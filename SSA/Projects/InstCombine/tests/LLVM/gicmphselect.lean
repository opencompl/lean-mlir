
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
section gicmphselect_statements

def icmp_select_const_before := [llvm|
{
^0(%arg92 : i8, %arg93 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg92, %0 : i8
  %2 = "llvm.select"(%1, %0, %arg93) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.icmp "eq" %2, %0 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_select_const_after := [llvm|
{
^0(%arg92 : i8, %arg93 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "eq" %arg92, %0 : i8
  %3 = llvm.icmp "eq" %arg93, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_select_const_proof : icmp_select_const_before ⊑ icmp_select_const_after := by
  unfold icmp_select_const_before icmp_select_const_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_select_const
  all_goals (try extract_goal ; sorry)
  ---END icmp_select_const



def icmp_select_var_before := [llvm|
{
^0(%arg89 : i8, %arg90 : i8, %arg91 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg89, %0 : i8
  %2 = "llvm.select"(%1, %arg91, %arg90) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.icmp "eq" %2, %arg91 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_select_var_after := [llvm|
{
^0(%arg89 : i8, %arg90 : i8, %arg91 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "eq" %arg89, %0 : i8
  %3 = llvm.icmp "eq" %arg90, %arg91 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_select_var_proof : icmp_select_var_before ⊑ icmp_select_var_after := by
  unfold icmp_select_var_before icmp_select_var_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_select_var
  all_goals (try extract_goal ; sorry)
  ---END icmp_select_var



def icmp_select_var_commuted_before := [llvm|
{
^0(%arg86 : i8, %arg87 : i8, %arg88 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.udiv %0, %arg88 : i8
  %3 = llvm.icmp "eq" %arg86, %1 : i8
  %4 = "llvm.select"(%3, %2, %arg87) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.icmp "eq" %2, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_select_var_commuted_after := [llvm|
{
^0(%arg86 : i8, %arg87 : i8, %arg88 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.udiv %0, %arg88 : i8
  %4 = llvm.icmp "eq" %arg86, %1 : i8
  %5 = llvm.icmp "eq" %arg87, %3 : i8
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_select_var_commuted_proof : icmp_select_var_commuted_before ⊑ icmp_select_var_commuted_after := by
  unfold icmp_select_var_commuted_before icmp_select_var_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_select_var_commuted
  all_goals (try extract_goal ; sorry)
  ---END icmp_select_var_commuted



def icmp_select_var_select_before := [llvm|
{
^0(%arg83 : i8, %arg84 : i8, %arg85 : i1):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = "llvm.select"(%arg85, %arg83, %arg84) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %2 = llvm.icmp "eq" %arg83, %0 : i8
  %3 = "llvm.select"(%2, %1, %arg84) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.icmp "eq" %1, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_select_var_select_after := [llvm|
{
^0(%arg83 : i8, %arg84 : i8, %arg85 : i1):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "eq" %arg83, %0 : i8
  %3 = llvm.icmp "eq" %arg83, %arg84 : i8
  %4 = llvm.xor %arg85, %1 : i1
  %5 = "llvm.select"(%2, %1, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = "llvm.select"(%5, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_select_var_select_proof : icmp_select_var_select_before ⊑ icmp_select_var_select_after := by
  unfold icmp_select_var_select_before icmp_select_var_select_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_select_var_select
  all_goals (try extract_goal ; sorry)
  ---END icmp_select_var_select



def icmp_select_var_both_fold_before := [llvm|
{
^0(%arg80 : i8, %arg81 : i8, %arg82 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(2 : i8) : i8
  %3 = llvm.or %arg82, %0 : i8
  %4 = llvm.icmp "eq" %arg80, %1 : i8
  %5 = "llvm.select"(%4, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %6 = llvm.icmp "eq" %5, %3 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_select_var_both_fold_after := [llvm|
{
^0(%arg80 : i8, %arg81 : i8, %arg82 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg80, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_select_var_both_fold_proof : icmp_select_var_both_fold_before ⊑ icmp_select_var_both_fold_after := by
  unfold icmp_select_var_both_fold_before icmp_select_var_both_fold_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_select_var_both_fold
  all_goals (try extract_goal ; sorry)
  ---END icmp_select_var_both_fold



def icmp_select_var_pred_ne_before := [llvm|
{
^0(%arg71 : i8, %arg72 : i8, %arg73 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg71, %0 : i8
  %2 = "llvm.select"(%1, %arg73, %arg72) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.icmp "ne" %2, %arg73 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_select_var_pred_ne_after := [llvm|
{
^0(%arg71 : i8, %arg72 : i8, %arg73 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ne" %arg71, %0 : i8
  %3 = llvm.icmp "ne" %arg72, %arg73 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_select_var_pred_ne_proof : icmp_select_var_pred_ne_before ⊑ icmp_select_var_pred_ne_after := by
  unfold icmp_select_var_pred_ne_before icmp_select_var_pred_ne_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_select_var_pred_ne
  all_goals (try extract_goal ; sorry)
  ---END icmp_select_var_pred_ne



def icmp_select_var_pred_ult_before := [llvm|
{
^0(%arg68 : i8, %arg69 : i8, %arg70 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.add %arg70, %0 overflow<nuw> : i8
  %3 = llvm.icmp "eq" %arg68, %1 : i8
  %4 = "llvm.select"(%3, %arg70, %arg69) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.icmp "ult" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_select_var_pred_ult_after := [llvm|
{
^0(%arg68 : i8, %arg69 : i8, %arg70 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.add %arg70, %0 overflow<nuw> : i8
  %4 = llvm.icmp "eq" %arg68, %1 : i8
  %5 = llvm.icmp "ult" %arg69, %3 : i8
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_select_var_pred_ult_proof : icmp_select_var_pred_ult_before ⊑ icmp_select_var_pred_ult_after := by
  unfold icmp_select_var_pred_ult_before icmp_select_var_pred_ult_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_select_var_pred_ult
  all_goals (try extract_goal ; sorry)
  ---END icmp_select_var_pred_ult



def icmp_select_var_pred_uge_before := [llvm|
{
^0(%arg65 : i8, %arg66 : i8, %arg67 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.add %arg67, %0 overflow<nuw> : i8
  %3 = llvm.icmp "eq" %arg65, %1 : i8
  %4 = "llvm.select"(%3, %arg67, %arg66) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.icmp "uge" %4, %2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_select_var_pred_uge_after := [llvm|
{
^0(%arg65 : i8, %arg66 : i8, %arg67 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.add %arg67, %0 overflow<nuw> : i8
  %4 = llvm.icmp "ne" %arg65, %1 : i8
  %5 = llvm.icmp "uge" %arg66, %3 : i8
  %6 = "llvm.select"(%4, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_select_var_pred_uge_proof : icmp_select_var_pred_uge_before ⊑ icmp_select_var_pred_uge_after := by
  unfold icmp_select_var_pred_uge_before icmp_select_var_pred_uge_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_select_var_pred_uge
  all_goals (try extract_goal ; sorry)
  ---END icmp_select_var_pred_uge



def icmp_select_var_pred_uge_commuted_before := [llvm|
{
^0(%arg62 : i8, %arg63 : i8, %arg64 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.add %arg64, %0 overflow<nuw> : i8
  %3 = llvm.icmp "eq" %arg62, %1 : i8
  %4 = "llvm.select"(%3, %arg64, %arg63) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.icmp "uge" %2, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_select_var_pred_uge_commuted_after := [llvm|
{
^0(%arg62 : i8, %arg63 : i8, %arg64 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.add %arg64, %0 overflow<nuw> : i8
  %4 = llvm.icmp "eq" %arg62, %1 : i8
  %5 = llvm.icmp "ule" %arg63, %3 : i8
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_select_var_pred_uge_commuted_proof : icmp_select_var_pred_uge_commuted_before ⊑ icmp_select_var_pred_uge_commuted_after := by
  unfold icmp_select_var_pred_uge_commuted_before icmp_select_var_pred_uge_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_select_var_pred_uge_commuted
  all_goals (try extract_goal ; sorry)
  ---END icmp_select_var_pred_uge_commuted



def icmp_select_implied_cond_before := [llvm|
{
^0(%arg60 : i8, %arg61 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg60, %0 : i8
  %2 = "llvm.select"(%1, %0, %arg61) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.icmp "eq" %2, %arg60 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_select_implied_cond_after := [llvm|
{
^0(%arg60 : i8, %arg61 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "eq" %arg60, %0 : i8
  %3 = llvm.icmp "eq" %arg61, %arg60 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_select_implied_cond_proof : icmp_select_implied_cond_before ⊑ icmp_select_implied_cond_after := by
  unfold icmp_select_implied_cond_before icmp_select_implied_cond_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_select_implied_cond
  all_goals (try extract_goal ; sorry)
  ---END icmp_select_implied_cond



def icmp_select_implied_cond_ne_before := [llvm|
{
^0(%arg58 : i8, %arg59 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg58, %0 : i8
  %2 = "llvm.select"(%1, %0, %arg59) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.icmp "ne" %2, %arg58 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_select_implied_cond_ne_after := [llvm|
{
^0(%arg58 : i8, %arg59 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ne" %arg58, %0 : i8
  %3 = llvm.icmp "ne" %arg59, %arg58 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_select_implied_cond_ne_proof : icmp_select_implied_cond_ne_before ⊑ icmp_select_implied_cond_ne_after := by
  unfold icmp_select_implied_cond_ne_before icmp_select_implied_cond_ne_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_select_implied_cond_ne
  all_goals (try extract_goal ; sorry)
  ---END icmp_select_implied_cond_ne



def icmp_select_implied_cond_swapped_select_before := [llvm|
{
^0(%arg56 : i8, %arg57 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg56, %0 : i8
  %2 = "llvm.select"(%1, %arg57, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.icmp "eq" %2, %arg56 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_select_implied_cond_swapped_select_after := [llvm|
{
^0(%arg56 : i8, %arg57 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg56, %0 : i8
  %3 = llvm.icmp "eq" %arg57, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_select_implied_cond_swapped_select_proof : icmp_select_implied_cond_swapped_select_before ⊑ icmp_select_implied_cond_swapped_select_after := by
  unfold icmp_select_implied_cond_swapped_select_before icmp_select_implied_cond_swapped_select_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_select_implied_cond_swapped_select
  all_goals (try extract_goal ; sorry)
  ---END icmp_select_implied_cond_swapped_select



def icmp_select_implied_cond_relational_before := [llvm|
{
^0(%arg52 : i8, %arg53 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.icmp "ugt" %arg52, %0 : i8
  %2 = "llvm.select"(%1, %0, %arg53) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.icmp "ult" %2, %arg52 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_select_implied_cond_relational_after := [llvm|
{
^0(%arg52 : i8, %arg53 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ugt" %arg52, %0 : i8
  %3 = llvm.icmp "ult" %arg53, %arg52 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_select_implied_cond_relational_proof : icmp_select_implied_cond_relational_before ⊑ icmp_select_implied_cond_relational_after := by
  unfold icmp_select_implied_cond_relational_before icmp_select_implied_cond_relational_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_select_implied_cond_relational
  all_goals (try extract_goal ; sorry)
  ---END icmp_select_implied_cond_relational



def select_constants_and_icmp_eq0_before := [llvm|
{
^0(%arg46 : i1, %arg47 : i1):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = "llvm.select"(%arg46, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = "llvm.select"(%arg47, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.and %3, %4 : i8
  %6 = llvm.icmp "eq" %5, %2 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def select_constants_and_icmp_eq0_after := [llvm|
{
^0(%arg46 : i1, %arg47 : i1):
  %0 = llvm.xor %arg46, %arg47 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_constants_and_icmp_eq0_proof : select_constants_and_icmp_eq0_before ⊑ select_constants_and_icmp_eq0_after := by
  unfold select_constants_and_icmp_eq0_before select_constants_and_icmp_eq0_after
  simp_alive_peephole
  intros
  ---BEGIN select_constants_and_icmp_eq0
  all_goals (try extract_goal ; sorry)
  ---END select_constants_and_icmp_eq0



def select_constants_and_icmp_eq0_common_bit_before := [llvm|
{
^0(%arg40 : i1, %arg41 : i1):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = "llvm.select"(%arg40, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = "llvm.select"(%arg41, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.and %3, %4 : i8
  %6 = llvm.icmp "eq" %5, %2 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def select_constants_and_icmp_eq0_common_bit_after := [llvm|
{
^0(%arg40 : i1, %arg41 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_constants_and_icmp_eq0_common_bit_proof : select_constants_and_icmp_eq0_common_bit_before ⊑ select_constants_and_icmp_eq0_common_bit_after := by
  unfold select_constants_and_icmp_eq0_common_bit_before select_constants_and_icmp_eq0_common_bit_after
  simp_alive_peephole
  intros
  ---BEGIN select_constants_and_icmp_eq0_common_bit
  all_goals (try extract_goal ; sorry)
  ---END select_constants_and_icmp_eq0_common_bit



def select_constants_and_icmp_eq0_zero_tval_before := [llvm|
{
^0(%arg34 : i1, %arg35 : i1):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(12 : i8) : i8
  %2 = "llvm.select"(%arg34, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = "llvm.select"(%arg35, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %2, %3 : i8
  %5 = llvm.icmp "eq" %4, %0 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def select_constants_and_icmp_eq0_zero_tval_after := [llvm|
{
^0(%arg34 : i1, %arg35 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg34, %0, %arg35) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_constants_and_icmp_eq0_zero_tval_proof : select_constants_and_icmp_eq0_zero_tval_before ⊑ select_constants_and_icmp_eq0_zero_tval_after := by
  unfold select_constants_and_icmp_eq0_zero_tval_before select_constants_and_icmp_eq0_zero_tval_after
  simp_alive_peephole
  intros
  ---BEGIN select_constants_and_icmp_eq0_zero_tval
  all_goals (try extract_goal ; sorry)
  ---END select_constants_and_icmp_eq0_zero_tval



def select_constants_and_icmp_eq0_zero_fval_before := [llvm|
{
^0(%arg32 : i1, %arg33 : i1):
  %0 = llvm.mlir.constant(12 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = "llvm.select"(%arg32, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = "llvm.select"(%arg33, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %2, %3 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def select_constants_and_icmp_eq0_zero_fval_after := [llvm|
{
^0(%arg32 : i1, %arg33 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg32, %arg33, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = llvm.xor %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_constants_and_icmp_eq0_zero_fval_proof : select_constants_and_icmp_eq0_zero_fval_before ⊑ select_constants_and_icmp_eq0_zero_fval_after := by
  unfold select_constants_and_icmp_eq0_zero_fval_before select_constants_and_icmp_eq0_zero_fval_after
  simp_alive_peephole
  intros
  ---BEGIN select_constants_and_icmp_eq0_zero_fval
  all_goals (try extract_goal ; sorry)
  ---END select_constants_and_icmp_eq0_zero_fval



def select_constants_and_icmp_ne0_before := [llvm|
{
^0(%arg26 : i1, %arg27 : i1):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = "llvm.select"(%arg26, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = "llvm.select"(%arg27, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.and %3, %4 : i8
  %6 = llvm.icmp "ne" %5, %2 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def select_constants_and_icmp_ne0_after := [llvm|
{
^0(%arg26 : i1, %arg27 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg26, %arg27 : i1
  %2 = llvm.xor %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_constants_and_icmp_ne0_proof : select_constants_and_icmp_ne0_before ⊑ select_constants_and_icmp_ne0_after := by
  unfold select_constants_and_icmp_ne0_before select_constants_and_icmp_ne0_after
  simp_alive_peephole
  intros
  ---BEGIN select_constants_and_icmp_ne0
  all_goals (try extract_goal ; sorry)
  ---END select_constants_and_icmp_ne0



def select_constants_and_icmp_ne0_common_bit_before := [llvm|
{
^0(%arg18 : i1, %arg19 : i1):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = "llvm.select"(%arg18, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = "llvm.select"(%arg19, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.and %3, %4 : i8
  %6 = llvm.icmp "ne" %5, %2 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def select_constants_and_icmp_ne0_common_bit_after := [llvm|
{
^0(%arg18 : i1, %arg19 : i1):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_constants_and_icmp_ne0_common_bit_proof : select_constants_and_icmp_ne0_common_bit_before ⊑ select_constants_and_icmp_ne0_common_bit_after := by
  unfold select_constants_and_icmp_ne0_common_bit_before select_constants_and_icmp_ne0_common_bit_after
  simp_alive_peephole
  intros
  ---BEGIN select_constants_and_icmp_ne0_common_bit
  all_goals (try extract_goal ; sorry)
  ---END select_constants_and_icmp_ne0_common_bit



def select_constants_and_icmp_ne0_zero_tval_before := [llvm|
{
^0(%arg12 : i1, %arg13 : i1):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(12 : i8) : i8
  %2 = "llvm.select"(%arg12, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = "llvm.select"(%arg13, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %2, %3 : i8
  %5 = llvm.icmp "ne" %4, %0 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def select_constants_and_icmp_ne0_zero_tval_after := [llvm|
{
^0(%arg12 : i1, %arg13 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg12, %0, %arg13) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.xor %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_constants_and_icmp_ne0_zero_tval_proof : select_constants_and_icmp_ne0_zero_tval_before ⊑ select_constants_and_icmp_ne0_zero_tval_after := by
  unfold select_constants_and_icmp_ne0_zero_tval_before select_constants_and_icmp_ne0_zero_tval_after
  simp_alive_peephole
  intros
  ---BEGIN select_constants_and_icmp_ne0_zero_tval
  all_goals (try extract_goal ; sorry)
  ---END select_constants_and_icmp_ne0_zero_tval



def select_constants_and_icmp_ne0_zero_fval_before := [llvm|
{
^0(%arg10 : i1, %arg11 : i1):
  %0 = llvm.mlir.constant(12 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = "llvm.select"(%arg10, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = "llvm.select"(%arg11, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %2, %3 : i8
  %5 = llvm.icmp "ne" %4, %1 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def select_constants_and_icmp_ne0_zero_fval_after := [llvm|
{
^0(%arg10 : i1, %arg11 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg10, %arg11, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_constants_and_icmp_ne0_zero_fval_proof : select_constants_and_icmp_ne0_zero_fval_before ⊑ select_constants_and_icmp_ne0_zero_fval_after := by
  unfold select_constants_and_icmp_ne0_zero_fval_before select_constants_and_icmp_ne0_zero_fval_after
  simp_alive_peephole
  intros
  ---BEGIN select_constants_and_icmp_ne0_zero_fval
  all_goals (try extract_goal ; sorry)
  ---END select_constants_and_icmp_ne0_zero_fval



def icmp_eq_select_before := [llvm|
{
^0(%arg3 : i1, %arg4 : i32, %arg5 : i32):
  %0 = "llvm.select"(%arg3, %arg4, %arg5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %1 = "llvm.select"(%arg3, %arg5, %arg4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "eq" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def icmp_eq_select_after := [llvm|
{
^0(%arg3 : i1, %arg4 : i32, %arg5 : i32):
  %0 = llvm.icmp "eq" %arg4, %arg5 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_select_proof : icmp_eq_select_before ⊑ icmp_eq_select_after := by
  unfold icmp_eq_select_before icmp_eq_select_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_select
  all_goals (try extract_goal ; sorry)
  ---END icmp_eq_select


