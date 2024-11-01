import SSA.Projects.InstCombine.tests.proofs.gsinkhnothintohlogicalhor_proof
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
section gsinkhnothintohlogicalhor_statements

def t0_before := [llvm|
{
^0(%arg42 : i32, %arg43 : i32, %arg44 : i32, %arg45 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "eq" %arg42, %arg43 : i32
  %2 = llvm.icmp "eq" %arg44, %arg45 : i32
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.xor %3, %0 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg42 : i32, %arg43 : i32, %arg44 : i32, %arg45 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "ne" %arg42, %arg43 : i32
  %2 = llvm.icmp "ne" %arg44, %arg45 : i32
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
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
^0(%arg36 : i32, %arg37 : i32, %arg38 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "eq" %arg36, %arg37 : i32
  %2 = "llvm.select"(%arg38, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = llvm.xor %2, %0 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def n2_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i32, %arg38 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ne" %arg36, %arg37 : i32
  %3 = llvm.xor %arg38, %0 : i1
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
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


