import SSA.Projects.InstCombine.lean.gannotations_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def do_not_add_annotation_to_existing_instr_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = llvm.add %arg0, %arg1 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def do_not_add_annotation_to_existing_instr_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem do_not_add_annotation_to_existing_instr_proof : do_not_add_annotation_to_existing_instr_before ⊑ do_not_add_annotation_to_existing_instr_after := by
  unfold do_not_add_annotation_to_existing_instr_before do_not_add_annotation_to_existing_instr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN do_not_add_annotation_to_existing_instr
  all_goals (try extract_goal ; sorry)
  ---END do_not_add_annotation_to_existing_instr


