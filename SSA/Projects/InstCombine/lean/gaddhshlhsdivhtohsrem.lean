import SSA.Projects.InstCombine.lean.gaddhshlhsdivhtohsrem_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def add-shl-sdiv-scalar0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.sdiv %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  %4 = llvm.add %3, %arg0 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def add-shl-sdiv-scalar0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = llvm.srem %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem add-shl-sdiv-scalar0_proof : add-shl-sdiv-scalar0_before ⊑ add-shl-sdiv-scalar0_after := by
  unfold add-shl-sdiv-scalar0_before add-shl-sdiv-scalar0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add-shl-sdiv-scalar0
  all_goals (try extract_goal ; sorry)
  ---END add-shl-sdiv-scalar0



def add-shl-sdiv-scalar1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = -64 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %2 = llvm.sdiv %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  %4 = llvm.add %3, %arg0 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def add-shl-sdiv-scalar1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{value = 64 : i8}> : () -> i8
  %1 = llvm.srem %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem add-shl-sdiv-scalar1_proof : add-shl-sdiv-scalar1_before ⊑ add-shl-sdiv-scalar1_after := by
  unfold add-shl-sdiv-scalar1_before add-shl-sdiv-scalar1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add-shl-sdiv-scalar1
  all_goals (try extract_goal ; sorry)
  ---END add-shl-sdiv-scalar1



def add-shl-sdiv-scalar2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1073741824 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 30 : i32}> : () -> i32
  %2 = llvm.sdiv %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.add %3, %arg0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add-shl-sdiv-scalar2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1073741824 : i32}> : () -> i32
  %1 = llvm.srem %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem add-shl-sdiv-scalar2_proof : add-shl-sdiv-scalar2_before ⊑ add-shl-sdiv-scalar2_after := by
  unfold add-shl-sdiv-scalar2_before add-shl-sdiv-scalar2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add-shl-sdiv-scalar2
  all_goals (try extract_goal ; sorry)
  ---END add-shl-sdiv-scalar2



def add-shl-sdiv-negative1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.sdiv %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.add %3, %arg0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add-shl-sdiv-negative1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem add-shl-sdiv-negative1_proof : add-shl-sdiv-negative1_before ⊑ add-shl-sdiv-negative1_after := by
  unfold add-shl-sdiv-negative1_before add-shl-sdiv-negative1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add-shl-sdiv-negative1
  all_goals (try extract_goal ; sorry)
  ---END add-shl-sdiv-negative1


