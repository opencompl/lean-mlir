
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
section gashrhlshr_statements

def ashr_known_pos_exact_before := [llvm|
{
^0(%arg35 : i8, %arg36 : i8):
  %0 = "llvm.mlir.constant"() <{value = 127 : i8}> : () -> i8
  %1 = llvm.and %arg35, %0 : i8
  %2 = llvm.ashr %1, %arg36 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def ashr_known_pos_exact_after := [llvm|
{
^0(%arg35 : i8, %arg36 : i8):
  %0 = "llvm.mlir.constant"() <{value = 127 : i8}> : () -> i8
  %1 = llvm.and %arg35, %0 : i8
  %2 = llvm.lshr %1, %arg36 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem ashr_known_pos_exact_proof : ashr_known_pos_exact_before ⊑ ashr_known_pos_exact_after := by
  unfold ashr_known_pos_exact_before ashr_known_pos_exact_after
  simp_alive_peephole
  ---BEGIN ashr_known_pos_exact
  all_goals (try extract_goal ; sorry)
  ---END ashr_known_pos_exact



def lshr_mul_times_3_div_2_before := [llvm|
{
^0(%arg32 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.mul %arg32, %0 overflow<nsw,nuw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_3_div_2_after := [llvm|
{
^0(%arg32 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.lshr %arg32, %0 : i32
  %2 = llvm.add %arg32, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem lshr_mul_times_3_div_2_proof : lshr_mul_times_3_div_2_before ⊑ lshr_mul_times_3_div_2_after := by
  unfold lshr_mul_times_3_div_2_before lshr_mul_times_3_div_2_after
  simp_alive_peephole
  ---BEGIN lshr_mul_times_3_div_2
  all_goals (try extract_goal ; sorry)
  ---END lshr_mul_times_3_div_2



def lshr_mul_times_3_div_2_exact_before := [llvm|
{
^0(%arg31 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.mul %arg31, %0 overflow<nsw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_3_div_2_exact_after := [llvm|
{
^0(%arg31 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.lshr %arg31, %0 : i32
  %2 = llvm.add %arg31, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem lshr_mul_times_3_div_2_exact_proof : lshr_mul_times_3_div_2_exact_before ⊑ lshr_mul_times_3_div_2_exact_after := by
  unfold lshr_mul_times_3_div_2_exact_before lshr_mul_times_3_div_2_exact_after
  simp_alive_peephole
  ---BEGIN lshr_mul_times_3_div_2_exact
  all_goals (try extract_goal ; sorry)
  ---END lshr_mul_times_3_div_2_exact



def lshr_mul_times_3_div_2_exact_2_before := [llvm|
{
^0(%arg28 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.mul %arg28, %0 overflow<nuw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_3_div_2_exact_2_after := [llvm|
{
^0(%arg28 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.lshr %arg28, %0 : i32
  %2 = llvm.add %arg28, %1 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem lshr_mul_times_3_div_2_exact_2_proof : lshr_mul_times_3_div_2_exact_2_before ⊑ lshr_mul_times_3_div_2_exact_2_after := by
  unfold lshr_mul_times_3_div_2_exact_2_before lshr_mul_times_3_div_2_exact_2_after
  simp_alive_peephole
  ---BEGIN lshr_mul_times_3_div_2_exact_2
  all_goals (try extract_goal ; sorry)
  ---END lshr_mul_times_3_div_2_exact_2



def lshr_mul_times_5_div_4_before := [llvm|
{
^0(%arg27 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.mul %arg27, %0 overflow<nsw,nuw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_5_div_4_after := [llvm|
{
^0(%arg27 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.lshr %arg27, %0 : i32
  %2 = llvm.add %arg27, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem lshr_mul_times_5_div_4_proof : lshr_mul_times_5_div_4_before ⊑ lshr_mul_times_5_div_4_after := by
  unfold lshr_mul_times_5_div_4_before lshr_mul_times_5_div_4_after
  simp_alive_peephole
  ---BEGIN lshr_mul_times_5_div_4
  all_goals (try extract_goal ; sorry)
  ---END lshr_mul_times_5_div_4



def lshr_mul_times_5_div_4_exact_before := [llvm|
{
^0(%arg26 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.mul %arg26, %0 overflow<nsw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_5_div_4_exact_after := [llvm|
{
^0(%arg26 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.lshr %arg26, %0 : i32
  %2 = llvm.add %arg26, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem lshr_mul_times_5_div_4_exact_proof : lshr_mul_times_5_div_4_exact_before ⊑ lshr_mul_times_5_div_4_exact_after := by
  unfold lshr_mul_times_5_div_4_exact_before lshr_mul_times_5_div_4_exact_after
  simp_alive_peephole
  ---BEGIN lshr_mul_times_5_div_4_exact
  all_goals (try extract_goal ; sorry)
  ---END lshr_mul_times_5_div_4_exact



def lshr_mul_times_5_div_4_exact_2_before := [llvm|
{
^0(%arg23 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.mul %arg23, %0 overflow<nuw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_5_div_4_exact_2_after := [llvm|
{
^0(%arg23 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.lshr %arg23, %0 : i32
  %2 = llvm.add %arg23, %1 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem lshr_mul_times_5_div_4_exact_2_proof : lshr_mul_times_5_div_4_exact_2_before ⊑ lshr_mul_times_5_div_4_exact_2_after := by
  unfold lshr_mul_times_5_div_4_exact_2_before lshr_mul_times_5_div_4_exact_2_after
  simp_alive_peephole
  ---BEGIN lshr_mul_times_5_div_4_exact_2
  all_goals (try extract_goal ; sorry)
  ---END lshr_mul_times_5_div_4_exact_2



def ashr_mul_times_3_div_2_before := [llvm|
{
^0(%arg22 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.mul %arg22, %0 overflow<nsw,nuw> : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_3_div_2_after := [llvm|
{
^0(%arg22 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.lshr %arg22, %0 : i32
  %2 = llvm.add %arg22, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem ashr_mul_times_3_div_2_proof : ashr_mul_times_3_div_2_before ⊑ ashr_mul_times_3_div_2_after := by
  unfold ashr_mul_times_3_div_2_before ashr_mul_times_3_div_2_after
  simp_alive_peephole
  ---BEGIN ashr_mul_times_3_div_2
  all_goals (try extract_goal ; sorry)
  ---END ashr_mul_times_3_div_2



def ashr_mul_times_3_div_2_exact_before := [llvm|
{
^0(%arg21 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.mul %arg21, %0 overflow<nsw> : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_3_div_2_exact_after := [llvm|
{
^0(%arg21 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.ashr %arg21, %0 : i32
  %2 = llvm.add %arg21, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem ashr_mul_times_3_div_2_exact_proof : ashr_mul_times_3_div_2_exact_before ⊑ ashr_mul_times_3_div_2_exact_after := by
  unfold ashr_mul_times_3_div_2_exact_before ashr_mul_times_3_div_2_exact_after
  simp_alive_peephole
  ---BEGIN ashr_mul_times_3_div_2_exact
  all_goals (try extract_goal ; sorry)
  ---END ashr_mul_times_3_div_2_exact



def ashr_mul_times_3_div_2_exact_2_before := [llvm|
{
^0(%arg17 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.mul %arg17, %0 overflow<nsw> : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_3_div_2_exact_2_after := [llvm|
{
^0(%arg17 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.ashr %arg17, %0 : i32
  %2 = llvm.add %arg17, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem ashr_mul_times_3_div_2_exact_2_proof : ashr_mul_times_3_div_2_exact_2_before ⊑ ashr_mul_times_3_div_2_exact_2_after := by
  unfold ashr_mul_times_3_div_2_exact_2_before ashr_mul_times_3_div_2_exact_2_after
  simp_alive_peephole
  ---BEGIN ashr_mul_times_3_div_2_exact_2
  all_goals (try extract_goal ; sorry)
  ---END ashr_mul_times_3_div_2_exact_2



def ashr_mul_times_5_div_4_before := [llvm|
{
^0(%arg16 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.mul %arg16, %0 overflow<nsw,nuw> : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_5_div_4_after := [llvm|
{
^0(%arg16 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.lshr %arg16, %0 : i32
  %2 = llvm.add %arg16, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem ashr_mul_times_5_div_4_proof : ashr_mul_times_5_div_4_before ⊑ ashr_mul_times_5_div_4_after := by
  unfold ashr_mul_times_5_div_4_before ashr_mul_times_5_div_4_after
  simp_alive_peephole
  ---BEGIN ashr_mul_times_5_div_4
  all_goals (try extract_goal ; sorry)
  ---END ashr_mul_times_5_div_4



def ashr_mul_times_5_div_4_exact_before := [llvm|
{
^0(%arg15 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.mul %arg15, %0 overflow<nsw> : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_5_div_4_exact_after := [llvm|
{
^0(%arg15 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.ashr %arg15, %0 : i32
  %2 = llvm.add %arg15, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem ashr_mul_times_5_div_4_exact_proof : ashr_mul_times_5_div_4_exact_before ⊑ ashr_mul_times_5_div_4_exact_after := by
  unfold ashr_mul_times_5_div_4_exact_before ashr_mul_times_5_div_4_exact_after
  simp_alive_peephole
  ---BEGIN ashr_mul_times_5_div_4_exact
  all_goals (try extract_goal ; sorry)
  ---END ashr_mul_times_5_div_4_exact



def ashr_mul_times_5_div_4_exact_2_before := [llvm|
{
^0(%arg12 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.mul %arg12, %0 overflow<nsw> : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_5_div_4_exact_2_after := [llvm|
{
^0(%arg12 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.ashr %arg12, %0 : i32
  %2 = llvm.add %arg12, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem ashr_mul_times_5_div_4_exact_2_proof : ashr_mul_times_5_div_4_exact_2_before ⊑ ashr_mul_times_5_div_4_exact_2_after := by
  unfold ashr_mul_times_5_div_4_exact_2_before ashr_mul_times_5_div_4_exact_2_after
  simp_alive_peephole
  ---BEGIN ashr_mul_times_5_div_4_exact_2
  all_goals (try extract_goal ; sorry)
  ---END ashr_mul_times_5_div_4_exact_2



def lsb_mask_sign_zext_wrong_cst2_before := [llvm|
{
^0(%arg8 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %3 = llvm.add %arg8, %0 : i32
  %4 = llvm.xor %arg8, %1 : i32
  %5 = llvm.and %3, %4 : i32
  %6 = llvm.lshr %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def lsb_mask_sign_zext_wrong_cst2_after := [llvm|
{
^0(%arg8 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %2 = llvm.add %arg8, %0 : i32
  %3 = llvm.and %2, %arg8 : i32
  %4 = llvm.lshr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem lsb_mask_sign_zext_wrong_cst2_proof : lsb_mask_sign_zext_wrong_cst2_before ⊑ lsb_mask_sign_zext_wrong_cst2_after := by
  unfold lsb_mask_sign_zext_wrong_cst2_before lsb_mask_sign_zext_wrong_cst2_after
  simp_alive_peephole
  ---BEGIN lsb_mask_sign_zext_wrong_cst2
  all_goals (try extract_goal ; sorry)
  ---END lsb_mask_sign_zext_wrong_cst2



def lsb_mask_sign_sext_wrong_cst2_before := [llvm|
{
^0(%arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %3 = llvm.add %arg2, %0 : i32
  %4 = llvm.xor %arg2, %1 : i32
  %5 = llvm.and %3, %4 : i32
  %6 = llvm.ashr %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def lsb_mask_sign_sext_wrong_cst2_after := [llvm|
{
^0(%arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %2 = llvm.add %arg2, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.ashr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem lsb_mask_sign_sext_wrong_cst2_proof : lsb_mask_sign_sext_wrong_cst2_before ⊑ lsb_mask_sign_sext_wrong_cst2_after := by
  unfold lsb_mask_sign_sext_wrong_cst2_before lsb_mask_sign_sext_wrong_cst2_after
  simp_alive_peephole
  ---BEGIN lsb_mask_sign_sext_wrong_cst2
  all_goals (try extract_goal ; sorry)
  ---END lsb_mask_sign_sext_wrong_cst2


