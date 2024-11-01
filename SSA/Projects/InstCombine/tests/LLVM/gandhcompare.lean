
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
section gandhcompare_statements

def test1_before := [llvm|
{
^0(%arg24 : i32, %arg25 : i32):
  %0 = llvm.mlir.constant(65280 : i32) : i32
  %1 = llvm.and %arg24, %0 : i32
  %2 = llvm.and %arg25, %0 : i32
  %3 = llvm.icmp "ne" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg24 : i32, %arg25 : i32):
  %0 = llvm.mlir.constant(65280 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.xor %arg24, %arg25 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
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



def test_eq_0_and_15_add_1_before := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.add %arg5, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "eq" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_eq_0_and_15_add_1_after := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.and %arg5, %0 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_eq_0_and_15_add_1_proof : test_eq_0_and_15_add_1_before ⊑ test_eq_0_and_15_add_1_after := by
  unfold test_eq_0_and_15_add_1_before test_eq_0_and_15_add_1_after
  simp_alive_peephole
  intros
  ---BEGIN test_eq_0_and_15_add_1
  all_goals (try extract_goal ; sorry)
  ---END test_eq_0_and_15_add_1



def test_ne_0_and_15_add_1_before := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.add %arg4, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "ne" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_ne_0_and_15_add_1_after := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.and %arg4, %0 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_ne_0_and_15_add_1_proof : test_ne_0_and_15_add_1_before ⊑ test_ne_0_and_15_add_1_after := by
  unfold test_ne_0_and_15_add_1_before test_ne_0_and_15_add_1_after
  simp_alive_peephole
  intros
  ---BEGIN test_ne_0_and_15_add_1
  all_goals (try extract_goal ; sorry)
  ---END test_ne_0_and_15_add_1



def test_eq_0_and_15_add_3_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.add %arg3, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "eq" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_eq_0_and_15_add_3_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(13 : i8) : i8
  %2 = llvm.and %arg3, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_eq_0_and_15_add_3_proof : test_eq_0_and_15_add_3_before ⊑ test_eq_0_and_15_add_3_after := by
  unfold test_eq_0_and_15_add_3_before test_eq_0_and_15_add_3_after
  simp_alive_peephole
  intros
  ---BEGIN test_eq_0_and_15_add_3
  all_goals (try extract_goal ; sorry)
  ---END test_eq_0_and_15_add_3



def test_ne_0_and_15_add_3_before := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.add %arg2, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "ne" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_ne_0_and_15_add_3_after := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(13 : i8) : i8
  %2 = llvm.and %arg2, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_ne_0_and_15_add_3_proof : test_ne_0_and_15_add_3_before ⊑ test_ne_0_and_15_add_3_after := by
  unfold test_ne_0_and_15_add_3_before test_ne_0_and_15_add_3_after
  simp_alive_peephole
  intros
  ---BEGIN test_ne_0_and_15_add_3
  all_goals (try extract_goal ; sorry)
  ---END test_ne_0_and_15_add_3



def test_eq_11_and_15_add_10_before := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.mlir.constant(11 : i8) : i8
  %3 = llvm.add %arg1, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "eq" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_eq_11_and_15_add_10_after := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.and %arg1, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_eq_11_and_15_add_10_proof : test_eq_11_and_15_add_10_before ⊑ test_eq_11_and_15_add_10_after := by
  unfold test_eq_11_and_15_add_10_before test_eq_11_and_15_add_10_after
  simp_alive_peephole
  intros
  ---BEGIN test_eq_11_and_15_add_10
  all_goals (try extract_goal ; sorry)
  ---END test_eq_11_and_15_add_10



def test_ne_11_and_15_add_10_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.mlir.constant(11 : i8) : i8
  %3 = llvm.add %arg0, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.icmp "ne" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_ne_11_and_15_add_10_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_ne_11_and_15_add_10_proof : test_ne_11_and_15_add_10_before ⊑ test_ne_11_and_15_add_10_after := by
  unfold test_ne_11_and_15_add_10_before test_ne_11_and_15_add_10_after
  simp_alive_peephole
  intros
  ---BEGIN test_ne_11_and_15_add_10
  all_goals (try extract_goal ; sorry)
  ---END test_ne_11_and_15_add_10


