import SSA.Projects.InstCombine.tests.LLVM.gmaskedhmergehandhofhors_proof
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
section gmaskedhmergehandhofhors_statements
                                                    
def p_commutative0_before := [llvm|
{
^0(%arg56 : i32, %arg57 : i32, %arg58 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg58, %0 : i32
  %2 = llvm.or %arg56, %1 : i32
  %3 = llvm.or %arg57, %arg58 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative0_after := [llvm|
{
^0(%arg56 : i32, %arg57 : i32, %arg58 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg58, %0 : i32
  %2 = llvm.or %1, %arg56 : i32
  %3 = llvm.or %arg57, %arg58 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative0_proof : p_commutative0_before ⊑ p_commutative0_after := by
  unfold p_commutative0_before p_commutative0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN p_commutative0
  apply p_commutative0_thm
  ---END p_commutative0



def p_commutative4_before := [llvm|
{
^0(%arg46 : i32, %arg47 : i32, %arg48 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg48, %0 : i32
  %2 = llvm.or %arg46, %1 : i32
  %3 = llvm.or %arg47, %arg48 : i32
  %4 = llvm.and %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative4_after := [llvm|
{
^0(%arg46 : i32, %arg47 : i32, %arg48 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg48, %0 : i32
  %2 = llvm.or %1, %arg46 : i32
  %3 = llvm.or %arg47, %arg48 : i32
  %4 = llvm.and %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative4_proof : p_commutative4_before ⊑ p_commutative4_after := by
  unfold p_commutative4_before p_commutative4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN p_commutative4
  apply p_commutative4_thm
  ---END p_commutative4



def n3_constmask_samemask_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.or %arg1, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def n3_constmask_samemask_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -65281 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.or %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem n3_constmask_samemask_proof : n3_constmask_samemask_before ⊑ n3_constmask_samemask_after := by
  unfold n3_constmask_samemask_before n3_constmask_samemask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN n3_constmask_samemask
  apply n3_constmask_samemask_thm
  ---END n3_constmask_samemask


