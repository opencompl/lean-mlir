
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
section gmodulo_statements

def modulo2_before := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.srem %arg10, %0 : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  %4 = "llvm.select"(%3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %4, %2 overflow<nsw> : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def modulo2_after := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.and %arg10, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem modulo2_proof : modulo2_before ⊑ modulo2_after := by
  unfold modulo2_before modulo2_after
  simp_alive_peephole
  intros
  ---BEGIN modulo2
  all_goals (try extract_goal ; sorry)
  ---END modulo2



def modulo4_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.srem %arg6, %0 : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  %4 = "llvm.select"(%3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %4, %2 overflow<nsw> : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def modulo4_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.and %arg6, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem modulo4_proof : modulo4_before ⊑ modulo4_after := by
  unfold modulo4_before modulo4_after
  simp_alive_peephole
  intros
  ---BEGIN modulo4
  all_goals (try extract_goal ; sorry)
  ---END modulo4



def modulo32_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.srem %arg2, %0 : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  %4 = "llvm.select"(%3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %4, %2 overflow<nsw> : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def modulo32_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.and %arg2, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem modulo32_proof : modulo32_before ⊑ modulo32_after := by
  unfold modulo32_before modulo32_after
  simp_alive_peephole
  intros
  ---BEGIN modulo32
  all_goals (try extract_goal ; sorry)
  ---END modulo32


