
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
section gtrunchbinophext_statements

def narrow_sext_and_before := [llvm|
{
^0(%arg56 : i16, %arg57 : i32):
  %0 = llvm.sext %arg56 : i16 to i32
  %1 = llvm.and %0, %arg57 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def narrow_sext_and_after := [llvm|
{
^0(%arg56 : i16, %arg57 : i32):
  %0 = llvm.trunc %arg57 : i32 to i16
  %1 = llvm.and %arg56, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_sext_and_proof : narrow_sext_and_before ⊑ narrow_sext_and_after := by
  unfold narrow_sext_and_before narrow_sext_and_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_sext_and
  all_goals (try extract_goal ; sorry)
  ---END narrow_sext_and



def narrow_zext_and_before := [llvm|
{
^0(%arg54 : i16, %arg55 : i32):
  %0 = llvm.zext %arg54 : i16 to i32
  %1 = llvm.and %0, %arg55 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def narrow_zext_and_after := [llvm|
{
^0(%arg54 : i16, %arg55 : i32):
  %0 = llvm.trunc %arg55 : i32 to i16
  %1 = llvm.and %arg54, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_zext_and_proof : narrow_zext_and_before ⊑ narrow_zext_and_after := by
  unfold narrow_zext_and_before narrow_zext_and_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_zext_and
  all_goals (try extract_goal ; sorry)
  ---END narrow_zext_and



def narrow_sext_or_before := [llvm|
{
^0(%arg52 : i16, %arg53 : i32):
  %0 = llvm.sext %arg52 : i16 to i32
  %1 = llvm.or %0, %arg53 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def narrow_sext_or_after := [llvm|
{
^0(%arg52 : i16, %arg53 : i32):
  %0 = llvm.trunc %arg53 : i32 to i16
  %1 = llvm.or %arg52, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_sext_or_proof : narrow_sext_or_before ⊑ narrow_sext_or_after := by
  unfold narrow_sext_or_before narrow_sext_or_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_sext_or
  all_goals (try extract_goal ; sorry)
  ---END narrow_sext_or



def narrow_zext_or_before := [llvm|
{
^0(%arg50 : i16, %arg51 : i32):
  %0 = llvm.zext %arg50 : i16 to i32
  %1 = llvm.or %0, %arg51 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def narrow_zext_or_after := [llvm|
{
^0(%arg50 : i16, %arg51 : i32):
  %0 = llvm.trunc %arg51 : i32 to i16
  %1 = llvm.or %arg50, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_zext_or_proof : narrow_zext_or_before ⊑ narrow_zext_or_after := by
  unfold narrow_zext_or_before narrow_zext_or_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_zext_or
  all_goals (try extract_goal ; sorry)
  ---END narrow_zext_or



def narrow_sext_xor_before := [llvm|
{
^0(%arg48 : i16, %arg49 : i32):
  %0 = llvm.sext %arg48 : i16 to i32
  %1 = llvm.xor %0, %arg49 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def narrow_sext_xor_after := [llvm|
{
^0(%arg48 : i16, %arg49 : i32):
  %0 = llvm.trunc %arg49 : i32 to i16
  %1 = llvm.xor %arg48, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_sext_xor_proof : narrow_sext_xor_before ⊑ narrow_sext_xor_after := by
  unfold narrow_sext_xor_before narrow_sext_xor_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_sext_xor
  all_goals (try extract_goal ; sorry)
  ---END narrow_sext_xor



def narrow_zext_xor_before := [llvm|
{
^0(%arg46 : i16, %arg47 : i32):
  %0 = llvm.zext %arg46 : i16 to i32
  %1 = llvm.xor %0, %arg47 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def narrow_zext_xor_after := [llvm|
{
^0(%arg46 : i16, %arg47 : i32):
  %0 = llvm.trunc %arg47 : i32 to i16
  %1 = llvm.xor %arg46, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_zext_xor_proof : narrow_zext_xor_before ⊑ narrow_zext_xor_after := by
  unfold narrow_zext_xor_before narrow_zext_xor_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_zext_xor
  all_goals (try extract_goal ; sorry)
  ---END narrow_zext_xor



def narrow_sext_add_before := [llvm|
{
^0(%arg44 : i16, %arg45 : i32):
  %0 = llvm.sext %arg44 : i16 to i32
  %1 = llvm.add %0, %arg45 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def narrow_sext_add_after := [llvm|
{
^0(%arg44 : i16, %arg45 : i32):
  %0 = llvm.trunc %arg45 : i32 to i16
  %1 = llvm.add %arg44, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_sext_add_proof : narrow_sext_add_before ⊑ narrow_sext_add_after := by
  unfold narrow_sext_add_before narrow_sext_add_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_sext_add
  all_goals (try extract_goal ; sorry)
  ---END narrow_sext_add



def narrow_zext_add_before := [llvm|
{
^0(%arg42 : i16, %arg43 : i32):
  %0 = llvm.zext %arg42 : i16 to i32
  %1 = llvm.add %0, %arg43 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def narrow_zext_add_after := [llvm|
{
^0(%arg42 : i16, %arg43 : i32):
  %0 = llvm.trunc %arg43 : i32 to i16
  %1 = llvm.add %arg42, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_zext_add_proof : narrow_zext_add_before ⊑ narrow_zext_add_after := by
  unfold narrow_zext_add_before narrow_zext_add_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_zext_add
  all_goals (try extract_goal ; sorry)
  ---END narrow_zext_add



def narrow_sext_sub_before := [llvm|
{
^0(%arg40 : i16, %arg41 : i32):
  %0 = llvm.sext %arg40 : i16 to i32
  %1 = llvm.sub %0, %arg41 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def narrow_sext_sub_after := [llvm|
{
^0(%arg40 : i16, %arg41 : i32):
  %0 = llvm.trunc %arg41 : i32 to i16
  %1 = llvm.sub %arg40, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_sext_sub_proof : narrow_sext_sub_before ⊑ narrow_sext_sub_after := by
  unfold narrow_sext_sub_before narrow_sext_sub_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_sext_sub
  all_goals (try extract_goal ; sorry)
  ---END narrow_sext_sub



def narrow_zext_sub_before := [llvm|
{
^0(%arg38 : i16, %arg39 : i32):
  %0 = llvm.zext %arg38 : i16 to i32
  %1 = llvm.sub %0, %arg39 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def narrow_zext_sub_after := [llvm|
{
^0(%arg38 : i16, %arg39 : i32):
  %0 = llvm.trunc %arg39 : i32 to i16
  %1 = llvm.sub %arg38, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_zext_sub_proof : narrow_zext_sub_before ⊑ narrow_zext_sub_after := by
  unfold narrow_zext_sub_before narrow_zext_sub_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_zext_sub
  all_goals (try extract_goal ; sorry)
  ---END narrow_zext_sub



def narrow_sext_mul_before := [llvm|
{
^0(%arg36 : i16, %arg37 : i32):
  %0 = llvm.sext %arg36 : i16 to i32
  %1 = llvm.mul %0, %arg37 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def narrow_sext_mul_after := [llvm|
{
^0(%arg36 : i16, %arg37 : i32):
  %0 = llvm.trunc %arg37 : i32 to i16
  %1 = llvm.mul %arg36, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_sext_mul_proof : narrow_sext_mul_before ⊑ narrow_sext_mul_after := by
  unfold narrow_sext_mul_before narrow_sext_mul_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_sext_mul
  all_goals (try extract_goal ; sorry)
  ---END narrow_sext_mul



def narrow_zext_mul_before := [llvm|
{
^0(%arg34 : i16, %arg35 : i32):
  %0 = llvm.zext %arg34 : i16 to i32
  %1 = llvm.mul %0, %arg35 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def narrow_zext_mul_after := [llvm|
{
^0(%arg34 : i16, %arg35 : i32):
  %0 = llvm.trunc %arg35 : i32 to i16
  %1 = llvm.mul %arg34, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_zext_mul_proof : narrow_zext_mul_before ⊑ narrow_zext_mul_after := by
  unfold narrow_zext_mul_before narrow_zext_mul_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_zext_mul
  all_goals (try extract_goal ; sorry)
  ---END narrow_zext_mul



def narrow_zext_ashr_keep_trunc_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.sext %arg8 : i8 to i32
  %2 = llvm.sext %arg9 : i8 to i32
  %3 = llvm.add %1, %2 overflow<nsw> : i32
  %4 = llvm.ashr %3, %0 : i32
  %5 = llvm.trunc %4 : i32 to i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def narrow_zext_ashr_keep_trunc_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(1 : i16) : i16
  %1 = llvm.sext %arg8 : i8 to i16
  %2 = llvm.sext %arg9 : i8 to i16
  %3 = llvm.add %1, %2 overflow<nsw> : i16
  %4 = llvm.lshr %3, %0 : i16
  %5 = llvm.trunc %4 : i16 to i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_zext_ashr_keep_trunc_proof : narrow_zext_ashr_keep_trunc_before ⊑ narrow_zext_ashr_keep_trunc_after := by
  unfold narrow_zext_ashr_keep_trunc_before narrow_zext_ashr_keep_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_zext_ashr_keep_trunc
  all_goals (try extract_goal ; sorry)
  ---END narrow_zext_ashr_keep_trunc



def narrow_zext_ashr_keep_trunc2_before := [llvm|
{
^0(%arg6 : i9, %arg7 : i9):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.sext %arg6 : i9 to i64
  %2 = llvm.sext %arg7 : i9 to i64
  %3 = llvm.add %1, %2 overflow<nsw> : i64
  %4 = llvm.ashr %3, %0 : i64
  %5 = llvm.trunc %4 : i64 to i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def narrow_zext_ashr_keep_trunc2_after := [llvm|
{
^0(%arg6 : i9, %arg7 : i9):
  %0 = llvm.mlir.constant(1 : i16) : i16
  %1 = llvm.zext %arg6 : i9 to i16
  %2 = llvm.zext %arg7 : i9 to i16
  %3 = llvm.add %1, %2 overflow<nsw,nuw> : i16
  %4 = llvm.lshr %3, %0 : i16
  %5 = llvm.trunc %4 : i16 to i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_zext_ashr_keep_trunc2_proof : narrow_zext_ashr_keep_trunc2_before ⊑ narrow_zext_ashr_keep_trunc2_after := by
  unfold narrow_zext_ashr_keep_trunc2_before narrow_zext_ashr_keep_trunc2_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_zext_ashr_keep_trunc2
  all_goals (try extract_goal ; sorry)
  ---END narrow_zext_ashr_keep_trunc2



def narrow_zext_ashr_keep_trunc3_before := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.sext %arg4 : i8 to i64
  %2 = llvm.sext %arg5 : i8 to i64
  %3 = llvm.add %1, %2 overflow<nsw> : i64
  %4 = llvm.ashr %3, %0 : i64
  %5 = llvm.trunc %4 : i64 to i7
  "llvm.return"(%5) : (i7) -> ()
}
]
def narrow_zext_ashr_keep_trunc3_after := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(1 : i14) : i14
  %1 = llvm.zext %arg4 : i8 to i14
  %2 = llvm.zext %arg5 : i8 to i14
  %3 = llvm.add %1, %2 overflow<nsw,nuw> : i14
  %4 = llvm.lshr %3, %0 : i14
  %5 = llvm.trunc %4 : i14 to i7
  "llvm.return"(%5) : (i7) -> ()
}
]
set_option debug.skipKernelTC true in
theorem narrow_zext_ashr_keep_trunc3_proof : narrow_zext_ashr_keep_trunc3_before ⊑ narrow_zext_ashr_keep_trunc3_after := by
  unfold narrow_zext_ashr_keep_trunc3_before narrow_zext_ashr_keep_trunc3_after
  simp_alive_peephole
  intros
  ---BEGIN narrow_zext_ashr_keep_trunc3
  all_goals (try extract_goal ; sorry)
  ---END narrow_zext_ashr_keep_trunc3



def dont_narrow_zext_ashr_keep_trunc_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(1 : i16) : i16
  %1 = llvm.sext %arg0 : i8 to i16
  %2 = llvm.sext %arg1 : i8 to i16
  %3 = llvm.add %1, %2 overflow<nsw> : i16
  %4 = llvm.ashr %3, %0 : i16
  %5 = llvm.trunc %4 : i16 to i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def dont_narrow_zext_ashr_keep_trunc_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(1 : i16) : i16
  %1 = llvm.sext %arg0 : i8 to i16
  %2 = llvm.sext %arg1 : i8 to i16
  %3 = llvm.add %1, %2 overflow<nsw> : i16
  %4 = llvm.lshr %3, %0 : i16
  %5 = llvm.trunc %4 : i16 to i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem dont_narrow_zext_ashr_keep_trunc_proof : dont_narrow_zext_ashr_keep_trunc_before ⊑ dont_narrow_zext_ashr_keep_trunc_after := by
  unfold dont_narrow_zext_ashr_keep_trunc_before dont_narrow_zext_ashr_keep_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN dont_narrow_zext_ashr_keep_trunc
  all_goals (try extract_goal ; sorry)
  ---END dont_narrow_zext_ashr_keep_trunc


