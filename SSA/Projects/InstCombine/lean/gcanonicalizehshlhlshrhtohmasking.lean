import SSA.Projects.InstCombine.lean.gcanonicalizehshlhlshrhtohmasking_proof
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
                                                                       
def positive_samevar_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.shl %arg0, %arg1 : i32
  %1 = llvm.lshr %0, %arg1 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def positive_samevar_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.lshr %0, %arg1 : i32
  %2 = llvm.and %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem positive_samevar_proof : positive_samevar_before ⊑ positive_samevar_after := by
  unfold positive_samevar_before positive_samevar_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_samevar
  apply positive_samevar_thm
  ---END positive_samevar



def positive_sameconst_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  %2 = llvm.lshr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def positive_sameconst_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 134217727 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem positive_sameconst_proof : positive_sameconst_before ⊑ positive_sameconst_after := by
  unfold positive_sameconst_before positive_sameconst_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_sameconst
  apply positive_sameconst_thm
  ---END positive_sameconst



def positive_biggerShl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 10 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def positive_biggerShl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 134217696 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem positive_biggerShl_proof : positive_biggerShl_before ⊑ positive_biggerShl_after := by
  unfold positive_biggerShl_before positive_biggerShl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerShl
  apply positive_biggerShl_thm
  ---END positive_biggerShl



def positive_biggerLshr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 10 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def positive_biggerLshr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4194303 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem positive_biggerLshr_proof : positive_biggerLshr_before ⊑ positive_biggerLshr_after := by
  unfold positive_biggerLshr_before positive_biggerLshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerLshr
  apply positive_biggerLshr_thm
  ---END positive_biggerLshr



def positive_biggerLshr_lshrexact_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 10 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def positive_biggerLshr_lshrexact_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4194303 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem positive_biggerLshr_lshrexact_proof : positive_biggerLshr_lshrexact_before ⊑ positive_biggerLshr_lshrexact_after := by
  unfold positive_biggerLshr_lshrexact_before positive_biggerLshr_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerLshr_lshrexact
  apply positive_biggerLshr_lshrexact_thm
  ---END positive_biggerLshr_lshrexact



def positive_samevar_shlnuw_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.shl %arg0, %arg1 : i32
  %1 = llvm.lshr %0, %arg1 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def positive_samevar_shlnuw_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem positive_samevar_shlnuw_proof : positive_samevar_shlnuw_before ⊑ positive_samevar_shlnuw_after := by
  unfold positive_samevar_shlnuw_before positive_samevar_shlnuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_samevar_shlnuw
  apply positive_samevar_shlnuw_thm
  ---END positive_samevar_shlnuw



def positive_sameconst_shlnuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  %2 = llvm.lshr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def positive_sameconst_shlnuw_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem positive_sameconst_shlnuw_proof : positive_sameconst_shlnuw_before ⊑ positive_sameconst_shlnuw_after := by
  unfold positive_sameconst_shlnuw_before positive_sameconst_shlnuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_sameconst_shlnuw
  apply positive_sameconst_shlnuw_thm
  ---END positive_sameconst_shlnuw



def positive_biggerShl_shlnuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 10 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def positive_biggerShl_shlnuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem positive_biggerShl_shlnuw_proof : positive_biggerShl_shlnuw_before ⊑ positive_biggerShl_shlnuw_after := by
  unfold positive_biggerShl_shlnuw_before positive_biggerShl_shlnuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerShl_shlnuw
  apply positive_biggerShl_shlnuw_thm
  ---END positive_biggerShl_shlnuw



def positive_biggerLshr_shlnuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 10 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def positive_biggerLshr_shlnuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = llvm.lshr %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem positive_biggerLshr_shlnuw_proof : positive_biggerLshr_shlnuw_before ⊑ positive_biggerLshr_shlnuw_after := by
  unfold positive_biggerLshr_shlnuw_before positive_biggerLshr_shlnuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerLshr_shlnuw
  apply positive_biggerLshr_shlnuw_thm
  ---END positive_biggerLshr_shlnuw



def positive_biggerLshr_shlnuw_lshrexact_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 10 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def positive_biggerLshr_shlnuw_lshrexact_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = llvm.lshr %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem positive_biggerLshr_shlnuw_lshrexact_proof : positive_biggerLshr_shlnuw_lshrexact_before ⊑ positive_biggerLshr_shlnuw_lshrexact_after := by
  unfold positive_biggerLshr_shlnuw_lshrexact_before positive_biggerLshr_shlnuw_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerLshr_shlnuw_lshrexact
  apply positive_biggerLshr_shlnuw_lshrexact_thm
  ---END positive_biggerLshr_shlnuw_lshrexact


