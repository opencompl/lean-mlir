import SSA.Projects.InstCombine.tests.proofs.gredundanthrighthshifthinputhmasking_proof
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
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg31 : i32
  %2 = llvm.and %1, %arg30 : i32
  %3 = llvm.lshr exact %2, %arg31 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def t0_lshr_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg31 overflow<nsw> : i32
  %2 = llvm.and %1, %arg30 : i32
  %3 = llvm.lshr exact %2, %arg31 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_lshr_proof : t0_lshr_before ⊑ t0_lshr_after := by
  unfold t0_lshr_before t0_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN t0_lshr
  apply t0_lshr_thm
  ---END t0_lshr



def t1_sshr_before := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg29 : i32
  %2 = llvm.and %1, %arg28 : i32
  %3 = llvm.ashr exact %2, %arg29 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def t1_sshr_after := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg29 overflow<nsw> : i32
  %2 = llvm.and %1, %arg28 : i32
  %3 = llvm.ashr exact %2, %arg29 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_sshr_proof : t1_sshr_before ⊑ t1_sshr_after := by
  unfold t1_sshr_before t1_sshr_after
  simp_alive_peephole
  intros
  ---BEGIN t1_sshr
  apply t1_sshr_thm
  ---END t1_sshr



def n13_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32, %arg6 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg5 : i32
  %2 = llvm.and %1, %arg4 : i32
  %3 = llvm.lshr %2, %arg6 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def n13_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32, %arg6 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg5 overflow<nsw> : i32
  %2 = llvm.and %1, %arg4 : i32
  %3 = llvm.lshr %2, %arg6 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n13_proof : n13_before ⊑ n13_after := by
  unfold n13_before n13_after
  simp_alive_peephole
  intros
  ---BEGIN n13
  apply n13_thm
  ---END n13


