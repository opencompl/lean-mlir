import SSA.Projects.InstCombine.tests.proofs.gexact_proof
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
section gexact_statements

def sdiv2_before := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.sdiv exact %arg39, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def sdiv2_after := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.ashr exact %arg39, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv2_proof : sdiv2_before ⊑ sdiv2_after := by
  unfold sdiv2_before sdiv2_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv2
  apply sdiv2_thm
  ---END sdiv2



def sdiv4_before := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.sdiv exact %arg36, %0 : i32
  %2 = llvm.mul %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sdiv4_after := [llvm|
{
^0(%arg36 : i32):
  "llvm.return"(%arg36) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv4_proof : sdiv4_before ⊑ sdiv4_after := by
  unfold sdiv4_before sdiv4_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv4
  apply sdiv4_thm
  ---END sdiv4



def sdiv6_before := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(-3 : i32) : i32
  %2 = llvm.sdiv exact %arg34, %0 : i32
  %3 = llvm.mul %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sdiv6_after := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sub %0, %arg34 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv6_proof : sdiv6_before ⊑ sdiv6_after := by
  unfold sdiv6_before sdiv6_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv6
  apply sdiv6_thm
  ---END sdiv6



def udiv1_before := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  %0 = llvm.udiv exact %arg32, %arg33 : i32
  %1 = llvm.mul %0, %arg33 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def udiv1_after := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  "llvm.return"(%arg32) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv1_proof : udiv1_before ⊑ udiv1_after := by
  unfold udiv1_before udiv1_after
  simp_alive_peephole
  intros
  ---BEGIN udiv1
  apply udiv1_thm
  ---END udiv1



def udiv2_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg31 : i32
  %2 = llvm.udiv exact %arg30, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def udiv2_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.lshr exact %arg30, %arg31 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv2_proof : udiv2_before ⊑ udiv2_after := by
  unfold udiv2_before udiv2_after
  simp_alive_peephole
  intros
  ---BEGIN udiv2
  apply udiv2_thm
  ---END udiv2



def ashr1_before := [llvm|
{
^0(%arg29 : i64):
  %0 = llvm.mlir.constant(8) : i64
  %1 = llvm.mlir.constant(2) : i64
  %2 = llvm.shl %arg29, %0 : i64
  %3 = llvm.ashr %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def ashr1_after := [llvm|
{
^0(%arg29 : i64):
  %0 = llvm.mlir.constant(8) : i64
  %1 = llvm.mlir.constant(2) : i64
  %2 = llvm.shl %arg29, %0 : i64
  %3 = llvm.ashr exact %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr1_proof : ashr1_before ⊑ ashr1_after := by
  unfold ashr1_before ashr1_after
  simp_alive_peephole
  intros
  ---BEGIN ashr1
  apply ashr1_thm
  ---END ashr1



def ashr_icmp1_before := [llvm|
{
^0(%arg27 : i64):
  %0 = llvm.mlir.constant(2) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.ashr exact %arg27, %0 : i64
  %3 = llvm.icmp "eq" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_icmp1_after := [llvm|
{
^0(%arg27 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "eq" %arg27, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_icmp1_proof : ashr_icmp1_before ⊑ ashr_icmp1_after := by
  unfold ashr_icmp1_before ashr_icmp1_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_icmp1
  apply ashr_icmp1_thm
  ---END ashr_icmp1



def ashr_icmp2_before := [llvm|
{
^0(%arg26 : i64):
  %0 = llvm.mlir.constant(2) : i64
  %1 = llvm.mlir.constant(4) : i64
  %2 = llvm.ashr exact %arg26, %0 : i64
  %3 = llvm.icmp "slt" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_icmp2_after := [llvm|
{
^0(%arg26 : i64):
  %0 = llvm.mlir.constant(16) : i64
  %1 = llvm.icmp "slt" %arg26, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_icmp2_proof : ashr_icmp2_before ⊑ ashr_icmp2_after := by
  unfold ashr_icmp2_before ashr_icmp2_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_icmp2
  apply ashr_icmp2_thm
  ---END ashr_icmp2



def pr9998_before := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(7297771788697658747) : i64
  %2 = llvm.shl %arg24, %0 : i32
  %3 = llvm.ashr exact %2, %0 : i32
  %4 = llvm.sext %3 : i32 to i64
  %5 = llvm.icmp "ugt" %4, %1 : i64
  "llvm.return"(%5) : (i1) -> ()
}
]
def pr9998_after := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg24, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr9998_proof : pr9998_before ⊑ pr9998_after := by
  unfold pr9998_before pr9998_after
  simp_alive_peephole
  intros
  ---BEGIN pr9998
  apply pr9998_thm
  ---END pr9998



def udiv_icmp1_before := [llvm|
{
^0(%arg22 : i64):
  %0 = llvm.mlir.constant(5) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.udiv exact %arg22, %0 : i64
  %3 = llvm.icmp "ne" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def udiv_icmp1_after := [llvm|
{
^0(%arg22 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "ne" %arg22, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_icmp1_proof : udiv_icmp1_before ⊑ udiv_icmp1_after := by
  unfold udiv_icmp1_before udiv_icmp1_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_icmp1
  apply udiv_icmp1_thm
  ---END udiv_icmp1



def udiv_icmp2_before := [llvm|
{
^0(%arg20 : i64):
  %0 = llvm.mlir.constant(5) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.udiv exact %arg20, %0 : i64
  %3 = llvm.icmp "eq" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def udiv_icmp2_after := [llvm|
{
^0(%arg20 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "eq" %arg20, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_icmp2_proof : udiv_icmp2_before ⊑ udiv_icmp2_after := by
  unfold udiv_icmp2_before udiv_icmp2_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_icmp2
  apply udiv_icmp2_thm
  ---END udiv_icmp2



def sdiv_icmp1_before := [llvm|
{
^0(%arg18 : i64):
  %0 = llvm.mlir.constant(5) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.sdiv exact %arg18, %0 : i64
  %3 = llvm.icmp "eq" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def sdiv_icmp1_after := [llvm|
{
^0(%arg18 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "eq" %arg18, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_icmp1_proof : sdiv_icmp1_before ⊑ sdiv_icmp1_after := by
  unfold sdiv_icmp1_before sdiv_icmp1_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_icmp1
  apply sdiv_icmp1_thm
  ---END sdiv_icmp1



def sdiv_icmp2_before := [llvm|
{
^0(%arg16 : i64):
  %0 = llvm.mlir.constant(5) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = llvm.sdiv exact %arg16, %0 : i64
  %3 = llvm.icmp "eq" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def sdiv_icmp2_after := [llvm|
{
^0(%arg16 : i64):
  %0 = llvm.mlir.constant(5) : i64
  %1 = llvm.icmp "eq" %arg16, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_icmp2_proof : sdiv_icmp2_before ⊑ sdiv_icmp2_after := by
  unfold sdiv_icmp2_before sdiv_icmp2_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_icmp2
  apply sdiv_icmp2_thm
  ---END sdiv_icmp2



def sdiv_icmp3_before := [llvm|
{
^0(%arg14 : i64):
  %0 = llvm.mlir.constant(5) : i64
  %1 = llvm.mlir.constant(-1) : i64
  %2 = llvm.sdiv exact %arg14, %0 : i64
  %3 = llvm.icmp "eq" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def sdiv_icmp3_after := [llvm|
{
^0(%arg14 : i64):
  %0 = llvm.mlir.constant(-5) : i64
  %1 = llvm.icmp "eq" %arg14, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_icmp3_proof : sdiv_icmp3_before ⊑ sdiv_icmp3_after := by
  unfold sdiv_icmp3_before sdiv_icmp3_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_icmp3
  apply sdiv_icmp3_thm
  ---END sdiv_icmp3



def sdiv_icmp4_before := [llvm|
{
^0(%arg12 : i64):
  %0 = llvm.mlir.constant(-5) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.sdiv exact %arg12, %0 : i64
  %3 = llvm.icmp "eq" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def sdiv_icmp4_after := [llvm|
{
^0(%arg12 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "eq" %arg12, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_icmp4_proof : sdiv_icmp4_before ⊑ sdiv_icmp4_after := by
  unfold sdiv_icmp4_before sdiv_icmp4_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_icmp4
  apply sdiv_icmp4_thm
  ---END sdiv_icmp4



def sdiv_icmp5_before := [llvm|
{
^0(%arg10 : i64):
  %0 = llvm.mlir.constant(-5) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = llvm.sdiv exact %arg10, %0 : i64
  %3 = llvm.icmp "eq" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def sdiv_icmp5_after := [llvm|
{
^0(%arg10 : i64):
  %0 = llvm.mlir.constant(-5) : i64
  %1 = llvm.icmp "eq" %arg10, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_icmp5_proof : sdiv_icmp5_before ⊑ sdiv_icmp5_after := by
  unfold sdiv_icmp5_before sdiv_icmp5_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_icmp5
  apply sdiv_icmp5_thm
  ---END sdiv_icmp5



def sdiv_icmp6_before := [llvm|
{
^0(%arg8 : i64):
  %0 = llvm.mlir.constant(-5) : i64
  %1 = llvm.mlir.constant(-1) : i64
  %2 = llvm.sdiv exact %arg8, %0 : i64
  %3 = llvm.icmp "eq" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def sdiv_icmp6_after := [llvm|
{
^0(%arg8 : i64):
  %0 = llvm.mlir.constant(5) : i64
  %1 = llvm.icmp "eq" %arg8, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_icmp6_proof : sdiv_icmp6_before ⊑ sdiv_icmp6_after := by
  unfold sdiv_icmp6_before sdiv_icmp6_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_icmp6
  apply sdiv_icmp6_thm
  ---END sdiv_icmp6



def mul_of_udiv_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(12 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.udiv exact %arg6, %0 : i8
  %3 = llvm.mul %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def mul_of_udiv_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.lshr exact %arg6, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_of_udiv_proof : mul_of_udiv_before ⊑ mul_of_udiv_after := by
  unfold mul_of_udiv_before mul_of_udiv_after
  simp_alive_peephole
  intros
  ---BEGIN mul_of_udiv
  apply mul_of_udiv_thm
  ---END mul_of_udiv



def mul_of_sdiv_before := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(12 : i8) : i8
  %1 = llvm.mlir.constant(-6 : i8) : i8
  %2 = llvm.sdiv exact %arg5, %0 : i8
  %3 = llvm.mul %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def mul_of_sdiv_after := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.ashr exact %arg5, %0 : i8
  %3 = llvm.sub %1, %2 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_of_sdiv_proof : mul_of_sdiv_before ⊑ mul_of_sdiv_after := by
  unfold mul_of_sdiv_before mul_of_sdiv_after
  simp_alive_peephole
  intros
  ---BEGIN mul_of_sdiv
  apply mul_of_sdiv_thm
  ---END mul_of_sdiv



def mul_of_udiv_fail_bad_remainder_before := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(11 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.udiv exact %arg2, %0 : i8
  %3 = llvm.mul %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def mul_of_udiv_fail_bad_remainder_after := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(11 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.udiv exact %arg2, %0 : i8
  %3 = llvm.mul %2, %1 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_of_udiv_fail_bad_remainder_proof : mul_of_udiv_fail_bad_remainder_before ⊑ mul_of_udiv_fail_bad_remainder_after := by
  unfold mul_of_udiv_fail_bad_remainder_before mul_of_udiv_fail_bad_remainder_after
  simp_alive_peephole
  intros
  ---BEGIN mul_of_udiv_fail_bad_remainder
  apply mul_of_udiv_fail_bad_remainder_thm
  ---END mul_of_udiv_fail_bad_remainder



def mul_of_sdiv_fail_ub_before := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(-6 : i8) : i8
  %2 = llvm.sdiv exact %arg1, %0 : i8
  %3 = llvm.mul %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def mul_of_sdiv_fail_ub_after := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg1 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_of_sdiv_fail_ub_proof : mul_of_sdiv_fail_ub_before ⊑ mul_of_sdiv_fail_ub_after := by
  unfold mul_of_sdiv_fail_ub_before mul_of_sdiv_fail_ub_after
  simp_alive_peephole
  intros
  ---BEGIN mul_of_sdiv_fail_ub
  apply mul_of_sdiv_fail_ub_thm
  ---END mul_of_sdiv_fail_ub


