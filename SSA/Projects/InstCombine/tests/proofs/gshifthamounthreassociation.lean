import SSA.Projects.InstCombine.tests.proofs.gshifthamounthreassociation_proof
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
section gshifthamounthreassociation_statements

def t0_before := [llvm|
{
^0(%arg43 : i32, %arg44 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.sub %0, %arg44 : i32
  %3 = llvm.lshr %arg43, %2 : i32
  %4 = llvm.add %arg44, %1 : i32
  %5 = llvm.lshr exact %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg43 : i32, %arg44 : i32):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.lshr %arg43, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  intros
  ---BEGIN t0
  apply t0_thm
  ---END t0



def t6_shl_before := [llvm|
{
^0(%arg31 : i32, %arg32 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.sub %0, %arg32 : i32
  %3 = llvm.shl %arg31, %2 overflow<nuw> : i32
  %4 = llvm.add %arg32, %1 : i32
  %5 = llvm.shl %3, %4 overflow<nsw> : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t6_shl_after := [llvm|
{
^0(%arg31 : i32, %arg32 : i32):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.shl %arg31, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t6_shl_proof : t6_shl_before ⊑ t6_shl_after := by
  unfold t6_shl_before t6_shl_after
  simp_alive_peephole
  intros
  ---BEGIN t6_shl
  apply t6_shl_thm
  ---END t6_shl



def t7_ashr_before := [llvm|
{
^0(%arg29 : i32, %arg30 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.sub %0, %arg30 : i32
  %3 = llvm.ashr exact %arg29, %2 : i32
  %4 = llvm.add %arg30, %1 : i32
  %5 = llvm.ashr %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t7_ashr_after := [llvm|
{
^0(%arg29 : i32, %arg30 : i32):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.ashr %arg29, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t7_ashr_proof : t7_ashr_before ⊑ t7_ashr_after := by
  unfold t7_ashr_before t7_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN t7_ashr
  apply t7_ashr_thm
  ---END t7_ashr



def t8_lshr_exact_flag_preservation_before := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.sub %0, %arg28 : i32
  %3 = llvm.lshr exact %arg27, %2 : i32
  %4 = llvm.add %arg28, %1 : i32
  %5 = llvm.lshr exact %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t8_lshr_exact_flag_preservation_after := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.lshr exact %arg27, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t8_lshr_exact_flag_preservation_proof : t8_lshr_exact_flag_preservation_before ⊑ t8_lshr_exact_flag_preservation_after := by
  unfold t8_lshr_exact_flag_preservation_before t8_lshr_exact_flag_preservation_after
  simp_alive_peephole
  intros
  ---BEGIN t8_lshr_exact_flag_preservation
  apply t8_lshr_exact_flag_preservation_thm
  ---END t8_lshr_exact_flag_preservation



def t9_ashr_exact_flag_preservation_before := [llvm|
{
^0(%arg25 : i32, %arg26 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.sub %0, %arg26 : i32
  %3 = llvm.ashr exact %arg25, %2 : i32
  %4 = llvm.add %arg26, %1 : i32
  %5 = llvm.ashr exact %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t9_ashr_exact_flag_preservation_after := [llvm|
{
^0(%arg25 : i32, %arg26 : i32):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.ashr exact %arg25, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t9_ashr_exact_flag_preservation_proof : t9_ashr_exact_flag_preservation_before ⊑ t9_ashr_exact_flag_preservation_after := by
  unfold t9_ashr_exact_flag_preservation_before t9_ashr_exact_flag_preservation_after
  simp_alive_peephole
  intros
  ---BEGIN t9_ashr_exact_flag_preservation
  apply t9_ashr_exact_flag_preservation_thm
  ---END t9_ashr_exact_flag_preservation



def t10_shl_nuw_flag_preservation_before := [llvm|
{
^0(%arg23 : i32, %arg24 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.sub %0, %arg24 : i32
  %3 = llvm.shl %arg23, %2 overflow<nuw> : i32
  %4 = llvm.add %arg24, %1 : i32
  %5 = llvm.shl %3, %4 overflow<nsw,nuw> : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t10_shl_nuw_flag_preservation_after := [llvm|
{
^0(%arg23 : i32, %arg24 : i32):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.shl %arg23, %0 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t10_shl_nuw_flag_preservation_proof : t10_shl_nuw_flag_preservation_before ⊑ t10_shl_nuw_flag_preservation_after := by
  unfold t10_shl_nuw_flag_preservation_before t10_shl_nuw_flag_preservation_after
  simp_alive_peephole
  intros
  ---BEGIN t10_shl_nuw_flag_preservation
  apply t10_shl_nuw_flag_preservation_thm
  ---END t10_shl_nuw_flag_preservation



def t11_shl_nsw_flag_preservation_before := [llvm|
{
^0(%arg21 : i32, %arg22 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.sub %0, %arg22 : i32
  %3 = llvm.shl %arg21, %2 overflow<nsw> : i32
  %4 = llvm.add %arg22, %1 : i32
  %5 = llvm.shl %3, %4 overflow<nsw,nuw> : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t11_shl_nsw_flag_preservation_after := [llvm|
{
^0(%arg21 : i32, %arg22 : i32):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.shl %arg21, %0 overflow<nsw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t11_shl_nsw_flag_preservation_proof : t11_shl_nsw_flag_preservation_before ⊑ t11_shl_nsw_flag_preservation_after := by
  unfold t11_shl_nsw_flag_preservation_before t11_shl_nsw_flag_preservation_after
  simp_alive_peephole
  intros
  ---BEGIN t11_shl_nsw_flag_preservation
  apply t11_shl_nsw_flag_preservation_thm
  ---END t11_shl_nsw_flag_preservation


