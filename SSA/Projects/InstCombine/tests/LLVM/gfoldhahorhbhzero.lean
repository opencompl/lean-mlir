
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
section gfoldhahorhbhzero_statements

def a_or_b_before := [llvm|
{
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg15, %0 : i32
  %2 = llvm.icmp "ne" %arg16, %0 : i32
  %3 = llvm.and %1, %2 : i1
  %4 = llvm.icmp "ne" %arg15, %0 : i32
  %5 = llvm.icmp "eq" %arg16, %0 : i32
  %6 = llvm.and %4, %5 : i1
  %7 = llvm.or %3, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def a_or_b_after := [llvm|
{
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg15, %0 : i32
  %2 = llvm.icmp "eq" %arg16, %0 : i32
  %3 = llvm.xor %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_or_b_proof : a_or_b_before ⊑ a_or_b_after := by
  unfold a_or_b_before a_or_b_after
  simp_alive_peephole
  intros
  ---BEGIN a_or_b
  all_goals (try extract_goal ; sorry)
  ---END a_or_b



def a_or_b_const_before := [llvm|
{
^0(%arg10 : i32, %arg11 : i32, %arg12 : i32):
  %0 = llvm.icmp "eq" %arg10, %arg12 : i32
  %1 = llvm.icmp "ne" %arg11, %arg12 : i32
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "ne" %arg10, %arg12 : i32
  %4 = llvm.icmp "eq" %arg11, %arg12 : i32
  %5 = llvm.and %3, %4 : i1
  %6 = llvm.or %2, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def a_or_b_const_after := [llvm|
{
^0(%arg10 : i32, %arg11 : i32, %arg12 : i32):
  %0 = llvm.icmp "eq" %arg10, %arg12 : i32
  %1 = llvm.icmp "eq" %arg11, %arg12 : i32
  %2 = llvm.xor %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_or_b_const_proof : a_or_b_const_before ⊑ a_or_b_const_after := by
  unfold a_or_b_const_before a_or_b_const_after
  simp_alive_peephole
  intros
  ---BEGIN a_or_b_const
  all_goals (try extract_goal ; sorry)
  ---END a_or_b_const



def a_or_b_const2_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32, %arg9 : i32):
  %0 = llvm.icmp "eq" %arg6, %arg8 : i32
  %1 = llvm.icmp "ne" %arg7, %arg9 : i32
  %2 = llvm.and %0, %1 : i1
  %3 = llvm.icmp "ne" %arg6, %arg8 : i32
  %4 = llvm.icmp "eq" %arg7, %arg9 : i32
  %5 = llvm.and %3, %4 : i1
  %6 = llvm.or %2, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def a_or_b_const2_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32, %arg9 : i32):
  %0 = llvm.icmp "eq" %arg6, %arg8 : i32
  %1 = llvm.icmp "eq" %arg7, %arg9 : i32
  %2 = llvm.xor %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_or_b_const2_proof : a_or_b_const2_before ⊑ a_or_b_const2_after := by
  unfold a_or_b_const2_before a_or_b_const2_after
  simp_alive_peephole
  intros
  ---BEGIN a_or_b_const2
  all_goals (try extract_goal ; sorry)
  ---END a_or_b_const2


