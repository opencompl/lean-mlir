
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
section glogicalhselecthinseltpoison_statements

def foo_before := [llvm|
{
^0(%arg113 : i32, %arg114 : i32, %arg115 : i32, %arg116 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "slt" %arg113, %arg114 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.and %arg115, %2 : i32
  %4 = llvm.xor %2, %0 : i32
  %5 = llvm.and %arg116, %4 : i32
  %6 = llvm.or %3, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def foo_after := [llvm|
{
^0(%arg113 : i32, %arg114 : i32, %arg115 : i32, %arg116 : i32):
  %0 = llvm.icmp "slt" %arg113, %arg114 : i32
  %1 = "llvm.select"(%0, %arg115, %arg116) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo_proof : foo_before ⊑ foo_after := by
  unfold foo_before foo_after
  simp_alive_peephole
  intros
  ---BEGIN foo
  all_goals (try extract_goal ; sorry)
  ---END foo



def bar_before := [llvm|
{
^0(%arg109 : i32, %arg110 : i32, %arg111 : i32, %arg112 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "slt" %arg109, %arg110 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.and %arg111, %2 : i32
  %4 = llvm.xor %2, %0 : i32
  %5 = llvm.and %arg112, %4 : i32
  %6 = llvm.or %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def bar_after := [llvm|
{
^0(%arg109 : i32, %arg110 : i32, %arg111 : i32, %arg112 : i32):
  %0 = llvm.icmp "slt" %arg109, %arg110 : i32
  %1 = "llvm.select"(%0, %arg111, %arg112) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bar_proof : bar_before ⊑ bar_after := by
  unfold bar_before bar_after
  simp_alive_peephole
  intros
  ---BEGIN bar
  all_goals (try extract_goal ; sorry)
  ---END bar



def goo_before := [llvm|
{
^0(%arg105 : i32, %arg106 : i32, %arg107 : i32, %arg108 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "slt" %arg105, %arg106 : i32
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.and %3, %arg107 : i32
  %5 = llvm.xor %3, %0 : i32
  %6 = llvm.and %5, %arg108 : i32
  %7 = llvm.or %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def goo_after := [llvm|
{
^0(%arg105 : i32, %arg106 : i32, %arg107 : i32, %arg108 : i32):
  %0 = llvm.icmp "slt" %arg105, %arg106 : i32
  %1 = "llvm.select"(%0, %arg107, %arg108) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem goo_proof : goo_before ⊑ goo_after := by
  unfold goo_before goo_after
  simp_alive_peephole
  intros
  ---BEGIN goo
  all_goals (try extract_goal ; sorry)
  ---END goo



def poo_before := [llvm|
{
^0(%arg101 : i32, %arg102 : i32, %arg103 : i32, %arg104 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "slt" %arg101, %arg102 : i32
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.and %3, %arg103 : i32
  %5 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = llvm.and %5, %arg104 : i32
  %7 = llvm.or %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def poo_after := [llvm|
{
^0(%arg101 : i32, %arg102 : i32, %arg103 : i32, %arg104 : i32):
  %0 = llvm.icmp "slt" %arg101, %arg102 : i32
  %1 = "llvm.select"(%0, %arg103, %arg104) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem poo_proof : poo_before ⊑ poo_after := by
  unfold poo_before poo_after
  simp_alive_peephole
  intros
  ---BEGIN poo
  all_goals (try extract_goal ; sorry)
  ---END poo



def fold_inverted_icmp_preds_before := [llvm|
{
^0(%arg97 : i32, %arg98 : i32, %arg99 : i32, %arg100 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg97, %arg98 : i32
  %2 = "llvm.select"(%1, %arg99, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.icmp "sge" %arg97, %arg98 : i32
  %4 = "llvm.select"(%3, %arg100, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.or %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def fold_inverted_icmp_preds_after := [llvm|
{
^0(%arg97 : i32, %arg98 : i32, %arg99 : i32, %arg100 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg97, %arg98 : i32
  %2 = "llvm.select"(%1, %arg99, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.icmp "slt" %arg97, %arg98 : i32
  %4 = "llvm.select"(%3, %0, %arg100) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.or %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_inverted_icmp_preds_proof : fold_inverted_icmp_preds_before ⊑ fold_inverted_icmp_preds_after := by
  unfold fold_inverted_icmp_preds_before fold_inverted_icmp_preds_after
  simp_alive_peephole
  intros
  ---BEGIN fold_inverted_icmp_preds
  all_goals (try extract_goal ; sorry)
  ---END fold_inverted_icmp_preds



def fold_inverted_icmp_preds_reverse_before := [llvm|
{
^0(%arg93 : i32, %arg94 : i32, %arg95 : i32, %arg96 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg93, %arg94 : i32
  %2 = "llvm.select"(%1, %0, %arg95) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.icmp "sge" %arg93, %arg94 : i32
  %4 = "llvm.select"(%3, %0, %arg96) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.or %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def fold_inverted_icmp_preds_reverse_after := [llvm|
{
^0(%arg93 : i32, %arg94 : i32, %arg95 : i32, %arg96 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg93, %arg94 : i32
  %2 = "llvm.select"(%1, %0, %arg95) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.icmp "slt" %arg93, %arg94 : i32
  %4 = "llvm.select"(%3, %arg96, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.or %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_inverted_icmp_preds_reverse_proof : fold_inverted_icmp_preds_reverse_before ⊑ fold_inverted_icmp_preds_reverse_after := by
  unfold fold_inverted_icmp_preds_reverse_before fold_inverted_icmp_preds_reverse_after
  simp_alive_peephole
  intros
  ---BEGIN fold_inverted_icmp_preds_reverse
  all_goals (try extract_goal ; sorry)
  ---END fold_inverted_icmp_preds_reverse



def par_before := [llvm|
{
^0(%arg81 : i32, %arg82 : i32, %arg83 : i32, %arg84 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "slt" %arg81, %arg82 : i32
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.and %3, %arg83 : i32
  %5 = llvm.xor %3, %0 : i32
  %6 = llvm.and %5, %arg84 : i32
  %7 = llvm.or %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def par_after := [llvm|
{
^0(%arg81 : i32, %arg82 : i32, %arg83 : i32, %arg84 : i32):
  %0 = llvm.icmp "slt" %arg81, %arg82 : i32
  %1 = "llvm.select"(%0, %arg83, %arg84) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem par_proof : par_before ⊑ par_after := by
  unfold par_before par_after
  simp_alive_peephole
  intros
  ---BEGIN par
  all_goals (try extract_goal ; sorry)
  ---END par



def bools_before := [llvm|
{
^0(%arg51 : i1, %arg52 : i1, %arg53 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg53, %0 : i1
  %2 = llvm.and %1, %arg51 : i1
  %3 = llvm.and %arg53, %arg52 : i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def bools_after := [llvm|
{
^0(%arg51 : i1, %arg52 : i1, %arg53 : i1):
  %0 = "llvm.select"(%arg53, %arg52, %arg51) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools_proof : bools_before ⊑ bools_after := by
  unfold bools_before bools_after
  simp_alive_peephole
  intros
  ---BEGIN bools
  all_goals (try extract_goal ; sorry)
  ---END bools



def bools_logical_before := [llvm|
{
^0(%arg48 : i1, %arg49 : i1, %arg50 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg50, %0 : i1
  %3 = "llvm.select"(%2, %arg48, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg50, %arg49, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_after := [llvm|
{
^0(%arg48 : i1, %arg49 : i1, %arg50 : i1):
  %0 = "llvm.select"(%arg50, %arg49, %arg48) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools_logical_proof : bools_logical_before ⊑ bools_logical_after := by
  unfold bools_logical_before bools_logical_after
  simp_alive_peephole
  intros
  ---BEGIN bools_logical
  all_goals (try extract_goal ; sorry)
  ---END bools_logical



def bools_multi_uses1_before := [llvm|
{
^0(%arg45 : i1, %arg46 : i1, %arg47 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg47, %0 : i1
  %2 = llvm.and %1, %arg45 : i1
  %3 = llvm.and %arg47, %arg46 : i1
  %4 = llvm.or %2, %3 : i1
  %5 = llvm.xor %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_multi_uses1_after := [llvm|
{
^0(%arg45 : i1, %arg46 : i1, %arg47 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg47, %0 : i1
  %2 = llvm.and %arg45, %1 : i1
  %3 = "llvm.select"(%arg47, %arg46, %arg45) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools_multi_uses1_proof : bools_multi_uses1_before ⊑ bools_multi_uses1_after := by
  unfold bools_multi_uses1_before bools_multi_uses1_after
  simp_alive_peephole
  intros
  ---BEGIN bools_multi_uses1
  all_goals (try extract_goal ; sorry)
  ---END bools_multi_uses1



def bools_multi_uses1_logical_before := [llvm|
{
^0(%arg42 : i1, %arg43 : i1, %arg44 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg44, %0 : i1
  %3 = "llvm.select"(%2, %arg42, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg44, %arg43, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.xor %5, %3 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def bools_multi_uses1_logical_after := [llvm|
{
^0(%arg42 : i1, %arg43 : i1, %arg44 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg44, %0 : i1
  %3 = "llvm.select"(%2, %arg42, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg44, %arg43, %arg42) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.xor %4, %3 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools_multi_uses1_logical_proof : bools_multi_uses1_logical_before ⊑ bools_multi_uses1_logical_after := by
  unfold bools_multi_uses1_logical_before bools_multi_uses1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN bools_multi_uses1_logical
  all_goals (try extract_goal ; sorry)
  ---END bools_multi_uses1_logical



def bools_multi_uses2_before := [llvm|
{
^0(%arg39 : i1, %arg40 : i1, %arg41 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg41, %0 : i1
  %2 = llvm.and %1, %arg39 : i1
  %3 = llvm.and %arg41, %arg40 : i1
  %4 = llvm.or %2, %3 : i1
  %5 = llvm.add %2, %3 : i1
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def bools_multi_uses2_after := [llvm|
{
^0(%arg39 : i1, %arg40 : i1, %arg41 : i1):
  %0 = "llvm.select"(%arg41, %arg40, %arg39) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools_multi_uses2_proof : bools_multi_uses2_before ⊑ bools_multi_uses2_after := by
  unfold bools_multi_uses2_before bools_multi_uses2_after
  simp_alive_peephole
  intros
  ---BEGIN bools_multi_uses2
  all_goals (try extract_goal ; sorry)
  ---END bools_multi_uses2



def bools_multi_uses2_logical_before := [llvm|
{
^0(%arg36 : i1, %arg37 : i1, %arg38 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg38, %0 : i1
  %3 = "llvm.select"(%2, %arg36, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg38, %arg37, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.add %3, %4 : i1
  %7 = "llvm.select"(%5, %6, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def bools_multi_uses2_logical_after := [llvm|
{
^0(%arg36 : i1, %arg37 : i1, %arg38 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg38, %0 : i1
  %3 = "llvm.select"(%2, %arg36, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg38, %arg37, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%arg38, %arg37, %arg36) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.xor %3, %4 : i1
  %7 = "llvm.select"(%5, %6, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bools_multi_uses2_logical_proof : bools_multi_uses2_logical_before ⊑ bools_multi_uses2_logical_after := by
  unfold bools_multi_uses2_logical_before bools_multi_uses2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN bools_multi_uses2_logical
  all_goals (try extract_goal ; sorry)
  ---END bools_multi_uses2_logical



def allSignBits_before := [llvm|
{
^0(%arg13 : i32, %arg14 : i32, %arg15 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.ashr %arg13, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = llvm.and %arg14, %2 : i32
  %5 = llvm.and %3, %arg15 : i32
  %6 = llvm.or %4, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def allSignBits_after := [llvm|
{
^0(%arg13 : i32, %arg14 : i32, %arg15 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg13, %0 : i32
  %2 = "llvm.select"(%1, %arg14, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.icmp "slt" %arg13, %0 : i32
  %4 = "llvm.select"(%3, %0, %arg15) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.or %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem allSignBits_proof : allSignBits_before ⊑ allSignBits_after := by
  unfold allSignBits_before allSignBits_after
  simp_alive_peephole
  intros
  ---BEGIN allSignBits
  all_goals (try extract_goal ; sorry)
  ---END allSignBits


