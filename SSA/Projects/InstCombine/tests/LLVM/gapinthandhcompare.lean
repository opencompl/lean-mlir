
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
section gapinthandhcompare_statements

def test1_before := [llvm|
{
^0(%arg2 : i33, %arg3 : i33):
  %0 = llvm.mlir.constant(65280 : i33) : i33
  %1 = llvm.and %arg2, %0 : i33
  %2 = llvm.and %arg3, %0 : i33
  %3 = llvm.icmp "ne" %1, %2 : i33
  "llvm.return"(%3) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg2 : i33, %arg3 : i33):
  %0 = llvm.mlir.constant(65280 : i33) : i33
  %1 = llvm.mlir.constant(0 : i33) : i33
  %2 = llvm.xor %arg2, %arg3 : i33
  %3 = llvm.and %2, %0 : i33
  %4 = llvm.icmp "ne" %3, %1 : i33
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test2_before := [llvm|
{
^0(%arg0 : i999, %arg1 : i999):
  %0 = llvm.mlir.constant(65280 : i999) : i999
  %1 = llvm.and %arg0, %0 : i999
  %2 = llvm.and %arg1, %0 : i999
  %3 = llvm.icmp "ne" %1, %2 : i999
  "llvm.return"(%3) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i999, %arg1 : i999):
  %0 = llvm.mlir.constant(65280 : i999) : i999
  %1 = llvm.mlir.constant(0 : i999) : i999
  %2 = llvm.xor %arg0, %arg1 : i999
  %3 = llvm.and %2, %0 : i999
  %4 = llvm.icmp "ne" %3, %1 : i999
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  intros
  ---BEGIN test2
  all_goals (try extract_goal ; sorry)
  ---END test2


