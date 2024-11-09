import SSA.Projects.InstCombine.tests.proofs.gicmphshr_proof
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
section gicmphshr_statements

def lshr_eq_msb_low_last_zero_before := [llvm|
{
^0(%arg177 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.lshr %0, %arg177 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshr_eq_msb_low_last_zero_after := [llvm|
{
^0(%arg177 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.icmp "ugt" %arg177, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_eq_msb_low_last_zero_proof : lshr_eq_msb_low_last_zero_before ⊑ lshr_eq_msb_low_last_zero_after := by
  unfold lshr_eq_msb_low_last_zero_before lshr_eq_msb_low_last_zero_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_eq_msb_low_last_zero
  apply lshr_eq_msb_low_last_zero_thm
  ---END lshr_eq_msb_low_last_zero



def ashr_eq_msb_low_second_zero_before := [llvm|
{
^0(%arg175 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.ashr %0, %arg175 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_eq_msb_low_second_zero_after := [llvm|
{
^0(%arg175 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.icmp "ugt" %arg175, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_eq_msb_low_second_zero_proof : ashr_eq_msb_low_second_zero_before ⊑ ashr_eq_msb_low_second_zero_after := by
  unfold ashr_eq_msb_low_second_zero_before ashr_eq_msb_low_second_zero_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_eq_msb_low_second_zero
  apply ashr_eq_msb_low_second_zero_thm
  ---END ashr_eq_msb_low_second_zero



def lshr_ne_msb_low_last_zero_before := [llvm|
{
^0(%arg174 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.lshr %0, %arg174 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshr_ne_msb_low_last_zero_after := [llvm|
{
^0(%arg174 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.icmp "ult" %arg174, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_ne_msb_low_last_zero_proof : lshr_ne_msb_low_last_zero_before ⊑ lshr_ne_msb_low_last_zero_after := by
  unfold lshr_ne_msb_low_last_zero_before lshr_ne_msb_low_last_zero_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_ne_msb_low_last_zero
  apply lshr_ne_msb_low_last_zero_thm
  ---END lshr_ne_msb_low_last_zero



def ashr_ne_msb_low_second_zero_before := [llvm|
{
^0(%arg173 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.ashr %0, %arg173 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ne_msb_low_second_zero_after := [llvm|
{
^0(%arg173 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.icmp "ult" %arg173, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ne_msb_low_second_zero_proof : ashr_ne_msb_low_second_zero_before ⊑ ashr_ne_msb_low_second_zero_after := by
  unfold ashr_ne_msb_low_second_zero_before ashr_ne_msb_low_second_zero_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ne_msb_low_second_zero
  apply ashr_ne_msb_low_second_zero_thm
  ---END ashr_ne_msb_low_second_zero



def ashr_eq_both_equal_before := [llvm|
{
^0(%arg172 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.ashr %0, %arg172 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashr_eq_both_equal_after := [llvm|
{
^0(%arg172 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg172, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_eq_both_equal_proof : ashr_eq_both_equal_before ⊑ ashr_eq_both_equal_after := by
  unfold ashr_eq_both_equal_before ashr_eq_both_equal_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_eq_both_equal
  apply ashr_eq_both_equal_thm
  ---END ashr_eq_both_equal



def ashr_ne_both_equal_before := [llvm|
{
^0(%arg171 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.ashr %0, %arg171 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashr_ne_both_equal_after := [llvm|
{
^0(%arg171 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg171, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ne_both_equal_proof : ashr_ne_both_equal_before ⊑ ashr_ne_both_equal_after := by
  unfold ashr_ne_both_equal_before ashr_ne_both_equal_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ne_both_equal
  apply ashr_ne_both_equal_thm
  ---END ashr_ne_both_equal



def lshr_eq_both_equal_before := [llvm|
{
^0(%arg170 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.lshr %0, %arg170 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshr_eq_both_equal_after := [llvm|
{
^0(%arg170 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg170, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_eq_both_equal_proof : lshr_eq_both_equal_before ⊑ lshr_eq_both_equal_after := by
  unfold lshr_eq_both_equal_before lshr_eq_both_equal_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_eq_both_equal
  apply lshr_eq_both_equal_thm
  ---END lshr_eq_both_equal



def lshr_ne_both_equal_before := [llvm|
{
^0(%arg169 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.lshr %0, %arg169 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshr_ne_both_equal_after := [llvm|
{
^0(%arg169 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg169, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_ne_both_equal_proof : lshr_ne_both_equal_before ⊑ lshr_ne_both_equal_after := by
  unfold lshr_ne_both_equal_before lshr_ne_both_equal_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_ne_both_equal
  apply lshr_ne_both_equal_thm
  ---END lshr_ne_both_equal



def exact_ashr_eq_both_equal_before := [llvm|
{
^0(%arg168 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.ashr exact %0, %arg168 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def exact_ashr_eq_both_equal_after := [llvm|
{
^0(%arg168 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg168, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_ashr_eq_both_equal_proof : exact_ashr_eq_both_equal_before ⊑ exact_ashr_eq_both_equal_after := by
  unfold exact_ashr_eq_both_equal_before exact_ashr_eq_both_equal_after
  simp_alive_peephole
  intros
  ---BEGIN exact_ashr_eq_both_equal
  apply exact_ashr_eq_both_equal_thm
  ---END exact_ashr_eq_both_equal



def exact_ashr_ne_both_equal_before := [llvm|
{
^0(%arg167 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.ashr exact %0, %arg167 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def exact_ashr_ne_both_equal_after := [llvm|
{
^0(%arg167 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg167, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_ashr_ne_both_equal_proof : exact_ashr_ne_both_equal_before ⊑ exact_ashr_ne_both_equal_after := by
  unfold exact_ashr_ne_both_equal_before exact_ashr_ne_both_equal_after
  simp_alive_peephole
  intros
  ---BEGIN exact_ashr_ne_both_equal
  apply exact_ashr_ne_both_equal_thm
  ---END exact_ashr_ne_both_equal



def exact_lshr_eq_both_equal_before := [llvm|
{
^0(%arg166 : i8):
  %0 = llvm.mlir.constant(126 : i8) : i8
  %1 = llvm.lshr exact %0, %arg166 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def exact_lshr_eq_both_equal_after := [llvm|
{
^0(%arg166 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg166, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_lshr_eq_both_equal_proof : exact_lshr_eq_both_equal_before ⊑ exact_lshr_eq_both_equal_after := by
  unfold exact_lshr_eq_both_equal_before exact_lshr_eq_both_equal_after
  simp_alive_peephole
  intros
  ---BEGIN exact_lshr_eq_both_equal
  apply exact_lshr_eq_both_equal_thm
  ---END exact_lshr_eq_both_equal



def exact_lshr_ne_both_equal_before := [llvm|
{
^0(%arg165 : i8):
  %0 = llvm.mlir.constant(126 : i8) : i8
  %1 = llvm.lshr exact %0, %arg165 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def exact_lshr_ne_both_equal_after := [llvm|
{
^0(%arg165 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg165, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_lshr_ne_both_equal_proof : exact_lshr_ne_both_equal_before ⊑ exact_lshr_ne_both_equal_after := by
  unfold exact_lshr_ne_both_equal_before exact_lshr_ne_both_equal_after
  simp_alive_peephole
  intros
  ---BEGIN exact_lshr_ne_both_equal
  apply exact_lshr_ne_both_equal_thm
  ---END exact_lshr_ne_both_equal



def exact_lshr_eq_opposite_msb_before := [llvm|
{
^0(%arg164 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.lshr exact %0, %arg164 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_lshr_eq_opposite_msb_after := [llvm|
{
^0(%arg164 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.icmp "eq" %arg164, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_lshr_eq_opposite_msb_proof : exact_lshr_eq_opposite_msb_before ⊑ exact_lshr_eq_opposite_msb_after := by
  unfold exact_lshr_eq_opposite_msb_before exact_lshr_eq_opposite_msb_after
  simp_alive_peephole
  intros
  ---BEGIN exact_lshr_eq_opposite_msb
  apply exact_lshr_eq_opposite_msb_thm
  ---END exact_lshr_eq_opposite_msb



def lshr_eq_opposite_msb_before := [llvm|
{
^0(%arg163 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.lshr %0, %arg163 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshr_eq_opposite_msb_after := [llvm|
{
^0(%arg163 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.icmp "eq" %arg163, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_eq_opposite_msb_proof : lshr_eq_opposite_msb_before ⊑ lshr_eq_opposite_msb_after := by
  unfold lshr_eq_opposite_msb_before lshr_eq_opposite_msb_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_eq_opposite_msb
  apply lshr_eq_opposite_msb_thm
  ---END lshr_eq_opposite_msb



def exact_lshr_ne_opposite_msb_before := [llvm|
{
^0(%arg162 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.lshr exact %0, %arg162 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_lshr_ne_opposite_msb_after := [llvm|
{
^0(%arg162 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.icmp "ne" %arg162, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_lshr_ne_opposite_msb_proof : exact_lshr_ne_opposite_msb_before ⊑ exact_lshr_ne_opposite_msb_after := by
  unfold exact_lshr_ne_opposite_msb_before exact_lshr_ne_opposite_msb_after
  simp_alive_peephole
  intros
  ---BEGIN exact_lshr_ne_opposite_msb
  apply exact_lshr_ne_opposite_msb_thm
  ---END exact_lshr_ne_opposite_msb



def lshr_ne_opposite_msb_before := [llvm|
{
^0(%arg161 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.lshr %0, %arg161 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshr_ne_opposite_msb_after := [llvm|
{
^0(%arg161 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.icmp "ne" %arg161, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_ne_opposite_msb_proof : lshr_ne_opposite_msb_before ⊑ lshr_ne_opposite_msb_after := by
  unfold lshr_ne_opposite_msb_before lshr_ne_opposite_msb_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_ne_opposite_msb
  apply lshr_ne_opposite_msb_thm
  ---END lshr_ne_opposite_msb



def exact_ashr_eq_before := [llvm|
{
^0(%arg160 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr exact %0, %arg160 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_ashr_eq_after := [llvm|
{
^0(%arg160 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.icmp "eq" %arg160, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_ashr_eq_proof : exact_ashr_eq_before ⊑ exact_ashr_eq_after := by
  unfold exact_ashr_eq_before exact_ashr_eq_after
  simp_alive_peephole
  intros
  ---BEGIN exact_ashr_eq
  apply exact_ashr_eq_thm
  ---END exact_ashr_eq



def exact_ashr_ne_before := [llvm|
{
^0(%arg159 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr exact %0, %arg159 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_ashr_ne_after := [llvm|
{
^0(%arg159 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.icmp "ne" %arg159, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_ashr_ne_proof : exact_ashr_ne_before ⊑ exact_ashr_ne_after := by
  unfold exact_ashr_ne_before exact_ashr_ne_after
  simp_alive_peephole
  intros
  ---BEGIN exact_ashr_ne
  apply exact_ashr_ne_thm
  ---END exact_ashr_ne



def exact_lshr_eq_before := [llvm|
{
^0(%arg158 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.lshr exact %0, %arg158 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_lshr_eq_after := [llvm|
{
^0(%arg158 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.icmp "eq" %arg158, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_lshr_eq_proof : exact_lshr_eq_before ⊑ exact_lshr_eq_after := by
  unfold exact_lshr_eq_before exact_lshr_eq_after
  simp_alive_peephole
  intros
  ---BEGIN exact_lshr_eq
  apply exact_lshr_eq_thm
  ---END exact_lshr_eq



def exact_lshr_ne_before := [llvm|
{
^0(%arg157 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.lshr exact %0, %arg157 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_lshr_ne_after := [llvm|
{
^0(%arg157 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.icmp "ne" %arg157, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_lshr_ne_proof : exact_lshr_ne_before ⊑ exact_lshr_ne_after := by
  unfold exact_lshr_ne_before exact_lshr_ne_after
  simp_alive_peephole
  intros
  ---BEGIN exact_lshr_ne
  apply exact_lshr_ne_thm
  ---END exact_lshr_ne



def nonexact_ashr_eq_before := [llvm|
{
^0(%arg156 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr %0, %arg156 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_ashr_eq_after := [llvm|
{
^0(%arg156 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.icmp "eq" %arg156, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_ashr_eq_proof : nonexact_ashr_eq_before ⊑ nonexact_ashr_eq_after := by
  unfold nonexact_ashr_eq_before nonexact_ashr_eq_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_ashr_eq
  apply nonexact_ashr_eq_thm
  ---END nonexact_ashr_eq



def nonexact_ashr_ne_before := [llvm|
{
^0(%arg155 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr %0, %arg155 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_ashr_ne_after := [llvm|
{
^0(%arg155 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.icmp "ne" %arg155, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_ashr_ne_proof : nonexact_ashr_ne_before ⊑ nonexact_ashr_ne_after := by
  unfold nonexact_ashr_ne_before nonexact_ashr_ne_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_ashr_ne
  apply nonexact_ashr_ne_thm
  ---END nonexact_ashr_ne



def nonexact_lshr_eq_before := [llvm|
{
^0(%arg154 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.lshr %0, %arg154 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_lshr_eq_after := [llvm|
{
^0(%arg154 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.icmp "eq" %arg154, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_lshr_eq_proof : nonexact_lshr_eq_before ⊑ nonexact_lshr_eq_after := by
  unfold nonexact_lshr_eq_before nonexact_lshr_eq_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_lshr_eq
  apply nonexact_lshr_eq_thm
  ---END nonexact_lshr_eq



def nonexact_lshr_ne_before := [llvm|
{
^0(%arg153 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.lshr %0, %arg153 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_lshr_ne_after := [llvm|
{
^0(%arg153 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.icmp "ne" %arg153, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_lshr_ne_proof : nonexact_lshr_ne_before ⊑ nonexact_lshr_ne_after := by
  unfold nonexact_lshr_ne_before nonexact_lshr_ne_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_lshr_ne
  apply nonexact_lshr_ne_thm
  ---END nonexact_lshr_ne



def exact_lshr_eq_exactdiv_before := [llvm|
{
^0(%arg152 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.lshr exact %0, %arg152 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_lshr_eq_exactdiv_after := [llvm|
{
^0(%arg152 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "eq" %arg152, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_lshr_eq_exactdiv_proof : exact_lshr_eq_exactdiv_before ⊑ exact_lshr_eq_exactdiv_after := by
  unfold exact_lshr_eq_exactdiv_before exact_lshr_eq_exactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN exact_lshr_eq_exactdiv
  apply exact_lshr_eq_exactdiv_thm
  ---END exact_lshr_eq_exactdiv



def exact_lshr_ne_exactdiv_before := [llvm|
{
^0(%arg151 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.lshr exact %0, %arg151 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_lshr_ne_exactdiv_after := [llvm|
{
^0(%arg151 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "ne" %arg151, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_lshr_ne_exactdiv_proof : exact_lshr_ne_exactdiv_before ⊑ exact_lshr_ne_exactdiv_after := by
  unfold exact_lshr_ne_exactdiv_before exact_lshr_ne_exactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN exact_lshr_ne_exactdiv
  apply exact_lshr_ne_exactdiv_thm
  ---END exact_lshr_ne_exactdiv



def nonexact_lshr_eq_exactdiv_before := [llvm|
{
^0(%arg150 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.lshr %0, %arg150 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_lshr_eq_exactdiv_after := [llvm|
{
^0(%arg150 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "eq" %arg150, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_lshr_eq_exactdiv_proof : nonexact_lshr_eq_exactdiv_before ⊑ nonexact_lshr_eq_exactdiv_after := by
  unfold nonexact_lshr_eq_exactdiv_before nonexact_lshr_eq_exactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_lshr_eq_exactdiv
  apply nonexact_lshr_eq_exactdiv_thm
  ---END nonexact_lshr_eq_exactdiv



def nonexact_lshr_ne_exactdiv_before := [llvm|
{
^0(%arg149 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.lshr %0, %arg149 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_lshr_ne_exactdiv_after := [llvm|
{
^0(%arg149 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "ne" %arg149, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_lshr_ne_exactdiv_proof : nonexact_lshr_ne_exactdiv_before ⊑ nonexact_lshr_ne_exactdiv_after := by
  unfold nonexact_lshr_ne_exactdiv_before nonexact_lshr_ne_exactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_lshr_ne_exactdiv
  apply nonexact_lshr_ne_exactdiv_thm
  ---END nonexact_lshr_ne_exactdiv



def exact_ashr_eq_exactdiv_before := [llvm|
{
^0(%arg148 : i8):
  %0 = llvm.mlir.constant(-80 : i8) : i8
  %1 = llvm.mlir.constant(-5 : i8) : i8
  %2 = llvm.ashr exact %0, %arg148 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_ashr_eq_exactdiv_after := [llvm|
{
^0(%arg148 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "eq" %arg148, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_ashr_eq_exactdiv_proof : exact_ashr_eq_exactdiv_before ⊑ exact_ashr_eq_exactdiv_after := by
  unfold exact_ashr_eq_exactdiv_before exact_ashr_eq_exactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN exact_ashr_eq_exactdiv
  apply exact_ashr_eq_exactdiv_thm
  ---END exact_ashr_eq_exactdiv



def exact_ashr_ne_exactdiv_before := [llvm|
{
^0(%arg147 : i8):
  %0 = llvm.mlir.constant(-80 : i8) : i8
  %1 = llvm.mlir.constant(-5 : i8) : i8
  %2 = llvm.ashr exact %0, %arg147 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_ashr_ne_exactdiv_after := [llvm|
{
^0(%arg147 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "ne" %arg147, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_ashr_ne_exactdiv_proof : exact_ashr_ne_exactdiv_before ⊑ exact_ashr_ne_exactdiv_after := by
  unfold exact_ashr_ne_exactdiv_before exact_ashr_ne_exactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN exact_ashr_ne_exactdiv
  apply exact_ashr_ne_exactdiv_thm
  ---END exact_ashr_ne_exactdiv



def nonexact_ashr_eq_exactdiv_before := [llvm|
{
^0(%arg146 : i8):
  %0 = llvm.mlir.constant(-80 : i8) : i8
  %1 = llvm.mlir.constant(-5 : i8) : i8
  %2 = llvm.ashr %0, %arg146 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_ashr_eq_exactdiv_after := [llvm|
{
^0(%arg146 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "eq" %arg146, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_ashr_eq_exactdiv_proof : nonexact_ashr_eq_exactdiv_before ⊑ nonexact_ashr_eq_exactdiv_after := by
  unfold nonexact_ashr_eq_exactdiv_before nonexact_ashr_eq_exactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_ashr_eq_exactdiv
  apply nonexact_ashr_eq_exactdiv_thm
  ---END nonexact_ashr_eq_exactdiv



def nonexact_ashr_ne_exactdiv_before := [llvm|
{
^0(%arg145 : i8):
  %0 = llvm.mlir.constant(-80 : i8) : i8
  %1 = llvm.mlir.constant(-5 : i8) : i8
  %2 = llvm.ashr %0, %arg145 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_ashr_ne_exactdiv_after := [llvm|
{
^0(%arg145 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.icmp "ne" %arg145, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_ashr_ne_exactdiv_proof : nonexact_ashr_ne_exactdiv_before ⊑ nonexact_ashr_ne_exactdiv_after := by
  unfold nonexact_ashr_ne_exactdiv_before nonexact_ashr_ne_exactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_ashr_ne_exactdiv
  apply nonexact_ashr_ne_exactdiv_thm
  ---END nonexact_ashr_ne_exactdiv



def exact_lshr_eq_noexactdiv_before := [llvm|
{
^0(%arg144 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.mlir.constant(31 : i8) : i8
  %2 = llvm.lshr exact %0, %arg144 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_lshr_eq_noexactdiv_after := [llvm|
{
^0(%arg144 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_lshr_eq_noexactdiv_proof : exact_lshr_eq_noexactdiv_before ⊑ exact_lshr_eq_noexactdiv_after := by
  unfold exact_lshr_eq_noexactdiv_before exact_lshr_eq_noexactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN exact_lshr_eq_noexactdiv
  apply exact_lshr_eq_noexactdiv_thm
  ---END exact_lshr_eq_noexactdiv



def exact_lshr_ne_noexactdiv_before := [llvm|
{
^0(%arg143 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.mlir.constant(31 : i8) : i8
  %2 = llvm.lshr exact %0, %arg143 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_lshr_ne_noexactdiv_after := [llvm|
{
^0(%arg143 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_lshr_ne_noexactdiv_proof : exact_lshr_ne_noexactdiv_before ⊑ exact_lshr_ne_noexactdiv_after := by
  unfold exact_lshr_ne_noexactdiv_before exact_lshr_ne_noexactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN exact_lshr_ne_noexactdiv
  apply exact_lshr_ne_noexactdiv_thm
  ---END exact_lshr_ne_noexactdiv



def nonexact_lshr_eq_noexactdiv_before := [llvm|
{
^0(%arg142 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.mlir.constant(31 : i8) : i8
  %2 = llvm.lshr %0, %arg142 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_lshr_eq_noexactdiv_after := [llvm|
{
^0(%arg142 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_lshr_eq_noexactdiv_proof : nonexact_lshr_eq_noexactdiv_before ⊑ nonexact_lshr_eq_noexactdiv_after := by
  unfold nonexact_lshr_eq_noexactdiv_before nonexact_lshr_eq_noexactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_lshr_eq_noexactdiv
  apply nonexact_lshr_eq_noexactdiv_thm
  ---END nonexact_lshr_eq_noexactdiv



def nonexact_lshr_ne_noexactdiv_before := [llvm|
{
^0(%arg141 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.mlir.constant(31 : i8) : i8
  %2 = llvm.lshr %0, %arg141 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_lshr_ne_noexactdiv_after := [llvm|
{
^0(%arg141 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_lshr_ne_noexactdiv_proof : nonexact_lshr_ne_noexactdiv_before ⊑ nonexact_lshr_ne_noexactdiv_after := by
  unfold nonexact_lshr_ne_noexactdiv_before nonexact_lshr_ne_noexactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_lshr_ne_noexactdiv
  apply nonexact_lshr_ne_noexactdiv_thm
  ---END nonexact_lshr_ne_noexactdiv



def exact_ashr_eq_noexactdiv_before := [llvm|
{
^0(%arg140 : i8):
  %0 = llvm.mlir.constant(-80 : i8) : i8
  %1 = llvm.mlir.constant(-31 : i8) : i8
  %2 = llvm.ashr exact %0, %arg140 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_ashr_eq_noexactdiv_after := [llvm|
{
^0(%arg140 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_ashr_eq_noexactdiv_proof : exact_ashr_eq_noexactdiv_before ⊑ exact_ashr_eq_noexactdiv_after := by
  unfold exact_ashr_eq_noexactdiv_before exact_ashr_eq_noexactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN exact_ashr_eq_noexactdiv
  apply exact_ashr_eq_noexactdiv_thm
  ---END exact_ashr_eq_noexactdiv



def exact_ashr_ne_noexactdiv_before := [llvm|
{
^0(%arg139 : i8):
  %0 = llvm.mlir.constant(-80 : i8) : i8
  %1 = llvm.mlir.constant(-31 : i8) : i8
  %2 = llvm.ashr exact %0, %arg139 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def exact_ashr_ne_noexactdiv_after := [llvm|
{
^0(%arg139 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exact_ashr_ne_noexactdiv_proof : exact_ashr_ne_noexactdiv_before ⊑ exact_ashr_ne_noexactdiv_after := by
  unfold exact_ashr_ne_noexactdiv_before exact_ashr_ne_noexactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN exact_ashr_ne_noexactdiv
  apply exact_ashr_ne_noexactdiv_thm
  ---END exact_ashr_ne_noexactdiv



def nonexact_ashr_eq_noexactdiv_before := [llvm|
{
^0(%arg138 : i8):
  %0 = llvm.mlir.constant(-80 : i8) : i8
  %1 = llvm.mlir.constant(-31 : i8) : i8
  %2 = llvm.ashr %0, %arg138 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_ashr_eq_noexactdiv_after := [llvm|
{
^0(%arg138 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_ashr_eq_noexactdiv_proof : nonexact_ashr_eq_noexactdiv_before ⊑ nonexact_ashr_eq_noexactdiv_after := by
  unfold nonexact_ashr_eq_noexactdiv_before nonexact_ashr_eq_noexactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_ashr_eq_noexactdiv
  apply nonexact_ashr_eq_noexactdiv_thm
  ---END nonexact_ashr_eq_noexactdiv



def nonexact_ashr_ne_noexactdiv_before := [llvm|
{
^0(%arg137 : i8):
  %0 = llvm.mlir.constant(-80 : i8) : i8
  %1 = llvm.mlir.constant(-31 : i8) : i8
  %2 = llvm.ashr %0, %arg137 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_ashr_ne_noexactdiv_after := [llvm|
{
^0(%arg137 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_ashr_ne_noexactdiv_proof : nonexact_ashr_ne_noexactdiv_before ⊑ nonexact_ashr_ne_noexactdiv_after := by
  unfold nonexact_ashr_ne_noexactdiv_before nonexact_ashr_ne_noexactdiv_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_ashr_ne_noexactdiv
  apply nonexact_ashr_ne_noexactdiv_thm
  ---END nonexact_ashr_ne_noexactdiv



def nonexact_lshr_eq_noexactlog_before := [llvm|
{
^0(%arg136 : i8):
  %0 = llvm.mlir.constant(90 : i8) : i8
  %1 = llvm.mlir.constant(30 : i8) : i8
  %2 = llvm.lshr %0, %arg136 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_lshr_eq_noexactlog_after := [llvm|
{
^0(%arg136 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_lshr_eq_noexactlog_proof : nonexact_lshr_eq_noexactlog_before ⊑ nonexact_lshr_eq_noexactlog_after := by
  unfold nonexact_lshr_eq_noexactlog_before nonexact_lshr_eq_noexactlog_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_lshr_eq_noexactlog
  apply nonexact_lshr_eq_noexactlog_thm
  ---END nonexact_lshr_eq_noexactlog



def nonexact_lshr_ne_noexactlog_before := [llvm|
{
^0(%arg135 : i8):
  %0 = llvm.mlir.constant(90 : i8) : i8
  %1 = llvm.mlir.constant(30 : i8) : i8
  %2 = llvm.lshr %0, %arg135 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_lshr_ne_noexactlog_after := [llvm|
{
^0(%arg135 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_lshr_ne_noexactlog_proof : nonexact_lshr_ne_noexactlog_before ⊑ nonexact_lshr_ne_noexactlog_after := by
  unfold nonexact_lshr_ne_noexactlog_before nonexact_lshr_ne_noexactlog_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_lshr_ne_noexactlog
  apply nonexact_lshr_ne_noexactlog_thm
  ---END nonexact_lshr_ne_noexactlog



def nonexact_ashr_eq_noexactlog_before := [llvm|
{
^0(%arg134 : i8):
  %0 = llvm.mlir.constant(-90 : i8) : i8
  %1 = llvm.mlir.constant(-30 : i8) : i8
  %2 = llvm.ashr %0, %arg134 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_ashr_eq_noexactlog_after := [llvm|
{
^0(%arg134 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_ashr_eq_noexactlog_proof : nonexact_ashr_eq_noexactlog_before ⊑ nonexact_ashr_eq_noexactlog_after := by
  unfold nonexact_ashr_eq_noexactlog_before nonexact_ashr_eq_noexactlog_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_ashr_eq_noexactlog
  apply nonexact_ashr_eq_noexactlog_thm
  ---END nonexact_ashr_eq_noexactlog



def nonexact_ashr_ne_noexactlog_before := [llvm|
{
^0(%arg133 : i8):
  %0 = llvm.mlir.constant(-90 : i8) : i8
  %1 = llvm.mlir.constant(-30 : i8) : i8
  %2 = llvm.ashr %0, %arg133 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def nonexact_ashr_ne_noexactlog_after := [llvm|
{
^0(%arg133 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nonexact_ashr_ne_noexactlog_proof : nonexact_ashr_ne_noexactlog_before ⊑ nonexact_ashr_ne_noexactlog_after := by
  unfold nonexact_ashr_ne_noexactlog_before nonexact_ashr_ne_noexactlog_after
  simp_alive_peephole
  intros
  ---BEGIN nonexact_ashr_ne_noexactlog
  apply nonexact_ashr_ne_noexactlog_thm
  ---END nonexact_ashr_ne_noexactlog



def PR20945_before := [llvm|
{
^0(%arg132 : i32):
  %0 = llvm.mlir.constant(-9 : i32) : i32
  %1 = llvm.mlir.constant(-5 : i32) : i32
  %2 = llvm.ashr %0, %arg132 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def PR20945_after := [llvm|
{
^0(%arg132 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ne" %arg132, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR20945_proof : PR20945_before ⊑ PR20945_after := by
  unfold PR20945_before PR20945_after
  simp_alive_peephole
  intros
  ---BEGIN PR20945
  apply PR20945_thm
  ---END PR20945



def PR21222_before := [llvm|
{
^0(%arg131 : i32):
  %0 = llvm.mlir.constant(-93 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.ashr %0, %arg131 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def PR21222_after := [llvm|
{
^0(%arg131 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.icmp "eq" %arg131, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR21222_proof : PR21222_before ⊑ PR21222_after := by
  unfold PR21222_before PR21222_after
  simp_alive_peephole
  intros
  ---BEGIN PR21222
  apply PR21222_thm
  ---END PR21222



def PR24873_before := [llvm|
{
^0(%arg130 : i64):
  %0 = llvm.mlir.constant(-4611686018427387904) : i64
  %1 = llvm.mlir.constant(-1) : i64
  %2 = llvm.ashr %0, %arg130 : i64
  %3 = llvm.icmp "eq" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def PR24873_after := [llvm|
{
^0(%arg130 : i64):
  %0 = llvm.mlir.constant(61) : i64
  %1 = llvm.icmp "ugt" %arg130, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR24873_proof : PR24873_before ⊑ PR24873_after := by
  unfold PR24873_before PR24873_after
  simp_alive_peephole
  intros
  ---BEGIN PR24873
  apply PR24873_thm
  ---END PR24873



def ashr_exact_eq_0_before := [llvm|
{
^0(%arg127 : i32, %arg128 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.ashr exact %arg127, %arg128 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashr_exact_eq_0_after := [llvm|
{
^0(%arg127 : i32, %arg128 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg127, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_exact_eq_0_proof : ashr_exact_eq_0_before ⊑ ashr_exact_eq_0_after := by
  unfold ashr_exact_eq_0_before ashr_exact_eq_0_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_exact_eq_0
  apply ashr_exact_eq_0_thm
  ---END ashr_exact_eq_0



def lshr_exact_ne_0_before := [llvm|
{
^0(%arg121 : i32, %arg122 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.lshr exact %arg121, %arg122 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshr_exact_ne_0_after := [llvm|
{
^0(%arg121 : i32, %arg122 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg121, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_exact_ne_0_proof : lshr_exact_ne_0_before ⊑ lshr_exact_ne_0_after := by
  unfold lshr_exact_ne_0_before lshr_exact_ne_0_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_exact_ne_0
  apply lshr_exact_ne_0_thm
  ---END lshr_exact_ne_0



def ashr_ugt_0_before := [llvm|
{
^0(%arg116 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr %arg116, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_0_after := [llvm|
{
^0(%arg116 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.icmp "ugt" %arg116, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_0_proof : ashr_ugt_0_before ⊑ ashr_ugt_0_after := by
  unfold ashr_ugt_0_before ashr_ugt_0_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_0
  apply ashr_ugt_0_thm
  ---END ashr_ugt_0



def ashr_ugt_1_before := [llvm|
{
^0(%arg113 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.ashr %arg113, %0 : i4
  %2 = llvm.icmp "ugt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashr_ugt_1_after := [llvm|
{
^0(%arg113 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.icmp "ugt" %arg113, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_1_proof : ashr_ugt_1_before ⊑ ashr_ugt_1_after := by
  unfold ashr_ugt_1_before ashr_ugt_1_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_1
  apply ashr_ugt_1_thm
  ---END ashr_ugt_1



def ashr_ugt_2_before := [llvm|
{
^0(%arg112 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.ashr %arg112, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_2_after := [llvm|
{
^0(%arg112 : i4):
  %0 = llvm.mlir.constant(5 : i4) : i4
  %1 = llvm.icmp "ugt" %arg112, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_2_proof : ashr_ugt_2_before ⊑ ashr_ugt_2_after := by
  unfold ashr_ugt_2_before ashr_ugt_2_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_2
  apply ashr_ugt_2_thm
  ---END ashr_ugt_2



def ashr_ugt_3_before := [llvm|
{
^0(%arg111 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.ashr %arg111, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_3_after := [llvm|
{
^0(%arg111 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg111, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_3_proof : ashr_ugt_3_before ⊑ ashr_ugt_3_after := by
  unfold ashr_ugt_3_before ashr_ugt_3_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_3
  apply ashr_ugt_3_thm
  ---END ashr_ugt_3



def ashr_ugt_4_before := [llvm|
{
^0(%arg110 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr %arg110, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_4_after := [llvm|
{
^0(%arg110 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg110, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_4_proof : ashr_ugt_4_before ⊑ ashr_ugt_4_after := by
  unfold ashr_ugt_4_before ashr_ugt_4_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_4
  apply ashr_ugt_4_thm
  ---END ashr_ugt_4



def ashr_ugt_5_before := [llvm|
{
^0(%arg109 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr %arg109, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_5_after := [llvm|
{
^0(%arg109 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg109, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_5_proof : ashr_ugt_5_before ⊑ ashr_ugt_5_after := by
  unfold ashr_ugt_5_before ashr_ugt_5_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_5
  apply ashr_ugt_5_thm
  ---END ashr_ugt_5



def ashr_ugt_6_before := [llvm|
{
^0(%arg108 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr %arg108, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_6_after := [llvm|
{
^0(%arg108 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg108, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_6_proof : ashr_ugt_6_before ⊑ ashr_ugt_6_after := by
  unfold ashr_ugt_6_before ashr_ugt_6_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_6
  apply ashr_ugt_6_thm
  ---END ashr_ugt_6



def ashr_ugt_7_before := [llvm|
{
^0(%arg107 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr %arg107, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_7_after := [llvm|
{
^0(%arg107 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg107, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_7_proof : ashr_ugt_7_before ⊑ ashr_ugt_7_after := by
  unfold ashr_ugt_7_before ashr_ugt_7_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_7
  apply ashr_ugt_7_thm
  ---END ashr_ugt_7



def ashr_ugt_8_before := [llvm|
{
^0(%arg106 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr %arg106, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_8_after := [llvm|
{
^0(%arg106 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg106, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_8_proof : ashr_ugt_8_before ⊑ ashr_ugt_8_after := by
  unfold ashr_ugt_8_before ashr_ugt_8_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_8
  apply ashr_ugt_8_thm
  ---END ashr_ugt_8



def ashr_ugt_9_before := [llvm|
{
^0(%arg105 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr %arg105, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_9_after := [llvm|
{
^0(%arg105 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg105, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_9_proof : ashr_ugt_9_before ⊑ ashr_ugt_9_after := by
  unfold ashr_ugt_9_before ashr_ugt_9_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_9
  apply ashr_ugt_9_thm
  ---END ashr_ugt_9



def ashr_ugt_10_before := [llvm|
{
^0(%arg104 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr %arg104, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_10_after := [llvm|
{
^0(%arg104 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg104, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_10_proof : ashr_ugt_10_before ⊑ ashr_ugt_10_after := by
  unfold ashr_ugt_10_before ashr_ugt_10_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_10
  apply ashr_ugt_10_thm
  ---END ashr_ugt_10



def ashr_ugt_11_before := [llvm|
{
^0(%arg103 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr %arg103, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_11_after := [llvm|
{
^0(%arg103 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg103, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_11_proof : ashr_ugt_11_before ⊑ ashr_ugt_11_after := by
  unfold ashr_ugt_11_before ashr_ugt_11_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_11
  apply ashr_ugt_11_thm
  ---END ashr_ugt_11



def ashr_ugt_12_before := [llvm|
{
^0(%arg102 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr %arg102, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_12_after := [llvm|
{
^0(%arg102 : i4):
  %0 = llvm.mlir.constant(-7 : i4) : i4
  %1 = llvm.icmp "ugt" %arg102, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_12_proof : ashr_ugt_12_before ⊑ ashr_ugt_12_after := by
  unfold ashr_ugt_12_before ashr_ugt_12_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_12
  apply ashr_ugt_12_thm
  ---END ashr_ugt_12



def ashr_ugt_13_before := [llvm|
{
^0(%arg101 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr %arg101, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_13_after := [llvm|
{
^0(%arg101 : i4):
  %0 = llvm.mlir.constant(-5 : i4) : i4
  %1 = llvm.icmp "ugt" %arg101, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_13_proof : ashr_ugt_13_before ⊑ ashr_ugt_13_after := by
  unfold ashr_ugt_13_before ashr_ugt_13_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_13
  apply ashr_ugt_13_thm
  ---END ashr_ugt_13



def ashr_ugt_14_before := [llvm|
{
^0(%arg100 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr %arg100, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_14_after := [llvm|
{
^0(%arg100 : i4):
  %0 = llvm.mlir.constant(-3 : i4) : i4
  %1 = llvm.icmp "ugt" %arg100, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_14_proof : ashr_ugt_14_before ⊑ ashr_ugt_14_after := by
  unfold ashr_ugt_14_before ashr_ugt_14_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_14
  apply ashr_ugt_14_thm
  ---END ashr_ugt_14



def ashr_ugt_15_before := [llvm|
{
^0(%arg99 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr %arg99, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_15_after := [llvm|
{
^0(%arg99 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_15_proof : ashr_ugt_15_before ⊑ ashr_ugt_15_after := by
  unfold ashr_ugt_15_before ashr_ugt_15_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_15
  apply ashr_ugt_15_thm
  ---END ashr_ugt_15



def ashr_ult_0_before := [llvm|
{
^0(%arg98 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr %arg98, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_0_after := [llvm|
{
^0(%arg98 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_0_proof : ashr_ult_0_before ⊑ ashr_ult_0_after := by
  unfold ashr_ult_0_before ashr_ult_0_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_0
  apply ashr_ult_0_thm
  ---END ashr_ult_0



def ashr_ult_1_before := [llvm|
{
^0(%arg97 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.ashr %arg97, %0 : i4
  %2 = llvm.icmp "ult" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashr_ult_1_after := [llvm|
{
^0(%arg97 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.icmp "ult" %arg97, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_1_proof : ashr_ult_1_before ⊑ ashr_ult_1_after := by
  unfold ashr_ult_1_before ashr_ult_1_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_1
  apply ashr_ult_1_thm
  ---END ashr_ult_1



def ashr_ult_2_before := [llvm|
{
^0(%arg96 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.ashr %arg96, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_2_after := [llvm|
{
^0(%arg96 : i4):
  %0 = llvm.mlir.constant(4 : i4) : i4
  %1 = llvm.icmp "ult" %arg96, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_2_proof : ashr_ult_2_before ⊑ ashr_ult_2_after := by
  unfold ashr_ult_2_before ashr_ult_2_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_2
  apply ashr_ult_2_thm
  ---END ashr_ult_2



def ashr_ult_3_before := [llvm|
{
^0(%arg93 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.ashr %arg93, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_3_after := [llvm|
{
^0(%arg93 : i4):
  %0 = llvm.mlir.constant(6 : i4) : i4
  %1 = llvm.icmp "ult" %arg93, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_3_proof : ashr_ult_3_before ⊑ ashr_ult_3_after := by
  unfold ashr_ult_3_before ashr_ult_3_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_3
  apply ashr_ult_3_thm
  ---END ashr_ult_3



def ashr_ult_4_before := [llvm|
{
^0(%arg92 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr %arg92, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_4_after := [llvm|
{
^0(%arg92 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg92, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_4_proof : ashr_ult_4_before ⊑ ashr_ult_4_after := by
  unfold ashr_ult_4_before ashr_ult_4_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_4
  apply ashr_ult_4_thm
  ---END ashr_ult_4



def ashr_ult_5_before := [llvm|
{
^0(%arg91 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr %arg91, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_5_after := [llvm|
{
^0(%arg91 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg91, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_5_proof : ashr_ult_5_before ⊑ ashr_ult_5_after := by
  unfold ashr_ult_5_before ashr_ult_5_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_5
  apply ashr_ult_5_thm
  ---END ashr_ult_5



def ashr_ult_6_before := [llvm|
{
^0(%arg90 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr %arg90, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_6_after := [llvm|
{
^0(%arg90 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg90, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_6_proof : ashr_ult_6_before ⊑ ashr_ult_6_after := by
  unfold ashr_ult_6_before ashr_ult_6_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_6
  apply ashr_ult_6_thm
  ---END ashr_ult_6



def ashr_ult_7_before := [llvm|
{
^0(%arg89 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr %arg89, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_7_after := [llvm|
{
^0(%arg89 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg89, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_7_proof : ashr_ult_7_before ⊑ ashr_ult_7_after := by
  unfold ashr_ult_7_before ashr_ult_7_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_7
  apply ashr_ult_7_thm
  ---END ashr_ult_7



def ashr_ult_8_before := [llvm|
{
^0(%arg88 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr %arg88, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_8_after := [llvm|
{
^0(%arg88 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg88, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_8_proof : ashr_ult_8_before ⊑ ashr_ult_8_after := by
  unfold ashr_ult_8_before ashr_ult_8_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_8
  apply ashr_ult_8_thm
  ---END ashr_ult_8



def ashr_ult_9_before := [llvm|
{
^0(%arg87 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr %arg87, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_9_after := [llvm|
{
^0(%arg87 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg87, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_9_proof : ashr_ult_9_before ⊑ ashr_ult_9_after := by
  unfold ashr_ult_9_before ashr_ult_9_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_9
  apply ashr_ult_9_thm
  ---END ashr_ult_9



def ashr_ult_10_before := [llvm|
{
^0(%arg86 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr %arg86, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_10_after := [llvm|
{
^0(%arg86 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg86, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_10_proof : ashr_ult_10_before ⊑ ashr_ult_10_after := by
  unfold ashr_ult_10_before ashr_ult_10_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_10
  apply ashr_ult_10_thm
  ---END ashr_ult_10



def ashr_ult_11_before := [llvm|
{
^0(%arg85 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr %arg85, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_11_after := [llvm|
{
^0(%arg85 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg85, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_11_proof : ashr_ult_11_before ⊑ ashr_ult_11_after := by
  unfold ashr_ult_11_before ashr_ult_11_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_11
  apply ashr_ult_11_thm
  ---END ashr_ult_11



def ashr_ult_12_before := [llvm|
{
^0(%arg84 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr %arg84, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_12_after := [llvm|
{
^0(%arg84 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg84, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_12_proof : ashr_ult_12_before ⊑ ashr_ult_12_after := by
  unfold ashr_ult_12_before ashr_ult_12_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_12
  apply ashr_ult_12_thm
  ---END ashr_ult_12



def ashr_ult_13_before := [llvm|
{
^0(%arg83 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr %arg83, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_13_after := [llvm|
{
^0(%arg83 : i4):
  %0 = llvm.mlir.constant(-6 : i4) : i4
  %1 = llvm.icmp "ult" %arg83, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_13_proof : ashr_ult_13_before ⊑ ashr_ult_13_after := by
  unfold ashr_ult_13_before ashr_ult_13_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_13
  apply ashr_ult_13_thm
  ---END ashr_ult_13



def ashr_ult_14_before := [llvm|
{
^0(%arg82 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr %arg82, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_14_after := [llvm|
{
^0(%arg82 : i4):
  %0 = llvm.mlir.constant(-4 : i4) : i4
  %1 = llvm.icmp "ult" %arg82, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_14_proof : ashr_ult_14_before ⊑ ashr_ult_14_after := by
  unfold ashr_ult_14_before ashr_ult_14_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_14
  apply ashr_ult_14_thm
  ---END ashr_ult_14



def ashr_ult_15_before := [llvm|
{
^0(%arg81 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr %arg81, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_15_after := [llvm|
{
^0(%arg81 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.icmp "ult" %arg81, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_15_proof : ashr_ult_15_before ⊑ ashr_ult_15_after := by
  unfold ashr_ult_15_before ashr_ult_15_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_15
  apply ashr_ult_15_thm
  ---END ashr_ult_15



def lshr_pow2_ugt_before := [llvm|
{
^0(%arg72 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.lshr %0, %arg72 : i8
  %3 = llvm.icmp "ugt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshr_pow2_ugt_after := [llvm|
{
^0(%arg72 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg72, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_pow2_ugt_proof : lshr_pow2_ugt_before ⊑ lshr_pow2_ugt_after := by
  unfold lshr_pow2_ugt_before lshr_pow2_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_pow2_ugt
  apply lshr_pow2_ugt_thm
  ---END lshr_pow2_ugt



def lshr_pow2_ugt1_before := [llvm|
{
^0(%arg68 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.lshr %0, %arg68 : i8
  %3 = llvm.icmp "ugt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshr_pow2_ugt1_after := [llvm|
{
^0(%arg68 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.icmp "ult" %arg68, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_pow2_ugt1_proof : lshr_pow2_ugt1_before ⊑ lshr_pow2_ugt1_after := by
  unfold lshr_pow2_ugt1_before lshr_pow2_ugt1_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_pow2_ugt1
  apply lshr_pow2_ugt1_thm
  ---END lshr_pow2_ugt1



def ashr_pow2_ugt_before := [llvm|
{
^0(%arg67 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(-96 : i8) : i8
  %2 = llvm.ashr %0, %arg67 : i8
  %3 = llvm.icmp "ugt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_pow2_ugt_after := [llvm|
{
^0(%arg67 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(-96 : i8) : i8
  %2 = llvm.ashr exact %0, %arg67 : i8
  %3 = llvm.icmp "ugt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_pow2_ugt_proof : ashr_pow2_ugt_before ⊑ ashr_pow2_ugt_after := by
  unfold ashr_pow2_ugt_before ashr_pow2_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_pow2_ugt
  apply ashr_pow2_ugt_thm
  ---END ashr_pow2_ugt



def lshr_pow2_sgt_before := [llvm|
{
^0(%arg66 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr %0, %arg66 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshr_pow2_sgt_after := [llvm|
{
^0(%arg66 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr exact %0, %arg66 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_pow2_sgt_proof : lshr_pow2_sgt_before ⊑ lshr_pow2_sgt_after := by
  unfold lshr_pow2_sgt_before lshr_pow2_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_pow2_sgt
  apply lshr_pow2_sgt_thm
  ---END lshr_pow2_sgt



def lshr_pow2_ult_before := [llvm|
{
^0(%arg65 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.lshr %0, %arg65 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshr_pow2_ult_after := [llvm|
{
^0(%arg65 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.icmp "ugt" %arg65, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_pow2_ult_proof : lshr_pow2_ult_before ⊑ lshr_pow2_ult_after := by
  unfold lshr_pow2_ult_before lshr_pow2_ult_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_pow2_ult
  apply lshr_pow2_ult_thm
  ---END lshr_pow2_ult



def lshr_pow2_ult_equal_constants_before := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.lshr %0, %arg61 : i32
  %2 = llvm.icmp "ult" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshr_pow2_ult_equal_constants_after := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg61, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_pow2_ult_equal_constants_proof : lshr_pow2_ult_equal_constants_before ⊑ lshr_pow2_ult_equal_constants_after := by
  unfold lshr_pow2_ult_equal_constants_before lshr_pow2_ult_equal_constants_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_pow2_ult_equal_constants
  apply lshr_pow2_ult_equal_constants_thm
  ---END lshr_pow2_ult_equal_constants



def lshr_pow2_ult_smin_before := [llvm|
{
^0(%arg60 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.lshr %0, %arg60 : i8
  %2 = llvm.icmp "ult" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshr_pow2_ult_smin_after := [llvm|
{
^0(%arg60 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg60, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_pow2_ult_smin_proof : lshr_pow2_ult_smin_before ⊑ lshr_pow2_ult_smin_after := by
  unfold lshr_pow2_ult_smin_before lshr_pow2_ult_smin_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_pow2_ult_smin
  apply lshr_pow2_ult_smin_thm
  ---END lshr_pow2_ult_smin



def ashr_pow2_ult_before := [llvm|
{
^0(%arg59 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(-96 : i8) : i8
  %2 = llvm.ashr %0, %arg59 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_pow2_ult_after := [llvm|
{
^0(%arg59 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(-96 : i8) : i8
  %2 = llvm.ashr exact %0, %arg59 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_pow2_ult_proof : ashr_pow2_ult_before ⊑ ashr_pow2_ult_after := by
  unfold ashr_pow2_ult_before ashr_pow2_ult_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_pow2_ult
  apply ashr_pow2_ult_thm
  ---END ashr_pow2_ult



def lshr_pow2_slt_before := [llvm|
{
^0(%arg58 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr %0, %arg58 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshr_pow2_slt_after := [llvm|
{
^0(%arg58 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.lshr exact %0, %arg58 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_pow2_slt_proof : lshr_pow2_slt_before ⊑ lshr_pow2_slt_after := by
  unfold lshr_pow2_slt_before lshr_pow2_slt_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_pow2_slt
  apply lshr_pow2_slt_thm
  ---END lshr_pow2_slt



def lshr_neg_sgt_minus_1_before := [llvm|
{
^0(%arg57 : i8):
  %0 = llvm.mlir.constant(-17 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.lshr %0, %arg57 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshr_neg_sgt_minus_1_after := [llvm|
{
^0(%arg57 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg57, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_neg_sgt_minus_1_proof : lshr_neg_sgt_minus_1_before ⊑ lshr_neg_sgt_minus_1_after := by
  unfold lshr_neg_sgt_minus_1_before lshr_neg_sgt_minus_1_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_neg_sgt_minus_1
  apply lshr_neg_sgt_minus_1_thm
  ---END lshr_neg_sgt_minus_1



def lshr_neg_slt_zero_before := [llvm|
{
^0(%arg52 : i8):
  %0 = llvm.mlir.constant(-17 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.lshr %0, %arg52 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshr_neg_slt_zero_after := [llvm|
{
^0(%arg52 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg52, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_neg_slt_zero_proof : lshr_neg_slt_zero_before ⊑ lshr_neg_slt_zero_after := by
  unfold lshr_neg_slt_zero_before lshr_neg_slt_zero_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_neg_slt_zero
  apply lshr_neg_slt_zero_thm
  ---END lshr_neg_slt_zero



def exactly_one_set_signbit_before := [llvm|
{
^0(%arg46 : i8, %arg47 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.lshr %arg46, %0 : i8
  %3 = llvm.icmp "sgt" %arg47, %1 : i8
  %4 = llvm.zext %3 : i1 to i8
  %5 = llvm.icmp "eq" %2, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def exactly_one_set_signbit_after := [llvm|
{
^0(%arg46 : i8, %arg47 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.xor %arg46, %arg47 : i8
  %2 = llvm.icmp "slt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exactly_one_set_signbit_proof : exactly_one_set_signbit_before ⊑ exactly_one_set_signbit_after := by
  unfold exactly_one_set_signbit_before exactly_one_set_signbit_after
  simp_alive_peephole
  intros
  ---BEGIN exactly_one_set_signbit
  apply exactly_one_set_signbit_thm
  ---END exactly_one_set_signbit



def same_signbit_wrong_type_before := [llvm|
{
^0(%arg34 : i8, %arg35 : i32):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.lshr %arg34, %0 : i8
  %3 = llvm.icmp "sgt" %arg35, %1 : i32
  %4 = llvm.zext %3 : i1 to i8
  %5 = llvm.icmp "ne" %2, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def same_signbit_wrong_type_after := [llvm|
{
^0(%arg34 : i8, %arg35 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.icmp "sgt" %arg35, %0 : i32
  %3 = llvm.icmp "slt" %arg34, %1 : i8
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem same_signbit_wrong_type_proof : same_signbit_wrong_type_before ⊑ same_signbit_wrong_type_after := by
  unfold same_signbit_wrong_type_before same_signbit_wrong_type_after
  simp_alive_peephole
  intros
  ---BEGIN same_signbit_wrong_type
  apply same_signbit_wrong_type_thm
  ---END same_signbit_wrong_type



def exactly_one_set_signbit_wrong_pred_before := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.lshr %arg28, %0 : i8
  %3 = llvm.icmp "sgt" %arg29, %1 : i8
  %4 = llvm.zext %3 : i1 to i8
  %5 = llvm.icmp "sgt" %2, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def exactly_one_set_signbit_wrong_pred_after := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.and %arg29, %arg28 : i8
  %2 = llvm.icmp "slt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exactly_one_set_signbit_wrong_pred_proof : exactly_one_set_signbit_wrong_pred_before ⊑ exactly_one_set_signbit_wrong_pred_after := by
  unfold exactly_one_set_signbit_wrong_pred_before exactly_one_set_signbit_wrong_pred_after
  simp_alive_peephole
  intros
  ---BEGIN exactly_one_set_signbit_wrong_pred
  apply exactly_one_set_signbit_wrong_pred_thm
  ---END exactly_one_set_signbit_wrong_pred



def exactly_one_set_signbit_signed_before := [llvm|
{
^0(%arg26 : i8, %arg27 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr %arg26, %0 : i8
  %3 = llvm.icmp "sgt" %arg27, %1 : i8
  %4 = llvm.sext %3 : i1 to i8
  %5 = llvm.icmp "eq" %2, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def exactly_one_set_signbit_signed_after := [llvm|
{
^0(%arg26 : i8, %arg27 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.xor %arg26, %arg27 : i8
  %2 = llvm.icmp "slt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem exactly_one_set_signbit_signed_proof : exactly_one_set_signbit_signed_before ⊑ exactly_one_set_signbit_signed_after := by
  unfold exactly_one_set_signbit_signed_before exactly_one_set_signbit_signed_after
  simp_alive_peephole
  intros
  ---BEGIN exactly_one_set_signbit_signed
  apply exactly_one_set_signbit_signed_thm
  ---END exactly_one_set_signbit_signed



def same_signbit_wrong_type_signed_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i32):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.ashr %arg14, %0 : i8
  %3 = llvm.icmp "sgt" %arg15, %1 : i32
  %4 = llvm.sext %3 : i1 to i8
  %5 = llvm.icmp "ne" %2, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def same_signbit_wrong_type_signed_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.icmp "sgt" %arg15, %0 : i32
  %3 = llvm.icmp "slt" %arg14, %1 : i8
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem same_signbit_wrong_type_signed_proof : same_signbit_wrong_type_signed_before ⊑ same_signbit_wrong_type_signed_after := by
  unfold same_signbit_wrong_type_signed_before same_signbit_wrong_type_signed_after
  simp_alive_peephole
  intros
  ---BEGIN same_signbit_wrong_type_signed
  apply same_signbit_wrong_type_signed_thm
  ---END same_signbit_wrong_type_signed



def slt_zero_ult_i1_before := [llvm|
{
^0(%arg10 : i32, %arg11 : i1):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.zext %arg11 : i1 to i32
  %2 = llvm.lshr %arg10, %0 : i32
  %3 = llvm.icmp "ult" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_zero_ult_i1_after := [llvm|
{
^0(%arg10 : i32, %arg11 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "slt" %arg10, %0 : i32
  %3 = llvm.xor %arg11, %1 : i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_ult_i1_proof : slt_zero_ult_i1_before ⊑ slt_zero_ult_i1_after := by
  unfold slt_zero_ult_i1_before slt_zero_ult_i1_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_ult_i1
  apply slt_zero_ult_i1_thm
  ---END slt_zero_ult_i1



def slt_zero_ult_i1_fail1_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i1):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.zext %arg9 : i1 to i32
  %2 = llvm.lshr %arg8, %0 : i32
  %3 = llvm.icmp "ult" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_zero_ult_i1_fail1_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i1):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.zext %arg9 : i1 to i32
  %2 = llvm.lshr %arg8, %0 : i32
  %3 = llvm.icmp "ugt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_ult_i1_fail1_proof : slt_zero_ult_i1_fail1_before ⊑ slt_zero_ult_i1_fail1_after := by
  unfold slt_zero_ult_i1_fail1_before slt_zero_ult_i1_fail1_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_ult_i1_fail1
  apply slt_zero_ult_i1_fail1_thm
  ---END slt_zero_ult_i1_fail1



def slt_zero_ult_i1_fail2_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i1):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.zext %arg7 : i1 to i32
  %2 = llvm.ashr %arg6, %0 : i32
  %3 = llvm.icmp "ult" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_zero_ult_i1_fail2_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i1):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.zext %arg7 : i1 to i32
  %2 = llvm.ashr %arg6, %0 : i32
  %3 = llvm.icmp "ugt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_ult_i1_fail2_proof : slt_zero_ult_i1_fail2_before ⊑ slt_zero_ult_i1_fail2_after := by
  unfold slt_zero_ult_i1_fail2_before slt_zero_ult_i1_fail2_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_ult_i1_fail2
  apply slt_zero_ult_i1_fail2_thm
  ---END slt_zero_ult_i1_fail2



def slt_zero_slt_i1_fail_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i1):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.zext %arg5 : i1 to i32
  %2 = llvm.lshr %arg4, %0 : i32
  %3 = llvm.icmp "slt" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_zero_slt_i1_fail_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "slt" %arg4, %0 : i32
  %3 = llvm.xor %arg5, %1 : i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_slt_i1_fail_proof : slt_zero_slt_i1_fail_before ⊑ slt_zero_slt_i1_fail_after := by
  unfold slt_zero_slt_i1_fail_before slt_zero_slt_i1_fail_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_slt_i1_fail
  apply slt_zero_slt_i1_fail_thm
  ---END slt_zero_slt_i1_fail



def slt_zero_eq_i1_signed_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i1):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.sext %arg3 : i1 to i32
  %2 = llvm.ashr %arg2, %0 : i32
  %3 = llvm.icmp "eq" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_zero_eq_i1_signed_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "sgt" %arg2, %0 : i32
  %2 = llvm.xor %1, %arg3 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_eq_i1_signed_proof : slt_zero_eq_i1_signed_before ⊑ slt_zero_eq_i1_signed_after := by
  unfold slt_zero_eq_i1_signed_before slt_zero_eq_i1_signed_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_eq_i1_signed
  apply slt_zero_eq_i1_signed_thm
  ---END slt_zero_eq_i1_signed



def slt_zero_eq_i1_fail_signed_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i1):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.sext %arg1 : i1 to i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.icmp "eq" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_zero_eq_i1_fail_signed_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i1):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.sext %arg1 : i1 to i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_zero_eq_i1_fail_signed_proof : slt_zero_eq_i1_fail_signed_before ⊑ slt_zero_eq_i1_fail_signed_after := by
  unfold slt_zero_eq_i1_fail_signed_before slt_zero_eq_i1_fail_signed_after
  simp_alive_peephole
  intros
  ---BEGIN slt_zero_eq_i1_fail_signed
  apply slt_zero_eq_i1_fail_signed_thm
  ---END slt_zero_eq_i1_fail_signed


