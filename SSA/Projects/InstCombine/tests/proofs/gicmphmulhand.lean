import SSA.Projects.InstCombine.tests.proofs.gicmphmulhand_proof
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
section gicmphmulhand_statements

def mul_mask_pow2_eq0_before := [llvm|
{
^0(%arg25 : i8):
  %0 = llvm.mlir.constant(44 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mul %arg25, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "eq" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_mask_pow2_eq0_after := [llvm|
{
^0(%arg25 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg25, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_mask_pow2_eq0_proof : mul_mask_pow2_eq0_before ⊑ mul_mask_pow2_eq0_after := by
  unfold mul_mask_pow2_eq0_before mul_mask_pow2_eq0_after
  simp_alive_peephole
  intros
  ---BEGIN mul_mask_pow2_eq0
  apply mul_mask_pow2_eq0_thm
  ---END mul_mask_pow2_eq0



def mul_mask_pow2_sgt0_before := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(44 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mul %arg22, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "sgt" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_mask_pow2_sgt0_after := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg22, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_mask_pow2_sgt0_proof : mul_mask_pow2_sgt0_before ⊑ mul_mask_pow2_sgt0_after := by
  unfold mul_mask_pow2_sgt0_before mul_mask_pow2_sgt0_after
  simp_alive_peephole
  intros
  ---BEGIN mul_mask_pow2_sgt0
  apply mul_mask_pow2_sgt0_thm
  ---END mul_mask_pow2_sgt0



def mul_mask_fakepow2_ne0_before := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(44 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mul %arg21, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "ne" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_mask_fakepow2_ne0_after := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg21, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_mask_fakepow2_ne0_proof : mul_mask_fakepow2_ne0_before ⊑ mul_mask_fakepow2_ne0_after := by
  unfold mul_mask_fakepow2_ne0_before mul_mask_fakepow2_ne0_after
  simp_alive_peephole
  intros
  ---BEGIN mul_mask_fakepow2_ne0
  apply mul_mask_fakepow2_ne0_thm
  ---END mul_mask_fakepow2_ne0



def mul_mask_pow2_eq4_before := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(44 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.mul %arg20, %0 : i8
  %3 = llvm.and %2, %1 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def mul_mask_pow2_eq4_after := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg20, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_mask_pow2_eq4_proof : mul_mask_pow2_eq4_before ⊑ mul_mask_pow2_eq4_after := by
  unfold mul_mask_pow2_eq4_before mul_mask_pow2_eq4_after
  simp_alive_peephole
  intros
  ---BEGIN mul_mask_pow2_eq4
  apply mul_mask_pow2_eq4_thm
  ---END mul_mask_pow2_eq4



def mul_mask_notpow2_ne_before := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(60 : i8) : i8
  %1 = llvm.mlir.constant(12 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mul %arg19, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "ne" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_mask_notpow2_ne_after := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(12 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mul %arg19, %0 : i8
  %3 = llvm.and %2, %0 : i8
  %4 = llvm.icmp "ne" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_mask_notpow2_ne_proof : mul_mask_notpow2_ne_before ⊑ mul_mask_notpow2_ne_after := by
  unfold mul_mask_notpow2_ne_before mul_mask_notpow2_ne_after
  simp_alive_peephole
  intros
  ---BEGIN mul_mask_notpow2_ne
  apply mul_mask_notpow2_ne_thm
  ---END mul_mask_notpow2_ne



def pr40493_before := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mul %arg18, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def pr40493_after := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg18, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr40493_proof : pr40493_before ⊑ pr40493_after := by
  unfold pr40493_before pr40493_after
  simp_alive_peephole
  intros
  ---BEGIN pr40493
  apply pr40493_thm
  ---END pr40493



def pr40493_neg1_before := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(11 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mul %arg17, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def pr40493_neg1_after := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mul %arg17, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr40493_neg1_proof : pr40493_neg1_before ⊑ pr40493_neg1_after := by
  unfold pr40493_neg1_before pr40493_neg1_after
  simp_alive_peephole
  intros
  ---BEGIN pr40493_neg1
  apply pr40493_neg1_thm
  ---END pr40493_neg1



def pr40493_neg2_before := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mul %arg16, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def pr40493_neg2_after := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mul %arg16, %0 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr40493_neg2_proof : pr40493_neg2_before ⊑ pr40493_neg2_after := by
  unfold pr40493_neg2_before pr40493_neg2_after
  simp_alive_peephole
  intros
  ---BEGIN pr40493_neg2
  apply pr40493_neg2_thm
  ---END pr40493_neg2



def pr40493_neg3_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.mul %arg15, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def pr40493_neg3_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.shl %arg15, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr40493_neg3_proof : pr40493_neg3_before ⊑ pr40493_neg3_after := by
  unfold pr40493_neg3_before pr40493_neg3_after
  simp_alive_peephole
  intros
  ---BEGIN pr40493_neg3
  apply pr40493_neg3_thm
  ---END pr40493_neg3



def pr51551_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(-7 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.and %arg9, %0 : i32
  %5 = llvm.or %4, %1 : i32
  %6 = llvm.mul %5, %arg8 overflow<nsw> : i32
  %7 = llvm.and %6, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  "llvm.return"(%8) : (i1) -> ()
}
]
def pr51551_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg8, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr51551_proof : pr51551_before ⊑ pr51551_after := by
  unfold pr51551_before pr51551_after
  simp_alive_peephole
  intros
  ---BEGIN pr51551
  apply pr51551_thm
  ---END pr51551



def pr51551_2_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(-7 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg7, %0 : i32
  %4 = llvm.or %3, %1 : i32
  %5 = llvm.mul %4, %arg6 overflow<nsw> : i32
  %6 = llvm.and %5, %1 : i32
  %7 = llvm.icmp "eq" %6, %2 : i32
  "llvm.return"(%7) : (i1) -> ()
}
]
def pr51551_2_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg6, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr51551_2_proof : pr51551_2_before ⊑ pr51551_2_after := by
  unfold pr51551_2_before pr51551_2_after
  simp_alive_peephole
  intros
  ---BEGIN pr51551_2
  apply pr51551_2_thm
  ---END pr51551_2



def pr51551_neg1_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(-3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.and %arg5, %0 : i32
  %5 = llvm.or %4, %1 : i32
  %6 = llvm.mul %5, %arg4 overflow<nsw> : i32
  %7 = llvm.and %6, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  "llvm.return"(%8) : (i1) -> ()
}
]
def pr51551_neg1_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.and %arg5, %0 : i32
  %5 = llvm.or disjoint %4, %1 : i32
  %6 = llvm.mul %5, %arg4 : i32
  %7 = llvm.and %6, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr51551_neg1_proof : pr51551_neg1_before ⊑ pr51551_neg1_after := by
  unfold pr51551_neg1_before pr51551_neg1_after
  simp_alive_peephole
  intros
  ---BEGIN pr51551_neg1
  apply pr51551_neg1_thm
  ---END pr51551_neg1



def pr51551_neg2_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(-7 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg3, %0 : i32
  %4 = llvm.mul %3, %arg2 overflow<nsw> : i32
  %5 = llvm.and %4, %1 : i32
  %6 = llvm.icmp "eq" %5, %2 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
def pr51551_neg2_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.trunc %arg3 : i32 to i1
  %4 = llvm.and %arg2, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.xor %3, %2 : i1
  %7 = "llvm.select"(%6, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr51551_neg2_proof : pr51551_neg2_before ⊑ pr51551_neg2_after := by
  unfold pr51551_neg2_before pr51551_neg2_after
  simp_alive_peephole
  intros
  ---BEGIN pr51551_neg2
  apply pr51551_neg2_thm
  ---END pr51551_neg2



def pr51551_demand3bits_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(-7 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.and %arg1, %0 : i32
  %4 = llvm.or %3, %1 : i32
  %5 = llvm.mul %4, %arg0 overflow<nsw> : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def pr51551_demand3bits_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr51551_demand3bits_proof : pr51551_demand3bits_before ⊑ pr51551_demand3bits_after := by
  unfold pr51551_demand3bits_before pr51551_demand3bits_after
  simp_alive_peephole
  intros
  ---BEGIN pr51551_demand3bits
  apply pr51551_demand3bits_thm
  ---END pr51551_demand3bits


