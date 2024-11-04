
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
section gsexthahlthbhplushzexthahgthbhtohuscmp_statements

def signed_add_before := [llvm|
{
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.icmp "slt" %arg20, %arg21 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg20, %arg21 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def signed_add_after := [llvm|
{
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.icmp "slt" %arg20, %arg21 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg20, %arg21 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 overflow<nsw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem signed_add_proof : signed_add_before ⊑ signed_add_after := by
  unfold signed_add_before signed_add_after
  simp_alive_peephole
  intros
  ---BEGIN signed_add
  all_goals (try extract_goal ; sorry)
  ---END signed_add



def unsigned_add_before := [llvm|
{
^0(%arg18 : i32, %arg19 : i32):
  %0 = llvm.icmp "ult" %arg18, %arg19 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "ugt" %arg18, %arg19 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def unsigned_add_after := [llvm|
{
^0(%arg18 : i32, %arg19 : i32):
  %0 = llvm.icmp "ult" %arg18, %arg19 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "ugt" %arg18, %arg19 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 overflow<nsw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem unsigned_add_proof : unsigned_add_before ⊑ unsigned_add_after := by
  unfold unsigned_add_before unsigned_add_after
  simp_alive_peephole
  intros
  ---BEGIN unsigned_add
  all_goals (try extract_goal ; sorry)
  ---END unsigned_add



def signed_add_commuted1_before := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.icmp "slt" %arg16, %arg17 : i32
  %1 = llvm.zext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg16, %arg17 : i32
  %3 = llvm.sext %2 : i1 to i8
  %4 = llvm.add %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def signed_add_commuted1_after := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.icmp "slt" %arg16, %arg17 : i32
  %1 = llvm.zext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg16, %arg17 : i32
  %3 = llvm.sext %2 : i1 to i8
  %4 = llvm.add %1, %3 overflow<nsw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem signed_add_commuted1_proof : signed_add_commuted1_before ⊑ signed_add_commuted1_after := by
  unfold signed_add_commuted1_before signed_add_commuted1_after
  simp_alive_peephole
  intros
  ---BEGIN signed_add_commuted1
  all_goals (try extract_goal ; sorry)
  ---END signed_add_commuted1



def signed_add_commuted2_before := [llvm|
{
^0(%arg14 : i32, %arg15 : i32):
  %0 = llvm.icmp "sgt" %arg15, %arg14 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg14, %arg15 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def signed_add_commuted2_after := [llvm|
{
^0(%arg14 : i32, %arg15 : i32):
  %0 = llvm.icmp "sgt" %arg15, %arg14 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg14, %arg15 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 overflow<nsw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem signed_add_commuted2_proof : signed_add_commuted2_before ⊑ signed_add_commuted2_after := by
  unfold signed_add_commuted2_before signed_add_commuted2_after
  simp_alive_peephole
  intros
  ---BEGIN signed_add_commuted2
  all_goals (try extract_goal ; sorry)
  ---END signed_add_commuted2



def signed_sub_before := [llvm|
{
^0(%arg12 : i32, %arg13 : i32):
  %0 = llvm.icmp "slt" %arg12, %arg13 : i32
  %1 = llvm.zext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg12, %arg13 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.sub %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def signed_sub_after := [llvm|
{
^0(%arg12 : i32, %arg13 : i32):
  %0 = llvm.icmp "slt" %arg12, %arg13 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg12, %arg13 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 overflow<nsw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem signed_sub_proof : signed_sub_before ⊑ signed_sub_after := by
  unfold signed_sub_before signed_sub_after
  simp_alive_peephole
  intros
  ---BEGIN signed_sub
  all_goals (try extract_goal ; sorry)
  ---END signed_sub



def unsigned_sub_before := [llvm|
{
^0(%arg10 : i32, %arg11 : i32):
  %0 = llvm.icmp "ult" %arg10, %arg11 : i32
  %1 = llvm.zext %0 : i1 to i8
  %2 = llvm.icmp "ugt" %arg10, %arg11 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.sub %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def unsigned_sub_after := [llvm|
{
^0(%arg10 : i32, %arg11 : i32):
  %0 = llvm.icmp "ult" %arg10, %arg11 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "ugt" %arg10, %arg11 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 overflow<nsw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem unsigned_sub_proof : unsigned_sub_before ⊑ unsigned_sub_after := by
  unfold unsigned_sub_before unsigned_sub_after
  simp_alive_peephole
  intros
  ---BEGIN unsigned_sub
  all_goals (try extract_goal ; sorry)
  ---END unsigned_sub



def signed_add_neg1_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.icmp "sgt" %arg8, %arg9 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg8, %arg9 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def signed_add_neg1_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.icmp "sgt" %arg8, %arg9 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg8, %arg9 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 overflow<nsw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem signed_add_neg1_proof : signed_add_neg1_before ⊑ signed_add_neg1_after := by
  unfold signed_add_neg1_before signed_add_neg1_after
  simp_alive_peephole
  intros
  ---BEGIN signed_add_neg1
  all_goals (try extract_goal ; sorry)
  ---END signed_add_neg1



def signed_add_neg2_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.icmp "slt" %arg6, %arg7 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "ne" %arg6, %arg7 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def signed_add_neg2_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.icmp "slt" %arg6, %arg7 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "ne" %arg6, %arg7 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 overflow<nsw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem signed_add_neg2_proof : signed_add_neg2_before ⊑ signed_add_neg2_after := by
  unfold signed_add_neg2_before signed_add_neg2_after
  simp_alive_peephole
  intros
  ---BEGIN signed_add_neg2
  all_goals (try extract_goal ; sorry)
  ---END signed_add_neg2



def signed_add_neg3_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.icmp "slt" %arg4, %arg5 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "ugt" %arg4, %arg5 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def signed_add_neg3_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.icmp "slt" %arg4, %arg5 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "ugt" %arg4, %arg5 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 overflow<nsw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem signed_add_neg3_proof : signed_add_neg3_before ⊑ signed_add_neg3_after := by
  unfold signed_add_neg3_before signed_add_neg3_after
  simp_alive_peephole
  intros
  ---BEGIN signed_add_neg3
  all_goals (try extract_goal ; sorry)
  ---END signed_add_neg3



def signed_add_neg4_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.icmp "slt" %arg2, %arg3 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg2, %arg3 : i32
  %3 = llvm.sext %2 : i1 to i8
  %4 = llvm.add %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def signed_add_neg4_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.icmp "slt" %arg2, %arg3 : i32
  %1 = llvm.sext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg2, %arg3 : i32
  %3 = llvm.sext %2 : i1 to i8
  %4 = llvm.add %1, %3 overflow<nsw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem signed_add_neg4_proof : signed_add_neg4_before ⊑ signed_add_neg4_after := by
  unfold signed_add_neg4_before signed_add_neg4_after
  simp_alive_peephole
  intros
  ---BEGIN signed_add_neg4
  all_goals (try extract_goal ; sorry)
  ---END signed_add_neg4



def signed_add_neg5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.icmp "slt" %arg0, %arg1 : i32
  %1 = llvm.zext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def signed_add_neg5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.icmp "slt" %arg0, %arg1 : i32
  %1 = llvm.zext %0 : i1 to i8
  %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
  %3 = llvm.zext %2 : i1 to i8
  %4 = llvm.add %1, %3 overflow<nsw,nuw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem signed_add_neg5_proof : signed_add_neg5_before ⊑ signed_add_neg5_after := by
  unfold signed_add_neg5_before signed_add_neg5_after
  simp_alive_peephole
  intros
  ---BEGIN signed_add_neg5
  all_goals (try extract_goal ; sorry)
  ---END signed_add_neg5


