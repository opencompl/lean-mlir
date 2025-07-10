import SSA.Projects.InstCombine.tests.proofs.gicmphshlh1hoverflow_proof
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
section gicmphshlh1hoverflow_statements

def icmp_shl_ugt_1_before := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %arg15, %0 : i8
  %2 = llvm.icmp "ugt" %1, %arg15 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def icmp_shl_ugt_1_after := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "sgt" %arg15, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_shl_ugt_1_proof : icmp_shl_ugt_1_before ⊑ icmp_shl_ugt_1_after := by
  unfold icmp_shl_ugt_1_before icmp_shl_ugt_1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_shl_ugt_1
  apply icmp_shl_ugt_1_thm
  ---END icmp_shl_ugt_1



def icmp_shl_uge_2_before := [llvm|
{
^0(%arg12 : i5):
  %0 = llvm.mlir.constant(10 : i5) : i5
  %1 = llvm.mlir.constant(1 : i5) : i5
  %2 = llvm.add %0, %arg12 : i5
  %3 = llvm.shl %2, %1 : i5
  %4 = llvm.icmp "uge" %2, %3 : i5
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_shl_uge_2_after := [llvm|
{
^0(%arg12 : i5):
  %0 = llvm.mlir.constant(10 : i5) : i5
  %1 = llvm.mlir.constant(1 : i5) : i5
  %2 = llvm.add %arg12, %0 : i5
  %3 = llvm.icmp "slt" %2, %1 : i5
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_shl_uge_2_proof : icmp_shl_uge_2_before ⊑ icmp_shl_uge_2_after := by
  unfold icmp_shl_uge_2_before icmp_shl_uge_2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_shl_uge_2
  apply icmp_shl_uge_2_thm
  ---END icmp_shl_uge_2



def icmp_shl_ule_2_before := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.add %0, %arg8 : i8
  %3 = llvm.shl %2, %1 : i8
  %4 = llvm.icmp "ule" %2, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_shl_ule_2_after := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.add %arg8, %0 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_shl_ule_2_proof : icmp_shl_ule_2_before ⊑ icmp_shl_ule_2_after := by
  unfold icmp_shl_ule_2_before icmp_shl_ule_2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_shl_ule_2
  apply icmp_shl_ule_2_thm
  ---END icmp_shl_ule_2



def icmp_shl_eq_1_before := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %arg7, %0 : i8
  %2 = llvm.icmp "eq" %1, %arg7 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def icmp_shl_eq_1_after := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg7, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_shl_eq_1_proof : icmp_shl_eq_1_before ⊑ icmp_shl_eq_1_after := by
  unfold icmp_shl_eq_1_before icmp_shl_eq_1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_shl_eq_1
  apply icmp_shl_eq_1_thm
  ---END icmp_shl_eq_1



def icmp_shl_ne_2_before := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.sdiv %0, %arg4 : i8
  %3 = llvm.shl %2, %1 : i8
  %4 = llvm.icmp "ne" %2, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_shl_ne_2_after := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.sdiv %0, %arg4 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_shl_ne_2_proof : icmp_shl_ne_2_before ⊑ icmp_shl_ne_2_after := by
  unfold icmp_shl_ne_2_before icmp_shl_ne_2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_shl_ne_2
  apply icmp_shl_ne_2_thm
  ---END icmp_shl_ne_2


