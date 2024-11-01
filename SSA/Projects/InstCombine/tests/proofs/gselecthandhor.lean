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



def logical_or_noundef_b_before := [llvm|
{
^0(%arg244 : i1, %arg245 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg244, %0, %arg245) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def logical_or_noundef_b_after := [llvm|
{
^0(%arg244 : i1, %arg245 : i1):
  %0 = llvm.or %arg244, %arg245 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_or_noundef_b_proof : logical_or_noundef_b_before ⊑ logical_or_noundef_b_after := by
  unfold logical_or_noundef_b_before logical_or_noundef_b_after
  simp_alive_peephole
  intros
  ---BEGIN logical_or_noundef_b
  apply logical_or_noundef_b_thm
  ---END logical_or_noundef_b



def logical_and_noundef_b_before := [llvm|
{
^0(%arg240 : i1, %arg241 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg240, %arg241, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def logical_and_noundef_b_after := [llvm|
{
^0(%arg240 : i1, %arg241 : i1):
  %0 = llvm.and %arg240, %arg241 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logical_and_noundef_b_proof : logical_and_noundef_b_before ⊑ logical_and_noundef_b_after := by
  unfold logical_and_noundef_b_before logical_and_noundef_b_after
  simp_alive_peephole
  intros
  ---BEGIN logical_and_noundef_b
  apply logical_and_noundef_b_thm
  ---END logical_and_noundef_b



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


