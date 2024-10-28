
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
section gsignmaskhofhsexthvshofhshlhofhzext_statements

def t0_before := [llvm|
{
^0(%arg12 : i16):
  %0 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2147483648 : i32}> : () -> i32
  %2 = llvm.zext %arg12 : i16 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg12 : i16):
  %0 = "llvm.mlir.constant"() <{value = -2147483648 : i32}> : () -> i32
  %1 = llvm.sext %arg12 : i16 to i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  ---BEGIN t0
  all_goals (try extract_goal ; sorry)
  ---END t0



def t1_before := [llvm|
{
^0(%arg11 : i8):
  %0 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2147483648 : i32}> : () -> i32
  %2 = llvm.zext %arg11 : i8 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def t1_after := [llvm|
{
^0(%arg11 : i8):
  %0 = "llvm.mlir.constant"() <{value = -2147483648 : i32}> : () -> i32
  %1 = llvm.sext %arg11 : i8 to i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem t1_proof : t1_before ⊑ t1_after := by
  unfold t1_before t1_after
  simp_alive_peephole
  ---BEGIN t1
  all_goals (try extract_goal ; sorry)
  ---END t1



def n2_before := [llvm|
{
^0(%arg10 : i16):
  %0 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2147483648 : i32}> : () -> i32
  %2 = llvm.zext %arg10 : i16 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def n2_after := [llvm|
{
^0(%arg10 : i16):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem n2_proof : n2_before ⊑ n2_after := by
  unfold n2_before n2_after
  simp_alive_peephole
  ---BEGIN n2
  all_goals (try extract_goal ; sorry)
  ---END n2



def n4_before := [llvm|
{
^0(%arg8 : i16):
  %0 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1073741824 : i32}> : () -> i32
  %2 = llvm.zext %arg8 : i16 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def n4_after := [llvm|
{
^0(%arg8 : i16):
  %0 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1073741824 : i32}> : () -> i32
  %2 = llvm.zext %arg8 : i16 to i32
  %3 = llvm.shl %2, %0 overflow<nuw> : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem n4_proof : n4_before ⊑ n4_after := by
  unfold n4_before n4_after
  simp_alive_peephole
  ---BEGIN n4
  all_goals (try extract_goal ; sorry)
  ---END n4


