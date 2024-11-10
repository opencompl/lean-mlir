
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
section gsdivhcanonicalize_statements

def test_sdiv_canonicalize_op0_before := [llvm|
{
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sub %0, %arg15 overflow<nsw> : i32
  %2 = llvm.sdiv %1, %arg16 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_sdiv_canonicalize_op0_after := [llvm|
{
^0(%arg15 : i32, %arg16 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sdiv %arg15, %arg16 : i32
  %2 = llvm.sub %0, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sdiv_canonicalize_op0_proof : test_sdiv_canonicalize_op0_before ⊑ test_sdiv_canonicalize_op0_after := by
  unfold test_sdiv_canonicalize_op0_before test_sdiv_canonicalize_op0_after
  simp_alive_peephole
  intros
  ---BEGIN test_sdiv_canonicalize_op0
  all_goals (try extract_goal ; sorry)
  ---END test_sdiv_canonicalize_op0



def test_sdiv_canonicalize_op0_exact_before := [llvm|
{
^0(%arg13 : i32, %arg14 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sub %0, %arg13 overflow<nsw> : i32
  %2 = llvm.sdiv exact %1, %arg14 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_sdiv_canonicalize_op0_exact_after := [llvm|
{
^0(%arg13 : i32, %arg14 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sdiv exact %arg13, %arg14 : i32
  %2 = llvm.sub %0, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sdiv_canonicalize_op0_exact_proof : test_sdiv_canonicalize_op0_exact_before ⊑ test_sdiv_canonicalize_op0_exact_after := by
  unfold test_sdiv_canonicalize_op0_exact_before test_sdiv_canonicalize_op0_exact_after
  simp_alive_peephole
  intros
  ---BEGIN test_sdiv_canonicalize_op0_exact
  all_goals (try extract_goal ; sorry)
  ---END test_sdiv_canonicalize_op0_exact


