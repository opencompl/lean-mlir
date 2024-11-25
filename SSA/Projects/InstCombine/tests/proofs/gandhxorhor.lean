import SSA.Projects.InstCombine.tests.proofs.gandhxorhor_proof
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
section gandhxorhor_statements

def and_xor_common_op_before := [llvm|
{
^0(%arg695 : i32, %arg696 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(43 : i32) : i32
  %2 = llvm.udiv %0, %arg695 : i32
  %3 = llvm.udiv %1, %arg696 : i32
  %4 = llvm.xor %2, %3 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def and_xor_common_op_after := [llvm|
{
^0(%arg695 : i32, %arg696 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(43 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.udiv %0, %arg695 : i32
  %4 = llvm.udiv %1, %arg696 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.and %3, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_common_op_proof : and_xor_common_op_before ⊑ and_xor_common_op_after := by
  unfold and_xor_common_op_before and_xor_common_op_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_common_op
  apply and_xor_common_op_thm
  ---END and_xor_common_op



def and_xor_common_op_commute1_before := [llvm|
{
^0(%arg693 : i32, %arg694 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(43 : i32) : i32
  %2 = llvm.udiv %0, %arg693 : i32
  %3 = llvm.udiv %1, %arg694 : i32
  %4 = llvm.xor %3, %2 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def and_xor_common_op_commute1_after := [llvm|
{
^0(%arg693 : i32, %arg694 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(43 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.udiv %0, %arg693 : i32
  %4 = llvm.udiv %1, %arg694 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.and %3, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_common_op_commute1_proof : and_xor_common_op_commute1_before ⊑ and_xor_common_op_commute1_after := by
  unfold and_xor_common_op_commute1_before and_xor_common_op_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_common_op_commute1
  apply and_xor_common_op_commute1_thm
  ---END and_xor_common_op_commute1



def and_xor_common_op_commute2_before := [llvm|
{
^0(%arg691 : i32, %arg692 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(43 : i32) : i32
  %2 = llvm.udiv %0, %arg691 : i32
  %3 = llvm.udiv %1, %arg692 : i32
  %4 = llvm.xor %3, %2 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def and_xor_common_op_commute2_after := [llvm|
{
^0(%arg691 : i32, %arg692 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(43 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.udiv %0, %arg691 : i32
  %4 = llvm.udiv %1, %arg692 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.and %3, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_common_op_commute2_proof : and_xor_common_op_commute2_before ⊑ and_xor_common_op_commute2_after := by
  unfold and_xor_common_op_commute2_before and_xor_common_op_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_common_op_commute2
  apply and_xor_common_op_commute2_thm
  ---END and_xor_common_op_commute2



def and_xor_not_common_op_before := [llvm|
{
^0(%arg686 : i32, %arg687 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg687, %0 : i32
  %2 = llvm.xor %arg686, %1 : i32
  %3 = llvm.and %2, %arg686 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_xor_not_common_op_after := [llvm|
{
^0(%arg686 : i32, %arg687 : i32):
  %0 = llvm.and %arg686, %arg687 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_not_common_op_proof : and_xor_not_common_op_before ⊑ and_xor_not_common_op_after := by
  unfold and_xor_not_common_op_before and_xor_not_common_op_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_not_common_op
  apply and_xor_not_common_op_thm
  ---END and_xor_not_common_op



def and_not_xor_common_op_before := [llvm|
{
^0(%arg681 : i32, %arg682 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg682, %arg681 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg681 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_not_xor_common_op_after := [llvm|
{
^0(%arg681 : i32, %arg682 : i32):
  %0 = llvm.and %arg681, %arg682 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_xor_common_op_proof : and_not_xor_common_op_before ⊑ and_not_xor_common_op_after := by
  unfold and_not_xor_common_op_before and_not_xor_common_op_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_xor_common_op
  apply and_not_xor_common_op_thm
  ---END and_not_xor_common_op



def or_before := [llvm|
{
^0(%arg678 : i64, %arg679 : i64):
  %0 = llvm.and %arg679, %arg678 : i64
  %1 = llvm.xor %arg679, %arg678 : i64
  %2 = llvm.add %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def or_after := [llvm|
{
^0(%arg678 : i64, %arg679 : i64):
  %0 = llvm.or %arg679, %arg678 : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_proof : or_before ⊑ or_after := by
  unfold or_before or_after
  simp_alive_peephole
  intros
  ---BEGIN or
  apply or_thm
  ---END or



def or2_before := [llvm|
{
^0(%arg676 : i64, %arg677 : i64):
  %0 = llvm.and %arg677, %arg676 : i64
  %1 = llvm.xor %arg677, %arg676 : i64
  %2 = llvm.or %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def or2_after := [llvm|
{
^0(%arg676 : i64, %arg677 : i64):
  %0 = llvm.or %arg677, %arg676 : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or2_proof : or2_before ⊑ or2_after := by
  unfold or2_before or2_after
  simp_alive_peephole
  intros
  ---BEGIN or2
  apply or2_thm
  ---END or2



def and_xor_or1_before := [llvm|
{
^0(%arg673 : i64, %arg674 : i64, %arg675 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg673 : i64
  %2 = llvm.udiv %0, %arg674 : i64
  %3 = llvm.udiv %0, %arg675 : i64
  %4 = llvm.and %1, %2 : i64
  %5 = llvm.xor %4, %3 : i64
  %6 = llvm.or %5, %2 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def and_xor_or1_after := [llvm|
{
^0(%arg673 : i64, %arg674 : i64, %arg675 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg674 : i64
  %2 = llvm.udiv %0, %arg675 : i64
  %3 = llvm.or %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_or1_proof : and_xor_or1_before ⊑ and_xor_or1_after := by
  unfold and_xor_or1_before and_xor_or1_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_or1
  apply and_xor_or1_thm
  ---END and_xor_or1



def and_xor_or2_before := [llvm|
{
^0(%arg670 : i64, %arg671 : i64, %arg672 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg670 : i64
  %2 = llvm.udiv %0, %arg671 : i64
  %3 = llvm.udiv %0, %arg672 : i64
  %4 = llvm.and %2, %1 : i64
  %5 = llvm.xor %4, %3 : i64
  %6 = llvm.or %5, %2 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def and_xor_or2_after := [llvm|
{
^0(%arg670 : i64, %arg671 : i64, %arg672 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg671 : i64
  %2 = llvm.udiv %0, %arg672 : i64
  %3 = llvm.or %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_or2_proof : and_xor_or2_before ⊑ and_xor_or2_after := by
  unfold and_xor_or2_before and_xor_or2_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_or2
  apply and_xor_or2_thm
  ---END and_xor_or2



def and_xor_or3_before := [llvm|
{
^0(%arg667 : i64, %arg668 : i64, %arg669 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg667 : i64
  %2 = llvm.udiv %0, %arg668 : i64
  %3 = llvm.udiv %0, %arg669 : i64
  %4 = llvm.and %1, %2 : i64
  %5 = llvm.xor %3, %4 : i64
  %6 = llvm.or %5, %2 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def and_xor_or3_after := [llvm|
{
^0(%arg667 : i64, %arg668 : i64, %arg669 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg668 : i64
  %2 = llvm.udiv %0, %arg669 : i64
  %3 = llvm.or %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_or3_proof : and_xor_or3_before ⊑ and_xor_or3_after := by
  unfold and_xor_or3_before and_xor_or3_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_or3
  apply and_xor_or3_thm
  ---END and_xor_or3



def and_xor_or4_before := [llvm|
{
^0(%arg664 : i64, %arg665 : i64, %arg666 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg664 : i64
  %2 = llvm.udiv %0, %arg665 : i64
  %3 = llvm.udiv %0, %arg666 : i64
  %4 = llvm.and %2, %1 : i64
  %5 = llvm.xor %3, %4 : i64
  %6 = llvm.or %5, %2 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def and_xor_or4_after := [llvm|
{
^0(%arg664 : i64, %arg665 : i64, %arg666 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg665 : i64
  %2 = llvm.udiv %0, %arg666 : i64
  %3 = llvm.or %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_or4_proof : and_xor_or4_before ⊑ and_xor_or4_after := by
  unfold and_xor_or4_before and_xor_or4_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_or4
  apply and_xor_or4_thm
  ---END and_xor_or4



def and_xor_or5_before := [llvm|
{
^0(%arg661 : i64, %arg662 : i64, %arg663 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg661 : i64
  %2 = llvm.udiv %0, %arg662 : i64
  %3 = llvm.udiv %0, %arg663 : i64
  %4 = llvm.and %1, %2 : i64
  %5 = llvm.xor %4, %3 : i64
  %6 = llvm.or %2, %5 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def and_xor_or5_after := [llvm|
{
^0(%arg661 : i64, %arg662 : i64, %arg663 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg662 : i64
  %2 = llvm.udiv %0, %arg663 : i64
  %3 = llvm.or %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_or5_proof : and_xor_or5_before ⊑ and_xor_or5_after := by
  unfold and_xor_or5_before and_xor_or5_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_or5
  apply and_xor_or5_thm
  ---END and_xor_or5



def and_xor_or6_before := [llvm|
{
^0(%arg658 : i64, %arg659 : i64, %arg660 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg658 : i64
  %2 = llvm.udiv %0, %arg659 : i64
  %3 = llvm.udiv %0, %arg660 : i64
  %4 = llvm.and %2, %1 : i64
  %5 = llvm.xor %4, %3 : i64
  %6 = llvm.or %2, %5 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def and_xor_or6_after := [llvm|
{
^0(%arg658 : i64, %arg659 : i64, %arg660 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg659 : i64
  %2 = llvm.udiv %0, %arg660 : i64
  %3 = llvm.or %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_or6_proof : and_xor_or6_before ⊑ and_xor_or6_after := by
  unfold and_xor_or6_before and_xor_or6_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_or6
  apply and_xor_or6_thm
  ---END and_xor_or6



def and_xor_or7_before := [llvm|
{
^0(%arg655 : i64, %arg656 : i64, %arg657 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg655 : i64
  %2 = llvm.udiv %0, %arg656 : i64
  %3 = llvm.udiv %0, %arg657 : i64
  %4 = llvm.and %1, %2 : i64
  %5 = llvm.xor %3, %4 : i64
  %6 = llvm.or %2, %5 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def and_xor_or7_after := [llvm|
{
^0(%arg655 : i64, %arg656 : i64, %arg657 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg656 : i64
  %2 = llvm.udiv %0, %arg657 : i64
  %3 = llvm.or %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_or7_proof : and_xor_or7_before ⊑ and_xor_or7_after := by
  unfold and_xor_or7_before and_xor_or7_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_or7
  apply and_xor_or7_thm
  ---END and_xor_or7



def and_xor_or8_before := [llvm|
{
^0(%arg652 : i64, %arg653 : i64, %arg654 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg652 : i64
  %2 = llvm.udiv %0, %arg653 : i64
  %3 = llvm.udiv %0, %arg654 : i64
  %4 = llvm.and %2, %1 : i64
  %5 = llvm.xor %3, %4 : i64
  %6 = llvm.or %2, %5 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def and_xor_or8_after := [llvm|
{
^0(%arg652 : i64, %arg653 : i64, %arg654 : i64):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.udiv %0, %arg653 : i64
  %2 = llvm.udiv %0, %arg654 : i64
  %3 = llvm.or %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_xor_or8_proof : and_xor_or8_before ⊑ and_xor_or8_after := by
  unfold and_xor_or8_before and_xor_or8_after
  simp_alive_peephole
  intros
  ---BEGIN and_xor_or8
  apply and_xor_or8_thm
  ---END and_xor_or8



def and_shl_before := [llvm|
{
^0(%arg644 : i8, %arg645 : i8, %arg646 : i8, %arg647 : i8):
  %0 = llvm.shl %arg644, %arg647 : i8
  %1 = llvm.shl %arg645, %arg647 : i8
  %2 = llvm.and %0, %arg646 : i8
  %3 = llvm.and %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def and_shl_after := [llvm|
{
^0(%arg644 : i8, %arg645 : i8, %arg646 : i8, %arg647 : i8):
  %0 = llvm.and %arg644, %arg645 : i8
  %1 = llvm.shl %0, %arg647 : i8
  %2 = llvm.and %1, %arg646 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_shl_proof : and_shl_before ⊑ and_shl_after := by
  unfold and_shl_before and_shl_after
  simp_alive_peephole
  intros
  ---BEGIN and_shl
  apply and_shl_thm
  ---END and_shl



def or_shl_before := [llvm|
{
^0(%arg640 : i8, %arg641 : i8, %arg642 : i8, %arg643 : i8):
  %0 = llvm.shl %arg640, %arg643 : i8
  %1 = llvm.shl %arg641, %arg643 : i8
  %2 = llvm.or %0, %arg642 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_shl_after := [llvm|
{
^0(%arg640 : i8, %arg641 : i8, %arg642 : i8, %arg643 : i8):
  %0 = llvm.or %arg640, %arg641 : i8
  %1 = llvm.shl %0, %arg643 : i8
  %2 = llvm.or %1, %arg642 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_shl_proof : or_shl_before ⊑ or_shl_after := by
  unfold or_shl_before or_shl_after
  simp_alive_peephole
  intros
  ---BEGIN or_shl
  apply or_shl_thm
  ---END or_shl



def or_lshr_before := [llvm|
{
^0(%arg628 : i8, %arg629 : i8, %arg630 : i8, %arg631 : i8):
  %0 = llvm.lshr %arg628, %arg631 : i8
  %1 = llvm.lshr %arg629, %arg631 : i8
  %2 = llvm.or %0, %arg630 : i8
  %3 = llvm.or %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_lshr_after := [llvm|
{
^0(%arg628 : i8, %arg629 : i8, %arg630 : i8, %arg631 : i8):
  %0 = llvm.or %arg628, %arg629 : i8
  %1 = llvm.lshr %0, %arg631 : i8
  %2 = llvm.or %1, %arg630 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_lshr_proof : or_lshr_before ⊑ or_lshr_after := by
  unfold or_lshr_before or_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN or_lshr
  apply or_lshr_thm
  ---END or_lshr



def xor_lshr_before := [llvm|
{
^0(%arg624 : i8, %arg625 : i8, %arg626 : i8, %arg627 : i8):
  %0 = llvm.lshr %arg624, %arg627 : i8
  %1 = llvm.lshr %arg625, %arg627 : i8
  %2 = llvm.xor %0, %arg626 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def xor_lshr_after := [llvm|
{
^0(%arg624 : i8, %arg625 : i8, %arg626 : i8, %arg627 : i8):
  %0 = llvm.xor %arg624, %arg625 : i8
  %1 = llvm.lshr %0, %arg627 : i8
  %2 = llvm.xor %1, %arg626 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_lshr_proof : xor_lshr_before ⊑ xor_lshr_after := by
  unfold xor_lshr_before xor_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN xor_lshr
  apply xor_lshr_thm
  ---END xor_lshr



def xor_lshr_multiuse_before := [llvm|
{
^0(%arg596 : i8, %arg597 : i8, %arg598 : i8, %arg599 : i8):
  %0 = llvm.lshr %arg596, %arg599 : i8
  %1 = llvm.lshr %arg597, %arg599 : i8
  %2 = llvm.xor %0, %arg598 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.sdiv %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_lshr_multiuse_after := [llvm|
{
^0(%arg596 : i8, %arg597 : i8, %arg598 : i8, %arg599 : i8):
  %0 = llvm.lshr %arg596, %arg599 : i8
  %1 = llvm.xor %0, %arg598 : i8
  %2 = llvm.xor %arg596, %arg597 : i8
  %3 = llvm.lshr %2, %arg599 : i8
  %4 = llvm.xor %3, %arg598 : i8
  %5 = llvm.sdiv %1, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_lshr_multiuse_proof : xor_lshr_multiuse_before ⊑ xor_lshr_multiuse_after := by
  unfold xor_lshr_multiuse_before xor_lshr_multiuse_after
  simp_alive_peephole
  intros
  ---BEGIN xor_lshr_multiuse
  apply xor_lshr_multiuse_thm
  ---END xor_lshr_multiuse



def not_and_and_not_before := [llvm|
{
^0(%arg567 : i32, %arg568 : i32, %arg569 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg567 : i32
  %3 = llvm.xor %arg568, %1 : i32
  %4 = llvm.xor %arg569, %1 : i32
  %5 = llvm.and %2, %3 : i32
  %6 = llvm.and %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_not_after := [llvm|
{
^0(%arg567 : i32, %arg568 : i32, %arg569 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg567 : i32
  %3 = llvm.or %arg568, %arg569 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_not_proof : not_and_and_not_before ⊑ not_and_and_not_after := by
  unfold not_and_and_not_before not_and_and_not_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_not
  apply not_and_and_not_thm
  ---END not_and_and_not



def not_and_and_not_commute1_before := [llvm|
{
^0(%arg561 : i32, %arg562 : i32, %arg563 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg562, %0 : i32
  %2 = llvm.xor %arg563, %0 : i32
  %3 = llvm.and %1, %arg561 : i32
  %4 = llvm.and %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def not_and_and_not_commute1_after := [llvm|
{
^0(%arg561 : i32, %arg562 : i32, %arg563 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg562, %arg563 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg561, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_not_commute1_proof : not_and_and_not_commute1_before ⊑ not_and_and_not_commute1_after := by
  unfold not_and_and_not_commute1_before not_and_and_not_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_not_commute1
  apply not_and_and_not_commute1_thm
  ---END not_and_and_not_commute1



def not_or_or_not_before := [llvm|
{
^0(%arg552 : i32, %arg553 : i32, %arg554 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg552 : i32
  %3 = llvm.xor %arg553, %1 : i32
  %4 = llvm.xor %arg554, %1 : i32
  %5 = llvm.or %2, %3 : i32
  %6 = llvm.or %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_not_after := [llvm|
{
^0(%arg552 : i32, %arg553 : i32, %arg554 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg552 : i32
  %3 = llvm.and %arg553, %arg554 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_not_proof : not_or_or_not_before ⊑ not_or_or_not_after := by
  unfold not_or_or_not_before not_or_or_not_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_not
  apply not_or_or_not_thm
  ---END not_or_or_not



def not_or_or_not_commute1_before := [llvm|
{
^0(%arg546 : i32, %arg547 : i32, %arg548 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg547, %0 : i32
  %2 = llvm.xor %arg548, %0 : i32
  %3 = llvm.or %1, %arg546 : i32
  %4 = llvm.or %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def not_or_or_not_commute1_after := [llvm|
{
^0(%arg546 : i32, %arg547 : i32, %arg548 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg547, %arg548 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg546, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_not_commute1_proof : not_or_or_not_commute1_before ⊑ not_or_or_not_commute1_after := by
  unfold not_or_or_not_commute1_before not_or_or_not_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_not_commute1
  apply not_or_or_not_commute1_thm
  ---END not_or_or_not_commute1



def or_not_and_before := [llvm|
{
^0(%arg537 : i32, %arg538 : i32, %arg539 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg537, %arg538 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg539 : i32
  %4 = llvm.or %arg537, %arg539 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg538 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_after := [llvm|
{
^0(%arg537 : i32, %arg538 : i32, %arg539 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg538, %arg539 : i32
  %2 = llvm.xor %arg537, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_proof : or_not_and_before ⊑ or_not_and_after := by
  unfold or_not_and_before or_not_and_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and
  apply or_not_and_thm
  ---END or_not_and



def or_not_and_commute1_before := [llvm|
{
^0(%arg534 : i32, %arg535 : i32, %arg536 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg535 : i32
  %3 = llvm.or %arg534, %2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %4, %arg536 : i32
  %6 = llvm.or %arg534, %arg536 : i32
  %7 = llvm.xor %6, %1 : i32
  %8 = llvm.and %2, %7 : i32
  %9 = llvm.or %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def or_not_and_commute1_after := [llvm|
{
^0(%arg534 : i32, %arg535 : i32, %arg536 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg535 : i32
  %3 = llvm.xor %2, %arg536 : i32
  %4 = llvm.xor %arg534, %1 : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_commute1_proof : or_not_and_commute1_before ⊑ or_not_and_commute1_after := by
  unfold or_not_and_commute1_before or_not_and_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_commute1
  apply or_not_and_commute1_thm
  ---END or_not_and_commute1



def or_not_and_commute2_before := [llvm|
{
^0(%arg531 : i32, %arg532 : i32, %arg533 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg532 : i32
  %3 = llvm.or %arg531, %2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %4, %arg533 : i32
  %6 = llvm.or %arg531, %arg533 : i32
  %7 = llvm.xor %6, %1 : i32
  %8 = llvm.and %2, %7 : i32
  %9 = llvm.or %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def or_not_and_commute2_after := [llvm|
{
^0(%arg531 : i32, %arg532 : i32, %arg533 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg532 : i32
  %3 = llvm.xor %arg533, %2 : i32
  %4 = llvm.xor %arg531, %1 : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_commute2_proof : or_not_and_commute2_before ⊑ or_not_and_commute2_after := by
  unfold or_not_and_commute2_before or_not_and_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_commute2
  apply or_not_and_commute2_thm
  ---END or_not_and_commute2



def or_not_and_commute3_before := [llvm|
{
^0(%arg528 : i32, %arg529 : i32, %arg530 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg529, %arg528 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg530 : i32
  %4 = llvm.or %arg530, %arg528 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg529 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_commute3_after := [llvm|
{
^0(%arg528 : i32, %arg529 : i32, %arg530 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg529, %arg530 : i32
  %2 = llvm.xor %arg528, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_commute3_proof : or_not_and_commute3_before ⊑ or_not_and_commute3_after := by
  unfold or_not_and_commute3_before or_not_and_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_commute3
  apply or_not_and_commute3_thm
  ---END or_not_and_commute3



def or_not_and_commute4_before := [llvm|
{
^0(%arg525 : i32, %arg526 : i32, %arg527 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg527 : i32
  %3 = llvm.or %arg525, %arg526 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  %6 = llvm.or %arg525, %2 : i32
  %7 = llvm.xor %6, %1 : i32
  %8 = llvm.and %7, %arg526 : i32
  %9 = llvm.or %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def or_not_and_commute4_after := [llvm|
{
^0(%arg525 : i32, %arg526 : i32, %arg527 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg527 : i32
  %3 = llvm.xor %arg526, %2 : i32
  %4 = llvm.xor %arg525, %1 : i32
  %5 = llvm.and %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_commute4_proof : or_not_and_commute4_before ⊑ or_not_and_commute4_after := by
  unfold or_not_and_commute4_before or_not_and_commute4_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_commute4
  apply or_not_and_commute4_thm
  ---END or_not_and_commute4



def or_not_and_commute5_before := [llvm|
{
^0(%arg522 : i32, %arg523 : i32, %arg524 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg522 : i32
  %3 = llvm.sdiv %0, %arg524 : i32
  %4 = llvm.or %2, %arg523 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.and %3, %5 : i32
  %7 = llvm.or %2, %3 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.and %8, %arg523 : i32
  %10 = llvm.or %6, %9 : i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def or_not_and_commute5_after := [llvm|
{
^0(%arg522 : i32, %arg523 : i32, %arg524 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg522 : i32
  %3 = llvm.sdiv %0, %arg524 : i32
  %4 = llvm.xor %arg523, %3 : i32
  %5 = llvm.xor %2, %1 : i32
  %6 = llvm.and %4, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_commute5_proof : or_not_and_commute5_before ⊑ or_not_and_commute5_after := by
  unfold or_not_and_commute5_before or_not_and_commute5_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_commute5
  apply or_not_and_commute5_thm
  ---END or_not_and_commute5



def or_not_and_commute6_before := [llvm|
{
^0(%arg519 : i32, %arg520 : i32, %arg521 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg519, %arg520 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg521 : i32
  %4 = llvm.or %arg521, %arg519 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg520 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_commute6_after := [llvm|
{
^0(%arg519 : i32, %arg520 : i32, %arg521 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg520, %arg521 : i32
  %2 = llvm.xor %arg519, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_commute6_proof : or_not_and_commute6_before ⊑ or_not_and_commute6_after := by
  unfold or_not_and_commute6_before or_not_and_commute6_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_commute6
  apply or_not_and_commute6_thm
  ---END or_not_and_commute6



def or_not_and_commute7_before := [llvm|
{
^0(%arg516 : i32, %arg517 : i32, %arg518 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg517, %arg516 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg518 : i32
  %4 = llvm.or %arg516, %arg518 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg517 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_commute7_after := [llvm|
{
^0(%arg516 : i32, %arg517 : i32, %arg518 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg517, %arg518 : i32
  %2 = llvm.xor %arg516, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_commute7_proof : or_not_and_commute7_before ⊑ or_not_and_commute7_after := by
  unfold or_not_and_commute7_before or_not_and_commute7_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_commute7
  apply or_not_and_commute7_thm
  ---END or_not_and_commute7



def or_not_and_commute8_before := [llvm|
{
^0(%arg513 : i32, %arg514 : i32, %arg515 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg513 : i32
  %3 = llvm.sdiv %0, %arg514 : i32
  %4 = llvm.or %2, %3 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.and %5, %arg515 : i32
  %7 = llvm.or %arg515, %2 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.and %3, %8 : i32
  %10 = llvm.or %6, %9 : i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def or_not_and_commute8_after := [llvm|
{
^0(%arg513 : i32, %arg514 : i32, %arg515 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg513 : i32
  %3 = llvm.sdiv %0, %arg514 : i32
  %4 = llvm.xor %3, %arg515 : i32
  %5 = llvm.xor %2, %1 : i32
  %6 = llvm.and %4, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_commute8_proof : or_not_and_commute8_before ⊑ or_not_and_commute8_after := by
  unfold or_not_and_commute8_before or_not_and_commute8_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_commute8
  apply or_not_and_commute8_thm
  ---END or_not_and_commute8



def or_not_and_commute9_before := [llvm|
{
^0(%arg510 : i32, %arg511 : i32, %arg512 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg510 : i32
  %3 = llvm.sdiv %0, %arg511 : i32
  %4 = llvm.sdiv %0, %arg512 : i32
  %5 = llvm.or %2, %3 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.and %6, %4 : i32
  %8 = llvm.or %2, %4 : i32
  %9 = llvm.xor %8, %1 : i32
  %10 = llvm.and %3, %9 : i32
  %11 = llvm.or %7, %10 : i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def or_not_and_commute9_after := [llvm|
{
^0(%arg510 : i32, %arg511 : i32, %arg512 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg510 : i32
  %3 = llvm.sdiv %0, %arg511 : i32
  %4 = llvm.sdiv %0, %arg512 : i32
  %5 = llvm.xor %3, %4 : i32
  %6 = llvm.xor %2, %1 : i32
  %7 = llvm.and %5, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_commute9_proof : or_not_and_commute9_before ⊑ or_not_and_commute9_after := by
  unfold or_not_and_commute9_before or_not_and_commute9_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_commute9
  apply or_not_and_commute9_thm
  ---END or_not_and_commute9



def or_not_and_wrong_c_before := [llvm|
{
^0(%arg488 : i32, %arg489 : i32, %arg490 : i32, %arg491 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg488, %arg489 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg490 : i32
  %4 = llvm.or %arg488, %arg491 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg489 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_wrong_c_after := [llvm|
{
^0(%arg488 : i32, %arg489 : i32, %arg490 : i32, %arg491 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg488, %arg489 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg490, %2 : i32
  %4 = llvm.or %arg488, %arg491 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %arg489, %5 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_wrong_c_proof : or_not_and_wrong_c_before ⊑ or_not_and_wrong_c_after := by
  unfold or_not_and_wrong_c_before or_not_and_wrong_c_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_wrong_c
  apply or_not_and_wrong_c_thm
  ---END or_not_and_wrong_c



def or_not_and_wrong_b_before := [llvm|
{
^0(%arg484 : i32, %arg485 : i32, %arg486 : i32, %arg487 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg484, %arg485 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg486 : i32
  %4 = llvm.or %arg484, %arg486 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg487 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_wrong_b_after := [llvm|
{
^0(%arg484 : i32, %arg485 : i32, %arg486 : i32, %arg487 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg484, %arg485 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg486, %2 : i32
  %4 = llvm.or %arg484, %arg486 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %arg487, %5 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_wrong_b_proof : or_not_and_wrong_b_before ⊑ or_not_and_wrong_b_after := by
  unfold or_not_and_wrong_b_before or_not_and_wrong_b_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_wrong_b
  apply or_not_and_wrong_b_thm
  ---END or_not_and_wrong_b



def and_not_or_before := [llvm|
{
^0(%arg481 : i32, %arg482 : i32, %arg483 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg481, %arg482 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg483 : i32
  %4 = llvm.and %arg481, %arg483 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg482 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_after := [llvm|
{
^0(%arg481 : i32, %arg482 : i32, %arg483 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg482, %arg483 : i32
  %2 = llvm.and %1, %arg481 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_proof : and_not_or_before ⊑ and_not_or_after := by
  unfold and_not_or_before and_not_or_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or
  apply and_not_or_thm
  ---END and_not_or



def and_not_or_commute1_before := [llvm|
{
^0(%arg478 : i32, %arg479 : i32, %arg480 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg479 : i32
  %3 = llvm.and %arg478, %2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %4, %arg480 : i32
  %6 = llvm.and %arg478, %arg480 : i32
  %7 = llvm.xor %6, %1 : i32
  %8 = llvm.or %2, %7 : i32
  %9 = llvm.and %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def and_not_or_commute1_after := [llvm|
{
^0(%arg478 : i32, %arg479 : i32, %arg480 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg479 : i32
  %3 = llvm.xor %2, %arg480 : i32
  %4 = llvm.and %3, %arg478 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_commute1_proof : and_not_or_commute1_before ⊑ and_not_or_commute1_after := by
  unfold and_not_or_commute1_before and_not_or_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_commute1
  apply and_not_or_commute1_thm
  ---END and_not_or_commute1



def and_not_or_commute2_before := [llvm|
{
^0(%arg475 : i32, %arg476 : i32, %arg477 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg476 : i32
  %3 = llvm.and %arg475, %2 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %4, %arg477 : i32
  %6 = llvm.and %arg475, %arg477 : i32
  %7 = llvm.xor %6, %1 : i32
  %8 = llvm.or %2, %7 : i32
  %9 = llvm.and %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def and_not_or_commute2_after := [llvm|
{
^0(%arg475 : i32, %arg476 : i32, %arg477 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg476 : i32
  %3 = llvm.xor %arg477, %2 : i32
  %4 = llvm.and %3, %arg475 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_commute2_proof : and_not_or_commute2_before ⊑ and_not_or_commute2_after := by
  unfold and_not_or_commute2_before and_not_or_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_commute2
  apply and_not_or_commute2_thm
  ---END and_not_or_commute2



def and_not_or_commute3_before := [llvm|
{
^0(%arg472 : i32, %arg473 : i32, %arg474 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg473, %arg472 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg474 : i32
  %4 = llvm.and %arg474, %arg472 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg473 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_commute3_after := [llvm|
{
^0(%arg472 : i32, %arg473 : i32, %arg474 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg473, %arg474 : i32
  %2 = llvm.and %1, %arg472 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_commute3_proof : and_not_or_commute3_before ⊑ and_not_or_commute3_after := by
  unfold and_not_or_commute3_before and_not_or_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_commute3
  apply and_not_or_commute3_thm
  ---END and_not_or_commute3



def and_not_or_commute4_before := [llvm|
{
^0(%arg469 : i32, %arg470 : i32, %arg471 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg471 : i32
  %3 = llvm.and %arg469, %arg470 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.and %arg469, %2 : i32
  %7 = llvm.xor %6, %1 : i32
  %8 = llvm.or %7, %arg470 : i32
  %9 = llvm.and %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def and_not_or_commute4_after := [llvm|
{
^0(%arg469 : i32, %arg470 : i32, %arg471 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg471 : i32
  %3 = llvm.xor %arg470, %2 : i32
  %4 = llvm.and %3, %arg469 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_commute4_proof : and_not_or_commute4_before ⊑ and_not_or_commute4_after := by
  unfold and_not_or_commute4_before and_not_or_commute4_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_commute4
  apply and_not_or_commute4_thm
  ---END and_not_or_commute4



def and_not_or_commute5_before := [llvm|
{
^0(%arg466 : i32, %arg467 : i32, %arg468 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg466 : i32
  %3 = llvm.sdiv %0, %arg468 : i32
  %4 = llvm.and %2, %arg467 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.or %3, %5 : i32
  %7 = llvm.and %2, %3 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.or %8, %arg467 : i32
  %10 = llvm.and %6, %9 : i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def and_not_or_commute5_after := [llvm|
{
^0(%arg466 : i32, %arg467 : i32, %arg468 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg466 : i32
  %3 = llvm.sdiv %0, %arg468 : i32
  %4 = llvm.xor %arg467, %3 : i32
  %5 = llvm.and %4, %2 : i32
  %6 = llvm.xor %5, %1 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_commute5_proof : and_not_or_commute5_before ⊑ and_not_or_commute5_after := by
  unfold and_not_or_commute5_before and_not_or_commute5_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_commute5
  apply and_not_or_commute5_thm
  ---END and_not_or_commute5



def and_not_or_commute6_before := [llvm|
{
^0(%arg463 : i32, %arg464 : i32, %arg465 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg463, %arg464 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg465 : i32
  %4 = llvm.and %arg465, %arg463 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg464 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_commute6_after := [llvm|
{
^0(%arg463 : i32, %arg464 : i32, %arg465 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg464, %arg465 : i32
  %2 = llvm.and %1, %arg463 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_commute6_proof : and_not_or_commute6_before ⊑ and_not_or_commute6_after := by
  unfold and_not_or_commute6_before and_not_or_commute6_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_commute6
  apply and_not_or_commute6_thm
  ---END and_not_or_commute6



def and_not_or_commute7_before := [llvm|
{
^0(%arg460 : i32, %arg461 : i32, %arg462 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg461, %arg460 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg462 : i32
  %4 = llvm.and %arg460, %arg462 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg461 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_commute7_after := [llvm|
{
^0(%arg460 : i32, %arg461 : i32, %arg462 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg461, %arg462 : i32
  %2 = llvm.and %1, %arg460 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_commute7_proof : and_not_or_commute7_before ⊑ and_not_or_commute7_after := by
  unfold and_not_or_commute7_before and_not_or_commute7_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_commute7
  apply and_not_or_commute7_thm
  ---END and_not_or_commute7



def and_not_or_commute8_before := [llvm|
{
^0(%arg457 : i32, %arg458 : i32, %arg459 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg457 : i32
  %3 = llvm.sdiv %0, %arg458 : i32
  %4 = llvm.and %2, %3 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.or %5, %arg459 : i32
  %7 = llvm.and %arg459, %2 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.or %3, %8 : i32
  %10 = llvm.and %6, %9 : i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def and_not_or_commute8_after := [llvm|
{
^0(%arg457 : i32, %arg458 : i32, %arg459 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg457 : i32
  %3 = llvm.sdiv %0, %arg458 : i32
  %4 = llvm.xor %3, %arg459 : i32
  %5 = llvm.and %4, %2 : i32
  %6 = llvm.xor %5, %1 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_commute8_proof : and_not_or_commute8_before ⊑ and_not_or_commute8_after := by
  unfold and_not_or_commute8_before and_not_or_commute8_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_commute8
  apply and_not_or_commute8_thm
  ---END and_not_or_commute8



def and_not_or_commute9_before := [llvm|
{
^0(%arg454 : i32, %arg455 : i32, %arg456 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg454 : i32
  %3 = llvm.sdiv %0, %arg455 : i32
  %4 = llvm.sdiv %0, %arg456 : i32
  %5 = llvm.and %2, %3 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %6, %4 : i32
  %8 = llvm.and %2, %4 : i32
  %9 = llvm.xor %8, %1 : i32
  %10 = llvm.or %3, %9 : i32
  %11 = llvm.and %7, %10 : i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def and_not_or_commute9_after := [llvm|
{
^0(%arg454 : i32, %arg455 : i32, %arg456 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg454 : i32
  %3 = llvm.sdiv %0, %arg455 : i32
  %4 = llvm.sdiv %0, %arg456 : i32
  %5 = llvm.xor %3, %4 : i32
  %6 = llvm.and %5, %2 : i32
  %7 = llvm.xor %6, %1 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_commute9_proof : and_not_or_commute9_before ⊑ and_not_or_commute9_after := by
  unfold and_not_or_commute9_before and_not_or_commute9_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_commute9
  apply and_not_or_commute9_thm
  ---END and_not_or_commute9



def and_not_or_wrong_c_before := [llvm|
{
^0(%arg432 : i32, %arg433 : i32, %arg434 : i32, %arg435 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg432, %arg433 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg434 : i32
  %4 = llvm.and %arg432, %arg435 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg433 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_wrong_c_after := [llvm|
{
^0(%arg432 : i32, %arg433 : i32, %arg434 : i32, %arg435 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg432, %arg433 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg434, %2 : i32
  %4 = llvm.and %arg432, %arg435 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %arg433, %5 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_wrong_c_proof : and_not_or_wrong_c_before ⊑ and_not_or_wrong_c_after := by
  unfold and_not_or_wrong_c_before and_not_or_wrong_c_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_wrong_c
  apply and_not_or_wrong_c_thm
  ---END and_not_or_wrong_c



def and_not_or_wrong_b_before := [llvm|
{
^0(%arg428 : i32, %arg429 : i32, %arg430 : i32, %arg431 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg428, %arg429 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg430 : i32
  %4 = llvm.and %arg428, %arg430 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg431 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_wrong_b_after := [llvm|
{
^0(%arg428 : i32, %arg429 : i32, %arg430 : i32, %arg431 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg428, %arg429 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg430, %2 : i32
  %4 = llvm.and %arg428, %arg430 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %arg431, %5 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_wrong_b_proof : and_not_or_wrong_b_before ⊑ and_not_or_wrong_b_after := by
  unfold and_not_or_wrong_b_before and_not_or_wrong_b_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_wrong_b
  apply and_not_or_wrong_b_thm
  ---END and_not_or_wrong_b



def or_and_not_not_before := [llvm|
{
^0(%arg425 : i32, %arg426 : i32, %arg427 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg426, %arg425 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg425, %arg427 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg426 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_after := [llvm|
{
^0(%arg425 : i32, %arg426 : i32, %arg427 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg427, %arg426 : i32
  %2 = llvm.or %1, %arg425 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_not_proof : or_and_not_not_before ⊑ or_and_not_not_after := by
  unfold or_and_not_not_before or_and_not_not_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_not
  apply or_and_not_not_thm
  ---END or_and_not_not



def or_and_not_not_commute1_before := [llvm|
{
^0(%arg422 : i32, %arg423 : i32, %arg424 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg423 : i32
  %3 = llvm.or %2, %arg422 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %arg422, %arg424 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.and %2, %6 : i32
  %8 = llvm.or %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def or_and_not_not_commute1_after := [llvm|
{
^0(%arg422 : i32, %arg423 : i32, %arg424 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg423 : i32
  %3 = llvm.and %arg424, %2 : i32
  %4 = llvm.or %3, %arg422 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_not_commute1_proof : or_and_not_not_commute1_before ⊑ or_and_not_not_commute1_after := by
  unfold or_and_not_not_commute1_before or_and_not_not_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_not_commute1
  apply or_and_not_not_commute1_thm
  ---END or_and_not_not_commute1



def or_and_not_not_commute2_before := [llvm|
{
^0(%arg419 : i32, %arg420 : i32, %arg421 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg420, %arg419 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg419, %arg421 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg420 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute2_after := [llvm|
{
^0(%arg419 : i32, %arg420 : i32, %arg421 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg421, %arg420 : i32
  %2 = llvm.or %1, %arg419 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_not_commute2_proof : or_and_not_not_commute2_before ⊑ or_and_not_not_commute2_after := by
  unfold or_and_not_not_commute2_before or_and_not_not_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_not_commute2
  apply or_and_not_not_commute2_thm
  ---END or_and_not_not_commute2



def or_and_not_not_commute3_before := [llvm|
{
^0(%arg416 : i32, %arg417 : i32, %arg418 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg417, %arg416 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg418, %arg416 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg417 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute3_after := [llvm|
{
^0(%arg416 : i32, %arg417 : i32, %arg418 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg418, %arg417 : i32
  %2 = llvm.or %1, %arg416 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_not_commute3_proof : or_and_not_not_commute3_before ⊑ or_and_not_not_commute3_after := by
  unfold or_and_not_not_commute3_before or_and_not_not_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_not_commute3
  apply or_and_not_not_commute3_thm
  ---END or_and_not_not_commute3



def or_and_not_not_commute4_before := [llvm|
{
^0(%arg413 : i32, %arg414 : i32, %arg415 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg413, %arg414 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg413, %arg415 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg414 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute4_after := [llvm|
{
^0(%arg413 : i32, %arg414 : i32, %arg415 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg415, %arg414 : i32
  %2 = llvm.or %1, %arg413 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_not_commute4_proof : or_and_not_not_commute4_before ⊑ or_and_not_not_commute4_after := by
  unfold or_and_not_not_commute4_before or_and_not_not_commute4_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_not_commute4
  apply or_and_not_not_commute4_thm
  ---END or_and_not_not_commute4



def or_and_not_not_commute5_before := [llvm|
{
^0(%arg410 : i32, %arg411 : i32, %arg412 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg411, %arg410 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg410, %arg412 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg411 : i32
  %6 = llvm.or %2, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute5_after := [llvm|
{
^0(%arg410 : i32, %arg411 : i32, %arg412 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg412, %arg411 : i32
  %2 = llvm.or %1, %arg410 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_not_commute5_proof : or_and_not_not_commute5_before ⊑ or_and_not_not_commute5_after := by
  unfold or_and_not_not_commute5_before or_and_not_not_commute5_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_not_commute5
  apply or_and_not_not_commute5_thm
  ---END or_and_not_not_commute5



def or_and_not_not_commute6_before := [llvm|
{
^0(%arg407 : i32, %arg408 : i32, %arg409 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg408 : i32
  %3 = llvm.or %2, %arg407 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %arg409, %arg407 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.and %2, %6 : i32
  %8 = llvm.or %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def or_and_not_not_commute6_after := [llvm|
{
^0(%arg407 : i32, %arg408 : i32, %arg409 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg408 : i32
  %3 = llvm.and %arg409, %2 : i32
  %4 = llvm.or %3, %arg407 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_not_commute6_proof : or_and_not_not_commute6_before ⊑ or_and_not_not_commute6_after := by
  unfold or_and_not_not_commute6_before or_and_not_not_commute6_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_not_commute6
  apply or_and_not_not_commute6_thm
  ---END or_and_not_not_commute6



def or_and_not_not_commute7_before := [llvm|
{
^0(%arg404 : i32, %arg405 : i32, %arg406 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg404, %arg405 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg406, %arg404 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg405 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute7_after := [llvm|
{
^0(%arg404 : i32, %arg405 : i32, %arg406 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg406, %arg405 : i32
  %2 = llvm.or %1, %arg404 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_not_commute7_proof : or_and_not_not_commute7_before ⊑ or_and_not_not_commute7_after := by
  unfold or_and_not_not_commute7_before or_and_not_not_commute7_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_not_commute7
  apply or_and_not_not_commute7_thm
  ---END or_and_not_not_commute7



def or_and_not_not_wrong_a_before := [llvm|
{
^0(%arg382 : i32, %arg383 : i32, %arg384 : i32, %arg385 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg383, %arg385 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg382, %arg384 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg383 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_wrong_a_after := [llvm|
{
^0(%arg382 : i32, %arg383 : i32, %arg384 : i32, %arg385 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg383, %arg385 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg382, %arg384 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %arg383, %4 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_not_wrong_a_proof : or_and_not_not_wrong_a_before ⊑ or_and_not_not_wrong_a_after := by
  unfold or_and_not_not_wrong_a_before or_and_not_not_wrong_a_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_not_wrong_a
  apply or_and_not_not_wrong_a_thm
  ---END or_and_not_not_wrong_a



def or_and_not_not_wrong_b_before := [llvm|
{
^0(%arg378 : i32, %arg379 : i32, %arg380 : i32, %arg381 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg381, %arg378 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg378, %arg380 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg379 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_wrong_b_after := [llvm|
{
^0(%arg378 : i32, %arg379 : i32, %arg380 : i32, %arg381 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg381, %arg378 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg378, %arg380 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %arg379, %4 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_not_not_wrong_b_proof : or_and_not_not_wrong_b_before ⊑ or_and_not_not_wrong_b_after := by
  unfold or_and_not_not_wrong_b_before or_and_not_not_wrong_b_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_not_not_wrong_b
  apply or_and_not_not_wrong_b_thm
  ---END or_and_not_not_wrong_b



def and_or_not_not_before := [llvm|
{
^0(%arg375 : i32, %arg376 : i32, %arg377 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg376, %arg375 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg375, %arg377 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg376 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_after := [llvm|
{
^0(%arg375 : i32, %arg376 : i32, %arg377 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg377, %arg376 : i32
  %2 = llvm.and %1, %arg375 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or_not_not_proof : and_or_not_not_before ⊑ and_or_not_not_after := by
  unfold and_or_not_not_before and_or_not_not_after
  simp_alive_peephole
  intros
  ---BEGIN and_or_not_not
  apply and_or_not_not_thm
  ---END and_or_not_not



def and_or_not_not_commute1_before := [llvm|
{
^0(%arg372 : i32, %arg373 : i32, %arg374 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg373 : i32
  %3 = llvm.and %2, %arg372 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %arg372, %arg374 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %2, %6 : i32
  %8 = llvm.and %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def and_or_not_not_commute1_after := [llvm|
{
^0(%arg372 : i32, %arg373 : i32, %arg374 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg373 : i32
  %3 = llvm.or %arg374, %2 : i32
  %4 = llvm.and %3, %arg372 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or_not_not_commute1_proof : and_or_not_not_commute1_before ⊑ and_or_not_not_commute1_after := by
  unfold and_or_not_not_commute1_before and_or_not_not_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN and_or_not_not_commute1
  apply and_or_not_not_commute1_thm
  ---END and_or_not_not_commute1



def and_or_not_not_commute2_before := [llvm|
{
^0(%arg369 : i32, %arg370 : i32, %arg371 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg370, %arg369 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg369, %arg371 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg370 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute2_after := [llvm|
{
^0(%arg369 : i32, %arg370 : i32, %arg371 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg371, %arg370 : i32
  %2 = llvm.and %1, %arg369 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or_not_not_commute2_proof : and_or_not_not_commute2_before ⊑ and_or_not_not_commute2_after := by
  unfold and_or_not_not_commute2_before and_or_not_not_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN and_or_not_not_commute2
  apply and_or_not_not_commute2_thm
  ---END and_or_not_not_commute2



def and_or_not_not_commute3_before := [llvm|
{
^0(%arg366 : i32, %arg367 : i32, %arg368 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg367, %arg366 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg368, %arg366 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg367 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute3_after := [llvm|
{
^0(%arg366 : i32, %arg367 : i32, %arg368 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg368, %arg367 : i32
  %2 = llvm.and %1, %arg366 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or_not_not_commute3_proof : and_or_not_not_commute3_before ⊑ and_or_not_not_commute3_after := by
  unfold and_or_not_not_commute3_before and_or_not_not_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN and_or_not_not_commute3
  apply and_or_not_not_commute3_thm
  ---END and_or_not_not_commute3



def and_or_not_not_commute4_before := [llvm|
{
^0(%arg363 : i32, %arg364 : i32, %arg365 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg363, %arg364 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg363, %arg365 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg364 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute4_after := [llvm|
{
^0(%arg363 : i32, %arg364 : i32, %arg365 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg365, %arg364 : i32
  %2 = llvm.and %1, %arg363 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or_not_not_commute4_proof : and_or_not_not_commute4_before ⊑ and_or_not_not_commute4_after := by
  unfold and_or_not_not_commute4_before and_or_not_not_commute4_after
  simp_alive_peephole
  intros
  ---BEGIN and_or_not_not_commute4
  apply and_or_not_not_commute4_thm
  ---END and_or_not_not_commute4



def and_or_not_not_commute5_before := [llvm|
{
^0(%arg360 : i32, %arg361 : i32, %arg362 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg361, %arg360 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg360, %arg362 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg361 : i32
  %6 = llvm.and %2, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute5_after := [llvm|
{
^0(%arg360 : i32, %arg361 : i32, %arg362 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg362, %arg361 : i32
  %2 = llvm.and %1, %arg360 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or_not_not_commute5_proof : and_or_not_not_commute5_before ⊑ and_or_not_not_commute5_after := by
  unfold and_or_not_not_commute5_before and_or_not_not_commute5_after
  simp_alive_peephole
  intros
  ---BEGIN and_or_not_not_commute5
  apply and_or_not_not_commute5_thm
  ---END and_or_not_not_commute5



def and_or_not_not_commute6_before := [llvm|
{
^0(%arg357 : i32, %arg358 : i32, %arg359 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg358 : i32
  %3 = llvm.and %2, %arg357 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %arg359, %arg357 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %2, %6 : i32
  %8 = llvm.and %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def and_or_not_not_commute6_after := [llvm|
{
^0(%arg357 : i32, %arg358 : i32, %arg359 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg358 : i32
  %3 = llvm.or %arg359, %2 : i32
  %4 = llvm.and %3, %arg357 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or_not_not_commute6_proof : and_or_not_not_commute6_before ⊑ and_or_not_not_commute6_after := by
  unfold and_or_not_not_commute6_before and_or_not_not_commute6_after
  simp_alive_peephole
  intros
  ---BEGIN and_or_not_not_commute6
  apply and_or_not_not_commute6_thm
  ---END and_or_not_not_commute6



def and_or_not_not_commute7_before := [llvm|
{
^0(%arg354 : i32, %arg355 : i32, %arg356 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg354, %arg355 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg356, %arg354 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg355 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute7_after := [llvm|
{
^0(%arg354 : i32, %arg355 : i32, %arg356 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg356, %arg355 : i32
  %2 = llvm.and %1, %arg354 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or_not_not_commute7_proof : and_or_not_not_commute7_before ⊑ and_or_not_not_commute7_after := by
  unfold and_or_not_not_commute7_before and_or_not_not_commute7_after
  simp_alive_peephole
  intros
  ---BEGIN and_or_not_not_commute7
  apply and_or_not_not_commute7_thm
  ---END and_or_not_not_commute7



def and_or_not_not_wrong_a_before := [llvm|
{
^0(%arg332 : i32, %arg333 : i32, %arg334 : i32, %arg335 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg333, %arg335 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg332, %arg334 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg333 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_wrong_a_after := [llvm|
{
^0(%arg332 : i32, %arg333 : i32, %arg334 : i32, %arg335 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg333, %arg335 : i32
  %2 = llvm.and %arg332, %arg334 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %arg333, %3 : i32
  %5 = llvm.xor %1, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or_not_not_wrong_a_proof : and_or_not_not_wrong_a_before ⊑ and_or_not_not_wrong_a_after := by
  unfold and_or_not_not_wrong_a_before and_or_not_not_wrong_a_after
  simp_alive_peephole
  intros
  ---BEGIN and_or_not_not_wrong_a
  apply and_or_not_not_wrong_a_thm
  ---END and_or_not_not_wrong_a



def and_or_not_not_wrong_b_before := [llvm|
{
^0(%arg328 : i32, %arg329 : i32, %arg330 : i32, %arg331 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg331, %arg328 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg328, %arg330 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg329 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_wrong_b_after := [llvm|
{
^0(%arg328 : i32, %arg329 : i32, %arg330 : i32, %arg331 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg331, %arg328 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg328, %arg330 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %arg329, %4 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or_not_not_wrong_b_proof : and_or_not_not_wrong_b_before ⊑ and_or_not_not_wrong_b_after := by
  unfold and_or_not_not_wrong_b_before and_or_not_not_wrong_b_after
  simp_alive_peephole
  intros
  ---BEGIN and_or_not_not_wrong_b
  apply and_or_not_not_wrong_b_thm
  ---END and_or_not_not_wrong_b



def and_not_or_or_not_or_xor_before := [llvm|
{
^0(%arg325 : i32, %arg326 : i32, %arg327 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg326, %arg327 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg325 : i32
  %4 = llvm.xor %arg326, %arg327 : i32
  %5 = llvm.or %4, %arg325 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_after := [llvm|
{
^0(%arg325 : i32, %arg326 : i32, %arg327 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg326, %arg327 : i32
  %2 = llvm.xor %arg326, %arg327 : i32
  %3 = llvm.or %2, %arg325 : i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_or_not_or_xor_proof : and_not_or_or_not_or_xor_before ⊑ and_not_or_or_not_or_xor_after := by
  unfold and_not_or_or_not_or_xor_before and_not_or_or_not_or_xor_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_or_not_or_xor
  apply and_not_or_or_not_or_xor_thm
  ---END and_not_or_or_not_or_xor



def and_not_or_or_not_or_xor_commute1_before := [llvm|
{
^0(%arg322 : i32, %arg323 : i32, %arg324 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg324, %arg323 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg322 : i32
  %4 = llvm.xor %arg323, %arg324 : i32
  %5 = llvm.or %4, %arg322 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_commute1_after := [llvm|
{
^0(%arg322 : i32, %arg323 : i32, %arg324 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg324, %arg323 : i32
  %2 = llvm.xor %arg323, %arg324 : i32
  %3 = llvm.or %2, %arg322 : i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_or_not_or_xor_commute1_proof : and_not_or_or_not_or_xor_commute1_before ⊑ and_not_or_or_not_or_xor_commute1_after := by
  unfold and_not_or_or_not_or_xor_commute1_before and_not_or_or_not_or_xor_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_or_not_or_xor_commute1
  apply and_not_or_or_not_or_xor_commute1_thm
  ---END and_not_or_or_not_or_xor_commute1



def and_not_or_or_not_or_xor_commute2_before := [llvm|
{
^0(%arg319 : i32, %arg320 : i32, %arg321 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg319 : i32
  %3 = llvm.or %arg320, %arg321 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  %6 = llvm.xor %arg320, %arg321 : i32
  %7 = llvm.or %6, %2 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.or %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_commute2_after := [llvm|
{
^0(%arg319 : i32, %arg320 : i32, %arg321 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg319 : i32
  %3 = llvm.or %arg320, %arg321 : i32
  %4 = llvm.xor %arg320, %arg321 : i32
  %5 = llvm.or %4, %2 : i32
  %6 = llvm.and %3, %5 : i32
  %7 = llvm.xor %6, %1 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_or_not_or_xor_commute2_proof : and_not_or_or_not_or_xor_commute2_before ⊑ and_not_or_or_not_or_xor_commute2_after := by
  unfold and_not_or_or_not_or_xor_commute2_before and_not_or_or_not_or_xor_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_or_not_or_xor_commute2
  apply and_not_or_or_not_or_xor_commute2_thm
  ---END and_not_or_or_not_or_xor_commute2



def and_not_or_or_not_or_xor_commute3_before := [llvm|
{
^0(%arg316 : i32, %arg317 : i32, %arg318 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg317, %arg318 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg316 : i32
  %4 = llvm.xor %arg318, %arg317 : i32
  %5 = llvm.or %4, %arg316 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_commute3_after := [llvm|
{
^0(%arg316 : i32, %arg317 : i32, %arg318 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg317, %arg318 : i32
  %2 = llvm.xor %arg318, %arg317 : i32
  %3 = llvm.or %2, %arg316 : i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_or_not_or_xor_commute3_proof : and_not_or_or_not_or_xor_commute3_before ⊑ and_not_or_or_not_or_xor_commute3_after := by
  unfold and_not_or_or_not_or_xor_commute3_before and_not_or_or_not_or_xor_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_or_not_or_xor_commute3
  apply and_not_or_or_not_or_xor_commute3_thm
  ---END and_not_or_or_not_or_xor_commute3



def and_not_or_or_not_or_xor_commute4_before := [llvm|
{
^0(%arg313 : i32, %arg314 : i32, %arg315 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg313 : i32
  %3 = llvm.or %arg314, %arg315 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  %6 = llvm.xor %arg314, %arg315 : i32
  %7 = llvm.or %2, %6 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.or %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_commute4_after := [llvm|
{
^0(%arg313 : i32, %arg314 : i32, %arg315 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg313 : i32
  %3 = llvm.or %arg314, %arg315 : i32
  %4 = llvm.xor %arg314, %arg315 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.and %3, %5 : i32
  %7 = llvm.xor %6, %1 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_or_not_or_xor_commute4_proof : and_not_or_or_not_or_xor_commute4_before ⊑ and_not_or_or_not_or_xor_commute4_after := by
  unfold and_not_or_or_not_or_xor_commute4_before and_not_or_or_not_or_xor_commute4_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_or_not_or_xor_commute4
  apply and_not_or_or_not_or_xor_commute4_thm
  ---END and_not_or_or_not_or_xor_commute4



def and_not_or_or_not_or_xor_commute5_before := [llvm|
{
^0(%arg310 : i32, %arg311 : i32, %arg312 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg311, %arg312 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg310 : i32
  %4 = llvm.xor %arg311, %arg312 : i32
  %5 = llvm.or %4, %arg310 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_commute5_after := [llvm|
{
^0(%arg310 : i32, %arg311 : i32, %arg312 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg311, %arg312 : i32
  %2 = llvm.xor %arg311, %arg312 : i32
  %3 = llvm.or %2, %arg310 : i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_not_or_or_not_or_xor_commute5_proof : and_not_or_or_not_or_xor_commute5_before ⊑ and_not_or_or_not_or_xor_commute5_after := by
  unfold and_not_or_or_not_or_xor_commute5_before and_not_or_or_not_or_xor_commute5_after
  simp_alive_peephole
  intros
  ---BEGIN and_not_or_or_not_or_xor_commute5
  apply and_not_or_or_not_or_xor_commute5_thm
  ---END and_not_or_or_not_or_xor_commute5



def or_not_and_and_not_and_xor_before := [llvm|
{
^0(%arg289 : i32, %arg290 : i32, %arg291 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg290, %arg291 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg289 : i32
  %4 = llvm.xor %arg290, %arg291 : i32
  %5 = llvm.and %4, %arg289 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_after := [llvm|
{
^0(%arg289 : i32, %arg290 : i32, %arg291 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg290, %arg291 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg289, %2 : i32
  %4 = llvm.xor %arg290, %arg291 : i32
  %5 = llvm.and %4, %arg289 : i32
  %6 = llvm.xor %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_and_not_and_xor_proof : or_not_and_and_not_and_xor_before ⊑ or_not_and_and_not_and_xor_after := by
  unfold or_not_and_and_not_and_xor_before or_not_and_and_not_and_xor_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_and_not_and_xor
  apply or_not_and_and_not_and_xor_thm
  ---END or_not_and_and_not_and_xor



def or_not_and_and_not_and_xor_commute1_before := [llvm|
{
^0(%arg286 : i32, %arg287 : i32, %arg288 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg288, %arg287 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg286 : i32
  %4 = llvm.xor %arg287, %arg288 : i32
  %5 = llvm.and %4, %arg286 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_commute1_after := [llvm|
{
^0(%arg286 : i32, %arg287 : i32, %arg288 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg288, %arg287 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg286, %2 : i32
  %4 = llvm.xor %arg287, %arg288 : i32
  %5 = llvm.and %4, %arg286 : i32
  %6 = llvm.xor %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_and_not_and_xor_commute1_proof : or_not_and_and_not_and_xor_commute1_before ⊑ or_not_and_and_not_and_xor_commute1_after := by
  unfold or_not_and_and_not_and_xor_commute1_before or_not_and_and_not_and_xor_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_and_not_and_xor_commute1
  apply or_not_and_and_not_and_xor_commute1_thm
  ---END or_not_and_and_not_and_xor_commute1



def or_not_and_and_not_and_xor_commute2_before := [llvm|
{
^0(%arg283 : i32, %arg284 : i32, %arg285 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg283 : i32
  %3 = llvm.and %arg284, %arg285 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.xor %arg284, %arg285 : i32
  %7 = llvm.and %6, %2 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.and %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_commute2_after := [llvm|
{
^0(%arg283 : i32, %arg284 : i32, %arg285 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg283 : i32
  %3 = llvm.and %arg284, %arg285 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.xor %arg284, %arg285 : i32
  %7 = llvm.and %6, %2 : i32
  %8 = llvm.xor %7, %5 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_and_not_and_xor_commute2_proof : or_not_and_and_not_and_xor_commute2_before ⊑ or_not_and_and_not_and_xor_commute2_after := by
  unfold or_not_and_and_not_and_xor_commute2_before or_not_and_and_not_and_xor_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_and_not_and_xor_commute2
  apply or_not_and_and_not_and_xor_commute2_thm
  ---END or_not_and_and_not_and_xor_commute2



def or_not_and_and_not_and_xor_commute3_before := [llvm|
{
^0(%arg280 : i32, %arg281 : i32, %arg282 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg281, %arg282 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg280 : i32
  %4 = llvm.xor %arg282, %arg281 : i32
  %5 = llvm.and %4, %arg280 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_commute3_after := [llvm|
{
^0(%arg280 : i32, %arg281 : i32, %arg282 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg281, %arg282 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg280, %2 : i32
  %4 = llvm.xor %arg282, %arg281 : i32
  %5 = llvm.and %4, %arg280 : i32
  %6 = llvm.xor %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_and_not_and_xor_commute3_proof : or_not_and_and_not_and_xor_commute3_before ⊑ or_not_and_and_not_and_xor_commute3_after := by
  unfold or_not_and_and_not_and_xor_commute3_before or_not_and_and_not_and_xor_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_and_not_and_xor_commute3
  apply or_not_and_and_not_and_xor_commute3_thm
  ---END or_not_and_and_not_and_xor_commute3



def or_not_and_and_not_and_xor_commute4_before := [llvm|
{
^0(%arg277 : i32, %arg278 : i32, %arg279 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg277 : i32
  %3 = llvm.and %arg278, %arg279 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.xor %arg278, %arg279 : i32
  %7 = llvm.and %2, %6 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.and %5, %8 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_commute4_after := [llvm|
{
^0(%arg277 : i32, %arg278 : i32, %arg279 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg277 : i32
  %3 = llvm.and %arg278, %arg279 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.xor %arg278, %arg279 : i32
  %7 = llvm.and %2, %6 : i32
  %8 = llvm.xor %7, %5 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_and_not_and_xor_commute4_proof : or_not_and_and_not_and_xor_commute4_before ⊑ or_not_and_and_not_and_xor_commute4_after := by
  unfold or_not_and_and_not_and_xor_commute4_before or_not_and_and_not_and_xor_commute4_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_and_not_and_xor_commute4
  apply or_not_and_and_not_and_xor_commute4_thm
  ---END or_not_and_and_not_and_xor_commute4



def or_not_and_and_not_and_xor_commute5_before := [llvm|
{
^0(%arg274 : i32, %arg275 : i32, %arg276 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg275, %arg276 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg274 : i32
  %4 = llvm.xor %arg275, %arg276 : i32
  %5 = llvm.and %4, %arg274 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_commute5_after := [llvm|
{
^0(%arg274 : i32, %arg275 : i32, %arg276 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg275, %arg276 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg274, %2 : i32
  %4 = llvm.xor %arg275, %arg276 : i32
  %5 = llvm.and %4, %arg274 : i32
  %6 = llvm.xor %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_and_and_not_and_xor_commute5_proof : or_not_and_and_not_and_xor_commute5_before ⊑ or_not_and_and_not_and_xor_commute5_after := by
  unfold or_not_and_and_not_and_xor_commute5_before or_not_and_and_not_and_xor_commute5_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_and_and_not_and_xor_commute5
  apply or_not_and_and_not_and_xor_commute5_thm
  ---END or_not_and_and_not_and_xor_commute5



def not_and_and_or_not_or_or_before := [llvm|
{
^0(%arg253 : i32, %arg254 : i32, %arg255 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg254, %arg253 : i32
  %2 = llvm.or %1, %arg255 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg253, %0 : i32
  %5 = llvm.and %4, %arg254 : i32
  %6 = llvm.and %5, %arg255 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_after := [llvm|
{
^0(%arg253 : i32, %arg254 : i32, %arg255 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg255, %arg254 : i32
  %2 = llvm.or %1, %arg253 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_not_or_or_proof : not_and_and_or_not_or_or_before ⊑ not_and_and_or_not_or_or_after := by
  unfold not_and_and_or_not_or_or_before not_and_and_or_not_or_or_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_not_or_or
  apply not_and_and_or_not_or_or_thm
  ---END not_and_and_or_not_or_or



def not_and_and_or_not_or_or_commute1_or_before := [llvm|
{
^0(%arg250 : i32, %arg251 : i32, %arg252 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg252, %arg250 : i32
  %2 = llvm.or %1, %arg251 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg250, %0 : i32
  %5 = llvm.and %4, %arg251 : i32
  %6 = llvm.and %5, %arg252 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute1_or_after := [llvm|
{
^0(%arg250 : i32, %arg251 : i32, %arg252 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg252, %arg251 : i32
  %2 = llvm.or %1, %arg250 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_not_or_or_commute1_or_proof : not_and_and_or_not_or_or_commute1_or_before ⊑ not_and_and_or_not_or_or_commute1_or_after := by
  unfold not_and_and_or_not_or_or_commute1_or_before not_and_and_or_not_or_or_commute1_or_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_not_or_or_commute1_or
  apply not_and_and_or_not_or_or_commute1_or_thm
  ---END not_and_and_or_not_or_or_commute1_or



def not_and_and_or_not_or_or_commute2_or_before := [llvm|
{
^0(%arg247 : i32, %arg248 : i32, %arg249 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg248, %arg249 : i32
  %2 = llvm.or %1, %arg247 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg247, %0 : i32
  %5 = llvm.and %4, %arg248 : i32
  %6 = llvm.and %5, %arg249 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute2_or_after := [llvm|
{
^0(%arg247 : i32, %arg248 : i32, %arg249 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg249, %arg248 : i32
  %2 = llvm.or %1, %arg247 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_not_or_or_commute2_or_proof : not_and_and_or_not_or_or_commute2_or_before ⊑ not_and_and_or_not_or_or_commute2_or_after := by
  unfold not_and_and_or_not_or_or_commute2_or_before not_and_and_or_not_or_or_commute2_or_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_not_or_or_commute2_or
  apply not_and_and_or_not_or_or_commute2_or_thm
  ---END not_and_and_or_not_or_or_commute2_or



def not_and_and_or_not_or_or_commute1_and_before := [llvm|
{
^0(%arg244 : i32, %arg245 : i32, %arg246 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg245, %arg244 : i32
  %2 = llvm.or %1, %arg246 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg244, %0 : i32
  %5 = llvm.and %4, %arg246 : i32
  %6 = llvm.and %5, %arg245 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute1_and_after := [llvm|
{
^0(%arg244 : i32, %arg245 : i32, %arg246 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg245, %arg246 : i32
  %2 = llvm.or %1, %arg244 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_not_or_or_commute1_and_proof : not_and_and_or_not_or_or_commute1_and_before ⊑ not_and_and_or_not_or_or_commute1_and_after := by
  unfold not_and_and_or_not_or_or_commute1_and_before not_and_and_or_not_or_or_commute1_and_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_not_or_or_commute1_and
  apply not_and_and_or_not_or_or_commute1_and_thm
  ---END not_and_and_or_not_or_or_commute1_and



def not_and_and_or_not_or_or_commute2_and_before := [llvm|
{
^0(%arg241 : i32, %arg242 : i32, %arg243 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg242, %arg241 : i32
  %2 = llvm.or %1, %arg243 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg241, %0 : i32
  %5 = llvm.and %arg242, %arg243 : i32
  %6 = llvm.and %5, %4 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute2_and_after := [llvm|
{
^0(%arg241 : i32, %arg242 : i32, %arg243 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg242, %arg243 : i32
  %2 = llvm.or %1, %arg241 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_not_or_or_commute2_and_proof : not_and_and_or_not_or_or_commute2_and_before ⊑ not_and_and_or_not_or_or_commute2_and_after := by
  unfold not_and_and_or_not_or_or_commute2_and_before not_and_and_or_not_or_or_commute2_and_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_not_or_or_commute2_and
  apply not_and_and_or_not_or_or_commute2_and_thm
  ---END not_and_and_or_not_or_or_commute2_and



def not_and_and_or_not_or_or_commute1_before := [llvm|
{
^0(%arg238 : i32, %arg239 : i32, %arg240 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg238, %arg239 : i32
  %2 = llvm.or %1, %arg240 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg238, %0 : i32
  %5 = llvm.and %4, %arg239 : i32
  %6 = llvm.and %5, %arg240 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute1_after := [llvm|
{
^0(%arg238 : i32, %arg239 : i32, %arg240 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg240, %arg239 : i32
  %2 = llvm.or %1, %arg238 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_not_or_or_commute1_proof : not_and_and_or_not_or_or_commute1_before ⊑ not_and_and_or_not_or_or_commute1_after := by
  unfold not_and_and_or_not_or_or_commute1_before not_and_and_or_not_or_or_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_not_or_or_commute1
  apply not_and_and_or_not_or_or_commute1_thm
  ---END not_and_and_or_not_or_or_commute1



def not_and_and_or_not_or_or_commute2_before := [llvm|
{
^0(%arg235 : i32, %arg236 : i32, %arg237 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg237 : i32
  %3 = llvm.or %arg236, %arg235 : i32
  %4 = llvm.or %2, %3 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.xor %arg235, %1 : i32
  %7 = llvm.and %6, %arg236 : i32
  %8 = llvm.and %7, %2 : i32
  %9 = llvm.or %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute2_after := [llvm|
{
^0(%arg235 : i32, %arg236 : i32, %arg237 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg237 : i32
  %3 = llvm.xor %2, %arg236 : i32
  %4 = llvm.or %3, %arg235 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_not_or_or_commute2_proof : not_and_and_or_not_or_or_commute2_before ⊑ not_and_and_or_not_or_or_commute2_after := by
  unfold not_and_and_or_not_or_or_commute2_before not_and_and_or_not_or_or_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_not_or_or_commute2
  apply not_and_and_or_not_or_or_commute2_thm
  ---END not_and_and_or_not_or_or_commute2



def not_and_and_or_not_or_or_commute3_before := [llvm|
{
^0(%arg232 : i32, %arg233 : i32, %arg234 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg233 : i32
  %3 = llvm.or %2, %arg232 : i32
  %4 = llvm.or %3, %arg234 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.xor %arg232, %1 : i32
  %7 = llvm.and %2, %6 : i32
  %8 = llvm.and %7, %arg234 : i32
  %9 = llvm.or %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute3_after := [llvm|
{
^0(%arg232 : i32, %arg233 : i32, %arg234 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg233 : i32
  %3 = llvm.xor %arg234, %2 : i32
  %4 = llvm.or %3, %arg232 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_not_or_or_commute3_proof : not_and_and_or_not_or_or_commute3_before ⊑ not_and_and_or_not_or_or_commute3_after := by
  unfold not_and_and_or_not_or_or_commute3_before not_and_and_or_not_or_or_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_not_or_or_commute3
  apply not_and_and_or_not_or_or_commute3_thm
  ---END not_and_and_or_not_or_or_commute3



def not_and_and_or_not_or_or_commute4_before := [llvm|
{
^0(%arg229 : i32, %arg230 : i32, %arg231 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg231 : i32
  %3 = llvm.or %arg230, %arg229 : i32
  %4 = llvm.or %3, %2 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.xor %arg229, %1 : i32
  %7 = llvm.and %6, %arg230 : i32
  %8 = llvm.and %2, %7 : i32
  %9 = llvm.or %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute4_after := [llvm|
{
^0(%arg229 : i32, %arg230 : i32, %arg231 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg231 : i32
  %3 = llvm.xor %2, %arg230 : i32
  %4 = llvm.or %3, %arg229 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_not_or_or_commute4_proof : not_and_and_or_not_or_or_commute4_before ⊑ not_and_and_or_not_or_or_commute4_after := by
  unfold not_and_and_or_not_or_or_commute4_before not_and_and_or_not_or_or_commute4_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_not_or_or_commute4
  apply not_and_and_or_not_or_or_commute4_thm
  ---END not_and_and_or_not_or_or_commute4



def not_or_or_and_not_and_and_before := [llvm|
{
^0(%arg208 : i32, %arg209 : i32, %arg210 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg209, %arg208 : i32
  %2 = llvm.and %1, %arg210 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg208, %0 : i32
  %5 = llvm.or %4, %arg209 : i32
  %6 = llvm.or %5, %arg210 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_after := [llvm|
{
^0(%arg208 : i32, %arg209 : i32, %arg210 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg208, %0 : i32
  %2 = llvm.xor %arg210, %arg209 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_not_and_and_proof : not_or_or_and_not_and_and_before ⊑ not_or_or_and_not_and_and_after := by
  unfold not_or_or_and_not_and_and_before not_or_or_and_not_and_and_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_not_and_and
  apply not_or_or_and_not_and_and_thm
  ---END not_or_or_and_not_and_and



def not_or_or_and_not_and_and_commute1_and_before := [llvm|
{
^0(%arg205 : i32, %arg206 : i32, %arg207 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg207, %arg205 : i32
  %2 = llvm.and %1, %arg206 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg205, %0 : i32
  %5 = llvm.or %4, %arg206 : i32
  %6 = llvm.or %5, %arg207 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute1_and_after := [llvm|
{
^0(%arg205 : i32, %arg206 : i32, %arg207 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg205, %0 : i32
  %2 = llvm.xor %arg207, %arg206 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_not_and_and_commute1_and_proof : not_or_or_and_not_and_and_commute1_and_before ⊑ not_or_or_and_not_and_and_commute1_and_after := by
  unfold not_or_or_and_not_and_and_commute1_and_before not_or_or_and_not_and_and_commute1_and_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_not_and_and_commute1_and
  apply not_or_or_and_not_and_and_commute1_and_thm
  ---END not_or_or_and_not_and_and_commute1_and



def not_or_or_and_not_and_and_commute2_and_before := [llvm|
{
^0(%arg202 : i32, %arg203 : i32, %arg204 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg203, %arg204 : i32
  %2 = llvm.and %1, %arg202 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg202, %0 : i32
  %5 = llvm.or %4, %arg203 : i32
  %6 = llvm.or %5, %arg204 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute2_and_after := [llvm|
{
^0(%arg202 : i32, %arg203 : i32, %arg204 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg202, %0 : i32
  %2 = llvm.xor %arg204, %arg203 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_not_and_and_commute2_and_proof : not_or_or_and_not_and_and_commute2_and_before ⊑ not_or_or_and_not_and_and_commute2_and_after := by
  unfold not_or_or_and_not_and_and_commute2_and_before not_or_or_and_not_and_and_commute2_and_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_not_and_and_commute2_and
  apply not_or_or_and_not_and_and_commute2_and_thm
  ---END not_or_or_and_not_and_and_commute2_and



def not_or_or_and_not_and_and_commute1_or_before := [llvm|
{
^0(%arg199 : i32, %arg200 : i32, %arg201 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg200, %arg199 : i32
  %2 = llvm.and %1, %arg201 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg199, %0 : i32
  %5 = llvm.or %4, %arg201 : i32
  %6 = llvm.or %5, %arg200 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute1_or_after := [llvm|
{
^0(%arg199 : i32, %arg200 : i32, %arg201 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg199, %0 : i32
  %2 = llvm.xor %arg200, %arg201 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_not_and_and_commute1_or_proof : not_or_or_and_not_and_and_commute1_or_before ⊑ not_or_or_and_not_and_and_commute1_or_after := by
  unfold not_or_or_and_not_and_and_commute1_or_before not_or_or_and_not_and_and_commute1_or_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_not_and_and_commute1_or
  apply not_or_or_and_not_and_and_commute1_or_thm
  ---END not_or_or_and_not_and_and_commute1_or



def not_or_or_and_not_and_and_commute2_or_before := [llvm|
{
^0(%arg196 : i32, %arg197 : i32, %arg198 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg197, %arg196 : i32
  %2 = llvm.and %1, %arg198 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg196, %0 : i32
  %5 = llvm.or %arg197, %arg198 : i32
  %6 = llvm.or %5, %4 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute2_or_after := [llvm|
{
^0(%arg196 : i32, %arg197 : i32, %arg198 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg196, %0 : i32
  %2 = llvm.xor %arg197, %arg198 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_not_and_and_commute2_or_proof : not_or_or_and_not_and_and_commute2_or_before ⊑ not_or_or_and_not_and_and_commute2_or_after := by
  unfold not_or_or_and_not_and_and_commute2_or_before not_or_or_and_not_and_and_commute2_or_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_not_and_and_commute2_or
  apply not_or_or_and_not_and_and_commute2_or_thm
  ---END not_or_or_and_not_and_and_commute2_or



def not_or_or_and_not_and_and_commute1_before := [llvm|
{
^0(%arg193 : i32, %arg194 : i32, %arg195 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg193, %arg194 : i32
  %2 = llvm.and %1, %arg195 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg193, %0 : i32
  %5 = llvm.or %4, %arg194 : i32
  %6 = llvm.or %5, %arg195 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute1_after := [llvm|
{
^0(%arg193 : i32, %arg194 : i32, %arg195 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg193, %0 : i32
  %2 = llvm.xor %arg195, %arg194 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_not_and_and_commute1_proof : not_or_or_and_not_and_and_commute1_before ⊑ not_or_or_and_not_and_and_commute1_after := by
  unfold not_or_or_and_not_and_and_commute1_before not_or_or_and_not_and_and_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_not_and_and_commute1
  apply not_or_or_and_not_and_and_commute1_thm
  ---END not_or_or_and_not_and_and_commute1



def not_or_or_and_not_and_and_commute2_before := [llvm|
{
^0(%arg190 : i32, %arg191 : i32, %arg192 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg192 : i32
  %3 = llvm.and %arg191, %arg190 : i32
  %4 = llvm.and %2, %3 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.xor %arg190, %1 : i32
  %7 = llvm.or %6, %arg191 : i32
  %8 = llvm.or %7, %2 : i32
  %9 = llvm.and %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute2_after := [llvm|
{
^0(%arg190 : i32, %arg191 : i32, %arg192 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg192 : i32
  %3 = llvm.xor %arg190, %1 : i32
  %4 = llvm.xor %2, %arg191 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_not_and_and_commute2_proof : not_or_or_and_not_and_and_commute2_before ⊑ not_or_or_and_not_and_and_commute2_after := by
  unfold not_or_or_and_not_and_and_commute2_before not_or_or_and_not_and_and_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_not_and_and_commute2
  apply not_or_or_and_not_and_and_commute2_thm
  ---END not_or_or_and_not_and_and_commute2



def not_or_or_and_not_and_and_commute3_before := [llvm|
{
^0(%arg187 : i32, %arg188 : i32, %arg189 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg188 : i32
  %3 = llvm.and %2, %arg187 : i32
  %4 = llvm.and %3, %arg189 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.xor %arg187, %1 : i32
  %7 = llvm.or %2, %6 : i32
  %8 = llvm.or %7, %arg189 : i32
  %9 = llvm.and %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute3_after := [llvm|
{
^0(%arg187 : i32, %arg188 : i32, %arg189 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg188 : i32
  %3 = llvm.xor %arg187, %1 : i32
  %4 = llvm.xor %arg189, %2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_not_and_and_commute3_proof : not_or_or_and_not_and_and_commute3_before ⊑ not_or_or_and_not_and_and_commute3_after := by
  unfold not_or_or_and_not_and_and_commute3_before not_or_or_and_not_and_and_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_not_and_and_commute3
  apply not_or_or_and_not_and_and_commute3_thm
  ---END not_or_or_and_not_and_and_commute3



def not_or_or_and_not_and_and_commute4_before := [llvm|
{
^0(%arg184 : i32, %arg185 : i32, %arg186 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg186 : i32
  %3 = llvm.and %arg185, %arg184 : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.xor %arg184, %1 : i32
  %7 = llvm.or %6, %arg185 : i32
  %8 = llvm.or %2, %7 : i32
  %9 = llvm.and %8, %5 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute4_after := [llvm|
{
^0(%arg184 : i32, %arg185 : i32, %arg186 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg186 : i32
  %3 = llvm.xor %arg184, %1 : i32
  %4 = llvm.xor %2, %arg185 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_not_and_and_commute4_proof : not_or_or_and_not_and_and_commute4_before ⊑ not_or_or_and_not_and_and_commute4_after := by
  unfold not_or_or_and_not_and_and_commute4_before not_or_or_and_not_and_and_commute4_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_not_and_and_commute4
  apply not_or_or_and_not_and_and_commute4_thm
  ---END not_or_or_and_not_and_and_commute4



def not_and_and_or_no_or_before := [llvm|
{
^0(%arg163 : i32, %arg164 : i32, %arg165 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg164, %arg163 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg163, %0 : i32
  %4 = llvm.and %3, %arg164 : i32
  %5 = llvm.and %4, %arg165 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_or_no_or_after := [llvm|
{
^0(%arg163 : i32, %arg164 : i32, %arg165 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg163, %0 : i32
  %2 = llvm.xor %arg164, %0 : i32
  %3 = llvm.or %arg165, %2 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_no_or_proof : not_and_and_or_no_or_before ⊑ not_and_and_or_no_or_after := by
  unfold not_and_and_or_no_or_before not_and_and_or_no_or_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_no_or
  apply not_and_and_or_no_or_thm
  ---END not_and_and_or_no_or



def not_and_and_or_no_or_commute1_and_before := [llvm|
{
^0(%arg160 : i32, %arg161 : i32, %arg162 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg161, %arg160 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg160, %0 : i32
  %4 = llvm.and %arg162, %arg161 : i32
  %5 = llvm.and %4, %3 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_or_no_or_commute1_and_after := [llvm|
{
^0(%arg160 : i32, %arg161 : i32, %arg162 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg160, %0 : i32
  %2 = llvm.xor %arg161, %0 : i32
  %3 = llvm.or %arg162, %2 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_no_or_commute1_and_proof : not_and_and_or_no_or_commute1_and_before ⊑ not_and_and_or_no_or_commute1_and_after := by
  unfold not_and_and_or_no_or_commute1_and_before not_and_and_or_no_or_commute1_and_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_no_or_commute1_and
  apply not_and_and_or_no_or_commute1_and_thm
  ---END not_and_and_or_no_or_commute1_and



def not_and_and_or_no_or_commute2_and_before := [llvm|
{
^0(%arg157 : i32, %arg158 : i32, %arg159 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg158, %arg157 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg157, %0 : i32
  %4 = llvm.and %3, %arg159 : i32
  %5 = llvm.and %4, %arg158 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_or_no_or_commute2_and_after := [llvm|
{
^0(%arg157 : i32, %arg158 : i32, %arg159 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg157, %0 : i32
  %2 = llvm.xor %arg158, %0 : i32
  %3 = llvm.or %arg159, %2 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_no_or_commute2_and_proof : not_and_and_or_no_or_commute2_and_before ⊑ not_and_and_or_no_or_commute2_and_after := by
  unfold not_and_and_or_no_or_commute2_and_before not_and_and_or_no_or_commute2_and_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_no_or_commute2_and
  apply not_and_and_or_no_or_commute2_and_thm
  ---END not_and_and_or_no_or_commute2_and



def not_and_and_or_no_or_commute1_before := [llvm|
{
^0(%arg154 : i32, %arg155 : i32, %arg156 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg154, %arg155 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg154, %0 : i32
  %4 = llvm.and %3, %arg155 : i32
  %5 = llvm.and %4, %arg156 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_or_no_or_commute1_after := [llvm|
{
^0(%arg154 : i32, %arg155 : i32, %arg156 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg154, %0 : i32
  %2 = llvm.xor %arg155, %0 : i32
  %3 = llvm.or %arg156, %2 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_no_or_commute1_proof : not_and_and_or_no_or_commute1_before ⊑ not_and_and_or_no_or_commute1_after := by
  unfold not_and_and_or_no_or_commute1_before not_and_and_or_no_or_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_no_or_commute1
  apply not_and_and_or_no_or_commute1_thm
  ---END not_and_and_or_no_or_commute1



def not_and_and_or_no_or_commute2_before := [llvm|
{
^0(%arg151 : i32, %arg152 : i32, %arg153 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg152 : i32
  %3 = llvm.or %2, %arg151 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.xor %arg151, %1 : i32
  %6 = llvm.and %2, %5 : i32
  %7 = llvm.and %6, %arg153 : i32
  %8 = llvm.or %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def not_and_and_or_no_or_commute2_after := [llvm|
{
^0(%arg151 : i32, %arg152 : i32, %arg153 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg152 : i32
  %3 = llvm.xor %arg151, %1 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.or %arg153, %4 : i32
  %6 = llvm.and %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_no_or_commute2_proof : not_and_and_or_no_or_commute2_before ⊑ not_and_and_or_no_or_commute2_after := by
  unfold not_and_and_or_no_or_commute2_before not_and_and_or_no_or_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_no_or_commute2
  apply not_and_and_or_no_or_commute2_thm
  ---END not_and_and_or_no_or_commute2



def not_and_and_or_no_or_commute3_before := [llvm|
{
^0(%arg148 : i32, %arg149 : i32, %arg150 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg150 : i32
  %3 = llvm.or %arg149, %arg148 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.xor %arg148, %1 : i32
  %6 = llvm.and %5, %arg149 : i32
  %7 = llvm.and %2, %6 : i32
  %8 = llvm.or %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def not_and_and_or_no_or_commute3_after := [llvm|
{
^0(%arg148 : i32, %arg149 : i32, %arg150 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg150 : i32
  %3 = llvm.xor %arg148, %1 : i32
  %4 = llvm.xor %arg149, %1 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.and %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_and_and_or_no_or_commute3_proof : not_and_and_or_no_or_commute3_before ⊑ not_and_and_or_no_or_commute3_after := by
  unfold not_and_and_or_no_or_commute3_before not_and_and_or_no_or_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN not_and_and_or_no_or_commute3
  apply not_and_and_or_no_or_commute3_thm
  ---END not_and_and_or_no_or_commute3



def not_or_or_and_no_and_before := [llvm|
{
^0(%arg121 : i32, %arg122 : i32, %arg123 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg122, %arg121 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg121, %0 : i32
  %4 = llvm.or %3, %arg122 : i32
  %5 = llvm.or %4, %arg123 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_and_no_and_after := [llvm|
{
^0(%arg121 : i32, %arg122 : i32, %arg123 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg121, %0 : i32
  %2 = llvm.xor %arg122, %0 : i32
  %3 = llvm.and %arg123, %2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_no_and_proof : not_or_or_and_no_and_before ⊑ not_or_or_and_no_and_after := by
  unfold not_or_or_and_no_and_before not_or_or_and_no_and_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_no_and
  apply not_or_or_and_no_and_thm
  ---END not_or_or_and_no_and



def not_or_or_and_no_and_commute1_or_before := [llvm|
{
^0(%arg118 : i32, %arg119 : i32, %arg120 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg119, %arg118 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg118, %0 : i32
  %4 = llvm.or %arg120, %arg119 : i32
  %5 = llvm.or %4, %3 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_and_no_and_commute1_or_after := [llvm|
{
^0(%arg118 : i32, %arg119 : i32, %arg120 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg118, %0 : i32
  %2 = llvm.xor %arg119, %0 : i32
  %3 = llvm.and %arg120, %2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_no_and_commute1_or_proof : not_or_or_and_no_and_commute1_or_before ⊑ not_or_or_and_no_and_commute1_or_after := by
  unfold not_or_or_and_no_and_commute1_or_before not_or_or_and_no_and_commute1_or_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_no_and_commute1_or
  apply not_or_or_and_no_and_commute1_or_thm
  ---END not_or_or_and_no_and_commute1_or



def not_or_or_and_no_and_commute2_or_before := [llvm|
{
^0(%arg115 : i32, %arg116 : i32, %arg117 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg116, %arg115 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg115, %0 : i32
  %4 = llvm.or %3, %arg117 : i32
  %5 = llvm.or %4, %arg116 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_and_no_and_commute2_or_after := [llvm|
{
^0(%arg115 : i32, %arg116 : i32, %arg117 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg115, %0 : i32
  %2 = llvm.xor %arg116, %0 : i32
  %3 = llvm.and %arg117, %2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_no_and_commute2_or_proof : not_or_or_and_no_and_commute2_or_before ⊑ not_or_or_and_no_and_commute2_or_after := by
  unfold not_or_or_and_no_and_commute2_or_before not_or_or_and_no_and_commute2_or_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_no_and_commute2_or
  apply not_or_or_and_no_and_commute2_or_thm
  ---END not_or_or_and_no_and_commute2_or



def not_or_or_and_no_and_commute1_before := [llvm|
{
^0(%arg112 : i32, %arg113 : i32, %arg114 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg112, %arg113 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg112, %0 : i32
  %4 = llvm.or %3, %arg113 : i32
  %5 = llvm.or %4, %arg114 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_and_no_and_commute1_after := [llvm|
{
^0(%arg112 : i32, %arg113 : i32, %arg114 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg112, %0 : i32
  %2 = llvm.xor %arg113, %0 : i32
  %3 = llvm.and %arg114, %2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_no_and_commute1_proof : not_or_or_and_no_and_commute1_before ⊑ not_or_or_and_no_and_commute1_after := by
  unfold not_or_or_and_no_and_commute1_before not_or_or_and_no_and_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_no_and_commute1
  apply not_or_or_and_no_and_commute1_thm
  ---END not_or_or_and_no_and_commute1



def not_or_or_and_no_and_commute2_before := [llvm|
{
^0(%arg109 : i32, %arg110 : i32, %arg111 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg110 : i32
  %3 = llvm.and %2, %arg109 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.xor %arg109, %1 : i32
  %6 = llvm.or %2, %5 : i32
  %7 = llvm.or %6, %arg111 : i32
  %8 = llvm.and %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def not_or_or_and_no_and_commute2_after := [llvm|
{
^0(%arg109 : i32, %arg110 : i32, %arg111 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg110 : i32
  %3 = llvm.xor %arg109, %1 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.and %arg111, %4 : i32
  %6 = llvm.or %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_no_and_commute2_proof : not_or_or_and_no_and_commute2_before ⊑ not_or_or_and_no_and_commute2_after := by
  unfold not_or_or_and_no_and_commute2_before not_or_or_and_no_and_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_no_and_commute2
  apply not_or_or_and_no_and_commute2_thm
  ---END not_or_or_and_no_and_commute2



def not_or_or_and_no_and_commute3_before := [llvm|
{
^0(%arg106 : i32, %arg107 : i32, %arg108 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg108 : i32
  %3 = llvm.and %arg107, %arg106 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.xor %arg106, %1 : i32
  %6 = llvm.or %5, %arg107 : i32
  %7 = llvm.or %2, %6 : i32
  %8 = llvm.and %7, %4 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def not_or_or_and_no_and_commute3_after := [llvm|
{
^0(%arg106 : i32, %arg107 : i32, %arg108 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sdiv %0, %arg108 : i32
  %3 = llvm.xor %arg106, %1 : i32
  %4 = llvm.xor %arg107, %1 : i32
  %5 = llvm.and %2, %4 : i32
  %6 = llvm.or %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_or_and_no_and_commute3_proof : not_or_or_and_no_and_commute3_before ⊑ not_or_or_and_no_and_commute3_after := by
  unfold not_or_or_and_no_and_commute3_before not_or_or_and_no_and_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_or_and_no_and_commute3
  apply not_or_or_and_no_and_commute3_thm
  ---END not_or_or_and_no_and_commute3



def and_orn_xor_before := [llvm|
{
^0(%arg80 : i4, %arg81 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg80, %arg81 : i4
  %2 = llvm.xor %arg80, %0 : i4
  %3 = llvm.or %2, %arg81 : i4
  %4 = llvm.and %3, %1 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def and_orn_xor_after := [llvm|
{
^0(%arg80 : i4, %arg81 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg80, %0 : i4
  %2 = llvm.and %arg81, %1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_orn_xor_proof : and_orn_xor_before ⊑ and_orn_xor_after := by
  unfold and_orn_xor_before and_orn_xor_after
  simp_alive_peephole
  intros
  ---BEGIN and_orn_xor
  apply and_orn_xor_thm
  ---END and_orn_xor



def and_orn_xor_commute8_before := [llvm|
{
^0(%arg66 : i32, %arg67 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mul %arg66, %arg66 : i32
  %2 = llvm.mul %arg67, %arg67 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = llvm.xor %1, %0 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.and %3, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_orn_xor_commute8_after := [llvm|
{
^0(%arg66 : i32, %arg67 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mul %arg66, %arg66 : i32
  %2 = llvm.mul %arg67, %arg67 : i32
  %3 = llvm.xor %1, %0 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_orn_xor_commute8_proof : and_orn_xor_commute8_before ⊑ and_orn_xor_commute8_after := by
  unfold and_orn_xor_commute8_before and_orn_xor_commute8_after
  simp_alive_peephole
  intros
  ---BEGIN and_orn_xor_commute8
  apply and_orn_xor_commute8_thm
  ---END and_orn_xor_commute8



def and_zext_zext_before := [llvm|
{
^0(%arg58 : i8, %arg59 : i4):
  %0 = llvm.zext %arg58 : i8 to i16
  %1 = llvm.zext %arg59 : i4 to i16
  %2 = llvm.and %0, %1 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def and_zext_zext_after := [llvm|
{
^0(%arg58 : i8, %arg59 : i4):
  %0 = llvm.zext %arg59 : i4 to i8
  %1 = llvm.and %arg58, %0 : i8
  %2 = llvm.zext nneg %1 : i8 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_zext_zext_proof : and_zext_zext_before ⊑ and_zext_zext_after := by
  unfold and_zext_zext_before and_zext_zext_after
  simp_alive_peephole
  intros
  ---BEGIN and_zext_zext
  apply and_zext_zext_thm
  ---END and_zext_zext



def or_zext_zext_before := [llvm|
{
^0(%arg56 : i8, %arg57 : i4):
  %0 = llvm.zext %arg56 : i8 to i16
  %1 = llvm.zext %arg57 : i4 to i16
  %2 = llvm.or %1, %0 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def or_zext_zext_after := [llvm|
{
^0(%arg56 : i8, %arg57 : i4):
  %0 = llvm.zext %arg57 : i4 to i8
  %1 = llvm.or %arg56, %0 : i8
  %2 = llvm.zext %1 : i8 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_zext_zext_proof : or_zext_zext_before ⊑ or_zext_zext_after := by
  unfold or_zext_zext_before or_zext_zext_after
  simp_alive_peephole
  intros
  ---BEGIN or_zext_zext
  apply or_zext_zext_thm
  ---END or_zext_zext



def and_sext_sext_before := [llvm|
{
^0(%arg52 : i8, %arg53 : i4):
  %0 = llvm.sext %arg52 : i8 to i16
  %1 = llvm.sext %arg53 : i4 to i16
  %2 = llvm.and %1, %0 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def and_sext_sext_after := [llvm|
{
^0(%arg52 : i8, %arg53 : i4):
  %0 = llvm.sext %arg53 : i4 to i8
  %1 = llvm.and %arg52, %0 : i8
  %2 = llvm.sext %1 : i8 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_sext_sext_proof : and_sext_sext_before ⊑ and_sext_sext_after := by
  unfold and_sext_sext_before and_sext_sext_after
  simp_alive_peephole
  intros
  ---BEGIN and_sext_sext
  apply and_sext_sext_thm
  ---END and_sext_sext



def or_sext_sext_before := [llvm|
{
^0(%arg50 : i8, %arg51 : i4):
  %0 = llvm.sext %arg50 : i8 to i16
  %1 = llvm.sext %arg51 : i4 to i16
  %2 = llvm.or %0, %1 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def or_sext_sext_after := [llvm|
{
^0(%arg50 : i8, %arg51 : i4):
  %0 = llvm.sext %arg51 : i4 to i8
  %1 = llvm.or %arg50, %0 : i8
  %2 = llvm.sext %1 : i8 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_sext_sext_proof : or_sext_sext_before ⊑ or_sext_sext_after := by
  unfold or_sext_sext_before or_sext_sext_after
  simp_alive_peephole
  intros
  ---BEGIN or_sext_sext
  apply or_sext_sext_thm
  ---END or_sext_sext



def xor_sext_sext_before := [llvm|
{
^0(%arg48 : i8, %arg49 : i4):
  %0 = llvm.sext %arg48 : i8 to i16
  %1 = llvm.sext %arg49 : i4 to i16
  %2 = llvm.xor %0, %1 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def xor_sext_sext_after := [llvm|
{
^0(%arg48 : i8, %arg49 : i4):
  %0 = llvm.sext %arg49 : i4 to i8
  %1 = llvm.xor %arg48, %0 : i8
  %2 = llvm.sext %1 : i8 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_sext_sext_proof : xor_sext_sext_before ⊑ xor_sext_sext_after := by
  unfold xor_sext_sext_before xor_sext_sext_after
  simp_alive_peephole
  intros
  ---BEGIN xor_sext_sext
  apply xor_sext_sext_thm
  ---END xor_sext_sext



def PR56294_before := [llvm|
{
^0(%arg41 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.icmp "eq" %arg41, %0 : i8
  %4 = llvm.and %arg41, %1 : i8
  %5 = llvm.zext %3 : i1 to i32
  %6 = llvm.zext %4 : i8 to i32
  %7 = llvm.and %5, %6 : i32
  %8 = llvm.icmp "ne" %7, %2 : i32
  "llvm.return"(%8) : (i1) -> ()
}
]
def PR56294_after := [llvm|
{
^0(%arg41 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR56294_proof : PR56294_before ⊑ PR56294_after := by
  unfold PR56294_before PR56294_after
  simp_alive_peephole
  intros
  ---BEGIN PR56294
  apply PR56294_thm
  ---END PR56294



def canonicalize_logic_first_or0_before := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(112 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.add %arg40, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def canonicalize_logic_first_or0_after := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(112 : i32) : i32
  %2 = llvm.or %arg40, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem canonicalize_logic_first_or0_proof : canonicalize_logic_first_or0_before ⊑ canonicalize_logic_first_or0_after := by
  unfold canonicalize_logic_first_or0_before canonicalize_logic_first_or0_after
  simp_alive_peephole
  intros
  ---BEGIN canonicalize_logic_first_or0
  apply canonicalize_logic_first_or0_thm
  ---END canonicalize_logic_first_or0



def canonicalize_logic_first_or0_nsw_before := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(112 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.add %arg39, %0 overflow<nsw> : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def canonicalize_logic_first_or0_nsw_after := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(112 : i32) : i32
  %2 = llvm.or %arg39, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem canonicalize_logic_first_or0_nsw_proof : canonicalize_logic_first_or0_nsw_before ⊑ canonicalize_logic_first_or0_nsw_after := by
  unfold canonicalize_logic_first_or0_nsw_before canonicalize_logic_first_or0_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN canonicalize_logic_first_or0_nsw
  apply canonicalize_logic_first_or0_nsw_thm
  ---END canonicalize_logic_first_or0_nsw



def canonicalize_logic_first_or0_nswnuw_before := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(112 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.add %arg38, %0 overflow<nsw,nuw> : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def canonicalize_logic_first_or0_nswnuw_after := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(112 : i32) : i32
  %2 = llvm.or %arg38, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem canonicalize_logic_first_or0_nswnuw_proof : canonicalize_logic_first_or0_nswnuw_before ⊑ canonicalize_logic_first_or0_nswnuw_after := by
  unfold canonicalize_logic_first_or0_nswnuw_before canonicalize_logic_first_or0_nswnuw_after
  simp_alive_peephole
  intros
  ---BEGIN canonicalize_logic_first_or0_nswnuw
  apply canonicalize_logic_first_or0_nswnuw_thm
  ---END canonicalize_logic_first_or0_nswnuw



def canonicalize_logic_first_and0_before := [llvm|
{
^0(%arg28 : i8):
  %0 = llvm.mlir.constant(48 : i8) : i8
  %1 = llvm.mlir.constant(-10 : i8) : i8
  %2 = llvm.add %arg28, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_and0_after := [llvm|
{
^0(%arg28 : i8):
  %0 = llvm.mlir.constant(-10 : i8) : i8
  %1 = llvm.mlir.constant(48 : i8) : i8
  %2 = llvm.and %arg28, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem canonicalize_logic_first_and0_proof : canonicalize_logic_first_and0_before ⊑ canonicalize_logic_first_and0_after := by
  unfold canonicalize_logic_first_and0_before canonicalize_logic_first_and0_after
  simp_alive_peephole
  intros
  ---BEGIN canonicalize_logic_first_and0
  apply canonicalize_logic_first_and0_thm
  ---END canonicalize_logic_first_and0



def canonicalize_logic_first_and0_nsw_before := [llvm|
{
^0(%arg27 : i8):
  %0 = llvm.mlir.constant(48 : i8) : i8
  %1 = llvm.mlir.constant(-10 : i8) : i8
  %2 = llvm.add %arg27, %0 overflow<nsw> : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_and0_nsw_after := [llvm|
{
^0(%arg27 : i8):
  %0 = llvm.mlir.constant(-10 : i8) : i8
  %1 = llvm.mlir.constant(48 : i8) : i8
  %2 = llvm.and %arg27, %0 : i8
  %3 = llvm.add %2, %1 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem canonicalize_logic_first_and0_nsw_proof : canonicalize_logic_first_and0_nsw_before ⊑ canonicalize_logic_first_and0_nsw_after := by
  unfold canonicalize_logic_first_and0_nsw_before canonicalize_logic_first_and0_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN canonicalize_logic_first_and0_nsw
  apply canonicalize_logic_first_and0_nsw_thm
  ---END canonicalize_logic_first_and0_nsw



def canonicalize_logic_first_and0_nswnuw_before := [llvm|
{
^0(%arg26 : i8):
  %0 = llvm.mlir.constant(48 : i8) : i8
  %1 = llvm.mlir.constant(-10 : i8) : i8
  %2 = llvm.add %arg26, %0 overflow<nsw,nuw> : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_and0_nswnuw_after := [llvm|
{
^0(%arg26 : i8):
  %0 = llvm.mlir.constant(-10 : i8) : i8
  %1 = llvm.mlir.constant(48 : i8) : i8
  %2 = llvm.and %arg26, %0 : i8
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem canonicalize_logic_first_and0_nswnuw_proof : canonicalize_logic_first_and0_nswnuw_before ⊑ canonicalize_logic_first_and0_nswnuw_after := by
  unfold canonicalize_logic_first_and0_nswnuw_before canonicalize_logic_first_and0_nswnuw_after
  simp_alive_peephole
  intros
  ---BEGIN canonicalize_logic_first_and0_nswnuw
  apply canonicalize_logic_first_and0_nswnuw_thm
  ---END canonicalize_logic_first_and0_nswnuw



def canonicalize_logic_first_xor_0_before := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(96 : i8) : i8
  %1 = llvm.mlir.constant(31 : i8) : i8
  %2 = llvm.add %arg17, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_xor_0_after := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.mlir.constant(96 : i8) : i8
  %2 = llvm.xor %arg17, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem canonicalize_logic_first_xor_0_proof : canonicalize_logic_first_xor_0_before ⊑ canonicalize_logic_first_xor_0_after := by
  unfold canonicalize_logic_first_xor_0_before canonicalize_logic_first_xor_0_after
  simp_alive_peephole
  intros
  ---BEGIN canonicalize_logic_first_xor_0
  apply canonicalize_logic_first_xor_0_thm
  ---END canonicalize_logic_first_xor_0



def canonicalize_logic_first_xor_0_nsw_before := [llvm|
{
^0(%arg16 : i8):
  %0 = llvm.mlir.constant(96 : i8) : i8
  %1 = llvm.mlir.constant(31 : i8) : i8
  %2 = llvm.add %arg16, %0 overflow<nsw> : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_xor_0_nsw_after := [llvm|
{
^0(%arg16 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.mlir.constant(96 : i8) : i8
  %2 = llvm.xor %arg16, %0 : i8
  %3 = llvm.add %2, %1 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem canonicalize_logic_first_xor_0_nsw_proof : canonicalize_logic_first_xor_0_nsw_before ⊑ canonicalize_logic_first_xor_0_nsw_after := by
  unfold canonicalize_logic_first_xor_0_nsw_before canonicalize_logic_first_xor_0_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN canonicalize_logic_first_xor_0_nsw
  apply canonicalize_logic_first_xor_0_nsw_thm
  ---END canonicalize_logic_first_xor_0_nsw



def canonicalize_logic_first_xor_0_nswnuw_before := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(96 : i8) : i8
  %1 = llvm.mlir.constant(31 : i8) : i8
  %2 = llvm.add %arg15, %0 overflow<nsw,nuw> : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_xor_0_nswnuw_after := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.mlir.constant(96 : i8) : i8
  %2 = llvm.xor %arg15, %0 : i8
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem canonicalize_logic_first_xor_0_nswnuw_proof : canonicalize_logic_first_xor_0_nswnuw_before ⊑ canonicalize_logic_first_xor_0_nswnuw_after := by
  unfold canonicalize_logic_first_xor_0_nswnuw_before canonicalize_logic_first_xor_0_nswnuw_after
  simp_alive_peephole
  intros
  ---BEGIN canonicalize_logic_first_xor_0_nswnuw
  apply canonicalize_logic_first_xor_0_nswnuw_thm
  ---END canonicalize_logic_first_xor_0_nswnuw



def test_and_xor_freely_invertable_before := [llvm|
{
^0(%arg3 : i32, %arg4 : i32, %arg5 : i1):
  %0 = llvm.icmp "sgt" %arg3, %arg4 : i32
  %1 = llvm.xor %0, %arg5 : i1
  %2 = llvm.and %1, %arg5 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_and_xor_freely_invertable_after := [llvm|
{
^0(%arg3 : i32, %arg4 : i32, %arg5 : i1):
  %0 = llvm.icmp "sle" %arg3, %arg4 : i32
  %1 = llvm.and %0, %arg5 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_and_xor_freely_invertable_proof : test_and_xor_freely_invertable_before ⊑ test_and_xor_freely_invertable_after := by
  unfold test_and_xor_freely_invertable_before test_and_xor_freely_invertable_after
  simp_alive_peephole
  intros
  ---BEGIN test_and_xor_freely_invertable
  apply test_and_xor_freely_invertable_thm
  ---END test_and_xor_freely_invertable


