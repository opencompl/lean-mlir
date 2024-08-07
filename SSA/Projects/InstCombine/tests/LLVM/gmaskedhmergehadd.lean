import SSA.Projects.InstCombine.tests.LLVM.gmaskedhmergehadd_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def p_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg2 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg2 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_proof : p_before ⊑ p_after := by
  unfold p_before p_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN p
  apply p_thm
  ---END p



def p_constmask_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65280 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_constmask_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65280 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_constmask_proof : p_constmask_before ⊑ p_constmask_after := by
  unfold p_constmask_before p_constmask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN p_constmask
  apply p_constmask_thm
  ---END p_constmask



def p_constmask2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 61440 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_constmask2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 61440 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_constmask2_proof : p_constmask2_before ⊑ p_constmask2_after := by
  unfold p_constmask2_before p_constmask2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN p_constmask2
  apply p_constmask2_thm
  ---END p_constmask2



def p_commutative0_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg0 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative0_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg0 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative0_proof : p_commutative0_before ⊑ p_commutative0_after := by
  unfold p_commutative0_before p_commutative0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN p_commutative0
  apply p_commutative0_thm
  ---END p_commutative0



def p_commutative2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg2 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg2 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative2_proof : p_commutative2_before ⊑ p_commutative2_after := by
  unfold p_commutative2_before p_commutative2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN p_commutative2
  apply p_commutative2_thm
  ---END p_commutative2



def p_commutative4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg0 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg0 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative4_proof : p_commutative4_before ⊑ p_commutative4_after := by
  unfold p_commutative4_before p_commutative4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN p_commutative4
  apply p_commutative4_thm
  ---END p_commutative4



def p_constmask_commutative_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65280 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_constmask_commutative_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65280 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.or %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_constmask_commutative_proof : p_constmask_commutative_before ⊑ p_constmask_commutative_after := by
  unfold p_constmask_commutative_before p_constmask_commutative_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN p_constmask_commutative
  apply p_constmask_commutative_thm
  ---END p_constmask_commutative


