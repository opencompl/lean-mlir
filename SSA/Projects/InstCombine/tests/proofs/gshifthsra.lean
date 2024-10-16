import SSA.Projects.InstCombine.tests.proofs.gshifthsra_proof
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
section gshifthsra_statements
                                                    
def ashr_ashr_before := [llvm|
{
^0(%arg7 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %2 = llvm.ashr %arg7, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_ashr_after := [llvm|
{
^0(%arg7 : i32):
  %0 = "llvm.mlir.constant"() <{value = 12 : i32}> : () -> i32
  %1 = llvm.ashr %arg7, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem ashr_ashr_proof : ashr_ashr_before ⊑ ashr_ashr_after := by
  unfold ashr_ashr_before ashr_ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_ashr
  apply ashr_ashr_thm
  ---END ashr_ashr



def ashr_overshift_before := [llvm|
{
^0(%arg6 : i32):
  %0 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 17 : i32}> : () -> i32
  %2 = llvm.ashr %arg6, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_overshift_after := [llvm|
{
^0(%arg6 : i32):
  %0 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %1 = llvm.ashr %arg6, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem ashr_overshift_proof : ashr_overshift_before ⊑ ashr_overshift_after := by
  unfold ashr_overshift_before ashr_overshift_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_overshift
  apply ashr_overshift_thm
  ---END ashr_overshift


