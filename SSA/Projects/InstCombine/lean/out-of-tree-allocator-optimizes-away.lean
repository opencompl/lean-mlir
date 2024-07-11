import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  out-of-tree-allocator-optimizes-away
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def alloc_elides_test_before := [llvmfunc|
  llvm.func @alloc_elides_test(%arg0: i32) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(8 : i64) : i64
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.call @__rust_alloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.store %2, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

    %6 = llvm.call @__rust_realloc(%5, %0, %1, %3) : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr
    llvm.store %4, %6 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.call @__rust_dealloc(%6, %0, %1) : (!llvm.ptr, i64, i64) -> ()
    llvm.return
  }]

def alloc_elides_test_combined := [llvmfunc|
  llvm.func @alloc_elides_test(%arg0: i32) {
    llvm.return
  }]

theorem inst_combine_alloc_elides_test   : alloc_elides_test_before  ⊑  alloc_elides_test_combined := by
  unfold alloc_elides_test_before alloc_elides_test_combined
  simp_alive_peephole
  sorry
