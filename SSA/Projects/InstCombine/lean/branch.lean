import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  branch
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.cond_br %1, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    llvm.return %arg0 : i32
  }]

def pat_before := [llvmfunc|
  llvm.func @pat(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(27 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.addressof @global : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    %4 = llvm.icmp "eq" %0, %3 : i32
    llvm.cond_br %4, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    llvm.return %arg0 : i32
  }]

def test01_before := [llvmfunc|
  llvm.func @test01(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i1)
  ^bb3(%2: i1):  // 2 preds: ^bb1, ^bb2
    llvm.cond_br %2, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    llvm.br ^bb6(%1 : i1)
  ^bb5:  // pred: ^bb3
    llvm.br ^bb6(%0 : i1)
  ^bb6(%3: i1):  // 2 preds: ^bb4, ^bb5
    llvm.return %3 : i1
  }]

def test02_before := [llvmfunc|
  llvm.func @test02(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i1)
  ^bb3(%2: i1):  // 2 preds: ^bb1, ^bb2
    llvm.cond_br %2, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    llvm.br ^bb6(%1 : i1)
  ^bb5:  // pred: ^bb3
    llvm.br ^bb6(%0 : i1)
  ^bb6(%3: i1):  // 2 preds: ^bb4, ^bb5
    llvm.return %3 : i1
  }]

def logical_and_not_before := [llvmfunc|
  llvm.func @logical_and_not(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.xor %arg1, %0  : i1
    %5 = llvm.select %arg0, %4, %1 : i1, i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

def logical_and_or_before := [llvmfunc|
  llvm.func @logical_and_or(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

def logical_or_not_before := [llvmfunc|
  llvm.func @logical_or_not(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %0, %arg1 : i1, i1
    llvm.cond_br %4, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

def logical_and_not_use1_before := [llvmfunc|
  llvm.func @logical_and_not_use1(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.select %arg0, %4, %1 : i1, i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

def logical_and_not_use2_before := [llvmfunc|
  llvm.func @logical_and_not_use2(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.xor %arg1, %0  : i1
    %5 = llvm.select %arg0, %4, %1 : i1, i1
    llvm.call @use(%5) : (i1) -> ()
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %0, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def pat_combined := [llvmfunc|
  llvm.func @pat(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %0, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    llvm.return %arg0 : i32
  }]

theorem inst_combine_pat   : pat_before  ⊑  pat_combined := by
  unfold pat_before pat_combined
  simp_alive_peephole
  sorry
def test01_combined := [llvmfunc|
  llvm.func @test01(%arg0: i1) -> i1 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.cond_br %arg0, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    llvm.br ^bb6
  ^bb5:  // pred: ^bb3
    llvm.br ^bb6
  ^bb6:  // 2 preds: ^bb4, ^bb5
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test01   : test01_before  ⊑  test01_combined := by
  unfold test01_before test01_combined
  simp_alive_peephole
  sorry
def test02_combined := [llvmfunc|
  llvm.func @test02(%arg0: i1) -> i1 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.cond_br %arg0, ^bb5, ^bb4
  ^bb4:  // pred: ^bb3
    llvm.br ^bb6
  ^bb5:  // pred: ^bb3
    llvm.br ^bb6
  ^bb6:  // 2 preds: ^bb4, ^bb5
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test02   : test02_before  ⊑  test02_combined := by
  unfold test02_before test02_combined
  simp_alive_peephole
  sorry
def logical_and_not_combined := [llvmfunc|
  llvm.func @logical_and_not(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %0, %arg1 : i1, i1
    llvm.cond_br %4, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

theorem inst_combine_logical_and_not   : logical_and_not_before  ⊑  logical_and_not_combined := by
  unfold logical_and_not_before logical_and_not_combined
  simp_alive_peephole
  sorry
def logical_and_or_combined := [llvmfunc|
  llvm.func @logical_and_or(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %0, %arg1 : i1, i1
    llvm.cond_br %4, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

theorem inst_combine_logical_and_or   : logical_and_or_before  ⊑  logical_and_or_combined := by
  unfold logical_and_or_before logical_and_or_combined
  simp_alive_peephole
  sorry
def logical_or_not_combined := [llvmfunc|
  llvm.func @logical_or_not(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %0, %arg1 : i1, i1
    llvm.cond_br %4, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

theorem inst_combine_logical_or_not   : logical_or_not_before  ⊑  logical_or_not_combined := by
  unfold logical_or_not_before logical_or_not_combined
  simp_alive_peephole
  sorry
def logical_and_not_use1_combined := [llvmfunc|
  llvm.func @logical_and_not_use1(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.xor %arg1, %0  : i1
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.select %arg0, %4, %1 : i1, i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

theorem inst_combine_logical_and_not_use1   : logical_and_not_use1_before  ⊑  logical_and_not_use1_combined := by
  unfold logical_and_not_use1_before logical_and_not_use1_combined
  simp_alive_peephole
  sorry
def logical_and_not_use2_combined := [llvmfunc|
  llvm.func @logical_and_not_use2(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.xor %arg1, %0  : i1
    %5 = llvm.select %arg0, %4, %1 : i1, i1
    llvm.call @use(%5) : (i1) -> ()
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i32
  }]

theorem inst_combine_logical_and_not_use2   : logical_and_not_use2_before  ⊑  logical_and_not_use2_combined := by
  unfold logical_and_not_use2_before logical_and_not_use2_combined
  simp_alive_peephole
  sorry
