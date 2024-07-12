import SSA.Projects.InstCombine.lean.gshlhfactor_proof
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
                                                                       
def add_shl_same_amount_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.add %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.add %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem add_shl_same_amount_proof : add_shl_same_amount_before ⊑ add_shl_same_amount_after := by
  unfold add_shl_same_amount_before add_shl_same_amount_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_shl_same_amount
  apply add_shl_same_amount_thm
  ---END add_shl_same_amount



def add_shl_same_amount_nuw_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64):
  %0 = llvm.shl %arg0, %arg2 : i64
  %1 = llvm.shl %arg1, %arg2 : i64
  %2 = llvm.add %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def add_shl_same_amount_nuw_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64):
  %0 = llvm.add %arg0, %arg1 : i64
  %1 = llvm.shl %0, %arg2 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem add_shl_same_amount_nuw_proof : add_shl_same_amount_nuw_before ⊑ add_shl_same_amount_nuw_after := by
  unfold add_shl_same_amount_nuw_before add_shl_same_amount_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_shl_same_amount_nuw
  apply add_shl_same_amount_nuw_thm
  ---END add_shl_same_amount_nuw



def add_shl_same_amount_partial_nsw1_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.add %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_partial_nsw1_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.add %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem add_shl_same_amount_partial_nsw1_proof : add_shl_same_amount_partial_nsw1_before ⊑ add_shl_same_amount_partial_nsw1_after := by
  unfold add_shl_same_amount_partial_nsw1_before add_shl_same_amount_partial_nsw1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_shl_same_amount_partial_nsw1
  apply add_shl_same_amount_partial_nsw1_thm
  ---END add_shl_same_amount_partial_nsw1



def add_shl_same_amount_partial_nsw2_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.add %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_partial_nsw2_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.add %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem add_shl_same_amount_partial_nsw2_proof : add_shl_same_amount_partial_nsw2_before ⊑ add_shl_same_amount_partial_nsw2_after := by
  unfold add_shl_same_amount_partial_nsw2_before add_shl_same_amount_partial_nsw2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_shl_same_amount_partial_nsw2
  apply add_shl_same_amount_partial_nsw2_thm
  ---END add_shl_same_amount_partial_nsw2



def add_shl_same_amount_partial_nuw1_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.add %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_partial_nuw1_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.add %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem add_shl_same_amount_partial_nuw1_proof : add_shl_same_amount_partial_nuw1_before ⊑ add_shl_same_amount_partial_nuw1_after := by
  unfold add_shl_same_amount_partial_nuw1_before add_shl_same_amount_partial_nuw1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_shl_same_amount_partial_nuw1
  apply add_shl_same_amount_partial_nuw1_thm
  ---END add_shl_same_amount_partial_nuw1



def add_shl_same_amount_partial_nuw2_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.add %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def add_shl_same_amount_partial_nuw2_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.add %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem add_shl_same_amount_partial_nuw2_proof : add_shl_same_amount_partial_nuw2_before ⊑ add_shl_same_amount_partial_nuw2_after := by
  unfold add_shl_same_amount_partial_nuw2_before add_shl_same_amount_partial_nuw2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_shl_same_amount_partial_nuw2
  apply add_shl_same_amount_partial_nuw2_thm
  ---END add_shl_same_amount_partial_nuw2



def sub_shl_same_amount_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.sub %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.sub %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem sub_shl_same_amount_proof : sub_shl_same_amount_before ⊑ sub_shl_same_amount_after := by
  unfold sub_shl_same_amount_before sub_shl_same_amount_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_shl_same_amount
  apply sub_shl_same_amount_thm
  ---END sub_shl_same_amount



def sub_shl_same_amount_nuw_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64):
  %0 = llvm.shl %arg0, %arg2 : i64
  %1 = llvm.shl %arg1, %arg2 : i64
  %2 = llvm.sub %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def sub_shl_same_amount_nuw_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64):
  %0 = llvm.sub %arg0, %arg1 : i64
  %1 = llvm.shl %0, %arg2 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem sub_shl_same_amount_nuw_proof : sub_shl_same_amount_nuw_before ⊑ sub_shl_same_amount_nuw_after := by
  unfold sub_shl_same_amount_nuw_before sub_shl_same_amount_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_shl_same_amount_nuw
  apply sub_shl_same_amount_nuw_thm
  ---END sub_shl_same_amount_nuw



def sub_shl_same_amount_partial_nsw1_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.sub %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_partial_nsw1_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.sub %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem sub_shl_same_amount_partial_nsw1_proof : sub_shl_same_amount_partial_nsw1_before ⊑ sub_shl_same_amount_partial_nsw1_after := by
  unfold sub_shl_same_amount_partial_nsw1_before sub_shl_same_amount_partial_nsw1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_shl_same_amount_partial_nsw1
  apply sub_shl_same_amount_partial_nsw1_thm
  ---END sub_shl_same_amount_partial_nsw1



def sub_shl_same_amount_partial_nsw2_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.sub %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_partial_nsw2_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.sub %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem sub_shl_same_amount_partial_nsw2_proof : sub_shl_same_amount_partial_nsw2_before ⊑ sub_shl_same_amount_partial_nsw2_after := by
  unfold sub_shl_same_amount_partial_nsw2_before sub_shl_same_amount_partial_nsw2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_shl_same_amount_partial_nsw2
  apply sub_shl_same_amount_partial_nsw2_thm
  ---END sub_shl_same_amount_partial_nsw2



def sub_shl_same_amount_partial_nuw1_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.sub %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_partial_nuw1_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.sub %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem sub_shl_same_amount_partial_nuw1_proof : sub_shl_same_amount_partial_nuw1_before ⊑ sub_shl_same_amount_partial_nuw1_after := by
  unfold sub_shl_same_amount_partial_nuw1_before sub_shl_same_amount_partial_nuw1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_shl_same_amount_partial_nuw1
  apply sub_shl_same_amount_partial_nuw1_thm
  ---END sub_shl_same_amount_partial_nuw1



def sub_shl_same_amount_partial_nuw2_before := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.shl %arg0, %arg2 : i6
  %1 = llvm.shl %arg1, %arg2 : i6
  %2 = llvm.sub %0, %1 : i6
  "llvm.return"(%2) : (i6) -> ()
}
]
def sub_shl_same_amount_partial_nuw2_after := [llvm|
{
^0(%arg0 : i6, %arg1 : i6, %arg2 : i6):
  %0 = llvm.sub %arg0, %arg1 : i6
  %1 = llvm.shl %0, %arg2 : i6
  "llvm.return"(%1) : (i6) -> ()
}
]
theorem sub_shl_same_amount_partial_nuw2_proof : sub_shl_same_amount_partial_nuw2_before ⊑ sub_shl_same_amount_partial_nuw2_after := by
  unfold sub_shl_same_amount_partial_nuw2_before sub_shl_same_amount_partial_nuw2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_shl_same_amount_partial_nuw2
  apply sub_shl_same_amount_partial_nuw2_thm
  ---END sub_shl_same_amount_partial_nuw2


