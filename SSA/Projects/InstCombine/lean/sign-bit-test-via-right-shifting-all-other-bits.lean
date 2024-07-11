import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sign-bit-test-via-right-shifting-all-other-bits
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def highest_bit_test_via_lshr_before := [llvmfunc|
  llvm.func @highest_bit_test_via_lshr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.sub %arg1, %1  : i32
    %6 = llvm.lshr %4, %5  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }]

def highest_bit_test_via_lshr_with_truncation_before := [llvmfunc|
  llvm.func @highest_bit_test_via_lshr_with_truncation(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.sub %arg1, %1  : i32
    %8 = llvm.lshr %6, %7  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.icmp "ne" %8, %2 : i32
    llvm.return %9 : i1
  }]

def highest_bit_test_via_ashr_before := [llvmfunc|
  llvm.func @highest_bit_test_via_ashr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.ashr %arg0, %3  : i32
    %5 = llvm.sub %arg1, %1  : i32
    %6 = llvm.ashr %4, %5  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }]

def highest_bit_test_via_ashr_with_truncation_before := [llvmfunc|
  llvm.func @highest_bit_test_via_ashr_with_truncation(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.sub %arg1, %1  : i32
    %8 = llvm.ashr %6, %7  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.icmp "ne" %8, %2 : i32
    llvm.return %9 : i1
  }]

def highest_bit_test_via_lshr_ashr_before := [llvmfunc|
  llvm.func @highest_bit_test_via_lshr_ashr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.sub %arg1, %1  : i32
    %6 = llvm.ashr %4, %5  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }]

def highest_bit_test_via_lshr_ashe_with_truncation_before := [llvmfunc|
  llvm.func @highest_bit_test_via_lshr_ashe_with_truncation(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.sub %arg1, %1  : i32
    %8 = llvm.ashr %6, %7  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.icmp "ne" %8, %2 : i32
    llvm.return %9 : i1
  }]

def highest_bit_test_via_ashr_lshr_before := [llvmfunc|
  llvm.func @highest_bit_test_via_ashr_lshr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.ashr %arg0, %3  : i32
    %5 = llvm.sub %arg1, %1  : i32
    %6 = llvm.lshr %4, %5  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }]

def highest_bit_test_via_ashr_lshr_with_truncation_before := [llvmfunc|
  llvm.func @highest_bit_test_via_ashr_lshr_with_truncation(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.sub %arg1, %1  : i32
    %8 = llvm.lshr %6, %7  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.icmp "ne" %8, %2 : i32
    llvm.return %9 : i1
  }]

def unsigned_sign_bit_extract_before := [llvmfunc|
  llvm.func @unsigned_sign_bit_extract(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def unsigned_sign_bit_extract_extrause_before := [llvmfunc|
  llvm.func @unsigned_sign_bit_extract_extrause(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def unsigned_sign_bit_extract_extrause__ispositive_before := [llvmfunc|
  llvm.func @unsigned_sign_bit_extract_extrause__ispositive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def signed_sign_bit_extract_before := [llvmfunc|
  llvm.func @signed_sign_bit_extract(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def signed_sign_bit_extract_extrause_before := [llvmfunc|
  llvm.func @signed_sign_bit_extract_extrause(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def unsigned_sign_bit_extract_with_trunc_before := [llvmfunc|
  llvm.func @unsigned_sign_bit_extract_with_trunc(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

def unsigned_sign_bit_extract_with_trunc_extrause_before := [llvmfunc|
  llvm.func @unsigned_sign_bit_extract_with_trunc_extrause(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.trunc %2 : i64 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

def signed_sign_bit_extract_trunc_before := [llvmfunc|
  llvm.func @signed_sign_bit_extract_trunc(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

def signed_sign_bit_extract_trunc_extrause_before := [llvmfunc|
  llvm.func @signed_sign_bit_extract_trunc_extrause(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.trunc %2 : i64 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

def highest_bit_test_via_lshr_combined := [llvmfunc|
  llvm.func @highest_bit_test_via_lshr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.lshr %arg0, %4  : i32
    %6 = llvm.add %arg1, %1  : i32
    %7 = llvm.lshr %arg0, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.icmp "slt" %arg0, %3 : i32
    llvm.return %8 : i1
  }]

theorem inst_combine_highest_bit_test_via_lshr   : highest_bit_test_via_lshr_before  ⊑  highest_bit_test_via_lshr_combined := by
  unfold highest_bit_test_via_lshr_before highest_bit_test_via_lshr_combined
  simp_alive_peephole
  sorry
def highest_bit_test_via_lshr_with_truncation_combined := [llvmfunc|
  llvm.func @highest_bit_test_via_lshr_with_truncation(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.add %arg1, %1  : i32
    %8 = llvm.lshr %6, %7  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.icmp "slt" %arg0, %2 : i64
    llvm.return %9 : i1
  }]

theorem inst_combine_highest_bit_test_via_lshr_with_truncation   : highest_bit_test_via_lshr_with_truncation_before  ⊑  highest_bit_test_via_lshr_with_truncation_combined := by
  unfold highest_bit_test_via_lshr_with_truncation_before highest_bit_test_via_lshr_with_truncation_combined
  simp_alive_peephole
  sorry
def highest_bit_test_via_ashr_combined := [llvmfunc|
  llvm.func @highest_bit_test_via_ashr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.ashr %arg0, %4  : i32
    %6 = llvm.add %arg1, %1  : i32
    %7 = llvm.ashr %arg0, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.icmp "slt" %arg0, %3 : i32
    llvm.return %8 : i1
  }]

theorem inst_combine_highest_bit_test_via_ashr   : highest_bit_test_via_ashr_before  ⊑  highest_bit_test_via_ashr_combined := by
  unfold highest_bit_test_via_ashr_before highest_bit_test_via_ashr_combined
  simp_alive_peephole
  sorry
def highest_bit_test_via_ashr_with_truncation_combined := [llvmfunc|
  llvm.func @highest_bit_test_via_ashr_with_truncation(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.add %arg1, %1  : i32
    %8 = llvm.ashr %6, %7  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.icmp "slt" %arg0, %2 : i64
    llvm.return %9 : i1
  }]

theorem inst_combine_highest_bit_test_via_ashr_with_truncation   : highest_bit_test_via_ashr_with_truncation_before  ⊑  highest_bit_test_via_ashr_with_truncation_combined := by
  unfold highest_bit_test_via_ashr_with_truncation_before highest_bit_test_via_ashr_with_truncation_combined
  simp_alive_peephole
  sorry
def highest_bit_test_via_lshr_ashr_combined := [llvmfunc|
  llvm.func @highest_bit_test_via_lshr_ashr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.add %arg1, %1  : i32
    %6 = llvm.ashr %4, %5  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "slt" %arg0, %2 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_highest_bit_test_via_lshr_ashr   : highest_bit_test_via_lshr_ashr_before  ⊑  highest_bit_test_via_lshr_ashr_combined := by
  unfold highest_bit_test_via_lshr_ashr_before highest_bit_test_via_lshr_ashr_combined
  simp_alive_peephole
  sorry
def highest_bit_test_via_lshr_ashe_with_truncation_combined := [llvmfunc|
  llvm.func @highest_bit_test_via_lshr_ashe_with_truncation(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.add %arg1, %1  : i32
    %8 = llvm.ashr %6, %7  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.icmp "slt" %arg0, %2 : i64
    llvm.return %9 : i1
  }]

theorem inst_combine_highest_bit_test_via_lshr_ashe_with_truncation   : highest_bit_test_via_lshr_ashe_with_truncation_before  ⊑  highest_bit_test_via_lshr_ashe_with_truncation_combined := by
  unfold highest_bit_test_via_lshr_ashe_with_truncation_before highest_bit_test_via_lshr_ashe_with_truncation_combined
  simp_alive_peephole
  sorry
def highest_bit_test_via_ashr_lshr_combined := [llvmfunc|
  llvm.func @highest_bit_test_via_ashr_lshr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.ashr %arg0, %3  : i32
    %5 = llvm.add %arg1, %1  : i32
    %6 = llvm.lshr %4, %5  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "slt" %arg0, %2 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_highest_bit_test_via_ashr_lshr   : highest_bit_test_via_ashr_lshr_before  ⊑  highest_bit_test_via_ashr_lshr_combined := by
  unfold highest_bit_test_via_ashr_lshr_before highest_bit_test_via_ashr_lshr_combined
  simp_alive_peephole
  sorry
def highest_bit_test_via_ashr_lshr_with_truncation_combined := [llvmfunc|
  llvm.func @highest_bit_test_via_ashr_lshr_with_truncation(%arg0: i64, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.add %arg1, %1  : i32
    %8 = llvm.lshr %6, %7  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.icmp "slt" %arg0, %2 : i64
    llvm.return %9 : i1
  }]

theorem inst_combine_highest_bit_test_via_ashr_lshr_with_truncation   : highest_bit_test_via_ashr_lshr_with_truncation_before  ⊑  highest_bit_test_via_ashr_lshr_with_truncation_combined := by
  unfold highest_bit_test_via_ashr_lshr_with_truncation_before highest_bit_test_via_ashr_lshr_with_truncation_combined
  simp_alive_peephole
  sorry
def unsigned_sign_bit_extract_combined := [llvmfunc|
  llvm.func @unsigned_sign_bit_extract(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_unsigned_sign_bit_extract   : unsigned_sign_bit_extract_before  ⊑  unsigned_sign_bit_extract_combined := by
  unfold unsigned_sign_bit_extract_before unsigned_sign_bit_extract_combined
  simp_alive_peephole
  sorry
def unsigned_sign_bit_extract_extrause_combined := [llvmfunc|
  llvm.func @unsigned_sign_bit_extract_extrause(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_unsigned_sign_bit_extract_extrause   : unsigned_sign_bit_extract_extrause_before  ⊑  unsigned_sign_bit_extract_extrause_combined := by
  unfold unsigned_sign_bit_extract_extrause_before unsigned_sign_bit_extract_extrause_combined
  simp_alive_peephole
  sorry
def unsigned_sign_bit_extract_extrause__ispositive_combined := [llvmfunc|
  llvm.func @unsigned_sign_bit_extract_extrause__ispositive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_unsigned_sign_bit_extract_extrause__ispositive   : unsigned_sign_bit_extract_extrause__ispositive_before  ⊑  unsigned_sign_bit_extract_extrause__ispositive_combined := by
  unfold unsigned_sign_bit_extract_extrause__ispositive_before unsigned_sign_bit_extract_extrause__ispositive_combined
  simp_alive_peephole
  sorry
def signed_sign_bit_extract_combined := [llvmfunc|
  llvm.func @signed_sign_bit_extract(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_signed_sign_bit_extract   : signed_sign_bit_extract_before  ⊑  signed_sign_bit_extract_combined := by
  unfold signed_sign_bit_extract_before signed_sign_bit_extract_combined
  simp_alive_peephole
  sorry
def signed_sign_bit_extract_extrause_combined := [llvmfunc|
  llvm.func @signed_sign_bit_extract_extrause(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_signed_sign_bit_extract_extrause   : signed_sign_bit_extract_extrause_before  ⊑  signed_sign_bit_extract_extrause_combined := by
  unfold signed_sign_bit_extract_extrause_before signed_sign_bit_extract_extrause_combined
  simp_alive_peephole
  sorry
def unsigned_sign_bit_extract_with_trunc_combined := [llvmfunc|
  llvm.func @unsigned_sign_bit_extract_with_trunc(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_unsigned_sign_bit_extract_with_trunc   : unsigned_sign_bit_extract_with_trunc_before  ⊑  unsigned_sign_bit_extract_with_trunc_combined := by
  unfold unsigned_sign_bit_extract_with_trunc_before unsigned_sign_bit_extract_with_trunc_combined
  simp_alive_peephole
  sorry
def unsigned_sign_bit_extract_with_trunc_extrause_combined := [llvmfunc|
  llvm.func @unsigned_sign_bit_extract_with_trunc_extrause(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.trunc %2 : i64 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "slt" %arg0, %1 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_unsigned_sign_bit_extract_with_trunc_extrause   : unsigned_sign_bit_extract_with_trunc_extrause_before  ⊑  unsigned_sign_bit_extract_with_trunc_extrause_combined := by
  unfold unsigned_sign_bit_extract_with_trunc_extrause_before unsigned_sign_bit_extract_with_trunc_extrause_combined
  simp_alive_peephole
  sorry
def signed_sign_bit_extract_trunc_combined := [llvmfunc|
  llvm.func @signed_sign_bit_extract_trunc(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_signed_sign_bit_extract_trunc   : signed_sign_bit_extract_trunc_before  ⊑  signed_sign_bit_extract_trunc_combined := by
  unfold signed_sign_bit_extract_trunc_before signed_sign_bit_extract_trunc_combined
  simp_alive_peephole
  sorry
def signed_sign_bit_extract_trunc_extrause_combined := [llvmfunc|
  llvm.func @signed_sign_bit_extract_trunc_extrause(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.trunc %2 : i64 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "slt" %arg0, %1 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_signed_sign_bit_extract_trunc_extrause   : signed_sign_bit_extract_trunc_extrause_before  ⊑  signed_sign_bit_extract_trunc_extrause_combined := by
  unfold signed_sign_bit_extract_trunc_extrause_before signed_sign_bit_extract_trunc_extrause_combined
  simp_alive_peephole
  sorry
