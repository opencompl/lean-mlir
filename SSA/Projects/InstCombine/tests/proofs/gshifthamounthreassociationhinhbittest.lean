import SSA.Projects.InstCombine.tests.proofs.gshifthamounthreassociationhinhbittest_proof
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
section gshifthamounthreassociationhinhbittest_statements

def t0_const_lshr_shl_ne_before := [llvm|
{
^0(%arg95 : i32, %arg96 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg95, %0 : i32
  %3 = llvm.shl %arg96, %0 : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def t0_const_lshr_shl_ne_after := [llvm|
{
^0(%arg95 : i32, %arg96 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg95, %0 : i32
  %3 = llvm.and %2, %arg96 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_const_lshr_shl_ne_proof : t0_const_lshr_shl_ne_before ⊑ t0_const_lshr_shl_ne_after := by
  unfold t0_const_lshr_shl_ne_before t0_const_lshr_shl_ne_after
  simp_alive_peephole
  intros
  ---BEGIN t0_const_lshr_shl_ne
  apply t0_const_lshr_shl_ne_thm
  ---END t0_const_lshr_shl_ne



def t1_const_shl_lshr_ne_before := [llvm|
{
^0(%arg93 : i32, %arg94 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %arg93, %0 : i32
  %3 = llvm.lshr %arg94, %0 : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def t1_const_shl_lshr_ne_after := [llvm|
{
^0(%arg93 : i32, %arg94 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg94, %0 : i32
  %3 = llvm.and %2, %arg93 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_const_shl_lshr_ne_proof : t1_const_shl_lshr_ne_before ⊑ t1_const_shl_lshr_ne_after := by
  unfold t1_const_shl_lshr_ne_before t1_const_shl_lshr_ne_after
  simp_alive_peephole
  intros
  ---BEGIN t1_const_shl_lshr_ne
  apply t1_const_shl_lshr_ne_thm
  ---END t1_const_shl_lshr_ne



def t2_const_lshr_shl_eq_before := [llvm|
{
^0(%arg91 : i32, %arg92 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg91, %0 : i32
  %3 = llvm.shl %arg92, %0 : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def t2_const_lshr_shl_eq_after := [llvm|
{
^0(%arg91 : i32, %arg92 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg91, %0 : i32
  %3 = llvm.and %2, %arg92 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t2_const_lshr_shl_eq_proof : t2_const_lshr_shl_eq_before ⊑ t2_const_lshr_shl_eq_after := by
  unfold t2_const_lshr_shl_eq_before t2_const_lshr_shl_eq_after
  simp_alive_peephole
  intros
  ---BEGIN t2_const_lshr_shl_eq
  apply t2_const_lshr_shl_eq_thm
  ---END t2_const_lshr_shl_eq



def t3_const_after_fold_lshr_shl_ne_before := [llvm|
{
^0(%arg88 : i32, %arg89 : i32, %arg90 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.sub %0, %arg90 : i32
  %4 = llvm.lshr %arg88, %3 : i32
  %5 = llvm.add %arg90, %1 : i32
  %6 = llvm.shl %arg89, %5 : i32
  %7 = llvm.and %4, %6 : i32
  %8 = llvm.icmp "ne" %7, %2 : i32
  "llvm.return"(%8) : (i1) -> ()
}
]
def t3_const_after_fold_lshr_shl_ne_after := [llvm|
{
^0(%arg88 : i32, %arg89 : i32, %arg90 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg88, %0 : i32
  %3 = llvm.and %2, %arg89 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t3_const_after_fold_lshr_shl_ne_proof : t3_const_after_fold_lshr_shl_ne_before ⊑ t3_const_after_fold_lshr_shl_ne_after := by
  unfold t3_const_after_fold_lshr_shl_ne_before t3_const_after_fold_lshr_shl_ne_after
  simp_alive_peephole
  intros
  ---BEGIN t3_const_after_fold_lshr_shl_ne
  apply t3_const_after_fold_lshr_shl_ne_thm
  ---END t3_const_after_fold_lshr_shl_ne



def t4_const_after_fold_lshr_shl_ne_before := [llvm|
{
^0(%arg85 : i32, %arg86 : i32, %arg87 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.sub %0, %arg87 : i32
  %4 = llvm.shl %arg85, %3 : i32
  %5 = llvm.add %arg87, %1 : i32
  %6 = llvm.lshr %arg86, %5 : i32
  %7 = llvm.and %4, %6 : i32
  %8 = llvm.icmp "ne" %7, %2 : i32
  "llvm.return"(%8) : (i1) -> ()
}
]
def t4_const_after_fold_lshr_shl_ne_after := [llvm|
{
^0(%arg85 : i32, %arg86 : i32, %arg87 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg86, %0 : i32
  %3 = llvm.and %2, %arg85 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t4_const_after_fold_lshr_shl_ne_proof : t4_const_after_fold_lshr_shl_ne_before ⊑ t4_const_after_fold_lshr_shl_ne_after := by
  unfold t4_const_after_fold_lshr_shl_ne_before t4_const_after_fold_lshr_shl_ne_after
  simp_alive_peephole
  intros
  ---BEGIN t4_const_after_fold_lshr_shl_ne
  apply t4_const_after_fold_lshr_shl_ne_thm
  ---END t4_const_after_fold_lshr_shl_ne


