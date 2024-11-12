
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
section gbinophofhdisplacedhshifts_statements

def shl_or_before := [llvm|
{
^0(%arg25 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(3 : i8) : i8
  %3 = llvm.shl %0, %arg25 : i8
  %4 = llvm.add %arg25, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.or %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_or_after := [llvm|
{
^0(%arg25 : i8):
  %0 = llvm.mlir.constant(22 : i8) : i8
  %1 = llvm.shl %0, %arg25 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_or_proof : shl_or_before ⊑ shl_or_after := by
  unfold shl_or_before shl_or_after
  simp_alive_peephole
  intros
  ---BEGIN shl_or
  all_goals (try extract_goal ; sorry)
  ---END shl_or



def lshr_or_before := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(3 : i8) : i8
  %3 = llvm.lshr %0, %arg24 : i8
  %4 = llvm.add %arg24, %1 : i8
  %5 = llvm.lshr %2, %4 : i8
  %6 = llvm.or %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def lshr_or_after := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(17 : i8) : i8
  %1 = llvm.lshr %0, %arg24 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_or_proof : lshr_or_before ⊑ lshr_or_after := by
  unfold lshr_or_before lshr_or_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_or
  all_goals (try extract_goal ; sorry)
  ---END lshr_or



def ashr_or_before := [llvm|
{
^0(%arg23 : i8):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(-128 : i8) : i8
  %3 = llvm.ashr %0, %arg23 : i8
  %4 = llvm.add %arg23, %1 : i8
  %5 = llvm.ashr %2, %4 : i8
  %6 = llvm.or %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def ashr_or_after := [llvm|
{
^0(%arg23 : i8):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.ashr %0, %arg23 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_or_proof : ashr_or_before ⊑ ashr_or_after := by
  unfold ashr_or_before ashr_or_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_or
  all_goals (try extract_goal ; sorry)
  ---END ashr_or



def shl_xor_before := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(3 : i8) : i8
  %3 = llvm.shl %0, %arg22 : i8
  %4 = llvm.add %arg22, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.xor %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_xor_after := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(22 : i8) : i8
  %1 = llvm.shl %0, %arg22 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_xor_proof : shl_xor_before ⊑ shl_xor_after := by
  unfold shl_xor_before shl_xor_after
  simp_alive_peephole
  intros
  ---BEGIN shl_xor
  all_goals (try extract_goal ; sorry)
  ---END shl_xor



def lshr_xor_before := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(3 : i8) : i8
  %3 = llvm.lshr %0, %arg21 : i8
  %4 = llvm.add %arg21, %1 : i8
  %5 = llvm.lshr %2, %4 : i8
  %6 = llvm.xor %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def lshr_xor_after := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(17 : i8) : i8
  %1 = llvm.lshr %0, %arg21 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_xor_proof : lshr_xor_before ⊑ lshr_xor_after := by
  unfold lshr_xor_before lshr_xor_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_xor
  all_goals (try extract_goal ; sorry)
  ---END lshr_xor



def ashr_xor_before := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(-64 : i8) : i8
  %3 = llvm.ashr %0, %arg20 : i8
  %4 = llvm.add %arg20, %1 : i8
  %5 = llvm.ashr %2, %4 : i8
  %6 = llvm.xor %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def ashr_xor_after := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(96 : i8) : i8
  %1 = llvm.lshr %0, %arg20 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_xor_proof : ashr_xor_before ⊑ ashr_xor_after := by
  unfold ashr_xor_before ashr_xor_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_xor
  all_goals (try extract_goal ; sorry)
  ---END ashr_xor



def shl_and_before := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(48 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(8 : i8) : i8
  %3 = llvm.shl %0, %arg19 : i8
  %4 = llvm.add %arg19, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.and %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_and_after := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.shl %0, %arg19 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_and_proof : shl_and_before ⊑ shl_and_after := by
  unfold shl_and_before shl_and_after
  simp_alive_peephole
  intros
  ---BEGIN shl_and
  all_goals (try extract_goal ; sorry)
  ---END shl_and



def lshr_and_before := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(48 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(64 : i8) : i8
  %3 = llvm.lshr %0, %arg18 : i8
  %4 = llvm.add %arg18, %1 : i8
  %5 = llvm.lshr %2, %4 : i8
  %6 = llvm.and %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def lshr_and_after := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(32 : i8) : i8
  %1 = llvm.lshr %0, %arg18 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_and_proof : lshr_and_before ⊑ lshr_and_after := by
  unfold lshr_and_before lshr_and_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_and
  all_goals (try extract_goal ; sorry)
  ---END lshr_and



def ashr_and_before := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(-128 : i8) : i8
  %3 = llvm.ashr %0, %arg17 : i8
  %4 = llvm.add %arg17, %1 : i8
  %5 = llvm.ashr %2, %4 : i8
  %6 = llvm.and %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def ashr_and_after := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.ashr %0, %arg17 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_and_proof : ashr_and_before ⊑ ashr_and_after := by
  unfold ashr_and_before ashr_and_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_and
  all_goals (try extract_goal ; sorry)
  ---END ashr_and



def shl_add_before := [llvm|
{
^0(%arg16 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(7 : i8) : i8
  %3 = llvm.shl %0, %arg16 : i8
  %4 = llvm.add %arg16, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.add %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_add_after := [llvm|
{
^0(%arg16 : i8):
  %0 = llvm.mlir.constant(30 : i8) : i8
  %1 = llvm.shl %0, %arg16 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_proof : shl_add_before ⊑ shl_add_after := by
  unfold shl_add_before shl_add_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add
  all_goals (try extract_goal ; sorry)
  ---END shl_add



def lshr_add_fail_before := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(7 : i8) : i8
  %3 = llvm.lshr %0, %arg15 : i8
  %4 = llvm.add %arg15, %1 : i8
  %5 = llvm.lshr %2, %4 : i8
  %6 = llvm.add %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def lshr_add_fail_after := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(7 : i8) : i8
  %3 = llvm.lshr %0, %arg15 : i8
  %4 = llvm.add %arg15, %1 : i8
  %5 = llvm.lshr %2, %4 : i8
  %6 = llvm.add %3, %5 overflow<nsw,nuw> : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_add_fail_proof : lshr_add_fail_before ⊑ lshr_add_fail_after := by
  unfold lshr_add_fail_before lshr_add_fail_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_add_fail
  all_goals (try extract_goal ; sorry)
  ---END lshr_add_fail



def ashr_add_fail_before := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.ashr %0, %arg14 : i8
  %3 = llvm.add %arg14, %1 : i8
  %4 = llvm.ashr %0, %3 : i8
  %5 = llvm.add %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def ashr_add_fail_after := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.ashr exact %0, %arg14 : i8
  %3 = llvm.add %arg14, %1 : i8
  %4 = llvm.ashr exact %0, %3 : i8
  %5 = llvm.add %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_add_fail_proof : ashr_add_fail_before ⊑ ashr_add_fail_after := by
  unfold ashr_add_fail_before ashr_add_fail_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_add_fail
  all_goals (try extract_goal ; sorry)
  ---END ashr_add_fail



def shl_or_commuted_before := [llvm|
{
^0(%arg13 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(3 : i8) : i8
  %3 = llvm.shl %0, %arg13 : i8
  %4 = llvm.add %arg13, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.or %5, %3 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_or_commuted_after := [llvm|
{
^0(%arg13 : i8):
  %0 = llvm.mlir.constant(22 : i8) : i8
  %1 = llvm.shl %0, %arg13 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_or_commuted_proof : shl_or_commuted_before ⊑ shl_or_commuted_after := by
  unfold shl_or_commuted_before shl_or_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN shl_or_commuted
  all_goals (try extract_goal ; sorry)
  ---END shl_or_commuted



def mismatched_shifts_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(3 : i8) : i8
  %3 = llvm.shl %0, %arg6 : i8
  %4 = llvm.add %arg6, %1 : i8
  %5 = llvm.lshr %2, %4 : i8
  %6 = llvm.or %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def mismatched_shifts_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(3 : i8) : i8
  %3 = llvm.shl %0, %arg6 : i8
  %4 = llvm.add %arg6, %1 : i8
  %5 = llvm.lshr %2, %4 : i8
  %6 = llvm.or disjoint %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mismatched_shifts_proof : mismatched_shifts_before ⊑ mismatched_shifts_after := by
  unfold mismatched_shifts_before mismatched_shifts_after
  simp_alive_peephole
  intros
  ---BEGIN mismatched_shifts
  all_goals (try extract_goal ; sorry)
  ---END mismatched_shifts



def shl_or_with_or_disjoint_instead_of_add_before := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(16 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(3 : i8) : i8
  %3 = llvm.shl %0, %arg1 : i8
  %4 = llvm.or disjoint %arg1, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.or %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_or_with_or_disjoint_instead_of_add_after := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(22 : i8) : i8
  %1 = llvm.shl %0, %arg1 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_or_with_or_disjoint_instead_of_add_proof : shl_or_with_or_disjoint_instead_of_add_before ⊑ shl_or_with_or_disjoint_instead_of_add_after := by
  unfold shl_or_with_or_disjoint_instead_of_add_before shl_or_with_or_disjoint_instead_of_add_after
  simp_alive_peephole
  intros
  ---BEGIN shl_or_with_or_disjoint_instead_of_add
  all_goals (try extract_goal ; sorry)
  ---END shl_or_with_or_disjoint_instead_of_add


