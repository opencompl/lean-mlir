import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr77064
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(596 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.call fastcc @opendir(%arg0) : (!llvm.ptr) -> !llvm.ptr
    %4 = llvm.call @__memset_chk(%3, %0, %1, %2) : (!llvm.ptr, i32, i64, i64) -> !llvm.ptr
    llvm.return
  }]

def main_combined := [llvmfunc|
  llvm.func @main(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(596 : i64) : i64
    %2 = llvm.call fastcc @opendir(%arg0) : (!llvm.ptr) -> !llvm.ptr
    "llvm.intr.memset"(%2, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
