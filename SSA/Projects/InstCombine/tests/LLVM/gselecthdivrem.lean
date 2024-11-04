
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
section gselecthdivrem_statements

def udiv_common_divisor_before := [llvm|
{
^0(%arg65 : i1, %arg66 : i5, %arg67 : i5, %arg68 : i5):
  %0 = llvm.udiv %arg67, %arg66 : i5
  %1 = llvm.udiv %arg68, %arg66 : i5
  %2 = "llvm.select"(%arg65, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def udiv_common_divisor_after := [llvm|
{
^0(%arg65 : i1, %arg66 : i5, %arg67 : i5, %arg68 : i5):
  %0 = "llvm.select"(%arg65, %arg68, %arg67) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.udiv %0, %arg66 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_common_divisor_proof : udiv_common_divisor_before ⊑ udiv_common_divisor_after := by
  unfold udiv_common_divisor_before udiv_common_divisor_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_common_divisor
  all_goals (try extract_goal ; sorry)
  ---END udiv_common_divisor



def urem_common_divisor_before := [llvm|
{
^0(%arg61 : i1, %arg62 : i5, %arg63 : i5, %arg64 : i5):
  %0 = llvm.urem %arg63, %arg62 : i5
  %1 = llvm.urem %arg64, %arg62 : i5
  %2 = "llvm.select"(%arg61, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def urem_common_divisor_after := [llvm|
{
^0(%arg61 : i1, %arg62 : i5, %arg63 : i5, %arg64 : i5):
  %0 = "llvm.select"(%arg61, %arg64, %arg63) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.urem %0, %arg62 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_common_divisor_proof : urem_common_divisor_before ⊑ urem_common_divisor_after := by
  unfold urem_common_divisor_before urem_common_divisor_after
  simp_alive_peephole
  intros
  ---BEGIN urem_common_divisor
  all_goals (try extract_goal ; sorry)
  ---END urem_common_divisor



def sdiv_common_divisor_defined_cond_before := [llvm|
{
^0(%arg41 : i1, %arg42 : i5, %arg43 : i5, %arg44 : i5):
  %0 = llvm.sdiv %arg43, %arg42 : i5
  %1 = llvm.sdiv %arg44, %arg42 : i5
  %2 = "llvm.select"(%arg41, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def sdiv_common_divisor_defined_cond_after := [llvm|
{
^0(%arg41 : i1, %arg42 : i5, %arg43 : i5, %arg44 : i5):
  %0 = "llvm.select"(%arg41, %arg44, %arg43) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.sdiv %0, %arg42 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_common_divisor_defined_cond_proof : sdiv_common_divisor_defined_cond_before ⊑ sdiv_common_divisor_defined_cond_after := by
  unfold sdiv_common_divisor_defined_cond_before sdiv_common_divisor_defined_cond_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_common_divisor_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END sdiv_common_divisor_defined_cond



def srem_common_divisor_defined_cond_before := [llvm|
{
^0(%arg37 : i1, %arg38 : i5, %arg39 : i5, %arg40 : i5):
  %0 = llvm.srem %arg39, %arg38 : i5
  %1 = llvm.srem %arg40, %arg38 : i5
  %2 = "llvm.select"(%arg37, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def srem_common_divisor_defined_cond_after := [llvm|
{
^0(%arg37 : i1, %arg38 : i5, %arg39 : i5, %arg40 : i5):
  %0 = "llvm.select"(%arg37, %arg40, %arg39) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.srem %0, %arg38 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem srem_common_divisor_defined_cond_proof : srem_common_divisor_defined_cond_before ⊑ srem_common_divisor_defined_cond_after := by
  unfold srem_common_divisor_defined_cond_before srem_common_divisor_defined_cond_after
  simp_alive_peephole
  intros
  ---BEGIN srem_common_divisor_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END srem_common_divisor_defined_cond



def udiv_common_divisor_defined_cond_before := [llvm|
{
^0(%arg33 : i1, %arg34 : i5, %arg35 : i5, %arg36 : i5):
  %0 = llvm.udiv %arg35, %arg34 : i5
  %1 = llvm.udiv %arg36, %arg34 : i5
  %2 = "llvm.select"(%arg33, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def udiv_common_divisor_defined_cond_after := [llvm|
{
^0(%arg33 : i1, %arg34 : i5, %arg35 : i5, %arg36 : i5):
  %0 = "llvm.select"(%arg33, %arg36, %arg35) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.udiv %0, %arg34 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_common_divisor_defined_cond_proof : udiv_common_divisor_defined_cond_before ⊑ udiv_common_divisor_defined_cond_after := by
  unfold udiv_common_divisor_defined_cond_before udiv_common_divisor_defined_cond_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_common_divisor_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END udiv_common_divisor_defined_cond



def urem_common_divisor_defined_cond_before := [llvm|
{
^0(%arg29 : i1, %arg30 : i5, %arg31 : i5, %arg32 : i5):
  %0 = llvm.urem %arg31, %arg30 : i5
  %1 = llvm.urem %arg32, %arg30 : i5
  %2 = "llvm.select"(%arg29, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def urem_common_divisor_defined_cond_after := [llvm|
{
^0(%arg29 : i1, %arg30 : i5, %arg31 : i5, %arg32 : i5):
  %0 = "llvm.select"(%arg29, %arg32, %arg31) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.urem %0, %arg30 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_common_divisor_defined_cond_proof : urem_common_divisor_defined_cond_before ⊑ urem_common_divisor_defined_cond_after := by
  unfold urem_common_divisor_defined_cond_before urem_common_divisor_defined_cond_after
  simp_alive_peephole
  intros
  ---BEGIN urem_common_divisor_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END urem_common_divisor_defined_cond



def sdiv_common_dividend_defined_cond_before := [llvm|
{
^0(%arg25 : i1, %arg26 : i5, %arg27 : i5, %arg28 : i5):
  %0 = llvm.sdiv %arg26, %arg27 : i5
  %1 = llvm.sdiv %arg26, %arg28 : i5
  %2 = "llvm.select"(%arg25, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def sdiv_common_dividend_defined_cond_after := [llvm|
{
^0(%arg25 : i1, %arg26 : i5, %arg27 : i5, %arg28 : i5):
  %0 = "llvm.select"(%arg25, %arg28, %arg27) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.sdiv %arg26, %0 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_common_dividend_defined_cond_proof : sdiv_common_dividend_defined_cond_before ⊑ sdiv_common_dividend_defined_cond_after := by
  unfold sdiv_common_dividend_defined_cond_before sdiv_common_dividend_defined_cond_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_common_dividend_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END sdiv_common_dividend_defined_cond



def srem_common_dividend_defined_cond_before := [llvm|
{
^0(%arg21 : i1, %arg22 : i5, %arg23 : i5, %arg24 : i5):
  %0 = llvm.srem %arg22, %arg23 : i5
  %1 = llvm.srem %arg22, %arg24 : i5
  %2 = "llvm.select"(%arg21, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def srem_common_dividend_defined_cond_after := [llvm|
{
^0(%arg21 : i1, %arg22 : i5, %arg23 : i5, %arg24 : i5):
  %0 = "llvm.select"(%arg21, %arg24, %arg23) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.srem %arg22, %0 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem srem_common_dividend_defined_cond_proof : srem_common_dividend_defined_cond_before ⊑ srem_common_dividend_defined_cond_after := by
  unfold srem_common_dividend_defined_cond_before srem_common_dividend_defined_cond_after
  simp_alive_peephole
  intros
  ---BEGIN srem_common_dividend_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END srem_common_dividend_defined_cond



def udiv_common_dividend_defined_cond_before := [llvm|
{
^0(%arg17 : i1, %arg18 : i5, %arg19 : i5, %arg20 : i5):
  %0 = llvm.udiv %arg18, %arg19 : i5
  %1 = llvm.udiv %arg18, %arg20 : i5
  %2 = "llvm.select"(%arg17, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def udiv_common_dividend_defined_cond_after := [llvm|
{
^0(%arg17 : i1, %arg18 : i5, %arg19 : i5, %arg20 : i5):
  %0 = "llvm.select"(%arg17, %arg20, %arg19) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.udiv %arg18, %0 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_common_dividend_defined_cond_proof : udiv_common_dividend_defined_cond_before ⊑ udiv_common_dividend_defined_cond_after := by
  unfold udiv_common_dividend_defined_cond_before udiv_common_dividend_defined_cond_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_common_dividend_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END udiv_common_dividend_defined_cond



def urem_common_dividend_defined_cond_before := [llvm|
{
^0(%arg13 : i1, %arg14 : i5, %arg15 : i5, %arg16 : i5):
  %0 = llvm.urem %arg14, %arg15 : i5
  %1 = llvm.urem %arg14, %arg16 : i5
  %2 = "llvm.select"(%arg13, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def urem_common_dividend_defined_cond_after := [llvm|
{
^0(%arg13 : i1, %arg14 : i5, %arg15 : i5, %arg16 : i5):
  %0 = "llvm.select"(%arg13, %arg16, %arg15) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i5, i5) -> i5
  %1 = llvm.urem %arg14, %0 : i5
  "llvm.return"(%1) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_common_dividend_defined_cond_proof : urem_common_dividend_defined_cond_before ⊑ urem_common_dividend_defined_cond_after := by
  unfold urem_common_dividend_defined_cond_before urem_common_dividend_defined_cond_after
  simp_alive_peephole
  intros
  ---BEGIN urem_common_dividend_defined_cond
  all_goals (try extract_goal ; sorry)
  ---END urem_common_dividend_defined_cond



def rem_euclid_1_before := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.srem %arg12, %0 : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  %4 = llvm.add %2, %0 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def rem_euclid_1_after := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.and %arg12, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem rem_euclid_1_proof : rem_euclid_1_before ⊑ rem_euclid_1_after := by
  unfold rem_euclid_1_before rem_euclid_1_after
  simp_alive_peephole
  intros
  ---BEGIN rem_euclid_1
  all_goals (try extract_goal ; sorry)
  ---END rem_euclid_1



def rem_euclid_2_before := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.srem %arg11, %0 : i32
  %3 = llvm.icmp "sgt" %2, %1 : i32
  %4 = llvm.add %2, %0 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def rem_euclid_2_after := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.and %arg11, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem rem_euclid_2_proof : rem_euclid_2_before ⊑ rem_euclid_2_after := by
  unfold rem_euclid_2_before rem_euclid_2_after
  simp_alive_peephole
  intros
  ---BEGIN rem_euclid_2
  all_goals (try extract_goal ; sorry)
  ---END rem_euclid_2



def rem_euclid_wrong_sign_test_before := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.srem %arg10, %0 : i32
  %3 = llvm.icmp "sgt" %2, %1 : i32
  %4 = llvm.add %2, %0 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def rem_euclid_wrong_sign_test_after := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.srem %arg10, %0 : i32
  %3 = llvm.icmp "sgt" %2, %1 : i32
  %4 = llvm.add %2, %0 overflow<nsw> : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem rem_euclid_wrong_sign_test_proof : rem_euclid_wrong_sign_test_before ⊑ rem_euclid_wrong_sign_test_after := by
  unfold rem_euclid_wrong_sign_test_before rem_euclid_wrong_sign_test_after
  simp_alive_peephole
  intros
  ---BEGIN rem_euclid_wrong_sign_test
  all_goals (try extract_goal ; sorry)
  ---END rem_euclid_wrong_sign_test



def rem_euclid_add_different_const_before := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.srem %arg9, %0 : i32
  %4 = llvm.icmp "slt" %3, %1 : i32
  %5 = llvm.add %3, %2 : i32
  %6 = "llvm.select"(%4, %5, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def rem_euclid_add_different_const_after := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.srem %arg9, %0 : i32
  %4 = llvm.icmp "slt" %3, %1 : i32
  %5 = llvm.add %3, %2 overflow<nsw> : i32
  %6 = "llvm.select"(%4, %5, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem rem_euclid_add_different_const_proof : rem_euclid_add_different_const_before ⊑ rem_euclid_add_different_const_after := by
  unfold rem_euclid_add_different_const_before rem_euclid_add_different_const_after
  simp_alive_peephole
  intros
  ---BEGIN rem_euclid_add_different_const
  all_goals (try extract_goal ; sorry)
  ---END rem_euclid_add_different_const



def rem_euclid_wrong_operands_select_before := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.srem %arg8, %0 : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  %4 = llvm.add %2, %0 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def rem_euclid_wrong_operands_select_after := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.srem %arg8, %0 : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  %4 = llvm.add %2, %0 overflow<nsw> : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem rem_euclid_wrong_operands_select_proof : rem_euclid_wrong_operands_select_before ⊑ rem_euclid_wrong_operands_select_after := by
  unfold rem_euclid_wrong_operands_select_before rem_euclid_wrong_operands_select_after
  simp_alive_peephole
  intros
  ---BEGIN rem_euclid_wrong_operands_select
  all_goals (try extract_goal ; sorry)
  ---END rem_euclid_wrong_operands_select



def rem_euclid_i128_before := [llvm|
{
^0(%arg6 : i128):
  %0 = llvm.mlir.constant(8 : i128) : i128
  %1 = llvm.mlir.constant(0 : i128) : i128
  %2 = llvm.srem %arg6, %0 : i128
  %3 = llvm.icmp "slt" %2, %1 : i128
  %4 = llvm.add %2, %0 : i128
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i128, i128) -> i128
  "llvm.return"(%5) : (i128) -> ()
}
]
def rem_euclid_i128_after := [llvm|
{
^0(%arg6 : i128):
  %0 = llvm.mlir.constant(7 : i128) : i128
  %1 = llvm.and %arg6, %0 : i128
  "llvm.return"(%1) : (i128) -> ()
}
]
set_option debug.skipKernelTC true in
theorem rem_euclid_i128_proof : rem_euclid_i128_before ⊑ rem_euclid_i128_after := by
  unfold rem_euclid_i128_before rem_euclid_i128_after
  simp_alive_peephole
  intros
  ---BEGIN rem_euclid_i128
  all_goals (try extract_goal ; sorry)
  ---END rem_euclid_i128



def rem_euclid_non_const_pow2_before := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg4 : i8
  %3 = llvm.srem %arg5, %2 : i8
  %4 = llvm.icmp "slt" %3, %1 : i8
  %5 = llvm.add %3, %2 : i8
  %6 = "llvm.select"(%4, %5, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def rem_euclid_non_const_pow2_after := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg4 overflow<nsw> : i8
  %2 = llvm.xor %1, %0 : i8
  %3 = llvm.and %arg5, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem rem_euclid_non_const_pow2_proof : rem_euclid_non_const_pow2_before ⊑ rem_euclid_non_const_pow2_after := by
  unfold rem_euclid_non_const_pow2_before rem_euclid_non_const_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN rem_euclid_non_const_pow2
  all_goals (try extract_goal ; sorry)
  ---END rem_euclid_non_const_pow2



def rem_euclid_pow2_true_arm_folded_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.srem %arg3, %0 : i32
  %4 = llvm.icmp "slt" %3, %1 : i32
  %5 = "llvm.select"(%4, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def rem_euclid_pow2_true_arm_folded_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.and %arg3, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem rem_euclid_pow2_true_arm_folded_proof : rem_euclid_pow2_true_arm_folded_before ⊑ rem_euclid_pow2_true_arm_folded_after := by
  unfold rem_euclid_pow2_true_arm_folded_before rem_euclid_pow2_true_arm_folded_after
  simp_alive_peephole
  intros
  ---BEGIN rem_euclid_pow2_true_arm_folded
  all_goals (try extract_goal ; sorry)
  ---END rem_euclid_pow2_true_arm_folded



def rem_euclid_pow2_false_arm_folded_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.srem %arg2, %0 : i32
  %4 = llvm.icmp "sge" %3, %1 : i32
  %5 = "llvm.select"(%4, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def rem_euclid_pow2_false_arm_folded_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.and %arg2, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem rem_euclid_pow2_false_arm_folded_proof : rem_euclid_pow2_false_arm_folded_before ⊑ rem_euclid_pow2_false_arm_folded_after := by
  unfold rem_euclid_pow2_false_arm_folded_before rem_euclid_pow2_false_arm_folded_after
  simp_alive_peephole
  intros
  ---BEGIN rem_euclid_pow2_false_arm_folded
  all_goals (try extract_goal ; sorry)
  ---END rem_euclid_pow2_false_arm_folded



def pr89516_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "slt" %arg1, %0 : i8
  %3 = llvm.shl %1, %arg0 overflow<nuw> : i8
  %4 = llvm.srem %1, %3 : i8
  %5 = llvm.add %4, %3 overflow<nuw> : i8
  %6 = "llvm.select"(%2, %5, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def pr89516_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "slt" %arg1, %0 : i8
  %3 = llvm.shl %1, %arg0 overflow<nuw> : i8
  %4 = llvm.srem %1, %3 : i8
  %5 = "llvm.select"(%2, %3, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %6 = llvm.add %4, %5 overflow<nuw> : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr89516_proof : pr89516_before ⊑ pr89516_after := by
  unfold pr89516_before pr89516_after
  simp_alive_peephole
  intros
  ---BEGIN pr89516
  all_goals (try extract_goal ; sorry)
  ---END pr89516


