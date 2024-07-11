import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  partally-redundant-left-shift-input-masking-variant-e
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.add %arg1, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %2, %3  : i32
    llvm.return %4 : i32
  }]

def t1_vec_splat_before := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.shl %arg0, %arg1  : vector<8xi32>
    %2 = llvm.lshr %1, %arg1  : vector<8xi32>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    llvm.call @use8xi32(%1) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    %4 = llvm.shl %2, %3  : vector<8xi32>
    llvm.return %4 : vector<8xi32>
  }]

def t1_vec_splat_undef_before := [llvmfunc|
  llvm.func @t1_vec_splat_undef(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<8xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<8xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<8xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<8xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<8xi32>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<8xi32>
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.insertelement %0, %12[%13 : i32] : vector<8xi32>
    %15 = llvm.mlir.constant(6 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : vector<8xi32>
    %17 = llvm.mlir.constant(7 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<8xi32>
    %19 = llvm.shl %arg0, %arg1  : vector<8xi32>
    %20 = llvm.lshr %19, %arg1  : vector<8xi32>
    %21 = llvm.add %arg1, %18  : vector<8xi32>
    llvm.call @use8xi32(%19) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%21) : (vector<8xi32>) -> ()
    %22 = llvm.shl %20, %21  : vector<8xi32>
    llvm.return %22 : vector<8xi32>
  }]

def t1_vec_nonsplat_before := [llvmfunc|
  llvm.func @t1_vec_nonsplat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<[-32, -31, -1, 0, 1, 31, 32, 33]> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.shl %arg0, %arg1  : vector<8xi32>
    %2 = llvm.lshr %1, %arg1  : vector<8xi32>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    llvm.call @use8xi32(%1) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    %4 = llvm.shl %2, %3  : vector<8xi32>
    llvm.return %4 : vector<8xi32>
  }]

def n3_extrause_before := [llvmfunc|
  llvm.func @n3_extrause(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.add %arg1, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %2, %3  : i32
    llvm.return %4 : i32
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.add %arg1, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.and %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t1_vec_splat_combined := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<2147483647> : vector<8xi32>) : vector<8xi32>
    %2 = llvm.shl %arg0, %arg1  : vector<8xi32>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    llvm.call @use8xi32(%2) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    %4 = llvm.shl %arg0, %3  : vector<8xi32>
    %5 = llvm.and %4, %1  : vector<8xi32>
    llvm.return %5 : vector<8xi32>
  }]

theorem inst_combine_t1_vec_splat   : t1_vec_splat_before  ⊑  t1_vec_splat_combined := by
  unfold t1_vec_splat_before t1_vec_splat_combined
  simp_alive_peephole
  sorry
def t1_vec_splat_undef_combined := [llvmfunc|
  llvm.func @t1_vec_splat_undef(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<8xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<8xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<8xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<8xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<8xi32>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<8xi32>
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.insertelement %0, %12[%13 : i32] : vector<8xi32>
    %15 = llvm.mlir.constant(6 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : vector<8xi32>
    %17 = llvm.mlir.constant(7 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<8xi32>
    %19 = llvm.mlir.constant(2147483647 : i32) : i32
    %20 = llvm.mlir.poison : i32
    %21 = llvm.mlir.undef : vector<8xi32>
    %22 = llvm.mlir.constant(0 : i32) : i32
    %23 = llvm.insertelement %19, %21[%22 : i32] : vector<8xi32>
    %24 = llvm.mlir.constant(1 : i32) : i32
    %25 = llvm.insertelement %19, %23[%24 : i32] : vector<8xi32>
    %26 = llvm.mlir.constant(2 : i32) : i32
    %27 = llvm.insertelement %19, %25[%26 : i32] : vector<8xi32>
    %28 = llvm.mlir.constant(3 : i32) : i32
    %29 = llvm.insertelement %19, %27[%28 : i32] : vector<8xi32>
    %30 = llvm.mlir.constant(4 : i32) : i32
    %31 = llvm.insertelement %19, %29[%30 : i32] : vector<8xi32>
    %32 = llvm.mlir.constant(5 : i32) : i32
    %33 = llvm.insertelement %19, %31[%32 : i32] : vector<8xi32>
    %34 = llvm.mlir.constant(6 : i32) : i32
    %35 = llvm.insertelement %20, %33[%34 : i32] : vector<8xi32>
    %36 = llvm.mlir.constant(7 : i32) : i32
    %37 = llvm.insertelement %19, %35[%36 : i32] : vector<8xi32>
    %38 = llvm.shl %arg0, %arg1  : vector<8xi32>
    %39 = llvm.add %arg1, %18  : vector<8xi32>
    llvm.call @use8xi32(%38) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%39) : (vector<8xi32>) -> ()
    %40 = llvm.shl %arg0, %39  : vector<8xi32>
    %41 = llvm.and %40, %37  : vector<8xi32>
    llvm.return %41 : vector<8xi32>
  }]

theorem inst_combine_t1_vec_splat_undef   : t1_vec_splat_undef_before  ⊑  t1_vec_splat_undef_combined := by
  unfold t1_vec_splat_undef_before t1_vec_splat_undef_combined
  simp_alive_peephole
  sorry
def t1_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t1_vec_nonsplat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<[-32, -31, -1, 0, 1, 31, 32, 33]> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(2147483647 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.undef : vector<8xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<8xi32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %4, %7[%8 : i32] : vector<8xi32>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %3, %9[%10 : i32] : vector<8xi32>
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.insertelement %2, %11[%12 : i32] : vector<8xi32>
    %14 = llvm.mlir.constant(4 : i32) : i32
    %15 = llvm.insertelement %2, %13[%14 : i32] : vector<8xi32>
    %16 = llvm.mlir.constant(5 : i32) : i32
    %17 = llvm.insertelement %2, %15[%16 : i32] : vector<8xi32>
    %18 = llvm.mlir.constant(6 : i32) : i32
    %19 = llvm.insertelement %2, %17[%18 : i32] : vector<8xi32>
    %20 = llvm.mlir.constant(7 : i32) : i32
    %21 = llvm.insertelement %1, %19[%20 : i32] : vector<8xi32>
    %22 = llvm.shl %arg0, %arg1  : vector<8xi32>
    %23 = llvm.add %arg1, %0  : vector<8xi32>
    llvm.call @use8xi32(%22) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%23) : (vector<8xi32>) -> ()
    %24 = llvm.shl %arg0, %23  : vector<8xi32>
    %25 = llvm.and %24, %21  : vector<8xi32>
    llvm.return %25 : vector<8xi32>
  }]

theorem inst_combine_t1_vec_nonsplat   : t1_vec_nonsplat_before  ⊑  t1_vec_nonsplat_combined := by
  unfold t1_vec_nonsplat_before t1_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def n3_extrause_combined := [llvmfunc|
  llvm.func @n3_extrause(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.add %arg1, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n3_extrause   : n3_extrause_before  ⊑  n3_extrause_combined := by
  unfold n3_extrause_before n3_extrause_combined
  simp_alive_peephole
  sorry
