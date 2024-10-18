import SSA.Projects.InstCombine.tests.proofs.gmaskedhmergehadd_proof
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
section gmaskedhmergehadd_statements

def p_before := [llvm|
{
^0(%arg60 : i32, %arg61 : i32, %arg62 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg60, %arg62 : i32
  %2 = llvm.xor %arg62, %0 : i32
  %3 = llvm.and %2, %arg61 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_after := [llvm|
{
^0(%arg60 : i32, %arg61 : i32, %arg62 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg60, %arg62 : i32
  %2 = llvm.xor %arg62, %0 : i32
  %3 = llvm.and %arg61, %2 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_proof : p_before ⊑ p_after := by
  unfold p_before p_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN p
  apply p_thm
  ---END p



def p_constmask_before := [llvm|
{
^0(%arg49 : i32, %arg50 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65280 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg49, %0 : i32
  %3 = llvm.and %arg50, %1 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_constmask_after := [llvm|
{
^0(%arg49 : i32, %arg50 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65280 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg49, %0 : i32
  %3 = llvm.and %arg50, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_constmask_proof : p_constmask_before ⊑ p_constmask_after := by
  unfold p_constmask_before p_constmask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN p_constmask
  apply p_constmask_thm
  ---END p_constmask



def p_constmask2_before := [llvm|
{
^0(%arg41 : i32, %arg42 : i32):
  %0 = "llvm.mlir.constant"() <{value = 61440 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg41, %0 : i32
  %3 = llvm.and %arg42, %1 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_constmask2_after := [llvm|
{
^0(%arg41 : i32, %arg42 : i32):
  %0 = "llvm.mlir.constant"() <{value = 61440 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg41, %0 : i32
  %3 = llvm.and %arg42, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_constmask2_proof : p_constmask2_before ⊑ p_constmask2_after := by
  unfold p_constmask2_before p_constmask2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN p_constmask2
  apply p_constmask2_thm
  ---END p_constmask2



def p_commutative0_before := [llvm|
{
^0(%arg32 : i32, %arg33 : i32, %arg34 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg34, %arg32 : i32
  %2 = llvm.xor %arg34, %0 : i32
  %3 = llvm.and %2, %arg33 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative0_after := [llvm|
{
^0(%arg32 : i32, %arg33 : i32, %arg34 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg34, %arg32 : i32
  %2 = llvm.xor %arg34, %0 : i32
  %3 = llvm.and %arg33, %2 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative0_proof : p_commutative0_before ⊑ p_commutative0_after := by
  unfold p_commutative0_before p_commutative0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN p_commutative0
  apply p_commutative0_thm
  ---END p_commutative0



def p_commutative2_before := [llvm|
{
^0(%arg27 : i32, %arg28 : i32, %arg29 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg27, %arg29 : i32
  %2 = llvm.xor %arg29, %0 : i32
  %3 = llvm.and %2, %arg28 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative2_after := [llvm|
{
^0(%arg27 : i32, %arg28 : i32, %arg29 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg27, %arg29 : i32
  %2 = llvm.xor %arg29, %0 : i32
  %3 = llvm.and %arg28, %2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative2_proof : p_commutative2_before ⊑ p_commutative2_after := by
  unfold p_commutative2_before p_commutative2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN p_commutative2
  apply p_commutative2_thm
  ---END p_commutative2



def p_commutative4_before := [llvm|
{
^0(%arg22 : i32, %arg23 : i32, %arg24 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg24, %arg22 : i32
  %2 = llvm.xor %arg24, %0 : i32
  %3 = llvm.and %2, %arg23 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative4_after := [llvm|
{
^0(%arg22 : i32, %arg23 : i32, %arg24 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg24, %arg22 : i32
  %2 = llvm.xor %arg24, %0 : i32
  %3 = llvm.and %arg23, %2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative4_proof : p_commutative4_before ⊑ p_commutative4_after := by
  unfold p_commutative4_before p_commutative4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN p_commutative4
  apply p_commutative4_thm
  ---END p_commutative4



def p_constmask_commutative_before := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65280 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg16, %0 : i32
  %3 = llvm.and %arg17, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_constmask_commutative_after := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65280 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg16, %0 : i32
  %3 = llvm.and %arg17, %1 : i32
  %4 = llvm.or %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_constmask_commutative_proof : p_constmask_commutative_before ⊑ p_constmask_commutative_after := by
  unfold p_constmask_commutative_before p_constmask_commutative_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN p_constmask_commutative
  apply p_constmask_commutative_thm
  ---END p_constmask_commutative



def n2_badmask_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32, %arg6 : i32, %arg7 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg6, %arg4 : i32
  %2 = llvm.xor %arg7, %0 : i32
  %3 = llvm.and %2, %arg5 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def n2_badmask_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32, %arg6 : i32, %arg7 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg6, %arg4 : i32
  %2 = llvm.xor %arg7, %0 : i32
  %3 = llvm.and %arg5, %2 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem n2_badmask_proof : n2_badmask_before ⊑ n2_badmask_after := by
  unfold n2_badmask_before n2_badmask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN n2_badmask
  apply n2_badmask_thm
  ---END n2_badmask



def n3_constmask_samemask_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65280 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = llvm.add %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def n3_constmask_samemask_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65280 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = llvm.add %1, %2 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem n3_constmask_samemask_proof : n3_constmask_samemask_before ⊑ n3_constmask_samemask_after := by
  unfold n3_constmask_samemask_before n3_constmask_samemask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN n3_constmask_samemask
  apply n3_constmask_samemask_thm
  ---END n3_constmask_samemask


