import SSA.Projects.InstCombine.tests.proofs.gselecthobohpeohops_proof
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
section gselecthobohpeohops_statements

def test_shl_nuw_nsw__all_are_safe_before := [llvm|
{
^0(%arg90 : i32, %arg91 : i64):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg90, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw,nuw> : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg91, %5 : i64
  %8 = "llvm.select"(%6, %arg91, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_shl_nuw_nsw__all_are_safe_after := [llvm|
{
^0(%arg90 : i32, %arg91 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(60 : i32) : i32
  %2 = llvm.shl %arg90, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg91, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl_nuw_nsw__all_are_safe_proof : test_shl_nuw_nsw__all_are_safe_before ⊑ test_shl_nuw_nsw__all_are_safe_after := by
  unfold test_shl_nuw_nsw__all_are_safe_before test_shl_nuw_nsw__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl_nuw_nsw__all_are_safe
  apply test_shl_nuw_nsw__all_are_safe_thm
  ---END test_shl_nuw_nsw__all_are_safe



def test_shl_nuw__all_are_safe_before := [llvm|
{
^0(%arg88 : i32, %arg89 : i64):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg88, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nuw> : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg89, %5 : i64
  %8 = "llvm.select"(%6, %arg89, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_shl_nuw__all_are_safe_after := [llvm|
{
^0(%arg88 : i32, %arg89 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(60 : i32) : i32
  %2 = llvm.shl %arg88, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg89, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl_nuw__all_are_safe_proof : test_shl_nuw__all_are_safe_before ⊑ test_shl_nuw__all_are_safe_after := by
  unfold test_shl_nuw__all_are_safe_before test_shl_nuw__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl_nuw__all_are_safe
  apply test_shl_nuw__all_are_safe_thm
  ---END test_shl_nuw__all_are_safe



def test_shl_nsw__all_are_safe_before := [llvm|
{
^0(%arg86 : i32, %arg87 : i64):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg86, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw> : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg87, %5 : i64
  %8 = "llvm.select"(%6, %arg87, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_shl_nsw__all_are_safe_after := [llvm|
{
^0(%arg86 : i32, %arg87 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(60 : i32) : i32
  %2 = llvm.shl %arg86, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg87, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl_nsw__all_are_safe_proof : test_shl_nsw__all_are_safe_before ⊑ test_shl_nsw__all_are_safe_after := by
  unfold test_shl_nsw__all_are_safe_before test_shl_nsw__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl_nsw__all_are_safe
  apply test_shl_nsw__all_are_safe_thm
  ---END test_shl_nsw__all_are_safe



def test_shl__all_are_safe_before := [llvm|
{
^0(%arg84 : i32, %arg85 : i64):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg84, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg85, %5 : i64
  %8 = "llvm.select"(%6, %arg85, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_shl__all_are_safe_after := [llvm|
{
^0(%arg84 : i32, %arg85 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(60 : i32) : i32
  %2 = llvm.shl %arg84, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg85, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl__all_are_safe_proof : test_shl__all_are_safe_before ⊑ test_shl__all_are_safe_after := by
  unfold test_shl__all_are_safe_before test_shl__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl__all_are_safe
  apply test_shl__all_are_safe_thm
  ---END test_shl__all_are_safe



def test_shl_nuw_nsw__nuw_is_safe_before := [llvm|
{
^0(%arg82 : i32, %arg83 : i64):
  %0 = llvm.mlir.constant(1073741822 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg82, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw,nuw> : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg83, %5 : i64
  %8 = "llvm.select"(%6, %arg83, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_shl_nuw_nsw__nuw_is_safe_after := [llvm|
{
^0(%arg82 : i32, %arg83 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-8 : i32) : i32
  %2 = llvm.shl %arg82, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg83, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl_nuw_nsw__nuw_is_safe_proof : test_shl_nuw_nsw__nuw_is_safe_before ⊑ test_shl_nuw_nsw__nuw_is_safe_after := by
  unfold test_shl_nuw_nsw__nuw_is_safe_before test_shl_nuw_nsw__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl_nuw_nsw__nuw_is_safe
  apply test_shl_nuw_nsw__nuw_is_safe_thm
  ---END test_shl_nuw_nsw__nuw_is_safe



def test_shl_nuw__nuw_is_safe_before := [llvm|
{
^0(%arg80 : i32, %arg81 : i64):
  %0 = llvm.mlir.constant(1073741822 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg80, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nuw> : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg81, %5 : i64
  %8 = "llvm.select"(%6, %arg81, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_shl_nuw__nuw_is_safe_after := [llvm|
{
^0(%arg80 : i32, %arg81 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-8 : i32) : i32
  %2 = llvm.shl %arg80, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg81, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl_nuw__nuw_is_safe_proof : test_shl_nuw__nuw_is_safe_before ⊑ test_shl_nuw__nuw_is_safe_after := by
  unfold test_shl_nuw__nuw_is_safe_before test_shl_nuw__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl_nuw__nuw_is_safe
  apply test_shl_nuw__nuw_is_safe_thm
  ---END test_shl_nuw__nuw_is_safe



def test_shl_nsw__nuw_is_safe_before := [llvm|
{
^0(%arg78 : i32, %arg79 : i64):
  %0 = llvm.mlir.constant(1073741822 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg78, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw> : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg79, %5 : i64
  %8 = "llvm.select"(%6, %arg79, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_shl_nsw__nuw_is_safe_after := [llvm|
{
^0(%arg78 : i32, %arg79 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-8 : i32) : i32
  %2 = llvm.shl %arg78, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg79, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl_nsw__nuw_is_safe_proof : test_shl_nsw__nuw_is_safe_before ⊑ test_shl_nsw__nuw_is_safe_after := by
  unfold test_shl_nsw__nuw_is_safe_before test_shl_nsw__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl_nsw__nuw_is_safe
  apply test_shl_nsw__nuw_is_safe_thm
  ---END test_shl_nsw__nuw_is_safe



def test_shl__nuw_is_safe_before := [llvm|
{
^0(%arg76 : i32, %arg77 : i64):
  %0 = llvm.mlir.constant(1073741822 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg76, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg77, %5 : i64
  %8 = "llvm.select"(%6, %arg77, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_shl__nuw_is_safe_after := [llvm|
{
^0(%arg76 : i32, %arg77 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-8 : i32) : i32
  %2 = llvm.shl %arg76, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg77, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl__nuw_is_safe_proof : test_shl__nuw_is_safe_before ⊑ test_shl__nuw_is_safe_after := by
  unfold test_shl__nuw_is_safe_before test_shl__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl__nuw_is_safe
  apply test_shl__nuw_is_safe_thm
  ---END test_shl__nuw_is_safe



def test_shl_nuw_nsw__nsw_is_safe_before := [llvm|
{
^0(%arg75 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(-83886079 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(-335544316 : i32) : i32
  %4 = llvm.or %arg75, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.shl %4, %2 overflow<nsw,nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %7, %4 : i32
  %9 = llvm.mul %8, %6 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def test_shl_nuw_nsw__nsw_is_safe_after := [llvm|
{
^0(%arg75 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl_nuw_nsw__nsw_is_safe_proof : test_shl_nuw_nsw__nsw_is_safe_before ⊑ test_shl_nuw_nsw__nsw_is_safe_after := by
  unfold test_shl_nuw_nsw__nsw_is_safe_before test_shl_nuw_nsw__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl_nuw_nsw__nsw_is_safe
  apply test_shl_nuw_nsw__nsw_is_safe_thm
  ---END test_shl_nuw_nsw__nsw_is_safe



def test_shl_nuw__nsw_is_safe_before := [llvm|
{
^0(%arg74 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(-83886079 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(-335544316 : i32) : i32
  %4 = llvm.or %arg74, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.shl %4, %2 overflow<nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %7, %4 : i32
  %9 = llvm.mul %8, %6 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def test_shl_nuw__nsw_is_safe_after := [llvm|
{
^0(%arg74 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl_nuw__nsw_is_safe_proof : test_shl_nuw__nsw_is_safe_before ⊑ test_shl_nuw__nsw_is_safe_after := by
  unfold test_shl_nuw__nsw_is_safe_before test_shl_nuw__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl_nuw__nsw_is_safe
  apply test_shl_nuw__nsw_is_safe_thm
  ---END test_shl_nuw__nsw_is_safe



def test_shl_nsw__nsw_is_safe_before := [llvm|
{
^0(%arg73 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(-83886079 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(-335544316 : i32) : i32
  %4 = llvm.or %arg73, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.shl %4, %2 overflow<nsw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %7, %4 : i32
  %9 = llvm.mul %8, %6 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def test_shl_nsw__nsw_is_safe_after := [llvm|
{
^0(%arg73 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.or %arg73, %0 : i32
  %3 = llvm.shl %2, %1 overflow<nsw> : i32
  %4 = llvm.mul %3, %2 : i32
  %5 = llvm.mul %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl_nsw__nsw_is_safe_proof : test_shl_nsw__nsw_is_safe_before ⊑ test_shl_nsw__nsw_is_safe_after := by
  unfold test_shl_nsw__nsw_is_safe_before test_shl_nsw__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl_nsw__nsw_is_safe
  apply test_shl_nsw__nsw_is_safe_thm
  ---END test_shl_nsw__nsw_is_safe



def test_shl__nsw_is_safe_before := [llvm|
{
^0(%arg72 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(-83886079 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(-335544316 : i32) : i32
  %4 = llvm.or %arg72, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.shl %4, %2 : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %8 = llvm.mul %7, %4 : i32
  %9 = llvm.mul %8, %6 : i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def test_shl__nsw_is_safe_after := [llvm|
{
^0(%arg72 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.or %arg72, %0 : i32
  %3 = llvm.shl %2, %1 overflow<nsw> : i32
  %4 = llvm.mul %3, %2 : i32
  %5 = llvm.mul %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl__nsw_is_safe_proof : test_shl__nsw_is_safe_before ⊑ test_shl__nsw_is_safe_after := by
  unfold test_shl__nsw_is_safe_before test_shl__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl__nsw_is_safe
  apply test_shl__nsw_is_safe_thm
  ---END test_shl__nsw_is_safe



def test_shl_nuw_nsw__none_are_safe_before := [llvm|
{
^0(%arg70 : i32, %arg71 : i64):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg70, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw,nuw> : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg71, %5 : i64
  %8 = "llvm.select"(%6, %arg71, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_shl_nuw_nsw__none_are_safe_after := [llvm|
{
^0(%arg70 : i32, %arg71 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-8 : i32) : i32
  %2 = llvm.shl %arg70, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg71, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl_nuw_nsw__none_are_safe_proof : test_shl_nuw_nsw__none_are_safe_before ⊑ test_shl_nuw_nsw__none_are_safe_after := by
  unfold test_shl_nuw_nsw__none_are_safe_before test_shl_nuw_nsw__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl_nuw_nsw__none_are_safe
  apply test_shl_nuw_nsw__none_are_safe_thm
  ---END test_shl_nuw_nsw__none_are_safe



def test_shl_nuw__none_are_safe_before := [llvm|
{
^0(%arg68 : i32, %arg69 : i64):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg68, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nuw> : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg69, %5 : i64
  %8 = "llvm.select"(%6, %arg69, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_shl_nuw__none_are_safe_after := [llvm|
{
^0(%arg68 : i32, %arg69 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-8 : i32) : i32
  %2 = llvm.shl %arg68, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg69, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl_nuw__none_are_safe_proof : test_shl_nuw__none_are_safe_before ⊑ test_shl_nuw__none_are_safe_after := by
  unfold test_shl_nuw__none_are_safe_before test_shl_nuw__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl_nuw__none_are_safe
  apply test_shl_nuw__none_are_safe_thm
  ---END test_shl_nuw__none_are_safe



def test_shl_nsw__none_are_safe_before := [llvm|
{
^0(%arg66 : i32, %arg67 : i64):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg66, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw> : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg67, %5 : i64
  %8 = "llvm.select"(%6, %arg67, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_shl_nsw__none_are_safe_after := [llvm|
{
^0(%arg66 : i32, %arg67 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-8 : i32) : i32
  %2 = llvm.shl %arg66, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg67, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl_nsw__none_are_safe_proof : test_shl_nsw__none_are_safe_before ⊑ test_shl_nsw__none_are_safe_after := by
  unfold test_shl_nsw__none_are_safe_before test_shl_nsw__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl_nsw__none_are_safe
  apply test_shl_nsw__none_are_safe_thm
  ---END test_shl_nsw__none_are_safe



def test_shl__none_are_safe_before := [llvm|
{
^0(%arg64 : i32, %arg65 : i64):
  %0 = llvm.mlir.constant(-2 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg64, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg65, %5 : i64
  %8 = "llvm.select"(%6, %arg65, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_shl__none_are_safe_after := [llvm|
{
^0(%arg64 : i32, %arg65 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-8 : i32) : i32
  %2 = llvm.shl %arg64, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg65, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_shl__none_are_safe_proof : test_shl__none_are_safe_before ⊑ test_shl__none_are_safe_after := by
  unfold test_shl__none_are_safe_before test_shl__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_shl__none_are_safe
  apply test_shl__none_are_safe_thm
  ---END test_shl__none_are_safe



def test_lshr_exact__exact_is_safe_before := [llvm|
{
^0(%arg62 : i32, %arg63 : i64):
  %0 = llvm.mlir.constant(60 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg62, %0 : i32
  %4 = llvm.lshr exact %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg63, %5 : i64
  %8 = "llvm.select"(%6, %arg63, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_lshr_exact__exact_is_safe_after := [llvm|
{
^0(%arg62 : i32, %arg63 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.lshr %arg62, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg63, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_lshr_exact__exact_is_safe_proof : test_lshr_exact__exact_is_safe_before ⊑ test_lshr_exact__exact_is_safe_after := by
  unfold test_lshr_exact__exact_is_safe_before test_lshr_exact__exact_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_lshr_exact__exact_is_safe
  apply test_lshr_exact__exact_is_safe_thm
  ---END test_lshr_exact__exact_is_safe



def test_lshr__exact_is_safe_before := [llvm|
{
^0(%arg60 : i32, %arg61 : i64):
  %0 = llvm.mlir.constant(60 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg60, %0 : i32
  %4 = llvm.lshr %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg61, %5 : i64
  %8 = "llvm.select"(%6, %arg61, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_lshr__exact_is_safe_after := [llvm|
{
^0(%arg60 : i32, %arg61 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.lshr %arg60, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg61, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_lshr__exact_is_safe_proof : test_lshr__exact_is_safe_before ⊑ test_lshr__exact_is_safe_after := by
  unfold test_lshr__exact_is_safe_before test_lshr__exact_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_lshr__exact_is_safe
  apply test_lshr__exact_is_safe_thm
  ---END test_lshr__exact_is_safe



def test_lshr_exact__exact_is_unsafe_before := [llvm|
{
^0(%arg58 : i32, %arg59 : i64):
  %0 = llvm.mlir.constant(63 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg58, %0 : i32
  %4 = llvm.lshr exact %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg59, %5 : i64
  %8 = "llvm.select"(%6, %arg59, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_lshr_exact__exact_is_unsafe_after := [llvm|
{
^0(%arg58 : i32, %arg59 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.lshr %arg58, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg59, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_lshr_exact__exact_is_unsafe_proof : test_lshr_exact__exact_is_unsafe_before ⊑ test_lshr_exact__exact_is_unsafe_after := by
  unfold test_lshr_exact__exact_is_unsafe_before test_lshr_exact__exact_is_unsafe_after
  simp_alive_peephole
  intros
  ---BEGIN test_lshr_exact__exact_is_unsafe
  apply test_lshr_exact__exact_is_unsafe_thm
  ---END test_lshr_exact__exact_is_unsafe



def test_lshr__exact_is_unsafe_before := [llvm|
{
^0(%arg56 : i32, %arg57 : i64):
  %0 = llvm.mlir.constant(63 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg56, %0 : i32
  %4 = llvm.lshr %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg57, %5 : i64
  %8 = "llvm.select"(%6, %arg57, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_lshr__exact_is_unsafe_after := [llvm|
{
^0(%arg56 : i32, %arg57 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.lshr %arg56, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg57, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_lshr__exact_is_unsafe_proof : test_lshr__exact_is_unsafe_before ⊑ test_lshr__exact_is_unsafe_after := by
  unfold test_lshr__exact_is_unsafe_before test_lshr__exact_is_unsafe_after
  simp_alive_peephole
  intros
  ---BEGIN test_lshr__exact_is_unsafe
  apply test_lshr__exact_is_unsafe_thm
  ---END test_lshr__exact_is_unsafe



def test_ashr_exact__exact_is_safe_before := [llvm|
{
^0(%arg54 : i32, %arg55 : i64):
  %0 = llvm.mlir.constant(-2147483588 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg54, %0 : i32
  %4 = llvm.ashr exact %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg55, %5 : i64
  %8 = "llvm.select"(%6, %arg55, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_ashr_exact__exact_is_safe_after := [llvm|
{
^0(%arg54 : i32, %arg55 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-536870897 : i32) : i32
  %2 = llvm.ashr %arg54, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg55, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_ashr_exact__exact_is_safe_proof : test_ashr_exact__exact_is_safe_before ⊑ test_ashr_exact__exact_is_safe_after := by
  unfold test_ashr_exact__exact_is_safe_before test_ashr_exact__exact_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_ashr_exact__exact_is_safe
  apply test_ashr_exact__exact_is_safe_thm
  ---END test_ashr_exact__exact_is_safe



def test_ashr__exact_is_safe_before := [llvm|
{
^0(%arg52 : i32, %arg53 : i64):
  %0 = llvm.mlir.constant(-2147483588 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg52, %0 : i32
  %4 = llvm.ashr %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg53, %5 : i64
  %8 = "llvm.select"(%6, %arg53, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_ashr__exact_is_safe_after := [llvm|
{
^0(%arg52 : i32, %arg53 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-536870897 : i32) : i32
  %2 = llvm.ashr %arg52, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg53, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_ashr__exact_is_safe_proof : test_ashr__exact_is_safe_before ⊑ test_ashr__exact_is_safe_after := by
  unfold test_ashr__exact_is_safe_before test_ashr__exact_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_ashr__exact_is_safe
  apply test_ashr__exact_is_safe_thm
  ---END test_ashr__exact_is_safe



def test_ashr_exact__exact_is_unsafe_before := [llvm|
{
^0(%arg50 : i32, %arg51 : i64):
  %0 = llvm.mlir.constant(-2147483585 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg50, %0 : i32
  %4 = llvm.ashr exact %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg51, %5 : i64
  %8 = "llvm.select"(%6, %arg51, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_ashr_exact__exact_is_unsafe_after := [llvm|
{
^0(%arg50 : i32, %arg51 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-536870897 : i32) : i32
  %2 = llvm.ashr %arg50, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg51, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_ashr_exact__exact_is_unsafe_proof : test_ashr_exact__exact_is_unsafe_before ⊑ test_ashr_exact__exact_is_unsafe_after := by
  unfold test_ashr_exact__exact_is_unsafe_before test_ashr_exact__exact_is_unsafe_after
  simp_alive_peephole
  intros
  ---BEGIN test_ashr_exact__exact_is_unsafe
  apply test_ashr_exact__exact_is_unsafe_thm
  ---END test_ashr_exact__exact_is_unsafe



def test_ashr__exact_is_unsafe_before := [llvm|
{
^0(%arg48 : i32, %arg49 : i64):
  %0 = llvm.mlir.constant(-2147483585 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg48, %0 : i32
  %4 = llvm.ashr %3, %1 : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.icmp "eq" %3, %2 : i32
  %7 = llvm.ashr %arg49, %5 : i64
  %8 = "llvm.select"(%6, %arg49, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%8) : (i64) -> ()
}
]
def test_ashr__exact_is_unsafe_after := [llvm|
{
^0(%arg48 : i32, %arg49 : i64):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-536870897 : i32) : i32
  %2 = llvm.ashr %arg48, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.zext nneg %3 : i32 to i64
  %5 = llvm.ashr %arg49, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_ashr__exact_is_unsafe_proof : test_ashr__exact_is_unsafe_before ⊑ test_ashr__exact_is_unsafe_after := by
  unfold test_ashr__exact_is_unsafe_before test_ashr__exact_is_unsafe_after
  simp_alive_peephole
  intros
  ---BEGIN test_ashr__exact_is_unsafe
  apply test_ashr__exact_is_unsafe_thm
  ---END test_ashr__exact_is_unsafe



def test_add_nuw_nsw__all_are_safe_before := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(4 : i32) : i32
  %4 = llvm.and %arg47, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.add %4, %2 overflow<nsw,nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_add_nuw_nsw__all_are_safe_after := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg47, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add_nuw_nsw__all_are_safe_proof : test_add_nuw_nsw__all_are_safe_before ⊑ test_add_nuw_nsw__all_are_safe_after := by
  unfold test_add_nuw_nsw__all_are_safe_before test_add_nuw_nsw__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add_nuw_nsw__all_are_safe
  apply test_add_nuw_nsw__all_are_safe_thm
  ---END test_add_nuw_nsw__all_are_safe



def test_add_nuw__all_are_safe_before := [llvm|
{
^0(%arg46 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(4 : i32) : i32
  %4 = llvm.and %arg46, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.add %4, %2 overflow<nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_add_nuw__all_are_safe_after := [llvm|
{
^0(%arg46 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg46, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add_nuw__all_are_safe_proof : test_add_nuw__all_are_safe_before ⊑ test_add_nuw__all_are_safe_after := by
  unfold test_add_nuw__all_are_safe_before test_add_nuw__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add_nuw__all_are_safe
  apply test_add_nuw__all_are_safe_thm
  ---END test_add_nuw__all_are_safe



def test_add_nsw__all_are_safe_before := [llvm|
{
^0(%arg45 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(4 : i32) : i32
  %4 = llvm.and %arg45, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.add %4, %2 overflow<nsw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_add_nsw__all_are_safe_after := [llvm|
{
^0(%arg45 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg45, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add_nsw__all_are_safe_proof : test_add_nsw__all_are_safe_before ⊑ test_add_nsw__all_are_safe_after := by
  unfold test_add_nsw__all_are_safe_before test_add_nsw__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add_nsw__all_are_safe
  apply test_add_nsw__all_are_safe_thm
  ---END test_add_nsw__all_are_safe



def test_add__all_are_safe_before := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(4 : i32) : i32
  %4 = llvm.and %arg44, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.add %4, %2 : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_add__all_are_safe_after := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg44, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add__all_are_safe_proof : test_add__all_are_safe_before ⊑ test_add__all_are_safe_after := by
  unfold test_add__all_are_safe_before test_add__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add__all_are_safe
  apply test_add__all_are_safe_thm
  ---END test_add__all_are_safe



def test_add_nuw_nsw__nuw_is_safe_before := [llvm|
{
^0(%arg43 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(-2147483648 : i32) : i32
  %3 = llvm.and %arg43, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = llvm.add %3, %1 overflow<nsw,nuw> : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_add_nuw_nsw__nuw_is_safe_after := [llvm|
{
^0(%arg43 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg43, %0 : i32
  %3 = llvm.add %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add_nuw_nsw__nuw_is_safe_proof : test_add_nuw_nsw__nuw_is_safe_before ⊑ test_add_nuw_nsw__nuw_is_safe_after := by
  unfold test_add_nuw_nsw__nuw_is_safe_before test_add_nuw_nsw__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add_nuw_nsw__nuw_is_safe
  apply test_add_nuw_nsw__nuw_is_safe_thm
  ---END test_add_nuw_nsw__nuw_is_safe



def test_add_nuw__nuw_is_safe_before := [llvm|
{
^0(%arg42 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(-2147483648 : i32) : i32
  %3 = llvm.and %arg42, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = llvm.add %3, %1 overflow<nuw> : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_add_nuw__nuw_is_safe_after := [llvm|
{
^0(%arg42 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg42, %0 : i32
  %3 = llvm.add %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add_nuw__nuw_is_safe_proof : test_add_nuw__nuw_is_safe_before ⊑ test_add_nuw__nuw_is_safe_after := by
  unfold test_add_nuw__nuw_is_safe_before test_add_nuw__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add_nuw__nuw_is_safe
  apply test_add_nuw__nuw_is_safe_thm
  ---END test_add_nuw__nuw_is_safe



def test_add_nsw__nuw_is_safe_before := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(-2147483648 : i32) : i32
  %3 = llvm.and %arg41, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = llvm.add %3, %1 overflow<nsw> : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_add_nsw__nuw_is_safe_after := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg41, %0 : i32
  %3 = llvm.add %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add_nsw__nuw_is_safe_proof : test_add_nsw__nuw_is_safe_before ⊑ test_add_nsw__nuw_is_safe_after := by
  unfold test_add_nsw__nuw_is_safe_before test_add_nsw__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add_nsw__nuw_is_safe
  apply test_add_nsw__nuw_is_safe_thm
  ---END test_add_nsw__nuw_is_safe



def test_add__nuw_is_safe_before := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(-2147483648 : i32) : i32
  %3 = llvm.and %arg40, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = llvm.add %3, %1 : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_add__nuw_is_safe_after := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg40, %0 : i32
  %3 = llvm.add %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add__nuw_is_safe_proof : test_add__nuw_is_safe_before ⊑ test_add__nuw_is_safe_after := by
  unfold test_add__nuw_is_safe_before test_add__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add__nuw_is_safe
  apply test_add__nuw_is_safe_thm
  ---END test_add__nuw_is_safe



def test_add_nuw_nsw__nsw_is_safe_before := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.or %arg39, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.add %4, %2 overflow<nsw,nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_add_nuw_nsw__nsw_is_safe_after := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.or %arg39, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add_nuw_nsw__nsw_is_safe_proof : test_add_nuw_nsw__nsw_is_safe_before ⊑ test_add_nuw_nsw__nsw_is_safe_after := by
  unfold test_add_nuw_nsw__nsw_is_safe_before test_add_nuw_nsw__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add_nuw_nsw__nsw_is_safe
  apply test_add_nuw_nsw__nsw_is_safe_thm
  ---END test_add_nuw_nsw__nsw_is_safe



def test_add_nuw__nsw_is_safe_before := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.or %arg38, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.add %4, %2 overflow<nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_add_nuw__nsw_is_safe_after := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.or %arg38, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add_nuw__nsw_is_safe_proof : test_add_nuw__nsw_is_safe_before ⊑ test_add_nuw__nsw_is_safe_after := by
  unfold test_add_nuw__nsw_is_safe_before test_add_nuw__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add_nuw__nsw_is_safe
  apply test_add_nuw__nsw_is_safe_thm
  ---END test_add_nuw__nsw_is_safe



def test_add_nsw__nsw_is_safe_before := [llvm|
{
^0(%arg37 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.or %arg37, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.add %4, %2 overflow<nsw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_add_nsw__nsw_is_safe_after := [llvm|
{
^0(%arg37 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.or %arg37, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add_nsw__nsw_is_safe_proof : test_add_nsw__nsw_is_safe_before ⊑ test_add_nsw__nsw_is_safe_after := by
  unfold test_add_nsw__nsw_is_safe_before test_add_nsw__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add_nsw__nsw_is_safe
  apply test_add_nsw__nsw_is_safe_thm
  ---END test_add_nsw__nsw_is_safe



def test_add__nsw_is_safe_before := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.or %arg36, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.add %4, %2 : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_add__nsw_is_safe_after := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.or %arg36, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add__nsw_is_safe_proof : test_add__nsw_is_safe_before ⊑ test_add__nsw_is_safe_after := by
  unfold test_add__nsw_is_safe_before test_add__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add__nsw_is_safe
  apply test_add__nsw_is_safe_thm
  ---END test_add__nsw_is_safe



def test_add_nuw_nsw__none_are_safe_before := [llvm|
{
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(4 : i32) : i32
  %3 = llvm.icmp "eq" %arg35, %0 : i32
  %4 = llvm.add %arg35, %1 overflow<nsw,nuw> : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test_add_nuw_nsw__none_are_safe_after := [llvm|
{
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.add %arg35, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add_nuw_nsw__none_are_safe_proof : test_add_nuw_nsw__none_are_safe_before ⊑ test_add_nuw_nsw__none_are_safe_after := by
  unfold test_add_nuw_nsw__none_are_safe_before test_add_nuw_nsw__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add_nuw_nsw__none_are_safe
  apply test_add_nuw_nsw__none_are_safe_thm
  ---END test_add_nuw_nsw__none_are_safe



def test_add_nuw__none_are_safe_before := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(4 : i32) : i32
  %3 = llvm.icmp "eq" %arg34, %0 : i32
  %4 = llvm.add %arg34, %1 overflow<nuw> : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test_add_nuw__none_are_safe_after := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.add %arg34, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add_nuw__none_are_safe_proof : test_add_nuw__none_are_safe_before ⊑ test_add_nuw__none_are_safe_after := by
  unfold test_add_nuw__none_are_safe_before test_add_nuw__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add_nuw__none_are_safe
  apply test_add_nuw__none_are_safe_thm
  ---END test_add_nuw__none_are_safe



def test_add_nsw__none_are_safe_before := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(4 : i32) : i32
  %3 = llvm.icmp "eq" %arg33, %0 : i32
  %4 = llvm.add %arg33, %1 overflow<nsw> : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test_add_nsw__none_are_safe_after := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.add %arg33, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add_nsw__none_are_safe_proof : test_add_nsw__none_are_safe_before ⊑ test_add_nsw__none_are_safe_after := by
  unfold test_add_nsw__none_are_safe_before test_add_nsw__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add_nsw__none_are_safe
  apply test_add_nsw__none_are_safe_thm
  ---END test_add_nsw__none_are_safe



def test_add__none_are_safe_before := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(4 : i32) : i32
  %3 = llvm.icmp "eq" %arg32, %0 : i32
  %4 = llvm.add %arg32, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test_add__none_are_safe_after := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.add %arg32, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_add__none_are_safe_proof : test_add__none_are_safe_before ⊑ test_add__none_are_safe_after := by
  unfold test_add__none_are_safe_before test_add__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_add__none_are_safe
  apply test_add__none_are_safe_thm
  ---END test_add__none_are_safe



def test_sub_nuw_nsw__all_are_safe_before := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.mlir.constant(-254 : i32) : i32
  %3 = llvm.mlir.constant(-260 : i32) : i32
  %4 = llvm.and %arg31, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.sub %2, %4 overflow<nsw,nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_sub_nuw_nsw__all_are_safe_after := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(-254 : i32) : i32
  %2 = llvm.and %arg31, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_nuw_nsw__all_are_safe_proof : test_sub_nuw_nsw__all_are_safe_before ⊑ test_sub_nuw_nsw__all_are_safe_after := by
  unfold test_sub_nuw_nsw__all_are_safe_before test_sub_nuw_nsw__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_nuw_nsw__all_are_safe
  apply test_sub_nuw_nsw__all_are_safe_thm
  ---END test_sub_nuw_nsw__all_are_safe



def test_sub_nuw__all_are_safe_before := [llvm|
{
^0(%arg30 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.mlir.constant(-254 : i32) : i32
  %3 = llvm.mlir.constant(-260 : i32) : i32
  %4 = llvm.and %arg30, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.sub %2, %4 overflow<nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_sub_nuw__all_are_safe_after := [llvm|
{
^0(%arg30 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(-254 : i32) : i32
  %2 = llvm.and %arg30, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_nuw__all_are_safe_proof : test_sub_nuw__all_are_safe_before ⊑ test_sub_nuw__all_are_safe_after := by
  unfold test_sub_nuw__all_are_safe_before test_sub_nuw__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_nuw__all_are_safe
  apply test_sub_nuw__all_are_safe_thm
  ---END test_sub_nuw__all_are_safe



def test_sub_nsw__all_are_safe_before := [llvm|
{
^0(%arg29 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.mlir.constant(-254 : i32) : i32
  %3 = llvm.mlir.constant(-260 : i32) : i32
  %4 = llvm.and %arg29, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.sub %2, %4 overflow<nsw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_sub_nsw__all_are_safe_after := [llvm|
{
^0(%arg29 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(-254 : i32) : i32
  %2 = llvm.and %arg29, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_nsw__all_are_safe_proof : test_sub_nsw__all_are_safe_before ⊑ test_sub_nsw__all_are_safe_after := by
  unfold test_sub_nsw__all_are_safe_before test_sub_nsw__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_nsw__all_are_safe
  apply test_sub_nsw__all_are_safe_thm
  ---END test_sub_nsw__all_are_safe



def test_sub__all_are_safe_before := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.mlir.constant(-254 : i32) : i32
  %3 = llvm.mlir.constant(-260 : i32) : i32
  %4 = llvm.and %arg28, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.sub %2, %4 : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_sub__all_are_safe_after := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(-254 : i32) : i32
  %2 = llvm.and %arg28, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub__all_are_safe_proof : test_sub__all_are_safe_before ⊑ test_sub__all_are_safe_after := by
  unfold test_sub__all_are_safe_before test_sub__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub__all_are_safe
  apply test_sub__all_are_safe_thm
  ---END test_sub__all_are_safe



def test_sub_nuw_nsw__nuw_is_safe_before := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1073741824 : i32) : i32
  %2 = llvm.mlir.constant(-2147483648 : i32) : i32
  %3 = llvm.and %arg27, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.sub %2, %3 overflow<nsw,nuw> : i32
  %6 = "llvm.select"(%4, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_sub_nuw_nsw__nuw_is_safe_after := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.and %arg27, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_nuw_nsw__nuw_is_safe_proof : test_sub_nuw_nsw__nuw_is_safe_before ⊑ test_sub_nuw_nsw__nuw_is_safe_after := by
  unfold test_sub_nuw_nsw__nuw_is_safe_before test_sub_nuw_nsw__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_nuw_nsw__nuw_is_safe
  apply test_sub_nuw_nsw__nuw_is_safe_thm
  ---END test_sub_nuw_nsw__nuw_is_safe



def test_sub_nuw__nuw_is_safe_before := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1073741824 : i32) : i32
  %2 = llvm.mlir.constant(-2147483648 : i32) : i32
  %3 = llvm.and %arg26, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.sub %2, %3 overflow<nuw> : i32
  %6 = "llvm.select"(%4, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_sub_nuw__nuw_is_safe_after := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.and %arg26, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_nuw__nuw_is_safe_proof : test_sub_nuw__nuw_is_safe_before ⊑ test_sub_nuw__nuw_is_safe_after := by
  unfold test_sub_nuw__nuw_is_safe_before test_sub_nuw__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_nuw__nuw_is_safe
  apply test_sub_nuw__nuw_is_safe_thm
  ---END test_sub_nuw__nuw_is_safe



def test_sub_nsw__nuw_is_safe_before := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1073741824 : i32) : i32
  %2 = llvm.mlir.constant(-2147483648 : i32) : i32
  %3 = llvm.and %arg25, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.sub %2, %3 overflow<nsw> : i32
  %6 = "llvm.select"(%4, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_sub_nsw__nuw_is_safe_after := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.and %arg25, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_nsw__nuw_is_safe_proof : test_sub_nsw__nuw_is_safe_before ⊑ test_sub_nsw__nuw_is_safe_after := by
  unfold test_sub_nsw__nuw_is_safe_before test_sub_nsw__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_nsw__nuw_is_safe
  apply test_sub_nsw__nuw_is_safe_thm
  ---END test_sub_nsw__nuw_is_safe



def test_sub__nuw_is_safe_before := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1073741824 : i32) : i32
  %2 = llvm.mlir.constant(-2147483648 : i32) : i32
  %3 = llvm.and %arg24, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.sub %2, %3 : i32
  %6 = "llvm.select"(%4, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_sub__nuw_is_safe_after := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.and %arg24, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub__nuw_is_safe_proof : test_sub__nuw_is_safe_before ⊑ test_sub__nuw_is_safe_after := by
  unfold test_sub__nuw_is_safe_before test_sub__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub__nuw_is_safe
  apply test_sub__nuw_is_safe_thm
  ---END test_sub__nuw_is_safe



def test_sub_nuw_nsw__nsw_is_safe_before := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(-2147483647 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.or %arg23, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.sub %0, %3 overflow<nsw,nuw> : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_sub_nuw_nsw__nsw_is_safe_after := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.or %arg23, %0 : i32
  %2 = llvm.sub %0, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_nuw_nsw__nsw_is_safe_proof : test_sub_nuw_nsw__nsw_is_safe_before ⊑ test_sub_nuw_nsw__nsw_is_safe_after := by
  unfold test_sub_nuw_nsw__nsw_is_safe_before test_sub_nuw_nsw__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_nuw_nsw__nsw_is_safe
  apply test_sub_nuw_nsw__nsw_is_safe_thm
  ---END test_sub_nuw_nsw__nsw_is_safe



def test_sub_nuw__nsw_is_safe_before := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(-2147483647 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.or %arg22, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.sub %0, %3 overflow<nuw> : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_sub_nuw__nsw_is_safe_after := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.or %arg22, %0 : i32
  %2 = llvm.sub %0, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_nuw__nsw_is_safe_proof : test_sub_nuw__nsw_is_safe_before ⊑ test_sub_nuw__nsw_is_safe_after := by
  unfold test_sub_nuw__nsw_is_safe_before test_sub_nuw__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_nuw__nsw_is_safe
  apply test_sub_nuw__nsw_is_safe_thm
  ---END test_sub_nuw__nsw_is_safe



def test_sub_nsw__nsw_is_safe_before := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(-2147483647 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.or %arg21, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.sub %0, %3 overflow<nsw> : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_sub_nsw__nsw_is_safe_after := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.or %arg21, %0 : i32
  %2 = llvm.sub %0, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_nsw__nsw_is_safe_proof : test_sub_nsw__nsw_is_safe_before ⊑ test_sub_nsw__nsw_is_safe_after := by
  unfold test_sub_nsw__nsw_is_safe_before test_sub_nsw__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_nsw__nsw_is_safe
  apply test_sub_nsw__nsw_is_safe_thm
  ---END test_sub_nsw__nsw_is_safe



def test_sub__nsw_is_safe_before := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(-2147483647 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.or %arg20, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.sub %0, %3 : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_sub__nsw_is_safe_after := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.or %arg20, %0 : i32
  %2 = llvm.sub %0, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub__nsw_is_safe_proof : test_sub__nsw_is_safe_before ⊑ test_sub__nsw_is_safe_after := by
  unfold test_sub__nsw_is_safe_before test_sub__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub__nsw_is_safe
  apply test_sub__nsw_is_safe_thm
  ---END test_sub__nsw_is_safe



def test_sub_nuw_nsw__none_are_safe_before := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.mlir.constant(2147483647 : i32) : i32
  %3 = llvm.icmp "eq" %arg19, %0 : i32
  %4 = llvm.sub %1, %arg19 overflow<nsw,nuw> : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test_sub_nuw_nsw__none_are_safe_after := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.sub %0, %arg19 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_nuw_nsw__none_are_safe_proof : test_sub_nuw_nsw__none_are_safe_before ⊑ test_sub_nuw_nsw__none_are_safe_after := by
  unfold test_sub_nuw_nsw__none_are_safe_before test_sub_nuw_nsw__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_nuw_nsw__none_are_safe
  apply test_sub_nuw_nsw__none_are_safe_thm
  ---END test_sub_nuw_nsw__none_are_safe



def test_sub_nuw__none_are_safe_before := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.mlir.constant(2147483647 : i32) : i32
  %3 = llvm.icmp "eq" %arg18, %0 : i32
  %4 = llvm.sub %1, %arg18 overflow<nuw> : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test_sub_nuw__none_are_safe_after := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.sub %0, %arg18 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_nuw__none_are_safe_proof : test_sub_nuw__none_are_safe_before ⊑ test_sub_nuw__none_are_safe_after := by
  unfold test_sub_nuw__none_are_safe_before test_sub_nuw__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_nuw__none_are_safe
  apply test_sub_nuw__none_are_safe_thm
  ---END test_sub_nuw__none_are_safe



def test_sub_nsw__none_are_safe_before := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.mlir.constant(2147483647 : i32) : i32
  %3 = llvm.icmp "eq" %arg17, %0 : i32
  %4 = llvm.sub %1, %arg17 overflow<nsw> : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test_sub_nsw__none_are_safe_after := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.sub %0, %arg17 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub_nsw__none_are_safe_proof : test_sub_nsw__none_are_safe_before ⊑ test_sub_nsw__none_are_safe_after := by
  unfold test_sub_nsw__none_are_safe_before test_sub_nsw__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub_nsw__none_are_safe
  apply test_sub_nsw__none_are_safe_thm
  ---END test_sub_nsw__none_are_safe



def test_sub__none_are_safe_before := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.mlir.constant(2147483647 : i32) : i32
  %3 = llvm.icmp "eq" %arg16, %0 : i32
  %4 = llvm.sub %1, %arg16 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test_sub__none_are_safe_after := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.sub %0, %arg16 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sub__none_are_safe_proof : test_sub__none_are_safe_before ⊑ test_sub__none_are_safe_after := by
  unfold test_sub__none_are_safe_before test_sub__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_sub__none_are_safe
  apply test_sub__none_are_safe_thm
  ---END test_sub__none_are_safe



def test_mul_nuw_nsw__all_are_safe_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(17 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.mlir.constant(153 : i32) : i32
  %4 = llvm.and %arg15, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.mul %4, %2 overflow<nsw,nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_mul_nuw_nsw__all_are_safe_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg15, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul_nuw_nsw__all_are_safe_proof : test_mul_nuw_nsw__all_are_safe_before ⊑ test_mul_nuw_nsw__all_are_safe_after := by
  unfold test_mul_nuw_nsw__all_are_safe_before test_mul_nuw_nsw__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul_nuw_nsw__all_are_safe
  apply test_mul_nuw_nsw__all_are_safe_thm
  ---END test_mul_nuw_nsw__all_are_safe



def test_mul_nuw__all_are_safe_before := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(17 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.mlir.constant(153 : i32) : i32
  %4 = llvm.and %arg14, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.mul %4, %2 overflow<nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_mul_nuw__all_are_safe_after := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg14, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul_nuw__all_are_safe_proof : test_mul_nuw__all_are_safe_before ⊑ test_mul_nuw__all_are_safe_after := by
  unfold test_mul_nuw__all_are_safe_before test_mul_nuw__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul_nuw__all_are_safe
  apply test_mul_nuw__all_are_safe_thm
  ---END test_mul_nuw__all_are_safe



def test_mul_nsw__all_are_safe_before := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(17 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.mlir.constant(153 : i32) : i32
  %4 = llvm.and %arg13, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.mul %4, %2 overflow<nsw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_mul_nsw__all_are_safe_after := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg13, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul_nsw__all_are_safe_proof : test_mul_nsw__all_are_safe_before ⊑ test_mul_nsw__all_are_safe_after := by
  unfold test_mul_nsw__all_are_safe_before test_mul_nsw__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul_nsw__all_are_safe
  apply test_mul_nsw__all_are_safe_thm
  ---END test_mul_nsw__all_are_safe



def test_mul__all_are_safe_before := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(17 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.mlir.constant(153 : i32) : i32
  %4 = llvm.and %arg12, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.mul %4, %2 : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_mul__all_are_safe_after := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg12, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul__all_are_safe_proof : test_mul__all_are_safe_before ⊑ test_mul__all_are_safe_after := by
  unfold test_mul__all_are_safe_before test_mul__all_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul__all_are_safe
  apply test_mul__all_are_safe_thm
  ---END test_mul__all_are_safe



def test_mul_nuw_nsw__nuw_is_safe_before := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(268435457 : i32) : i32
  %1 = llvm.mlir.constant(268435456 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.mlir.constant(-1879048192 : i32) : i32
  %4 = llvm.and %arg11, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.mul %4, %2 overflow<nsw,nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_mul_nuw_nsw__nuw_is_safe_after := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(268435457 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg11, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul_nuw_nsw__nuw_is_safe_proof : test_mul_nuw_nsw__nuw_is_safe_before ⊑ test_mul_nuw_nsw__nuw_is_safe_after := by
  unfold test_mul_nuw_nsw__nuw_is_safe_before test_mul_nuw_nsw__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul_nuw_nsw__nuw_is_safe
  apply test_mul_nuw_nsw__nuw_is_safe_thm
  ---END test_mul_nuw_nsw__nuw_is_safe



def test_mul_nuw__nuw_is_safe_before := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(268435457 : i32) : i32
  %1 = llvm.mlir.constant(268435456 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.mlir.constant(-1879048192 : i32) : i32
  %4 = llvm.and %arg10, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.mul %4, %2 overflow<nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_mul_nuw__nuw_is_safe_after := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(268435457 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg10, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul_nuw__nuw_is_safe_proof : test_mul_nuw__nuw_is_safe_before ⊑ test_mul_nuw__nuw_is_safe_after := by
  unfold test_mul_nuw__nuw_is_safe_before test_mul_nuw__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul_nuw__nuw_is_safe
  apply test_mul_nuw__nuw_is_safe_thm
  ---END test_mul_nuw__nuw_is_safe



def test_mul_nsw__nuw_is_safe_before := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(268435457 : i32) : i32
  %1 = llvm.mlir.constant(268435456 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.mlir.constant(-1879048192 : i32) : i32
  %4 = llvm.and %arg9, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.mul %4, %2 overflow<nsw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_mul_nsw__nuw_is_safe_after := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(268435457 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg9, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul_nsw__nuw_is_safe_proof : test_mul_nsw__nuw_is_safe_before ⊑ test_mul_nsw__nuw_is_safe_after := by
  unfold test_mul_nsw__nuw_is_safe_before test_mul_nsw__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul_nsw__nuw_is_safe
  apply test_mul_nsw__nuw_is_safe_thm
  ---END test_mul_nsw__nuw_is_safe



def test_mul__nuw_is_safe_before := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(268435457 : i32) : i32
  %1 = llvm.mlir.constant(268435456 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.mlir.constant(-1879048192 : i32) : i32
  %4 = llvm.and %arg8, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.mul %4, %2 : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_mul__nuw_is_safe_after := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(268435457 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg8, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul__nuw_is_safe_proof : test_mul__nuw_is_safe_before ⊑ test_mul__nuw_is_safe_after := by
  unfold test_mul__nuw_is_safe_before test_mul__nuw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul__nuw_is_safe
  apply test_mul__nuw_is_safe_thm
  ---END test_mul__nuw_is_safe



def test_mul_nuw_nsw__nsw_is_safe_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(-83886079 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.mlir.constant(-754974711 : i32) : i32
  %4 = llvm.or %arg7, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.mul %4, %2 overflow<nsw,nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_mul_nuw_nsw__nsw_is_safe_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.or %arg7, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul_nuw_nsw__nsw_is_safe_proof : test_mul_nuw_nsw__nsw_is_safe_before ⊑ test_mul_nuw_nsw__nsw_is_safe_after := by
  unfold test_mul_nuw_nsw__nsw_is_safe_before test_mul_nuw_nsw__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul_nuw_nsw__nsw_is_safe
  apply test_mul_nuw_nsw__nsw_is_safe_thm
  ---END test_mul_nuw_nsw__nsw_is_safe



def test_mul_nuw__nsw_is_safe_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(-83886079 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.mlir.constant(-754974711 : i32) : i32
  %4 = llvm.or %arg6, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.mul %4, %2 overflow<nuw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_mul_nuw__nsw_is_safe_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.or %arg6, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul_nuw__nsw_is_safe_proof : test_mul_nuw__nsw_is_safe_before ⊑ test_mul_nuw__nsw_is_safe_after := by
  unfold test_mul_nuw__nsw_is_safe_before test_mul_nuw__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul_nuw__nsw_is_safe
  apply test_mul_nuw__nsw_is_safe_thm
  ---END test_mul_nuw__nsw_is_safe



def test_mul_nsw__nsw_is_safe_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(-83886079 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.mlir.constant(-754974711 : i32) : i32
  %4 = llvm.or %arg5, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.mul %4, %2 overflow<nsw> : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_mul_nsw__nsw_is_safe_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.or %arg5, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul_nsw__nsw_is_safe_proof : test_mul_nsw__nsw_is_safe_before ⊑ test_mul_nsw__nsw_is_safe_after := by
  unfold test_mul_nsw__nsw_is_safe_before test_mul_nsw__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul_nsw__nsw_is_safe
  apply test_mul_nsw__nsw_is_safe_thm
  ---END test_mul_nsw__nsw_is_safe



def test_mul__nsw_is_safe_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(-83886079 : i32) : i32
  %2 = llvm.mlir.constant(9 : i32) : i32
  %3 = llvm.mlir.constant(-754974711 : i32) : i32
  %4 = llvm.or %arg4, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.mul %4, %2 : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test_mul__nsw_is_safe_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(-83886080 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.or %arg4, %0 : i32
  %3 = llvm.mul %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul__nsw_is_safe_proof : test_mul__nsw_is_safe_before ⊑ test_mul__nsw_is_safe_after := by
  unfold test_mul__nsw_is_safe_before test_mul__nsw_is_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul__nsw_is_safe
  apply test_mul__nsw_is_safe_thm
  ---END test_mul__nsw_is_safe



def test_mul_nuw_nsw__none_are_safe_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(805306368 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.mlir.constant(-1342177280 : i32) : i32
  %3 = llvm.icmp "eq" %arg3, %0 : i32
  %4 = llvm.mul %arg3, %1 overflow<nsw,nuw> : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test_mul_nuw_nsw__none_are_safe_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(9 : i32) : i32
  %1 = llvm.mul %arg3, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul_nuw_nsw__none_are_safe_proof : test_mul_nuw_nsw__none_are_safe_before ⊑ test_mul_nuw_nsw__none_are_safe_after := by
  unfold test_mul_nuw_nsw__none_are_safe_before test_mul_nuw_nsw__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul_nuw_nsw__none_are_safe
  apply test_mul_nuw_nsw__none_are_safe_thm
  ---END test_mul_nuw_nsw__none_are_safe



def test_mul_nuw__none_are_safe_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(805306368 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.mlir.constant(-1342177280 : i32) : i32
  %3 = llvm.icmp "eq" %arg2, %0 : i32
  %4 = llvm.mul %arg2, %1 overflow<nuw> : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test_mul_nuw__none_are_safe_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(9 : i32) : i32
  %1 = llvm.mul %arg2, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul_nuw__none_are_safe_proof : test_mul_nuw__none_are_safe_before ⊑ test_mul_nuw__none_are_safe_after := by
  unfold test_mul_nuw__none_are_safe_before test_mul_nuw__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul_nuw__none_are_safe
  apply test_mul_nuw__none_are_safe_thm
  ---END test_mul_nuw__none_are_safe



def test_mul_nsw__none_are_safe_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(805306368 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.mlir.constant(-1342177280 : i32) : i32
  %3 = llvm.icmp "eq" %arg1, %0 : i32
  %4 = llvm.mul %arg1, %1 overflow<nsw> : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test_mul_nsw__none_are_safe_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(9 : i32) : i32
  %1 = llvm.mul %arg1, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul_nsw__none_are_safe_proof : test_mul_nsw__none_are_safe_before ⊑ test_mul_nsw__none_are_safe_after := by
  unfold test_mul_nsw__none_are_safe_before test_mul_nsw__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul_nsw__none_are_safe
  apply test_mul_nsw__none_are_safe_thm
  ---END test_mul_nsw__none_are_safe



def test_mul__none_are_safe_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(805306368 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.mlir.constant(-1342177280 : i32) : i32
  %3 = llvm.icmp "eq" %arg0, %0 : i32
  %4 = llvm.mul %arg0, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test_mul__none_are_safe_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(9 : i32) : i32
  %1 = llvm.mul %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_mul__none_are_safe_proof : test_mul__none_are_safe_before ⊑ test_mul__none_are_safe_after := by
  unfold test_mul__none_are_safe_before test_mul__none_are_safe_after
  simp_alive_peephole
  intros
  ---BEGIN test_mul__none_are_safe
  apply test_mul__none_are_safe_thm
  ---END test_mul__none_are_safe


