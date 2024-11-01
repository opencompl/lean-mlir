
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
section gsinkhnothintohlogicalhand_statements

def t0_before := [llvm|
{
^0(%arg45 : i32, %arg46 : i32, %arg47 : i32, %arg48 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "eq" %arg45, %arg46 : i32
  %3 = llvm.icmp "eq" %arg47, %arg48 : i32
  %4 = "llvm.select"(%3, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.xor %4, %1 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg45 : i32, %arg46 : i32, %arg47 : i32, %arg48 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "ne" %arg45, %arg46 : i32
  %2 = llvm.icmp "ne" %arg47, %arg48 : i32
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
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



def n2_before := [llvm|
{
^0(%arg39 : i32, %arg40 : i32, %arg41 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "eq" %arg39, %arg40 : i32
  %3 = "llvm.select"(%arg41, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.xor %3, %1 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def n2_after := [llvm|
{
^0(%arg39 : i32, %arg40 : i32, %arg41 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "ne" %arg39, %arg40 : i32
  %2 = llvm.xor %arg41, %0 : i1
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n2_proof : n2_before ⊑ n2_after := by
  unfold n2_before n2_after
  simp_alive_peephole
  intros
  ---BEGIN n2
  all_goals (try extract_goal ; sorry)
  ---END n2


