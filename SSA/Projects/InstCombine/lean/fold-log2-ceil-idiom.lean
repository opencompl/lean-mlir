import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-log2-ceil-idiom
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def log2_ceil_idiom_before := [llvmfunc|
  llvm.func @log2_ceil_idiom(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }]

def log2_ceil_idiom_trunc_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_trunc(%arg0: i32) -> i5 {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.trunc %2 : i32 to i5
    %4 = llvm.xor %3, %0  : i5
    %5 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i5
    %8 = llvm.add %4, %7  : i5
    llvm.return %8 : i5
  }]

def log2_ceil_idiom_zext_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_zext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i64
    %8 = llvm.add %4, %7  : i64
    llvm.return %8 : i64
  }]

def log2_ceil_idiom_power2_test2_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_power2_test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }]

def log2_ceil_idiom_commuted_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_commuted(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %6, %3  : i32
    llvm.return %7 : i32
  }]

def log2_ceil_idiom_multiuse1_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_multiuse1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }]

def log2_ceil_idiom_x_may_be_zero_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_x_may_be_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }]

def log2_ceil_idiom_trunc_too_short_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_trunc_too_short(%arg0: i32) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.trunc %2 : i32 to i4
    %4 = llvm.xor %3, %0  : i4
    %5 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i4
    %8 = llvm.add %4, %7  : i4
    llvm.return %8 : i4
  }]

def log2_ceil_idiom_mismatched_operands_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_mismatched_operands(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }]

def log2_ceil_idiom_wrong_constant_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_wrong_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }]

def log2_ceil_idiom_not_a_power2_test1_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_not_a_power2_test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }]

def log2_ceil_idiom_not_a_power2_test2_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_not_a_power2_test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }]

def log2_ceil_idiom_multiuse2_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_multiuse2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }]

def log2_ceil_idiom_multiuse3_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_multiuse3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.xor %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6  : i32
    llvm.return %7 : i32
  }]

def log2_ceil_idiom_trunc_multiuse4_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_trunc_multiuse4(%arg0: i32) -> i5 {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.trunc %2 : i32 to i5
    llvm.call @use5(%3) : (i5) -> ()
    %4 = llvm.xor %3, %0  : i5
    %5 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i5
    %8 = llvm.add %4, %7  : i5
    llvm.return %8 : i5
  }]

def log2_ceil_idiom_zext_multiuse5_before := [llvmfunc|
  llvm.func @log2_ceil_idiom_zext_multiuse5(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i64
    %8 = llvm.add %4, %7  : i64
    llvm.return %8 : i64
  }]

def log2_ceil_idiom_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    %4 = llvm.sub %1, %3 overflow<nsw, nuw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_log2_ceil_idiom   : log2_ceil_idiom_before  ⊑  log2_ceil_idiom_combined := by
  unfold log2_ceil_idiom_before log2_ceil_idiom_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_trunc_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_trunc(%arg0: i32) -> i5 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    %4 = llvm.sub %1, %3 overflow<nsw>  : i32
    %5 = llvm.trunc %4 : i32 to i5
    llvm.return %5 : i5
  }]

theorem inst_combine_log2_ceil_idiom_trunc   : log2_ceil_idiom_trunc_before  ⊑  log2_ceil_idiom_trunc_combined := by
  unfold log2_ceil_idiom_trunc_before log2_ceil_idiom_trunc_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_zext_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_zext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    %4 = llvm.sub %1, %3 overflow<nsw, nuw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }]

theorem inst_combine_log2_ceil_idiom_zext   : log2_ceil_idiom_zext_before  ⊑  log2_ceil_idiom_zext_combined := by
  unfold log2_ceil_idiom_zext_before log2_ceil_idiom_zext_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_power2_test2_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_power2_test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    %4 = llvm.sub %1, %3 overflow<nsw, nuw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_log2_ceil_idiom_power2_test2   : log2_ceil_idiom_power2_test2_before  ⊑  log2_ceil_idiom_power2_test2_combined := by
  unfold log2_ceil_idiom_power2_test2_before log2_ceil_idiom_power2_test2_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_commuted_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_commuted(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    %4 = llvm.sub %1, %3 overflow<nsw, nuw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_log2_ceil_idiom_commuted   : log2_ceil_idiom_commuted_before  ⊑  log2_ceil_idiom_commuted_combined := by
  unfold log2_ceil_idiom_commuted_before log2_ceil_idiom_commuted_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_multiuse1_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_multiuse1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.sub %1, %4 overflow<nsw, nuw>  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_log2_ceil_idiom_multiuse1   : log2_ceil_idiom_multiuse1_before  ⊑  log2_ceil_idiom_multiuse1_combined := by
  unfold log2_ceil_idiom_multiuse1_before log2_ceil_idiom_multiuse1_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_x_may_be_zero_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_x_may_be_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6 overflow<nsw, nuw>  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_log2_ceil_idiom_x_may_be_zero   : log2_ceil_idiom_x_may_be_zero_before  ⊑  log2_ceil_idiom_x_may_be_zero_combined := by
  unfold log2_ceil_idiom_x_may_be_zero_before log2_ceil_idiom_x_may_be_zero_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_trunc_too_short_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_trunc_too_short(%arg0: i32) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.trunc %2 : i32 to i4
    %4 = llvm.xor %3, %0  : i4
    %5 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i4
    %8 = llvm.add %4, %7  : i4
    llvm.return %8 : i4
  }]

theorem inst_combine_log2_ceil_idiom_trunc_too_short   : log2_ceil_idiom_trunc_too_short_before  ⊑  log2_ceil_idiom_trunc_too_short_combined := by
  unfold log2_ceil_idiom_trunc_too_short_before log2_ceil_idiom_trunc_too_short_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_mismatched_operands_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_mismatched_operands(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg1)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6 overflow<nsw, nuw>  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_log2_ceil_idiom_mismatched_operands   : log2_ceil_idiom_mismatched_operands_before  ⊑  log2_ceil_idiom_mismatched_operands_combined := by
  unfold log2_ceil_idiom_mismatched_operands_before log2_ceil_idiom_mismatched_operands_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_wrong_constant_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_wrong_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6 overflow<nsw, nuw>  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_log2_ceil_idiom_wrong_constant   : log2_ceil_idiom_wrong_constant_before  ⊑  log2_ceil_idiom_wrong_constant_combined := by
  unfold log2_ceil_idiom_wrong_constant_before log2_ceil_idiom_wrong_constant_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_not_a_power2_test1_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_not_a_power2_test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6 overflow<nsw, nuw>  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_log2_ceil_idiom_not_a_power2_test1   : log2_ceil_idiom_not_a_power2_test1_before  ⊑  log2_ceil_idiom_not_a_power2_test1_combined := by
  unfold log2_ceil_idiom_not_a_power2_test1_before log2_ceil_idiom_not_a_power2_test1_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_not_a_power2_test2_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_not_a_power2_test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6 overflow<nsw, nuw>  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_log2_ceil_idiom_not_a_power2_test2   : log2_ceil_idiom_not_a_power2_test2_before  ⊑  log2_ceil_idiom_not_a_power2_test2_combined := by
  unfold log2_ceil_idiom_not_a_power2_test2_before log2_ceil_idiom_not_a_power2_test2_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_multiuse2_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_multiuse2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6 overflow<nsw, nuw>  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_log2_ceil_idiom_multiuse2   : log2_ceil_idiom_multiuse2_before  ⊑  log2_ceil_idiom_multiuse2_combined := by
  unfold log2_ceil_idiom_multiuse2_before log2_ceil_idiom_multiuse2_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_multiuse3_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_multiuse3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.add %3, %6 overflow<nsw, nuw>  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_log2_ceil_idiom_multiuse3   : log2_ceil_idiom_multiuse3_before  ⊑  log2_ceil_idiom_multiuse3_combined := by
  unfold log2_ceil_idiom_multiuse3_before log2_ceil_idiom_multiuse3_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_trunc_multiuse4_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_trunc_multiuse4(%arg0: i32) -> i5 {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.trunc %2 : i32 to i5
    llvm.call @use5(%3) : (i5) -> ()
    %4 = llvm.xor %3, %0  : i5
    %5 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i5
    %8 = llvm.add %4, %7  : i5
    llvm.return %8 : i5
  }]

theorem inst_combine_log2_ceil_idiom_trunc_multiuse4   : log2_ceil_idiom_trunc_multiuse4_before  ⊑  log2_ceil_idiom_trunc_multiuse4_combined := by
  unfold log2_ceil_idiom_trunc_multiuse4_before log2_ceil_idiom_trunc_multiuse4_combined
  simp_alive_peephole
  sorry
def log2_ceil_idiom_zext_multiuse5_combined := [llvmfunc|
  llvm.func @log2_ceil_idiom_zext_multiuse5(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.zext %3 : i32 to i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i64
    %8 = llvm.add %4, %7 overflow<nsw, nuw>  : i64
    llvm.return %8 : i64
  }]

theorem inst_combine_log2_ceil_idiom_zext_multiuse5   : log2_ceil_idiom_zext_multiuse5_before  ⊑  log2_ceil_idiom_zext_multiuse5_combined := by
  unfold log2_ceil_idiom_zext_multiuse5_before log2_ceil_idiom_zext_multiuse5_combined
  simp_alive_peephole
  sorry
