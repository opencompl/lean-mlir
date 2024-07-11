import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  call-undef
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1() {
    %0 = llvm.mlir.undef : i32
    llvm.call @c(%0) : (i32) -> ()
    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() {
    %0 = llvm.mlir.poison : i32
    llvm.call @c(%0) : (i32) -> ()
    llvm.return
  }]

def test3_before := [llvmfunc|
  llvm.func @test3() {
    %0 = llvm.mlir.undef : i32
    llvm.call @e(%0) : (i32) -> ()
    llvm.return
  }]

def test4_before := [llvmfunc|
  llvm.func @test4() {
    %0 = llvm.mlir.poison : i32
    llvm.call @e(%0) : (i32) -> ()
    llvm.return
  }]

def test5_before := [llvmfunc|
  llvm.func @test5() {
    %0 = llvm.mlir.undef : !llvm.ptr
    llvm.call @d(%0) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test6_before := [llvmfunc|
  llvm.func @test6() {
    %0 = llvm.mlir.poison : !llvm.ptr
    llvm.call @d(%0) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test7_before := [llvmfunc|
  llvm.func @test7() {
    %0 = llvm.mlir.undef : !llvm.ptr
    llvm.call @f(%0) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test8_before := [llvmfunc|
  llvm.func @test8() {
    %0 = llvm.mlir.poison : !llvm.ptr
    llvm.call @f(%0) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test_mismatched_call_before := [llvmfunc|
  llvm.func @test_mismatched_call() {
    %0 = llvm.mlir.addressof @e : !llvm.ptr
    %1 = llvm.mlir.poison : i8
    llvm.call %0(%1) : !llvm.ptr, (i8) -> ()
    llvm.return
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1() {
    %0 = llvm.mlir.undef : i32
    llvm.call @c(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() {
    %0 = llvm.mlir.poison : i32
    llvm.call @c(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3() {
    %0 = llvm.mlir.undef : i32
    llvm.call @e(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4() {
    %0 = llvm.mlir.poison : i32
    llvm.call @e(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5() {
    %0 = llvm.mlir.undef : !llvm.ptr
    llvm.call @d(%0) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6() {
    %0 = llvm.mlir.poison : !llvm.ptr
    llvm.call @d(%0) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7() {
    %0 = llvm.mlir.undef : !llvm.ptr
    llvm.call @f(%0) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8() {
    %0 = llvm.mlir.poison : !llvm.ptr
    llvm.call @f(%0) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test_mismatched_call_combined := [llvmfunc|
  llvm.func @test_mismatched_call() {
    %0 = llvm.mlir.addressof @e : !llvm.ptr
    %1 = llvm.mlir.poison : i8
    llvm.call %0(%1) : !llvm.ptr, (i8) -> ()
    llvm.return
  }]

theorem inst_combine_test_mismatched_call   : test_mismatched_call_before  ⊑  test_mismatched_call_combined := by
  unfold test_mismatched_call_before test_mismatched_call_combined
  simp_alive_peephole
  sorry
