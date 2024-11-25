
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
section gapinthor_statements

def test1_before := [llvm|
{
^0(%arg5 : i23):
  %0 = llvm.mlir.constant(-1 : i23) : i23
  %1 = llvm.xor %0, %arg5 : i23
  %2 = llvm.or %arg5, %1 : i23
  "llvm.return"(%2) : (i23) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg5 : i23):
  %0 = llvm.mlir.constant(-1 : i23) : i23
  "llvm.return"(%0) : (i23) -> ()
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
^0(%arg3 : i39, %arg4 : i39):
  %0 = llvm.mlir.constant(274877906943 : i39) : i39
  %1 = llvm.mlir.constant(-1 : i39) : i39
  %2 = llvm.mlir.constant(-274877906944 : i39) : i39
  %3 = llvm.xor %0, %1 : i39
  %4 = llvm.and %arg4, %2 : i39
  %5 = llvm.add %arg3, %4 : i39
  %6 = llvm.and %5, %3 : i39
  %7 = llvm.and %arg3, %0 : i39
  %8 = llvm.or %6, %7 : i39
  "llvm.return"(%8) : (i39) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg3 : i39, %arg4 : i39):
  %0 = llvm.mlir.constant(-274877906944 : i39) : i39
  %1 = llvm.and %arg4, %0 : i39
  %2 = llvm.add %arg3, %1 : i39
  "llvm.return"(%2) : (i39) -> ()
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



def test4_before := [llvm|
{
^0(%arg2 : i1023):
  %0 = llvm.mlir.constant(-1 : i1023) : i1023
  %1 = llvm.xor %0, %arg2 : i1023
  %2 = llvm.or %arg2, %1 : i1023
  "llvm.return"(%2) : (i1023) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg2 : i1023):
  %0 = llvm.mlir.constant(-1 : i1023) : i1023
  "llvm.return"(%0) : (i1023) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  intros
  ---BEGIN test4
  all_goals (try extract_goal ; sorry)
  ---END test4



def test5_before := [llvm|
{
^0(%arg0 : i399, %arg1 : i399):
  %0 = llvm.mlir.constant(274877906943 : i399) : i399
  %1 = llvm.mlir.constant(-1 : i399) : i399
  %2 = llvm.mlir.constant(18446742974197923840 : i399) : i399
  %3 = llvm.xor %0, %1 : i399
  %4 = llvm.and %arg1, %2 : i399
  %5 = llvm.add %arg0, %4 : i399
  %6 = llvm.and %5, %3 : i399
  %7 = llvm.and %arg0, %0 : i399
  %8 = llvm.or %6, %7 : i399
  "llvm.return"(%8) : (i399) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i399, %arg1 : i399):
  %0 = llvm.mlir.constant(18446742974197923840 : i399) : i399
  %1 = llvm.and %arg1, %0 : i399
  %2 = llvm.add %arg0, %1 : i399
  "llvm.return"(%2) : (i399) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  intros
  ---BEGIN test5
  all_goals (try extract_goal ; sorry)
  ---END test5


