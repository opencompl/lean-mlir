import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cast-call-combine-prof
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_call_before := [llvmfunc|
  llvm.func @test_call() {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.call @foo(%0) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test_invoke_before := [llvmfunc|
  llvm.func @test_invoke() attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.array<0 x ptr>
    llvm.invoke @foo(%0) to ^bb1 unwind ^bb2 : (!llvm.ptr) -> ()
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %2 = llvm.landingpad (filter %1 : !llvm.array<0 x ptr>) : !llvm.struct<(ptr, i32)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(ptr, i32)> 
    llvm.call @__cxa_call_unexpected(%3) : (!llvm.ptr) -> ()
    llvm.unreachable
  }]

def test_call_combined := [llvmfunc|
  llvm.func @test_call() {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.call @foo(%0) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test_call   : test_call_before  ⊑  test_call_combined := by
  unfold test_call_before test_call_combined
  simp_alive_peephole
  sorry
def test_invoke_combined := [llvmfunc|
  llvm.func @test_invoke() attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.array<0 x ptr>
    llvm.invoke @foo(%0) to ^bb1 unwind ^bb2 : (!llvm.ptr) -> ()
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %2 = llvm.landingpad (filter %1 : !llvm.array<0 x ptr>) : !llvm.struct<(ptr, i32)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(ptr, i32)> 
    llvm.call @__cxa_call_unexpected(%3) : (!llvm.ptr) -> ()
    llvm.unreachable
  }]

theorem inst_combine_test_invoke   : test_invoke_before  ⊑  test_invoke_combined := by
  unfold test_invoke_before test_invoke_combined
  simp_alive_peephole
  sorry
