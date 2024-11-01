
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
section gselecthofhbittest_statements

def and_lshr_and_before := [llvm|
{
^0(%arg63 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg63, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.lshr %arg63, %0 : i32
  %5 = llvm.and %4, %0 : i32
  %6 = "llvm.select"(%3, %5, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_lshr_and_after := [llvm|
{
^0(%arg63 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg63, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_lshr_and_proof : and_lshr_and_before ⊑ and_lshr_and_after := by
  unfold and_lshr_and_before and_lshr_and_after
  simp_alive_peephole
  intros
  ---BEGIN and_lshr_and
  all_goals (try extract_goal ; sorry)
  ---END and_lshr_and



def and_and_before := [llvm|
{
^0(%arg57 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg57, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg57, %2 : i32
  %6 = "llvm.select"(%4, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_and_after := [llvm|
{
^0(%arg57 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg57, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_and_proof : and_and_before ⊑ and_and_after := by
  unfold and_and_before and_and_after
  simp_alive_peephole
  intros
  ---BEGIN and_and
  all_goals (try extract_goal ; sorry)
  ---END and_and



def f_var0_before := [llvm|
{
^0(%arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg52, %arg53 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = llvm.lshr %arg52, %1 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = "llvm.select"(%3, %5, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def f_var0_after := [llvm|
{
^0(%arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.or %arg53, %0 : i32
  %3 = llvm.and %arg52, %2 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem f_var0_proof : f_var0_before ⊑ f_var0_after := by
  unfold f_var0_before f_var0_after
  simp_alive_peephole
  intros
  ---BEGIN f_var0
  all_goals (try extract_goal ; sorry)
  ---END f_var0



def f_var0_commutative_and_before := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg51, %arg50 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = llvm.lshr %arg50, %1 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = "llvm.select"(%3, %5, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def f_var0_commutative_and_after := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.or %arg51, %0 : i32
  %3 = llvm.and %arg50, %2 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem f_var0_commutative_and_proof : f_var0_commutative_and_before ⊑ f_var0_commutative_and_after := by
  unfold f_var0_commutative_and_before f_var0_commutative_and_after
  simp_alive_peephole
  intros
  ---BEGIN f_var0_commutative_and
  all_goals (try extract_goal ; sorry)
  ---END f_var0_commutative_and



def f_var1_before := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg42, %arg43 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = llvm.and %arg42, %1 : i32
  %5 = "llvm.select"(%3, %4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def f_var1_after := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.or %arg43, %0 : i32
  %3 = llvm.and %arg42, %2 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem f_var1_proof : f_var1_before ⊑ f_var1_after := by
  unfold f_var1_before f_var1_after
  simp_alive_peephole
  intros
  ---BEGIN f_var1
  all_goals (try extract_goal ; sorry)
  ---END f_var1



def f_var1_commutative_and_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg41, %arg40 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = llvm.and %arg40, %1 : i32
  %5 = "llvm.select"(%3, %4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def f_var1_commutative_and_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.or %arg41, %0 : i32
  %3 = llvm.and %arg40, %2 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem f_var1_commutative_and_proof : f_var1_commutative_and_before ⊑ f_var1_commutative_and_after := by
  unfold f_var1_commutative_and_before f_var1_commutative_and_after
  simp_alive_peephole
  intros
  ---BEGIN f_var1_commutative_and
  all_goals (try extract_goal ; sorry)
  ---END f_var1_commutative_and



def n5_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg3, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg3, %0 : i32
  %6 = "llvm.select"(%4, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def n5_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.lshr %arg3, %0 : i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n5_proof : n5_before ⊑ n5_after := by
  unfold n5_before n5_after
  simp_alive_peephole
  intros
  ---BEGIN n5
  all_goals (try extract_goal ; sorry)
  ---END n5



def n6_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.lshr %arg2, %2 : i32
  %6 = llvm.and %5, %0 : i32
  %7 = "llvm.select"(%4, %6, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def n6_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.lshr %arg2, %2 : i32
  %6 = llvm.and %5, %0 : i32
  %7 = "llvm.select"(%4, %0, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n6_proof : n6_before ⊑ n6_after := by
  unfold n6_before n6_after
  simp_alive_peephole
  intros
  ---BEGIN n6
  all_goals (try extract_goal ; sorry)
  ---END n6



def n7_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg1, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %arg1, %2 : i32
  %6 = "llvm.select"(%4, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def n7_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg1, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg1, %2 : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n7_proof : n7_before ⊑ n7_after := by
  unfold n7_before n7_after
  simp_alive_peephole
  intros
  ---BEGIN n7
  all_goals (try extract_goal ; sorry)
  ---END n7



def n8_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = llvm.lshr %arg0, %1 : i32
  %5 = llvm.and %4, %0 : i32
  %6 = "llvm.select"(%3, %5, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def n8_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.lshr %arg0, %2 : i32
  %6 = llvm.and %5, %0 : i32
  %7 = "llvm.select"(%4, %0, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n8_proof : n8_before ⊑ n8_after := by
  unfold n8_before n8_after
  simp_alive_peephole
  intros
  ---BEGIN n8
  all_goals (try extract_goal ; sorry)
  ---END n8


