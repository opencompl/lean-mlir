import SSA.Projects.InstCombine.tests.LLVM.gcanonicalizehlshrhshlhtohmasking_proof
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
                                                                       
def positive_samevar_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.lshr %arg0, %arg1 : i8
  %1 = llvm.shl %0, %arg1 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.and %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
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
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %0 : i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -8 : i8}> : () -> i8
  %1 = llvm.and %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
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



def positive_biggerlshr_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 24 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem positive_biggerlshr_proof : positive_biggerlshr_before ⊑ positive_biggerlshr_after := by
  unfold positive_biggerlshr_before positive_biggerlshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerlshr
  apply positive_biggerlshr_thm
  ---END positive_biggerlshr



def positive_biggershl_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -64 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem positive_biggershl_proof : positive_biggershl_before ⊑ positive_biggershl_after := by
  unfold positive_biggershl_before positive_biggershl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggershl
  apply positive_biggershl_thm
  ---END positive_biggershl



def positive_samevar_shlnuw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.lshr %arg0, %arg1 : i8
  %1 = llvm.shl %0, %arg1 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnuw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.and %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
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
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %0 : i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnuw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -8 : i8}> : () -> i8
  %1 = llvm.and %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
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



def positive_biggerlshr_shlnuw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_shlnuw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 24 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem positive_biggerlshr_shlnuw_proof : positive_biggerlshr_shlnuw_before ⊑ positive_biggerlshr_shlnuw_after := by
  unfold positive_biggerlshr_shlnuw_before positive_biggerlshr_shlnuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerlshr_shlnuw
  apply positive_biggerlshr_shlnuw_thm
  ---END positive_biggerlshr_shlnuw



def positive_biggershl_shlnuw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnuw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -64 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem positive_biggershl_shlnuw_proof : positive_biggershl_shlnuw_before ⊑ positive_biggershl_shlnuw_after := by
  unfold positive_biggershl_shlnuw_before positive_biggershl_shlnuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggershl_shlnuw
  apply positive_biggershl_shlnuw_thm
  ---END positive_biggershl_shlnuw



def positive_samevar_shlnsw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.lshr %arg0, %arg1 : i8
  %1 = llvm.shl %0, %arg1 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnsw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.and %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem positive_samevar_shlnsw_proof : positive_samevar_shlnsw_before ⊑ positive_samevar_shlnsw_after := by
  unfold positive_samevar_shlnsw_before positive_samevar_shlnsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_samevar_shlnsw
  apply positive_samevar_shlnsw_thm
  ---END positive_samevar_shlnsw



def positive_sameconst_shlnsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %0 : i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -8 : i8}> : () -> i8
  %1 = llvm.and %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem positive_sameconst_shlnsw_proof : positive_sameconst_shlnsw_before ⊑ positive_sameconst_shlnsw_after := by
  unfold positive_sameconst_shlnsw_before positive_sameconst_shlnsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_sameconst_shlnsw
  apply positive_sameconst_shlnsw_thm
  ---END positive_sameconst_shlnsw



def positive_biggerlshr_shlnsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_shlnsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 24 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem positive_biggerlshr_shlnsw_proof : positive_biggerlshr_shlnsw_before ⊑ positive_biggerlshr_shlnsw_after := by
  unfold positive_biggerlshr_shlnsw_before positive_biggerlshr_shlnsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerlshr_shlnsw
  apply positive_biggerlshr_shlnsw_thm
  ---END positive_biggerlshr_shlnsw



def positive_biggershl_shlnsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 64 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem positive_biggershl_shlnsw_proof : positive_biggershl_shlnsw_before ⊑ positive_biggershl_shlnsw_after := by
  unfold positive_biggershl_shlnsw_before positive_biggershl_shlnsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggershl_shlnsw
  apply positive_biggershl_shlnsw_thm
  ---END positive_biggershl_shlnsw



def positive_samevar_shlnuwnsw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.lshr %arg0, %arg1 : i8
  %1 = llvm.shl %0, %arg1 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnuwnsw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.and %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem positive_samevar_shlnuwnsw_proof : positive_samevar_shlnuwnsw_before ⊑ positive_samevar_shlnuwnsw_after := by
  unfold positive_samevar_shlnuwnsw_before positive_samevar_shlnuwnsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_samevar_shlnuwnsw
  apply positive_samevar_shlnuwnsw_thm
  ---END positive_samevar_shlnuwnsw



def positive_sameconst_shlnuwnsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %0 : i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnuwnsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -8 : i8}> : () -> i8
  %1 = llvm.and %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem positive_sameconst_shlnuwnsw_proof : positive_sameconst_shlnuwnsw_before ⊑ positive_sameconst_shlnuwnsw_after := by
  unfold positive_sameconst_shlnuwnsw_before positive_sameconst_shlnuwnsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_sameconst_shlnuwnsw
  apply positive_sameconst_shlnuwnsw_thm
  ---END positive_sameconst_shlnuwnsw



def positive_biggerlshr_shlnuwnsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_shlnuwnsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 24 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem positive_biggerlshr_shlnuwnsw_proof : positive_biggerlshr_shlnuwnsw_before ⊑ positive_biggerlshr_shlnuwnsw_after := by
  unfold positive_biggerlshr_shlnuwnsw_before positive_biggerlshr_shlnuwnsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerlshr_shlnuwnsw
  apply positive_biggerlshr_shlnuwnsw_thm
  ---END positive_biggerlshr_shlnuwnsw



def positive_biggershl_shlnuwnsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnuwnsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 64 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem positive_biggershl_shlnuwnsw_proof : positive_biggershl_shlnuwnsw_before ⊑ positive_biggershl_shlnuwnsw_after := by
  unfold positive_biggershl_shlnuwnsw_before positive_biggershl_shlnuwnsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggershl_shlnuwnsw
  apply positive_biggershl_shlnuwnsw_thm
  ---END positive_biggershl_shlnuwnsw



def positive_samevar_lshrexact_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.lshr %arg0, %arg1 : i8
  %1 = llvm.shl %0, %arg1 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_lshrexact_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  "llvm.return"(%arg0) : (i8) -> ()
}
]
theorem positive_samevar_lshrexact_proof : positive_samevar_lshrexact_before ⊑ positive_samevar_lshrexact_after := by
  unfold positive_samevar_lshrexact_before positive_samevar_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_samevar_lshrexact
  apply positive_samevar_lshrexact_thm
  ---END positive_samevar_lshrexact



def positive_sameconst_lshrexact_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %0 : i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_lshrexact_after := [llvm|
{
^0(%arg0 : i8):
  "llvm.return"(%arg0) : (i8) -> ()
}
]
theorem positive_sameconst_lshrexact_proof : positive_sameconst_lshrexact_before ⊑ positive_sameconst_lshrexact_after := by
  unfold positive_sameconst_lshrexact_before positive_sameconst_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_sameconst_lshrexact
  apply positive_sameconst_lshrexact_thm
  ---END positive_sameconst_lshrexact



def positive_biggerlshr_lshrexact_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_lshrexact_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem positive_biggerlshr_lshrexact_proof : positive_biggerlshr_lshrexact_before ⊑ positive_biggerlshr_lshrexact_after := by
  unfold positive_biggerlshr_lshrexact_before positive_biggerlshr_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerlshr_lshrexact
  apply positive_biggerlshr_lshrexact_thm
  ---END positive_biggerlshr_lshrexact



def positive_biggershl_lshrexact_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_lshrexact_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem positive_biggershl_lshrexact_proof : positive_biggershl_lshrexact_before ⊑ positive_biggershl_lshrexact_after := by
  unfold positive_biggershl_lshrexact_before positive_biggershl_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggershl_lshrexact
  apply positive_biggershl_lshrexact_thm
  ---END positive_biggershl_lshrexact



def positive_samevar_shlnsw_lshrexact_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.lshr %arg0, %arg1 : i8
  %1 = llvm.shl %0, %arg1 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnsw_lshrexact_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  "llvm.return"(%arg0) : (i8) -> ()
}
]
theorem positive_samevar_shlnsw_lshrexact_proof : positive_samevar_shlnsw_lshrexact_before ⊑ positive_samevar_shlnsw_lshrexact_after := by
  unfold positive_samevar_shlnsw_lshrexact_before positive_samevar_shlnsw_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_samevar_shlnsw_lshrexact
  apply positive_samevar_shlnsw_lshrexact_thm
  ---END positive_samevar_shlnsw_lshrexact



def positive_sameconst_shlnsw_lshrexact_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %0 : i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnsw_lshrexact_after := [llvm|
{
^0(%arg0 : i8):
  "llvm.return"(%arg0) : (i8) -> ()
}
]
theorem positive_sameconst_shlnsw_lshrexact_proof : positive_sameconst_shlnsw_lshrexact_before ⊑ positive_sameconst_shlnsw_lshrexact_after := by
  unfold positive_sameconst_shlnsw_lshrexact_before positive_sameconst_shlnsw_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_sameconst_shlnsw_lshrexact
  apply positive_sameconst_shlnsw_lshrexact_thm
  ---END positive_sameconst_shlnsw_lshrexact



def positive_biggerlshr_shlnsw_lshrexact_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_shlnsw_lshrexact_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem positive_biggerlshr_shlnsw_lshrexact_proof : positive_biggerlshr_shlnsw_lshrexact_before ⊑ positive_biggerlshr_shlnsw_lshrexact_after := by
  unfold positive_biggerlshr_shlnsw_lshrexact_before positive_biggerlshr_shlnsw_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerlshr_shlnsw_lshrexact
  apply positive_biggerlshr_shlnsw_lshrexact_thm
  ---END positive_biggerlshr_shlnsw_lshrexact



def positive_biggershl_shlnsw_lshrexact_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnsw_lshrexact_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem positive_biggershl_shlnsw_lshrexact_proof : positive_biggershl_shlnsw_lshrexact_before ⊑ positive_biggershl_shlnsw_lshrexact_after := by
  unfold positive_biggershl_shlnsw_lshrexact_before positive_biggershl_shlnsw_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggershl_shlnsw_lshrexact
  apply positive_biggershl_shlnsw_lshrexact_thm
  ---END positive_biggershl_shlnsw_lshrexact



def positive_samevar_shlnuw_lshrexact_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.lshr %arg0, %arg1 : i8
  %1 = llvm.shl %0, %arg1 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnuw_lshrexact_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  "llvm.return"(%arg0) : (i8) -> ()
}
]
theorem positive_samevar_shlnuw_lshrexact_proof : positive_samevar_shlnuw_lshrexact_before ⊑ positive_samevar_shlnuw_lshrexact_after := by
  unfold positive_samevar_shlnuw_lshrexact_before positive_samevar_shlnuw_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_samevar_shlnuw_lshrexact
  apply positive_samevar_shlnuw_lshrexact_thm
  ---END positive_samevar_shlnuw_lshrexact



def positive_sameconst_shlnuw_lshrexact_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %0 : i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnuw_lshrexact_after := [llvm|
{
^0(%arg0 : i8):
  "llvm.return"(%arg0) : (i8) -> ()
}
]
theorem positive_sameconst_shlnuw_lshrexact_proof : positive_sameconst_shlnuw_lshrexact_before ⊑ positive_sameconst_shlnuw_lshrexact_after := by
  unfold positive_sameconst_shlnuw_lshrexact_before positive_sameconst_shlnuw_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_sameconst_shlnuw_lshrexact
  apply positive_sameconst_shlnuw_lshrexact_thm
  ---END positive_sameconst_shlnuw_lshrexact



def positive_biggerlshr_shlnuw_lshrexact_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_shlnuw_lshrexact_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem positive_biggerlshr_shlnuw_lshrexact_proof : positive_biggerlshr_shlnuw_lshrexact_before ⊑ positive_biggerlshr_shlnuw_lshrexact_after := by
  unfold positive_biggerlshr_shlnuw_lshrexact_before positive_biggerlshr_shlnuw_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerlshr_shlnuw_lshrexact
  apply positive_biggerlshr_shlnuw_lshrexact_thm
  ---END positive_biggerlshr_shlnuw_lshrexact



def positive_biggershl_shlnuw_lshrexact_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnuw_lshrexact_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem positive_biggershl_shlnuw_lshrexact_proof : positive_biggershl_shlnuw_lshrexact_before ⊑ positive_biggershl_shlnuw_lshrexact_after := by
  unfold positive_biggershl_shlnuw_lshrexact_before positive_biggershl_shlnuw_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggershl_shlnuw_lshrexact
  apply positive_biggershl_shlnuw_lshrexact_thm
  ---END positive_biggershl_shlnuw_lshrexact



def positive_samevar_shlnuwnsw_lshrexact_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.lshr %arg0, %arg1 : i8
  %1 = llvm.shl %0, %arg1 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def positive_samevar_shlnuwnsw_lshrexact_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  "llvm.return"(%arg0) : (i8) -> ()
}
]
theorem positive_samevar_shlnuwnsw_lshrexact_proof : positive_samevar_shlnuwnsw_lshrexact_before ⊑ positive_samevar_shlnuwnsw_lshrexact_after := by
  unfold positive_samevar_shlnuwnsw_lshrexact_before positive_samevar_shlnuwnsw_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_samevar_shlnuwnsw_lshrexact
  apply positive_samevar_shlnuwnsw_lshrexact_thm
  ---END positive_samevar_shlnuwnsw_lshrexact



def positive_sameconst_shlnuwnsw_lshrexact_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %0 : i8
  %2 = llvm.shl %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def positive_sameconst_shlnuwnsw_lshrexact_after := [llvm|
{
^0(%arg0 : i8):
  "llvm.return"(%arg0) : (i8) -> ()
}
]
theorem positive_sameconst_shlnuwnsw_lshrexact_proof : positive_sameconst_shlnuwnsw_lshrexact_before ⊑ positive_sameconst_shlnuwnsw_lshrexact_after := by
  unfold positive_sameconst_shlnuwnsw_lshrexact_before positive_sameconst_shlnuwnsw_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_sameconst_shlnuwnsw_lshrexact
  apply positive_sameconst_shlnuwnsw_lshrexact_thm
  ---END positive_sameconst_shlnuwnsw_lshrexact



def positive_biggerlshr_shlnuwnsw_lshrexact_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggerlshr_shlnuwnsw_lshrexact_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.lshr %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem positive_biggerlshr_shlnuwnsw_lshrexact_proof : positive_biggerlshr_shlnuwnsw_lshrexact_before ⊑ positive_biggerlshr_shlnuwnsw_lshrexact_after := by
  unfold positive_biggerlshr_shlnuwnsw_lshrexact_before positive_biggerlshr_shlnuwnsw_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggerlshr_shlnuwnsw_lshrexact
  apply positive_biggerlshr_shlnuwnsw_lshrexact_thm
  ---END positive_biggerlshr_shlnuwnsw_lshrexact



def positive_biggershl_shlnuwnsw_lshrexact_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def positive_biggershl_shlnuwnsw_lshrexact_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem positive_biggershl_shlnuwnsw_lshrexact_proof : positive_biggershl_shlnuwnsw_lshrexact_before ⊑ positive_biggershl_shlnuwnsw_lshrexact_after := by
  unfold positive_biggershl_shlnuwnsw_lshrexact_before positive_biggershl_shlnuwnsw_lshrexact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN positive_biggershl_shlnuwnsw_lshrexact
  apply positive_biggershl_shlnuwnsw_lshrexact_thm
  ---END positive_biggershl_shlnuwnsw_lshrexact


