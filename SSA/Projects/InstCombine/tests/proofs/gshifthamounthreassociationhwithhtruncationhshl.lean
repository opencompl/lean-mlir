import SSA.Projects.InstCombine.tests.proofs.gshifthamounthreassociationhwithhtruncationhshl_proof
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
section gshifthamounthreassociationhwithhtruncationhshl_statements

def t0_before := [llvm|
{
^0(%arg23 : i32, %arg24 : i16):
  %0 = llvm.mlir.constant(32 : i16) : i16
  %1 = llvm.mlir.constant(-24 : i16) : i16
  %2 = llvm.sub %0, %arg24 : i16
  %3 = llvm.zext %2 : i16 to i32
  %4 = llvm.shl %arg23, %3 : i32
  %5 = llvm.trunc %4 : i32 to i16
  %6 = llvm.add %arg24, %1 : i16
  %7 = llvm.shl %5, %6 : i16
  "llvm.return"(%7) : (i16) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg23 : i32, %arg24 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.trunc %arg23 : i32 to i16
  %2 = llvm.shl %1, %0 : i16
  "llvm.return"(%2) : (i16) -> ()
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



def n11_before := [llvm|
{
^0(%arg5 : i32, %arg6 : i16):
  %0 = llvm.mlir.constant(30 : i16) : i16
  %1 = llvm.mlir.constant(-31 : i16) : i16
  %2 = llvm.sub %0, %arg6 : i16
  %3 = llvm.zext %2 : i16 to i32
  %4 = llvm.shl %arg5, %3 : i32
  %5 = llvm.trunc %4 : i32 to i16
  %6 = llvm.add %arg6, %1 : i16
  %7 = llvm.shl %5, %6 : i16
  "llvm.return"(%7) : (i16) -> ()
}
]
def n11_after := [llvm|
{
^0(%arg5 : i32, %arg6 : i16):
  %0 = llvm.mlir.constant(30 : i16) : i16
  %1 = llvm.mlir.constant(-31 : i16) : i16
  %2 = llvm.sub %0, %arg6 : i16
  %3 = llvm.zext nneg %2 : i16 to i32
  %4 = llvm.shl %arg5, %3 : i32
  %5 = llvm.trunc %4 : i32 to i16
  %6 = llvm.add %arg6, %1 : i16
  %7 = llvm.shl %5, %6 : i16
  "llvm.return"(%7) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n11_proof : n11_before ⊑ n11_after := by
  unfold n11_before n11_after
  simp_alive_peephole
  intros
  ---BEGIN n11
  apply n11_thm
  ---END n11


