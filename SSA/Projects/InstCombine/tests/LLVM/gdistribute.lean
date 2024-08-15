import SSA.Projects.InstCombine.tests.LLVM.gdistribute_proof
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
                                                                       
def factorize_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.or %arg0, %1 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def factorize_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem factorize_proof : factorize_before ⊑ factorize_after := by
  unfold factorize_before factorize_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN factorize
  apply factorize_thm
  ---END factorize



def factorize2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.mul %0, %arg0 : i32
  %3 = llvm.mul %1, %arg0 : i32
  %4 = llvm.sub %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def factorize2_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem factorize2_proof : factorize2_before ⊑ factorize2_after := by
  unfold factorize2_before factorize2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN factorize2
  apply factorize2_thm
  ---END factorize2



def factorize3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.or %arg1, %arg2 : i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.or %arg0, %arg2 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def factorize3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.or %arg2, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem factorize3_proof : factorize3_before ⊑ factorize3_after := by
  unfold factorize3_before factorize3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN factorize3
  all_goals (try extract_goal ; sorry)
  ---END factorize3



def factorize4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.shl %arg1, %0 : i32
  %2 = llvm.mul %1, %arg0 : i32
  %3 = llvm.mul %arg0, %arg1 : i32
  %4 = llvm.sub %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def factorize4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mul %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem factorize4_proof : factorize4_before ⊑ factorize4_after := by
  unfold factorize4_before factorize4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN factorize4
  apply factorize4_thm
  ---END factorize4



def factorize5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %0 : i32
  %2 = llvm.mul %1, %arg0 : i32
  %3 = llvm.mul %arg0, %arg1 : i32
  %4 = llvm.sub %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def factorize5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mul %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem factorize5_proof : factorize5_before ⊑ factorize5_after := by
  unfold factorize5_before factorize5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN factorize5
  apply factorize5_thm
  ---END factorize5



def expand_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = llvm.and %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def expand_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem expand_proof : expand_before ⊑ expand_after := by
  unfold expand_before expand_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN expand
  apply expand_thm
  ---END expand


