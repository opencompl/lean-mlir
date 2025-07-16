import SSA.Projects.InstCombine.tests.proofs.gselecthsafehtransforms_proof
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
section gselecthsafehtransforms_statements

def cond_eq_and_const_before := [llvm|
{
^0(%arg154 : i8, %arg155 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg154, %0 : i8
  %3 = llvm.icmp "ult" %arg154, %arg155 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def cond_eq_and_const_after := [llvm|
{
^0(%arg154 : i8, %arg155 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg154, %0 : i8
  %3 = llvm.icmp "ugt" %arg155, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem cond_eq_and_const_proof : cond_eq_and_const_before ⊑ cond_eq_and_const_after := by
  unfold cond_eq_and_const_before cond_eq_and_const_after
  simp_alive_peephole
  intros
  ---BEGIN cond_eq_and_const
  apply cond_eq_and_const_thm
  ---END cond_eq_and_const



def cond_eq_or_const_before := [llvm|
{
^0(%arg149 : i8, %arg150 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ne" %arg149, %0 : i8
  %3 = llvm.icmp "ult" %arg149, %arg150 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def cond_eq_or_const_after := [llvm|
{
^0(%arg149 : i8, %arg150 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ne" %arg149, %0 : i8
  %3 = llvm.icmp "ugt" %arg150, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem cond_eq_or_const_proof : cond_eq_or_const_before ⊑ cond_eq_or_const_after := by
  unfold cond_eq_or_const_before cond_eq_or_const_after
  simp_alive_peephole
  intros
  ---BEGIN cond_eq_or_const
  apply cond_eq_or_const_thm
  ---END cond_eq_or_const



def xor_and_before := [llvm|
{
^0(%arg146 : i1, %arg147 : i32, %arg148 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ult" %arg147, %arg148 : i32
  %3 = "llvm.select"(%arg146, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.xor %3, %1 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_and_after := [llvm|
{
^0(%arg146 : i1, %arg147 : i32, %arg148 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "uge" %arg147, %arg148 : i32
  %2 = llvm.xor %arg146, %0 : i1
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_and_proof : xor_and_before ⊑ xor_and_after := by
  unfold xor_and_before xor_and_after
  simp_alive_peephole
  intros
  ---BEGIN xor_and
  apply xor_and_thm
  ---END xor_and



def xor_or_before := [llvm|
{
^0(%arg137 : i1, %arg138 : i32, %arg139 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "ult" %arg138, %arg139 : i32
  %2 = "llvm.select"(%arg137, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = llvm.xor %2, %0 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def xor_or_after := [llvm|
{
^0(%arg137 : i1, %arg138 : i32, %arg139 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "uge" %arg138, %arg139 : i32
  %3 = llvm.xor %arg137, %0 : i1
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_or_proof : xor_or_before ⊑ xor_or_after := by
  unfold xor_or_before xor_or_after
  simp_alive_peephole
  intros
  ---BEGIN xor_or
  apply xor_or_thm
  ---END xor_or



def and_orn_cmp_1_logical_before := [llvm|
{
^0(%arg128 : i32, %arg129 : i32, %arg130 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sgt" %arg128, %arg129 : i32
  %3 = llvm.icmp "sle" %arg128, %arg129 : i32
  %4 = "llvm.select"(%arg130, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%2, %4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def and_orn_cmp_1_logical_after := [llvm|
{
^0(%arg128 : i32, %arg129 : i32, %arg130 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "sgt" %arg128, %arg129 : i32
  %2 = "llvm.select"(%1, %arg130, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_orn_cmp_1_logical_proof : and_orn_cmp_1_logical_before ⊑ and_orn_cmp_1_logical_after := by
  unfold and_orn_cmp_1_logical_before and_orn_cmp_1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN and_orn_cmp_1_logical
  apply and_orn_cmp_1_logical_thm
  ---END and_orn_cmp_1_logical



def andn_or_cmp_2_logical_before := [llvm|
{
^0(%arg120 : i16, %arg121 : i16, %arg122 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sge" %arg120, %arg121 : i16
  %3 = llvm.icmp "slt" %arg120, %arg121 : i16
  %4 = "llvm.select"(%arg122, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%4, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def andn_or_cmp_2_logical_after := [llvm|
{
^0(%arg120 : i16, %arg121 : i16, %arg122 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "slt" %arg120, %arg121 : i16
  %2 = "llvm.select"(%arg122, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem andn_or_cmp_2_logical_proof : andn_or_cmp_2_logical_before ⊑ andn_or_cmp_2_logical_after := by
  unfold andn_or_cmp_2_logical_before andn_or_cmp_2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN andn_or_cmp_2_logical
  apply andn_or_cmp_2_logical_thm
  ---END andn_or_cmp_2_logical



def andn_or_cmp_2_partial_logical_before := [llvm|
{
^0(%arg117 : i16, %arg118 : i16, %arg119 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "sge" %arg117, %arg118 : i16
  %2 = llvm.icmp "slt" %arg117, %arg118 : i16
  %3 = llvm.or %1, %arg119 : i1
  %4 = "llvm.select"(%3, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def andn_or_cmp_2_partial_logical_after := [llvm|
{
^0(%arg117 : i16, %arg118 : i16, %arg119 : i1):
  %0 = llvm.icmp "slt" %arg117, %arg118 : i16
  %1 = llvm.and %arg119, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem andn_or_cmp_2_partial_logical_proof : andn_or_cmp_2_partial_logical_before ⊑ andn_or_cmp_2_partial_logical_after := by
  unfold andn_or_cmp_2_partial_logical_before andn_or_cmp_2_partial_logical_after
  simp_alive_peephole
  intros
  ---BEGIN andn_or_cmp_2_partial_logical
  apply andn_or_cmp_2_partial_logical_thm
  ---END andn_or_cmp_2_partial_logical



def bools_logical_commute0_before := [llvm|
{
^0(%arg108 : i1, %arg109 : i1, %arg110 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg110, %0 : i1
  %3 = "llvm.select"(%2, %arg108, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg110, %arg109, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_commute0_after := [llvm|
{
^0(%arg108 : i1, %arg109 : i1, %arg110 : i1):
  %0 = "llvm.select"(%arg110, %arg109, %arg108) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools_logical_commute0_proof : bools_logical_commute0_before ⊑ bools_logical_commute0_after := by
  unfold bools_logical_commute0_before bools_logical_commute0_after
  simp_alive_peephole
  intros
  ---BEGIN bools_logical_commute0
  apply bools_logical_commute0_thm
  ---END bools_logical_commute0



def bools_logical_commute0_and1_before := [llvm|
{
^0(%arg105 : i1, %arg106 : i1, %arg107 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg107, %0 : i1
  %3 = llvm.and %2, %arg105 : i1
  %4 = "llvm.select"(%arg107, %arg106, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_commute0_and1_after := [llvm|
{
^0(%arg105 : i1, %arg106 : i1, %arg107 : i1):
  %0 = "llvm.select"(%arg107, %arg106, %arg105) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools_logical_commute0_and1_proof : bools_logical_commute0_and1_before ⊑ bools_logical_commute0_and1_after := by
  unfold bools_logical_commute0_and1_before bools_logical_commute0_and1_after
  simp_alive_peephole
  intros
  ---BEGIN bools_logical_commute0_and1
  apply bools_logical_commute0_and1_thm
  ---END bools_logical_commute0_and1



def bools_logical_commute0_and2_before := [llvm|
{
^0(%arg102 : i1, %arg103 : i1, %arg104 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg104, %0 : i1
  %3 = "llvm.select"(%2, %arg102, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.and %arg104, %arg103 : i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_commute0_and2_after := [llvm|
{
^0(%arg102 : i1, %arg103 : i1, %arg104 : i1):
  %0 = "llvm.select"(%arg104, %arg103, %arg102) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools_logical_commute0_and2_proof : bools_logical_commute0_and2_before ⊑ bools_logical_commute0_and2_after := by
  unfold bools_logical_commute0_and2_before bools_logical_commute0_and2_after
  simp_alive_peephole
  intros
  ---BEGIN bools_logical_commute0_and2
  apply bools_logical_commute0_and2_thm
  ---END bools_logical_commute0_and2



def bools_logical_commute0_and1_and2_before := [llvm|
{
^0(%arg99 : i1, %arg100 : i1, %arg101 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg101, %0 : i1
  %2 = llvm.and %1, %arg99 : i1
  %3 = llvm.and %arg101, %arg100 : i1
  %4 = "llvm.select"(%2, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def bools_logical_commute0_and1_and2_after := [llvm|
{
^0(%arg99 : i1, %arg100 : i1, %arg101 : i1):
  %0 = "llvm.select"(%arg101, %arg100, %arg99) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools_logical_commute0_and1_and2_proof : bools_logical_commute0_and1_and2_before ⊑ bools_logical_commute0_and1_and2_after := by
  unfold bools_logical_commute0_and1_and2_before bools_logical_commute0_and1_and2_after
  simp_alive_peephole
  intros
  ---BEGIN bools_logical_commute0_and1_and2
  apply bools_logical_commute0_and1_and2_thm
  ---END bools_logical_commute0_and1_and2



def bools_logical_commute1_before := [llvm|
{
^0(%arg96 : i1, %arg97 : i1, %arg98 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg98, %0 : i1
  %3 = "llvm.select"(%arg96, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg98, %arg97, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_commute1_after := [llvm|
{
^0(%arg96 : i1, %arg97 : i1, %arg98 : i1):
  %0 = "llvm.select"(%arg98, %arg97, %arg96) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools_logical_commute1_proof : bools_logical_commute1_before ⊑ bools_logical_commute1_after := by
  unfold bools_logical_commute1_before bools_logical_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN bools_logical_commute1
  apply bools_logical_commute1_thm
  ---END bools_logical_commute1



def bools_logical_commute1_and2_before := [llvm|
{
^0(%arg91 : i1, %arg92 : i1, %arg93 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg93, %0 : i1
  %3 = "llvm.select"(%arg91, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.and %arg93, %arg92 : i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_commute1_and2_after := [llvm|
{
^0(%arg91 : i1, %arg92 : i1, %arg93 : i1):
  %0 = "llvm.select"(%arg93, %arg92, %arg91) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools_logical_commute1_and2_proof : bools_logical_commute1_and2_before ⊑ bools_logical_commute1_and2_after := by
  unfold bools_logical_commute1_and2_before bools_logical_commute1_and2_after
  simp_alive_peephole
  intros
  ---BEGIN bools_logical_commute1_and2
  apply bools_logical_commute1_and2_thm
  ---END bools_logical_commute1_and2



def bools_logical_commute3_and2_before := [llvm|
{
^0(%arg69 : i1, %arg70 : i1, %arg71 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg71, %0 : i1
  %3 = "llvm.select"(%arg69, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.and %arg70, %arg71 : i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_commute3_and2_after := [llvm|
{
^0(%arg69 : i1, %arg70 : i1, %arg71 : i1):
  %0 = "llvm.select"(%arg71, %arg70, %arg69) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools_logical_commute3_and2_proof : bools_logical_commute3_and2_before ⊑ bools_logical_commute3_and2_after := by
  unfold bools_logical_commute3_and2_before bools_logical_commute3_and2_after
  simp_alive_peephole
  intros
  ---BEGIN bools_logical_commute3_and2
  apply bools_logical_commute3_and2_thm
  ---END bools_logical_commute3_and2



def bools2_logical_commute0_before := [llvm|
{
^0(%arg64 : i1, %arg65 : i1, %arg66 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg66, %0 : i1
  %3 = "llvm.select"(%arg66, %arg64, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %arg65, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute0_after := [llvm|
{
^0(%arg64 : i1, %arg65 : i1, %arg66 : i1):
  %0 = "llvm.select"(%arg66, %arg64, %arg65) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools2_logical_commute0_proof : bools2_logical_commute0_before ⊑ bools2_logical_commute0_after := by
  unfold bools2_logical_commute0_before bools2_logical_commute0_after
  simp_alive_peephole
  intros
  ---BEGIN bools2_logical_commute0
  apply bools2_logical_commute0_thm
  ---END bools2_logical_commute0



def bools2_logical_commute0_and1_before := [llvm|
{
^0(%arg61 : i1, %arg62 : i1, %arg63 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg63, %0 : i1
  %3 = llvm.and %arg63, %arg61 : i1
  %4 = "llvm.select"(%2, %arg62, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute0_and1_after := [llvm|
{
^0(%arg61 : i1, %arg62 : i1, %arg63 : i1):
  %0 = "llvm.select"(%arg63, %arg61, %arg62) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools2_logical_commute0_and1_proof : bools2_logical_commute0_and1_before ⊑ bools2_logical_commute0_and1_after := by
  unfold bools2_logical_commute0_and1_before bools2_logical_commute0_and1_after
  simp_alive_peephole
  intros
  ---BEGIN bools2_logical_commute0_and1
  apply bools2_logical_commute0_and1_thm
  ---END bools2_logical_commute0_and1



def bools2_logical_commute0_and2_before := [llvm|
{
^0(%arg58 : i1, %arg59 : i1, %arg60 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg60, %0 : i1
  %3 = "llvm.select"(%arg60, %arg58, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.and %2, %arg59 : i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute0_and2_after := [llvm|
{
^0(%arg58 : i1, %arg59 : i1, %arg60 : i1):
  %0 = "llvm.select"(%arg60, %arg58, %arg59) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools2_logical_commute0_and2_proof : bools2_logical_commute0_and2_before ⊑ bools2_logical_commute0_and2_after := by
  unfold bools2_logical_commute0_and2_before bools2_logical_commute0_and2_after
  simp_alive_peephole
  intros
  ---BEGIN bools2_logical_commute0_and2
  apply bools2_logical_commute0_and2_thm
  ---END bools2_logical_commute0_and2



def bools2_logical_commute0_and1_and2_before := [llvm|
{
^0(%arg55 : i1, %arg56 : i1, %arg57 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg57, %0 : i1
  %2 = llvm.and %arg57, %arg55 : i1
  %3 = llvm.and %1, %arg56 : i1
  %4 = "llvm.select"(%2, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def bools2_logical_commute0_and1_and2_after := [llvm|
{
^0(%arg55 : i1, %arg56 : i1, %arg57 : i1):
  %0 = "llvm.select"(%arg57, %arg55, %arg56) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools2_logical_commute0_and1_and2_proof : bools2_logical_commute0_and1_and2_before ⊑ bools2_logical_commute0_and1_and2_after := by
  unfold bools2_logical_commute0_and1_and2_before bools2_logical_commute0_and1_and2_after
  simp_alive_peephole
  intros
  ---BEGIN bools2_logical_commute0_and1_and2
  apply bools2_logical_commute0_and1_and2_thm
  ---END bools2_logical_commute0_and1_and2



def bools2_logical_commute1_before := [llvm|
{
^0(%arg52 : i1, %arg53 : i1, %arg54 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg54, %0 : i1
  %3 = "llvm.select"(%arg52, %arg54, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %arg53, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute1_after := [llvm|
{
^0(%arg52 : i1, %arg53 : i1, %arg54 : i1):
  %0 = "llvm.select"(%arg54, %arg52, %arg53) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools2_logical_commute1_proof : bools2_logical_commute1_before ⊑ bools2_logical_commute1_after := by
  unfold bools2_logical_commute1_before bools2_logical_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN bools2_logical_commute1
  apply bools2_logical_commute1_thm
  ---END bools2_logical_commute1



def bools2_logical_commute1_and1_before := [llvm|
{
^0(%arg49 : i1, %arg50 : i1, %arg51 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg51, %0 : i1
  %3 = llvm.and %arg49, %arg51 : i1
  %4 = "llvm.select"(%2, %arg50, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute1_and1_after := [llvm|
{
^0(%arg49 : i1, %arg50 : i1, %arg51 : i1):
  %0 = "llvm.select"(%arg51, %arg49, %arg50) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools2_logical_commute1_and1_proof : bools2_logical_commute1_and1_before ⊑ bools2_logical_commute1_and1_after := by
  unfold bools2_logical_commute1_and1_before bools2_logical_commute1_and1_after
  simp_alive_peephole
  intros
  ---BEGIN bools2_logical_commute1_and1
  apply bools2_logical_commute1_and1_thm
  ---END bools2_logical_commute1_and1



def bools2_logical_commute1_and2_before := [llvm|
{
^0(%arg46 : i1, %arg47 : i1, %arg48 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg48, %0 : i1
  %3 = "llvm.select"(%arg46, %arg48, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.and %2, %arg47 : i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute1_and2_after := [llvm|
{
^0(%arg46 : i1, %arg47 : i1, %arg48 : i1):
  %0 = "llvm.select"(%arg48, %arg46, %arg47) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools2_logical_commute1_and2_proof : bools2_logical_commute1_and2_before ⊑ bools2_logical_commute1_and2_after := by
  unfold bools2_logical_commute1_and2_before bools2_logical_commute1_and2_after
  simp_alive_peephole
  intros
  ---BEGIN bools2_logical_commute1_and2
  apply bools2_logical_commute1_and2_thm
  ---END bools2_logical_commute1_and2



def bools2_logical_commute1_and1_and2_before := [llvm|
{
^0(%arg43 : i1, %arg44 : i1, %arg45 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg45, %0 : i1
  %2 = llvm.and %arg43, %arg45 : i1
  %3 = llvm.and %1, %arg44 : i1
  %4 = "llvm.select"(%2, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def bools2_logical_commute1_and1_and2_after := [llvm|
{
^0(%arg43 : i1, %arg44 : i1, %arg45 : i1):
  %0 = "llvm.select"(%arg45, %arg43, %arg44) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools2_logical_commute1_and1_and2_proof : bools2_logical_commute1_and1_and2_before ⊑ bools2_logical_commute1_and1_and2_after := by
  unfold bools2_logical_commute1_and1_and2_before bools2_logical_commute1_and1_and2_after
  simp_alive_peephole
  intros
  ---BEGIN bools2_logical_commute1_and1_and2
  apply bools2_logical_commute1_and1_and2_thm
  ---END bools2_logical_commute1_and1_and2



def bools2_logical_commute2_before := [llvm|
{
^0(%arg40 : i1, %arg41 : i1, %arg42 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg42, %0 : i1
  %3 = "llvm.select"(%arg42, %arg40, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg41, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute2_after := [llvm|
{
^0(%arg40 : i1, %arg41 : i1, %arg42 : i1):
  %0 = "llvm.select"(%arg42, %arg40, %arg41) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools2_logical_commute2_proof : bools2_logical_commute2_before ⊑ bools2_logical_commute2_after := by
  unfold bools2_logical_commute2_before bools2_logical_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN bools2_logical_commute2
  apply bools2_logical_commute2_thm
  ---END bools2_logical_commute2



def bools2_logical_commute2_and1_before := [llvm|
{
^0(%arg37 : i1, %arg38 : i1, %arg39 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg39, %0 : i1
  %3 = llvm.and %arg39, %arg37 : i1
  %4 = "llvm.select"(%arg38, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute2_and1_after := [llvm|
{
^0(%arg37 : i1, %arg38 : i1, %arg39 : i1):
  %0 = "llvm.select"(%arg39, %arg37, %arg38) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools2_logical_commute2_and1_proof : bools2_logical_commute2_and1_before ⊑ bools2_logical_commute2_and1_after := by
  unfold bools2_logical_commute2_and1_before bools2_logical_commute2_and1_after
  simp_alive_peephole
  intros
  ---BEGIN bools2_logical_commute2_and1
  apply bools2_logical_commute2_and1_thm
  ---END bools2_logical_commute2_and1



def bools2_logical_commute3_and1_before := [llvm|
{
^0(%arg24 : i1, %arg25 : i1, %arg26 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg26, %0 : i1
  %3 = llvm.and %arg24, %arg26 : i1
  %4 = "llvm.select"(%arg25, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute3_and1_after := [llvm|
{
^0(%arg24 : i1, %arg25 : i1, %arg26 : i1):
  %0 = "llvm.select"(%arg26, %arg24, %arg25) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools2_logical_commute3_and1_proof : bools2_logical_commute3_and1_before ⊑ bools2_logical_commute3_and1_after := by
  unfold bools2_logical_commute3_and1_before bools2_logical_commute3_and1_after
  simp_alive_peephole
  intros
  ---BEGIN bools2_logical_commute3_and1
  apply bools2_logical_commute3_and1_thm
  ---END bools2_logical_commute3_and1



def orn_and_cmp_1_logical_before := [llvm|
{
^0(%arg17 : i37, %arg18 : i37, %arg19 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sgt" %arg17, %arg18 : i37
  %3 = llvm.icmp "sle" %arg17, %arg18 : i37
  %4 = "llvm.select"(%arg19, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %1, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def orn_and_cmp_1_logical_after := [llvm|
{
^0(%arg17 : i37, %arg18 : i37, %arg19 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "sle" %arg17, %arg18 : i37
  %2 = "llvm.select"(%1, %0, %arg19) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem orn_and_cmp_1_logical_proof : orn_and_cmp_1_logical_before ⊑ orn_and_cmp_1_logical_after := by
  unfold orn_and_cmp_1_logical_before orn_and_cmp_1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN orn_and_cmp_1_logical
  apply orn_and_cmp_1_logical_thm
  ---END orn_and_cmp_1_logical



def orn_and_cmp_2_logical_before := [llvm|
{
^0(%arg9 : i16, %arg10 : i16, %arg11 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sge" %arg9, %arg10 : i16
  %3 = llvm.icmp "slt" %arg9, %arg10 : i16
  %4 = "llvm.select"(%arg11, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%4, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def orn_and_cmp_2_logical_after := [llvm|
{
^0(%arg9 : i16, %arg10 : i16, %arg11 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "slt" %arg9, %arg10 : i16
  %2 = "llvm.select"(%arg11, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem orn_and_cmp_2_logical_proof : orn_and_cmp_2_logical_before ⊑ orn_and_cmp_2_logical_after := by
  unfold orn_and_cmp_2_logical_before orn_and_cmp_2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN orn_and_cmp_2_logical
  apply orn_and_cmp_2_logical_thm
  ---END orn_and_cmp_2_logical



def orn_and_cmp_2_partial_logical_before := [llvm|
{
^0(%arg6 : i16, %arg7 : i16, %arg8 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "sge" %arg6, %arg7 : i16
  %2 = llvm.icmp "slt" %arg6, %arg7 : i16
  %3 = llvm.and %1, %arg8 : i1
  %4 = "llvm.select"(%3, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def orn_and_cmp_2_partial_logical_after := [llvm|
{
^0(%arg6 : i16, %arg7 : i16, %arg8 : i1):
  %0 = llvm.icmp "slt" %arg6, %arg7 : i16
  %1 = llvm.or %arg8, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem orn_and_cmp_2_partial_logical_proof : orn_and_cmp_2_partial_logical_before ⊑ orn_and_cmp_2_partial_logical_after := by
  unfold orn_and_cmp_2_partial_logical_before orn_and_cmp_2_partial_logical_after
  simp_alive_peephole
  intros
  ---BEGIN orn_and_cmp_2_partial_logical
  apply orn_and_cmp_2_partial_logical_thm
  ---END orn_and_cmp_2_partial_logical


