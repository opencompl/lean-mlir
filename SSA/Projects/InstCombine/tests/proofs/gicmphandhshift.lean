import SSA.Projects.InstCombine.tests.proofs.gicmphandhshift_proof
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
section gicmphandhshift_statements

def icmp_eq_and_pow2_shl1_before := [llvm|
{
^0(%arg69 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg69 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_eq_and_pow2_shl1_after := [llvm|
{
^0(%arg69 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.icmp "ne" %arg69, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_and_pow2_shl1_proof : icmp_eq_and_pow2_shl1_before ⊑ icmp_eq_and_pow2_shl1_after := by
  unfold icmp_eq_and_pow2_shl1_before icmp_eq_and_pow2_shl1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_and_pow2_shl1
  apply icmp_eq_and_pow2_shl1_thm
  ---END icmp_eq_and_pow2_shl1



def icmp_ne_and_pow2_shl1_before := [llvm|
{
^0(%arg67 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg67 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "ne" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_ne_and_pow2_shl1_after := [llvm|
{
^0(%arg67 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.icmp "eq" %arg67, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_and_pow2_shl1_proof : icmp_ne_and_pow2_shl1_before ⊑ icmp_ne_and_pow2_shl1_after := by
  unfold icmp_ne_and_pow2_shl1_before icmp_ne_and_pow2_shl1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_and_pow2_shl1
  apply icmp_ne_and_pow2_shl1_thm
  ---END icmp_ne_and_pow2_shl1



def icmp_eq_and_pow2_shl_pow2_before := [llvm|
{
^0(%arg65 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg65 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_eq_and_pow2_shl_pow2_after := [llvm|
{
^0(%arg65 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "ne" %arg65, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_and_pow2_shl_pow2_proof : icmp_eq_and_pow2_shl_pow2_before ⊑ icmp_eq_and_pow2_shl_pow2_after := by
  unfold icmp_eq_and_pow2_shl_pow2_before icmp_eq_and_pow2_shl_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_and_pow2_shl_pow2
  apply icmp_eq_and_pow2_shl_pow2_thm
  ---END icmp_eq_and_pow2_shl_pow2



def icmp_ne_and_pow2_shl_pow2_before := [llvm|
{
^0(%arg63 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg63 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "ne" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_ne_and_pow2_shl_pow2_after := [llvm|
{
^0(%arg63 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "eq" %arg63, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_and_pow2_shl_pow2_proof : icmp_ne_and_pow2_shl_pow2_before ⊑ icmp_ne_and_pow2_shl_pow2_after := by
  unfold icmp_ne_and_pow2_shl_pow2_before icmp_ne_and_pow2_shl_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_and_pow2_shl_pow2
  apply icmp_ne_and_pow2_shl_pow2_thm
  ---END icmp_ne_and_pow2_shl_pow2



def icmp_eq_and_pow2_shl_pow2_negative1_before := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(11 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg61 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_eq_and_pow2_shl_pow2_negative1_after := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(11 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.shl %0, %arg61 : i32
  %4 = llvm.lshr %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  %6 = llvm.xor %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_and_pow2_shl_pow2_negative1_proof : icmp_eq_and_pow2_shl_pow2_negative1_before ⊑ icmp_eq_and_pow2_shl_pow2_negative1_after := by
  unfold icmp_eq_and_pow2_shl_pow2_negative1_before icmp_eq_and_pow2_shl_pow2_negative1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_and_pow2_shl_pow2_negative1
  apply icmp_eq_and_pow2_shl_pow2_negative1_thm
  ---END icmp_eq_and_pow2_shl_pow2_negative1



def icmp_eq_and_pow2_shl_pow2_negative2_before := [llvm|
{
^0(%arg60 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(14 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg60 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_eq_and_pow2_shl_pow2_negative2_after := [llvm|
{
^0(%arg60 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ugt" %arg60, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_and_pow2_shl_pow2_negative2_proof : icmp_eq_and_pow2_shl_pow2_negative2_before ⊑ icmp_eq_and_pow2_shl_pow2_negative2_after := by
  unfold icmp_eq_and_pow2_shl_pow2_negative2_before icmp_eq_and_pow2_shl_pow2_negative2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_and_pow2_shl_pow2_negative2
  apply icmp_eq_and_pow2_shl_pow2_negative2_thm
  ---END icmp_eq_and_pow2_shl_pow2_negative2



def icmp_eq_and_pow2_shl_pow2_negative3_before := [llvm|
{
^0(%arg59 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg59 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_eq_and_pow2_shl_pow2_negative3_after := [llvm|
{
^0(%arg59 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_and_pow2_shl_pow2_negative3_proof : icmp_eq_and_pow2_shl_pow2_negative3_before ⊑ icmp_eq_and_pow2_shl_pow2_negative3_after := by
  unfold icmp_eq_and_pow2_shl_pow2_negative3_before icmp_eq_and_pow2_shl_pow2_negative3_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_and_pow2_shl_pow2_negative3
  apply icmp_eq_and_pow2_shl_pow2_negative3_thm
  ---END icmp_eq_and_pow2_shl_pow2_negative3



def icmp_eq_and_pow2_minus1_shl1_before := [llvm|
{
^0(%arg58 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg58 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_eq_and_pow2_minus1_shl1_after := [llvm|
{
^0(%arg58 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "ugt" %arg58, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_and_pow2_minus1_shl1_proof : icmp_eq_and_pow2_minus1_shl1_before ⊑ icmp_eq_and_pow2_minus1_shl1_after := by
  unfold icmp_eq_and_pow2_minus1_shl1_before icmp_eq_and_pow2_minus1_shl1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_and_pow2_minus1_shl1
  apply icmp_eq_and_pow2_minus1_shl1_thm
  ---END icmp_eq_and_pow2_minus1_shl1



def icmp_ne_and_pow2_minus1_shl1_before := [llvm|
{
^0(%arg56 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg56 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "ne" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_ne_and_pow2_minus1_shl1_after := [llvm|
{
^0(%arg56 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.icmp "ult" %arg56, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_and_pow2_minus1_shl1_proof : icmp_ne_and_pow2_minus1_shl1_before ⊑ icmp_ne_and_pow2_minus1_shl1_after := by
  unfold icmp_ne_and_pow2_minus1_shl1_before icmp_ne_and_pow2_minus1_shl1_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_and_pow2_minus1_shl1
  apply icmp_ne_and_pow2_minus1_shl1_thm
  ---END icmp_ne_and_pow2_minus1_shl1



def icmp_eq_and_pow2_minus1_shl_pow2_before := [llvm|
{
^0(%arg54 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg54 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_eq_and_pow2_minus1_shl_pow2_after := [llvm|
{
^0(%arg54 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ugt" %arg54, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_and_pow2_minus1_shl_pow2_proof : icmp_eq_and_pow2_minus1_shl_pow2_before ⊑ icmp_eq_and_pow2_minus1_shl_pow2_after := by
  unfold icmp_eq_and_pow2_minus1_shl_pow2_before icmp_eq_and_pow2_minus1_shl_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_and_pow2_minus1_shl_pow2
  apply icmp_eq_and_pow2_minus1_shl_pow2_thm
  ---END icmp_eq_and_pow2_minus1_shl_pow2



def icmp_ne_and_pow2_minus1_shl_pow2_before := [llvm|
{
^0(%arg52 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg52 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "ne" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_ne_and_pow2_minus1_shl_pow2_after := [llvm|
{
^0(%arg52 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "ult" %arg52, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_and_pow2_minus1_shl_pow2_proof : icmp_ne_and_pow2_minus1_shl_pow2_before ⊑ icmp_ne_and_pow2_minus1_shl_pow2_after := by
  unfold icmp_ne_and_pow2_minus1_shl_pow2_before icmp_ne_and_pow2_minus1_shl_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_and_pow2_minus1_shl_pow2
  apply icmp_ne_and_pow2_minus1_shl_pow2_thm
  ---END icmp_ne_and_pow2_minus1_shl_pow2



def icmp_eq_and_pow2_minus1_shl1_negative2_before := [llvm|
{
^0(%arg49 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg49 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_eq_and_pow2_minus1_shl1_negative2_after := [llvm|
{
^0(%arg49 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_and_pow2_minus1_shl1_negative2_proof : icmp_eq_and_pow2_minus1_shl1_negative2_before ⊑ icmp_eq_and_pow2_minus1_shl1_negative2_after := by
  unfold icmp_eq_and_pow2_minus1_shl1_negative2_before icmp_eq_and_pow2_minus1_shl1_negative2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_and_pow2_minus1_shl1_negative2
  apply icmp_eq_and_pow2_minus1_shl1_negative2_thm
  ---END icmp_eq_and_pow2_minus1_shl1_negative2



def icmp_eq_and1_lshr_pow2_before := [llvm|
{
^0(%arg48 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %0, %arg48 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_eq_and1_lshr_pow2_after := [llvm|
{
^0(%arg48 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "ne" %arg48, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_and1_lshr_pow2_proof : icmp_eq_and1_lshr_pow2_before ⊑ icmp_eq_and1_lshr_pow2_after := by
  unfold icmp_eq_and1_lshr_pow2_before icmp_eq_and1_lshr_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_and1_lshr_pow2
  apply icmp_eq_and1_lshr_pow2_thm
  ---END icmp_eq_and1_lshr_pow2



def icmp_ne_and1_lshr_pow2_before := [llvm|
{
^0(%arg46 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %0, %arg46 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_ne_and1_lshr_pow2_after := [llvm|
{
^0(%arg46 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.icmp "ne" %arg46, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_and1_lshr_pow2_proof : icmp_ne_and1_lshr_pow2_before ⊑ icmp_ne_and1_lshr_pow2_after := by
  unfold icmp_ne_and1_lshr_pow2_before icmp_ne_and1_lshr_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_and1_lshr_pow2
  apply icmp_ne_and1_lshr_pow2_thm
  ---END icmp_ne_and1_lshr_pow2



def icmp_eq_and_pow2_lshr_pow2_before := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %0, %arg44 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_eq_and_pow2_lshr_pow2_after := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ne" %arg44, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_and_pow2_lshr_pow2_proof : icmp_eq_and_pow2_lshr_pow2_before ⊑ icmp_eq_and_pow2_lshr_pow2_after := by
  unfold icmp_eq_and_pow2_lshr_pow2_before icmp_eq_and_pow2_lshr_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_and_pow2_lshr_pow2
  apply icmp_eq_and_pow2_lshr_pow2_thm
  ---END icmp_eq_and_pow2_lshr_pow2



def icmp_eq_and_pow2_lshr_pow2_case2_before := [llvm|
{
^0(%arg43 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %0, %arg43 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_eq_and_pow2_lshr_pow2_case2_after := [llvm|
{
^0(%arg43 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_and_pow2_lshr_pow2_case2_proof : icmp_eq_and_pow2_lshr_pow2_case2_before ⊑ icmp_eq_and_pow2_lshr_pow2_case2_after := by
  unfold icmp_eq_and_pow2_lshr_pow2_case2_before icmp_eq_and_pow2_lshr_pow2_case2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_and_pow2_lshr_pow2_case2
  apply icmp_eq_and_pow2_lshr_pow2_case2_thm
  ---END icmp_eq_and_pow2_lshr_pow2_case2



def icmp_ne_and_pow2_lshr_pow2_before := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %0, %arg41 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_ne_and_pow2_lshr_pow2_after := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ne" %arg41, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_and_pow2_lshr_pow2_proof : icmp_ne_and_pow2_lshr_pow2_before ⊑ icmp_ne_and_pow2_lshr_pow2_after := by
  unfold icmp_ne_and_pow2_lshr_pow2_before icmp_ne_and_pow2_lshr_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_and_pow2_lshr_pow2
  apply icmp_ne_and_pow2_lshr_pow2_thm
  ---END icmp_ne_and_pow2_lshr_pow2



def icmp_ne_and_pow2_lshr_pow2_case2_before := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %0, %arg40 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_ne_and_pow2_lshr_pow2_case2_after := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_and_pow2_lshr_pow2_case2_proof : icmp_ne_and_pow2_lshr_pow2_case2_before ⊑ icmp_ne_and_pow2_lshr_pow2_case2_after := by
  unfold icmp_ne_and_pow2_lshr_pow2_case2_before icmp_ne_and_pow2_lshr_pow2_case2_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_and_pow2_lshr_pow2_case2
  apply icmp_ne_and_pow2_lshr_pow2_case2_thm
  ---END icmp_ne_and_pow2_lshr_pow2_case2



def icmp_eq_and1_lshr_pow2_minus_one_before := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %0, %arg38 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def icmp_eq_and1_lshr_pow2_minus_one_after := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ugt" %arg38, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_and1_lshr_pow2_minus_one_proof : icmp_eq_and1_lshr_pow2_minus_one_before ⊑ icmp_eq_and1_lshr_pow2_minus_one_after := by
  unfold icmp_eq_and1_lshr_pow2_minus_one_before icmp_eq_and1_lshr_pow2_minus_one_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_and1_lshr_pow2_minus_one
  apply icmp_eq_and1_lshr_pow2_minus_one_thm
  ---END icmp_eq_and1_lshr_pow2_minus_one



def eq_and_shl_one_before := [llvm|
{
^0(%arg35 : i8, %arg36 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %0, %arg36 : i8
  %2 = llvm.and %1, %arg35 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_and_shl_one_after := [llvm|
{
^0(%arg35 : i8, %arg36 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg36 overflow<nuw> : i8
  %3 = llvm.and %2, %arg35 : i8
  %4 = llvm.icmp "ne" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_and_shl_one_proof : eq_and_shl_one_before ⊑ eq_and_shl_one_after := by
  unfold eq_and_shl_one_before eq_and_shl_one_after
  simp_alive_peephole
  intros
  ---BEGIN eq_and_shl_one
  apply eq_and_shl_one_thm
  ---END eq_and_shl_one



def ne_and_lshr_minval_before := [llvm|
{
^0(%arg31 : i8, %arg32 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mul %arg31, %arg31 : i8
  %2 = llvm.lshr %0, %arg32 : i8
  %3 = llvm.and %1, %2 : i8
  %4 = llvm.icmp "ne" %3, %2 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def ne_and_lshr_minval_after := [llvm|
{
^0(%arg31 : i8, %arg32 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mul %arg31, %arg31 : i8
  %3 = llvm.lshr exact %0, %arg32 : i8
  %4 = llvm.and %2, %3 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_and_lshr_minval_proof : ne_and_lshr_minval_before ⊑ ne_and_lshr_minval_after := by
  unfold ne_and_lshr_minval_before ne_and_lshr_minval_after
  simp_alive_peephole
  intros
  ---BEGIN ne_and_lshr_minval
  apply ne_and_lshr_minval_thm
  ---END ne_and_lshr_minval



def slt_and_shl_one_before := [llvm|
{
^0(%arg25 : i8, %arg26 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %0, %arg26 : i8
  %2 = llvm.and %arg25, %1 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_and_shl_one_after := [llvm|
{
^0(%arg25 : i8, %arg26 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %0, %arg26 overflow<nuw> : i8
  %2 = llvm.and %arg25, %1 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_and_shl_one_proof : slt_and_shl_one_before ⊑ slt_and_shl_one_after := by
  unfold slt_and_shl_one_before slt_and_shl_one_after
  simp_alive_peephole
  intros
  ---BEGIN slt_and_shl_one
  apply slt_and_shl_one_thm
  ---END slt_and_shl_one



def fold_eq_lhs_before := [llvm|
{
^0(%arg23 : i8, %arg24 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg23 : i8
  %3 = llvm.and %2, %arg24 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_eq_lhs_after := [llvm|
{
^0(%arg23 : i8, %arg24 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.lshr %arg24, %arg23 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_eq_lhs_proof : fold_eq_lhs_before ⊑ fold_eq_lhs_after := by
  unfold fold_eq_lhs_before fold_eq_lhs_after
  simp_alive_peephole
  intros
  ---BEGIN fold_eq_lhs
  apply fold_eq_lhs_thm
  ---END fold_eq_lhs



def fold_eq_lhs_fail_eq_nonzero_before := [llvm|
{
^0(%arg21 : i8, %arg22 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.shl %0, %arg21 : i8
  %3 = llvm.and %2, %arg22 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_eq_lhs_fail_eq_nonzero_after := [llvm|
{
^0(%arg21 : i8, %arg22 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.shl %0, %arg21 overflow<nsw> : i8
  %3 = llvm.and %2, %arg22 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_eq_lhs_fail_eq_nonzero_proof : fold_eq_lhs_fail_eq_nonzero_before ⊑ fold_eq_lhs_fail_eq_nonzero_after := by
  unfold fold_eq_lhs_fail_eq_nonzero_before fold_eq_lhs_fail_eq_nonzero_after
  simp_alive_peephole
  intros
  ---BEGIN fold_eq_lhs_fail_eq_nonzero
  apply fold_eq_lhs_fail_eq_nonzero_thm
  ---END fold_eq_lhs_fail_eq_nonzero



def fold_ne_rhs_before := [llvm|
{
^0(%arg17 : i8, %arg18 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.xor %arg18, %0 : i8
  %4 = llvm.shl %1, %arg17 : i8
  %5 = llvm.and %3, %4 : i8
  %6 = llvm.icmp "ne" %5, %2 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def fold_ne_rhs_after := [llvm|
{
^0(%arg17 : i8, %arg18 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.xor %arg18, %0 : i8
  %3 = llvm.lshr %2, %arg17 : i8
  %4 = llvm.icmp "ne" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_ne_rhs_proof : fold_ne_rhs_before ⊑ fold_ne_rhs_after := by
  unfold fold_ne_rhs_before fold_ne_rhs_after
  simp_alive_peephole
  intros
  ---BEGIN fold_ne_rhs
  apply fold_ne_rhs_thm
  ---END fold_ne_rhs



def fold_ne_rhs_fail_shift_not_1s_before := [llvm|
{
^0(%arg13 : i8, %arg14 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.xor %arg14, %0 : i8
  %4 = llvm.shl %1, %arg13 : i8
  %5 = llvm.and %3, %4 : i8
  %6 = llvm.icmp "ne" %5, %2 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def fold_ne_rhs_fail_shift_not_1s_after := [llvm|
{
^0(%arg13 : i8, %arg14 : i8):
  %0 = llvm.mlir.constant(122 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.xor %arg14, %0 : i8
  %4 = llvm.shl %1, %arg13 : i8
  %5 = llvm.and %3, %4 : i8
  %6 = llvm.icmp "ne" %5, %2 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_ne_rhs_fail_shift_not_1s_proof : fold_ne_rhs_fail_shift_not_1s_before ⊑ fold_ne_rhs_fail_shift_not_1s_after := by
  unfold fold_ne_rhs_fail_shift_not_1s_before fold_ne_rhs_fail_shift_not_1s_after
  simp_alive_peephole
  intros
  ---BEGIN fold_ne_rhs_fail_shift_not_1s
  apply fold_ne_rhs_fail_shift_not_1s_thm
  ---END fold_ne_rhs_fail_shift_not_1s



def test_shr_and_1_ne_0_before := [llvm|
{
^0(%arg11 : i32, %arg12 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg11, %arg12 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def test_shr_and_1_ne_0_after := [llvm|
{
^0(%arg11 : i32, %arg12 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg12 overflow<nuw> : i32
  %3 = llvm.and %arg11, %2 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shr_and_1_ne_0_proof : test_shr_and_1_ne_0_before ⊑ test_shr_and_1_ne_0_after := by
  unfold test_shr_and_1_ne_0_before test_shr_and_1_ne_0_after
  simp_alive_peephole
  intros
  ---BEGIN test_shr_and_1_ne_0
  apply test_shr_and_1_ne_0_thm
  ---END test_shr_and_1_ne_0



def test_shr_and_1_ne_0_samesign_before := [llvm|
{
^0(%arg9 : i32, %arg10 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg9, %arg10 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def test_shr_and_1_ne_0_samesign_after := [llvm|
{
^0(%arg9 : i32, %arg10 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg10 overflow<nuw> : i32
  %3 = llvm.and %arg9, %2 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shr_and_1_ne_0_samesign_proof : test_shr_and_1_ne_0_samesign_before ⊑ test_shr_and_1_ne_0_samesign_after := by
  unfold test_shr_and_1_ne_0_samesign_before test_shr_and_1_ne_0_samesign_after
  simp_alive_peephole
  intros
  ---BEGIN test_shr_and_1_ne_0_samesign
  apply test_shr_and_1_ne_0_samesign_thm
  ---END test_shr_and_1_ne_0_samesign



def test_const_shr_and_1_ne_0_before := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %0, %arg8 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "ne" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_const_shr_and_1_ne_0_after := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg8 overflow<nuw> : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "ne" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_const_shr_and_1_ne_0_proof : test_const_shr_and_1_ne_0_before ⊑ test_const_shr_and_1_ne_0_after := by
  unfold test_const_shr_and_1_ne_0_before test_const_shr_and_1_ne_0_after
  simp_alive_peephole
  intros
  ---BEGIN test_const_shr_and_1_ne_0
  apply test_const_shr_and_1_ne_0_thm
  ---END test_const_shr_and_1_ne_0



def test_not_const_shr_and_1_ne_0_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr %0, %arg7 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_not_const_shr_and_1_ne_0_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg7 overflow<nuw> : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_not_const_shr_and_1_ne_0_proof : test_not_const_shr_and_1_ne_0_before ⊑ test_not_const_shr_and_1_ne_0_after := by
  unfold test_not_const_shr_and_1_ne_0_before test_not_const_shr_and_1_ne_0_after
  simp_alive_peephole
  intros
  ---BEGIN test_not_const_shr_and_1_ne_0
  apply test_not_const_shr_and_1_ne_0_thm
  ---END test_not_const_shr_and_1_ne_0



def test_const_shr_exact_and_1_ne_0_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.lshr exact %0, %arg6 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "ne" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_const_shr_exact_and_1_ne_0_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg6 overflow<nuw> : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "ne" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_const_shr_exact_and_1_ne_0_proof : test_const_shr_exact_and_1_ne_0_before ⊑ test_const_shr_exact_and_1_ne_0_after := by
  unfold test_const_shr_exact_and_1_ne_0_before test_const_shr_exact_and_1_ne_0_after
  simp_alive_peephole
  intros
  ---BEGIN test_const_shr_exact_and_1_ne_0
  apply test_const_shr_exact_and_1_ne_0_thm
  ---END test_const_shr_exact_and_1_ne_0



def test_const_shr_and_1_ne_0_i1_negative_before := [llvm|
{
^0(%arg2 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.lshr %0, %arg2 : i1
  %3 = llvm.and %2, %0 : i1
  %4 = llvm.icmp "ne" %3, %1 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def test_const_shr_and_1_ne_0_i1_negative_after := [llvm|
{
^0(%arg2 : i1):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_const_shr_and_1_ne_0_i1_negative_proof : test_const_shr_and_1_ne_0_i1_negative_before ⊑ test_const_shr_and_1_ne_0_i1_negative_after := by
  unfold test_const_shr_and_1_ne_0_i1_negative_before test_const_shr_and_1_ne_0_i1_negative_after
  simp_alive_peephole
  intros
  ---BEGIN test_const_shr_and_1_ne_0_i1_negative
  apply test_const_shr_and_1_ne_0_i1_negative_thm
  ---END test_const_shr_and_1_ne_0_i1_negative


