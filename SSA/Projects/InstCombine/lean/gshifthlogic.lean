import SSA.Projects.InstCombine.lean.gshifthlogic_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def shl_and_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.and %2, %arg1 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_and_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %1 : i8
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
  try alive_auto
  ---BEGIN shl_and
  apply shl_and_thm
  ---END shl_and



def shl_or_before := [llvm|
{
^0(%arg0 : i16, %arg1 : i16):
  %0 = "llvm.mlir.constant"() <{value = 42 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 5 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{value = 7 : i16}> : () -> i16
  %3 = llvm.srem %arg1, %0 : i16
  %4 = llvm.shl %arg0, %1 : i16
  %5 = llvm.or %3, %4 : i16
  %6 = llvm.shl %5, %2 : i16
  "llvm.return"(%6) : (i16) -> ()
}
]
def shl_or_after := [llvm|
{
^0(%arg0 : i16, %arg1 : i16):
  %0 = "llvm.mlir.constant"() <{value = 42 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 12 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{value = 7 : i16}> : () -> i16
  %3 = llvm.srem %arg1, %0 : i16
  %4 = llvm.shl %arg0, %1 : i16
  %5 = llvm.shl %3, %2 : i16
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
  try alive_auto
  ---BEGIN shl_or
  apply shl_or_thm
  ---END shl_or



def shl_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def shl_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.shl %arg1, %1 : i32
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
  try alive_auto
  ---BEGIN shl_xor
  apply shl_xor_thm
  ---END shl_xor



def lshr_and_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = "llvm.mlir.constant"() <{value = 42 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 5 : i64}> : () -> i64
  %2 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
  %3 = llvm.srem %arg1, %0 : i64
  %4 = llvm.lshr %arg0, %1 : i64
  %5 = llvm.and %3, %4 : i64
  %6 = llvm.lshr %5, %2 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def lshr_and_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = "llvm.mlir.constant"() <{value = 42 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 12 : i64}> : () -> i64
  %2 = "llvm.mlir.constant"() <{value = 7 : i64}> : () -> i64
  %3 = llvm.srem %arg1, %0 : i64
  %4 = llvm.lshr %arg0, %1 : i64
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
  try alive_auto
  ---BEGIN lshr_and
  apply lshr_and_thm
  ---END lshr_and



def ashr_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %3 = llvm.srem %arg1, %0 : i32
  %4 = llvm.ashr %arg0, %1 : i32
  %5 = llvm.xor %3, %4 : i32
  %6 = llvm.ashr %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def ashr_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 12 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %3 = llvm.srem %arg1, %0 : i32
  %4 = llvm.ashr %arg0, %1 : i32
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
  try alive_auto
  ---BEGIN ashr_xor
  apply ashr_xor_thm
  ---END ashr_xor



def shr_mismatch_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %2 = llvm.ashr %arg0, %0 : i32
  %3 = llvm.xor %arg1, %2 : i32
  %4 = llvm.lshr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def shr_mismatch_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %2 = llvm.ashr %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.lshr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem shr_mismatch_xor_proof : shr_mismatch_xor_before ⊑ shr_mismatch_xor_after := by
  unfold shr_mismatch_xor_before shr_mismatch_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shr_mismatch_xor
  all_goals (try extract_goal ; sorry)
  ---END shr_mismatch_xor



def ashr_overshift_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 17 : i32}> : () -> i32
  %2 = llvm.ashr %arg0, %0 : i32
  %3 = llvm.xor %arg1, %2 : i32
  %4 = llvm.ashr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def ashr_overshift_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 17 : i32}> : () -> i32
  %2 = llvm.ashr %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.ashr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem ashr_overshift_xor_proof : ashr_overshift_xor_before ⊑ ashr_overshift_xor_after := by
  unfold ashr_overshift_xor_before ashr_overshift_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN ashr_overshift_xor
  apply ashr_overshift_xor_thm
  ---END ashr_overshift_xor



def lshr_mul_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 52 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
  %2 = llvm.mul %arg0, %0 : i64
  %3 = llvm.lshr %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def lshr_mul_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 13 : i64}> : () -> i64
  %1 = llvm.mul %arg0, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem lshr_mul_proof : lshr_mul_before ⊑ lshr_mul_after := by
  unfold lshr_mul_before lshr_mul_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_mul
  apply lshr_mul_thm
  ---END lshr_mul



def lshr_mul_nuw_nsw_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 52 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
  %2 = llvm.mul %arg0, %0 : i64
  %3 = llvm.lshr %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def lshr_mul_nuw_nsw_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{value = 13 : i64}> : () -> i64
  %1 = llvm.mul %arg0, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem lshr_mul_nuw_nsw_proof : lshr_mul_nuw_nsw_before ⊑ lshr_mul_nuw_nsw_after := by
  unfold lshr_mul_nuw_nsw_before lshr_mul_nuw_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_mul_nuw_nsw
  apply lshr_mul_nuw_nsw_thm
  ---END lshr_mul_nuw_nsw



def shl_add_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.add %2, %arg1 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_add_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %1 : i8
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
  try alive_auto
  ---BEGIN shl_add
  apply shl_add_thm
  ---END shl_add



def shl_sub_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.sub %2, %arg1 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_sub_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %1 : i8
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
  try alive_auto
  ---BEGIN shl_sub
  apply shl_sub_thm
  ---END shl_sub



def shl_sub_no_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg1, %0 : i8
  %3 = llvm.sub %arg0, %2 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_sub_no_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg1, %0 : i8
  %3 = llvm.shl %arg0, %1 : i8
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
  try alive_auto
  ---BEGIN shl_sub_no_commute
  apply shl_sub_no_commute_thm
  ---END shl_sub_no_commute


