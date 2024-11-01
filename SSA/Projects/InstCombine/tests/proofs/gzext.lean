import SSA.Projects.InstCombine.tests.proofs.gzext_proof
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
section gzext_statements

def test_sext_zext_before := [llvm|
{
^0(%arg105 : i16):
  %0 = llvm.zext %arg105 : i16 to i32
  %1 = llvm.sext %0 : i32 to i64
  "llvm.return"(%1) : (i64) -> ()
}
]
def test_sext_zext_after := [llvm|
{
^0(%arg105 : i16):
  %0 = llvm.zext %arg105 : i16 to i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sext_zext_proof : test_sext_zext_before ⊑ test_sext_zext_after := by
  unfold test_sext_zext_before test_sext_zext_after
  simp_alive_peephole
  intros
  ---BEGIN test_sext_zext
  apply test_sext_zext_thm
  ---END test_sext_zext



def fold_xor_zext_sandwich_before := [llvm|
{
^0(%arg101 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.zext %arg101 : i1 to i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.zext %2 : i32 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def fold_xor_zext_sandwich_after := [llvm|
{
^0(%arg101 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg101, %0 : i1
  %2 = llvm.zext %1 : i1 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_xor_zext_sandwich_proof : fold_xor_zext_sandwich_before ⊑ fold_xor_zext_sandwich_after := by
  unfold fold_xor_zext_sandwich_before fold_xor_zext_sandwich_after
  simp_alive_peephole
  intros
  ---BEGIN fold_xor_zext_sandwich
  apply fold_xor_zext_sandwich_thm
  ---END fold_xor_zext_sandwich



def sext_zext_apint1_before := [llvm|
{
^0(%arg86 : i77):
  %0 = llvm.zext %arg86 : i77 to i533
  %1 = llvm.sext %0 : i533 to i1024
  "llvm.return"(%1) : (i1024) -> ()
}
]
def sext_zext_apint1_after := [llvm|
{
^0(%arg86 : i77):
  %0 = llvm.zext %arg86 : i77 to i1024
  "llvm.return"(%0) : (i1024) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_zext_apint1_proof : sext_zext_apint1_before ⊑ sext_zext_apint1_after := by
  unfold sext_zext_apint1_before sext_zext_apint1_after
  simp_alive_peephole
  intros
  ---BEGIN sext_zext_apint1
  apply sext_zext_apint1_thm
  ---END sext_zext_apint1



def sext_zext_apint2_before := [llvm|
{
^0(%arg85 : i11):
  %0 = llvm.zext %arg85 : i11 to i39
  %1 = llvm.sext %0 : i39 to i47
  "llvm.return"(%1) : (i47) -> ()
}
]
def sext_zext_apint2_after := [llvm|
{
^0(%arg85 : i11):
  %0 = llvm.zext %arg85 : i11 to i47
  "llvm.return"(%0) : (i47) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_zext_apint2_proof : sext_zext_apint2_before ⊑ sext_zext_apint2_after := by
  unfold sext_zext_apint2_before sext_zext_apint2_after
  simp_alive_peephole
  intros
  ---BEGIN sext_zext_apint2
  apply sext_zext_apint2_thm
  ---END sext_zext_apint2



def zext_nneg_flag_drop_before := [llvm|
{
^0(%arg7 : i8, %arg8 : i16):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(128 : i16) : i16
  %2 = llvm.and %arg7, %0 : i8
  %3 = llvm.zext %2 : i8 to i16
  %4 = llvm.or %3, %arg8 : i16
  %5 = llvm.or %4, %1 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def zext_nneg_flag_drop_after := [llvm|
{
^0(%arg7 : i8, %arg8 : i16):
  %0 = llvm.mlir.constant(128 : i16) : i16
  %1 = llvm.zext %arg7 : i8 to i16
  %2 = llvm.or %arg8, %1 : i16
  %3 = llvm.or %2, %0 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_flag_drop_proof : zext_nneg_flag_drop_before ⊑ zext_nneg_flag_drop_after := by
  unfold zext_nneg_flag_drop_before zext_nneg_flag_drop_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg_flag_drop
  apply zext_nneg_flag_drop_thm
  ---END zext_nneg_flag_drop



def zext_nneg_redundant_and_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(127 : i32) : i32
  %1 = llvm.zext %arg6 : i8 to i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def zext_nneg_redundant_and_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.zext %arg6 : i8 to i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_redundant_and_proof : zext_nneg_redundant_and_before ⊑ zext_nneg_redundant_and_after := by
  unfold zext_nneg_redundant_and_before zext_nneg_redundant_and_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg_redundant_and
  apply zext_nneg_redundant_and_thm
  ---END zext_nneg_redundant_and



def zext_nneg_signbit_extract_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(31) : i64
  %1 = llvm.zext %arg4 : i32 to i64
  %2 = llvm.lshr %1, %0 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def zext_nneg_signbit_extract_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(0) : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_signbit_extract_proof : zext_nneg_signbit_extract_before ⊑ zext_nneg_signbit_extract_after := by
  unfold zext_nneg_signbit_extract_before zext_nneg_signbit_extract_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg_signbit_extract
  apply zext_nneg_signbit_extract_thm
  ---END zext_nneg_signbit_extract



def zext_nneg_i1_before := [llvm|
{
^0(%arg2 : i1):
  %0 = llvm.zext %arg2 : i1 to i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def zext_nneg_i1_after := [llvm|
{
^0(%arg2 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_nneg_i1_proof : zext_nneg_i1_before ⊑ zext_nneg_i1_after := by
  unfold zext_nneg_i1_before zext_nneg_i1_after
  simp_alive_peephole
  intros
  ---BEGIN zext_nneg_i1
  apply zext_nneg_i1_thm
  ---END zext_nneg_i1


