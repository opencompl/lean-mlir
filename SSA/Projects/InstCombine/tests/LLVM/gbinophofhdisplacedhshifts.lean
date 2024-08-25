import SSA.Projects.InstCombine.tests.LLVM.gbinophofhdisplacedhshifts_proof
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
                                                                       
def shl_or_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %3 = llvm.shl %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.or %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_or_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 22 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_or_proof : shl_or_before ⊑ shl_or_after := by
  unfold shl_or_before shl_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_or
  apply shl_or_thm
  ---END shl_or



def lshr_or_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %3 = llvm.lshr %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.lshr %2, %4 : i8
  %6 = llvm.or %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def lshr_or_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 17 : i8}> : () -> i8
  %1 = llvm.lshr %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem lshr_or_proof : lshr_or_before ⊑ lshr_or_after := by
  unfold lshr_or_before lshr_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_or
  apply lshr_or_thm
  ---END lshr_or



def ashr_or_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -64 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = -128 : i8}> : () -> i8
  %3 = llvm.ashr %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.ashr %2, %4 : i8
  %6 = llvm.or %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def ashr_or_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -64 : i8}> : () -> i8
  %1 = llvm.ashr %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem ashr_or_proof : ashr_or_before ⊑ ashr_or_after := by
  unfold ashr_or_before ashr_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN ashr_or
  apply ashr_or_thm
  ---END ashr_or



def shl_xor_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %3 = llvm.shl %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.xor %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_xor_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 22 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_xor_proof : shl_xor_before ⊑ shl_xor_after := by
  unfold shl_xor_before shl_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_xor
  apply shl_xor_thm
  ---END shl_xor



def lshr_xor_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %3 = llvm.lshr %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.lshr %2, %4 : i8
  %6 = llvm.xor %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def lshr_xor_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 17 : i8}> : () -> i8
  %1 = llvm.lshr %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem lshr_xor_proof : lshr_xor_before ⊑ lshr_xor_after := by
  unfold lshr_xor_before lshr_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_xor
  apply lshr_xor_thm
  ---END lshr_xor



def ashr_xor_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -128 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = -64 : i8}> : () -> i8
  %3 = llvm.ashr %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.ashr %2, %4 : i8
  %6 = llvm.xor %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def ashr_xor_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 96 : i8}> : () -> i8
  %1 = llvm.lshr %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem ashr_xor_proof : ashr_xor_before ⊑ ashr_xor_after := by
  unfold ashr_xor_before ashr_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN ashr_xor
  apply ashr_xor_thm
  ---END ashr_xor



def shl_and_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 48 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 8 : i8}> : () -> i8
  %3 = llvm.shl %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.and %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_and_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_and_proof : shl_and_before ⊑ shl_and_after := by
  unfold shl_and_before shl_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_and
  apply shl_and_thm
  ---END shl_and



def lshr_and_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 48 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 64 : i8}> : () -> i8
  %3 = llvm.lshr %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.lshr %2, %4 : i8
  %6 = llvm.and %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def lshr_and_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 32 : i8}> : () -> i8
  %1 = llvm.lshr %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem lshr_and_proof : lshr_and_before ⊑ lshr_and_after := by
  unfold lshr_and_before lshr_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_and
  apply lshr_and_thm
  ---END lshr_and



def ashr_and_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -64 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = -128 : i8}> : () -> i8
  %3 = llvm.ashr %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.ashr %2, %4 : i8
  %6 = llvm.and %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def ashr_and_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -64 : i8}> : () -> i8
  %1 = llvm.ashr %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem ashr_and_proof : ashr_and_before ⊑ ashr_and_after := by
  unfold ashr_and_before ashr_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN ashr_and
  apply ashr_and_thm
  ---END ashr_and



def shl_add_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %3 = llvm.shl %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.add %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_add_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 30 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_add_proof : shl_add_before ⊑ shl_add_after := by
  unfold shl_add_before shl_add_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_add
  apply shl_add_thm
  ---END shl_add



def shl_or_commuted_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %3 = llvm.shl %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.or %5, %3 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_or_commuted_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 22 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_or_commuted_proof : shl_or_commuted_before ⊑ shl_or_commuted_after := by
  unfold shl_or_commuted_before shl_or_commuted_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_or_commuted
  apply shl_or_commuted_thm
  ---END shl_or_commuted



def shl_or_with_or_disjoint_instead_of_add_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %3 = llvm.shl %0, %arg0 : i8
  %4 = llvm.or %arg0, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.or %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_or_with_or_disjoint_instead_of_add_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 22 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_or_with_or_disjoint_instead_of_add_proof : shl_or_with_or_disjoint_instead_of_add_before ⊑ shl_or_with_or_disjoint_instead_of_add_after := by
  unfold shl_or_with_or_disjoint_instead_of_add_before shl_or_with_or_disjoint_instead_of_add_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_or_with_or_disjoint_instead_of_add
  apply shl_or_with_or_disjoint_instead_of_add_thm
  ---END shl_or_with_or_disjoint_instead_of_add


