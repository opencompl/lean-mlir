
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
section gmax_known_bits_statements

def foo_before := [llvm|
{
^0(%arg8 : i16):
  %0 = llvm.mlir.constant(255 : i16) : i16
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.and %arg8, %0 : i16
  %3 = llvm.zext %2 : i16 to i32
  %4 = llvm.icmp "ult" %3, %1 : i32
  %5 = "llvm.select"(%4, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = llvm.trunc %5 : i32 to i16
  %7 = llvm.and %6, %0 : i16
  "llvm.return"(%7) : (i16) -> ()
}
]
def foo_after := [llvm|
{
^0(%arg8 : i16):
  %0 = llvm.mlir.constant(255 : i16) : i16
  %1 = llvm.and %arg8, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo_proof : foo_before ⊑ foo_after := by
  unfold foo_before foo_after
  simp_alive_peephole
  intros
  ---BEGIN foo
  all_goals (try extract_goal ; sorry)
  ---END foo


