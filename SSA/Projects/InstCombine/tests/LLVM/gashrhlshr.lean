
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



def lsb_mask_sign_zext_commuted_before := [llvm|
{
^0(%arg10 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %2 = llvm.add %arg10, %0 : i32
  %3 = llvm.xor %arg10, %0 : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.lshr %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lsb_mask_sign_zext_commuted_after := [llvm|
{
^0(%arg10 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %2 = llvm.add %arg10, %0 : i32
  %3 = llvm.xor %arg10, %0 : i32
  %4 = llvm.and %2, %3 : i32
  %5 = llvm.lshr %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem lsb_mask_sign_zext_commuted_proof : lsb_mask_sign_zext_commuted_before ⊑ lsb_mask_sign_zext_commuted_after := by
  unfold lsb_mask_sign_zext_commuted_before lsb_mask_sign_zext_commuted_after
  simp_alive_peephole
  ---BEGIN lsb_mask_sign_zext_commuted
  all_goals (try extract_goal ; sorry)
  ---END lsb_mask_sign_zext_commuted



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



def lsb_mask_sign_sext_commuted_before := [llvm|
{
^0(%arg4 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %2 = llvm.add %arg4, %0 : i32
  %3 = llvm.xor %arg4, %0 : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.ashr %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lsb_mask_sign_sext_commuted_after := [llvm|
{
^0(%arg4 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %2 = llvm.add %arg4, %0 : i32
  %3 = llvm.xor %arg4, %0 : i32
  %4 = llvm.and %2, %3 : i32
  %5 = llvm.ashr %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem lsb_mask_sign_sext_commuted_proof : lsb_mask_sign_sext_commuted_before ⊑ lsb_mask_sign_sext_commuted_after := by
  unfold lsb_mask_sign_sext_commuted_before lsb_mask_sign_sext_commuted_after
  simp_alive_peephole
  ---BEGIN lsb_mask_sign_sext_commuted
  all_goals (try extract_goal ; sorry)
  ---END lsb_mask_sign_sext_commuted



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


