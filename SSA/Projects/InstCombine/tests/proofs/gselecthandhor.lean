import SSA.Projects.InstCombine.tests.proofs.gselecthandhor_proof
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
section gselecthandhor_statements

def logical_and_not_before := [llvm|
{
^0(%arg262 : i1, %arg263 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg262, %0, %arg263) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def logical_and_not_after := [llvm|
{
^0(%arg262 : i1, %arg263 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg262, %0 : i1
  %3 = "llvm.select"(%2, %arg263, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_not_proof : logical_and_not_before ⊑ logical_and_not_after := by
  unfold logical_and_not_before logical_and_not_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_not
  apply logical_and_not_thm
  ---END logical_and_not



def logical_or_not_before := [llvm|
{
^0(%arg260 : i1, %arg261 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg260, %arg261, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def logical_or_not_after := [llvm|
{
^0(%arg260 : i1, %arg261 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg260, %0 : i1
  %2 = "llvm.select"(%1, %0, %arg261) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_not_proof : logical_or_not_before ⊑ logical_or_not_after := by
  unfold logical_or_not_before logical_or_not_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_not
  apply logical_or_not_thm
  ---END logical_or_not



def logical_and_cond_reuse_before := [llvm|
{
^0(%arg258 : i1, %arg259 : i1):
  %0 = "llvm.select"(%arg258, %arg259, %arg258) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def logical_and_cond_reuse_after := [llvm|
{
^0(%arg258 : i1, %arg259 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg258, %arg259, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_cond_reuse_proof : logical_and_cond_reuse_before ⊑ logical_and_cond_reuse_after := by
  unfold logical_and_cond_reuse_before logical_and_cond_reuse_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_cond_reuse
  apply logical_and_cond_reuse_thm
  ---END logical_and_cond_reuse



def logical_or_cond_reuse_before := [llvm|
{
^0(%arg256 : i1, %arg257 : i1):
  %0 = "llvm.select"(%arg256, %arg256, %arg257) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def logical_or_cond_reuse_after := [llvm|
{
^0(%arg256 : i1, %arg257 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg256, %0, %arg257) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_cond_reuse_proof : logical_or_cond_reuse_before ⊑ logical_or_cond_reuse_after := by
  unfold logical_or_cond_reuse_before logical_or_cond_reuse_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_cond_reuse
  apply logical_or_cond_reuse_thm
  ---END logical_or_cond_reuse



def logical_and_not_cond_reuse_before := [llvm|
{
^0(%arg254 : i1, %arg255 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg254, %0 : i1
  %2 = "llvm.select"(%arg254, %arg255, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def logical_and_not_cond_reuse_after := [llvm|
{
^0(%arg254 : i1, %arg255 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg254, %0 : i1
  %2 = "llvm.select"(%1, %0, %arg255) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_not_cond_reuse_proof : logical_and_not_cond_reuse_before ⊑ logical_and_not_cond_reuse_after := by
  unfold logical_and_not_cond_reuse_before logical_and_not_cond_reuse_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_not_cond_reuse
  apply logical_and_not_cond_reuse_thm
  ---END logical_and_not_cond_reuse



def logical_or_not_cond_reuse_before := [llvm|
{
^0(%arg252 : i1, %arg253 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg252, %0 : i1
  %2 = "llvm.select"(%arg252, %1, %arg253) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def logical_or_not_cond_reuse_after := [llvm|
{
^0(%arg252 : i1, %arg253 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg252, %0 : i1
  %3 = "llvm.select"(%2, %arg253, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_not_cond_reuse_proof : logical_or_not_cond_reuse_before ⊑ logical_or_not_cond_reuse_after := by
  unfold logical_or_not_cond_reuse_before logical_or_not_cond_reuse_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_not_cond_reuse
  apply logical_or_not_cond_reuse_thm
  ---END logical_or_not_cond_reuse



def logical_or_implies_before := [llvm|
{
^0(%arg251 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg251, %0 : i32
  %4 = llvm.icmp "eq" %arg251, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def logical_or_implies_after := [llvm|
{
^0(%arg251 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.icmp "eq" %arg251, %0 : i32
  %3 = llvm.icmp "eq" %arg251, %1 : i32
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_implies_proof : logical_or_implies_before ⊑ logical_or_implies_after := by
  unfold logical_or_implies_before logical_or_implies_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_implies
  apply logical_or_implies_thm
  ---END logical_or_implies



def logical_or_implies_folds_before := [llvm|
{
^0(%arg250 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "slt" %arg250, %0 : i32
  %3 = llvm.icmp "sge" %arg250, %0 : i32
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logical_or_implies_folds_after := [llvm|
{
^0(%arg250 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_implies_folds_proof : logical_or_implies_folds_before ⊑ logical_or_implies_folds_after := by
  unfold logical_or_implies_folds_before logical_or_implies_folds_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_implies_folds
  apply logical_or_implies_folds_thm
  ---END logical_or_implies_folds



def logical_and_implies_before := [llvm|
{
^0(%arg249 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ne" %arg249, %0 : i32
  %4 = llvm.icmp "ne" %arg249, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def logical_and_implies_after := [llvm|
{
^0(%arg249 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.icmp "ne" %arg249, %0 : i32
  %3 = llvm.icmp "ne" %arg249, %1 : i32
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_implies_proof : logical_and_implies_before ⊑ logical_and_implies_after := by
  unfold logical_and_implies_before logical_and_implies_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_implies
  apply logical_and_implies_thm
  ---END logical_and_implies



def logical_and_implies_folds_before := [llvm|
{
^0(%arg248 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ugt" %arg248, %0 : i32
  %4 = llvm.icmp "ne" %arg248, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def logical_and_implies_folds_after := [llvm|
{
^0(%arg248 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.icmp "ugt" %arg248, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_implies_folds_proof : logical_and_implies_folds_before ⊑ logical_and_implies_folds_after := by
  unfold logical_and_implies_folds_before logical_and_implies_folds_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_implies_folds
  apply logical_and_implies_folds_thm
  ---END logical_and_implies_folds



def not_not_true_before := [llvm|
{
^0(%arg238 : i1, %arg239 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg238, %0 : i1
  %2 = llvm.xor %arg239, %0 : i1
  %3 = "llvm.select"(%1, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def not_not_true_after := [llvm|
{
^0(%arg238 : i1, %arg239 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg239, %0 : i1
  %2 = "llvm.select"(%arg238, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_not_true_proof : not_not_true_before ⊑ not_not_true_after := by
  unfold not_not_true_before not_not_true_after
  simp_alive_peephole
  intros
  ---BEGIN not_not_true
  apply not_not_true_thm
  ---END not_not_true



def not_not_false_before := [llvm|
{
^0(%arg236 : i1, %arg237 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg236, %0 : i1
  %3 = llvm.xor %arg237, %0 : i1
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def not_not_false_after := [llvm|
{
^0(%arg236 : i1, %arg237 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg236, %0, %arg237) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.xor %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_not_false_proof : not_not_false_before ⊑ not_not_false_after := by
  unfold not_not_false_before not_not_false_after
  simp_alive_peephole
  intros
  ---BEGIN not_not_false
  apply not_not_false_thm
  ---END not_not_false



def not_true_not_before := [llvm|
{
^0(%arg234 : i1, %arg235 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg234, %0 : i1
  %2 = llvm.xor %arg235, %0 : i1
  %3 = "llvm.select"(%1, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def not_true_not_after := [llvm|
{
^0(%arg234 : i1, %arg235 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg234, %arg235, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = llvm.xor %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_true_not_proof : not_true_not_before ⊑ not_true_not_after := by
  unfold not_true_not_before not_true_not_after
  simp_alive_peephole
  intros
  ---BEGIN not_true_not
  apply not_true_not_thm
  ---END not_true_not



def not_false_not_before := [llvm|
{
^0(%arg232 : i1, %arg233 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg232, %0 : i1
  %3 = llvm.xor %arg233, %0 : i1
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def not_false_not_after := [llvm|
{
^0(%arg232 : i1, %arg233 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg233, %0 : i1
  %3 = "llvm.select"(%arg232, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_false_not_proof : not_false_not_before ⊑ not_false_not_after := by
  unfold not_false_not_before not_false_not_after
  simp_alive_peephole
  intros
  ---BEGIN not_false_not
  apply not_false_not_thm
  ---END not_false_not



def and_or1_before := [llvm|
{
^0(%arg203 : i1, %arg204 : i1, %arg205 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg203, %0 : i1
  %2 = llvm.or %1, %arg205 : i1
  %3 = "llvm.select"(%2, %arg203, %arg204) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def and_or1_after := [llvm|
{
^0(%arg203 : i1, %arg204 : i1, %arg205 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg205, %0, %arg204) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg203, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or1_proof : and_or1_before ⊑ and_or1_after := by
  unfold and_or1_before and_or1_after
  simp_alive_peephole
  intros
  ---BEGIN and_or1
  apply and_or1_thm
  ---END and_or1



def and_or2_before := [llvm|
{
^0(%arg200 : i1, %arg201 : i1, %arg202 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg202, %0 : i1
  %2 = llvm.and %1, %arg201 : i1
  %3 = "llvm.select"(%2, %arg200, %arg201) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def and_or2_after := [llvm|
{
^0(%arg200 : i1, %arg201 : i1, %arg202 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg202, %0, %arg200) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg201, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or2_proof : and_or2_before ⊑ and_or2_after := by
  unfold and_or2_before and_or2_after
  simp_alive_peephole
  intros
  ---BEGIN and_or2
  apply and_or2_thm
  ---END and_or2



def and_or1_commuted_before := [llvm|
{
^0(%arg197 : i1, %arg198 : i1, %arg199 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg197, %0 : i1
  %2 = llvm.or %arg199, %1 : i1
  %3 = "llvm.select"(%2, %arg197, %arg198) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def and_or1_commuted_after := [llvm|
{
^0(%arg197 : i1, %arg198 : i1, %arg199 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg199, %0, %arg198) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg197, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or1_commuted_proof : and_or1_commuted_before ⊑ and_or1_commuted_after := by
  unfold and_or1_commuted_before and_or1_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN and_or1_commuted
  apply and_or1_commuted_thm
  ---END and_or1_commuted



def and_or2_commuted_before := [llvm|
{
^0(%arg194 : i1, %arg195 : i1, %arg196 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg196, %0 : i1
  %2 = llvm.and %arg195, %1 : i1
  %3 = "llvm.select"(%2, %arg194, %arg195) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def and_or2_commuted_after := [llvm|
{
^0(%arg194 : i1, %arg195 : i1, %arg196 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg196, %0, %arg194) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg195, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or2_commuted_proof : and_or2_commuted_before ⊑ and_or2_commuted_after := by
  unfold and_or2_commuted_before and_or2_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN and_or2_commuted
  apply and_or2_commuted_thm
  ---END and_or2_commuted



def and_or1_wrong_operand_before := [llvm|
{
^0(%arg176 : i1, %arg177 : i1, %arg178 : i1, %arg179 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg176, %0 : i1
  %2 = llvm.or %1, %arg178 : i1
  %3 = "llvm.select"(%2, %arg179, %arg177) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def and_or1_wrong_operand_after := [llvm|
{
^0(%arg176 : i1, %arg177 : i1, %arg178 : i1, %arg179 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg176, %0 : i1
  %2 = llvm.or %arg178, %1 : i1
  %3 = "llvm.select"(%2, %arg179, %arg177) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or1_wrong_operand_proof : and_or1_wrong_operand_before ⊑ and_or1_wrong_operand_after := by
  unfold and_or1_wrong_operand_before and_or1_wrong_operand_after
  simp_alive_peephole
  intros
  ---BEGIN and_or1_wrong_operand
  apply and_or1_wrong_operand_thm
  ---END and_or1_wrong_operand



def and_or2_wrong_operand_before := [llvm|
{
^0(%arg172 : i1, %arg173 : i1, %arg174 : i1, %arg175 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg174, %0 : i1
  %2 = llvm.and %1, %arg173 : i1
  %3 = "llvm.select"(%2, %arg172, %arg175) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def and_or2_wrong_operand_after := [llvm|
{
^0(%arg172 : i1, %arg173 : i1, %arg174 : i1, %arg175 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg174, %0 : i1
  %2 = llvm.and %arg173, %1 : i1
  %3 = "llvm.select"(%2, %arg172, %arg175) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or2_wrong_operand_proof : and_or2_wrong_operand_before ⊑ and_or2_wrong_operand_after := by
  unfold and_or2_wrong_operand_before and_or2_wrong_operand_after
  simp_alive_peephole
  intros
  ---BEGIN and_or2_wrong_operand
  apply and_or2_wrong_operand_thm
  ---END and_or2_wrong_operand



def and_or3_before := [llvm|
{
^0(%arg168 : i1, %arg169 : i1, %arg170 : i32, %arg171 : i32):
  %0 = llvm.icmp "eq" %arg170, %arg171 : i32
  %1 = llvm.and %arg169, %0 : i1
  %2 = "llvm.select"(%1, %arg168, %arg169) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def and_or3_after := [llvm|
{
^0(%arg168 : i1, %arg169 : i1, %arg170 : i32, %arg171 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ne" %arg170, %arg171 : i32
  %3 = "llvm.select"(%2, %0, %arg168) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg169, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or3_proof : and_or3_before ⊑ and_or3_after := by
  unfold and_or3_before and_or3_after
  simp_alive_peephole
  intros
  ---BEGIN and_or3
  apply and_or3_thm
  ---END and_or3



def and_or3_commuted_before := [llvm|
{
^0(%arg164 : i1, %arg165 : i1, %arg166 : i32, %arg167 : i32):
  %0 = llvm.icmp "eq" %arg166, %arg167 : i32
  %1 = llvm.and %0, %arg165 : i1
  %2 = "llvm.select"(%1, %arg164, %arg165) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def and_or3_commuted_after := [llvm|
{
^0(%arg164 : i1, %arg165 : i1, %arg166 : i32, %arg167 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ne" %arg166, %arg167 : i32
  %3 = "llvm.select"(%2, %0, %arg164) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg165, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_or3_commuted_proof : and_or3_commuted_before ⊑ and_or3_commuted_after := by
  unfold and_or3_commuted_before and_or3_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN and_or3_commuted
  apply and_or3_commuted_thm
  ---END and_or3_commuted



def or_and1_before := [llvm|
{
^0(%arg141 : i1, %arg142 : i1, %arg143 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg142, %0 : i1
  %2 = llvm.and %1, %arg143 : i1
  %3 = "llvm.select"(%2, %arg141, %arg142) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_and1_after := [llvm|
{
^0(%arg141 : i1, %arg142 : i1, %arg143 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg143, %arg141, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg142, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and1_proof : or_and1_before ⊑ or_and1_after := by
  unfold or_and1_before or_and1_after
  simp_alive_peephole
  intros
  ---BEGIN or_and1
  apply or_and1_thm
  ---END or_and1



def or_and2_before := [llvm|
{
^0(%arg138 : i1, %arg139 : i1, %arg140 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg140, %0 : i1
  %2 = llvm.or %1, %arg138 : i1
  %3 = "llvm.select"(%2, %arg138, %arg139) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_and2_after := [llvm|
{
^0(%arg138 : i1, %arg139 : i1, %arg140 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg140, %arg139, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg138, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and2_proof : or_and2_before ⊑ or_and2_after := by
  unfold or_and2_before or_and2_after
  simp_alive_peephole
  intros
  ---BEGIN or_and2
  apply or_and2_thm
  ---END or_and2



def or_and1_commuted_before := [llvm|
{
^0(%arg135 : i1, %arg136 : i1, %arg137 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg136, %0 : i1
  %2 = llvm.and %arg137, %1 : i1
  %3 = "llvm.select"(%2, %arg135, %arg136) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_and1_commuted_after := [llvm|
{
^0(%arg135 : i1, %arg136 : i1, %arg137 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg137, %arg135, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg136, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and1_commuted_proof : or_and1_commuted_before ⊑ or_and1_commuted_after := by
  unfold or_and1_commuted_before or_and1_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN or_and1_commuted
  apply or_and1_commuted_thm
  ---END or_and1_commuted



def or_and2_commuted_before := [llvm|
{
^0(%arg132 : i1, %arg133 : i1, %arg134 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg134, %0 : i1
  %2 = llvm.or %arg132, %1 : i1
  %3 = "llvm.select"(%2, %arg132, %arg133) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_and2_commuted_after := [llvm|
{
^0(%arg132 : i1, %arg133 : i1, %arg134 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg134, %arg133, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg132, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and2_commuted_proof : or_and2_commuted_before ⊑ or_and2_commuted_after := by
  unfold or_and2_commuted_before or_and2_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN or_and2_commuted
  apply or_and2_commuted_thm
  ---END or_and2_commuted



def pr64558_before := [llvm|
{
^0(%arg108 : i1, %arg109 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg109, %0 : i1
  %2 = llvm.and %1, %arg108 : i1
  %3 = "llvm.select"(%2, %arg108, %arg109) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def pr64558_after := [llvm|
{
^0(%arg108 : i1, %arg109 : i1):
  %0 = llvm.or %arg109, %arg108 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr64558_proof : pr64558_before ⊑ pr64558_after := by
  unfold pr64558_before pr64558_after
  simp_alive_peephole
  intros
  ---BEGIN pr64558
  apply pr64558_thm
  ---END pr64558



def or_and3_before := [llvm|
{
^0(%arg104 : i1, %arg105 : i1, %arg106 : i32, %arg107 : i32):
  %0 = llvm.icmp "eq" %arg106, %arg107 : i32
  %1 = llvm.or %arg104, %0 : i1
  %2 = "llvm.select"(%1, %arg104, %arg105) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def or_and3_after := [llvm|
{
^0(%arg104 : i1, %arg105 : i1, %arg106 : i32, %arg107 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ne" %arg106, %arg107 : i32
  %3 = "llvm.select"(%2, %arg105, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg104, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and3_proof : or_and3_before ⊑ or_and3_after := by
  unfold or_and3_before or_and3_after
  simp_alive_peephole
  intros
  ---BEGIN or_and3
  apply or_and3_thm
  ---END or_and3



def or_and3_commuted_before := [llvm|
{
^0(%arg100 : i1, %arg101 : i1, %arg102 : i32, %arg103 : i32):
  %0 = llvm.icmp "eq" %arg102, %arg103 : i32
  %1 = llvm.or %0, %arg100 : i1
  %2 = "llvm.select"(%1, %arg100, %arg101) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def or_and3_commuted_after := [llvm|
{
^0(%arg100 : i1, %arg101 : i1, %arg102 : i32, %arg103 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ne" %arg102, %arg103 : i32
  %3 = "llvm.select"(%2, %arg101, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg100, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and3_commuted_proof : or_and3_commuted_before ⊑ or_and3_commuted_after := by
  unfold or_and3_commuted_before or_and3_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN or_and3_commuted
  apply or_and3_commuted_thm
  ---END or_and3_commuted



def test_or_eq_a_b_before := [llvm|
{
^0(%arg36 : i1, %arg37 : i8, %arg38 : i8):
  %0 = llvm.icmp "eq" %arg37, %arg38 : i8
  %1 = llvm.or %arg36, %0 : i1
  %2 = "llvm.select"(%1, %arg37, %arg38) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def test_or_eq_a_b_after := [llvm|
{
^0(%arg36 : i1, %arg37 : i8, %arg38 : i8):
  %0 = "llvm.select"(%arg36, %arg37, %arg38) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_or_eq_a_b_proof : test_or_eq_a_b_before ⊑ test_or_eq_a_b_after := by
  unfold test_or_eq_a_b_before test_or_eq_a_b_after
  simp_alive_peephole
  intros
  ---BEGIN test_or_eq_a_b
  apply test_or_eq_a_b_thm
  ---END test_or_eq_a_b



def test_and_ne_a_b_before := [llvm|
{
^0(%arg33 : i1, %arg34 : i8, %arg35 : i8):
  %0 = llvm.icmp "ne" %arg34, %arg35 : i8
  %1 = llvm.and %arg33, %0 : i1
  %2 = "llvm.select"(%1, %arg34, %arg35) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def test_and_ne_a_b_after := [llvm|
{
^0(%arg33 : i1, %arg34 : i8, %arg35 : i8):
  %0 = "llvm.select"(%arg33, %arg34, %arg35) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_and_ne_a_b_proof : test_and_ne_a_b_before ⊑ test_and_ne_a_b_after := by
  unfold test_and_ne_a_b_before test_and_ne_a_b_after
  simp_alive_peephole
  intros
  ---BEGIN test_and_ne_a_b
  apply test_and_ne_a_b_thm
  ---END test_and_ne_a_b



def test_or_eq_a_b_commuted_before := [llvm|
{
^0(%arg30 : i1, %arg31 : i8, %arg32 : i8):
  %0 = llvm.icmp "eq" %arg31, %arg32 : i8
  %1 = llvm.or %arg30, %0 : i1
  %2 = "llvm.select"(%1, %arg32, %arg31) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def test_or_eq_a_b_commuted_after := [llvm|
{
^0(%arg30 : i1, %arg31 : i8, %arg32 : i8):
  %0 = "llvm.select"(%arg30, %arg32, %arg31) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_or_eq_a_b_commuted_proof : test_or_eq_a_b_commuted_before ⊑ test_or_eq_a_b_commuted_after := by
  unfold test_or_eq_a_b_commuted_before test_or_eq_a_b_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN test_or_eq_a_b_commuted
  apply test_or_eq_a_b_commuted_thm
  ---END test_or_eq_a_b_commuted



def test_and_ne_a_b_commuted_before := [llvm|
{
^0(%arg27 : i1, %arg28 : i8, %arg29 : i8):
  %0 = llvm.icmp "ne" %arg28, %arg29 : i8
  %1 = llvm.and %arg27, %0 : i1
  %2 = "llvm.select"(%1, %arg29, %arg28) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def test_and_ne_a_b_commuted_after := [llvm|
{
^0(%arg27 : i1, %arg28 : i8, %arg29 : i8):
  %0 = "llvm.select"(%arg27, %arg29, %arg28) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_and_ne_a_b_commuted_proof : test_and_ne_a_b_commuted_before ⊑ test_and_ne_a_b_commuted_after := by
  unfold test_and_ne_a_b_commuted_before test_and_ne_a_b_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN test_and_ne_a_b_commuted
  apply test_and_ne_a_b_commuted_thm
  ---END test_and_ne_a_b_commuted



def test_or_eq_different_operands_before := [llvm|
{
^0(%arg24 : i8, %arg25 : i8, %arg26 : i8):
  %0 = llvm.icmp "eq" %arg24, %arg26 : i8
  %1 = llvm.icmp "eq" %arg25, %arg24 : i8
  %2 = llvm.or %0, %1 : i1
  %3 = "llvm.select"(%2, %arg24, %arg25) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test_or_eq_different_operands_after := [llvm|
{
^0(%arg24 : i8, %arg25 : i8, %arg26 : i8):
  %0 = llvm.icmp "eq" %arg24, %arg26 : i8
  %1 = "llvm.select"(%0, %arg24, %arg25) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_or_eq_different_operands_proof : test_or_eq_different_operands_before ⊑ test_or_eq_different_operands_after := by
  unfold test_or_eq_different_operands_before test_or_eq_different_operands_after
  simp_alive_peephole
  intros
  ---BEGIN test_or_eq_different_operands
  apply test_or_eq_different_operands_thm
  ---END test_or_eq_different_operands



def test_or_ne_a_b_before := [llvm|
{
^0(%arg15 : i1, %arg16 : i8, %arg17 : i8):
  %0 = llvm.icmp "ne" %arg16, %arg17 : i8
  %1 = llvm.or %arg15, %0 : i1
  %2 = "llvm.select"(%1, %arg16, %arg17) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def test_or_ne_a_b_after := [llvm|
{
^0(%arg15 : i1, %arg16 : i8, %arg17 : i8):
  "llvm.return"(%arg16) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_or_ne_a_b_proof : test_or_ne_a_b_before ⊑ test_or_ne_a_b_after := by
  unfold test_or_ne_a_b_before test_or_ne_a_b_after
  simp_alive_peephole
  intros
  ---BEGIN test_or_ne_a_b
  apply test_or_ne_a_b_thm
  ---END test_or_ne_a_b



def test_logical_or_eq_a_b_before := [llvm|
{
^0(%arg9 : i1, %arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "eq" %arg10, %arg11 : i8
  %2 = "llvm.select"(%arg9, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%2, %arg10, %arg11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test_logical_or_eq_a_b_after := [llvm|
{
^0(%arg9 : i1, %arg10 : i8, %arg11 : i8):
  %0 = "llvm.select"(%arg9, %arg10, %arg11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_logical_or_eq_a_b_proof : test_logical_or_eq_a_b_before ⊑ test_logical_or_eq_a_b_after := by
  unfold test_logical_or_eq_a_b_before test_logical_or_eq_a_b_after
  simp_alive_peephole
  intros
  ---BEGIN test_logical_or_eq_a_b
  apply test_logical_or_eq_a_b_thm
  ---END test_logical_or_eq_a_b



def test_logical_and_ne_a_b_before := [llvm|
{
^0(%arg3 : i1, %arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "ne" %arg4, %arg5 : i8
  %2 = "llvm.select"(%arg3, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%2, %arg4, %arg5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test_logical_and_ne_a_b_after := [llvm|
{
^0(%arg3 : i1, %arg4 : i8, %arg5 : i8):
  %0 = "llvm.select"(%arg3, %arg4, %arg5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_logical_and_ne_a_b_proof : test_logical_and_ne_a_b_before ⊑ test_logical_and_ne_a_b_after := by
  unfold test_logical_and_ne_a_b_before test_logical_and_ne_a_b_after
  simp_alive_peephole
  intros
  ---BEGIN test_logical_and_ne_a_b
  apply test_logical_and_ne_a_b_thm
  ---END test_logical_and_ne_a_b


