import SSA.Projects.InstCombine.tests.proofs.gcanonicalizehconstanthlowhbithmaskhandhicmphsgehtohicmphsle_proof
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
section gcanonicalizehconstanthlowhbithmaskhandhicmphsgehtohicmphsle_statements

def p0_before := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.and %arg17, %0 : i8
  %2 = llvm.icmp "sge" %1, %arg17 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def p0_after := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "slt" %arg17, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p0_proof : p0_before ⊑ p0_after := by
  unfold p0_before p0_after
  simp_alive_peephole
  intros
  ---BEGIN p0
  apply p0_thm
  ---END p0


