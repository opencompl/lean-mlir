import SSA.Projects.InstCombine.lean.gshlhbo_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def lshr_add_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %2 = llvm.srem %arg0, %0 : i8
  %3 = llvm.lshr %arg1, %1 : i8
  %4 = llvm.add %3, %2 : i8
  %5 = llvm.shl %4, %1 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_add_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = -32 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.add %4, %arg1 : i8
  %6 = llvm.and %5, %2 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
theorem lshr_add_proof : lshr_add_before ⊑ lshr_add_after := by
  unfold lshr_add_before lshr_add_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_add
  apply lshr_add_thm
  ---END lshr_add



def lshr_and_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %2 = llvm.srem %arg0, %0 : i8
  %3 = llvm.lshr %arg1, %1 : i8
  %4 = llvm.and %3, %2 : i8
  %5 = llvm.shl %4, %1 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_and_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %2 = llvm.srem %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  %4 = llvm.and %3, %arg1 : i8
  "llvm.return"(%4) : (i8) -> ()
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



def lshr_or_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %2 = llvm.srem %arg0, %0 : i8
  %3 = llvm.lshr %arg1, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = llvm.shl %4, %1 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_or_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = -16 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg1, %2 : i8
  %6 = llvm.or %4, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
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



def lshr_xor_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = llvm.srem %arg0, %0 : i8
  %3 = llvm.lshr %arg1, %1 : i8
  %4 = llvm.xor %3, %2 : i8
  %5 = llvm.shl %4, %1 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_xor_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = -8 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg1, %2 : i8
  %6 = llvm.xor %4, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
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



def lshr_and_add_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 12 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.lshr %arg1, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.add %3, %5 : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def lshr_and_add_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 96 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg1, %2 : i8
  %6 = llvm.add %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
theorem lshr_and_add_proof : lshr_and_add_before ⊑ lshr_and_add_after := by
  unfold lshr_and_add_before lshr_and_add_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_and_add
  apply lshr_and_add_thm
  ---END lshr_and_add



def lshr_and_and_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 13 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.lshr %arg1, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.and %5, %3 : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def lshr_and_and_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 52 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg1, %2 : i8
  %6 = llvm.and %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
theorem lshr_and_and_proof : lshr_and_and_before ⊑ lshr_and_and_after := by
  unfold lshr_and_and_before lshr_and_and_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_and_and
  apply lshr_and_and_thm
  ---END lshr_and_and



def lshr_and_or_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 13 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.lshr %arg1, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.or %3, %5 : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def lshr_and_or_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 52 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg1, %2 : i8
  %6 = llvm.or %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
theorem lshr_and_or_proof : lshr_and_or_before ⊑ lshr_and_or_after := by
  unfold lshr_and_or_before lshr_and_or_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_and_or
  apply lshr_and_or_thm
  ---END lshr_and_or



def lshr_and_or_disjoint_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 13 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.lshr %arg1, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.or %3, %5 : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def lshr_and_or_disjoint_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 52 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg1, %2 : i8
  %6 = llvm.or %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
theorem lshr_and_or_disjoint_proof : lshr_and_or_disjoint_before ⊑ lshr_and_or_disjoint_after := by
  unfold lshr_and_or_disjoint_before lshr_and_or_disjoint_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_and_or_disjoint
  apply lshr_and_or_disjoint_thm
  ---END lshr_and_or_disjoint



def ashr_and_or_disjoint_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 13 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.ashr %arg1, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.or %3, %5 : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def ashr_and_or_disjoint_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 52 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg1, %2 : i8
  %6 = llvm.or %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
theorem ashr_and_or_disjoint_proof : ashr_and_or_disjoint_before ⊑ ashr_and_or_disjoint_after := by
  unfold ashr_and_or_disjoint_before ashr_and_or_disjoint_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN ashr_and_or_disjoint
  apply ashr_and_or_disjoint_thm
  ---END ashr_and_or_disjoint



def lshr_and_xor_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 13 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.lshr %arg1, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.xor %5, %3 : i8
  %7 = llvm.shl %6, %1 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def lshr_and_xor_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = 52 : i8}> : () -> i8
  %3 = llvm.srem %arg0, %0 : i8
  %4 = llvm.shl %3, %1 : i8
  %5 = llvm.and %arg1, %2 : i8
  %6 = llvm.xor %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
theorem lshr_and_xor_proof : lshr_and_xor_before ⊑ lshr_and_xor_after := by
  unfold lshr_and_xor_before lshr_and_xor_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_and_xor
  apply lshr_and_xor_thm
  ---END lshr_and_xor



def lshr_add_and_shl_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 127 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %arg1, %3 : i32
  %5 = llvm.shl %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lshr_add_and_shl_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4064 : i32}> : () -> i32
  %2 = llvm.shl %arg1, %0 : i32
  %3 = llvm.and %arg0, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem lshr_add_and_shl_proof : lshr_add_and_shl_before ⊑ lshr_add_and_shl_after := by
  unfold lshr_add_and_shl_before lshr_add_and_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN lshr_add_and_shl
  apply lshr_add_and_shl_thm
  ---END lshr_add_and_shl



def shl_add_and_lshr_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %3, %arg1 : i32
  %5 = llvm.shl %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def shl_add_and_lshr_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg1, %0 : i32
  %3 = llvm.and %arg0, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem shl_add_and_lshr_proof : shl_add_and_lshr_before ⊑ shl_add_and_lshr_after := by
  unfold shl_add_and_lshr_before shl_add_and_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN shl_add_and_lshr
  apply shl_add_and_lshr_thm
  ---END shl_add_and_lshr


