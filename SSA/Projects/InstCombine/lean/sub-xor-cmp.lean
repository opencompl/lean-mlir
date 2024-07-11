import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sub-xor-cmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sext_xor_sub_before := [llvmfunc|
  llvm.func @sext_xor_sub(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }]

def sext_xor_sub_1_before := [llvmfunc|
  llvm.func @sext_xor_sub_1(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }]

def sext_xor_sub_2_before := [llvmfunc|
  llvm.func @sext_xor_sub_2(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }]

def sext_xor_sub_3_before := [llvmfunc|
  llvm.func @sext_xor_sub_3(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }]

def sext_non_bool_xor_sub_before := [llvmfunc|
  llvm.func @sext_non_bool_xor_sub(%arg0: i64, %arg1: i8) -> i64 {
    %0 = llvm.sext %arg1 : i8 to i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }]

def sext_non_bool_xor_sub_1_before := [llvmfunc|
  llvm.func @sext_non_bool_xor_sub_1(%arg0: i64, %arg1: i8) -> i64 {
    %0 = llvm.sext %arg1 : i8 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }]

def sext_diff_i1_xor_sub_before := [llvmfunc|
  llvm.func @sext_diff_i1_xor_sub(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.xor %arg0, %0  : i64
    %3 = llvm.sub %0, %1  : i64
    llvm.return %3 : i64
  }]

def sext_diff_i1_xor_sub_1_before := [llvmfunc|
  llvm.func @sext_diff_i1_xor_sub_1(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.sext %arg2 : i1 to i64
    %2 = llvm.xor %0, %arg0  : i64
    %3 = llvm.sub %0, %1  : i64
    llvm.return %3 : i64
  }]

def sext_multi_uses_before := [llvmfunc|
  llvm.func @sext_multi_uses(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.sub %1, %0  : i64
    %3 = llvm.mul %arg2, %0  : i64
    %4 = llvm.add %3, %2  : i64
    llvm.return %4 : i64
  }]

def xor_multi_uses_before := [llvmfunc|
  llvm.func @xor_multi_uses(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.sub %1, %0  : i64
    %3 = llvm.mul %arg2, %1  : i64
    %4 = llvm.add %3, %2  : i64
    llvm.return %4 : i64
  }]

def absdiff_before := [llvmfunc|
  llvm.func @absdiff(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.xor %1, %2  : i64
    %4 = llvm.sub %3, %1  : i64
    llvm.return %4 : i64
  }]

def absdiff1_before := [llvmfunc|
  llvm.func @absdiff1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.xor %2, %1  : i64
    %4 = llvm.sub %3, %1  : i64
    llvm.return %4 : i64
  }]

def absdiff2_before := [llvmfunc|
  llvm.func @absdiff2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.xor %2, %1  : i64
    %4 = llvm.sub %3, %1  : i64
    llvm.return %4 : i64
  }]

def sext_xor_sub_combined := [llvmfunc|
  llvm.func @sext_xor_sub(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sext_xor_sub   : sext_xor_sub_before  ⊑  sext_xor_sub_combined := by
  unfold sext_xor_sub_before sext_xor_sub_combined
  simp_alive_peephole
  sorry
def sext_xor_sub_1_combined := [llvmfunc|
  llvm.func @sext_xor_sub_1(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sext_xor_sub_1   : sext_xor_sub_1_before  ⊑  sext_xor_sub_1_combined := by
  unfold sext_xor_sub_1_before sext_xor_sub_1_combined
  simp_alive_peephole
  sorry
def sext_xor_sub_2_combined := [llvmfunc|
  llvm.func @sext_xor_sub_2(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sext_xor_sub_2   : sext_xor_sub_2_before  ⊑  sext_xor_sub_2_combined := by
  unfold sext_xor_sub_2_before sext_xor_sub_2_combined
  simp_alive_peephole
  sorry
def sext_xor_sub_3_combined := [llvmfunc|
  llvm.func @sext_xor_sub_3(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %0, %1  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sext_xor_sub_3   : sext_xor_sub_3_before  ⊑  sext_xor_sub_3_combined := by
  unfold sext_xor_sub_3_before sext_xor_sub_3_combined
  simp_alive_peephole
  sorry
def sext_non_bool_xor_sub_combined := [llvmfunc|
  llvm.func @sext_non_bool_xor_sub(%arg0: i64, %arg1: i8) -> i64 {
    %0 = llvm.sext %arg1 : i8 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sext_non_bool_xor_sub   : sext_non_bool_xor_sub_before  ⊑  sext_non_bool_xor_sub_combined := by
  unfold sext_non_bool_xor_sub_before sext_non_bool_xor_sub_combined
  simp_alive_peephole
  sorry
def sext_non_bool_xor_sub_1_combined := [llvmfunc|
  llvm.func @sext_non_bool_xor_sub_1(%arg0: i64, %arg1: i8) -> i64 {
    %0 = llvm.sext %arg1 : i8 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sext_non_bool_xor_sub_1   : sext_non_bool_xor_sub_1_before  ⊑  sext_non_bool_xor_sub_1_combined := by
  unfold sext_non_bool_xor_sub_1_before sext_non_bool_xor_sub_1_combined
  simp_alive_peephole
  sorry
def sext_diff_i1_xor_sub_combined := [llvmfunc|
  llvm.func @sext_diff_i1_xor_sub(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.add %1, %0 overflow<nsw>  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sext_diff_i1_xor_sub   : sext_diff_i1_xor_sub_before  ⊑  sext_diff_i1_xor_sub_combined := by
  unfold sext_diff_i1_xor_sub_before sext_diff_i1_xor_sub_combined
  simp_alive_peephole
  sorry
def sext_diff_i1_xor_sub_1_combined := [llvmfunc|
  llvm.func @sext_diff_i1_xor_sub_1(%arg0: i64, %arg1: i1, %arg2: i1) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.zext %arg2 : i1 to i64
    %2 = llvm.add %1, %0 overflow<nsw>  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sext_diff_i1_xor_sub_1   : sext_diff_i1_xor_sub_1_before  ⊑  sext_diff_i1_xor_sub_1_combined := by
  unfold sext_diff_i1_xor_sub_1_before sext_diff_i1_xor_sub_1_combined
  simp_alive_peephole
  sorry
def sext_multi_uses_combined := [llvmfunc|
  llvm.func @sext_multi_uses(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %1, %0  : i64
    %3 = llvm.mul %0, %arg2  : i64
    %4 = llvm.add %3, %2  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_sext_multi_uses   : sext_multi_uses_before  ⊑  sext_multi_uses_combined := by
  unfold sext_multi_uses_before sext_multi_uses_combined
  simp_alive_peephole
  sorry
def xor_multi_uses_combined := [llvmfunc|
  llvm.func @xor_multi_uses(%arg0: i64, %arg1: i1, %arg2: i64) -> i64 {
    %0 = llvm.sext %arg1 : i1 to i64
    %1 = llvm.xor %0, %arg0  : i64
    %2 = llvm.sub %1, %0  : i64
    %3 = llvm.mul %1, %arg2  : i64
    %4 = llvm.add %3, %2  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_xor_multi_uses   : xor_multi_uses_before  ⊑  xor_multi_uses_combined := by
  unfold xor_multi_uses_before xor_multi_uses_combined
  simp_alive_peephole
  sorry
def absdiff_combined := [llvmfunc|
  llvm.func @absdiff(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.xor %2, %1  : i64
    %4 = llvm.sub %3, %1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_absdiff   : absdiff_before  ⊑  absdiff_combined := by
  unfold absdiff_before absdiff_combined
  simp_alive_peephole
  sorry
def absdiff1_combined := [llvmfunc|
  llvm.func @absdiff1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.xor %2, %1  : i64
    %4 = llvm.sub %3, %1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_absdiff1   : absdiff1_before  ⊑  absdiff1_combined := by
  unfold absdiff1_before absdiff1_combined
  simp_alive_peephole
  sorry
def absdiff2_combined := [llvmfunc|
  llvm.func @absdiff2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
    %1 = llvm.sext %0 : i1 to i64
    %2 = llvm.sub %arg1, %arg0  : i64
    %3 = llvm.xor %2, %1  : i64
    %4 = llvm.sub %3, %1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_absdiff2   : absdiff2_before  ⊑  absdiff2_combined := by
  unfold absdiff2_before absdiff2_combined
  simp_alive_peephole
  sorry
