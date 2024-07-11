import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(18 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.lshr %arg1, %1  : i32
    %4 = llvm.select %2, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(18 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.select %2, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }]

def t3_before := [llvmfunc|
  llvm.func @t3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %2 = llvm.select %1, %arg0, %0 : i1, f32
    %3 = llvm.fadd %2, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def ashr_exact_poison_constant_fold_before := [llvmfunc|
  llvm.func @ashr_exact_poison_constant_fold(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.select %arg0, %arg1, %0 : i1, i8
    %3 = llvm.ashr %2, %1  : i8
    llvm.return %3 : i8
  }]

def ashr_exact_before := [llvmfunc|
  llvm.func @ashr_exact(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.select %arg0, %arg1, %0 : i1, i8
    %3 = llvm.ashr %2, %1  : i8
    llvm.return %3 : i8
  }]

def shl_nsw_nuw_poison_constant_fold_before := [llvmfunc|
  llvm.func @shl_nsw_nuw_poison_constant_fold(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.select %arg0, %0, %arg1 : i1, i8
    %3 = llvm.shl %1, %2 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }]

def shl_nsw_nuw_before := [llvmfunc|
  llvm.func @shl_nsw_nuw(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.select %arg0, %0, %arg1 : i1, i8
    %3 = llvm.shl %1, %2 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }]

def add_nsw_poison_constant_fold_before := [llvmfunc|
  llvm.func @add_nsw_poison_constant_fold(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(65 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.select %arg0, %arg1, %0 : i1, i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

def add_nsw_before := [llvmfunc|
  llvm.func @add_nsw(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.select %arg0, %arg1, %0 : i1, i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(18 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.lshr %arg1, %1  : i32
    %4 = llvm.select %2, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(18 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.select %2, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def t3_combined := [llvmfunc|
  llvm.func @t3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %3 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.select %2, %3, %1 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_t3   : t3_before  ⊑  t3_combined := by
  unfold t3_before t3_combined
  simp_alive_peephole
  sorry
def ashr_exact_poison_constant_fold_combined := [llvmfunc|
  llvm.func @ashr_exact_poison_constant_fold(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.ashr %arg1, %0  : i8
    %3 = llvm.select %arg0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_ashr_exact_poison_constant_fold   : ashr_exact_poison_constant_fold_before  ⊑  ashr_exact_poison_constant_fold_combined := by
  unfold ashr_exact_poison_constant_fold_before ashr_exact_poison_constant_fold_combined
  simp_alive_peephole
  sorry
def ashr_exact_combined := [llvmfunc|
  llvm.func @ashr_exact(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.ashr %arg1, %0  : i8
    %3 = llvm.select %arg0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_ashr_exact   : ashr_exact_before  ⊑  ashr_exact_combined := by
  unfold ashr_exact_before ashr_exact_combined
  simp_alive_peephole
  sorry
def shl_nsw_nuw_poison_constant_fold_combined := [llvmfunc|
  llvm.func @shl_nsw_nuw_poison_constant_fold(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i8
    %3 = llvm.select %arg0, %1, %2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_shl_nsw_nuw_poison_constant_fold   : shl_nsw_nuw_poison_constant_fold_before  ⊑  shl_nsw_nuw_poison_constant_fold_combined := by
  unfold shl_nsw_nuw_poison_constant_fold_before shl_nsw_nuw_poison_constant_fold_combined
  simp_alive_peephole
  sorry
def shl_nsw_nuw_combined := [llvmfunc|
  llvm.func @shl_nsw_nuw(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(56 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i8
    %3 = llvm.select %arg0, %1, %2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_shl_nsw_nuw   : shl_nsw_nuw_before  ⊑  shl_nsw_nuw_combined := by
  unfold shl_nsw_nuw_before shl_nsw_nuw_combined
  simp_alive_peephole
  sorry
def add_nsw_poison_constant_fold_combined := [llvmfunc|
  llvm.func @add_nsw_poison_constant_fold(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.add %arg1, %0 overflow<nsw>  : i8
    %3 = llvm.select %arg0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_add_nsw_poison_constant_fold   : add_nsw_poison_constant_fold_before  ⊑  add_nsw_poison_constant_fold_combined := by
  unfold add_nsw_poison_constant_fold_before add_nsw_poison_constant_fold_combined
  simp_alive_peephole
  sorry
def add_nsw_combined := [llvmfunc|
  llvm.func @add_nsw(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(71 : i8) : i8
    %2 = llvm.add %arg1, %0 overflow<nsw>  : i8
    %3 = llvm.select %arg0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_add_nsw   : add_nsw_before  ⊑  add_nsw_combined := by
  unfold add_nsw_before add_nsw_combined
  simp_alive_peephole
  sorry
