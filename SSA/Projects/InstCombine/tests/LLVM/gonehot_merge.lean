
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
section gonehot_merge_statements

def and_consts_before := [llvm|
{
^0(%arg190 : i32, %arg191 : i32, %arg192 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.and %0, %arg190 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %2, %arg190 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def and_consts_after := [llvm|
{
^0(%arg190 : i32, %arg191 : i32, %arg192 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.and %arg190, %0 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_consts_proof : and_consts_before ⊑ and_consts_after := by
  unfold and_consts_before and_consts_after
  simp_alive_peephole
  intros
  ---BEGIN and_consts
  all_goals (try extract_goal ; sorry)
  ---END and_consts



def and_consts_logical_before := [llvm|
{
^0(%arg187 : i32, %arg188 : i32, %arg189 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.and %0, %arg187 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %2, %arg187 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = "llvm.select"(%5, %3, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def and_consts_logical_after := [llvm|
{
^0(%arg187 : i32, %arg188 : i32, %arg189 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.and %arg187, %0 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_consts_logical_proof : and_consts_logical_before ⊑ and_consts_logical_after := by
  unfold and_consts_logical_before and_consts_logical_after
  simp_alive_peephole
  intros
  ---BEGIN and_consts_logical
  all_goals (try extract_goal ; sorry)
  ---END and_consts_logical



def foo1_and_before := [llvm|
{
^0(%arg181 : i32, %arg182 : i32, %arg183 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg182 : i32
  %3 = llvm.shl %0, %arg183 : i32
  %4 = llvm.and %2, %arg181 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %3, %arg181 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def foo1_and_after := [llvm|
{
^0(%arg181 : i32, %arg182 : i32, %arg183 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg182 overflow<nuw> : i32
  %2 = llvm.shl %0, %arg183 overflow<nuw> : i32
  %3 = llvm.or %1, %2 : i32
  %4 = llvm.and %arg181, %3 : i32
  %5 = llvm.icmp "ne" %4, %3 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_and_proof : foo1_and_before ⊑ foo1_and_after := by
  unfold foo1_and_before foo1_and_after
  simp_alive_peephole
  intros
  ---BEGIN foo1_and
  all_goals (try extract_goal ; sorry)
  ---END foo1_and



def foo1_and_commuted_before := [llvm|
{
^0(%arg172 : i32, %arg173 : i32, %arg174 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mul %arg172, %arg172 : i32
  %3 = llvm.shl %0, %arg173 : i32
  %4 = llvm.shl %0, %arg174 : i32
  %5 = llvm.and %2, %3 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %4, %2 : i32
  %8 = llvm.icmp "eq" %7, %1 : i32
  %9 = llvm.or %6, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def foo1_and_commuted_after := [llvm|
{
^0(%arg172 : i32, %arg173 : i32, %arg174 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mul %arg172, %arg172 : i32
  %2 = llvm.shl %0, %arg173 overflow<nuw> : i32
  %3 = llvm.shl %0, %arg174 overflow<nuw> : i32
  %4 = llvm.or %2, %3 : i32
  %5 = llvm.and %1, %4 : i32
  %6 = llvm.icmp "ne" %5, %4 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_and_commuted_proof : foo1_and_commuted_before ⊑ foo1_and_commuted_after := by
  unfold foo1_and_commuted_before foo1_and_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN foo1_and_commuted
  all_goals (try extract_goal ; sorry)
  ---END foo1_and_commuted



def or_consts_before := [llvm|
{
^0(%arg163 : i32, %arg164 : i32, %arg165 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.and %0, %arg163 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %2, %arg163 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def or_consts_after := [llvm|
{
^0(%arg163 : i32, %arg164 : i32, %arg165 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.and %arg163, %0 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_consts_proof : or_consts_before ⊑ or_consts_after := by
  unfold or_consts_before or_consts_after
  simp_alive_peephole
  intros
  ---BEGIN or_consts
  all_goals (try extract_goal ; sorry)
  ---END or_consts



def or_consts_logical_before := [llvm|
{
^0(%arg160 : i32, %arg161 : i32, %arg162 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %0, %arg160 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %2, %arg160 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = "llvm.select"(%5, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def or_consts_logical_after := [llvm|
{
^0(%arg160 : i32, %arg161 : i32, %arg162 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.and %arg160, %0 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_consts_logical_proof : or_consts_logical_before ⊑ or_consts_logical_after := by
  unfold or_consts_logical_before or_consts_logical_after
  simp_alive_peephole
  intros
  ---BEGIN or_consts_logical
  all_goals (try extract_goal ; sorry)
  ---END or_consts_logical



def foo1_or_before := [llvm|
{
^0(%arg154 : i32, %arg155 : i32, %arg156 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg155 : i32
  %3 = llvm.shl %0, %arg156 : i32
  %4 = llvm.and %2, %arg154 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %3, %arg154 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def foo1_or_after := [llvm|
{
^0(%arg154 : i32, %arg155 : i32, %arg156 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg155 overflow<nuw> : i32
  %2 = llvm.shl %0, %arg156 overflow<nuw> : i32
  %3 = llvm.or %1, %2 : i32
  %4 = llvm.and %arg154, %3 : i32
  %5 = llvm.icmp "eq" %4, %3 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_or_proof : foo1_or_before ⊑ foo1_or_after := by
  unfold foo1_or_before foo1_or_after
  simp_alive_peephole
  intros
  ---BEGIN foo1_or
  all_goals (try extract_goal ; sorry)
  ---END foo1_or



def foo1_or_commuted_before := [llvm|
{
^0(%arg145 : i32, %arg146 : i32, %arg147 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mul %arg145, %arg145 : i32
  %3 = llvm.shl %0, %arg146 : i32
  %4 = llvm.shl %0, %arg147 : i32
  %5 = llvm.and %2, %3 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %4, %2 : i32
  %8 = llvm.icmp "ne" %7, %1 : i32
  %9 = llvm.and %6, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def foo1_or_commuted_after := [llvm|
{
^0(%arg145 : i32, %arg146 : i32, %arg147 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mul %arg145, %arg145 : i32
  %2 = llvm.shl %0, %arg146 overflow<nuw> : i32
  %3 = llvm.shl %0, %arg147 overflow<nuw> : i32
  %4 = llvm.or %2, %3 : i32
  %5 = llvm.and %1, %4 : i32
  %6 = llvm.icmp "eq" %5, %4 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_or_commuted_proof : foo1_or_commuted_before ⊑ foo1_or_commuted_after := by
  unfold foo1_or_commuted_before foo1_or_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN foo1_or_commuted
  all_goals (try extract_goal ; sorry)
  ---END foo1_or_commuted



def foo1_and_signbit_lshr_before := [llvm|
{
^0(%arg136 : i32, %arg137 : i32, %arg138 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg137 : i32
  %4 = llvm.lshr %1, %arg138 : i32
  %5 = llvm.and %3, %arg136 : i32
  %6 = llvm.icmp "eq" %5, %2 : i32
  %7 = llvm.and %4, %arg136 : i32
  %8 = llvm.icmp "eq" %7, %2 : i32
  %9 = llvm.or %6, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def foo1_and_signbit_lshr_after := [llvm|
{
^0(%arg136 : i32, %arg137 : i32, %arg138 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.shl %0, %arg137 overflow<nuw> : i32
  %3 = llvm.lshr exact %1, %arg138 : i32
  %4 = llvm.or %2, %3 : i32
  %5 = llvm.and %arg136, %4 : i32
  %6 = llvm.icmp "ne" %5, %4 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_and_signbit_lshr_proof : foo1_and_signbit_lshr_before ⊑ foo1_and_signbit_lshr_after := by
  unfold foo1_and_signbit_lshr_before foo1_and_signbit_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN foo1_and_signbit_lshr
  all_goals (try extract_goal ; sorry)
  ---END foo1_and_signbit_lshr



def foo1_or_signbit_lshr_before := [llvm|
{
^0(%arg127 : i32, %arg128 : i32, %arg129 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.shl %0, %arg128 : i32
  %4 = llvm.lshr %1, %arg129 : i32
  %5 = llvm.and %3, %arg127 : i32
  %6 = llvm.icmp "ne" %5, %2 : i32
  %7 = llvm.and %4, %arg127 : i32
  %8 = llvm.icmp "ne" %7, %2 : i32
  %9 = llvm.and %6, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def foo1_or_signbit_lshr_after := [llvm|
{
^0(%arg127 : i32, %arg128 : i32, %arg129 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.shl %0, %arg128 overflow<nuw> : i32
  %3 = llvm.lshr exact %1, %arg129 : i32
  %4 = llvm.or %2, %3 : i32
  %5 = llvm.and %arg127, %4 : i32
  %6 = llvm.icmp "eq" %5, %4 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_or_signbit_lshr_proof : foo1_or_signbit_lshr_before ⊑ foo1_or_signbit_lshr_after := by
  unfold foo1_or_signbit_lshr_before foo1_or_signbit_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN foo1_or_signbit_lshr
  all_goals (try extract_goal ; sorry)
  ---END foo1_or_signbit_lshr



def foo1_and_signbit_lshr_without_shifting_signbit_before := [llvm|
{
^0(%arg118 : i32, %arg119 : i32, %arg120 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.shl %0, %arg119 : i32
  %4 = llvm.and %3, %arg118 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.shl %arg118, %arg120 : i32
  %7 = llvm.icmp "sgt" %6, %2 : i32
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def foo1_and_signbit_lshr_without_shifting_signbit_after := [llvm|
{
^0(%arg118 : i32, %arg119 : i32, %arg120 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.shl %0, %arg119 overflow<nuw> : i32
  %4 = llvm.and %3, %arg118 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.shl %arg118, %arg120 : i32
  %7 = llvm.icmp "sgt" %6, %2 : i32
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_and_signbit_lshr_without_shifting_signbit_proof : foo1_and_signbit_lshr_without_shifting_signbit_before ⊑ foo1_and_signbit_lshr_without_shifting_signbit_after := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_before foo1_and_signbit_lshr_without_shifting_signbit_after
  simp_alive_peephole
  intros
  ---BEGIN foo1_and_signbit_lshr_without_shifting_signbit
  all_goals (try extract_goal ; sorry)
  ---END foo1_and_signbit_lshr_without_shifting_signbit



def foo1_and_signbit_lshr_without_shifting_signbit_logical_before := [llvm|
{
^0(%arg115 : i32, %arg116 : i32, %arg117 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.shl %0, %arg116 : i32
  %5 = llvm.and %4, %arg115 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.shl %arg115, %arg117 : i32
  %8 = llvm.icmp "sgt" %7, %2 : i32
  %9 = "llvm.select"(%6, %3, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def foo1_and_signbit_lshr_without_shifting_signbit_logical_after := [llvm|
{
^0(%arg115 : i32, %arg116 : i32, %arg117 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.shl %0, %arg116 overflow<nuw> : i32
  %5 = llvm.and %4, %arg115 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.shl %arg115, %arg117 : i32
  %8 = llvm.icmp "sgt" %7, %2 : i32
  %9 = "llvm.select"(%6, %3, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_and_signbit_lshr_without_shifting_signbit_logical_proof : foo1_and_signbit_lshr_without_shifting_signbit_logical_before ⊑ foo1_and_signbit_lshr_without_shifting_signbit_logical_after := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_logical_before foo1_and_signbit_lshr_without_shifting_signbit_logical_after
  simp_alive_peephole
  intros
  ---BEGIN foo1_and_signbit_lshr_without_shifting_signbit_logical
  all_goals (try extract_goal ; sorry)
  ---END foo1_and_signbit_lshr_without_shifting_signbit_logical



def foo1_or_signbit_lshr_without_shifting_signbit_before := [llvm|
{
^0(%arg112 : i32, %arg113 : i32, %arg114 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg113 : i32
  %3 = llvm.and %2, %arg112 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.shl %arg112, %arg114 : i32
  %6 = llvm.icmp "slt" %5, %1 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def foo1_or_signbit_lshr_without_shifting_signbit_after := [llvm|
{
^0(%arg112 : i32, %arg113 : i32, %arg114 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg113 overflow<nuw> : i32
  %3 = llvm.and %2, %arg112 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.shl %arg112, %arg114 : i32
  %6 = llvm.icmp "slt" %5, %1 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_or_signbit_lshr_without_shifting_signbit_proof : foo1_or_signbit_lshr_without_shifting_signbit_before ⊑ foo1_or_signbit_lshr_without_shifting_signbit_after := by
  unfold foo1_or_signbit_lshr_without_shifting_signbit_before foo1_or_signbit_lshr_without_shifting_signbit_after
  simp_alive_peephole
  intros
  ---BEGIN foo1_or_signbit_lshr_without_shifting_signbit
  all_goals (try extract_goal ; sorry)
  ---END foo1_or_signbit_lshr_without_shifting_signbit



def foo1_or_signbit_lshr_without_shifting_signbit_logical_before := [llvm|
{
^0(%arg109 : i32, %arg110 : i32, %arg111 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.shl %0, %arg110 : i32
  %4 = llvm.and %3, %arg109 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.shl %arg109, %arg111 : i32
  %7 = llvm.icmp "slt" %6, %1 : i32
  %8 = "llvm.select"(%5, %7, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def foo1_or_signbit_lshr_without_shifting_signbit_logical_after := [llvm|
{
^0(%arg109 : i32, %arg110 : i32, %arg111 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.shl %0, %arg110 overflow<nuw> : i32
  %4 = llvm.and %3, %arg109 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.shl %arg109, %arg111 : i32
  %7 = llvm.icmp "slt" %6, %1 : i32
  %8 = "llvm.select"(%5, %7, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_or_signbit_lshr_without_shifting_signbit_logical_proof : foo1_or_signbit_lshr_without_shifting_signbit_logical_before ⊑ foo1_or_signbit_lshr_without_shifting_signbit_logical_after := by
  unfold foo1_or_signbit_lshr_without_shifting_signbit_logical_before foo1_or_signbit_lshr_without_shifting_signbit_logical_after
  simp_alive_peephole
  intros
  ---BEGIN foo1_or_signbit_lshr_without_shifting_signbit_logical
  all_goals (try extract_goal ; sorry)
  ---END foo1_or_signbit_lshr_without_shifting_signbit_logical



def foo1_and_signbit_lshr_without_shifting_signbit_both_sides_before := [llvm|
{
^0(%arg106 : i32, %arg107 : i32, %arg108 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %arg106, %arg107 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  %3 = llvm.shl %arg106, %arg108 : i32
  %4 = llvm.icmp "sgt" %3, %0 : i32
  %5 = llvm.or %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def foo1_and_signbit_lshr_without_shifting_signbit_both_sides_after := [llvm|
{
^0(%arg106 : i32, %arg107 : i32, %arg108 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %arg106, %arg107 : i32
  %2 = llvm.shl %arg106, %arg108 : i32
  %3 = llvm.and %1, %2 : i32
  %4 = llvm.icmp "sgt" %3, %0 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_and_signbit_lshr_without_shifting_signbit_both_sides_proof : foo1_and_signbit_lshr_without_shifting_signbit_both_sides_before ⊑ foo1_and_signbit_lshr_without_shifting_signbit_both_sides_after := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_both_sides_before foo1_and_signbit_lshr_without_shifting_signbit_both_sides_after
  simp_alive_peephole
  intros
  ---BEGIN foo1_and_signbit_lshr_without_shifting_signbit_both_sides
  all_goals (try extract_goal ; sorry)
  ---END foo1_and_signbit_lshr_without_shifting_signbit_both_sides



def foo1_or_signbit_lshr_without_shifting_signbit_both_sides_before := [llvm|
{
^0(%arg100 : i32, %arg101 : i32, %arg102 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.shl %arg100, %arg101 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  %3 = llvm.shl %arg100, %arg102 : i32
  %4 = llvm.icmp "slt" %3, %0 : i32
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def foo1_or_signbit_lshr_without_shifting_signbit_both_sides_after := [llvm|
{
^0(%arg100 : i32, %arg101 : i32, %arg102 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.shl %arg100, %arg101 : i32
  %2 = llvm.shl %arg100, %arg102 : i32
  %3 = llvm.and %1, %2 : i32
  %4 = llvm.icmp "slt" %3, %0 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo1_or_signbit_lshr_without_shifting_signbit_both_sides_proof : foo1_or_signbit_lshr_without_shifting_signbit_both_sides_before ⊑ foo1_or_signbit_lshr_without_shifting_signbit_both_sides_after := by
  unfold foo1_or_signbit_lshr_without_shifting_signbit_both_sides_before foo1_or_signbit_lshr_without_shifting_signbit_both_sides_after
  simp_alive_peephole
  intros
  ---BEGIN foo1_or_signbit_lshr_without_shifting_signbit_both_sides
  all_goals (try extract_goal ; sorry)
  ---END foo1_or_signbit_lshr_without_shifting_signbit_both_sides


