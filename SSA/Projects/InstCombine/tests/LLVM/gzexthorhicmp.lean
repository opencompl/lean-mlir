
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
section gzexthorhicmp_statements

def zext_or_eq_ult_add_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(-3 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(5 : i32) : i32
  %3 = llvm.add %arg15, %0 : i32
  %4 = llvm.icmp "ult" %3, %1 : i32
  %5 = llvm.icmp "eq" %arg15, %2 : i32
  %6 = llvm.or %4, %5 : i1
  %7 = llvm.zext %6 : i1 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def zext_or_eq_ult_add_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(-3 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.add %arg15, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_or_eq_ult_add_proof : zext_or_eq_ult_add_before ⊑ zext_or_eq_ult_add_after := by
  unfold zext_or_eq_ult_add_before zext_or_eq_ult_add_after
  simp_alive_peephole
  intros
  ---BEGIN zext_or_eq_ult_add
  all_goals (try extract_goal ; sorry)
  ---END zext_or_eq_ult_add



def select_zext_or_eq_ult_add_before := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(-3 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(5 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.add %arg14, %0 : i32
  %5 = llvm.icmp "ult" %4, %1 : i32
  %6 = llvm.icmp "eq" %arg14, %2 : i32
  %7 = llvm.zext %6 : i1 to i32
  %8 = "llvm.select"(%5, %3, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def select_zext_or_eq_ult_add_after := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(-3 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.add %arg14, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_zext_or_eq_ult_add_proof : select_zext_or_eq_ult_add_before ⊑ select_zext_or_eq_ult_add_after := by
  unfold select_zext_or_eq_ult_add_before select_zext_or_eq_ult_add_after
  simp_alive_peephole
  intros
  ---BEGIN select_zext_or_eq_ult_add
  all_goals (try extract_goal ; sorry)
  ---END select_zext_or_eq_ult_add


