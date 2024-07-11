import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  known-signbit-shift
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_shift_nonnegative_before := [llvmfunc|
  llvm.func @test_shift_nonnegative(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw>  : i32
    %5 = llvm.icmp "sge" %4, %2 : i32
    llvm.return %5 : i1
  }]

def test_shift_negative_before := [llvmfunc|
  llvm.func @test_shift_negative(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.shl %3, %4 overflow<nsw>  : i32
    %6 = llvm.icmp "slt" %5, %2 : i32
    llvm.return %6 : i1
  }]

def test_no_sign_bit_conflict1_before := [llvmfunc|
  llvm.func @test_no_sign_bit_conflict1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(8193 : i32) : i32
    %1 = llvm.mlir.constant(8192 : i32) : i32
    %2 = llvm.mlir.constant(18 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.shl %3, %2 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

def test_no_sign_bit_conflict2_before := [llvmfunc|
  llvm.func @test_no_sign_bit_conflict2(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(-8193 : i32) : i32
    %1 = llvm.mlir.constant(-8194 : i32) : i32
    %2 = llvm.mlir.constant(18 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.shl %3, %2 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

def test_shift_nonnegative_combined := [llvmfunc|
  llvm.func @test_shift_nonnegative(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_shift_nonnegative   : test_shift_nonnegative_before  ⊑  test_shift_nonnegative_combined := by
  unfold test_shift_nonnegative_before test_shift_nonnegative_combined
  simp_alive_peephole
  sorry
def test_shift_negative_combined := [llvmfunc|
  llvm.func @test_shift_negative(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_shift_negative   : test_shift_negative_before  ⊑  test_shift_negative_combined := by
  unfold test_shift_negative_before test_shift_negative_combined
  simp_alive_peephole
  sorry
def test_no_sign_bit_conflict1_combined := [llvmfunc|
  llvm.func @test_no_sign_bit_conflict1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.poison : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_no_sign_bit_conflict1   : test_no_sign_bit_conflict1_before  ⊑  test_no_sign_bit_conflict1_combined := by
  unfold test_no_sign_bit_conflict1_before test_no_sign_bit_conflict1_combined
  simp_alive_peephole
  sorry
def test_no_sign_bit_conflict2_combined := [llvmfunc|
  llvm.func @test_no_sign_bit_conflict2(%arg0: i1) -> i32 {
    %0 = llvm.mlir.poison : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_no_sign_bit_conflict2   : test_no_sign_bit_conflict2_before  ⊑  test_no_sign_bit_conflict2_combined := by
  unfold test_no_sign_bit_conflict2_before test_no_sign_bit_conflict2_combined
  simp_alive_peephole
  sorry
