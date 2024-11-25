
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
section gminmaxhfold_statements

def add_umin_constant_limit_before := [llvm|
{
^0(%arg55 : i32):
  %0 = llvm.mlir.constant(41 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.add %arg55, %0 overflow<nuw> : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_umin_constant_limit_after := [llvm|
{
^0(%arg55 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(41 : i32) : i32
  %2 = llvm.mlir.constant(42 : i32) : i32
  %3 = llvm.icmp "eq" %arg55, %0 : i32
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_umin_constant_limit_proof : add_umin_constant_limit_before ⊑ add_umin_constant_limit_after := by
  unfold add_umin_constant_limit_before add_umin_constant_limit_after
  simp_alive_peephole
  intros
  ---BEGIN add_umin_constant_limit
  all_goals (try extract_goal ; sorry)
  ---END add_umin_constant_limit



def add_umin_simplify_before := [llvm|
{
^0(%arg54 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.add %arg54, %0 overflow<nuw> : i32
  %2 = llvm.icmp "ult" %1, %0 : i32
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_umin_simplify_after := [llvm|
{
^0(%arg54 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_umin_simplify_proof : add_umin_simplify_before ⊑ add_umin_simplify_after := by
  unfold add_umin_simplify_before add_umin_simplify_after
  simp_alive_peephole
  intros
  ---BEGIN add_umin_simplify
  all_goals (try extract_goal ; sorry)
  ---END add_umin_simplify



def add_umin_simplify2_before := [llvm|
{
^0(%arg53 : i32):
  %0 = llvm.mlir.constant(43 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.add %arg53, %0 overflow<nuw> : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_umin_simplify2_after := [llvm|
{
^0(%arg53 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_umin_simplify2_proof : add_umin_simplify2_before ⊑ add_umin_simplify2_after := by
  unfold add_umin_simplify2_before add_umin_simplify2_after
  simp_alive_peephole
  intros
  ---BEGIN add_umin_simplify2
  all_goals (try extract_goal ; sorry)
  ---END add_umin_simplify2



def add_umax_simplify_before := [llvm|
{
^0(%arg45 : i37):
  %0 = llvm.mlir.constant(42 : i37) : i37
  %1 = llvm.add %arg45, %0 overflow<nuw> : i37
  %2 = llvm.icmp "ugt" %1, %0 : i37
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i37, i37) -> i37
  "llvm.return"(%3) : (i37) -> ()
}
]
def add_umax_simplify_after := [llvm|
{
^0(%arg45 : i37):
  %0 = llvm.mlir.constant(42 : i37) : i37
  %1 = llvm.add %arg45, %0 overflow<nuw> : i37
  "llvm.return"(%1) : (i37) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_umax_simplify_proof : add_umax_simplify_before ⊑ add_umax_simplify_after := by
  unfold add_umax_simplify_before add_umax_simplify_after
  simp_alive_peephole
  intros
  ---BEGIN add_umax_simplify
  all_goals (try extract_goal ; sorry)
  ---END add_umax_simplify



def add_umax_simplify2_before := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(57 : i32) : i32
  %1 = llvm.mlir.constant(56 : i32) : i32
  %2 = llvm.add %arg44, %0 overflow<nuw> : i32
  %3 = llvm.icmp "ugt" %2, %1 : i32
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_umax_simplify2_after := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(57 : i32) : i32
  %1 = llvm.add %arg44, %0 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_umax_simplify2_proof : add_umax_simplify2_before ⊑ add_umax_simplify2_after := by
  unfold add_umax_simplify2_before add_umax_simplify2_after
  simp_alive_peephole
  intros
  ---BEGIN add_umax_simplify2
  all_goals (try extract_goal ; sorry)
  ---END add_umax_simplify2



def add_smin_simplify_before := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(-3 : i32) : i32
  %1 = llvm.mlir.constant(2147483644 : i32) : i32
  %2 = llvm.add %arg34, %0 overflow<nsw> : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_smin_simplify_after := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(-3 : i32) : i32
  %1 = llvm.add %arg34, %0 overflow<nsw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_smin_simplify_proof : add_smin_simplify_before ⊑ add_smin_simplify_after := by
  unfold add_smin_simplify_before add_smin_simplify_after
  simp_alive_peephole
  intros
  ---BEGIN add_smin_simplify
  all_goals (try extract_goal ; sorry)
  ---END add_smin_simplify



def add_smin_simplify2_before := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(-3 : i32) : i32
  %1 = llvm.mlir.constant(2147483645 : i32) : i32
  %2 = llvm.add %arg33, %0 overflow<nsw> : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_smin_simplify2_after := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(-3 : i32) : i32
  %1 = llvm.add %arg33, %0 overflow<nsw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_smin_simplify2_proof : add_smin_simplify2_before ⊑ add_smin_simplify2_after := by
  unfold add_smin_simplify2_before add_smin_simplify2_after
  simp_alive_peephole
  intros
  ---BEGIN add_smin_simplify2
  all_goals (try extract_goal ; sorry)
  ---END add_smin_simplify2



def add_smax_simplify_before := [llvm|
{
^0(%arg25 : i8):
  %0 = llvm.mlir.constant(126 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.add %arg25, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def add_smax_simplify_after := [llvm|
{
^0(%arg25 : i8):
  %0 = llvm.mlir.constant(126 : i8) : i8
  %1 = llvm.add %arg25, %0 overflow<nsw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_smax_simplify_proof : add_smax_simplify_before ⊑ add_smax_simplify_after := by
  unfold add_smax_simplify_before add_smax_simplify_after
  simp_alive_peephole
  intros
  ---BEGIN add_smax_simplify
  all_goals (try extract_goal ; sorry)
  ---END add_smax_simplify



def add_smax_simplify2_before := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.add %arg24, %0 overflow<nsw> : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def add_smax_simplify2_after := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.add %arg24, %0 overflow<nsw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_smax_simplify2_proof : add_smax_simplify2_before ⊑ add_smax_simplify2_after := by
  unfold add_smax_simplify2_before add_smax_simplify2_after
  simp_alive_peephole
  intros
  ---BEGIN add_smax_simplify2
  all_goals (try extract_goal ; sorry)
  ---END add_smax_simplify2



def twoway_clamp_lt_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(13768 : i32) : i32
  %1 = llvm.mlir.constant(13767 : i32) : i32
  %2 = llvm.icmp "slt" %arg15, %0 : i32
  %3 = "llvm.select"(%2, %arg15, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "sgt" %3, %1 : i32
  %5 = "llvm.select"(%4, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def twoway_clamp_lt_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(13767 : i32) : i32
  %1 = llvm.mlir.constant(13768 : i32) : i32
  %2 = llvm.icmp "sgt" %arg15, %0 : i32
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem twoway_clamp_lt_proof : twoway_clamp_lt_before ⊑ twoway_clamp_lt_after := by
  unfold twoway_clamp_lt_before twoway_clamp_lt_after
  simp_alive_peephole
  intros
  ---BEGIN twoway_clamp_lt
  all_goals (try extract_goal ; sorry)
  ---END twoway_clamp_lt


