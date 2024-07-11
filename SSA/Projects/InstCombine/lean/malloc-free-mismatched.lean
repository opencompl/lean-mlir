import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  malloc-free-mismatched
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _Z6answeri_before := [llvmfunc|
  llvm.func @_Z6answeri(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(80 : i64) : i64
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.call @free(%2) : (!llvm.ptr) -> ()
    llvm.return %1 : i32
  }]

def test_alloca_before := [llvmfunc|
  llvm.func @test_alloca() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.call @free(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def _Z6answeri_combined := [llvmfunc|
  llvm.func @_Z6answeri(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(80 : i64) : i64
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.call @free(%2) : (!llvm.ptr) -> ()
    llvm.return %1 : i32
  }]

theorem inst_combine__Z6answeri   : _Z6answeri_before  ⊑  _Z6answeri_combined := by
  unfold _Z6answeri_before _Z6answeri_combined
  simp_alive_peephole
  sorry
def test_alloca_combined := [llvmfunc|
  llvm.func @test_alloca() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.call @free(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test_alloca   : test_alloca_before  ⊑  test_alloca_combined := by
  unfold test_alloca_before test_alloca_combined
  simp_alive_peephole
  sorry
