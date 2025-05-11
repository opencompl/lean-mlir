
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
section gcanonicalizehconstanthlowhbithmaskhandhicmphsgthtohicmphsgt_statements

def c0_before := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.and %arg7, %0 : i8
  %2 = llvm.icmp "sgt" %1, %arg7 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def c0_after := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "slt" %arg7, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem c0_proof : c0_before ⊑ c0_after := by
  unfold c0_before c0_after
  simp_alive_peephole
  intros
  ---BEGIN c0
  all_goals (try extract_goal ; sorry)
  ---END c0


