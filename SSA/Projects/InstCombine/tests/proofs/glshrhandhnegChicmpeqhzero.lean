import SSA.Projects.InstCombine.tests.proofs.glshrhandhnegChicmpeqhzero_proof
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
section glshrhandhnegChicmpeqhzero_statements

def scalar_i8_lshr_and_negC_eq_before := [llvm|
{
^0(%arg39 : i8, %arg40 : i8):
  %0 = llvm.mlir.constant(-4 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.lshr %arg39, %arg40 : i8
  %3 = llvm.and %2, %0 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i8_lshr_and_negC_eq_after := [llvm|
{
^0(%arg39 : i8, %arg40 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.lshr %arg39, %arg40 : i8
  %2 = llvm.icmp "ult" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i8_lshr_and_negC_eq_proof : scalar_i8_lshr_and_negC_eq_before ⊑ scalar_i8_lshr_and_negC_eq_after := by
  unfold scalar_i8_lshr_and_negC_eq_before scalar_i8_lshr_and_negC_eq_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i8_lshr_and_negC_eq
  apply scalar_i8_lshr_and_negC_eq_thm
  ---END scalar_i8_lshr_and_negC_eq



def scalar_i16_lshr_and_negC_eq_before := [llvm|
{
^0(%arg37 : i16, %arg38 : i16):
  %0 = llvm.mlir.constant(-128 : i16) : i16
  %1 = llvm.mlir.constant(0 : i16) : i16
  %2 = llvm.lshr %arg37, %arg38 : i16
  %3 = llvm.and %2, %0 : i16
  %4 = llvm.icmp "eq" %3, %1 : i16
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i16_lshr_and_negC_eq_after := [llvm|
{
^0(%arg37 : i16, %arg38 : i16):
  %0 = llvm.mlir.constant(128 : i16) : i16
  %1 = llvm.lshr %arg37, %arg38 : i16
  %2 = llvm.icmp "ult" %1, %0 : i16
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i16_lshr_and_negC_eq_proof : scalar_i16_lshr_and_negC_eq_before ⊑ scalar_i16_lshr_and_negC_eq_after := by
  unfold scalar_i16_lshr_and_negC_eq_before scalar_i16_lshr_and_negC_eq_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i16_lshr_and_negC_eq
  apply scalar_i16_lshr_and_negC_eq_thm
  ---END scalar_i16_lshr_and_negC_eq



def scalar_i32_lshr_and_negC_eq_before := [llvm|
{
^0(%arg35 : i32, %arg36 : i32):
  %0 = llvm.mlir.constant(-262144 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg35, %arg36 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i32_lshr_and_negC_eq_after := [llvm|
{
^0(%arg35 : i32, %arg36 : i32):
  %0 = llvm.mlir.constant(262144 : i32) : i32
  %1 = llvm.lshr %arg35, %arg36 : i32
  %2 = llvm.icmp "ult" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i32_lshr_and_negC_eq_proof : scalar_i32_lshr_and_negC_eq_before ⊑ scalar_i32_lshr_and_negC_eq_after := by
  unfold scalar_i32_lshr_and_negC_eq_before scalar_i32_lshr_and_negC_eq_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i32_lshr_and_negC_eq
  apply scalar_i32_lshr_and_negC_eq_thm
  ---END scalar_i32_lshr_and_negC_eq



def scalar_i64_lshr_and_negC_eq_before := [llvm|
{
^0(%arg33 : i64, %arg34 : i64):
  %0 = llvm.mlir.constant(-8589934592) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.lshr %arg33, %arg34 : i64
  %3 = llvm.and %2, %0 : i64
  %4 = llvm.icmp "eq" %3, %1 : i64
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i64_lshr_and_negC_eq_after := [llvm|
{
^0(%arg33 : i64, %arg34 : i64):
  %0 = llvm.mlir.constant(8589934592) : i64
  %1 = llvm.lshr %arg33, %arg34 : i64
  %2 = llvm.icmp "ult" %1, %0 : i64
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i64_lshr_and_negC_eq_proof : scalar_i64_lshr_and_negC_eq_before ⊑ scalar_i64_lshr_and_negC_eq_after := by
  unfold scalar_i64_lshr_and_negC_eq_before scalar_i64_lshr_and_negC_eq_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i64_lshr_and_negC_eq
  apply scalar_i64_lshr_and_negC_eq_thm
  ---END scalar_i64_lshr_and_negC_eq



def scalar_i32_lshr_and_negC_ne_before := [llvm|
{
^0(%arg31 : i32, %arg32 : i32):
  %0 = llvm.mlir.constant(-262144 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg31, %arg32 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i32_lshr_and_negC_ne_after := [llvm|
{
^0(%arg31 : i32, %arg32 : i32):
  %0 = llvm.mlir.constant(262143 : i32) : i32
  %1 = llvm.lshr %arg31, %arg32 : i32
  %2 = llvm.icmp "ugt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i32_lshr_and_negC_ne_proof : scalar_i32_lshr_and_negC_ne_before ⊑ scalar_i32_lshr_and_negC_ne_after := by
  unfold scalar_i32_lshr_and_negC_ne_before scalar_i32_lshr_and_negC_ne_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i32_lshr_and_negC_ne
  apply scalar_i32_lshr_and_negC_ne_thm
  ---END scalar_i32_lshr_and_negC_ne



def scalar_i32_lshr_and_negC_eq_X_is_constant1_before := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(12345 : i32) : i32
  %1 = llvm.mlir.constant(-8 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %0, %arg9 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def scalar_i32_lshr_and_negC_eq_X_is_constant1_after := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(12345 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.lshr %0, %arg9 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i32_lshr_and_negC_eq_X_is_constant1_proof : scalar_i32_lshr_and_negC_eq_X_is_constant1_before ⊑ scalar_i32_lshr_and_negC_eq_X_is_constant1_after := by
  unfold scalar_i32_lshr_and_negC_eq_X_is_constant1_before scalar_i32_lshr_and_negC_eq_X_is_constant1_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i32_lshr_and_negC_eq_X_is_constant1
  apply scalar_i32_lshr_and_negC_eq_X_is_constant1_thm
  ---END scalar_i32_lshr_and_negC_eq_X_is_constant1



def scalar_i32_lshr_and_negC_eq_X_is_constant2_before := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(268435456 : i32) : i32
  %1 = llvm.mlir.constant(-8 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %0, %arg8 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def scalar_i32_lshr_and_negC_eq_X_is_constant2_after := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(25 : i32) : i32
  %1 = llvm.icmp "ugt" %arg8, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i32_lshr_and_negC_eq_X_is_constant2_proof : scalar_i32_lshr_and_negC_eq_X_is_constant2_before ⊑ scalar_i32_lshr_and_negC_eq_X_is_constant2_after := by
  unfold scalar_i32_lshr_and_negC_eq_X_is_constant2_before scalar_i32_lshr_and_negC_eq_X_is_constant2_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i32_lshr_and_negC_eq_X_is_constant2
  apply scalar_i32_lshr_and_negC_eq_X_is_constant2_thm
  ---END scalar_i32_lshr_and_negC_eq_X_is_constant2



def scalar_i32_udiv_and_negC_eq_X_is_constant3_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(12345 : i32) : i32
  %1 = llvm.mlir.constant(16376 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.udiv %0, %arg7 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "ne" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def scalar_i32_udiv_and_negC_eq_X_is_constant3_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(1544 : i32) : i32
  %1 = llvm.icmp "ult" %arg7, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i32_udiv_and_negC_eq_X_is_constant3_proof : scalar_i32_udiv_and_negC_eq_X_is_constant3_before ⊑ scalar_i32_udiv_and_negC_eq_X_is_constant3_after := by
  unfold scalar_i32_udiv_and_negC_eq_X_is_constant3_before scalar_i32_udiv_and_negC_eq_X_is_constant3_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i32_udiv_and_negC_eq_X_is_constant3
  apply scalar_i32_udiv_and_negC_eq_X_is_constant3_thm
  ---END scalar_i32_udiv_and_negC_eq_X_is_constant3



def scalar_i32_lshr_and_negC_slt_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(-8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg4, %arg5 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "slt" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i32_lshr_and_negC_slt_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.lshr %arg4, %arg5 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i32_lshr_and_negC_slt_proof : scalar_i32_lshr_and_negC_slt_before ⊑ scalar_i32_lshr_and_negC_slt_after := by
  unfold scalar_i32_lshr_and_negC_slt_before scalar_i32_lshr_and_negC_slt_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i32_lshr_and_negC_slt
  apply scalar_i32_lshr_and_negC_slt_thm
  ---END scalar_i32_lshr_and_negC_slt



def scalar_i32_lshr_and_negC_eq_nonzero_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(-8 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.lshr %arg2, %arg3 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i32_lshr_and_negC_eq_nonzero_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i32_lshr_and_negC_eq_nonzero_proof : scalar_i32_lshr_and_negC_eq_nonzero_before ⊑ scalar_i32_lshr_and_negC_eq_nonzero_after := by
  unfold scalar_i32_lshr_and_negC_eq_nonzero_before scalar_i32_lshr_and_negC_eq_nonzero_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i32_lshr_and_negC_eq_nonzero
  apply scalar_i32_lshr_and_negC_eq_nonzero_thm
  ---END scalar_i32_lshr_and_negC_eq_nonzero



def scalar_i8_lshr_and_negC_eq_not_negatedPowerOf2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(-3 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.lshr %arg0, %arg1 : i8
  %3 = llvm.and %2, %0 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i8_lshr_and_negC_eq_not_negatedPowerOf2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(-3 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg1 : i8
  %3 = llvm.and %arg0, %2 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i8_lshr_and_negC_eq_not_negatedPowerOf2_proof : scalar_i8_lshr_and_negC_eq_not_negatedPowerOf2_before ⊑ scalar_i8_lshr_and_negC_eq_not_negatedPowerOf2_after := by
  unfold scalar_i8_lshr_and_negC_eq_not_negatedPowerOf2_before scalar_i8_lshr_and_negC_eq_not_negatedPowerOf2_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i8_lshr_and_negC_eq_not_negatedPowerOf2
  apply scalar_i8_lshr_and_negC_eq_not_negatedPowerOf2_thm
  ---END scalar_i8_lshr_and_negC_eq_not_negatedPowerOf2


