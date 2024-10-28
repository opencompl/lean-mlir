
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
section gbinophselect_statements

def and_sel_op0_before := [llvm|
{
^0(%arg17 : i1):
  %0 = "llvm.mlir.constant"() <{value = 25 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %3 = "llvm.select"(%arg17, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.and %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_sel_op0_after := [llvm|
{
^0(%arg17 : i1):
  %0 = llvm.zext %arg17 : i1 to i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem and_sel_op0_proof : and_sel_op0_before ⊑ and_sel_op0_after := by
  unfold and_sel_op0_before and_sel_op0_after
  simp_alive_peephole
  ---BEGIN and_sel_op0
  all_goals (try extract_goal ; sorry)
  ---END and_sel_op0



def mul_sel_op0_before := [llvm|
{
^0(%arg14 : i1, %arg15 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %2 = llvm.udiv %0, %arg15 : i32
  %3 = "llvm.select"(%arg14, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.mul %3, %arg15 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def mul_sel_op0_after := [llvm|
{
^0(%arg14 : i1, %arg15 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %2 = "llvm.select"(%arg14, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem mul_sel_op0_proof : mul_sel_op0_before ⊑ mul_sel_op0_after := by
  unfold mul_sel_op0_before mul_sel_op0_after
  simp_alive_peephole
  ---BEGIN mul_sel_op0
  all_goals (try extract_goal ; sorry)
  ---END mul_sel_op0



def sub_sel_op1_before := [llvm|
{
^0(%arg11 : i1):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 41 : i32}> : () -> i32
  %2 = "llvm.select"(%arg11, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.sub %0, %2 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sub_sel_op1_after := [llvm|
{
^0(%arg11 : i1):
  %0 = "llvm.mlir.constant"() <{value = true}> : () -> i1
  %1 = llvm.xor %arg11, %0 : i1
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sub_sel_op1_proof : sub_sel_op1_before ⊑ sub_sel_op1_after := by
  unfold sub_sel_op1_before sub_sel_op1_after
  simp_alive_peephole
  ---BEGIN sub_sel_op1
  all_goals (try extract_goal ; sorry)
  ---END sub_sel_op1



def ashr_sel_op1_before := [llvm|
{
^0(%arg1 : i1):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %3 = "llvm.select"(%arg1, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.ashr %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_sel_op1_after := [llvm|
{
^0(%arg1 : i1):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = "llvm.select"(%arg1, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem ashr_sel_op1_proof : ashr_sel_op1_before ⊑ ashr_sel_op1_after := by
  unfold ashr_sel_op1_before ashr_sel_op1_after
  simp_alive_peephole
  ---BEGIN ashr_sel_op1
  all_goals (try extract_goal ; sorry)
  ---END ashr_sel_op1


