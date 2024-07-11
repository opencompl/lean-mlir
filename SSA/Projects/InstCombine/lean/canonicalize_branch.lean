import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize_branch
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def eq_before := [llvmfunc|
  llvm.func @eq(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([0, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def ne_before := [llvmfunc|
  llvm.func @ne(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([1, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def ugt_before := [llvmfunc|
  llvm.func @ugt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([2, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def uge_before := [llvmfunc|
  llvm.func @uge(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "uge" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([3, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def ult_before := [llvmfunc|
  llvm.func @ult(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([4, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def ule_before := [llvmfunc|
  llvm.func @ule(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "ule" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([5, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def sgt_before := [llvmfunc|
  llvm.func @sgt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([6, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def sge_before := [llvmfunc|
  llvm.func @sge(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([7, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def slt_before := [llvmfunc|
  llvm.func @slt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([8, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def sle_before := [llvmfunc|
  llvm.func @sle(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([9, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_false_before := [llvmfunc|
  llvm.func @f_false(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([10, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_oeq_before := [llvmfunc|
  llvm.func @f_oeq(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([11, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_ogt_before := [llvmfunc|
  llvm.func @f_ogt(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([12, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_oge_before := [llvmfunc|
  llvm.func @f_oge(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([13, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_olt_before := [llvmfunc|
  llvm.func @f_olt(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([14, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_ole_before := [llvmfunc|
  llvm.func @f_ole(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([15, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_one_before := [llvmfunc|
  llvm.func @f_one(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "one" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([16, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_ord_before := [llvmfunc|
  llvm.func @f_ord(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([17, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_uno_before := [llvmfunc|
  llvm.func @f_uno(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([18, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_ueq_before := [llvmfunc|
  llvm.func @f_ueq(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([19, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_ugt_before := [llvmfunc|
  llvm.func @f_ugt(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([20, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_uge_before := [llvmfunc|
  llvm.func @f_uge(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([21, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_ult_before := [llvmfunc|
  llvm.func @f_ult(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([22, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_ule_before := [llvmfunc|
  llvm.func @f_ule(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([23, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_une_before := [llvmfunc|
  llvm.func @f_une(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "une" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([24, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def f_true_before := [llvmfunc|
  llvm.func @f_true(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "_true" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([25, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def eq_combined := [llvmfunc|
  llvm.func @eq(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([0, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_eq   : eq_before  ⊑  eq_combined := by
  unfold eq_before eq_combined
  simp_alive_peephole
  sorry
def ne_combined := [llvmfunc|
  llvm.func @ne(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([99, 1]), ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

theorem inst_combine_ne   : ne_before  ⊑  ne_combined := by
  unfold ne_before ne_combined
  simp_alive_peephole
  sorry
def ugt_combined := [llvmfunc|
  llvm.func @ugt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([2, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_ugt   : ugt_before  ⊑  ugt_combined := by
  unfold ugt_before ugt_combined
  simp_alive_peephole
  sorry
def uge_combined := [llvmfunc|
  llvm.func @uge(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([99, 3]), ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

theorem inst_combine_uge   : uge_before  ⊑  uge_combined := by
  unfold uge_before uge_combined
  simp_alive_peephole
  sorry
def ult_combined := [llvmfunc|
  llvm.func @ult(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([4, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_ult   : ult_before  ⊑  ult_combined := by
  unfold ult_before ult_combined
  simp_alive_peephole
  sorry
def ule_combined := [llvmfunc|
  llvm.func @ule(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([99, 5]), ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

theorem inst_combine_ule   : ule_before  ⊑  ule_combined := by
  unfold ule_before ule_combined
  simp_alive_peephole
  sorry
def sgt_combined := [llvmfunc|
  llvm.func @sgt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([6, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_sgt   : sgt_before  ⊑  sgt_combined := by
  unfold sgt_before sgt_combined
  simp_alive_peephole
  sorry
def sge_combined := [llvmfunc|
  llvm.func @sge(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([99, 7]), ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

theorem inst_combine_sge   : sge_before  ⊑  sge_combined := by
  unfold sge_before sge_combined
  simp_alive_peephole
  sorry
def slt_combined := [llvmfunc|
  llvm.func @slt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([8, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_slt   : slt_before  ⊑  slt_combined := by
  unfold slt_before slt_combined
  simp_alive_peephole
  sorry
def sle_combined := [llvmfunc|
  llvm.func @sle(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %2 weights([99, 9]), ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

theorem inst_combine_sle   : sle_before  ⊑  sle_combined := by
  unfold sle_before sle_combined
  simp_alive_peephole
  sorry
def f_false_combined := [llvmfunc|
  llvm.func @f_false(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.mlir.constant(12 : i32) : i32
    llvm.cond_br %0 weights([10, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

theorem inst_combine_f_false   : f_false_before  ⊑  f_false_combined := by
  unfold f_false_before f_false_combined
  simp_alive_peephole
  sorry
def f_oeq_combined := [llvmfunc|
  llvm.func @f_oeq(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([11, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_f_oeq   : f_oeq_before  ⊑  f_oeq_combined := by
  unfold f_oeq_before f_oeq_combined
  simp_alive_peephole
  sorry
def f_ogt_combined := [llvmfunc|
  llvm.func @f_ogt(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([12, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_f_ogt   : f_ogt_before  ⊑  f_ogt_combined := by
  unfold f_ogt_before f_ogt_combined
  simp_alive_peephole
  sorry
def f_oge_combined := [llvmfunc|
  llvm.func @f_oge(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([99, 13]), ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

theorem inst_combine_f_oge   : f_oge_before  ⊑  f_oge_combined := by
  unfold f_oge_before f_oge_combined
  simp_alive_peephole
  sorry
def f_olt_combined := [llvmfunc|
  llvm.func @f_olt(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([14, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_f_olt   : f_olt_before  ⊑  f_olt_combined := by
  unfold f_olt_before f_olt_combined
  simp_alive_peephole
  sorry
def f_ole_combined := [llvmfunc|
  llvm.func @f_ole(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([99, 15]), ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

theorem inst_combine_f_ole   : f_ole_before  ⊑  f_ole_combined := by
  unfold f_ole_before f_ole_combined
  simp_alive_peephole
  sorry
def f_one_combined := [llvmfunc|
  llvm.func @f_one(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([99, 16]), ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

theorem inst_combine_f_one   : f_one_before  ⊑  f_one_combined := by
  unfold f_one_before f_one_combined
  simp_alive_peephole
  sorry
def f_ord_combined := [llvmfunc|
  llvm.func @f_ord(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([17, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_f_ord   : f_ord_before  ⊑  f_ord_combined := by
  unfold f_ord_before f_ord_combined
  simp_alive_peephole
  sorry
def f_uno_combined := [llvmfunc|
  llvm.func @f_uno(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([18, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_f_uno   : f_uno_before  ⊑  f_uno_combined := by
  unfold f_uno_before f_uno_combined
  simp_alive_peephole
  sorry
def f_ueq_combined := [llvmfunc|
  llvm.func @f_ueq(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([19, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_f_ueq   : f_ueq_before  ⊑  f_ueq_combined := by
  unfold f_ueq_before f_ueq_combined
  simp_alive_peephole
  sorry
def f_ugt_combined := [llvmfunc|
  llvm.func @f_ugt(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([20, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_f_ugt   : f_ugt_before  ⊑  f_ugt_combined := by
  unfold f_ugt_before f_ugt_combined
  simp_alive_peephole
  sorry
def f_uge_combined := [llvmfunc|
  llvm.func @f_uge(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([21, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_f_uge   : f_uge_before  ⊑  f_uge_combined := by
  unfold f_uge_before f_uge_combined
  simp_alive_peephole
  sorry
def f_ult_combined := [llvmfunc|
  llvm.func @f_ult(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([22, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_f_ult   : f_ult_before  ⊑  f_ult_combined := by
  unfold f_ult_before f_ult_combined
  simp_alive_peephole
  sorry
def f_ule_combined := [llvmfunc|
  llvm.func @f_ule(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([23, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_f_ule   : f_ule_before  ⊑  f_ule_combined := by
  unfold f_ule_before f_ule_combined
  simp_alive_peephole
  sorry
def f_une_combined := [llvmfunc|
  llvm.func @f_une(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.fcmp "une" %arg0, %arg1 : f32
    llvm.cond_br %2 weights([24, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_f_une   : f_une_before  ⊑  f_une_combined := by
  unfold f_une_before f_une_combined
  simp_alive_peephole
  sorry
def f_true_combined := [llvmfunc|
  llvm.func @f_true(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.mlir.constant(12 : i32) : i32
    llvm.cond_br %0 weights([25, 99]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

theorem inst_combine_f_true   : f_true_before  ⊑  f_true_combined := by
  unfold f_true_before f_true_combined
  simp_alive_peephole
  sorry
