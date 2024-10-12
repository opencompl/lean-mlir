
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
section gshifthlogic_statements
                                                    
def shl_and_before := [llvm|
{
^0(%arg71 : i8, %arg72 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg71, %0 : i8
  %3 = llvm.and %2, %arg72 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_and_after := [llvm|
{
^0(%arg71 : i8, %arg72 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg71, %0 : i8
  %3 = llvm.shl %arg72, %1 : i8
  %4 = llvm.and %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_and_proof : shl_and_before ⊑ shl_and_after := by
  unfold shl_and_before shl_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_and
  all_goals (try extract_goal ; sorry)
  ---END shl_and



def shl_or_before := [llvm|
{
^0(%arg67 : i16, %arg68 : i16):
  %0 = "llvm.mlir.constant"() <{value = 42 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 5 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{value = 7 : i16}> : () -> i16
  %3 = llvm.srem %arg68, %0 : i16
  %4 = llvm.shl %arg67, %1 : i16
  %5 = llvm.or %3, %4 : i16
  %6 = llvm.shl %5, %2 : i16
  "llvm.return"(%6) : (i16) -> ()
}
]
def shl_or_after := [llvm|
{
^0(%arg67 : i16, %arg68 : i16):
  %0 = "llvm.mlir.constant"() <{value = 42 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 12 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{value = 7 : i16}> : () -> i16
  %3 = llvm.srem %arg68, %0 : i16
  %4 = llvm.shl %arg67, %1 : i16
  %5 = llvm.shl %3, %2 overflow<nsw> : i16
  %6 = llvm.or %4, %5 : i16
  "llvm.return"(%6) : (i16) -> ()
}
]
theorem shl_or_proof : shl_or_before ⊑ shl_or_after := by
  unfold shl_or_before shl_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_or
  all_goals (try extract_goal ; sorry)
  ---END shl_or



def shl_xor_before := [llvm|
{
^0(%arg63 : i32, %arg64 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %2 = llvm.shl %arg63, %0 : i32
  %3 = llvm.xor %2, %arg64 : i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def shl_xor_after := [llvm|
{
^0(%arg63 : i32, %arg64 : i32):
  %0 = "llvm.mlir.constant"() <{value = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %2 = llvm.shl %arg63, %0 : i32
  %3 = llvm.shl %arg64, %1 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem shl_xor_proof : shl_xor_before ⊑ shl_xor_after := by
  unfold shl_xor_before shl_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_xor
  all_goals (try extract_goal ; sorry)
  ---END shl_xor



def lshr_and_before := [llvm|
{
^0(%arg59 : i64, %arg60 : i64):
  %0 = "llvm.mlir.constant"() <{value = 42 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
  %2 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
  %3 = llvm.srem %arg60, %0 : i64
  %4 = llvm.lshr %arg59, %1 : i64
  %5 = llvm.and %3, %4 : i64
  %6 = llvm.lshr %5, %2 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def lshr_and_after := [llvm|
{
^0(%arg59 : i64, %arg60 : i64):
  %0 = "llvm.mlir.constant"() <{value = 42 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 12 : i64}> : () -> i64
  %2 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
  %3 = llvm.srem %arg60, %0 : i64
  %4 = llvm.lshr %arg59, %1 : i64
  %5 = llvm.lshr %3, %2 : i64
  %6 = llvm.and %4, %5 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
theorem lshr_and_proof : lshr_and_before ⊑ lshr_and_after := by
  unfold lshr_and_before lshr_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_and
  all_goals (try extract_goal ; sorry)
  ---END lshr_and



def ashr_xor_before := [llvm|
{
^0(%arg46 : i32, %arg47 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %3 = llvm.srem %arg47, %0 : i32
  %4 = llvm.ashr %arg46, %1 : i32
  %5 = llvm.xor %3, %4 : i32
  %6 = llvm.ashr %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def ashr_xor_after := [llvm|
{
^0(%arg46 : i32, %arg47 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 12 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %3 = llvm.srem %arg47, %0 : i32
  %4 = llvm.ashr %arg46, %1 : i32
  %5 = llvm.ashr %3, %2 : i32
  %6 = llvm.xor %4, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem ashr_xor_proof : ashr_xor_before ⊑ ashr_xor_after := by
  unfold ashr_xor_before ashr_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_xor
  all_goals (try extract_goal ; sorry)
  ---END ashr_xor



def lshr_mul_before := [llvm|
{
^0(%arg35 : i64):
  %0 = "llvm.mlir.constant"() <{value = 52 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
  %2 = llvm.mul %arg35, %0 overflow<nuw> : i64
  %3 = llvm.lshr %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def lshr_mul_after := [llvm|
{
^0(%arg35 : i64):
  %0 = "llvm.mlir.constant"() <{value = 13 : i64}> : () -> i64
  %1 = llvm.mul %arg35, %0 overflow<nsw,nuw> : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem lshr_mul_proof : lshr_mul_before ⊑ lshr_mul_after := by
  unfold lshr_mul_before lshr_mul_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_mul
  all_goals (try extract_goal ; sorry)
  ---END lshr_mul



def lshr_mul_nuw_nsw_before := [llvm|
{
^0(%arg34 : i64):
  %0 = "llvm.mlir.constant"() <{value = 52 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
  %2 = llvm.mul %arg34, %0 overflow<nsw,nuw> : i64
  %3 = llvm.lshr %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def lshr_mul_nuw_nsw_after := [llvm|
{
^0(%arg34 : i64):
  %0 = "llvm.mlir.constant"() <{value = 13 : i64}> : () -> i64
  %1 = llvm.mul %arg34, %0 overflow<nsw,nuw> : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem lshr_mul_nuw_nsw_proof : lshr_mul_nuw_nsw_before ⊑ lshr_mul_nuw_nsw_after := by
  unfold lshr_mul_nuw_nsw_before lshr_mul_nuw_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_mul_nuw_nsw
  all_goals (try extract_goal ; sorry)
  ---END lshr_mul_nuw_nsw



def shl_add_before := [llvm|
{
^0(%arg27 : i8, %arg28 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg27, %0 : i8
  %3 = llvm.add %2, %arg28 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_add_after := [llvm|
{
^0(%arg27 : i8, %arg28 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg27, %0 : i8
  %3 = llvm.shl %arg28, %1 : i8
  %4 = llvm.add %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_add_proof : shl_add_before ⊑ shl_add_after := by
  unfold shl_add_before shl_add_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_add
  all_goals (try extract_goal ; sorry)
  ---END shl_add



def shl_sub_before := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg12, %0 : i8
  %3 = llvm.sub %2, %arg13 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_sub_after := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg12, %0 : i8
  %3 = llvm.shl %arg13, %1 : i8
  %4 = llvm.sub %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_sub_proof : shl_sub_before ⊑ shl_sub_after := by
  unfold shl_sub_before shl_sub_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_sub
  all_goals (try extract_goal ; sorry)
  ---END shl_sub



def shl_sub_no_commute_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg11, %0 : i8
  %3 = llvm.sub %arg10, %2 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_sub_no_commute_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg11, %0 : i8
  %3 = llvm.shl %arg10, %1 : i8
  %4 = llvm.sub %3, %2 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_sub_no_commute_proof : shl_sub_no_commute_before ⊑ shl_sub_no_commute_after := by
  unfold shl_sub_no_commute_before shl_sub_no_commute_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_sub_no_commute
  all_goals (try extract_goal ; sorry)
  ---END shl_sub_no_commute


