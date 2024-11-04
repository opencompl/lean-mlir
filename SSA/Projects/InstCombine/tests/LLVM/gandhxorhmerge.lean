
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
section gandhxorhmerge_statements

def test1_before := [llvm|
{
^0(%arg9 : i32, %arg10 : i32, %arg11 : i32):
  %0 = llvm.and %arg11, %arg9 : i32
  %1 = llvm.and %arg11, %arg10 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg9 : i32, %arg10 : i32, %arg11 : i32):
  %0 = llvm.xor %arg9, %arg10 : i32
  %1 = llvm.and %arg11, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
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
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32):
  %0 = llvm.and %arg7, %arg6 : i32
  %1 = llvm.or %arg7, %arg6 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32):
  %0 = llvm.xor %arg7, %arg6 : i32
  "llvm.return"(%0) : (i32) -> ()
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



def PR38781_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.lshr %arg4, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = llvm.lshr %arg5, %0 : i32
  %5 = llvm.xor %4, %1 : i32
  %6 = llvm.and %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def PR38781_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg5, %arg4 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR38781_proof : PR38781_before ⊑ PR38781_after := by
  unfold PR38781_before PR38781_after
  simp_alive_peephole
  intros
  ---BEGIN PR38781
  all_goals (try extract_goal ; sorry)
  ---END PR38781



def PR75692_1_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(-5 : i32) : i32
  %2 = llvm.xor %arg3, %0 : i32
  %3 = llvm.xor %arg3, %1 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def PR75692_1_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR75692_1_proof : PR75692_1_before ⊑ PR75692_1_after := by
  unfold PR75692_1_before PR75692_1_after
  simp_alive_peephole
  intros
  ---BEGIN PR75692_1
  all_goals (try extract_goal ; sorry)
  ---END PR75692_1


