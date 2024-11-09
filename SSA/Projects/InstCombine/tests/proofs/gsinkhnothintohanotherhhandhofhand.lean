import SSA.Projects.InstCombine.tests.proofs.gsinkhnothintohanotherhhandhofhand_proof
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
section gsinkhnothintohanotherhhandhofhand_statements

def t0_before := [llvm|
{
^0(%arg30 : i1, %arg31 : i8, %arg32 : i8, %arg33 : i8, %arg34 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "eq" %arg31, %arg32 : i8
  %2 = llvm.xor %arg30, %0 : i1
  %3 = llvm.and %2, %1 : i1
  %4 = "llvm.select"(%3, %arg33, %arg34) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg30 : i1, %arg31 : i8, %arg32 : i8, %arg33 : i8, %arg34 : i8):
  %0 = llvm.icmp "ne" %arg31, %arg32 : i8
  %1 = llvm.or %0, %arg30 : i1
  %2 = "llvm.select"(%1, %arg34, %arg33) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  intros
  ---BEGIN t0
  apply t0_thm
  ---END t0



def n2_before := [llvm|
{
^0(%arg19 : i1, %arg20 : i8, %arg21 : i8, %arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "eq" %arg20, %arg21 : i8
  %2 = llvm.xor %arg19, %0 : i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def n2_after := [llvm|
{
^0(%arg19 : i1, %arg20 : i8, %arg21 : i8, %arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "eq" %arg20, %arg21 : i8
  %2 = llvm.xor %arg19, %0 : i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n2_proof : n2_before ⊑ n2_after := by
  unfold n2_before n2_after
  simp_alive_peephole
  intros
  ---BEGIN n2
  apply n2_thm
  ---END n2


