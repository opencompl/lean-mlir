
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
section gshifthflags_statements

def shl_add_nuw_before := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(63 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.and %arg16, %0 : i8
  %3 = llvm.and %arg17, %1 : i8
  %4 = llvm.shl %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_add_nuw_after := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(63 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.and %arg16, %0 : i8
  %3 = llvm.and %arg17, %1 : i8
  %4 = llvm.shl %2, %3 overflow<nuw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_nuw_proof : shl_add_nuw_before ⊑ shl_add_nuw_after := by
  unfold shl_add_nuw_before shl_add_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_add_nuw



def shl_add_nuw_and_nsw_before := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.and %arg12, %0 : i8
  %3 = llvm.and %arg13, %1 : i8
  %4 = llvm.shl %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_add_nuw_and_nsw_after := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.and %arg12, %0 : i8
  %3 = llvm.and %arg13, %1 : i8
  %4 = llvm.shl %2, %3 overflow<nsw,nuw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_nuw_and_nsw_proof : shl_add_nuw_and_nsw_before ⊑ shl_add_nuw_and_nsw_after := by
  unfold shl_add_nuw_and_nsw_before shl_add_nuw_and_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_nuw_and_nsw
  all_goals (try extract_goal ; sorry)
  ---END shl_add_nuw_and_nsw



def shl_add_nsw_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(-32 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.or %arg10, %0 : i8
  %3 = llvm.and %arg11, %1 : i8
  %4 = llvm.shl %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_add_nsw_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(-32 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.or %arg10, %0 : i8
  %3 = llvm.and %arg11, %1 : i8
  %4 = llvm.shl %2, %3 overflow<nsw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_nsw_proof : shl_add_nsw_before ⊑ shl_add_nsw_after := by
  unfold shl_add_nsw_before shl_add_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_nsw
  all_goals (try extract_goal ; sorry)
  ---END shl_add_nsw



def lshr_add_exact_before := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(-4 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.and %arg6, %0 : i8
  %3 = llvm.and %arg7, %1 : i8
  %4 = llvm.lshr %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def lshr_add_exact_after := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(-4 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.and %arg6, %0 : i8
  %3 = llvm.and %arg7, %1 : i8
  %4 = llvm.lshr exact %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_add_exact_proof : lshr_add_exact_before ⊑ lshr_add_exact_after := by
  unfold lshr_add_exact_before lshr_add_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_add_exact
  all_goals (try extract_goal ; sorry)
  ---END lshr_add_exact



def ashr_add_exact_before := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(-14 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.and %arg2, %0 : i8
  %3 = llvm.and %arg3, %1 : i8
  %4 = llvm.ashr %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def ashr_add_exact_after := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(-14 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.and %arg2, %0 : i8
  %3 = llvm.and %arg3, %1 : i8
  %4 = llvm.ashr exact %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_add_exact_proof : ashr_add_exact_before ⊑ ashr_add_exact_after := by
  unfold ashr_add_exact_before ashr_add_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_add_exact
  all_goals (try extract_goal ; sorry)
  ---END ashr_add_exact


