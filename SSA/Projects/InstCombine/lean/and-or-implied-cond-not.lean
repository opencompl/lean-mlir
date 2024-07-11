import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and-or-implied-cond-not
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_imply_not1_before := [llvmfunc|
  llvm.func @test_imply_not1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.xor %3, %2  : i1
    %6 = llvm.or %4, %5  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  }]

def test_imply_not2_before := [llvmfunc|
  llvm.func @test_imply_not2(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %1 : i1, i1
    %5 = llvm.xor %3, %2  : i1
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }]

def test_imply_not3_before := [llvmfunc|
  llvm.func @test_imply_not3(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    %4 = llvm.xor %2, %0  : i1
    %5 = llvm.select %4, %arg2, %1 : i1, i1
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def test_imply_not1_combined := [llvmfunc|
  llvm.func @test_imply_not1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.xor %3, %2  : i1
    %6 = llvm.or %4, %5  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  }]

theorem inst_combine_test_imply_not1   : test_imply_not1_before  ⊑  test_imply_not1_combined := by
  unfold test_imply_not1_before test_imply_not1_combined
  simp_alive_peephole
  sorry
def test_imply_not2_combined := [llvmfunc|
  llvm.func @test_imply_not2(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %1 : i1, i1
    %5 = llvm.xor %3, %2  : i1
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_test_imply_not2   : test_imply_not2_before  ⊑  test_imply_not2_combined := by
  unfold test_imply_not2_before test_imply_not2_combined
  simp_alive_peephole
  sorry
def test_imply_not3_combined := [llvmfunc|
  llvm.func @test_imply_not3(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    %4 = llvm.xor %2, %0  : i1
    %5 = llvm.select %4, %arg2, %1 : i1, i1
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_test_imply_not3   : test_imply_not3_before  ⊑  test_imply_not3_combined := by
  unfold test_imply_not3_before test_imply_not3_combined
  simp_alive_peephole
  sorry
