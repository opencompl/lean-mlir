
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
section gdebuginfohvariables_statements

def test_sext_zext_before := [llvm|
{
^0(%arg14 : i16):
  %0 = llvm.zext %arg14 : i16 to i32
  %1 = llvm.sext %0 : i32 to i64
  "llvm.return"(%1) : (i64) -> ()
}
]
def test_sext_zext_after := [llvm|
{
^0(%arg14 : i16):
  %0 = llvm.zext %arg14 : i16 to i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sext_zext_proof : test_sext_zext_before ⊑ test_sext_zext_after := by
  unfold test_sext_zext_before test_sext_zext_after
  simp_alive_peephole
  intros
  ---BEGIN test_sext_zext
  all_goals (try extract_goal ; sorry)
  ---END test_sext_zext



def test_cast_select_before := [llvm|
{
^0(%arg12 : i1):
  %0 = llvm.mlir.constant(3 : i16) : i16
  %1 = llvm.mlir.constant(5 : i16) : i16
  %2 = "llvm.select"(%arg12, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  %3 = llvm.zext %2 : i16 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test_cast_select_after := [llvm|
{
^0(%arg12 : i1):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = "llvm.select"(%arg12, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_cast_select_proof : test_cast_select_before ⊑ test_cast_select_after := by
  unfold test_cast_select_before test_cast_select_after
  simp_alive_peephole
  intros
  ---BEGIN test_cast_select
  all_goals (try extract_goal ; sorry)
  ---END test_cast_select


