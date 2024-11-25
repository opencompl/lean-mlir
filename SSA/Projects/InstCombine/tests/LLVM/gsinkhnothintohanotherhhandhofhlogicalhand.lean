
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
section gsinkhnothintohanotherhhandhofhlogicalhand_statements

def t0_before := [llvm|
{
^0(%arg41 : i1, %arg42 : i8, %arg43 : i8, %arg44 : i8, %arg45 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg42, %arg43 : i8
  %3 = llvm.xor %arg41, %0 : i1
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%4, %arg44, %arg45) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg41 : i1, %arg42 : i8, %arg43 : i8, %arg44 : i8, %arg45 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "ne" %arg42, %arg43 : i8
  %2 = "llvm.select"(%arg41, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%2, %arg45, %arg44) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  intros
  ---BEGIN t0
  all_goals (try extract_goal ; sorry)
  ---END t0



def t0_commutative_before := [llvm|
{
^0(%arg36 : i1, %arg37 : i8, %arg38 : i8, %arg39 : i8, %arg40 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg37, %arg38 : i8
  %3 = llvm.xor %arg36, %0 : i1
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%4, %arg39, %arg40) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def t0_commutative_after := [llvm|
{
^0(%arg36 : i1, %arg37 : i8, %arg38 : i8, %arg39 : i8, %arg40 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "ne" %arg37, %arg38 : i8
  %2 = "llvm.select"(%1, %0, %arg36) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%2, %arg40, %arg39) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_commutative_proof : t0_commutative_before ⊑ t0_commutative_after := by
  unfold t0_commutative_before t0_commutative_after
  simp_alive_peephole
  intros
  ---BEGIN t0_commutative
  all_goals (try extract_goal ; sorry)
  ---END t0_commutative


