
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
section gnestedhselect_statements

def andcond_before := [llvm|
{
^0(%arg169 : i1, %arg170 : i1, %arg171 : i8, %arg172 : i8, %arg173 : i8):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg169, %arg170, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%arg169, %arg171, %arg172) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = "llvm.select"(%1, %arg173, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def andcond_after := [llvm|
{
^0(%arg169 : i1, %arg170 : i1, %arg171 : i8, %arg172 : i8, %arg173 : i8):
  %0 = "llvm.select"(%arg170, %arg173, %arg171) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %1 = "llvm.select"(%arg169, %0, %arg172) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem andcond_proof : andcond_before ⊑ andcond_after := by
  unfold andcond_before andcond_after
  simp_alive_peephole
  intros
  ---BEGIN andcond
  all_goals (try extract_goal ; sorry)
  ---END andcond



def orcond_before := [llvm|
{
^0(%arg164 : i1, %arg165 : i1, %arg166 : i8, %arg167 : i8, %arg168 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg164, %0, %arg165) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%arg164, %arg166, %arg167) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = "llvm.select"(%1, %2, %arg168) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def orcond_after := [llvm|
{
^0(%arg164 : i1, %arg165 : i1, %arg166 : i8, %arg167 : i8, %arg168 : i8):
  %0 = "llvm.select"(%arg165, %arg167, %arg168) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %1 = "llvm.select"(%arg164, %arg166, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem orcond_proof : orcond_before ⊑ orcond_after := by
  unfold orcond_before orcond_after
  simp_alive_peephole
  intros
  ---BEGIN orcond
  all_goals (try extract_goal ; sorry)
  ---END orcond



def andcond.001.inv.outer.cond_before := [llvm|
{
^0(%arg75 : i1, %arg76 : i1, %arg77 : i1, %arg78 : i1, %arg79 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg75, %arg76, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg75, %arg77, %arg78) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.xor %2, %1 : i1
  %5 = "llvm.select"(%4, %3, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def andcond.001.inv.outer.cond_after := [llvm|
{
^0(%arg75 : i1, %arg76 : i1, %arg77 : i1, %arg78 : i1, %arg79 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg76, %0 : i1
  %3 = "llvm.select"(%2, %arg77, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg75, %3, %arg78) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem andcond.001.inv.outer.cond_proof : andcond.001.inv.outer.cond_before ⊑ andcond.001.inv.outer.cond_after := by
  unfold andcond.001.inv.outer.cond_before andcond.001.inv.outer.cond_after
  simp_alive_peephole
  intros
  ---BEGIN andcond.001.inv.outer.cond
  all_goals (try extract_goal ; sorry)
  ---END andcond.001.inv.outer.cond



def orcond.001.inv.outer.cond_before := [llvm|
{
^0(%arg70 : i1, %arg71 : i1, %arg72 : i1, %arg73 : i1, %arg74 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg70, %0, %arg71) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%arg70, %arg72, %arg73) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = llvm.xor %1, %0 : i1
  %4 = "llvm.select"(%3, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def orcond.001.inv.outer.cond_after := [llvm|
{
^0(%arg70 : i1, %arg71 : i1, %arg72 : i1, %arg73 : i1, %arg74 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg71, %0 : i1
  %2 = "llvm.select"(%1, %0, %arg73) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg70, %arg72, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem orcond.001.inv.outer.cond_proof : orcond.001.inv.outer.cond_before ⊑ orcond.001.inv.outer.cond_after := by
  unfold orcond.001.inv.outer.cond_before orcond.001.inv.outer.cond_after
  simp_alive_peephole
  intros
  ---BEGIN orcond.001.inv.outer.cond
  all_goals (try extract_goal ; sorry)
  ---END orcond.001.inv.outer.cond



def andcond.010.inv.inner.cond.in.inner.sel_before := [llvm|
{
^0(%arg65 : i1, %arg66 : i1, %arg67 : i1, %arg68 : i1, %arg69 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg65, %arg66, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = llvm.xor %arg65, %1 : i1
  %4 = "llvm.select"(%3, %arg68, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%2, %arg69, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def andcond.010.inv.inner.cond.in.inner.sel_after := [llvm|
{
^0(%arg65 : i1, %arg66 : i1, %arg67 : i1, %arg68 : i1, %arg69 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg66, %arg69, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%arg65, %1, %arg68) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem andcond.010.inv.inner.cond.in.inner.sel_proof : andcond.010.inv.inner.cond.in.inner.sel_before ⊑ andcond.010.inv.inner.cond.in.inner.sel_after := by
  unfold andcond.010.inv.inner.cond.in.inner.sel_before andcond.010.inv.inner.cond.in.inner.sel_after
  simp_alive_peephole
  intros
  ---BEGIN andcond.010.inv.inner.cond.in.inner.sel
  all_goals (try extract_goal ; sorry)
  ---END andcond.010.inv.inner.cond.in.inner.sel



def orcond.010.inv.inner.cond.in.inner.sel_before := [llvm|
{
^0(%arg60 : i1, %arg61 : i1, %arg62 : i1, %arg63 : i1, %arg64 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg60, %0, %arg61) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.xor %arg60, %0 : i1
  %3 = "llvm.select"(%2, %0, %arg62) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%1, %3, %arg64) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def orcond.010.inv.inner.cond.in.inner.sel_after := [llvm|
{
^0(%arg60 : i1, %arg61 : i1, %arg62 : i1, %arg63 : i1, %arg64 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg61, %0, %arg64) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%arg60, %arg62, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem orcond.010.inv.inner.cond.in.inner.sel_proof : orcond.010.inv.inner.cond.in.inner.sel_before ⊑ orcond.010.inv.inner.cond.in.inner.sel_after := by
  unfold orcond.010.inv.inner.cond.in.inner.sel_before orcond.010.inv.inner.cond.in.inner.sel_after
  simp_alive_peephole
  intros
  ---BEGIN orcond.010.inv.inner.cond.in.inner.sel
  all_goals (try extract_goal ; sorry)
  ---END orcond.010.inv.inner.cond.in.inner.sel



def andcond.100.inv.inner.cond.in.outer.cond_before := [llvm|
{
^0(%arg55 : i1, %arg56 : i1, %arg57 : i8, %arg58 : i8, %arg59 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg55, %0 : i1
  %3 = "llvm.select"(%2, %arg56, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg55, %arg57, %arg58) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = "llvm.select"(%3, %arg59, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def andcond.100.inv.inner.cond.in.outer.cond_after := [llvm|
{
^0(%arg55 : i1, %arg56 : i1, %arg57 : i8, %arg58 : i8, %arg59 : i8):
  %0 = "llvm.select"(%arg56, %arg59, %arg58) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %1 = "llvm.select"(%arg55, %arg57, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem andcond.100.inv.inner.cond.in.outer.cond_proof : andcond.100.inv.inner.cond.in.outer.cond_before ⊑ andcond.100.inv.inner.cond.in.outer.cond_after := by
  unfold andcond.100.inv.inner.cond.in.outer.cond_before andcond.100.inv.inner.cond.in.outer.cond_after
  simp_alive_peephole
  intros
  ---BEGIN andcond.100.inv.inner.cond.in.outer.cond
  all_goals (try extract_goal ; sorry)
  ---END andcond.100.inv.inner.cond.in.outer.cond



def orcond.100.inv.inner.cond.in.outer.cond_before := [llvm|
{
^0(%arg50 : i1, %arg51 : i1, %arg52 : i8, %arg53 : i8, %arg54 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg50, %0 : i1
  %2 = "llvm.select"(%1, %0, %arg51) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg50, %arg52, %arg53) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = "llvm.select"(%2, %3, %arg54) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def orcond.100.inv.inner.cond.in.outer.cond_after := [llvm|
{
^0(%arg50 : i1, %arg51 : i1, %arg52 : i8, %arg53 : i8, %arg54 : i8):
  %0 = "llvm.select"(%arg51, %arg52, %arg54) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %1 = "llvm.select"(%arg50, %0, %arg53) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem orcond.100.inv.inner.cond.in.outer.cond_proof : orcond.100.inv.inner.cond.in.outer.cond_before ⊑ orcond.100.inv.inner.cond.in.outer.cond_after := by
  unfold orcond.100.inv.inner.cond.in.outer.cond_before orcond.100.inv.inner.cond.in.outer.cond_after
  simp_alive_peephole
  intros
  ---BEGIN orcond.100.inv.inner.cond.in.outer.cond
  all_goals (try extract_goal ; sorry)
  ---END orcond.100.inv.inner.cond.in.outer.cond



def andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_before := [llvm|
{
^0(%arg25 : i1, %arg26 : i1, %arg27 : i1, %arg28 : i1, %arg29 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg25, %0 : i1
  %3 = "llvm.select"(%2, %arg26, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.xor %arg25, %0 : i1
  %5 = "llvm.select"(%4, %arg28, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = "llvm.select"(%3, %arg29, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_after := [llvm|
{
^0(%arg25 : i1, %arg26 : i1, %arg27 : i1, %arg28 : i1, %arg29 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg25, %0 : i1
  %3 = "llvm.select"(%arg26, %arg29, %arg28) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_proof : andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_before ⊑ andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_after := by
  unfold andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_before andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_after
  simp_alive_peephole
  intros
  ---BEGIN andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond
  all_goals (try extract_goal ; sorry)
  ---END andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond



def orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_before := [llvm|
{
^0(%arg20 : i1, %arg21 : i1, %arg22 : i1, %arg23 : i1, %arg24 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg20, %0 : i1
  %2 = "llvm.select"(%1, %0, %arg21) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = llvm.xor %arg20, %0 : i1
  %4 = "llvm.select"(%3, %0, %arg22) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%2, %4, %arg24) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_after := [llvm|
{
^0(%arg20 : i1, %arg21 : i1, %arg22 : i1, %arg23 : i1, %arg24 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg20, %0 : i1
  %2 = "llvm.select"(%arg21, %arg22, %arg24) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%1, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_proof : orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_before ⊑ orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_after := by
  unfold orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_before orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_after
  simp_alive_peephole
  intros
  ---BEGIN orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond
  all_goals (try extract_goal ; sorry)
  ---END orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond



def test_implied_true_before := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(5 : i8) : i8
  %3 = llvm.mlir.constant(20 : i8) : i8
  %4 = llvm.icmp "slt" %arg9, %0 : i8
  %5 = llvm.icmp "slt" %arg9, %1 : i8
  %6 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %7 = "llvm.select"(%5, %6, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def test_implied_true_after := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(20 : i8) : i8
  %2 = llvm.icmp "slt" %arg9, %0 : i8
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_implied_true_proof : test_implied_true_before ⊑ test_implied_true_after := by
  unfold test_implied_true_before test_implied_true_after
  simp_alive_peephole
  intros
  ---BEGIN test_implied_true
  all_goals (try extract_goal ; sorry)
  ---END test_implied_true



def test_implied_true_falseval_before := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(5 : i8) : i8
  %3 = llvm.mlir.constant(20 : i8) : i8
  %4 = llvm.icmp "slt" %arg7, %0 : i8
  %5 = llvm.icmp "sgt" %arg7, %1 : i8
  %6 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def test_implied_true_falseval_after := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(20 : i8) : i8
  %2 = llvm.icmp "sgt" %arg7, %0 : i8
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_implied_true_falseval_proof : test_implied_true_falseval_before ⊑ test_implied_true_falseval_after := by
  unfold test_implied_true_falseval_before test_implied_true_falseval_after
  simp_alive_peephole
  intros
  ---BEGIN test_implied_true_falseval
  all_goals (try extract_goal ; sorry)
  ---END test_implied_true_falseval



def test_implied_false_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(5 : i8) : i8
  %3 = llvm.mlir.constant(20 : i8) : i8
  %4 = llvm.icmp "sgt" %arg6, %0 : i8
  %5 = llvm.icmp "slt" %arg6, %1 : i8
  %6 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %7 = "llvm.select"(%5, %6, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def test_implied_false_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.mlir.constant(20 : i8) : i8
  %3 = llvm.icmp "slt" %arg6, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_implied_false_proof : test_implied_false_before ⊑ test_implied_false_after := by
  unfold test_implied_false_before test_implied_false_after
  simp_alive_peephole
  intros
  ---BEGIN test_implied_false
  all_goals (try extract_goal ; sorry)
  ---END test_implied_false


