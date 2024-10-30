
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
section ghighhbithsignmask_statements

def t0_before := [llvm|
{
^0(%arg10 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.lshr %arg10, %0 : i64
  %3 = llvm.sub %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg10 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.ashr %arg10, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  ---BEGIN t0
  all_goals (try extract_goal ; sorry)
  ---END t0



def t0_exact_before := [llvm|
{
^0(%arg9 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.lshr %arg9, %0 : i64
  %3 = llvm.sub %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def t0_exact_after := [llvm|
{
^0(%arg9 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.ashr %arg9, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem t0_exact_proof : t0_exact_before ⊑ t0_exact_after := by
  unfold t0_exact_before t0_exact_after
  simp_alive_peephole
  ---BEGIN t0_exact
  all_goals (try extract_goal ; sorry)
  ---END t0_exact



def t2_before := [llvm|
{
^0(%arg8 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.ashr %arg8, %0 : i64
  %3 = llvm.sub %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def t2_after := [llvm|
{
^0(%arg8 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.lshr %arg8, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem t2_proof : t2_before ⊑ t2_after := by
  unfold t2_before t2_after
  simp_alive_peephole
  ---BEGIN t2
  all_goals (try extract_goal ; sorry)
  ---END t2



def t3_exact_before := [llvm|
{
^0(%arg7 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.ashr %arg7, %0 : i64
  %3 = llvm.sub %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def t3_exact_after := [llvm|
{
^0(%arg7 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.lshr %arg7, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem t3_exact_proof : t3_exact_before ⊑ t3_exact_after := by
  unfold t3_exact_before t3_exact_after
  simp_alive_peephole
  ---BEGIN t3_exact
  all_goals (try extract_goal ; sorry)
  ---END t3_exact



def n9_before := [llvm|
{
^0(%arg1 : i64):
  %0 = llvm.mlir.constant(62) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.lshr %arg1, %0 : i64
  %3 = llvm.sub %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def n9_after := [llvm|
{
^0(%arg1 : i64):
  %0 = llvm.mlir.constant(62) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.lshr %arg1, %0 : i64
  %3 = llvm.sub %1, %2 overflow<nsw> : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
theorem n9_proof : n9_before ⊑ n9_after := by
  unfold n9_before n9_after
  simp_alive_peephole
  ---BEGIN n9
  all_goals (try extract_goal ; sorry)
  ---END n9


