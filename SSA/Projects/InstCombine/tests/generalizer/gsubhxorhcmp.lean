import SSA.Projects.InstCombine.tests.proofs.gsubhxorhcmp_proof
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
section gsubhxorhcmp_statements

def sext_xor_sub_before := [llvm|
{
^0(%arg28 : i64, %arg29 : i1):
  %0 = llvm.sext %arg29 : i1 to i64
  %1 = llvm.xor %arg28, %0 : i64
  %2 = llvm.sub %1, %0 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def sext_xor_sub_after := [llvm|
{
^0(%arg28 : i64, %arg29 : i1):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sub %0, %arg28 : i64
  %2 = "llvm.select"(%arg29, %1, %arg28) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_xor_sub_proof : sext_xor_sub_before ⊑ sext_xor_sub_after := by
  unfold sext_xor_sub_before sext_xor_sub_after
  simp_alive_peephole
  intros
  ---BEGIN sext_xor_sub
  apply sext_xor_sub_thm
  ---END sext_xor_sub



def sext_xor_sub_1_before := [llvm|
{
^0(%arg26 : i64, %arg27 : i1):
  %0 = llvm.sext %arg27 : i1 to i64
  %1 = llvm.xor %0, %arg26 : i64
  %2 = llvm.sub %1, %0 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def sext_xor_sub_1_after := [llvm|
{
^0(%arg26 : i64, %arg27 : i1):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sub %0, %arg26 : i64
  %2 = "llvm.select"(%arg27, %1, %arg26) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_xor_sub_1_proof : sext_xor_sub_1_before ⊑ sext_xor_sub_1_after := by
  unfold sext_xor_sub_1_before sext_xor_sub_1_after
  simp_alive_peephole
  intros
  ---BEGIN sext_xor_sub_1
  apply sext_xor_sub_1_thm
  ---END sext_xor_sub_1



def sext_xor_sub_2_before := [llvm|
{
^0(%arg24 : i64, %arg25 : i1):
  %0 = llvm.sext %arg25 : i1 to i64
  %1 = llvm.xor %arg24, %0 : i64
  %2 = llvm.sub %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def sext_xor_sub_2_after := [llvm|
{
^0(%arg24 : i64, %arg25 : i1):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sub %0, %arg24 : i64
  %2 = "llvm.select"(%arg25, %arg24, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_xor_sub_2_proof : sext_xor_sub_2_before ⊑ sext_xor_sub_2_after := by
  unfold sext_xor_sub_2_before sext_xor_sub_2_after
  simp_alive_peephole
  intros
  ---BEGIN sext_xor_sub_2
  apply sext_xor_sub_2_thm
  ---END sext_xor_sub_2



def sext_xor_sub_3_before := [llvm|
{
^0(%arg22 : i64, %arg23 : i1):
  %0 = llvm.sext %arg23 : i1 to i64
  %1 = llvm.xor %0, %arg22 : i64
  %2 = llvm.sub %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def sext_xor_sub_3_after := [llvm|
{
^0(%arg22 : i64, %arg23 : i1):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sub %0, %arg22 : i64
  %2 = "llvm.select"(%arg23, %arg22, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_xor_sub_3_proof : sext_xor_sub_3_before ⊑ sext_xor_sub_3_after := by
  unfold sext_xor_sub_3_before sext_xor_sub_3_after
  simp_alive_peephole
  intros
  ---BEGIN sext_xor_sub_3
  apply sext_xor_sub_3_thm
  ---END sext_xor_sub_3



def sext_non_bool_xor_sub_1_before := [llvm|
{
^0(%arg18 : i64, %arg19 : i8):
  %0 = llvm.sext %arg19 : i8 to i64
  %1 = llvm.xor %0, %arg18 : i64
  %2 = llvm.sub %1, %0 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def sext_non_bool_xor_sub_1_after := [llvm|
{
^0(%arg18 : i64, %arg19 : i8):
  %0 = llvm.sext %arg19 : i8 to i64
  %1 = llvm.xor %arg18, %0 : i64
  %2 = llvm.sub %1, %0 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_non_bool_xor_sub_1_proof : sext_non_bool_xor_sub_1_before ⊑ sext_non_bool_xor_sub_1_after := by
  unfold sext_non_bool_xor_sub_1_before sext_non_bool_xor_sub_1_after
  simp_alive_peephole
  intros
  ---BEGIN sext_non_bool_xor_sub_1
  apply sext_non_bool_xor_sub_1_thm
  ---END sext_non_bool_xor_sub_1



def sext_diff_i1_xor_sub_before := [llvm|
{
^0(%arg15 : i64, %arg16 : i1, %arg17 : i1):
  %0 = llvm.sext %arg16 : i1 to i64
  %1 = llvm.sext %arg17 : i1 to i64
  %2 = llvm.xor %arg15, %0 : i64
  %3 = llvm.sub %0, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def sext_diff_i1_xor_sub_after := [llvm|
{
^0(%arg15 : i64, %arg16 : i1, %arg17 : i1):
  %0 = llvm.sext %arg16 : i1 to i64
  %1 = llvm.zext %arg17 : i1 to i64
  %2 = llvm.add %1, %0 overflow<nsw> : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_diff_i1_xor_sub_proof : sext_diff_i1_xor_sub_before ⊑ sext_diff_i1_xor_sub_after := by
  unfold sext_diff_i1_xor_sub_before sext_diff_i1_xor_sub_after
  simp_alive_peephole
  intros
  ---BEGIN sext_diff_i1_xor_sub
  apply sext_diff_i1_xor_sub_thm
  ---END sext_diff_i1_xor_sub



def sext_diff_i1_xor_sub_1_before := [llvm|
{
^0(%arg12 : i64, %arg13 : i1, %arg14 : i1):
  %0 = llvm.sext %arg13 : i1 to i64
  %1 = llvm.sext %arg14 : i1 to i64
  %2 = llvm.xor %0, %arg12 : i64
  %3 = llvm.sub %0, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def sext_diff_i1_xor_sub_1_after := [llvm|
{
^0(%arg12 : i64, %arg13 : i1, %arg14 : i1):
  %0 = llvm.sext %arg13 : i1 to i64
  %1 = llvm.zext %arg14 : i1 to i64
  %2 = llvm.add %1, %0 overflow<nsw> : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_diff_i1_xor_sub_1_proof : sext_diff_i1_xor_sub_1_before ⊑ sext_diff_i1_xor_sub_1_after := by
  unfold sext_diff_i1_xor_sub_1_before sext_diff_i1_xor_sub_1_after
  simp_alive_peephole
  intros
  ---BEGIN sext_diff_i1_xor_sub_1
  apply sext_diff_i1_xor_sub_1_thm
  ---END sext_diff_i1_xor_sub_1



def sext_multi_uses_before := [llvm|
{
^0(%arg9 : i64, %arg10 : i1, %arg11 : i64):
  %0 = llvm.sext %arg10 : i1 to i64
  %1 = llvm.xor %arg9, %0 : i64
  %2 = llvm.sub %1, %0 : i64
  %3 = llvm.mul %arg11, %0 : i64
  %4 = llvm.add %3, %2 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def sext_multi_uses_after := [llvm|
{
^0(%arg9 : i64, %arg10 : i1, %arg11 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.add %arg11, %arg9 : i64
  %2 = llvm.sub %0, %1 : i64
  %3 = "llvm.select"(%arg10, %2, %arg9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_multi_uses_proof : sext_multi_uses_before ⊑ sext_multi_uses_after := by
  unfold sext_multi_uses_before sext_multi_uses_after
  simp_alive_peephole
  intros
  ---BEGIN sext_multi_uses
  apply sext_multi_uses_thm
  ---END sext_multi_uses



def absdiff_before := [llvm|
{
^0(%arg4 : i64, %arg5 : i64):
  %0 = llvm.icmp "ult" %arg4, %arg5 : i64
  %1 = llvm.sext %0 : i1 to i64
  %2 = llvm.sub %arg4, %arg5 : i64
  %3 = llvm.xor %1, %2 : i64
  %4 = llvm.sub %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def absdiff_after := [llvm|
{
^0(%arg4 : i64, %arg5 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "ult" %arg4, %arg5 : i64
  %2 = llvm.sub %arg4, %arg5 : i64
  %3 = llvm.sub %0, %2 : i64
  %4 = "llvm.select"(%1, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem absdiff_proof : absdiff_before ⊑ absdiff_after := by
  unfold absdiff_before absdiff_after
  simp_alive_peephole
  intros
  ---BEGIN absdiff
  apply absdiff_thm
  ---END absdiff



def absdiff1_before := [llvm|
{
^0(%arg2 : i64, %arg3 : i64):
  %0 = llvm.icmp "ult" %arg2, %arg3 : i64
  %1 = llvm.sext %0 : i1 to i64
  %2 = llvm.sub %arg2, %arg3 : i64
  %3 = llvm.xor %2, %1 : i64
  %4 = llvm.sub %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def absdiff1_after := [llvm|
{
^0(%arg2 : i64, %arg3 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "ult" %arg2, %arg3 : i64
  %2 = llvm.sub %arg2, %arg3 : i64
  %3 = llvm.sub %0, %2 : i64
  %4 = "llvm.select"(%1, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem absdiff1_proof : absdiff1_before ⊑ absdiff1_after := by
  unfold absdiff1_before absdiff1_after
  simp_alive_peephole
  intros
  ---BEGIN absdiff1
  apply absdiff1_thm
  ---END absdiff1



def absdiff2_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.icmp "ugt" %arg0, %arg1 : i64
  %1 = llvm.sext %0 : i1 to i64
  %2 = llvm.sub %arg1, %arg0 : i64
  %3 = llvm.xor %2, %1 : i64
  %4 = llvm.sub %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def absdiff2_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "ugt" %arg0, %arg1 : i64
  %2 = llvm.sub %arg1, %arg0 : i64
  %3 = llvm.sub %0, %2 : i64
  %4 = "llvm.select"(%1, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem absdiff2_proof : absdiff2_before ⊑ absdiff2_after := by
  unfold absdiff2_before absdiff2_after
  simp_alive_peephole
  intros
  ---BEGIN absdiff2
  apply absdiff2_thm
  ---END absdiff2


