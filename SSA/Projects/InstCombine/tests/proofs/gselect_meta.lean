import SSA.Projects.InstCombine.tests.proofs.gselect_meta_proof
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
section gselect_meta_statements

def foo_before := [llvm|
{
^0(%arg54 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(20 : i32) : i32
  %2 = llvm.mlir.constant(-20 : i32) : i32
  %3 = llvm.icmp "sgt" %arg54, %0 : i32
  %4 = llvm.add %arg54, %1 overflow<nsw> : i32
  %5 = llvm.add %arg54, %2 : i32
  %6 = "llvm.select"(%3, %4, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def foo_after := [llvm|
{
^0(%arg54 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(20 : i32) : i32
  %2 = llvm.mlir.constant(-20 : i32) : i32
  %3 = llvm.icmp "sgt" %arg54, %0 : i32
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %arg54, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo_proof : foo_before ⊑ foo_after := by
  unfold foo_before foo_after
  simp_alive_peephole
  intros
  ---BEGIN foo
  apply foo_thm
  ---END foo



def shrink_select_before := [llvm|
{
^0(%arg52 : i1, %arg53 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = "llvm.select"(%arg52, %arg53, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.trunc %1 : i32 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def shrink_select_after := [llvm|
{
^0(%arg52 : i1, %arg53 : i32):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.trunc %arg53 : i32 to i8
  %2 = "llvm.select"(%arg52, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shrink_select_proof : shrink_select_before ⊑ shrink_select_after := by
  unfold shrink_select_before shrink_select_after
  simp_alive_peephole
  intros
  ---BEGIN shrink_select
  apply shrink_select_thm
  ---END shrink_select



def foo2_before := [llvm|
{
^0(%arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "sgt" %arg46, %0 : i32
  %2 = llvm.add %arg46, %arg47 overflow<nsw> : i32
  %3 = llvm.sub %arg46, %arg47 overflow<nsw> : i32
  %4 = "llvm.select"(%1, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def foo2_after := [llvm|
{
^0(%arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "sgt" %arg46, %0 : i32
  %3 = llvm.sub %1, %arg47 : i32
  %4 = "llvm.select"(%2, %arg47, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.add %arg46, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo2_proof : foo2_before ⊑ foo2_after := by
  unfold foo2_before foo2_after
  simp_alive_peephole
  intros
  ---BEGIN foo2
  apply foo2_thm
  ---END foo2



def not_cond_before := [llvm|
{
^0(%arg24 : i1, %arg25 : i32, %arg26 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg24, %0 : i1
  %2 = "llvm.select"(%1, %arg25, %arg26) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def not_cond_after := [llvm|
{
^0(%arg24 : i1, %arg25 : i32, %arg26 : i32):
  %0 = "llvm.select"(%arg24, %arg26, %arg25) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_cond_proof : not_cond_before ⊑ not_cond_after := by
  unfold not_cond_before not_cond_after
  simp_alive_peephole
  intros
  ---BEGIN not_cond
  apply not_cond_thm
  ---END not_cond



def select_add_before := [llvm|
{
^0(%arg15 : i1, %arg16 : i64, %arg17 : i64):
  %0 = llvm.add %arg16, %arg17 : i64
  %1 = "llvm.select"(%arg15, %0, %arg16) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%1) : (i64) -> ()
}
]
def select_add_after := [llvm|
{
^0(%arg15 : i1, %arg16 : i64, %arg17 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = "llvm.select"(%arg15, %arg17, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  %2 = llvm.add %arg16, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_add_proof : select_add_before ⊑ select_add_after := by
  unfold select_add_before select_add_after
  simp_alive_peephole
  intros
  ---BEGIN select_add
  apply select_add_thm
  ---END select_add



def select_sub_before := [llvm|
{
^0(%arg9 : i1, %arg10 : i17, %arg11 : i17):
  %0 = llvm.sub %arg10, %arg11 : i17
  %1 = "llvm.select"(%arg9, %0, %arg10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i17, i17) -> i17
  "llvm.return"(%1) : (i17) -> ()
}
]
def select_sub_after := [llvm|
{
^0(%arg9 : i1, %arg10 : i17, %arg11 : i17):
  %0 = llvm.mlir.constant(0 : i17) : i17
  %1 = "llvm.select"(%arg9, %arg11, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i17, i17) -> i17
  %2 = llvm.sub %arg10, %1 : i17
  "llvm.return"(%2) : (i17) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_sub_proof : select_sub_before ⊑ select_sub_after := by
  unfold select_sub_before select_sub_after
  simp_alive_peephole
  intros
  ---BEGIN select_sub
  apply select_sub_thm
  ---END select_sub



def select_ashr_before := [llvm|
{
^0(%arg6 : i1, %arg7 : i128, %arg8 : i128):
  %0 = llvm.ashr %arg7, %arg8 : i128
  %1 = "llvm.select"(%arg6, %0, %arg7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i128, i128) -> i128
  "llvm.return"(%1) : (i128) -> ()
}
]
def select_ashr_after := [llvm|
{
^0(%arg6 : i1, %arg7 : i128, %arg8 : i128):
  %0 = llvm.mlir.constant(0 : i128) : i128
  %1 = "llvm.select"(%arg6, %arg8, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i128, i128) -> i128
  %2 = llvm.ashr %arg7, %1 : i128
  "llvm.return"(%2) : (i128) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_ashr_proof : select_ashr_before ⊑ select_ashr_after := by
  unfold select_ashr_before select_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN select_ashr
  apply select_ashr_thm
  ---END select_ashr


