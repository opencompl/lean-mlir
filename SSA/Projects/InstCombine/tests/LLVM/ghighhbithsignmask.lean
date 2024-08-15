import SSA.Projects.InstCombine.tests.LLVM.ghighhbithsignmask_proof
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
                                                                       
def t0_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 63 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
  %2 = llvm.lshr %arg0, %0 : i64
  %3 = llvm.sub %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 63 : i64}> : () -> i64
  %1 = llvm.ashr %arg0, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t0
  apply t0_thm
  ---END t0



def t0_exact_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 63 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
  %2 = llvm.lshr %arg0, %0 : i64
  %3 = llvm.sub %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def t0_exact_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 63 : i64}> : () -> i64
  %1 = llvm.ashr %arg0, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem t0_exact_proof : t0_exact_before ⊑ t0_exact_after := by
  unfold t0_exact_before t0_exact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t0_exact
  apply t0_exact_thm
  ---END t0_exact



def t2_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 63 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
  %2 = llvm.ashr %arg0, %0 : i64
  %3 = llvm.sub %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def t2_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 63 : i64}> : () -> i64
  %1 = llvm.lshr %arg0, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem t2_proof : t2_before ⊑ t2_after := by
  unfold t2_before t2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t2
  apply t2_thm
  ---END t2



def t3_exact_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 63 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
  %2 = llvm.ashr %arg0, %0 : i64
  %3 = llvm.sub %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def t3_exact_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 63 : i64}> : () -> i64
  %1 = llvm.lshr %arg0, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem t3_exact_proof : t3_exact_before ⊑ t3_exact_after := by
  unfold t3_exact_before t3_exact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN t3_exact
  apply t3_exact_thm
  ---END t3_exact


