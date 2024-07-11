import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  unfold-masked-merge-with-const-mask-vector
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def splat_before := [llvmfunc|
  llvm.func @splat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

def splat_undef_before := [llvmfunc|
  llvm.func @splat_undef(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.undef : i4
    %2 = llvm.mlir.undef : vector<3xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi4>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi4>
    %9 = llvm.xor %arg0, %arg1  : vector<3xi4>
    %10 = llvm.and %9, %8  : vector<3xi4>
    %11 = llvm.xor %10, %arg1  : vector<3xi4>
    llvm.return %11 : vector<3xi4>
  }]

def nonsplat_before := [llvmfunc|
  llvm.func @nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-2, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def in_constant_varx_mone_before := [llvmfunc|
  llvm.func @in_constant_varx_mone(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg0, %1  : vector<2xi4>
    %5 = llvm.and %4, %3  : vector<2xi4>
    %6 = llvm.xor %5, %1  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def in_constant_varx_14_before := [llvmfunc|
  llvm.func @in_constant_varx_14(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg0, %1  : vector<2xi4>
    %5 = llvm.and %4, %3  : vector<2xi4>
    %6 = llvm.xor %5, %1  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def in_constant_varx_14_nonsplat_before := [llvmfunc|
  llvm.func @in_constant_varx_14_nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-2, 7]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(1 : i4) : i4
    %4 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.xor %arg0, %2  : vector<2xi4>
    %6 = llvm.and %5, %4  : vector<2xi4>
    %7 = llvm.xor %6, %2  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

def in_constant_varx_14_undef_before := [llvmfunc|
  llvm.func @in_constant_varx_14_undef(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.undef : i4
    %2 = llvm.mlir.constant(-2 : i4) : i4
    %3 = llvm.mlir.undef : vector<3xi4>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi4>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi4>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi4>
    %10 = llvm.mlir.constant(1 : i4) : i4
    %11 = llvm.mlir.undef : vector<3xi4>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi4>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<3xi4>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %10, %15[%16 : i32] : vector<3xi4>
    %18 = llvm.xor %arg0, %9  : vector<3xi4>
    %19 = llvm.and %18, %17  : vector<3xi4>
    %20 = llvm.xor %19, %9  : vector<3xi4>
    llvm.return %20 : vector<3xi4>
  }]

def in_constant_mone_vary_before := [llvmfunc|
  llvm.func @in_constant_mone_vary(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg0, %1  : vector<2xi4>
    %5 = llvm.and %4, %3  : vector<2xi4>
    %6 = llvm.xor %5, %arg0  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def in_constant_14_vary_before := [llvmfunc|
  llvm.func @in_constant_14_vary(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg0, %1  : vector<2xi4>
    %5 = llvm.and %4, %3  : vector<2xi4>
    %6 = llvm.xor %5, %arg0  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def in_constant_14_vary_nonsplat_before := [llvmfunc|
  llvm.func @in_constant_14_vary_nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-2, 7]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(1 : i4) : i4
    %4 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.xor %arg0, %2  : vector<2xi4>
    %6 = llvm.and %5, %4  : vector<2xi4>
    %7 = llvm.xor %6, %arg0  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

def in_constant_14_vary_undef_before := [llvmfunc|
  llvm.func @in_constant_14_vary_undef(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.undef : i4
    %2 = llvm.mlir.constant(-2 : i4) : i4
    %3 = llvm.mlir.undef : vector<3xi4>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi4>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi4>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi4>
    %10 = llvm.mlir.constant(1 : i4) : i4
    %11 = llvm.mlir.undef : vector<3xi4>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi4>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<3xi4>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %10, %15[%16 : i32] : vector<3xi4>
    %18 = llvm.xor %arg0, %9  : vector<3xi4>
    %19 = llvm.and %18, %17  : vector<3xi4>
    %20 = llvm.xor %19, %arg0  : vector<3xi4>
    llvm.return %20 : vector<3xi4>
  }]

def c_1_0_0_before := [llvmfunc|
  llvm.func @c_1_0_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

def c_0_1_0_before := [llvmfunc|
  llvm.func @c_0_1_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg0  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

def c_0_0_1_before := [llvmfunc|
  llvm.func @c_0_0_1() -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.call @gen4() : () -> vector<2xi4>
    %3 = llvm.call @gen4() : () -> vector<2xi4>
    %4 = llvm.xor %2, %3  : vector<2xi4>
    %5 = llvm.and %4, %1  : vector<2xi4>
    %6 = llvm.xor %3, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def c_1_1_0_before := [llvmfunc|
  llvm.func @c_1_1_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg0  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

def c_1_0_1_before := [llvmfunc|
  llvm.func @c_1_0_1(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.call @gen4() : () -> vector<2xi4>
    %3 = llvm.xor %2, %arg0  : vector<2xi4>
    %4 = llvm.and %3, %1  : vector<2xi4>
    %5 = llvm.xor %2, %4  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def c_0_1_1_before := [llvmfunc|
  llvm.func @c_0_1_1(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.call @gen4() : () -> vector<2xi4>
    %3 = llvm.xor %2, %arg0  : vector<2xi4>
    %4 = llvm.and %3, %1  : vector<2xi4>
    %5 = llvm.xor %2, %4  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def c_1_1_1_before := [llvmfunc|
  llvm.func @c_1_1_1() -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.call @gen4() : () -> vector<2xi4>
    %3 = llvm.call @gen4() : () -> vector<2xi4>
    %4 = llvm.xor %3, %2  : vector<2xi4>
    %5 = llvm.and %4, %1  : vector<2xi4>
    %6 = llvm.xor %2, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def commutativity_constant_14_vary_before := [llvmfunc|
  llvm.func @commutativity_constant_14_vary(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg0, %1  : vector<2xi4>
    %5 = llvm.and %4, %3  : vector<2xi4>
    %6 = llvm.xor %arg0, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def n_oneuse_D_before := [llvmfunc|
  llvm.func @n_oneuse_D(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    llvm.call @use4(%2) : (vector<2xi4>) -> ()
    llvm.return %4 : vector<2xi4>
  }]

def n_oneuse_A_before := [llvmfunc|
  llvm.func @n_oneuse_A(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    llvm.call @use4(%3) : (vector<2xi4>) -> ()
    llvm.return %4 : vector<2xi4>
  }]

def n_oneuse_AD_before := [llvmfunc|
  llvm.func @n_oneuse_AD(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    llvm.call @use4(%2) : (vector<2xi4>) -> ()
    llvm.call @use4(%3) : (vector<2xi4>) -> ()
    llvm.return %4 : vector<2xi4>
  }]

def n_var_mask_before := [llvmfunc|
  llvm.func @n_var_mask(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %1 = llvm.and %0, %arg2  : vector<2xi4>
    %2 = llvm.xor %1, %arg1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

def n_differenty_before := [llvmfunc|
  llvm.func @n_differenty(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-2, 7]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(1 : i4) : i4
    %4 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.mlir.constant(dense<[7, -2]> : vector<2xi4>) : vector<2xi4>
    %6 = llvm.xor %arg0, %2  : vector<2xi4>
    %7 = llvm.and %6, %4  : vector<2xi4>
    %8 = llvm.xor %7, %5  : vector<2xi4>
    llvm.return %8 : vector<2xi4>
  }]

def splat_combined := [llvmfunc|
  llvm.func @splat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.and %arg0, %1  : vector<2xi4>
    %5 = llvm.and %arg1, %3  : vector<2xi4>
    %6 = llvm.or %4, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

theorem inst_combine_splat   : splat_before  ⊑  splat_combined := by
  unfold splat_before splat_combined
  simp_alive_peephole
  sorry
def splat_undef_combined := [llvmfunc|
  llvm.func @splat_undef(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-2, -1, -2]> : vector<3xi4>) : vector<3xi4>
    %3 = llvm.mlir.constant(1 : i4) : i4
    %4 = llvm.mlir.constant(0 : i4) : i4
    %5 = llvm.mlir.constant(dense<[1, 0, 1]> : vector<3xi4>) : vector<3xi4>
    %6 = llvm.and %arg0, %2  : vector<3xi4>
    %7 = llvm.and %arg1, %5  : vector<3xi4>
    %8 = llvm.or %6, %7  : vector<3xi4>
    llvm.return %8 : vector<3xi4>
  }]

theorem inst_combine_splat_undef   : splat_undef_before  ⊑  splat_undef_combined := by
  unfold splat_undef_before splat_undef_combined
  simp_alive_peephole
  sorry
def nonsplat_combined := [llvmfunc|
  llvm.func @nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-2, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(dense<[1, -2]> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.and %arg0, %2  : vector<2xi4>
    %5 = llvm.and %arg1, %3  : vector<2xi4>
    %6 = llvm.or %4, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

theorem inst_combine_nonsplat   : nonsplat_before  ⊑  nonsplat_combined := by
  unfold nonsplat_before nonsplat_combined
  simp_alive_peephole
  sorry
def in_constant_varx_mone_combined := [llvmfunc|
  llvm.func @in_constant_varx_mone(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.or %arg0, %1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_in_constant_varx_mone   : in_constant_varx_mone_before  ⊑  in_constant_varx_mone_combined := by
  unfold in_constant_varx_mone_before in_constant_varx_mone_combined
  simp_alive_peephole
  sorry
def in_constant_varx_14_combined := [llvmfunc|
  llvm.func @in_constant_varx_14(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.or %arg0, %1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_in_constant_varx_14   : in_constant_varx_14_before  ⊑  in_constant_varx_14_combined := by
  unfold in_constant_varx_14_before in_constant_varx_14_combined
  simp_alive_peephole
  sorry
def in_constant_varx_14_nonsplat_combined := [llvmfunc|
  llvm.func @in_constant_varx_14_nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(6 : i4) : i4
    %3 = llvm.mlir.constant(-2 : i4) : i4
    %4 = llvm.mlir.constant(dense<[-2, 6]> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.and %arg0, %1  : vector<2xi4>
    %6 = llvm.or %5, %4  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

theorem inst_combine_in_constant_varx_14_nonsplat   : in_constant_varx_14_nonsplat_before  ⊑  in_constant_varx_14_nonsplat_combined := by
  unfold in_constant_varx_14_nonsplat_before in_constant_varx_14_nonsplat_combined
  simp_alive_peephole
  sorry
def in_constant_varx_14_undef_combined := [llvmfunc|
  llvm.func @in_constant_varx_14_undef(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.mlir.constant(dense<[1, -1, 1]> : vector<3xi4>) : vector<3xi4>
    %3 = llvm.mlir.constant(6 : i4) : i4
    %4 = llvm.mlir.constant(0 : i4) : i4
    %5 = llvm.mlir.constant(-2 : i4) : i4
    %6 = llvm.mlir.constant(dense<[-2, 0, 6]> : vector<3xi4>) : vector<3xi4>
    %7 = llvm.and %arg0, %2  : vector<3xi4>
    %8 = llvm.or %7, %6  : vector<3xi4>
    llvm.return %8 : vector<3xi4>
  }]

theorem inst_combine_in_constant_varx_14_undef   : in_constant_varx_14_undef_before  ⊑  in_constant_varx_14_undef_combined := by
  unfold in_constant_varx_14_undef_before in_constant_varx_14_undef_combined
  simp_alive_peephole
  sorry
def in_constant_mone_vary_combined := [llvmfunc|
  llvm.func @in_constant_mone_vary(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.or %arg0, %1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_in_constant_mone_vary   : in_constant_mone_vary_before  ⊑  in_constant_mone_vary_combined := by
  unfold in_constant_mone_vary_before in_constant_mone_vary_combined
  simp_alive_peephole
  sorry
def in_constant_14_vary_combined := [llvmfunc|
  llvm.func @in_constant_14_vary(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.and %arg0, %1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_in_constant_14_vary   : in_constant_14_vary_before  ⊑  in_constant_14_vary_combined := by
  unfold in_constant_14_vary_before in_constant_14_vary_combined
  simp_alive_peephole
  sorry
def in_constant_14_vary_nonsplat_combined := [llvmfunc|
  llvm.func @in_constant_14_vary_nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(0 : i4) : i4
    %4 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.and %arg0, %1  : vector<2xi4>
    %6 = llvm.or %5, %4  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

theorem inst_combine_in_constant_14_vary_nonsplat   : in_constant_14_vary_nonsplat_before  ⊑  in_constant_14_vary_nonsplat_combined := by
  unfold in_constant_14_vary_nonsplat_before in_constant_14_vary_nonsplat_combined
  simp_alive_peephole
  sorry
def in_constant_14_vary_undef_combined := [llvmfunc|
  llvm.func @in_constant_14_vary_undef(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-2, 0, -2]> : vector<3xi4>) : vector<3xi4>
    %3 = llvm.mlir.constant(1 : i4) : i4
    %4 = llvm.mlir.undef : i4
    %5 = llvm.mlir.undef : vector<3xi4>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi4>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %4, %7[%8 : i32] : vector<3xi4>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %3, %9[%10 : i32] : vector<3xi4>
    %12 = llvm.and %arg0, %2  : vector<3xi4>
    %13 = llvm.or %12, %11  : vector<3xi4>
    llvm.return %13 : vector<3xi4>
  }]

theorem inst_combine_in_constant_14_vary_undef   : in_constant_14_vary_undef_before  ⊑  in_constant_14_vary_undef_combined := by
  unfold in_constant_14_vary_undef_before in_constant_14_vary_undef_combined
  simp_alive_peephole
  sorry
def c_1_0_0_combined := [llvmfunc|
  llvm.func @c_1_0_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.and %arg0, %1  : vector<2xi4>
    %5 = llvm.and %arg1, %3  : vector<2xi4>
    %6 = llvm.or %4, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

theorem inst_combine_c_1_0_0   : c_1_0_0_before  ⊑  c_1_0_0_combined := by
  unfold c_1_0_0_before c_1_0_0_combined
  simp_alive_peephole
  sorry
def c_0_1_0_combined := [llvmfunc|
  llvm.func @c_0_1_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.and %arg1, %1  : vector<2xi4>
    %5 = llvm.and %arg0, %3  : vector<2xi4>
    %6 = llvm.or %4, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

theorem inst_combine_c_0_1_0   : c_0_1_0_before  ⊑  c_0_1_0_combined := by
  unfold c_0_1_0_before c_0_1_0_combined
  simp_alive_peephole
  sorry
def c_0_0_1_combined := [llvmfunc|
  llvm.func @c_0_0_1() -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.call @gen4() : () -> vector<2xi4>
    %5 = llvm.call @gen4() : () -> vector<2xi4>
    %6 = llvm.and %4, %1  : vector<2xi4>
    %7 = llvm.and %5, %3  : vector<2xi4>
    %8 = llvm.or %6, %7  : vector<2xi4>
    llvm.return %8 : vector<2xi4>
  }]

theorem inst_combine_c_0_0_1   : c_0_0_1_before  ⊑  c_0_0_1_combined := by
  unfold c_0_0_1_before c_0_0_1_combined
  simp_alive_peephole
  sorry
def c_1_1_0_combined := [llvmfunc|
  llvm.func @c_1_1_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.and %arg1, %1  : vector<2xi4>
    %5 = llvm.and %arg0, %3  : vector<2xi4>
    %6 = llvm.or %4, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

theorem inst_combine_c_1_1_0   : c_1_1_0_before  ⊑  c_1_1_0_combined := by
  unfold c_1_1_0_before c_1_1_0_combined
  simp_alive_peephole
  sorry
def c_1_0_1_combined := [llvmfunc|
  llvm.func @c_1_0_1(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.call @gen4() : () -> vector<2xi4>
    %5 = llvm.and %arg0, %1  : vector<2xi4>
    %6 = llvm.and %4, %3  : vector<2xi4>
    %7 = llvm.or %5, %6  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

theorem inst_combine_c_1_0_1   : c_1_0_1_before  ⊑  c_1_0_1_combined := by
  unfold c_1_0_1_before c_1_0_1_combined
  simp_alive_peephole
  sorry
def c_0_1_1_combined := [llvmfunc|
  llvm.func @c_0_1_1(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.call @gen4() : () -> vector<2xi4>
    %5 = llvm.and %arg0, %1  : vector<2xi4>
    %6 = llvm.and %4, %3  : vector<2xi4>
    %7 = llvm.or %5, %6  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

theorem inst_combine_c_0_1_1   : c_0_1_1_before  ⊑  c_0_1_1_combined := by
  unfold c_0_1_1_before c_0_1_1_combined
  simp_alive_peephole
  sorry
def c_1_1_1_combined := [llvmfunc|
  llvm.func @c_1_1_1() -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.call @gen4() : () -> vector<2xi4>
    %5 = llvm.call @gen4() : () -> vector<2xi4>
    %6 = llvm.and %5, %1  : vector<2xi4>
    %7 = llvm.and %4, %3  : vector<2xi4>
    %8 = llvm.or %6, %7  : vector<2xi4>
    llvm.return %8 : vector<2xi4>
  }]

theorem inst_combine_c_1_1_1   : c_1_1_1_before  ⊑  c_1_1_1_combined := by
  unfold c_1_1_1_before c_1_1_1_combined
  simp_alive_peephole
  sorry
def commutativity_constant_14_vary_combined := [llvmfunc|
  llvm.func @commutativity_constant_14_vary(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.and %arg0, %1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_commutativity_constant_14_vary   : commutativity_constant_14_vary_before  ⊑  commutativity_constant_14_vary_combined := by
  unfold commutativity_constant_14_vary_before commutativity_constant_14_vary_combined
  simp_alive_peephole
  sorry
def n_oneuse_D_combined := [llvmfunc|
  llvm.func @n_oneuse_D(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    llvm.call @use4(%2) : (vector<2xi4>) -> ()
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_n_oneuse_D   : n_oneuse_D_before  ⊑  n_oneuse_D_combined := by
  unfold n_oneuse_D_before n_oneuse_D_combined
  simp_alive_peephole
  sorry
def n_oneuse_A_combined := [llvmfunc|
  llvm.func @n_oneuse_A(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    llvm.call @use4(%3) : (vector<2xi4>) -> ()
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_n_oneuse_A   : n_oneuse_A_before  ⊑  n_oneuse_A_combined := by
  unfold n_oneuse_A_before n_oneuse_A_combined
  simp_alive_peephole
  sorry
def n_oneuse_AD_combined := [llvmfunc|
  llvm.func @n_oneuse_AD(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.and %2, %1  : vector<2xi4>
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    llvm.call @use4(%2) : (vector<2xi4>) -> ()
    llvm.call @use4(%3) : (vector<2xi4>) -> ()
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_n_oneuse_AD   : n_oneuse_AD_before  ⊑  n_oneuse_AD_combined := by
  unfold n_oneuse_AD_before n_oneuse_AD_combined
  simp_alive_peephole
  sorry
def n_var_mask_combined := [llvmfunc|
  llvm.func @n_var_mask(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %1 = llvm.and %0, %arg2  : vector<2xi4>
    %2 = llvm.xor %1, %arg1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_n_var_mask   : n_var_mask_before  ⊑  n_var_mask_combined := by
  unfold n_var_mask_before n_var_mask_combined
  simp_alive_peephole
  sorry
def n_differenty_combined := [llvmfunc|
  llvm.func @n_differenty(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-2, 7]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(1 : i4) : i4
    %4 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.mlir.constant(dense<[7, -2]> : vector<2xi4>) : vector<2xi4>
    %6 = llvm.xor %arg0, %2  : vector<2xi4>
    %7 = llvm.and %6, %4  : vector<2xi4>
    %8 = llvm.xor %7, %5  : vector<2xi4>
    llvm.return %8 : vector<2xi4>
  }]

theorem inst_combine_n_differenty   : n_differenty_before  ⊑  n_differenty_combined := by
  unfold n_differenty_before n_differenty_combined
  simp_alive_peephole
  sorry
