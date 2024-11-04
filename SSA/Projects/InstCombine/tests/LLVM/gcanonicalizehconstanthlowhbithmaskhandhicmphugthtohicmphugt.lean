
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
section gcanonicalizehconstanthlowhbithmaskhandhicmphugthtohicmphugt_statements

def c0_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.and %arg6, %0 : i8
  %2 = llvm.icmp "ugt" %1, %arg6 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def c0_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
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



def cv2_before := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.lshr %0, %arg3 : i8
  %2 = llvm.and %1, %arg2 : i8
  %3 = llvm.icmp "ugt" %2, %arg2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def cv2_after := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem cv2_proof : cv2_before ⊑ cv2_after := by
  unfold cv2_before cv2_after
  simp_alive_peephole
  intros
  ---BEGIN cv2
  all_goals (try extract_goal ; sorry)
  ---END cv2


