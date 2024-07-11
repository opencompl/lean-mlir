import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  invert-variable-mask-in-masked-merge-vector
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def vector_before := [llvmfunc|
  llvm.func @vector(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def vector_poison_before := [llvmfunc|
  llvm.func @vector_poison(%arg0: vector<3xi4>, %arg1: vector<3xi4>, %arg2: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.poison : i4
    %2 = llvm.mlir.undef : vector<3xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi4>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi4>
    %9 = llvm.xor %arg2, %8  : vector<3xi4>
    %10 = llvm.xor %arg0, %arg1  : vector<3xi4>
    %11 = llvm.and %10, %9  : vector<3xi4>
    %12 = llvm.xor %11, %arg1  : vector<3xi4>
    llvm.return %12 : vector<3xi4>
  }]

def in_constant_varx_mone_invmask_before := [llvmfunc|
  llvm.func @in_constant_varx_mone_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %1  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def in_constant_varx_6_invmask_before := [llvmfunc|
  llvm.func @in_constant_varx_6_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(6 : i4) : i4
    %3 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg1, %1  : vector<2xi4>
    %5 = llvm.xor %arg0, %3  : vector<2xi4>
    %6 = llvm.and %5, %4  : vector<2xi4>
    %7 = llvm.xor %6, %3  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

def in_constant_varx_6_invmask_nonsplat_before := [llvmfunc|
  llvm.func @in_constant_varx_6_invmask_nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(7 : i4) : i4
    %3 = llvm.mlir.constant(6 : i4) : i4
    %4 = llvm.mlir.constant(dense<[6, 7]> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.xor %arg1, %1  : vector<2xi4>
    %6 = llvm.xor %arg0, %4  : vector<2xi4>
    %7 = llvm.and %6, %5  : vector<2xi4>
    %8 = llvm.xor %7, %4  : vector<2xi4>
    llvm.return %8 : vector<2xi4>
  }]

def in_constant_varx_6_invmask_poison_before := [llvmfunc|
  llvm.func @in_constant_varx_6_invmask_poison(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.poison : i4
    %2 = llvm.mlir.undef : vector<3xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi4>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi4>
    %9 = llvm.mlir.constant(7 : i4) : i4
    %10 = llvm.mlir.constant(6 : i4) : i4
    %11 = llvm.mlir.undef : vector<3xi4>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi4>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<3xi4>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %9, %15[%16 : i32] : vector<3xi4>
    %18 = llvm.xor %arg1, %8  : vector<3xi4>
    %19 = llvm.xor %arg0, %17  : vector<3xi4>
    %20 = llvm.and %19, %18  : vector<3xi4>
    %21 = llvm.xor %20, %17  : vector<3xi4>
    llvm.return %21 : vector<3xi4>
  }]

def in_constant_mone_vary_invmask_before := [llvmfunc|
  llvm.func @in_constant_mone_vary_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %1  : vector<2xi4>
    %3 = llvm.xor %1, %arg0  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg0  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def in_constant_6_vary_invmask_before := [llvmfunc|
  llvm.func @in_constant_6_vary_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(6 : i4) : i4
    %3 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg1, %1  : vector<2xi4>
    %5 = llvm.xor %arg0, %3  : vector<2xi4>
    %6 = llvm.and %5, %4  : vector<2xi4>
    %7 = llvm.xor %6, %arg0  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

def in_constant_6_vary_invmask_nonsplat_before := [llvmfunc|
  llvm.func @in_constant_6_vary_invmask_nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(7 : i4) : i4
    %3 = llvm.mlir.constant(6 : i4) : i4
    %4 = llvm.mlir.constant(dense<[6, 7]> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.xor %arg1, %1  : vector<2xi4>
    %6 = llvm.xor %arg0, %4  : vector<2xi4>
    %7 = llvm.and %6, %5  : vector<2xi4>
    %8 = llvm.xor %7, %arg0  : vector<2xi4>
    llvm.return %8 : vector<2xi4>
  }]

def in_constant_6_vary_invmask_poison_before := [llvmfunc|
  llvm.func @in_constant_6_vary_invmask_poison(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.poison : i4
    %2 = llvm.mlir.undef : vector<3xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi4>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi4>
    %9 = llvm.mlir.constant(6 : i4) : i4
    %10 = llvm.mlir.undef : vector<3xi4>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi4>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi4>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi4>
    %17 = llvm.xor %arg1, %8  : vector<3xi4>
    %18 = llvm.xor %arg0, %16  : vector<3xi4>
    %19 = llvm.and %18, %17  : vector<3xi4>
    %20 = llvm.xor %19, %arg0  : vector<3xi4>
    llvm.return %20 : vector<3xi4>
  }]

def c_1_0_0_before := [llvmfunc|
  llvm.func @c_1_0_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def c_0_1_0_before := [llvmfunc|
  llvm.func @c_0_1_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg0  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def c_0_0_1_before := [llvmfunc|
  llvm.func @c_0_0_1(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %1  : vector<2xi4>
    %3 = llvm.call @gen4() : () -> vector<2xi4>
    %4 = llvm.call @gen4() : () -> vector<2xi4>
    %5 = llvm.xor %3, %4  : vector<2xi4>
    %6 = llvm.and %5, %2  : vector<2xi4>
    %7 = llvm.xor %4, %6  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

def c_1_1_0_before := [llvmfunc|
  llvm.func @c_1_1_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg0  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def c_1_0_1_before := [llvmfunc|
  llvm.func @c_1_0_1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %1  : vector<2xi4>
    %3 = llvm.call @gen4() : () -> vector<2xi4>
    %4 = llvm.xor %3, %arg0  : vector<2xi4>
    %5 = llvm.and %4, %2  : vector<2xi4>
    %6 = llvm.xor %3, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def c_0_1_1_before := [llvmfunc|
  llvm.func @c_0_1_1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %1  : vector<2xi4>
    %3 = llvm.call @gen4() : () -> vector<2xi4>
    %4 = llvm.xor %3, %arg0  : vector<2xi4>
    %5 = llvm.and %4, %2  : vector<2xi4>
    %6 = llvm.xor %3, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def c_1_1_1_before := [llvmfunc|
  llvm.func @c_1_1_1(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %1  : vector<2xi4>
    %3 = llvm.call @gen4() : () -> vector<2xi4>
    %4 = llvm.call @gen4() : () -> vector<2xi4>
    %5 = llvm.xor %4, %3  : vector<2xi4>
    %6 = llvm.and %5, %2  : vector<2xi4>
    %7 = llvm.xor %3, %6  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

def commutativity_constant_varx_6_invmask_before := [llvmfunc|
  llvm.func @commutativity_constant_varx_6_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(6 : i4) : i4
    %3 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg1, %1  : vector<2xi4>
    %5 = llvm.xor %arg0, %3  : vector<2xi4>
    %6 = llvm.and %4, %5  : vector<2xi4>
    %7 = llvm.xor %6, %3  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

def commutativity_constant_6_vary_invmask_before := [llvmfunc|
  llvm.func @commutativity_constant_6_vary_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(6 : i4) : i4
    %3 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg1, %1  : vector<2xi4>
    %5 = llvm.xor %arg0, %3  : vector<2xi4>
    %6 = llvm.and %4, %5  : vector<2xi4>
    %7 = llvm.xor %6, %arg0  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

def n_oneuse_D_is_ok_before := [llvmfunc|
  llvm.func @n_oneuse_D_is_ok(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.call @use4(%3) : (vector<2xi4>) -> ()
    llvm.return %5 : vector<2xi4>
  }]

def n_oneuse_A_before := [llvmfunc|
  llvm.func @n_oneuse_A(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.call @use4(%4) : (vector<2xi4>) -> ()
    llvm.return %5 : vector<2xi4>
  }]

def n_oneuse_AD_before := [llvmfunc|
  llvm.func @n_oneuse_AD(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.call @use4(%3) : (vector<2xi4>) -> ()
    llvm.call @use4(%4) : (vector<2xi4>) -> ()
    llvm.return %5 : vector<2xi4>
  }]

def n_third_var_before := [llvmfunc|
  llvm.func @n_third_var(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg3, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg2  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def n_third_var_const_before := [llvmfunc|
  llvm.func @n_third_var_const(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(7 : i4) : i4
    %3 = llvm.mlir.constant(6 : i4) : i4
    %4 = llvm.mlir.constant(dense<[6, 7]> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.mlir.constant(dense<[7, 6]> : vector<2xi4>) : vector<2xi4>
    %6 = llvm.xor %arg2, %1  : vector<2xi4>
    %7 = llvm.xor %arg0, %4  : vector<2xi4>
    %8 = llvm.and %7, %6  : vector<2xi4>
    %9 = llvm.xor %8, %5  : vector<2xi4>
    llvm.return %9 : vector<2xi4>
  }]

def n_badxor_splat_before := [llvmfunc|
  llvm.func @n_badxor_splat(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def n_badxor_before := [llvmfunc|
  llvm.func @n_badxor(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.xor %arg2, %2  : vector<2xi4>
    %4 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %5 = llvm.and %4, %3  : vector<2xi4>
    %6 = llvm.xor %5, %arg1  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def vector_combined := [llvmfunc|
  llvm.func @vector(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %1 = llvm.and %0, %arg2  : vector<2xi4>
    %2 = llvm.xor %1, %arg0  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_vector   : vector_before  ⊑  vector_combined := by
  unfold vector_before vector_combined
  simp_alive_peephole
  sorry
def vector_poison_combined := [llvmfunc|
  llvm.func @vector_poison(%arg0: vector<3xi4>, %arg1: vector<3xi4>, %arg2: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.xor %arg0, %arg1  : vector<3xi4>
    %1 = llvm.and %0, %arg2  : vector<3xi4>
    %2 = llvm.xor %1, %arg0  : vector<3xi4>
    llvm.return %2 : vector<3xi4>
  }]

theorem inst_combine_vector_poison   : vector_poison_before  ⊑  vector_poison_combined := by
  unfold vector_poison_before vector_poison_combined
  simp_alive_peephole
  sorry
def in_constant_varx_mone_invmask_combined := [llvmfunc|
  llvm.func @in_constant_varx_mone_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi4>
    llvm.return %0 : vector<2xi4>
  }]

theorem inst_combine_in_constant_varx_mone_invmask   : in_constant_varx_mone_invmask_before  ⊑  in_constant_varx_mone_invmask_combined := by
  unfold in_constant_varx_mone_invmask_before in_constant_varx_mone_invmask_combined
  simp_alive_peephole
  sorry
def in_constant_varx_6_invmask_combined := [llvmfunc|
  llvm.func @in_constant_varx_6_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %1  : vector<2xi4>
    %3 = llvm.and %2, %arg1  : vector<2xi4>
    %4 = llvm.xor %3, %arg0  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_in_constant_varx_6_invmask   : in_constant_varx_6_invmask_before  ⊑  in_constant_varx_6_invmask_combined := by
  unfold in_constant_varx_6_invmask_before in_constant_varx_6_invmask_combined
  simp_alive_peephole
  sorry
def in_constant_varx_6_invmask_nonsplat_combined := [llvmfunc|
  llvm.func @in_constant_varx_6_invmask_nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[6, 7]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.xor %arg0, %2  : vector<2xi4>
    %4 = llvm.and %3, %arg1  : vector<2xi4>
    %5 = llvm.xor %4, %arg0  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

theorem inst_combine_in_constant_varx_6_invmask_nonsplat   : in_constant_varx_6_invmask_nonsplat_before  ⊑  in_constant_varx_6_invmask_nonsplat_combined := by
  unfold in_constant_varx_6_invmask_nonsplat_before in_constant_varx_6_invmask_nonsplat_combined
  simp_alive_peephole
  sorry
def in_constant_varx_6_invmask_poison_combined := [llvmfunc|
  llvm.func @in_constant_varx_6_invmask_poison(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.poison : i4
    %2 = llvm.mlir.constant(6 : i4) : i4
    %3 = llvm.mlir.undef : vector<3xi4>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi4>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi4>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi4>
    %10 = llvm.xor %arg0, %9  : vector<3xi4>
    %11 = llvm.and %10, %arg1  : vector<3xi4>
    %12 = llvm.xor %11, %arg0  : vector<3xi4>
    llvm.return %12 : vector<3xi4>
  }]

theorem inst_combine_in_constant_varx_6_invmask_poison   : in_constant_varx_6_invmask_poison_before  ⊑  in_constant_varx_6_invmask_poison_combined := by
  unfold in_constant_varx_6_invmask_poison_before in_constant_varx_6_invmask_poison_combined
  simp_alive_peephole
  sorry
def in_constant_mone_vary_invmask_combined := [llvmfunc|
  llvm.func @in_constant_mone_vary_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg1, %1  : vector<2xi4>
    %3 = llvm.or %2, %arg0  : vector<2xi4>
    llvm.return %3 : vector<2xi4>
  }]

theorem inst_combine_in_constant_mone_vary_invmask   : in_constant_mone_vary_invmask_before  ⊑  in_constant_mone_vary_invmask_combined := by
  unfold in_constant_mone_vary_invmask_before in_constant_mone_vary_invmask_combined
  simp_alive_peephole
  sorry
def in_constant_6_vary_invmask_combined := [llvmfunc|
  llvm.func @in_constant_6_vary_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %1  : vector<2xi4>
    %3 = llvm.and %2, %arg1  : vector<2xi4>
    %4 = llvm.xor %3, %1  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_in_constant_6_vary_invmask   : in_constant_6_vary_invmask_before  ⊑  in_constant_6_vary_invmask_combined := by
  unfold in_constant_6_vary_invmask_before in_constant_6_vary_invmask_combined
  simp_alive_peephole
  sorry
def in_constant_6_vary_invmask_nonsplat_combined := [llvmfunc|
  llvm.func @in_constant_6_vary_invmask_nonsplat(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(7 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[6, 7]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.xor %arg0, %2  : vector<2xi4>
    %4 = llvm.and %3, %arg1  : vector<2xi4>
    %5 = llvm.xor %4, %2  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

theorem inst_combine_in_constant_6_vary_invmask_nonsplat   : in_constant_6_vary_invmask_nonsplat_before  ⊑  in_constant_6_vary_invmask_nonsplat_combined := by
  unfold in_constant_6_vary_invmask_nonsplat_before in_constant_6_vary_invmask_nonsplat_combined
  simp_alive_peephole
  sorry
def in_constant_6_vary_invmask_poison_combined := [llvmfunc|
  llvm.func @in_constant_6_vary_invmask_poison(%arg0: vector<3xi4>, %arg1: vector<3xi4>) -> vector<3xi4> {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.mlir.poison : i4
    %2 = llvm.mlir.undef : vector<3xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi4>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi4>
    %9 = llvm.xor %arg0, %8  : vector<3xi4>
    %10 = llvm.and %9, %arg1  : vector<3xi4>
    %11 = llvm.xor %10, %8  : vector<3xi4>
    llvm.return %11 : vector<3xi4>
  }]

theorem inst_combine_in_constant_6_vary_invmask_poison   : in_constant_6_vary_invmask_poison_before  ⊑  in_constant_6_vary_invmask_poison_combined := by
  unfold in_constant_6_vary_invmask_poison_before in_constant_6_vary_invmask_poison_combined
  simp_alive_peephole
  sorry
def c_1_0_0_combined := [llvmfunc|
  llvm.func @c_1_0_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %1 = llvm.and %0, %arg2  : vector<2xi4>
    %2 = llvm.xor %1, %arg0  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_c_1_0_0   : c_1_0_0_before  ⊑  c_1_0_0_combined := by
  unfold c_1_0_0_before c_1_0_0_combined
  simp_alive_peephole
  sorry
def c_0_1_0_combined := [llvmfunc|
  llvm.func @c_0_1_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %1 = llvm.and %0, %arg2  : vector<2xi4>
    %2 = llvm.xor %1, %arg1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_c_0_1_0   : c_0_1_0_before  ⊑  c_0_1_0_combined := by
  unfold c_0_1_0_before c_0_1_0_combined
  simp_alive_peephole
  sorry
def c_0_0_1_combined := [llvmfunc|
  llvm.func @c_0_0_1(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.call @gen4() : () -> vector<2xi4>
    %1 = llvm.call @gen4() : () -> vector<2xi4>
    %2 = llvm.xor %0, %1  : vector<2xi4>
    %3 = llvm.and %2, %arg0  : vector<2xi4>
    %4 = llvm.xor %3, %0  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_c_0_0_1   : c_0_0_1_before  ⊑  c_0_0_1_combined := by
  unfold c_0_0_1_before c_0_0_1_combined
  simp_alive_peephole
  sorry
def c_1_1_0_combined := [llvmfunc|
  llvm.func @c_1_1_0(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %1 = llvm.and %0, %arg2  : vector<2xi4>
    %2 = llvm.xor %1, %arg1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_c_1_1_0   : c_1_1_0_before  ⊑  c_1_1_0_combined := by
  unfold c_1_1_0_before c_1_1_0_combined
  simp_alive_peephole
  sorry
def c_1_0_1_combined := [llvmfunc|
  llvm.func @c_1_0_1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.call @gen4() : () -> vector<2xi4>
    %1 = llvm.xor %0, %arg0  : vector<2xi4>
    %2 = llvm.and %1, %arg1  : vector<2xi4>
    %3 = llvm.xor %2, %arg0  : vector<2xi4>
    llvm.return %3 : vector<2xi4>
  }]

theorem inst_combine_c_1_0_1   : c_1_0_1_before  ⊑  c_1_0_1_combined := by
  unfold c_1_0_1_before c_1_0_1_combined
  simp_alive_peephole
  sorry
def c_0_1_1_combined := [llvmfunc|
  llvm.func @c_0_1_1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.call @gen4() : () -> vector<2xi4>
    %1 = llvm.xor %0, %arg0  : vector<2xi4>
    %2 = llvm.and %1, %arg1  : vector<2xi4>
    %3 = llvm.xor %2, %arg0  : vector<2xi4>
    llvm.return %3 : vector<2xi4>
  }]

theorem inst_combine_c_0_1_1   : c_0_1_1_before  ⊑  c_0_1_1_combined := by
  unfold c_0_1_1_before c_0_1_1_combined
  simp_alive_peephole
  sorry
def c_1_1_1_combined := [llvmfunc|
  llvm.func @c_1_1_1(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.call @gen4() : () -> vector<2xi4>
    %1 = llvm.call @gen4() : () -> vector<2xi4>
    %2 = llvm.xor %1, %0  : vector<2xi4>
    %3 = llvm.and %2, %arg0  : vector<2xi4>
    %4 = llvm.xor %3, %1  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_c_1_1_1   : c_1_1_1_before  ⊑  c_1_1_1_combined := by
  unfold c_1_1_1_before c_1_1_1_combined
  simp_alive_peephole
  sorry
def commutativity_constant_varx_6_invmask_combined := [llvmfunc|
  llvm.func @commutativity_constant_varx_6_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %1  : vector<2xi4>
    %3 = llvm.and %2, %arg1  : vector<2xi4>
    %4 = llvm.xor %3, %arg0  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_commutativity_constant_varx_6_invmask   : commutativity_constant_varx_6_invmask_before  ⊑  commutativity_constant_varx_6_invmask_combined := by
  unfold commutativity_constant_varx_6_invmask_before commutativity_constant_varx_6_invmask_combined
  simp_alive_peephole
  sorry
def commutativity_constant_6_vary_invmask_combined := [llvmfunc|
  llvm.func @commutativity_constant_6_vary_invmask(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.mlir.constant(dense<6> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %1  : vector<2xi4>
    %3 = llvm.and %2, %arg1  : vector<2xi4>
    %4 = llvm.xor %3, %1  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_commutativity_constant_6_vary_invmask   : commutativity_constant_6_vary_invmask_before  ⊑  commutativity_constant_6_vary_invmask_combined := by
  unfold commutativity_constant_6_vary_invmask_before commutativity_constant_6_vary_invmask_combined
  simp_alive_peephole
  sorry
def n_oneuse_D_is_ok_combined := [llvmfunc|
  llvm.func @n_oneuse_D_is_ok(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %1 = llvm.and %0, %arg2  : vector<2xi4>
    %2 = llvm.xor %1, %arg0  : vector<2xi4>
    llvm.call @use4(%0) : (vector<2xi4>) -> ()
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_n_oneuse_D_is_ok   : n_oneuse_D_is_ok_before  ⊑  n_oneuse_D_is_ok_combined := by
  unfold n_oneuse_D_is_ok_before n_oneuse_D_is_ok_combined
  simp_alive_peephole
  sorry
def n_oneuse_A_combined := [llvmfunc|
  llvm.func @n_oneuse_A(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.call @use4(%4) : (vector<2xi4>) -> ()
    llvm.return %5 : vector<2xi4>
  }]

theorem inst_combine_n_oneuse_A   : n_oneuse_A_before  ⊑  n_oneuse_A_combined := by
  unfold n_oneuse_A_before n_oneuse_A_combined
  simp_alive_peephole
  sorry
def n_oneuse_AD_combined := [llvmfunc|
  llvm.func @n_oneuse_AD(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.call @use4(%3) : (vector<2xi4>) -> ()
    llvm.call @use4(%4) : (vector<2xi4>) -> ()
    llvm.return %5 : vector<2xi4>
  }]

theorem inst_combine_n_oneuse_AD   : n_oneuse_AD_before  ⊑  n_oneuse_AD_combined := by
  unfold n_oneuse_AD_before n_oneuse_AD_combined
  simp_alive_peephole
  sorry
def n_third_var_combined := [llvmfunc|
  llvm.func @n_third_var(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg3, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg2  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

theorem inst_combine_n_third_var   : n_third_var_before  ⊑  n_third_var_combined := by
  unfold n_third_var_before n_third_var_combined
  simp_alive_peephole
  sorry
def n_third_var_const_combined := [llvmfunc|
  llvm.func @n_third_var_const(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(7 : i4) : i4
    %3 = llvm.mlir.constant(6 : i4) : i4
    %4 = llvm.mlir.constant(dense<[6, 7]> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.mlir.constant(dense<[7, 6]> : vector<2xi4>) : vector<2xi4>
    %6 = llvm.xor %arg2, %1  : vector<2xi4>
    %7 = llvm.xor %arg0, %4  : vector<2xi4>
    %8 = llvm.and %7, %6  : vector<2xi4>
    %9 = llvm.xor %8, %5  : vector<2xi4>
    llvm.return %9 : vector<2xi4>
  }]

theorem inst_combine_n_third_var_const   : n_third_var_const_before  ⊑  n_third_var_const_combined := by
  unfold n_third_var_const_before n_third_var_const_combined
  simp_alive_peephole
  sorry
def n_badxor_splat_combined := [llvmfunc|
  llvm.func @n_badxor_splat(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg2, %1  : vector<2xi4>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %4 = llvm.and %3, %2  : vector<2xi4>
    %5 = llvm.xor %4, %arg1  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

theorem inst_combine_n_badxor_splat   : n_badxor_splat_before  ⊑  n_badxor_splat_combined := by
  unfold n_badxor_splat_before n_badxor_splat_combined
  simp_alive_peephole
  sorry
def n_badxor_combined := [llvmfunc|
  llvm.func @n_badxor(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.xor %arg2, %2  : vector<2xi4>
    %4 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %5 = llvm.and %4, %3  : vector<2xi4>
    %6 = llvm.xor %5, %arg1  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

theorem inst_combine_n_badxor   : n_badxor_before  ⊑  n_badxor_combined := by
  unfold n_badxor_before n_badxor_combined
  simp_alive_peephole
  sorry
