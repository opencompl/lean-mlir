
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
section gredundanthrighthshifthinputhmasking_statements

def t0_lshr_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg31 : i32
  %2 = llvm.and %1, %arg30 : i32
  %3 = llvm.lshr %2, %arg31 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def t0_lshr_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg31 overflow<nsw> : i32
  %2 = llvm.and %1, %arg30 : i32
  %3 = llvm.lshr %2, %arg31 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem t0_lshr_proof : t0_lshr_before ⊑ t0_lshr_after := by
  unfold t0_lshr_before t0_lshr_after
  simp_alive_peephole
  ---BEGIN t0_lshr
  all_goals (try extract_goal ; sorry)
  ---END t0_lshr



def t1_sshr_before := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg29 : i32
  %2 = llvm.and %1, %arg28 : i32
  %3 = llvm.ashr %2, %arg29 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def t1_sshr_after := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg29 overflow<nsw> : i32
  %2 = llvm.and %1, %arg28 : i32
  %3 = llvm.ashr %2, %arg29 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem t1_sshr_proof : t1_sshr_before ⊑ t1_sshr_after := by
  unfold t1_sshr_before t1_sshr_after
  simp_alive_peephole
  ---BEGIN t1_sshr
  all_goals (try extract_goal ; sorry)
  ---END t1_sshr



def n13_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32, %arg6 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg5 : i32
  %2 = llvm.and %1, %arg4 : i32
  %3 = llvm.lshr %2, %arg6 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def n13_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32, %arg6 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg5 overflow<nsw> : i32
  %2 = llvm.and %1, %arg4 : i32
  %3 = llvm.lshr %2, %arg6 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem n13_proof : n13_before ⊑ n13_after := by
  unfold n13_before n13_after
  simp_alive_peephole
  ---BEGIN n13
  all_goals (try extract_goal ; sorry)
  ---END n13


