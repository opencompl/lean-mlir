import SSA.Projects.InstCombine.tests.proofs.gannotations_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

open MLIR AST
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
section gannotations_statements

def do_not_add_annotation_to_existing_instr_before := [llvm|
{
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.add %arg15, %arg16 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def do_not_add_annotation_to_existing_instr_after := [llvm|
{
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.add %arg15, %arg16 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem do_not_add_annotation_to_existing_instr_proof : do_not_add_annotation_to_existing_instr_before ⊑ do_not_add_annotation_to_existing_instr_after := by
  unfold do_not_add_annotation_to_existing_instr_before do_not_add_annotation_to_existing_instr_after
  simp_alive_peephole
  intros
  ---BEGIN do_not_add_annotation_to_existing_instr
  apply do_not_add_annotation_to_existing_instr_thm
  ---END do_not_add_annotation_to_existing_instr


