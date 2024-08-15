import SSA.Projects.InstCombine.tests.LLVM.gdemorgan_proof
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
                                                                       
def demorgan_or_apint1_before := [llvm|
{
^0(%arg0 : i43, %arg1 : i43):
  %0 = "llvm.mlir.constant"() <{value = -1 : i43}> : () -> i43
  %1 = llvm.xor %arg0, %0 : i43
  %2 = llvm.xor %arg1, %0 : i43
  %3 = llvm.or %1, %2 : i43
  "llvm.return"(%3) : (i43) -> ()
}
]
def demorgan_or_apint1_after := [llvm|
{
^0(%arg0 : i43, %arg1 : i43):
  %0 = "llvm.mlir.constant"() <{value = -1 : i43}> : () -> i43
  %1 = llvm.and %arg0, %arg1 : i43
  %2 = llvm.xor %1, %0 : i43
  "llvm.return"(%2) : (i43) -> ()
}
]
theorem demorgan_or_apint1_proof : demorgan_or_apint1_before ⊑ demorgan_or_apint1_after := by
  unfold demorgan_or_apint1_before demorgan_or_apint1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_or_apint1
  apply demorgan_or_apint1_thm
  ---END demorgan_or_apint1



def demorgan_or_apint2_before := [llvm|
{
^0(%arg0 : i129, %arg1 : i129):
  %0 = "llvm.mlir.constant"() <{value = -1 : i129}> : () -> i129
  %1 = llvm.xor %arg0, %0 : i129
  %2 = llvm.xor %arg1, %0 : i129
  %3 = llvm.or %1, %2 : i129
  "llvm.return"(%3) : (i129) -> ()
}
]
def demorgan_or_apint2_after := [llvm|
{
^0(%arg0 : i129, %arg1 : i129):
  %0 = "llvm.mlir.constant"() <{value = -1 : i129}> : () -> i129
  %1 = llvm.and %arg0, %arg1 : i129
  %2 = llvm.xor %1, %0 : i129
  "llvm.return"(%2) : (i129) -> ()
}
]
theorem demorgan_or_apint2_proof : demorgan_or_apint2_before ⊑ demorgan_or_apint2_after := by
  unfold demorgan_or_apint2_before demorgan_or_apint2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_or_apint2
  apply demorgan_or_apint2_thm
  ---END demorgan_or_apint2



def demorgan_and_apint1_before := [llvm|
{
^0(%arg0 : i477, %arg1 : i477):
  %0 = "llvm.mlir.constant"() <{value = -1 : i477}> : () -> i477
  %1 = llvm.xor %arg0, %0 : i477
  %2 = llvm.xor %arg1, %0 : i477
  %3 = llvm.and %1, %2 : i477
  "llvm.return"(%3) : (i477) -> ()
}
]
def demorgan_and_apint1_after := [llvm|
{
^0(%arg0 : i477, %arg1 : i477):
  %0 = "llvm.mlir.constant"() <{value = -1 : i477}> : () -> i477
  %1 = llvm.or %arg0, %arg1 : i477
  %2 = llvm.xor %1, %0 : i477
  "llvm.return"(%2) : (i477) -> ()
}
]
theorem demorgan_and_apint1_proof : demorgan_and_apint1_before ⊑ demorgan_and_apint1_after := by
  unfold demorgan_and_apint1_before demorgan_and_apint1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_and_apint1
  apply demorgan_and_apint1_thm
  ---END demorgan_and_apint1



def demorgan_and_apint2_before := [llvm|
{
^0(%arg0 : i129, %arg1 : i129):
  %0 = "llvm.mlir.constant"() <{value = -1 : i129}> : () -> i129
  %1 = llvm.xor %arg0, %0 : i129
  %2 = llvm.xor %arg1, %0 : i129
  %3 = llvm.and %1, %2 : i129
  "llvm.return"(%3) : (i129) -> ()
}
]
def demorgan_and_apint2_after := [llvm|
{
^0(%arg0 : i129, %arg1 : i129):
  %0 = "llvm.mlir.constant"() <{value = -1 : i129}> : () -> i129
  %1 = llvm.or %arg0, %arg1 : i129
  %2 = llvm.xor %1, %0 : i129
  "llvm.return"(%2) : (i129) -> ()
}
]
theorem demorgan_and_apint2_proof : demorgan_and_apint2_before ⊑ demorgan_and_apint2_after := by
  unfold demorgan_and_apint2_before demorgan_and_apint2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_and_apint2
  apply demorgan_and_apint2_thm
  ---END demorgan_and_apint2



def demorgan_and_apint3_before := [llvm|
{
^0(%arg0 : i65, %arg1 : i65):
  %0 = "llvm.mlir.constant"() <{value = -1 : i65}> : () -> i65
  %1 = llvm.xor %arg0, %0 : i65
  %2 = llvm.xor %0, %arg1 : i65
  %3 = llvm.and %1, %2 : i65
  "llvm.return"(%3) : (i65) -> ()
}
]
def demorgan_and_apint3_after := [llvm|
{
^0(%arg0 : i65, %arg1 : i65):
  %0 = "llvm.mlir.constant"() <{value = -1 : i65}> : () -> i65
  %1 = llvm.or %arg0, %arg1 : i65
  %2 = llvm.xor %1, %0 : i65
  "llvm.return"(%2) : (i65) -> ()
}
]
theorem demorgan_and_apint3_proof : demorgan_and_apint3_before ⊑ demorgan_and_apint3_after := by
  unfold demorgan_and_apint3_before demorgan_and_apint3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_and_apint3
  apply demorgan_and_apint3_thm
  ---END demorgan_and_apint3



def demorgan_and_apint4_before := [llvm|
{
^0(%arg0 : i66, %arg1 : i66):
  %0 = "llvm.mlir.constant"() <{value = -1 : i66}> : () -> i66
  %1 = llvm.xor %arg0, %0 : i66
  %2 = llvm.xor %arg1, %0 : i66
  %3 = llvm.and %1, %2 : i66
  "llvm.return"(%3) : (i66) -> ()
}
]
def demorgan_and_apint4_after := [llvm|
{
^0(%arg0 : i66, %arg1 : i66):
  %0 = "llvm.mlir.constant"() <{value = -1 : i66}> : () -> i66
  %1 = llvm.or %arg0, %arg1 : i66
  %2 = llvm.xor %1, %0 : i66
  "llvm.return"(%2) : (i66) -> ()
}
]
theorem demorgan_and_apint4_proof : demorgan_and_apint4_before ⊑ demorgan_and_apint4_after := by
  unfold demorgan_and_apint4_before demorgan_and_apint4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_and_apint4
  apply demorgan_and_apint4_thm
  ---END demorgan_and_apint4



def demorgan_and_apint5_before := [llvm|
{
^0(%arg0 : i47, %arg1 : i47):
  %0 = "llvm.mlir.constant"() <{value = -1 : i47}> : () -> i47
  %1 = llvm.xor %arg0, %0 : i47
  %2 = llvm.xor %arg1, %0 : i47
  %3 = llvm.and %1, %2 : i47
  "llvm.return"(%3) : (i47) -> ()
}
]
def demorgan_and_apint5_after := [llvm|
{
^0(%arg0 : i47, %arg1 : i47):
  %0 = "llvm.mlir.constant"() <{value = -1 : i47}> : () -> i47
  %1 = llvm.or %arg0, %arg1 : i47
  %2 = llvm.xor %1, %0 : i47
  "llvm.return"(%2) : (i47) -> ()
}
]
theorem demorgan_and_apint5_proof : demorgan_and_apint5_before ⊑ demorgan_and_apint5_after := by
  unfold demorgan_and_apint5_before demorgan_and_apint5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_and_apint5
  apply demorgan_and_apint5_thm
  ---END demorgan_and_apint5



def test3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.and %1, %2 : i32
  %4 = llvm.xor %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test3
  apply test3_thm
  ---END test3



def test4_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -6 : i32}> : () -> i32
  %1 = llvm.or %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test4
  apply test4_thm
  ---END test4



def test5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.or %1, %2 : i32
  %4 = llvm.xor %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test5
  apply test5_thm
  ---END test5



def test3_apint_before := [llvm|
{
^0(%arg0 : i47, %arg1 : i47):
  %0 = "llvm.mlir.constant"() <{value = -1 : i47}> : () -> i47
  %1 = llvm.xor %arg0, %0 : i47
  %2 = llvm.xor %arg1, %0 : i47
  %3 = llvm.and %1, %2 : i47
  %4 = llvm.xor %3, %0 : i47
  "llvm.return"(%4) : (i47) -> ()
}
]
def test3_apint_after := [llvm|
{
^0(%arg0 : i47, %arg1 : i47):
  %0 = llvm.or %arg0, %arg1 : i47
  "llvm.return"(%0) : (i47) -> ()
}
]
theorem test3_apint_proof : test3_apint_before ⊑ test3_apint_after := by
  unfold test3_apint_before test3_apint_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test3_apint
  apply test3_apint_thm
  ---END test3_apint



def test4_apint_before := [llvm|
{
^0(%arg0 : i61):
  %0 = "llvm.mlir.constant"() <{value = -1 : i61}> : () -> i61
  %1 = "llvm.mlir.constant"() <{value = 5 : i61}> : () -> i61
  %2 = llvm.xor %arg0, %0 : i61
  %3 = llvm.and %2, %1 : i61
  %4 = llvm.xor %3, %0 : i61
  "llvm.return"(%3) : (i61) -> ()
}
]
def test4_apint_after := [llvm|
{
^0(%arg0 : i61):
  %0 = "llvm.mlir.constant"() <{value = 5 : i61}> : () -> i61
  %1 = llvm.and %arg0, %0 : i61
  %2 = llvm.xor %1, %0 : i61
  "llvm.return"(%2) : (i61) -> ()
}
]
theorem test4_apint_proof : test4_apint_before ⊑ test4_apint_after := by
  unfold test4_apint_before test4_apint_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test4_apint
  apply test4_apint_thm
  ---END test4_apint



def test5_apint_before := [llvm|
{
^0(%arg0 : i71, %arg1 : i71):
  %0 = "llvm.mlir.constant"() <{value = -1 : i71}> : () -> i71
  %1 = llvm.xor %arg0, %0 : i71
  %2 = llvm.xor %arg1, %0 : i71
  %3 = llvm.or %1, %2 : i71
  %4 = llvm.xor %3, %0 : i71
  "llvm.return"(%4) : (i71) -> ()
}
]
def test5_apint_after := [llvm|
{
^0(%arg0 : i71, %arg1 : i71):
  %0 = llvm.and %arg0, %arg1 : i71
  "llvm.return"(%0) : (i71) -> ()
}
]
theorem test5_apint_proof : test5_apint_before ⊑ test5_apint_after := by
  unfold test5_apint_before test5_apint_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test5_apint
  apply test5_apint_thm
  ---END test5_apint



def demorgan_nand_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.and %1, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def demorgan_nand_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.or %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem demorgan_nand_proof : demorgan_nand_before ⊑ demorgan_nand_after := by
  unfold demorgan_nand_before demorgan_nand_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_nand
  apply demorgan_nand_thm
  ---END demorgan_nand



def demorgan_nand_apint1_before := [llvm|
{
^0(%arg0 : i7, %arg1 : i7):
  %0 = "llvm.mlir.constant"() <{value = -1 : i7}> : () -> i7
  %1 = llvm.xor %arg0, %0 : i7
  %2 = llvm.and %1, %arg1 : i7
  %3 = llvm.xor %2, %0 : i7
  "llvm.return"(%3) : (i7) -> ()
}
]
def demorgan_nand_apint1_after := [llvm|
{
^0(%arg0 : i7, %arg1 : i7):
  %0 = "llvm.mlir.constant"() <{value = -1 : i7}> : () -> i7
  %1 = llvm.xor %arg1, %0 : i7
  %2 = llvm.or %1, %arg0 : i7
  "llvm.return"(%2) : (i7) -> ()
}
]
theorem demorgan_nand_apint1_proof : demorgan_nand_apint1_before ⊑ demorgan_nand_apint1_after := by
  unfold demorgan_nand_apint1_before demorgan_nand_apint1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_nand_apint1
  apply demorgan_nand_apint1_thm
  ---END demorgan_nand_apint1



def demorgan_nand_apint2_before := [llvm|
{
^0(%arg0 : i117, %arg1 : i117):
  %0 = "llvm.mlir.constant"() <{value = -1 : i117}> : () -> i117
  %1 = llvm.xor %arg0, %0 : i117
  %2 = llvm.and %1, %arg1 : i117
  %3 = llvm.xor %2, %0 : i117
  "llvm.return"(%3) : (i117) -> ()
}
]
def demorgan_nand_apint2_after := [llvm|
{
^0(%arg0 : i117, %arg1 : i117):
  %0 = "llvm.mlir.constant"() <{value = -1 : i117}> : () -> i117
  %1 = llvm.xor %arg1, %0 : i117
  %2 = llvm.or %1, %arg0 : i117
  "llvm.return"(%2) : (i117) -> ()
}
]
theorem demorgan_nand_apint2_proof : demorgan_nand_apint2_before ⊑ demorgan_nand_apint2_after := by
  unfold demorgan_nand_apint2_before demorgan_nand_apint2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_nand_apint2
  apply demorgan_nand_apint2_thm
  ---END demorgan_nand_apint2



def demorgan_nor_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.or %1, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def demorgan_nor_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.and %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem demorgan_nor_proof : demorgan_nor_before ⊑ demorgan_nor_after := by
  unfold demorgan_nor_before demorgan_nor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_nor
  apply demorgan_nor_thm
  ---END demorgan_nor



def demorgan_nor_use2a_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 23 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.mul %2, %1 : i8
  %4 = llvm.or %2, %arg1 : i8
  %5 = llvm.xor %4, %0 : i8
  %6 = llvm.sdiv %5, %3 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def demorgan_nor_use2a_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 23 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.mul %2, %1 : i8
  %4 = llvm.xor %arg1, %0 : i8
  %5 = llvm.and %4, %arg0 : i8
  %6 = llvm.sdiv %5, %3 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
theorem demorgan_nor_use2a_proof : demorgan_nor_use2a_before ⊑ demorgan_nor_use2a_after := by
  unfold demorgan_nor_use2a_before demorgan_nor_use2a_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_nor_use2a
  apply demorgan_nor_use2a_thm
  ---END demorgan_nor_use2a



def demorgan_nor_use2b_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 23 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.mul %arg1, %0 : i8
  %3 = llvm.xor %arg0, %1 : i8
  %4 = llvm.or %3, %arg1 : i8
  %5 = llvm.xor %4, %1 : i8
  %6 = llvm.sdiv %5, %2 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def demorgan_nor_use2b_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 23 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.mul %arg1, %0 : i8
  %3 = llvm.xor %arg1, %1 : i8
  %4 = llvm.and %3, %arg0 : i8
  %5 = llvm.sdiv %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem demorgan_nor_use2b_proof : demorgan_nor_use2b_before ⊑ demorgan_nor_use2b_after := by
  unfold demorgan_nor_use2b_before demorgan_nor_use2b_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_nor_use2b
  apply demorgan_nor_use2b_thm
  ---END demorgan_nor_use2b



def demorgan_nor_use2ab_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 23 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 17 : i8}> : () -> i8
  %3 = llvm.mul %arg1, %0 : i8
  %4 = llvm.xor %arg0, %1 : i8
  %5 = llvm.mul %4, %2 : i8
  %6 = llvm.or %4, %arg1 : i8
  %7 = llvm.xor %6, %1 : i8
  %8 = llvm.sdiv %7, %3 : i8
  %9 = llvm.sdiv %8, %5 : i8
  "llvm.return"(%9) : (i8) -> ()
}
]
def demorgan_nor_use2ab_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 23 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 17 : i8}> : () -> i8
  %3 = llvm.mul %arg1, %0 : i8
  %4 = llvm.xor %arg0, %1 : i8
  %5 = llvm.mul %4, %2 : i8
  %6 = llvm.xor %arg1, %1 : i8
  %7 = llvm.and %6, %arg0 : i8
  %8 = llvm.sdiv %7, %3 : i8
  %9 = llvm.sdiv %8, %5 : i8
  "llvm.return"(%9) : (i8) -> ()
}
]
theorem demorgan_nor_use2ab_proof : demorgan_nor_use2ab_before ⊑ demorgan_nor_use2ab_after := by
  unfold demorgan_nor_use2ab_before demorgan_nor_use2ab_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_nor_use2ab
  apply demorgan_nor_use2ab_thm
  ---END demorgan_nor_use2ab



def demorganize_constant2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def demorganize_constant2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -16 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem demorganize_constant2_proof : demorganize_constant2_before ⊑ demorganize_constant2_after := by
  unfold demorganize_constant2_before demorganize_constant2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorganize_constant2
  apply demorganize_constant2_thm
  ---END demorganize_constant2



def demorgan_plus_and_to_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg1, %arg0 : i32
  %4 = llvm.or %3, %2 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def demorgan_plus_and_to_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem demorgan_plus_and_to_xor_proof : demorgan_plus_and_to_xor_before ⊑ demorgan_plus_and_to_xor_after := by
  unfold demorgan_plus_and_to_xor_before demorgan_plus_and_to_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN demorgan_plus_and_to_xor
  apply demorgan_plus_and_to_xor_thm
  ---END demorgan_plus_and_to_xor



def PR45984_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
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
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem PR45984_proof : PR45984_before ⊑ PR45984_after := by
  unfold PR45984_before PR45984_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN PR45984
  apply PR45984_thm
  ---END PR45984


