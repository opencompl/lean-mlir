import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-not-bool-constant
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def eq_t_not_before := [llvmfunc|
  llvm.func @eq_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def eq_f_not_before := [llvmfunc|
  llvm.func @eq_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "eq" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def ne_t_not_before := [llvmfunc|
  llvm.func @ne_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def ne_f_not_before := [llvmfunc|
  llvm.func @ne_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "ne" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def ugt_t_not_before := [llvmfunc|
  llvm.func @ugt_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "ugt" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def ugt_f_not_before := [llvmfunc|
  llvm.func @ugt_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "ugt" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def ult_t_not_before := [llvmfunc|
  llvm.func @ult_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def ult_f_not_before := [llvmfunc|
  llvm.func @ult_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "ult" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def sgt_t_not_before := [llvmfunc|
  llvm.func @sgt_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def sgt_f_not_before := [llvmfunc|
  llvm.func @sgt_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "sgt" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def slt_t_not_before := [llvmfunc|
  llvm.func @slt_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def slt_f_not_before := [llvmfunc|
  llvm.func @slt_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "slt" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def uge_t_not_before := [llvmfunc|
  llvm.func @uge_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "uge" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def uge_f_not_before := [llvmfunc|
  llvm.func @uge_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "uge" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def ule_t_not_before := [llvmfunc|
  llvm.func @ule_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "ule" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def ule_f_not_before := [llvmfunc|
  llvm.func @ule_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "ule" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def sge_t_not_before := [llvmfunc|
  llvm.func @sge_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "sge" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def sge_f_not_before := [llvmfunc|
  llvm.func @sge_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "sge" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def sle_t_not_before := [llvmfunc|
  llvm.func @sle_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "sle" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def sle_f_not_before := [llvmfunc|
  llvm.func @sle_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "sle" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def eq_t_not_combined := [llvmfunc|
  llvm.func @eq_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_eq_t_not   : eq_t_not_before  ⊑  eq_t_not_combined := by
  unfold eq_t_not_before eq_t_not_combined
  simp_alive_peephole
  sorry
def eq_f_not_combined := [llvmfunc|
  llvm.func @eq_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    llvm.return %arg0 : vector<2xi1>
  }]

theorem inst_combine_eq_f_not   : eq_f_not_before  ⊑  eq_f_not_combined := by
  unfold eq_f_not_before eq_f_not_combined
  simp_alive_peephole
  sorry
def ne_t_not_combined := [llvmfunc|
  llvm.func @ne_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    llvm.return %arg0 : vector<2xi1>
  }]

theorem inst_combine_ne_t_not   : ne_t_not_before  ⊑  ne_t_not_combined := by
  unfold ne_t_not_before ne_t_not_combined
  simp_alive_peephole
  sorry
def ne_f_not_combined := [llvmfunc|
  llvm.func @ne_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ne_f_not   : ne_f_not_before  ⊑  ne_f_not_combined := by
  unfold ne_f_not_before ne_f_not_combined
  simp_alive_peephole
  sorry
def ugt_t_not_combined := [llvmfunc|
  llvm.func @ugt_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_ugt_t_not   : ugt_t_not_before  ⊑  ugt_t_not_combined := by
  unfold ugt_t_not_before ugt_t_not_combined
  simp_alive_peephole
  sorry
def ugt_f_not_combined := [llvmfunc|
  llvm.func @ugt_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ugt_f_not   : ugt_f_not_before  ⊑  ugt_f_not_combined := by
  unfold ugt_f_not_before ugt_f_not_combined
  simp_alive_peephole
  sorry
def ult_t_not_combined := [llvmfunc|
  llvm.func @ult_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    llvm.return %arg0 : vector<2xi1>
  }]

theorem inst_combine_ult_t_not   : ult_t_not_before  ⊑  ult_t_not_combined := by
  unfold ult_t_not_before ult_t_not_combined
  simp_alive_peephole
  sorry
def ult_f_not_combined := [llvmfunc|
  llvm.func @ult_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_ult_f_not   : ult_f_not_before  ⊑  ult_f_not_combined := by
  unfold ult_f_not_before ult_f_not_combined
  simp_alive_peephole
  sorry
def sgt_t_not_combined := [llvmfunc|
  llvm.func @sgt_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    llvm.return %arg0 : vector<2xi1>
  }]

theorem inst_combine_sgt_t_not   : sgt_t_not_before  ⊑  sgt_t_not_combined := by
  unfold sgt_t_not_before sgt_t_not_combined
  simp_alive_peephole
  sorry
def sgt_f_not_combined := [llvmfunc|
  llvm.func @sgt_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sgt_f_not   : sgt_f_not_before  ⊑  sgt_f_not_combined := by
  unfold sgt_f_not_before sgt_f_not_combined
  simp_alive_peephole
  sorry
def slt_t_not_combined := [llvmfunc|
  llvm.func @slt_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_slt_t_not   : slt_t_not_before  ⊑  slt_t_not_combined := by
  unfold slt_t_not_before slt_t_not_combined
  simp_alive_peephole
  sorry
def slt_f_not_combined := [llvmfunc|
  llvm.func @slt_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_slt_f_not   : slt_f_not_before  ⊑  slt_f_not_combined := by
  unfold slt_f_not_before slt_f_not_combined
  simp_alive_peephole
  sorry
def uge_t_not_combined := [llvmfunc|
  llvm.func @uge_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_uge_t_not   : uge_t_not_before  ⊑  uge_t_not_combined := by
  unfold uge_t_not_before uge_t_not_combined
  simp_alive_peephole
  sorry
def uge_f_not_combined := [llvmfunc|
  llvm.func @uge_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_uge_f_not   : uge_f_not_before  ⊑  uge_f_not_combined := by
  unfold uge_f_not_before uge_f_not_combined
  simp_alive_peephole
  sorry
def ule_t_not_combined := [llvmfunc|
  llvm.func @ule_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_ule_t_not   : ule_t_not_before  ⊑  ule_t_not_combined := by
  unfold ule_t_not_before ule_t_not_combined
  simp_alive_peephole
  sorry
def ule_f_not_combined := [llvmfunc|
  llvm.func @ule_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    llvm.return %arg0 : vector<2xi1>
  }]

theorem inst_combine_ule_f_not   : ule_f_not_before  ⊑  ule_f_not_combined := by
  unfold ule_f_not_before ule_f_not_combined
  simp_alive_peephole
  sorry
def sge_t_not_combined := [llvmfunc|
  llvm.func @sge_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sge_t_not   : sge_t_not_before  ⊑  sge_t_not_combined := by
  unfold sge_t_not_before sge_t_not_combined
  simp_alive_peephole
  sorry
def sge_f_not_combined := [llvmfunc|
  llvm.func @sge_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    llvm.return %arg0 : vector<2xi1>
  }]

theorem inst_combine_sge_f_not   : sge_f_not_before  ⊑  sge_f_not_combined := by
  unfold sge_f_not_before sge_f_not_combined
  simp_alive_peephole
  sorry
def sle_t_not_combined := [llvmfunc|
  llvm.func @sle_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_sle_t_not   : sle_t_not_before  ⊑  sle_t_not_combined := by
  unfold sle_t_not_before sle_t_not_combined
  simp_alive_peephole
  sorry
def sle_f_not_combined := [llvmfunc|
  llvm.func @sle_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sle_f_not   : sle_f_not_before  ⊑  sle_f_not_combined := by
  unfold sle_f_not_before sle_f_not_combined
  simp_alive_peephole
  sorry
