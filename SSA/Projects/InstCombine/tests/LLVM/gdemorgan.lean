
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
section gdemorgan_statements

def demorgan_or_apint1_before := [llvm|
{
^0(%arg62 : i43, %arg63 : i43):
  %0 = llvm.mlir.constant(-1 : i43) : i43
  %1 = llvm.xor %arg62, %0 : i43
  %2 = llvm.xor %arg63, %0 : i43
  %3 = llvm.or %1, %2 : i43
  "llvm.return"(%3) : (i43) -> ()
}
]
def demorgan_or_apint1_after := [llvm|
{
^0(%arg62 : i43, %arg63 : i43):
  %0 = llvm.mlir.constant(-1 : i43) : i43
  %1 = llvm.and %arg62, %arg63 : i43
  %2 = llvm.xor %1, %0 : i43
  "llvm.return"(%2) : (i43) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_or_apint1_proof : demorgan_or_apint1_before ⊑ demorgan_or_apint1_after := by
  unfold demorgan_or_apint1_before demorgan_or_apint1_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_or_apint1
  all_goals (try extract_goal ; sorry)
  ---END demorgan_or_apint1



def demorgan_or_apint2_before := [llvm|
{
^0(%arg60 : i129, %arg61 : i129):
  %0 = llvm.mlir.constant(-1 : i129) : i129
  %1 = llvm.xor %arg60, %0 : i129
  %2 = llvm.xor %arg61, %0 : i129
  %3 = llvm.or %1, %2 : i129
  "llvm.return"(%3) : (i129) -> ()
}
]
def demorgan_or_apint2_after := [llvm|
{
^0(%arg60 : i129, %arg61 : i129):
  %0 = llvm.mlir.constant(-1 : i129) : i129
  %1 = llvm.and %arg60, %arg61 : i129
  %2 = llvm.xor %1, %0 : i129
  "llvm.return"(%2) : (i129) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_or_apint2_proof : demorgan_or_apint2_before ⊑ demorgan_or_apint2_after := by
  unfold demorgan_or_apint2_before demorgan_or_apint2_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_or_apint2
  all_goals (try extract_goal ; sorry)
  ---END demorgan_or_apint2



def demorgan_and_apint1_before := [llvm|
{
^0(%arg58 : i477, %arg59 : i477):
  %0 = llvm.mlir.constant(-1 : i477) : i477
  %1 = llvm.xor %arg58, %0 : i477
  %2 = llvm.xor %arg59, %0 : i477
  %3 = llvm.and %1, %2 : i477
  "llvm.return"(%3) : (i477) -> ()
}
]
def demorgan_and_apint1_after := [llvm|
{
^0(%arg58 : i477, %arg59 : i477):
  %0 = llvm.mlir.constant(-1 : i477) : i477
  %1 = llvm.or %arg58, %arg59 : i477
  %2 = llvm.xor %1, %0 : i477
  "llvm.return"(%2) : (i477) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_and_apint1_proof : demorgan_and_apint1_before ⊑ demorgan_and_apint1_after := by
  unfold demorgan_and_apint1_before demorgan_and_apint1_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_and_apint1
  all_goals (try extract_goal ; sorry)
  ---END demorgan_and_apint1



def demorgan_and_apint2_before := [llvm|
{
^0(%arg56 : i129, %arg57 : i129):
  %0 = llvm.mlir.constant(-1 : i129) : i129
  %1 = llvm.xor %arg56, %0 : i129
  %2 = llvm.xor %arg57, %0 : i129
  %3 = llvm.and %1, %2 : i129
  "llvm.return"(%3) : (i129) -> ()
}
]
def demorgan_and_apint2_after := [llvm|
{
^0(%arg56 : i129, %arg57 : i129):
  %0 = llvm.mlir.constant(-1 : i129) : i129
  %1 = llvm.or %arg56, %arg57 : i129
  %2 = llvm.xor %1, %0 : i129
  "llvm.return"(%2) : (i129) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_and_apint2_proof : demorgan_and_apint2_before ⊑ demorgan_and_apint2_after := by
  unfold demorgan_and_apint2_before demorgan_and_apint2_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_and_apint2
  all_goals (try extract_goal ; sorry)
  ---END demorgan_and_apint2



def demorgan_and_apint3_before := [llvm|
{
^0(%arg54 : i65, %arg55 : i65):
  %0 = llvm.mlir.constant(-1 : i65) : i65
  %1 = llvm.xor %arg54, %0 : i65
  %2 = llvm.xor %0, %arg55 : i65
  %3 = llvm.and %1, %2 : i65
  "llvm.return"(%3) : (i65) -> ()
}
]
def demorgan_and_apint3_after := [llvm|
{
^0(%arg54 : i65, %arg55 : i65):
  %0 = llvm.mlir.constant(-1 : i65) : i65
  %1 = llvm.or %arg54, %arg55 : i65
  %2 = llvm.xor %1, %0 : i65
  "llvm.return"(%2) : (i65) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_and_apint3_proof : demorgan_and_apint3_before ⊑ demorgan_and_apint3_after := by
  unfold demorgan_and_apint3_before demorgan_and_apint3_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_and_apint3
  all_goals (try extract_goal ; sorry)
  ---END demorgan_and_apint3



def demorgan_and_apint4_before := [llvm|
{
^0(%arg52 : i66, %arg53 : i66):
  %0 = llvm.mlir.constant(-1 : i66) : i66
  %1 = llvm.xor %arg52, %0 : i66
  %2 = llvm.xor %arg53, %0 : i66
  %3 = llvm.and %1, %2 : i66
  "llvm.return"(%3) : (i66) -> ()
}
]
def demorgan_and_apint4_after := [llvm|
{
^0(%arg52 : i66, %arg53 : i66):
  %0 = llvm.mlir.constant(-1 : i66) : i66
  %1 = llvm.or %arg52, %arg53 : i66
  %2 = llvm.xor %1, %0 : i66
  "llvm.return"(%2) : (i66) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_and_apint4_proof : demorgan_and_apint4_before ⊑ demorgan_and_apint4_after := by
  unfold demorgan_and_apint4_before demorgan_and_apint4_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_and_apint4
  all_goals (try extract_goal ; sorry)
  ---END demorgan_and_apint4



def demorgan_and_apint5_before := [llvm|
{
^0(%arg50 : i47, %arg51 : i47):
  %0 = llvm.mlir.constant(-1 : i47) : i47
  %1 = llvm.xor %arg50, %0 : i47
  %2 = llvm.xor %arg51, %0 : i47
  %3 = llvm.and %1, %2 : i47
  "llvm.return"(%3) : (i47) -> ()
}
]
def demorgan_and_apint5_after := [llvm|
{
^0(%arg50 : i47, %arg51 : i47):
  %0 = llvm.mlir.constant(-1 : i47) : i47
  %1 = llvm.or %arg50, %arg51 : i47
  %2 = llvm.xor %1, %0 : i47
  "llvm.return"(%2) : (i47) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_and_apint5_proof : demorgan_and_apint5_before ⊑ demorgan_and_apint5_after := by
  unfold demorgan_and_apint5_before demorgan_and_apint5_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_and_apint5
  all_goals (try extract_goal ; sorry)
  ---END demorgan_and_apint5



def test3_before := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg48, %0 : i32
  %2 = llvm.xor %arg49, %0 : i32
  %3 = llvm.and %1, %2 : i32
  %4 = llvm.xor %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.or %arg48, %arg49 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  intros
  ---BEGIN test3
  all_goals (try extract_goal ; sorry)
  ---END test3



def test4_before := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.xor %arg47, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(-6 : i32) : i32
  %1 = llvm.or %arg47, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  intros
  ---BEGIN test4
  all_goals (try extract_goal ; sorry)
  ---END test4



def test5_before := [llvm|
{
^0(%arg45 : i32, %arg46 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg45, %0 : i32
  %2 = llvm.xor %arg46, %0 : i32
  %3 = llvm.or %1, %2 : i32
  %4 = llvm.xor %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg45 : i32, %arg46 : i32):
  %0 = llvm.and %arg45, %arg46 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  intros
  ---BEGIN test5
  all_goals (try extract_goal ; sorry)
  ---END test5



def test3_apint_before := [llvm|
{
^0(%arg43 : i47, %arg44 : i47):
  %0 = llvm.mlir.constant(-1 : i47) : i47
  %1 = llvm.xor %arg43, %0 : i47
  %2 = llvm.xor %arg44, %0 : i47
  %3 = llvm.and %1, %2 : i47
  %4 = llvm.xor %3, %0 : i47
  "llvm.return"(%4) : (i47) -> ()
}
]
def test3_apint_after := [llvm|
{
^0(%arg43 : i47, %arg44 : i47):
  %0 = llvm.or %arg43, %arg44 : i47
  "llvm.return"(%0) : (i47) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_apint_proof : test3_apint_before ⊑ test3_apint_after := by
  unfold test3_apint_before test3_apint_after
  simp_alive_peephole
  intros
  ---BEGIN test3_apint
  all_goals (try extract_goal ; sorry)
  ---END test3_apint



def test4_apint_before := [llvm|
{
^0(%arg42 : i61):
  %0 = llvm.mlir.constant(-1 : i61) : i61
  %1 = llvm.mlir.constant(5 : i61) : i61
  %2 = llvm.xor %arg42, %0 : i61
  %3 = llvm.and %2, %1 : i61
  %4 = llvm.xor %3, %0 : i61
  "llvm.return"(%3) : (i61) -> ()
}
]
def test4_apint_after := [llvm|
{
^0(%arg42 : i61):
  %0 = llvm.mlir.constant(5 : i61) : i61
  %1 = llvm.and %arg42, %0 : i61
  %2 = llvm.xor %1, %0 : i61
  "llvm.return"(%2) : (i61) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4_apint_proof : test4_apint_before ⊑ test4_apint_after := by
  unfold test4_apint_before test4_apint_after
  simp_alive_peephole
  intros
  ---BEGIN test4_apint
  all_goals (try extract_goal ; sorry)
  ---END test4_apint



def test5_apint_before := [llvm|
{
^0(%arg40 : i71, %arg41 : i71):
  %0 = llvm.mlir.constant(-1 : i71) : i71
  %1 = llvm.xor %arg40, %0 : i71
  %2 = llvm.xor %arg41, %0 : i71
  %3 = llvm.or %1, %2 : i71
  %4 = llvm.xor %3, %0 : i71
  "llvm.return"(%4) : (i71) -> ()
}
]
def test5_apint_after := [llvm|
{
^0(%arg40 : i71, %arg41 : i71):
  %0 = llvm.and %arg40, %arg41 : i71
  "llvm.return"(%0) : (i71) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test5_apint_proof : test5_apint_before ⊑ test5_apint_after := by
  unfold test5_apint_before test5_apint_after
  simp_alive_peephole
  intros
  ---BEGIN test5_apint
  all_goals (try extract_goal ; sorry)
  ---END test5_apint



def demorgan_nand_before := [llvm|
{
^0(%arg38 : i8, %arg39 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg38, %0 : i8
  %2 = llvm.and %1, %arg39 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def demorgan_nand_after := [llvm|
{
^0(%arg38 : i8, %arg39 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg39, %0 : i8
  %2 = llvm.or %arg38, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_nand_proof : demorgan_nand_before ⊑ demorgan_nand_after := by
  unfold demorgan_nand_before demorgan_nand_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_nand
  all_goals (try extract_goal ; sorry)
  ---END demorgan_nand



def demorgan_nand_apint1_before := [llvm|
{
^0(%arg36 : i7, %arg37 : i7):
  %0 = llvm.mlir.constant(-1 : i7) : i7
  %1 = llvm.xor %arg36, %0 : i7
  %2 = llvm.and %1, %arg37 : i7
  %3 = llvm.xor %2, %0 : i7
  "llvm.return"(%3) : (i7) -> ()
}
]
def demorgan_nand_apint1_after := [llvm|
{
^0(%arg36 : i7, %arg37 : i7):
  %0 = llvm.mlir.constant(-1 : i7) : i7
  %1 = llvm.xor %arg37, %0 : i7
  %2 = llvm.or %arg36, %1 : i7
  "llvm.return"(%2) : (i7) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_nand_apint1_proof : demorgan_nand_apint1_before ⊑ demorgan_nand_apint1_after := by
  unfold demorgan_nand_apint1_before demorgan_nand_apint1_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_nand_apint1
  all_goals (try extract_goal ; sorry)
  ---END demorgan_nand_apint1



def demorgan_nand_apint2_before := [llvm|
{
^0(%arg34 : i117, %arg35 : i117):
  %0 = llvm.mlir.constant(-1 : i117) : i117
  %1 = llvm.xor %arg34, %0 : i117
  %2 = llvm.and %1, %arg35 : i117
  %3 = llvm.xor %2, %0 : i117
  "llvm.return"(%3) : (i117) -> ()
}
]
def demorgan_nand_apint2_after := [llvm|
{
^0(%arg34 : i117, %arg35 : i117):
  %0 = llvm.mlir.constant(-1 : i117) : i117
  %1 = llvm.xor %arg35, %0 : i117
  %2 = llvm.or %arg34, %1 : i117
  "llvm.return"(%2) : (i117) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_nand_apint2_proof : demorgan_nand_apint2_before ⊑ demorgan_nand_apint2_after := by
  unfold demorgan_nand_apint2_before demorgan_nand_apint2_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_nand_apint2
  all_goals (try extract_goal ; sorry)
  ---END demorgan_nand_apint2



def demorgan_nor_before := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg32, %0 : i8
  %2 = llvm.or %1, %arg33 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def demorgan_nor_after := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg33, %0 : i8
  %2 = llvm.and %arg32, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_nor_proof : demorgan_nor_before ⊑ demorgan_nor_after := by
  unfold demorgan_nor_before demorgan_nor_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_nor
  all_goals (try extract_goal ; sorry)
  ---END demorgan_nor



def demorgan_nor_use2a_before := [llvm|
{
^0(%arg30 : i8, %arg31 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(23 : i8) : i8
  %2 = llvm.xor %arg30, %0 : i8
  %3 = llvm.mul %2, %1 : i8
  %4 = llvm.or %2, %arg31 : i8
  %5 = llvm.xor %4, %0 : i8
  %6 = llvm.sdiv %5, %3 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def demorgan_nor_use2a_after := [llvm|
{
^0(%arg30 : i8, %arg31 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(23 : i8) : i8
  %2 = llvm.xor %arg30, %0 : i8
  %3 = llvm.mul %2, %1 : i8
  %4 = llvm.xor %arg31, %0 : i8
  %5 = llvm.and %arg30, %4 : i8
  %6 = llvm.sdiv %5, %3 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_nor_use2a_proof : demorgan_nor_use2a_before ⊑ demorgan_nor_use2a_after := by
  unfold demorgan_nor_use2a_before demorgan_nor_use2a_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_nor_use2a
  all_goals (try extract_goal ; sorry)
  ---END demorgan_nor_use2a



def demorgan_nor_use2b_before := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(23 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mul %arg29, %0 : i8
  %3 = llvm.xor %arg28, %1 : i8
  %4 = llvm.or %3, %arg29 : i8
  %5 = llvm.xor %4, %1 : i8
  %6 = llvm.sdiv %5, %2 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def demorgan_nor_use2b_after := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(23 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mul %arg29, %0 : i8
  %3 = llvm.xor %arg29, %1 : i8
  %4 = llvm.and %arg28, %3 : i8
  %5 = llvm.sdiv %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_nor_use2b_proof : demorgan_nor_use2b_before ⊑ demorgan_nor_use2b_after := by
  unfold demorgan_nor_use2b_before demorgan_nor_use2b_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_nor_use2b
  all_goals (try extract_goal ; sorry)
  ---END demorgan_nor_use2b



def demorgan_nor_use2c_before := [llvm|
{
^0(%arg26 : i8, %arg27 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(23 : i8) : i8
  %2 = llvm.xor %arg26, %0 : i8
  %3 = llvm.or %2, %arg27 : i8
  %4 = llvm.mul %3, %1 : i8
  %5 = llvm.xor %3, %0 : i8
  %6 = llvm.sdiv %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def demorgan_nor_use2c_after := [llvm|
{
^0(%arg26 : i8, %arg27 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(23 : i8) : i8
  %2 = llvm.xor %arg26, %0 : i8
  %3 = llvm.or %arg27, %2 : i8
  %4 = llvm.mul %3, %1 : i8
  %5 = llvm.xor %3, %0 : i8
  %6 = llvm.sdiv %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_nor_use2c_proof : demorgan_nor_use2c_before ⊑ demorgan_nor_use2c_after := by
  unfold demorgan_nor_use2c_before demorgan_nor_use2c_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_nor_use2c
  all_goals (try extract_goal ; sorry)
  ---END demorgan_nor_use2c



def demorgan_nor_use2ab_before := [llvm|
{
^0(%arg24 : i8, %arg25 : i8):
  %0 = llvm.mlir.constant(23 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(17 : i8) : i8
  %3 = llvm.mul %arg25, %0 : i8
  %4 = llvm.xor %arg24, %1 : i8
  %5 = llvm.mul %4, %2 : i8
  %6 = llvm.or %4, %arg25 : i8
  %7 = llvm.xor %6, %1 : i8
  %8 = llvm.sdiv %7, %3 : i8
  %9 = llvm.sdiv %8, %5 : i8
  "llvm.return"(%9) : (i8) -> ()
}
]
def demorgan_nor_use2ab_after := [llvm|
{
^0(%arg24 : i8, %arg25 : i8):
  %0 = llvm.mlir.constant(23 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(17 : i8) : i8
  %3 = llvm.mul %arg25, %0 : i8
  %4 = llvm.xor %arg24, %1 : i8
  %5 = llvm.mul %4, %2 : i8
  %6 = llvm.xor %arg25, %1 : i8
  %7 = llvm.and %arg24, %6 : i8
  %8 = llvm.sdiv %7, %3 : i8
  %9 = llvm.sdiv %8, %5 : i8
  "llvm.return"(%9) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_nor_use2ab_proof : demorgan_nor_use2ab_before ⊑ demorgan_nor_use2ab_after := by
  unfold demorgan_nor_use2ab_before demorgan_nor_use2ab_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_nor_use2ab
  all_goals (try extract_goal ; sorry)
  ---END demorgan_nor_use2ab



def demorgan_nor_use2ac_before := [llvm|
{
^0(%arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(17 : i8) : i8
  %2 = llvm.mlir.constant(23 : i8) : i8
  %3 = llvm.xor %arg22, %0 : i8
  %4 = llvm.mul %3, %1 : i8
  %5 = llvm.or %3, %arg23 : i8
  %6 = llvm.mul %5, %2 : i8
  %7 = llvm.xor %5, %0 : i8
  %8 = llvm.sdiv %7, %6 : i8
  %9 = llvm.sdiv %8, %4 : i8
  "llvm.return"(%9) : (i8) -> ()
}
]
def demorgan_nor_use2ac_after := [llvm|
{
^0(%arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(17 : i8) : i8
  %2 = llvm.mlir.constant(23 : i8) : i8
  %3 = llvm.xor %arg22, %0 : i8
  %4 = llvm.mul %3, %1 : i8
  %5 = llvm.or %arg23, %3 : i8
  %6 = llvm.mul %5, %2 : i8
  %7 = llvm.xor %5, %0 : i8
  %8 = llvm.sdiv %7, %6 : i8
  %9 = llvm.sdiv %8, %4 : i8
  "llvm.return"(%9) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_nor_use2ac_proof : demorgan_nor_use2ac_before ⊑ demorgan_nor_use2ac_after := by
  unfold demorgan_nor_use2ac_before demorgan_nor_use2ac_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_nor_use2ac
  all_goals (try extract_goal ; sorry)
  ---END demorgan_nor_use2ac



def demorgan_nor_use2bc_before := [llvm|
{
^0(%arg20 : i8, %arg21 : i8):
  %0 = llvm.mlir.constant(23 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mul %arg21, %0 : i8
  %3 = llvm.xor %arg20, %1 : i8
  %4 = llvm.or %3, %arg21 : i8
  %5 = llvm.mul %4, %0 : i8
  %6 = llvm.xor %4, %1 : i8
  %7 = llvm.sdiv %6, %5 : i8
  %8 = llvm.sdiv %7, %2 : i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def demorgan_nor_use2bc_after := [llvm|
{
^0(%arg20 : i8, %arg21 : i8):
  %0 = llvm.mlir.constant(23 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mul %arg21, %0 : i8
  %3 = llvm.xor %arg20, %1 : i8
  %4 = llvm.or %arg21, %3 : i8
  %5 = llvm.mul %4, %0 : i8
  %6 = llvm.xor %4, %1 : i8
  %7 = llvm.sdiv %6, %5 : i8
  %8 = llvm.sdiv %7, %2 : i8
  "llvm.return"(%8) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_nor_use2bc_proof : demorgan_nor_use2bc_before ⊑ demorgan_nor_use2bc_after := by
  unfold demorgan_nor_use2bc_before demorgan_nor_use2bc_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_nor_use2bc
  all_goals (try extract_goal ; sorry)
  ---END demorgan_nor_use2bc



def demorganize_constant2_before := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.or %arg18, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def demorganize_constant2_after := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(-16 : i32) : i32
  %1 = llvm.and %arg18, %0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorganize_constant2_proof : demorganize_constant2_before ⊑ demorganize_constant2_after := by
  unfold demorganize_constant2_before demorganize_constant2_after
  simp_alive_peephole
  intros
  ---BEGIN demorganize_constant2
  all_goals (try extract_goal ; sorry)
  ---END demorganize_constant2



def demorgan_or_zext_before := [llvm|
{
^0(%arg16 : i1, %arg17 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.zext %arg16 : i1 to i32
  %2 = llvm.zext %arg17 : i1 to i32
  %3 = llvm.xor %1, %0 : i32
  %4 = llvm.xor %2, %0 : i32
  %5 = llvm.or %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def demorgan_or_zext_after := [llvm|
{
^0(%arg16 : i1, %arg17 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg16, %arg17 : i1
  %2 = llvm.xor %1, %0 : i1
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_or_zext_proof : demorgan_or_zext_before ⊑ demorgan_or_zext_after := by
  unfold demorgan_or_zext_before demorgan_or_zext_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_or_zext
  all_goals (try extract_goal ; sorry)
  ---END demorgan_or_zext



def demorgan_and_zext_before := [llvm|
{
^0(%arg14 : i1, %arg15 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.zext %arg14 : i1 to i32
  %2 = llvm.zext %arg15 : i1 to i32
  %3 = llvm.xor %1, %0 : i32
  %4 = llvm.xor %2, %0 : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def demorgan_and_zext_after := [llvm|
{
^0(%arg14 : i1, %arg15 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.or %arg14, %arg15 : i1
  %2 = llvm.xor %1, %0 : i1
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_and_zext_proof : demorgan_and_zext_before ⊑ demorgan_and_zext_after := by
  unfold demorgan_and_zext_before demorgan_and_zext_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_and_zext
  all_goals (try extract_goal ; sorry)
  ---END demorgan_and_zext



def PR28476_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.icmp "ne" %arg8, %0 : i32
  %3 = llvm.icmp "ne" %arg9, %0 : i32
  %4 = llvm.and %2, %3 : i1
  %5 = llvm.zext %4 : i1 to i32
  %6 = llvm.xor %5, %1 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def PR28476_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg8, %0 : i32
  %2 = llvm.icmp "eq" %arg9, %0 : i32
  %3 = llvm.or %1, %2 : i1
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR28476_proof : PR28476_before ⊑ PR28476_after := by
  unfold PR28476_before PR28476_after
  simp_alive_peephole
  intros
  ---BEGIN PR28476
  all_goals (try extract_goal ; sorry)
  ---END PR28476



def PR28476_logical_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.icmp "ne" %arg6, %0 : i32
  %4 = llvm.icmp "ne" %arg7, %0 : i32
  %5 = "llvm.select"(%3, %4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.zext %5 : i1 to i32
  %7 = llvm.xor %6, %2 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def PR28476_logical_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "eq" %arg6, %0 : i32
  %3 = llvm.icmp "eq" %arg7, %0 : i32
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR28476_logical_proof : PR28476_logical_before ⊑ PR28476_logical_after := by
  unfold PR28476_logical_before PR28476_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR28476_logical
  all_goals (try extract_goal ; sorry)
  ---END PR28476_logical



def demorgan_plus_and_to_xor_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg5, %arg4 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg5, %arg4 : i32
  %4 = llvm.or %3, %2 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def demorgan_plus_and_to_xor_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.xor %arg5, %arg4 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem demorgan_plus_and_to_xor_proof : demorgan_plus_and_to_xor_before ⊑ demorgan_plus_and_to_xor_after := by
  unfold demorgan_plus_and_to_xor_before demorgan_plus_and_to_xor_after
  simp_alive_peephole
  intros
  ---BEGIN demorgan_plus_and_to_xor
  all_goals (try extract_goal ; sorry)
  ---END demorgan_plus_and_to_xor



def PR45984_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.or %arg1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def PR45984_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR45984_proof : PR45984_before ⊑ PR45984_after := by
  unfold PR45984_before PR45984_after
  simp_alive_peephole
  intros
  ---BEGIN PR45984
  all_goals (try extract_goal ; sorry)
  ---END PR45984


