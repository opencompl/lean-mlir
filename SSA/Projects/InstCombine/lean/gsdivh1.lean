import SSA.Projects.InstCombine.lean.gsdivh1_proof
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
                                                                       
def c_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2147483648 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -3 : i32}> : () -> i32
  %3 = llvm.sub %0, %1 : i32
  %4 = llvm.sdiv %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def c_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 715827882 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem c_proof : c_before ⊑ c_after := by
  unfold c_before c_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN c
  all_goals (try extract_goal ; sorry)
  ---END c


