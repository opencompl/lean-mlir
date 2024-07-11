import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bcopy
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bcopy_memmove_before := [llvmfunc|
  llvm.func @bcopy_memmove(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture}) {
    %0 = llvm.mlir.constant(8 : i32) : i32
    llvm.call @bcopy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }]

def bcopy_memmove2_before := [llvmfunc|
  llvm.func @bcopy_memmove2(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture}, %arg2: i32) {
    llvm.call @bcopy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }]

def bcopy_memmove_combined := [llvmfunc|
  llvm.func @bcopy_memmove(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture}) {
    %0 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i64]

theorem inst_combine_bcopy_memmove   : bcopy_memmove_before  ⊑  bcopy_memmove_combined := by
  unfold bcopy_memmove_before bcopy_memmove_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %arg1 {alignment = 1 : i64} : i64, !llvm.ptr]

theorem inst_combine_bcopy_memmove   : bcopy_memmove_before  ⊑  bcopy_memmove_combined := by
  unfold bcopy_memmove_before bcopy_memmove_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bcopy_memmove   : bcopy_memmove_before  ⊑  bcopy_memmove_combined := by
  unfold bcopy_memmove_before bcopy_memmove_combined
  simp_alive_peephole
  sorry
def bcopy_memmove2_combined := [llvmfunc|
  llvm.func @bcopy_memmove2(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture}, %arg2: i32) {
    "llvm.intr.memmove"(%arg1, %arg0, %arg2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

theorem inst_combine_bcopy_memmove2   : bcopy_memmove2_before  ⊑  bcopy_memmove2_combined := by
  unfold bcopy_memmove2_before bcopy_memmove2_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bcopy_memmove2   : bcopy_memmove2_before  ⊑  bcopy_memmove2_combined := by
  unfold bcopy_memmove2_before bcopy_memmove2_combined
  simp_alive_peephole
  sorry
