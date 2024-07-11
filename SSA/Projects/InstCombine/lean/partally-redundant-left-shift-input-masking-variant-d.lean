import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  partally-redundant-left-shift-input-masking-variant-d
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %arg1, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.shl %3, %4  : i32
    llvm.return %5 : i32
  }]

def t2_vec_splat_before := [llvmfunc|
  llvm.func @t2_vec_splat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.shl %0, %arg1  : vector<8xi32>
    %2 = llvm.lshr %1, %arg1  : vector<8xi32>
    %3 = llvm.and %2, %arg0  : vector<8xi32>
    %4 = llvm.add %arg1, %0  : vector<8xi32>
    llvm.call @use8xi32(%1) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%2) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%4) : (vector<8xi32>) -> ()
    %5 = llvm.shl %3, %4  : vector<8xi32>
    llvm.return %5 : vector<8xi32>
  }]

def t2_vec_splat_poison_before := [llvmfunc|
  llvm.func @t2_vec_splat_poison(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
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
    %19 = llvm.shl %18, %arg1  : vector<8xi32>
    %20 = llvm.lshr %19, %arg1  : vector<8xi32>
    %21 = llvm.and %20, %arg0  : vector<8xi32>
    %22 = llvm.add %arg1, %18  : vector<8xi32>
    llvm.call @use8xi32(%19) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%20) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%22) : (vector<8xi32>) -> ()
    %23 = llvm.shl %21, %22  : vector<8xi32>
    llvm.return %23 : vector<8xi32>
  }]

def t2_vec_nonsplat_before := [llvmfunc|
  llvm.func @t2_vec_nonsplat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<[-32, -31, -1, 0, 1, 31, 32, 33]> : vector<8xi32>) : vector<8xi32>
    %2 = llvm.shl %0, %arg1  : vector<8xi32>
    %3 = llvm.lshr %2, %arg1  : vector<8xi32>
    %4 = llvm.and %3, %arg0  : vector<8xi32>
    %5 = llvm.add %arg1, %1  : vector<8xi32>
    llvm.call @use8xi32(%2) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%5) : (vector<8xi32>) -> ()
    %6 = llvm.shl %4, %5  : vector<8xi32>
    llvm.return %6 : vector<8xi32>
  }]

def n3_extrause_before := [llvmfunc|
  llvm.func @n3_extrause(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %arg1, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.shl %3, %4  : i32
    llvm.return %5 : i32
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    %4 = llvm.add %arg1, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.shl %arg0, %4  : i32
    %6 = llvm.and %5, %1  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t2_vec_splat_combined := [llvmfunc|
  llvm.func @t2_vec_splat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<2147483647> : vector<8xi32>) : vector<8xi32>
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : vector<8xi32>
    %3 = llvm.lshr %2, %arg1  : vector<8xi32>
    %4 = llvm.add %arg1, %0  : vector<8xi32>
    llvm.call @use8xi32(%2) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%4) : (vector<8xi32>) -> ()
    %5 = llvm.shl %arg0, %4  : vector<8xi32>
    %6 = llvm.and %5, %1  : vector<8xi32>
    llvm.return %6 : vector<8xi32>
  }]

theorem inst_combine_t2_vec_splat   : t2_vec_splat_before  ⊑  t2_vec_splat_combined := by
  unfold t2_vec_splat_before t2_vec_splat_combined
  simp_alive_peephole
  sorry
def t2_vec_splat_poison_combined := [llvmfunc|
  llvm.func @t2_vec_splat_poison(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
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
    %20 = llvm.mlir.undef : vector<8xi32>
    %21 = llvm.mlir.constant(0 : i32) : i32
    %22 = llvm.insertelement %19, %20[%21 : i32] : vector<8xi32>
    %23 = llvm.mlir.constant(1 : i32) : i32
    %24 = llvm.insertelement %19, %22[%23 : i32] : vector<8xi32>
    %25 = llvm.mlir.constant(2 : i32) : i32
    %26 = llvm.insertelement %19, %24[%25 : i32] : vector<8xi32>
    %27 = llvm.mlir.constant(3 : i32) : i32
    %28 = llvm.insertelement %19, %26[%27 : i32] : vector<8xi32>
    %29 = llvm.mlir.constant(4 : i32) : i32
    %30 = llvm.insertelement %19, %28[%29 : i32] : vector<8xi32>
    %31 = llvm.mlir.constant(5 : i32) : i32
    %32 = llvm.insertelement %19, %30[%31 : i32] : vector<8xi32>
    %33 = llvm.mlir.constant(6 : i32) : i32
    %34 = llvm.insertelement %1, %32[%33 : i32] : vector<8xi32>
    %35 = llvm.mlir.constant(7 : i32) : i32
    %36 = llvm.insertelement %19, %34[%35 : i32] : vector<8xi32>
    %37 = llvm.shl %18, %arg1 overflow<nsw>  : vector<8xi32>
    %38 = llvm.lshr %37, %arg1  : vector<8xi32>
    %39 = llvm.add %arg1, %18  : vector<8xi32>
    llvm.call @use8xi32(%37) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%38) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%39) : (vector<8xi32>) -> ()
    %40 = llvm.shl %arg0, %39  : vector<8xi32>
    %41 = llvm.and %40, %36  : vector<8xi32>
    llvm.return %41 : vector<8xi32>
  }]

theorem inst_combine_t2_vec_splat_poison   : t2_vec_splat_poison_before  ⊑  t2_vec_splat_poison_combined := by
  unfold t2_vec_splat_poison_before t2_vec_splat_poison_combined
  simp_alive_peephole
  sorry
def t2_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t2_vec_nonsplat(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<[-32, -31, -1, 0, 1, 31, 32, 33]> : vector<8xi32>) : vector<8xi32>
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.constant(2147483647 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.undef : vector<8xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<8xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %5, %8[%9 : i32] : vector<8xi32>
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.insertelement %4, %10[%11 : i32] : vector<8xi32>
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.insertelement %3, %12[%13 : i32] : vector<8xi32>
    %15 = llvm.mlir.constant(4 : i32) : i32
    %16 = llvm.insertelement %3, %14[%15 : i32] : vector<8xi32>
    %17 = llvm.mlir.constant(5 : i32) : i32
    %18 = llvm.insertelement %3, %16[%17 : i32] : vector<8xi32>
    %19 = llvm.mlir.constant(6 : i32) : i32
    %20 = llvm.insertelement %3, %18[%19 : i32] : vector<8xi32>
    %21 = llvm.mlir.constant(7 : i32) : i32
    %22 = llvm.insertelement %2, %20[%21 : i32] : vector<8xi32>
    %23 = llvm.shl %0, %arg1 overflow<nsw>  : vector<8xi32>
    %24 = llvm.lshr %23, %arg1  : vector<8xi32>
    %25 = llvm.add %arg1, %1  : vector<8xi32>
    llvm.call @use8xi32(%23) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%24) : (vector<8xi32>) -> ()
    llvm.call @use8xi32(%25) : (vector<8xi32>) -> ()
    %26 = llvm.shl %arg0, %25  : vector<8xi32>
    %27 = llvm.and %26, %22  : vector<8xi32>
    llvm.return %27 : vector<8xi32>
  }]

theorem inst_combine_t2_vec_nonsplat   : t2_vec_nonsplat_before  ⊑  t2_vec_nonsplat_combined := by
  unfold t2_vec_nonsplat_before t2_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def n3_extrause_combined := [llvmfunc|
  llvm.func @n3_extrause(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %arg1, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.shl %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n3_extrause   : n3_extrause_before  ⊑  n3_extrause_combined := by
  unfold n3_extrause_before n3_extrause_combined
  simp_alive_peephole
  sorry
