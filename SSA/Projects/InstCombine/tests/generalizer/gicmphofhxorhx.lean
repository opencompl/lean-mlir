import SSA.Projects.InstCombine.tests.proofs.gicmphofhxorhx_proof
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
section gicmphofhxorhx_statements

def test_xor_ne_before := [llvm|
{
^0(%arg64 : i8, %arg65 : i8, %arg66 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg66, %0 : i8
  %2 = llvm.xor %arg65, %0 : i8
  %3 = llvm.xor %2, %arg64 : i8
  %4 = llvm.icmp "ne" %1, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def test_xor_ne_after := [llvm|
{
^0(%arg64 : i8, %arg65 : i8, %arg66 : i8):
  %0 = llvm.xor %arg65, %arg64 : i8
  %1 = llvm.icmp "ne" %arg66, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_xor_ne_proof : test_xor_ne_before ⊑ test_xor_ne_after := by
  unfold test_xor_ne_before test_xor_ne_after
  simp_alive_peephole
  intros
  ---BEGIN test_xor_ne
  apply test_xor_ne_thm
  ---END test_xor_ne



def test_xor_eq_before := [llvm|
{
^0(%arg61 : i8, %arg62 : i8, %arg63 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg63, %0 : i8
  %2 = llvm.xor %arg62, %0 : i8
  %3 = llvm.xor %2, %arg61 : i8
  %4 = llvm.icmp "eq" %1, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def test_xor_eq_after := [llvm|
{
^0(%arg61 : i8, %arg62 : i8, %arg63 : i8):
  %0 = llvm.xor %arg62, %arg61 : i8
  %1 = llvm.icmp "eq" %arg63, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_xor_eq_proof : test_xor_eq_before ⊑ test_xor_eq_after := by
  unfold test_xor_eq_before test_xor_eq_after
  simp_alive_peephole
  intros
  ---BEGIN test_xor_eq
  apply test_xor_eq_thm
  ---END test_xor_eq



def test_slt_xor_before := [llvm|
{
^0(%arg44 : i32, %arg45 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg44, %0 : i32
  %2 = llvm.xor %1, %arg45 : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_slt_xor_after := [llvm|
{
^0(%arg44 : i32, %arg45 : i32):
  %0 = llvm.xor %arg45, %arg44 : i32
  %1 = llvm.icmp "sgt" %0, %arg44 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_slt_xor_proof : test_slt_xor_before ⊑ test_slt_xor_after := by
  unfold test_slt_xor_before test_slt_xor_after
  simp_alive_peephole
  intros
  ---BEGIN test_slt_xor
  apply test_slt_xor_thm
  ---END test_slt_xor



def test_sle_xor_before := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg43, %0 : i32
  %2 = llvm.xor %1, %arg42 : i32
  %3 = llvm.icmp "sle" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_sle_xor_after := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.xor %arg42, %arg43 : i32
  %1 = llvm.icmp "sge" %0, %arg43 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sle_xor_proof : test_sle_xor_before ⊑ test_sle_xor_after := by
  unfold test_sle_xor_before test_sle_xor_after
  simp_alive_peephole
  intros
  ---BEGIN test_sle_xor
  apply test_sle_xor_thm
  ---END test_sle_xor



def test_sgt_xor_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg40, %0 : i32
  %2 = llvm.xor %1, %arg41 : i32
  %3 = llvm.icmp "sgt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_sgt_xor_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.xor %arg41, %arg40 : i32
  %1 = llvm.icmp "slt" %0, %arg40 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sgt_xor_proof : test_sgt_xor_before ⊑ test_sgt_xor_after := by
  unfold test_sgt_xor_before test_sgt_xor_after
  simp_alive_peephole
  intros
  ---BEGIN test_sgt_xor
  apply test_sgt_xor_thm
  ---END test_sgt_xor



def test_sge_xor_before := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg38, %0 : i32
  %2 = llvm.xor %1, %arg39 : i32
  %3 = llvm.icmp "sge" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_sge_xor_after := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.xor %arg39, %arg38 : i32
  %1 = llvm.icmp "sle" %0, %arg38 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sge_xor_proof : test_sge_xor_before ⊑ test_sge_xor_after := by
  unfold test_sge_xor_before test_sge_xor_after
  simp_alive_peephole
  intros
  ---BEGIN test_sge_xor
  apply test_sge_xor_thm
  ---END test_sge_xor



def test_ult_xor_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg36, %0 : i32
  %2 = llvm.xor %1, %arg37 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_ult_xor_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.xor %arg37, %arg36 : i32
  %1 = llvm.icmp "ugt" %0, %arg36 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_ult_xor_proof : test_ult_xor_before ⊑ test_ult_xor_after := by
  unfold test_ult_xor_before test_ult_xor_after
  simp_alive_peephole
  intros
  ---BEGIN test_ult_xor
  apply test_ult_xor_thm
  ---END test_ult_xor



def test_ule_xor_before := [llvm|
{
^0(%arg34 : i32, %arg35 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg34, %0 : i32
  %2 = llvm.xor %1, %arg35 : i32
  %3 = llvm.icmp "ule" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_ule_xor_after := [llvm|
{
^0(%arg34 : i32, %arg35 : i32):
  %0 = llvm.xor %arg35, %arg34 : i32
  %1 = llvm.icmp "uge" %0, %arg34 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_ule_xor_proof : test_ule_xor_before ⊑ test_ule_xor_after := by
  unfold test_ule_xor_before test_ule_xor_after
  simp_alive_peephole
  intros
  ---BEGIN test_ule_xor
  apply test_ule_xor_thm
  ---END test_ule_xor



def test_ugt_xor_before := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg32, %0 : i32
  %2 = llvm.xor %1, %arg33 : i32
  %3 = llvm.icmp "ugt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_ugt_xor_after := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  %0 = llvm.xor %arg33, %arg32 : i32
  %1 = llvm.icmp "ult" %0, %arg32 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_ugt_xor_proof : test_ugt_xor_before ⊑ test_ugt_xor_after := by
  unfold test_ugt_xor_before test_ugt_xor_after
  simp_alive_peephole
  intros
  ---BEGIN test_ugt_xor
  apply test_ugt_xor_thm
  ---END test_ugt_xor



def test_uge_xor_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg30, %0 : i32
  %2 = llvm.xor %1, %arg31 : i32
  %3 = llvm.icmp "uge" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_uge_xor_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.xor %arg31, %arg30 : i32
  %1 = llvm.icmp "ule" %0, %arg30 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_uge_xor_proof : test_uge_xor_before ⊑ test_uge_xor_after := by
  unfold test_uge_xor_before test_uge_xor_after
  simp_alive_peephole
  intros
  ---BEGIN test_uge_xor
  apply test_uge_xor_thm
  ---END test_uge_xor



def xor_sge_before := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mul %arg16, %arg16 : i8
  %2 = llvm.or %arg17, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.icmp "sge" %1, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_sge_after := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mul %arg16, %arg16 : i8
  %2 = llvm.or %arg17, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.icmp "slt" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_sge_proof : xor_sge_before ⊑ xor_sge_after := by
  unfold xor_sge_before xor_sge_after
  simp_alive_peephole
  intros
  ---BEGIN xor_sge
  apply xor_sge_thm
  ---END xor_sge



def xor_ugt_2_before := [llvm|
{
^0(%arg13 : i8, %arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(63 : i8) : i8
  %1 = llvm.mlir.constant(64 : i8) : i8
  %2 = llvm.add %arg13, %arg15 : i8
  %3 = llvm.and %arg14, %0 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.xor %2, %4 : i8
  %6 = llvm.icmp "ugt" %2, %5 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def xor_ugt_2_after := [llvm|
{
^0(%arg13 : i8, %arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(63 : i8) : i8
  %1 = llvm.mlir.constant(64 : i8) : i8
  %2 = llvm.add %arg13, %arg15 : i8
  %3 = llvm.and %arg14, %0 : i8
  %4 = llvm.or disjoint %3, %1 : i8
  %5 = llvm.xor %2, %4 : i8
  %6 = llvm.icmp "ugt" %2, %5 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_ugt_2_proof : xor_ugt_2_before ⊑ xor_ugt_2_after := by
  unfold xor_ugt_2_before xor_ugt_2_after
  simp_alive_peephole
  intros
  ---BEGIN xor_ugt_2
  apply xor_ugt_2_thm
  ---END xor_ugt_2


