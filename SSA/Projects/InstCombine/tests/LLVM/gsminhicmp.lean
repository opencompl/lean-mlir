
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
section gsminhicmp_statements

def eq_smin1_before := [llvm|
{
^0(%arg87 : i32, %arg88 : i32):
  %0 = llvm.icmp "slt" %arg87, %arg88 : i32
  %1 = "llvm.select"(%0, %arg87, %arg88) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "eq" %1, %arg87 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def eq_smin1_after := [llvm|
{
^0(%arg87 : i32, %arg88 : i32):
  %0 = llvm.icmp "sle" %arg87, %arg88 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_smin1_proof : eq_smin1_before ⊑ eq_smin1_after := by
  unfold eq_smin1_before eq_smin1_after
  simp_alive_peephole
  intros
  ---BEGIN eq_smin1
  all_goals (try extract_goal ; sorry)
  ---END eq_smin1



def eq_smin2_before := [llvm|
{
^0(%arg85 : i32, %arg86 : i32):
  %0 = llvm.icmp "slt" %arg86, %arg85 : i32
  %1 = "llvm.select"(%0, %arg86, %arg85) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "eq" %1, %arg85 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def eq_smin2_after := [llvm|
{
^0(%arg85 : i32, %arg86 : i32):
  %0 = llvm.icmp "sle" %arg85, %arg86 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_smin2_proof : eq_smin2_before ⊑ eq_smin2_after := by
  unfold eq_smin2_before eq_smin2_after
  simp_alive_peephole
  intros
  ---BEGIN eq_smin2
  all_goals (try extract_goal ; sorry)
  ---END eq_smin2



def eq_smin3_before := [llvm|
{
^0(%arg83 : i32, %arg84 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg83, %0 : i32
  %2 = llvm.icmp "slt" %1, %arg84 : i32
  %3 = "llvm.select"(%2, %1, %arg84) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "eq" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def eq_smin3_after := [llvm|
{
^0(%arg83 : i32, %arg84 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg83, %0 : i32
  %2 = llvm.icmp "sle" %1, %arg84 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_smin3_proof : eq_smin3_before ⊑ eq_smin3_after := by
  unfold eq_smin3_before eq_smin3_after
  simp_alive_peephole
  intros
  ---BEGIN eq_smin3
  all_goals (try extract_goal ; sorry)
  ---END eq_smin3



def eq_smin4_before := [llvm|
{
^0(%arg81 : i32, %arg82 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg81, %0 : i32
  %2 = llvm.icmp "slt" %arg82, %1 : i32
  %3 = "llvm.select"(%2, %arg82, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "eq" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def eq_smin4_after := [llvm|
{
^0(%arg81 : i32, %arg82 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg81, %0 : i32
  %2 = llvm.icmp "sle" %1, %arg82 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_smin4_proof : eq_smin4_before ⊑ eq_smin4_after := by
  unfold eq_smin4_before eq_smin4_after
  simp_alive_peephole
  intros
  ---BEGIN eq_smin4
  all_goals (try extract_goal ; sorry)
  ---END eq_smin4



def sge_smin1_before := [llvm|
{
^0(%arg79 : i32, %arg80 : i32):
  %0 = llvm.icmp "slt" %arg79, %arg80 : i32
  %1 = "llvm.select"(%0, %arg79, %arg80) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "sge" %1, %arg79 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sge_smin1_after := [llvm|
{
^0(%arg79 : i32, %arg80 : i32):
  %0 = llvm.icmp "sge" %arg80, %arg79 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_smin1_proof : sge_smin1_before ⊑ sge_smin1_after := by
  unfold sge_smin1_before sge_smin1_after
  simp_alive_peephole
  intros
  ---BEGIN sge_smin1
  all_goals (try extract_goal ; sorry)
  ---END sge_smin1



def sge_smin2_before := [llvm|
{
^0(%arg77 : i32, %arg78 : i32):
  %0 = llvm.icmp "slt" %arg78, %arg77 : i32
  %1 = "llvm.select"(%0, %arg78, %arg77) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "sge" %1, %arg77 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sge_smin2_after := [llvm|
{
^0(%arg77 : i32, %arg78 : i32):
  %0 = llvm.icmp "sge" %arg78, %arg77 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_smin2_proof : sge_smin2_before ⊑ sge_smin2_after := by
  unfold sge_smin2_before sge_smin2_after
  simp_alive_peephole
  intros
  ---BEGIN sge_smin2
  all_goals (try extract_goal ; sorry)
  ---END sge_smin2



def sge_smin3_before := [llvm|
{
^0(%arg75 : i32, %arg76 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg75, %0 : i32
  %2 = llvm.icmp "slt" %1, %arg76 : i32
  %3 = "llvm.select"(%2, %1, %arg76) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "sle" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sge_smin3_after := [llvm|
{
^0(%arg75 : i32, %arg76 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg75, %0 : i32
  %2 = llvm.icmp "sge" %arg76, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_smin3_proof : sge_smin3_before ⊑ sge_smin3_after := by
  unfold sge_smin3_before sge_smin3_after
  simp_alive_peephole
  intros
  ---BEGIN sge_smin3
  all_goals (try extract_goal ; sorry)
  ---END sge_smin3



def sge_smin4_before := [llvm|
{
^0(%arg73 : i32, %arg74 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg73, %0 : i32
  %2 = llvm.icmp "slt" %arg74, %1 : i32
  %3 = "llvm.select"(%2, %arg74, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "sle" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sge_smin4_after := [llvm|
{
^0(%arg73 : i32, %arg74 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg73, %0 : i32
  %2 = llvm.icmp "sge" %arg74, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_smin4_proof : sge_smin4_before ⊑ sge_smin4_after := by
  unfold sge_smin4_before sge_smin4_after
  simp_alive_peephole
  intros
  ---BEGIN sge_smin4
  all_goals (try extract_goal ; sorry)
  ---END sge_smin4



def ne_smin1_before := [llvm|
{
^0(%arg71 : i32, %arg72 : i32):
  %0 = llvm.icmp "slt" %arg71, %arg72 : i32
  %1 = "llvm.select"(%0, %arg71, %arg72) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ne" %1, %arg71 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ne_smin1_after := [llvm|
{
^0(%arg71 : i32, %arg72 : i32):
  %0 = llvm.icmp "sgt" %arg71, %arg72 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_smin1_proof : ne_smin1_before ⊑ ne_smin1_after := by
  unfold ne_smin1_before ne_smin1_after
  simp_alive_peephole
  intros
  ---BEGIN ne_smin1
  all_goals (try extract_goal ; sorry)
  ---END ne_smin1



def ne_smin2_before := [llvm|
{
^0(%arg69 : i32, %arg70 : i32):
  %0 = llvm.icmp "slt" %arg70, %arg69 : i32
  %1 = "llvm.select"(%0, %arg70, %arg69) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ne" %1, %arg69 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ne_smin2_after := [llvm|
{
^0(%arg69 : i32, %arg70 : i32):
  %0 = llvm.icmp "sgt" %arg69, %arg70 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_smin2_proof : ne_smin2_before ⊑ ne_smin2_after := by
  unfold ne_smin2_before ne_smin2_after
  simp_alive_peephole
  intros
  ---BEGIN ne_smin2
  all_goals (try extract_goal ; sorry)
  ---END ne_smin2



def ne_smin3_before := [llvm|
{
^0(%arg67 : i32, %arg68 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg67, %0 : i32
  %2 = llvm.icmp "slt" %1, %arg68 : i32
  %3 = "llvm.select"(%2, %1, %arg68) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ne_smin3_after := [llvm|
{
^0(%arg67 : i32, %arg68 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg67, %0 : i32
  %2 = llvm.icmp "sgt" %1, %arg68 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_smin3_proof : ne_smin3_before ⊑ ne_smin3_after := by
  unfold ne_smin3_before ne_smin3_after
  simp_alive_peephole
  intros
  ---BEGIN ne_smin3
  all_goals (try extract_goal ; sorry)
  ---END ne_smin3



def ne_smin4_before := [llvm|
{
^0(%arg65 : i32, %arg66 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg65, %0 : i32
  %2 = llvm.icmp "slt" %arg66, %1 : i32
  %3 = "llvm.select"(%2, %arg66, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ne_smin4_after := [llvm|
{
^0(%arg65 : i32, %arg66 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg65, %0 : i32
  %2 = llvm.icmp "sgt" %1, %arg66 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_smin4_proof : ne_smin4_before ⊑ ne_smin4_after := by
  unfold ne_smin4_before ne_smin4_after
  simp_alive_peephole
  intros
  ---BEGIN ne_smin4
  all_goals (try extract_goal ; sorry)
  ---END ne_smin4



def slt_smin1_before := [llvm|
{
^0(%arg63 : i32, %arg64 : i32):
  %0 = llvm.icmp "slt" %arg63, %arg64 : i32
  %1 = "llvm.select"(%0, %arg63, %arg64) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "slt" %1, %arg63 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def slt_smin1_after := [llvm|
{
^0(%arg63 : i32, %arg64 : i32):
  %0 = llvm.icmp "slt" %arg64, %arg63 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_smin1_proof : slt_smin1_before ⊑ slt_smin1_after := by
  unfold slt_smin1_before slt_smin1_after
  simp_alive_peephole
  intros
  ---BEGIN slt_smin1
  all_goals (try extract_goal ; sorry)
  ---END slt_smin1



def slt_smin2_before := [llvm|
{
^0(%arg61 : i32, %arg62 : i32):
  %0 = llvm.icmp "slt" %arg62, %arg61 : i32
  %1 = "llvm.select"(%0, %arg62, %arg61) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "slt" %1, %arg61 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def slt_smin2_after := [llvm|
{
^0(%arg61 : i32, %arg62 : i32):
  %0 = llvm.icmp "slt" %arg62, %arg61 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_smin2_proof : slt_smin2_before ⊑ slt_smin2_after := by
  unfold slt_smin2_before slt_smin2_after
  simp_alive_peephole
  intros
  ---BEGIN slt_smin2
  all_goals (try extract_goal ; sorry)
  ---END slt_smin2



def slt_smin3_before := [llvm|
{
^0(%arg59 : i32, %arg60 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg59, %0 : i32
  %2 = llvm.icmp "slt" %1, %arg60 : i32
  %3 = "llvm.select"(%2, %1, %arg60) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "sgt" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_smin3_after := [llvm|
{
^0(%arg59 : i32, %arg60 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg59, %0 : i32
  %2 = llvm.icmp "slt" %arg60, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_smin3_proof : slt_smin3_before ⊑ slt_smin3_after := by
  unfold slt_smin3_before slt_smin3_after
  simp_alive_peephole
  intros
  ---BEGIN slt_smin3
  all_goals (try extract_goal ; sorry)
  ---END slt_smin3



def slt_smin4_before := [llvm|
{
^0(%arg57 : i32, %arg58 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg57, %0 : i32
  %2 = llvm.icmp "slt" %arg58, %1 : i32
  %3 = "llvm.select"(%2, %arg58, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "sgt" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_smin4_after := [llvm|
{
^0(%arg57 : i32, %arg58 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg57, %0 : i32
  %2 = llvm.icmp "slt" %arg58, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_smin4_proof : slt_smin4_before ⊑ slt_smin4_after := by
  unfold slt_smin4_before slt_smin4_after
  simp_alive_peephole
  intros
  ---BEGIN slt_smin4
  all_goals (try extract_goal ; sorry)
  ---END slt_smin4



def sle_smin1_before := [llvm|
{
^0(%arg55 : i32, %arg56 : i32):
  %0 = llvm.icmp "slt" %arg55, %arg56 : i32
  %1 = "llvm.select"(%0, %arg55, %arg56) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "sle" %1, %arg55 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sle_smin1_after := [llvm|
{
^0(%arg55 : i32, %arg56 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_smin1_proof : sle_smin1_before ⊑ sle_smin1_after := by
  unfold sle_smin1_before sle_smin1_after
  simp_alive_peephole
  intros
  ---BEGIN sle_smin1
  all_goals (try extract_goal ; sorry)
  ---END sle_smin1



def sle_smin2_before := [llvm|
{
^0(%arg53 : i32, %arg54 : i32):
  %0 = llvm.icmp "slt" %arg54, %arg53 : i32
  %1 = "llvm.select"(%0, %arg54, %arg53) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "sle" %1, %arg53 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sle_smin2_after := [llvm|
{
^0(%arg53 : i32, %arg54 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_smin2_proof : sle_smin2_before ⊑ sle_smin2_after := by
  unfold sle_smin2_before sle_smin2_after
  simp_alive_peephole
  intros
  ---BEGIN sle_smin2
  all_goals (try extract_goal ; sorry)
  ---END sle_smin2



def sle_smin3_before := [llvm|
{
^0(%arg51 : i32, %arg52 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg51, %0 : i32
  %2 = llvm.icmp "slt" %1, %arg52 : i32
  %3 = "llvm.select"(%2, %1, %arg52) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "sge" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_smin3_after := [llvm|
{
^0(%arg51 : i32, %arg52 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_smin3_proof : sle_smin3_before ⊑ sle_smin3_after := by
  unfold sle_smin3_before sle_smin3_after
  simp_alive_peephole
  intros
  ---BEGIN sle_smin3
  all_goals (try extract_goal ; sorry)
  ---END sle_smin3



def sle_smin4_before := [llvm|
{
^0(%arg49 : i32, %arg50 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg49, %0 : i32
  %2 = llvm.icmp "slt" %arg50, %1 : i32
  %3 = "llvm.select"(%2, %arg50, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "sge" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_smin4_after := [llvm|
{
^0(%arg49 : i32, %arg50 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_smin4_proof : sle_smin4_before ⊑ sle_smin4_after := by
  unfold sle_smin4_before sle_smin4_after
  simp_alive_peephole
  intros
  ---BEGIN sle_smin4
  all_goals (try extract_goal ; sorry)
  ---END sle_smin4



def sgt_smin1_before := [llvm|
{
^0(%arg47 : i32, %arg48 : i32):
  %0 = llvm.icmp "slt" %arg47, %arg48 : i32
  %1 = "llvm.select"(%0, %arg47, %arg48) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "sgt" %1, %arg47 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sgt_smin1_after := [llvm|
{
^0(%arg47 : i32, %arg48 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_smin1_proof : sgt_smin1_before ⊑ sgt_smin1_after := by
  unfold sgt_smin1_before sgt_smin1_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_smin1
  all_goals (try extract_goal ; sorry)
  ---END sgt_smin1



def sgt_smin2_before := [llvm|
{
^0(%arg45 : i32, %arg46 : i32):
  %0 = llvm.icmp "slt" %arg46, %arg45 : i32
  %1 = "llvm.select"(%0, %arg46, %arg45) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "sgt" %1, %arg45 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sgt_smin2_after := [llvm|
{
^0(%arg45 : i32, %arg46 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_smin2_proof : sgt_smin2_before ⊑ sgt_smin2_after := by
  unfold sgt_smin2_before sgt_smin2_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_smin2
  all_goals (try extract_goal ; sorry)
  ---END sgt_smin2



def sgt_smin3_before := [llvm|
{
^0(%arg43 : i32, %arg44 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg43, %0 : i32
  %2 = llvm.icmp "slt" %1, %arg44 : i32
  %3 = "llvm.select"(%2, %1, %arg44) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "slt" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_smin3_after := [llvm|
{
^0(%arg43 : i32, %arg44 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_smin3_proof : sgt_smin3_before ⊑ sgt_smin3_after := by
  unfold sgt_smin3_before sgt_smin3_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_smin3
  all_goals (try extract_goal ; sorry)
  ---END sgt_smin3



def sgt_smin4_before := [llvm|
{
^0(%arg41 : i32, %arg42 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg41, %0 : i32
  %2 = llvm.icmp "slt" %arg42, %1 : i32
  %3 = "llvm.select"(%2, %arg42, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "slt" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_smin4_after := [llvm|
{
^0(%arg41 : i32, %arg42 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_smin4_proof : sgt_smin4_before ⊑ sgt_smin4_after := by
  unfold sgt_smin4_before sgt_smin4_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_smin4
  all_goals (try extract_goal ; sorry)
  ---END sgt_smin4


