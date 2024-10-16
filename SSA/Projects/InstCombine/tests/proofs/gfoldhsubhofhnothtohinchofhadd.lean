import SSA.Projects.InstCombine.tests.proofs.gfoldhsubhofhnothtohinchofhadd_proof
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
section gfoldhsubhofhnothtohinchofhadd_statements
<<<<<<< HEAD

=======
                                                    
>>>>>>> 43a49182 (re-ran scripts)
def p0_scalar_before := [llvm|
{
^0(%arg14 : i32, %arg15 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg14, %0 : i32
  %2 = llvm.sub %arg15, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def p0_scalar_after := [llvm|
{
^0(%arg14 : i32, %arg15 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.add %arg14, %0 : i32
  %2 = llvm.add %1, %arg15 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem p0_scalar_proof : p0_scalar_before ⊑ p0_scalar_after := by
  unfold p0_scalar_before p0_scalar_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
<<<<<<< HEAD
  try simp
  simp_alive_case_bash
  try intros
=======
  simp_alive_case_bash
  intros
>>>>>>> 43a49182 (re-ran scripts)
  try simp
  ---BEGIN p0_scalar
  apply p0_scalar_thm
  ---END p0_scalar


