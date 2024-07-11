import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bit_ceil
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bit_ceil_32_before := [llvmfunc|
  llvm.func @bit_ceil_32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.shl %2, %5  : i32
    %7 = llvm.icmp "ugt" %arg0, %2 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.return %8 : i32
  }]

def bit_ceil_64_before := [llvmfunc|
  llvm.func @bit_ceil_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(64 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.add %arg0, %0  : i64
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i64) -> i64]

    %5 = llvm.sub %1, %4  : i64
    %6 = llvm.shl %2, %5  : i64
    %7 = llvm.icmp "ugt" %arg0, %2 : i64
    %8 = llvm.select %7, %6, %2 : i1, i64
    llvm.return %8 : i64
  }]

def bit_ceil_32_minus_1_before := [llvmfunc|
  llvm.func @bit_ceil_32_minus_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(-3 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

    %6 = llvm.sub %1, %5 overflow<nsw, nuw>  : i32
    %7 = llvm.shl %2, %6 overflow<nuw>  : i32
    %8 = llvm.add %arg0, %3  : i32
    %9 = llvm.icmp "ult" %8, %0 : i32
    %10 = llvm.select %9, %7, %2 : i1, i32
    llvm.return %10 : i32
  }]

def bit_ceil_32_plus_1_before := [llvmfunc|
  llvm.func @bit_ceil_32_plus_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(-2 : i32) : i32
    %4 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.shl %1, %5  : i32
    %7 = llvm.add %arg0, %2  : i32
    %8 = llvm.icmp "ult" %7, %3 : i32
    %9 = llvm.select %8, %6, %1 : i1, i32
    llvm.return %9 : i32
  }]

def bit_ceil_plus_2_before := [llvmfunc|
  llvm.func @bit_ceil_plus_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

    %5 = llvm.sub %1, %4 overflow<nsw, nuw>  : i32
    %6 = llvm.shl %0, %5 overflow<nuw>  : i32
    %7 = llvm.icmp "ult" %arg0, %2 : i32
    %8 = llvm.select %7, %6, %0 : i1, i32
    llvm.return %8 : i32
  }]

def bit_ceil_32_neg_before := [llvmfunc|
  llvm.func @bit_ceil_32_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(-2 : i32) : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

    %6 = llvm.sub %1, %5 overflow<nsw, nuw>  : i32
    %7 = llvm.shl %2, %6 overflow<nuw>  : i32
    %8 = llvm.add %arg0, %0  : i32
    %9 = llvm.icmp "ult" %8, %3 : i32
    %10 = llvm.select %9, %7, %2 : i1, i32
    llvm.return %10 : i32
  }]

def bit_ceil_not_before := [llvmfunc|
  llvm.func @bit_ceil_not(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

    %5 = llvm.sub %1, %4 overflow<nsw, nuw>  : i32
    %6 = llvm.shl %2, %5 overflow<nuw>  : i32
    %7 = llvm.icmp "ult" %arg0, %0 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.return %8 : i32
  }]

def bit_ceil_commuted_operands_before := [llvmfunc|
  llvm.func @bit_ceil_commuted_operands(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

    %6 = llvm.sub %1, %5  : i32
    %7 = llvm.shl %2, %6  : i32
    %8 = llvm.icmp "eq" %4, %3 : i32
    %9 = llvm.select %8, %2, %7 : i1, i32
    llvm.return %9 : i32
  }]

def bit_ceil_wrong_select_constant_before := [llvmfunc|
  llvm.func @bit_ceil_wrong_select_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

    %6 = llvm.sub %1, %5  : i32
    %7 = llvm.shl %2, %6  : i32
    %8 = llvm.icmp "ugt" %arg0, %2 : i32
    %9 = llvm.select %8, %7, %3 : i1, i32
    llvm.return %9 : i32
  }]

def bit_ceil_32_wrong_cond_before := [llvmfunc|
  llvm.func @bit_ceil_32_wrong_cond(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

    %6 = llvm.sub %1, %5  : i32
    %7 = llvm.shl %2, %6  : i32
    %8 = llvm.icmp "ugt" %arg0, %3 : i32
    %9 = llvm.select %8, %7, %2 : i1, i32
    llvm.return %9 : i32
  }]

def bit_ceil_wrong_sub_constant_before := [llvmfunc|
  llvm.func @bit_ceil_wrong_sub_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(33 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.shl %2, %5  : i32
    %7 = llvm.icmp "ugt" %arg0, %2 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.return %8 : i32
  }]

def bit_ceil_32_shl_used_twice_before := [llvmfunc|
  llvm.func @bit_ceil_32_shl_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.shl %2, %5  : i32
    %7 = llvm.icmp "ugt" %arg0, %2 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.store %6, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %8 : i32
  }]

def bit_ceil_32_sub_used_twice_before := [llvmfunc|
  llvm.func @bit_ceil_32_sub_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.shl %2, %5  : i32
    %7 = llvm.icmp "ugt" %arg0, %2 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.store %5, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %8 : i32
  }]

def bit_ceil_v4i32_before := [llvmfunc|
  llvm.func @bit_ceil_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<32> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.add %arg0, %0  : vector<4xi32>
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (vector<4xi32>) -> vector<4xi32>]

    %5 = llvm.sub %1, %4  : vector<4xi32>
    %6 = llvm.shl %2, %5  : vector<4xi32>
    %7 = llvm.icmp "ugt" %arg0, %2 : vector<4xi32>
    %8 = llvm.select %7, %6, %2 : vector<4xi1>, vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }]

def pr91691_before := [llvmfunc|
  llvm.func @pr91691(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg0 overflow<nuw>  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.shl %2, %5  : i32
    %7 = llvm.icmp "ult" %arg0, %0 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.return %8 : i32
  }]

def pr91691_keep_nsw_before := [llvmfunc|
  llvm.func @pr91691_keep_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.shl %2, %5  : i32
    %7 = llvm.icmp "ult" %arg0, %0 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.return %8 : i32
  }]

def bit_ceil_32_combined := [llvmfunc|
  llvm.func @bit_ceil_32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_ceil_32   : bit_ceil_32_before  ⊑  bit_ceil_32_combined := by
  unfold bit_ceil_32_before bit_ceil_32_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %1, %5 overflow<nsw>  : i32
    %7 = llvm.and %6, %2  : i32
    %8 = llvm.shl %3, %7 overflow<nuw>  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_bit_ceil_32   : bit_ceil_32_before  ⊑  bit_ceil_32_combined := by
  unfold bit_ceil_32_before bit_ceil_32_combined
  simp_alive_peephole
  sorry
def bit_ceil_64_combined := [llvmfunc|
  llvm.func @bit_ceil_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.add %arg0, %0  : i64
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i64) -> i64]

theorem inst_combine_bit_ceil_64   : bit_ceil_64_before  ⊑  bit_ceil_64_combined := by
  unfold bit_ceil_64_before bit_ceil_64_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %1, %5 overflow<nsw>  : i64
    %7 = llvm.and %6, %2  : i64
    %8 = llvm.shl %3, %7 overflow<nuw>  : i64
    llvm.return %8 : i64
  }]

theorem inst_combine_bit_ceil_64   : bit_ceil_64_before  ⊑  bit_ceil_64_combined := by
  unfold bit_ceil_64_before bit_ceil_64_combined
  simp_alive_peephole
  sorry
def bit_ceil_32_minus_1_combined := [llvmfunc|
  llvm.func @bit_ceil_32_minus_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_ceil_32_minus_1   : bit_ceil_32_minus_1_before  ⊑  bit_ceil_32_minus_1_combined := by
  unfold bit_ceil_32_minus_1_before bit_ceil_32_minus_1_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %1, %5 overflow<nsw>  : i32
    %7 = llvm.and %6, %2  : i32
    %8 = llvm.shl %3, %7 overflow<nuw>  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_bit_ceil_32_minus_1   : bit_ceil_32_minus_1_before  ⊑  bit_ceil_32_minus_1_combined := by
  unfold bit_ceil_32_minus_1_before bit_ceil_32_minus_1_combined
  simp_alive_peephole
  sorry
def bit_ceil_32_plus_1_combined := [llvmfunc|
  llvm.func @bit_ceil_32_plus_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_ceil_32_plus_1   : bit_ceil_32_plus_1_before  ⊑  bit_ceil_32_plus_1_combined := by
  unfold bit_ceil_32_plus_1_before bit_ceil_32_plus_1_combined
  simp_alive_peephole
  sorry
    %4 = llvm.sub %0, %3 overflow<nsw>  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.shl %2, %5 overflow<nuw>  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_bit_ceil_32_plus_1   : bit_ceil_32_plus_1_before  ⊑  bit_ceil_32_plus_1_combined := by
  unfold bit_ceil_32_plus_1_before bit_ceil_32_plus_1_combined
  simp_alive_peephole
  sorry
def bit_ceil_plus_2_combined := [llvmfunc|
  llvm.func @bit_ceil_plus_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_ceil_plus_2   : bit_ceil_plus_2_before  ⊑  bit_ceil_plus_2_combined := by
  unfold bit_ceil_plus_2_before bit_ceil_plus_2_combined
  simp_alive_peephole
  sorry
    %5 = llvm.sub %1, %4 overflow<nsw>  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.shl %0, %6 overflow<nuw>  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_bit_ceil_plus_2   : bit_ceil_plus_2_before  ⊑  bit_ceil_plus_2_combined := by
  unfold bit_ceil_plus_2_before bit_ceil_plus_2_combined
  simp_alive_peephole
  sorry
def bit_ceil_32_neg_combined := [llvmfunc|
  llvm.func @bit_ceil_32_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_ceil_32_neg   : bit_ceil_32_neg_before  ⊑  bit_ceil_32_neg_combined := by
  unfold bit_ceil_32_neg_before bit_ceil_32_neg_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %1, %5 overflow<nsw>  : i32
    %7 = llvm.and %6, %2  : i32
    %8 = llvm.shl %3, %7 overflow<nuw>  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_bit_ceil_32_neg   : bit_ceil_32_neg_before  ⊑  bit_ceil_32_neg_combined := by
  unfold bit_ceil_32_neg_before bit_ceil_32_neg_combined
  simp_alive_peephole
  sorry
def bit_ceil_not_combined := [llvmfunc|
  llvm.func @bit_ceil_not(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.sub %0, %arg0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_ceil_not   : bit_ceil_not_before  ⊑  bit_ceil_not_combined := by
  unfold bit_ceil_not_before bit_ceil_not_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %1, %5 overflow<nsw>  : i32
    %7 = llvm.and %6, %2  : i32
    %8 = llvm.shl %3, %7 overflow<nuw>  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_bit_ceil_not   : bit_ceil_not_before  ⊑  bit_ceil_not_combined := by
  unfold bit_ceil_not_before bit_ceil_not_combined
  simp_alive_peephole
  sorry
def bit_ceil_commuted_operands_combined := [llvmfunc|
  llvm.func @bit_ceil_commuted_operands(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_ceil_commuted_operands   : bit_ceil_commuted_operands_before  ⊑  bit_ceil_commuted_operands_combined := by
  unfold bit_ceil_commuted_operands_before bit_ceil_commuted_operands_combined
  simp_alive_peephole
  sorry
    %5 = llvm.sub %1, %4 overflow<nsw, nuw>  : i32
    %6 = llvm.shl %2, %5 overflow<nuw>  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_bit_ceil_commuted_operands   : bit_ceil_commuted_operands_before  ⊑  bit_ceil_commuted_operands_combined := by
  unfold bit_ceil_commuted_operands_before bit_ceil_commuted_operands_combined
  simp_alive_peephole
  sorry
def bit_ceil_wrong_select_constant_combined := [llvmfunc|
  llvm.func @bit_ceil_wrong_select_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_ceil_wrong_select_constant   : bit_ceil_wrong_select_constant_before  ⊑  bit_ceil_wrong_select_constant_combined := by
  unfold bit_ceil_wrong_select_constant_before bit_ceil_wrong_select_constant_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %1, %5 overflow<nsw, nuw>  : i32
    %7 = llvm.shl %2, %6 overflow<nuw>  : i32
    %8 = llvm.icmp "ult" %arg0, %3 : i32
    %9 = llvm.select %8, %3, %7 : i1, i32
    llvm.return %9 : i32
  }]

theorem inst_combine_bit_ceil_wrong_select_constant   : bit_ceil_wrong_select_constant_before  ⊑  bit_ceil_wrong_select_constant_combined := by
  unfold bit_ceil_wrong_select_constant_before bit_ceil_wrong_select_constant_combined
  simp_alive_peephole
  sorry
def bit_ceil_32_wrong_cond_combined := [llvmfunc|
  llvm.func @bit_ceil_32_wrong_cond(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_ceil_32_wrong_cond   : bit_ceil_32_wrong_cond_before  ⊑  bit_ceil_32_wrong_cond_combined := by
  unfold bit_ceil_32_wrong_cond_before bit_ceil_32_wrong_cond_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %1, %5 overflow<nsw, nuw>  : i32
    %7 = llvm.shl %2, %6 overflow<nuw>  : i32
    %8 = llvm.icmp "ugt" %arg0, %3 : i32
    %9 = llvm.select %8, %7, %2 : i1, i32
    llvm.return %9 : i32
  }]

theorem inst_combine_bit_ceil_32_wrong_cond   : bit_ceil_32_wrong_cond_before  ⊑  bit_ceil_32_wrong_cond_combined := by
  unfold bit_ceil_32_wrong_cond_before bit_ceil_32_wrong_cond_combined
  simp_alive_peephole
  sorry
def bit_ceil_wrong_sub_constant_combined := [llvmfunc|
  llvm.func @bit_ceil_wrong_sub_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(33 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_ceil_wrong_sub_constant   : bit_ceil_wrong_sub_constant_before  ⊑  bit_ceil_wrong_sub_constant_combined := by
  unfold bit_ceil_wrong_sub_constant_before bit_ceil_wrong_sub_constant_combined
  simp_alive_peephole
  sorry
    %5 = llvm.sub %1, %4 overflow<nsw, nuw>  : i32
    %6 = llvm.shl %2, %5 overflow<nuw>  : i32
    %7 = llvm.icmp "ugt" %arg0, %2 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.return %8 : i32
  }]

theorem inst_combine_bit_ceil_wrong_sub_constant   : bit_ceil_wrong_sub_constant_before  ⊑  bit_ceil_wrong_sub_constant_combined := by
  unfold bit_ceil_wrong_sub_constant_before bit_ceil_wrong_sub_constant_combined
  simp_alive_peephole
  sorry
def bit_ceil_32_shl_used_twice_combined := [llvmfunc|
  llvm.func @bit_ceil_32_shl_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_ceil_32_shl_used_twice   : bit_ceil_32_shl_used_twice_before  ⊑  bit_ceil_32_shl_used_twice_combined := by
  unfold bit_ceil_32_shl_used_twice_before bit_ceil_32_shl_used_twice_combined
  simp_alive_peephole
  sorry
    %5 = llvm.sub %1, %4 overflow<nsw, nuw>  : i32
    %6 = llvm.shl %2, %5 overflow<nuw>  : i32
    %7 = llvm.icmp "ugt" %arg0, %2 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.store %6, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_bit_ceil_32_shl_used_twice   : bit_ceil_32_shl_used_twice_before  ⊑  bit_ceil_32_shl_used_twice_combined := by
  unfold bit_ceil_32_shl_used_twice_before bit_ceil_32_shl_used_twice_combined
  simp_alive_peephole
  sorry
    llvm.return %8 : i32
  }]

theorem inst_combine_bit_ceil_32_shl_used_twice   : bit_ceil_32_shl_used_twice_before  ⊑  bit_ceil_32_shl_used_twice_combined := by
  unfold bit_ceil_32_shl_used_twice_before bit_ceil_32_shl_used_twice_combined
  simp_alive_peephole
  sorry
def bit_ceil_32_sub_used_twice_combined := [llvmfunc|
  llvm.func @bit_ceil_32_sub_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_bit_ceil_32_sub_used_twice   : bit_ceil_32_sub_used_twice_before  ⊑  bit_ceil_32_sub_used_twice_combined := by
  unfold bit_ceil_32_sub_used_twice_before bit_ceil_32_sub_used_twice_combined
  simp_alive_peephole
  sorry
    %5 = llvm.sub %1, %4 overflow<nsw, nuw>  : i32
    %6 = llvm.shl %2, %5 overflow<nuw>  : i32
    %7 = llvm.icmp "ugt" %arg0, %2 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.store %5, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_bit_ceil_32_sub_used_twice   : bit_ceil_32_sub_used_twice_before  ⊑  bit_ceil_32_sub_used_twice_combined := by
  unfold bit_ceil_32_sub_used_twice_before bit_ceil_32_sub_used_twice_combined
  simp_alive_peephole
  sorry
    llvm.return %8 : i32
  }]

theorem inst_combine_bit_ceil_32_sub_used_twice   : bit_ceil_32_sub_used_twice_before  ⊑  bit_ceil_32_sub_used_twice_combined := by
  unfold bit_ceil_32_sub_used_twice_before bit_ceil_32_sub_used_twice_combined
  simp_alive_peephole
  sorry
def bit_ceil_v4i32_combined := [llvmfunc|
  llvm.func @bit_ceil_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %5 = llvm.add %arg0, %0  : vector<4xi32>
    %6 = "llvm.intr.ctlz"(%5) <{is_zero_poison = false}> : (vector<4xi32>) -> vector<4xi32>]

theorem inst_combine_bit_ceil_v4i32   : bit_ceil_v4i32_before  ⊑  bit_ceil_v4i32_combined := by
  unfold bit_ceil_v4i32_before bit_ceil_v4i32_combined
  simp_alive_peephole
  sorry
    %7 = llvm.sub %2, %6 overflow<nsw>  : vector<4xi32>
    %8 = llvm.and %7, %3  : vector<4xi32>
    %9 = llvm.shl %4, %8 overflow<nuw>  : vector<4xi32>
    llvm.return %9 : vector<4xi32>
  }]

theorem inst_combine_bit_ceil_v4i32   : bit_ceil_v4i32_before  ⊑  bit_ceil_v4i32_combined := by
  unfold bit_ceil_v4i32_before bit_ceil_v4i32_combined
  simp_alive_peephole
  sorry
def pr91691_combined := [llvmfunc|
  llvm.func @pr91691(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.sub %0, %arg0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_pr91691   : pr91691_before  ⊑  pr91691_combined := by
  unfold pr91691_before pr91691_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %1, %5 overflow<nsw>  : i32
    %7 = llvm.and %6, %2  : i32
    %8 = llvm.shl %3, %7 overflow<nuw>  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_pr91691   : pr91691_before  ⊑  pr91691_combined := by
  unfold pr91691_before pr91691_combined
  simp_alive_peephole
  sorry
def pr91691_keep_nsw_combined := [llvmfunc|
  llvm.func @pr91691_keep_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_pr91691_keep_nsw   : pr91691_keep_nsw_before  ⊑  pr91691_keep_nsw_combined := by
  unfold pr91691_keep_nsw_before pr91691_keep_nsw_combined
  simp_alive_peephole
  sorry
    %6 = llvm.sub %1, %5 overflow<nsw>  : i32
    %7 = llvm.and %6, %2  : i32
    %8 = llvm.shl %3, %7 overflow<nuw>  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_pr91691_keep_nsw   : pr91691_keep_nsw_before  ⊑  pr91691_keep_nsw_combined := by
  unfold pr91691_keep_nsw_before pr91691_keep_nsw_combined
  simp_alive_peephole
  sorry
