import SSA.Projects.InstCombine.tests.proofs.gshlhsub_proof
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
section gshlhsub_statements

def shl_sub_i32_before := [llvm|
{
^0(%arg18 : i32):
  %0 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg18 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_sub_i32_after := [llvm|
{
^0(%arg18 : i32):
  %0 = "llvm.mlir.constant"() <{value = -2147483648 : i32}> : () -> i32
  %1 = llvm.lshr %0, %arg18 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_sub_i32_proof : shl_sub_i32_before ⊑ shl_sub_i32_after := by
  unfold shl_sub_i32_before shl_sub_i32_after
  simp_alive_peephole
  ---BEGIN shl_sub_i32
  apply shl_sub_i32_thm
  ---END shl_sub_i32



def shl_sub_i8_before := [llvm|
{
^0(%arg16 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg16 : i8
  %3 = llvm.shl %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_sub_i8_after := [llvm|
{
^0(%arg16 : i8):
  %0 = "llvm.mlir.constant"() <{value = -128 : i8}> : () -> i8
  %1 = llvm.lshr %0, %arg16 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_sub_i8_proof : shl_sub_i8_before ⊑ shl_sub_i8_after := by
  unfold shl_sub_i8_before shl_sub_i8_after
  simp_alive_peephole
  ---BEGIN shl_sub_i8
  apply shl_sub_i8_thm
  ---END shl_sub_i8



def shl_sub_i64_before := [llvm|
{
^0(%arg15 : i64):
  %0 = "llvm.mlir.constant"() <{value = 63 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg15 : i64
  %3 = llvm.shl %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def shl_sub_i64_after := [llvm|
{
^0(%arg15 : i64):
  %0 = "llvm.mlir.constant"() <{value = -9223372036854775808 : i64}> : () -> i64
  %1 = llvm.lshr %0, %arg15 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem shl_sub_i64_proof : shl_sub_i64_before ⊑ shl_sub_i64_after := by
  unfold shl_sub_i64_before shl_sub_i64_after
  simp_alive_peephole
  ---BEGIN shl_sub_i64
  apply shl_sub_i64_thm
  ---END shl_sub_i64



def shl_bad_sub_i32_before := [llvm|
{
^0(%arg12 : i32):
  %0 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg12 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_bad_sub_i32_after := [llvm|
{
^0(%arg12 : i32):
  %0 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg12 : i32
  %3 = llvm.shl %1, %2 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem shl_bad_sub_i32_proof : shl_bad_sub_i32_before ⊑ shl_bad_sub_i32_after := by
  unfold shl_bad_sub_i32_before shl_bad_sub_i32_after
  simp_alive_peephole
  ---BEGIN shl_bad_sub_i32
  apply shl_bad_sub_i32_thm
  ---END shl_bad_sub_i32



def shl_bad_sub2_i32_before := [llvm|
{
^0(%arg10 : i32):
  %0 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.sub %arg10, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_bad_sub2_i32_after := [llvm|
{
^0(%arg10 : i32):
  %0 = "llvm.mlir.constant"() <{value = -31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.add %arg10, %0 : i32
  %3 = llvm.shl %1, %2 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem shl_bad_sub2_i32_proof : shl_bad_sub2_i32_before ⊑ shl_bad_sub2_i32_after := by
  unfold shl_bad_sub2_i32_before shl_bad_sub2_i32_after
  simp_alive_peephole
  ---BEGIN shl_bad_sub2_i32
  apply shl_bad_sub2_i32_thm
  ---END shl_bad_sub2_i32



def bad_shl2_sub_i32_before := [llvm|
{
^0(%arg9 : i32):
  %0 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.sub %arg9, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def bad_shl2_sub_i32_after := [llvm|
{
^0(%arg9 : i32):
  %0 = "llvm.mlir.constant"() <{value = -31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.add %arg9, %0 : i32
  %3 = llvm.shl %1, %2 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem bad_shl2_sub_i32_proof : bad_shl2_sub_i32_before ⊑ bad_shl2_sub_i32_after := by
  unfold bad_shl2_sub_i32_before bad_shl2_sub_i32_after
  simp_alive_peephole
  ---BEGIN bad_shl2_sub_i32
  apply bad_shl2_sub_i32_thm
  ---END bad_shl2_sub_i32



def shl_bad_sub_i8_before := [llvm|
{
^0(%arg8 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg8 : i8
  %3 = llvm.shl %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_bad_sub_i8_after := [llvm|
{
^0(%arg8 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg8 : i8
  %3 = llvm.shl %1, %2 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem shl_bad_sub_i8_proof : shl_bad_sub_i8_before ⊑ shl_bad_sub_i8_after := by
  unfold shl_bad_sub_i8_before shl_bad_sub_i8_after
  simp_alive_peephole
  ---BEGIN shl_bad_sub_i8
  apply shl_bad_sub_i8_thm
  ---END shl_bad_sub_i8



def shl_bad_sub_i64_before := [llvm|
{
^0(%arg7 : i64):
  %0 = "llvm.mlir.constant"() <{value = 67 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg7 : i64
  %3 = llvm.shl %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def shl_bad_sub_i64_after := [llvm|
{
^0(%arg7 : i64):
  %0 = "llvm.mlir.constant"() <{value = 67 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg7 : i64
  %3 = llvm.shl %1, %2 overflow<nuw> : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
theorem shl_bad_sub_i64_proof : shl_bad_sub_i64_before ⊑ shl_bad_sub_i64_after := by
  unfold shl_bad_sub_i64_before shl_bad_sub_i64_after
  simp_alive_peephole
  ---BEGIN shl_bad_sub_i64
  apply shl_bad_sub_i64_thm
  ---END shl_bad_sub_i64



def shl_const_op1_sub_const_op0_before := [llvm|
{
^0(%arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg2 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_const_op1_sub_const_op0_after := [llvm|
{
^0(%arg2 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 336 : i32}> : () -> i32
  %2 = llvm.shl %arg2, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem shl_const_op1_sub_const_op0_proof : shl_const_op1_sub_const_op0_before ⊑ shl_const_op1_sub_const_op0_after := by
  unfold shl_const_op1_sub_const_op0_before shl_const_op1_sub_const_op0_after
  simp_alive_peephole
  ---BEGIN shl_const_op1_sub_const_op0
  apply shl_const_op1_sub_const_op0_thm
  ---END shl_const_op1_sub_const_op0


