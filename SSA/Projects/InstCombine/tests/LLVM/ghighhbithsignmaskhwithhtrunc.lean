
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
section ghighhbithsignmaskhwithhtrunc_statements

def t0_before := [llvm|
{
^0(%arg10 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg10, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.sub %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg10 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.ashr %arg10, %0 : i64
  %2 = llvm.trunc %1 overflow<nsw> : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  intros
  ---BEGIN t0
  all_goals (try extract_goal ; sorry)
  ---END t0



def t1_exact_before := [llvm|
{
^0(%arg9 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr exact %arg9, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.sub %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def t1_exact_after := [llvm|
{
^0(%arg9 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.ashr exact %arg9, %0 : i64
  %2 = llvm.trunc %1 overflow<nsw> : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_exact_proof : t1_exact_before ⊑ t1_exact_after := by
  unfold t1_exact_before t1_exact_after
  simp_alive_peephole
  intros
  ---BEGIN t1_exact
  all_goals (try extract_goal ; sorry)
  ---END t1_exact



def t2_before := [llvm|
{
^0(%arg8 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.ashr %arg8, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.sub %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def t2_after := [llvm|
{
^0(%arg8 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.lshr %arg8, %0 : i64
  %2 = llvm.trunc %1 overflow<nsw,nuw> : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t2_proof : t2_before ⊑ t2_after := by
  unfold t2_before t2_after
  simp_alive_peephole
  intros
  ---BEGIN t2
  all_goals (try extract_goal ; sorry)
  ---END t2



def t3_exact_before := [llvm|
{
^0(%arg7 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.ashr exact %arg7, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.sub %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def t3_exact_after := [llvm|
{
^0(%arg7 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.lshr exact %arg7, %0 : i64
  %2 = llvm.trunc %1 overflow<nsw,nuw> : i64 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t3_exact_proof : t3_exact_before ⊑ t3_exact_after := by
  unfold t3_exact_before t3_exact_after
  simp_alive_peephole
  intros
  ---BEGIN t3_exact
  all_goals (try extract_goal ; sorry)
  ---END t3_exact



def n9_before := [llvm|
{
^0(%arg1 : i64):
  %0 = llvm.mlir.constant(62) : i64
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg1, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.sub %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def n9_after := [llvm|
{
^0(%arg1 : i64):
  %0 = llvm.mlir.constant(62) : i64
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg1, %0 : i64
  %3 = llvm.trunc %2 overflow<nsw,nuw> : i64 to i32
  %4 = llvm.sub %1, %3 overflow<nsw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n9_proof : n9_before ⊑ n9_after := by
  unfold n9_before n9_after
  simp_alive_peephole
  intros
  ---BEGIN n9
  all_goals (try extract_goal ; sorry)
  ---END n9



def n10_before := [llvm|
{
^0(%arg0 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.lshr %arg0, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.sub %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def n10_after := [llvm|
{
^0(%arg0 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.ashr %arg0, %0 : i64
  %3 = llvm.trunc %2 overflow<nsw> : i64 to i32
  %4 = llvm.add %3, %1 overflow<nsw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n10_proof : n10_before ⊑ n10_after := by
  unfold n10_before n10_after
  simp_alive_peephole
  intros
  ---BEGIN n10
  all_goals (try extract_goal ; sorry)
  ---END n10


