import SSA.Projects.InstCombine.tests.proofs.gselecthicmphandhzerohshl_proof
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
section gselecthicmphandhzerohshl_statements

def test_eq_before := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg11, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.shl %arg11, %2 : i32
  %6 = "llvm.select"(%4, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_eq_after := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.shl %arg11, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_eq_proof : test_eq_before ⊑ test_eq_after := by
  unfold test_eq_before test_eq_after
  simp_alive_peephole
  intros
  ---BEGIN test_eq
  apply test_eq_thm
  ---END test_eq



def test_ne_before := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg9, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.shl %arg9, %2 : i32
  %6 = "llvm.select"(%4, %5, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_ne_after := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.shl %arg9, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_ne_proof : test_ne_before ⊑ test_ne_after := by
  unfold test_ne_before test_ne_after
  simp_alive_peephole
  intros
  ---BEGIN test_ne
  apply test_ne_thm
  ---END test_ne



def test_nuw_dropped_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg7, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.shl %arg7, %2 overflow<nuw> : i32
  %6 = "llvm.select"(%4, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_nuw_dropped_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.shl %arg7, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_nuw_dropped_proof : test_nuw_dropped_before ⊑ test_nuw_dropped_after := by
  unfold test_nuw_dropped_before test_nuw_dropped_after
  simp_alive_peephole
  intros
  ---BEGIN test_nuw_dropped
  apply test_nuw_dropped_thm
  ---END test_nuw_dropped



def test_nsw_dropped_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg6, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.shl %arg6, %2 overflow<nsw> : i32
  %6 = "llvm.select"(%4, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_nsw_dropped_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.shl %arg6, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_nsw_dropped_proof : test_nsw_dropped_before ⊑ test_nsw_dropped_after := by
  unfold test_nsw_dropped_before test_nsw_dropped_after
  simp_alive_peephole
  intros
  ---BEGIN test_nsw_dropped
  apply test_nsw_dropped_thm
  ---END test_nsw_dropped



def neg_test_icmp_non_equality_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg2, %0 : i32
  %4 = llvm.icmp "slt" %3, %1 : i32
  %5 = llvm.shl %arg2, %2 : i32
  %6 = "llvm.select"(%4, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def neg_test_icmp_non_equality_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.shl %arg2, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_test_icmp_non_equality_proof : neg_test_icmp_non_equality_before ⊑ neg_test_icmp_non_equality_after := by
  unfold neg_test_icmp_non_equality_before neg_test_icmp_non_equality_after
  simp_alive_peephole
  intros
  ---BEGIN neg_test_icmp_non_equality
  apply neg_test_icmp_non_equality_thm
  ---END neg_test_icmp_non_equality


