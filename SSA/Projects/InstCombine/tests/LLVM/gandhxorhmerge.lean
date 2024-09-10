import SSA.Projects.InstCombine.tests.LLVM.gandhxorhmerge_proof
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
section gandhxorhmerge_statements
                                                    
def test1_before := [llvm|
{
^0(%arg9 : i32, %arg10 : i32, %arg11 : i32):
  %0 = llvm.and %arg11, %arg9 : i32
  %1 = llvm.and %arg11, %arg10 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg9 : i32, %arg10 : i32, %arg11 : i32):
  %0 = llvm.xor %arg9, %arg10 : i32
  %1 = llvm.and %0, %arg11 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test1
  apply test1_thm
  ---END test1



def test2_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32):
  %0 = llvm.and %arg7, %arg6 : i32
  %1 = llvm.or %arg7, %arg6 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32):
  %0 = llvm.xor %arg7, %arg6 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test2
  apply test2_thm
  ---END test2



def PR75692_1_before := [llvm|
{
^0(%arg3 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -5 : i32}> : () -> i32
  %2 = llvm.xor %arg3, %0 : i32
  %3 = llvm.xor %arg3, %1 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def PR75692_1_after := [llvm|
{
^0(%arg3 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem PR75692_1_proof : PR75692_1_before ⊑ PR75692_1_after := by
  unfold PR75692_1_before PR75692_1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN PR75692_1
  apply PR75692_1_thm
  ---END PR75692_1


