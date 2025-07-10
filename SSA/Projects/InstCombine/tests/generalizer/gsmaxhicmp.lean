import SSA.Projects.InstCombine.tests.proofs.gsmaxhicmp_proof
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
section gsmaxhicmp_statements

def eq_smax1_before := [llvm|
{
^0(%arg63 : i32, %arg64 : i32):
  %0 = llvm.icmp "sgt" %arg63, %arg64 : i32
  %1 = "llvm.select"(%0, %arg63, %arg64) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "eq" %1, %arg63 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def eq_smax1_after := [llvm|
{
^0(%arg63 : i32, %arg64 : i32):
  %0 = llvm.icmp "sge" %arg63, %arg64 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_smax1_proof : eq_smax1_before ⊑ eq_smax1_after := by
  unfold eq_smax1_before eq_smax1_after
  simp_alive_peephole
  intros
  ---BEGIN eq_smax1
  apply eq_smax1_thm
  ---END eq_smax1



def eq_smax2_before := [llvm|
{
^0(%arg61 : i32, %arg62 : i32):
  %0 = llvm.icmp "sgt" %arg62, %arg61 : i32
  %1 = "llvm.select"(%0, %arg62, %arg61) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "eq" %1, %arg61 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def eq_smax2_after := [llvm|
{
^0(%arg61 : i32, %arg62 : i32):
  %0 = llvm.icmp "sge" %arg61, %arg62 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_smax2_proof : eq_smax2_before ⊑ eq_smax2_after := by
  unfold eq_smax2_before eq_smax2_after
  simp_alive_peephole
  intros
  ---BEGIN eq_smax2
  apply eq_smax2_thm
  ---END eq_smax2



def eq_smax3_before := [llvm|
{
^0(%arg59 : i32, %arg60 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg59, %0 : i32
  %2 = llvm.icmp "sgt" %1, %arg60 : i32
  %3 = "llvm.select"(%2, %1, %arg60) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "eq" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def eq_smax3_after := [llvm|
{
^0(%arg59 : i32, %arg60 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg59, %0 : i32
  %2 = llvm.icmp "sge" %1, %arg60 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_smax3_proof : eq_smax3_before ⊑ eq_smax3_after := by
  unfold eq_smax3_before eq_smax3_after
  simp_alive_peephole
  intros
  ---BEGIN eq_smax3
  apply eq_smax3_thm
  ---END eq_smax3



def eq_smax4_before := [llvm|
{
^0(%arg57 : i32, %arg58 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg57, %0 : i32
  %2 = llvm.icmp "sgt" %arg58, %1 : i32
  %3 = "llvm.select"(%2, %arg58, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "eq" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def eq_smax4_after := [llvm|
{
^0(%arg57 : i32, %arg58 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg57, %0 : i32
  %2 = llvm.icmp "sge" %1, %arg58 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_smax4_proof : eq_smax4_before ⊑ eq_smax4_after := by
  unfold eq_smax4_before eq_smax4_after
  simp_alive_peephole
  intros
  ---BEGIN eq_smax4
  apply eq_smax4_thm
  ---END eq_smax4



def sle_smax1_before := [llvm|
{
^0(%arg55 : i32, %arg56 : i32):
  %0 = llvm.icmp "sgt" %arg55, %arg56 : i32
  %1 = "llvm.select"(%0, %arg55, %arg56) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "sle" %1, %arg55 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sle_smax1_after := [llvm|
{
^0(%arg55 : i32, %arg56 : i32):
  %0 = llvm.icmp "sle" %arg56, %arg55 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_smax1_proof : sle_smax1_before ⊑ sle_smax1_after := by
  unfold sle_smax1_before sle_smax1_after
  simp_alive_peephole
  intros
  ---BEGIN sle_smax1
  apply sle_smax1_thm
  ---END sle_smax1



def sle_smax2_before := [llvm|
{
^0(%arg53 : i32, %arg54 : i32):
  %0 = llvm.icmp "sgt" %arg54, %arg53 : i32
  %1 = "llvm.select"(%0, %arg54, %arg53) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "sle" %1, %arg53 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sle_smax2_after := [llvm|
{
^0(%arg53 : i32, %arg54 : i32):
  %0 = llvm.icmp "sle" %arg54, %arg53 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_smax2_proof : sle_smax2_before ⊑ sle_smax2_after := by
  unfold sle_smax2_before sle_smax2_after
  simp_alive_peephole
  intros
  ---BEGIN sle_smax2
  apply sle_smax2_thm
  ---END sle_smax2



def sle_smax3_before := [llvm|
{
^0(%arg51 : i32, %arg52 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg51, %0 : i32
  %2 = llvm.icmp "sgt" %1, %arg52 : i32
  %3 = "llvm.select"(%2, %1, %arg52) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "sge" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_smax3_after := [llvm|
{
^0(%arg51 : i32, %arg52 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg51, %0 : i32
  %2 = llvm.icmp "sle" %arg52, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_smax3_proof : sle_smax3_before ⊑ sle_smax3_after := by
  unfold sle_smax3_before sle_smax3_after
  simp_alive_peephole
  intros
  ---BEGIN sle_smax3
  apply sle_smax3_thm
  ---END sle_smax3



def sle_smax4_before := [llvm|
{
^0(%arg49 : i32, %arg50 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg49, %0 : i32
  %2 = llvm.icmp "sgt" %arg50, %1 : i32
  %3 = "llvm.select"(%2, %arg50, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "sge" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_smax4_after := [llvm|
{
^0(%arg49 : i32, %arg50 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg49, %0 : i32
  %2 = llvm.icmp "sle" %arg50, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_smax4_proof : sle_smax4_before ⊑ sle_smax4_after := by
  unfold sle_smax4_before sle_smax4_after
  simp_alive_peephole
  intros
  ---BEGIN sle_smax4
  apply sle_smax4_thm
  ---END sle_smax4



def ne_smax1_before := [llvm|
{
^0(%arg47 : i32, %arg48 : i32):
  %0 = llvm.icmp "sgt" %arg47, %arg48 : i32
  %1 = "llvm.select"(%0, %arg47, %arg48) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ne" %1, %arg47 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ne_smax1_after := [llvm|
{
^0(%arg47 : i32, %arg48 : i32):
  %0 = llvm.icmp "slt" %arg47, %arg48 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_smax1_proof : ne_smax1_before ⊑ ne_smax1_after := by
  unfold ne_smax1_before ne_smax1_after
  simp_alive_peephole
  intros
  ---BEGIN ne_smax1
  apply ne_smax1_thm
  ---END ne_smax1



def ne_smax2_before := [llvm|
{
^0(%arg45 : i32, %arg46 : i32):
  %0 = llvm.icmp "sgt" %arg46, %arg45 : i32
  %1 = "llvm.select"(%0, %arg46, %arg45) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ne" %1, %arg45 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ne_smax2_after := [llvm|
{
^0(%arg45 : i32, %arg46 : i32):
  %0 = llvm.icmp "slt" %arg45, %arg46 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_smax2_proof : ne_smax2_before ⊑ ne_smax2_after := by
  unfold ne_smax2_before ne_smax2_after
  simp_alive_peephole
  intros
  ---BEGIN ne_smax2
  apply ne_smax2_thm
  ---END ne_smax2



def ne_smax3_before := [llvm|
{
^0(%arg43 : i32, %arg44 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg43, %0 : i32
  %2 = llvm.icmp "sgt" %1, %arg44 : i32
  %3 = "llvm.select"(%2, %1, %arg44) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ne_smax3_after := [llvm|
{
^0(%arg43 : i32, %arg44 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg43, %0 : i32
  %2 = llvm.icmp "slt" %1, %arg44 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_smax3_proof : ne_smax3_before ⊑ ne_smax3_after := by
  unfold ne_smax3_before ne_smax3_after
  simp_alive_peephole
  intros
  ---BEGIN ne_smax3
  apply ne_smax3_thm
  ---END ne_smax3



def ne_smax4_before := [llvm|
{
^0(%arg41 : i32, %arg42 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg41, %0 : i32
  %2 = llvm.icmp "sgt" %arg42, %1 : i32
  %3 = "llvm.select"(%2, %arg42, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ne_smax4_after := [llvm|
{
^0(%arg41 : i32, %arg42 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg41, %0 : i32
  %2 = llvm.icmp "slt" %1, %arg42 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_smax4_proof : ne_smax4_before ⊑ ne_smax4_after := by
  unfold ne_smax4_before ne_smax4_after
  simp_alive_peephole
  intros
  ---BEGIN ne_smax4
  apply ne_smax4_thm
  ---END ne_smax4



def sgt_smax1_before := [llvm|
{
^0(%arg39 : i32, %arg40 : i32):
  %0 = llvm.icmp "sgt" %arg39, %arg40 : i32
  %1 = "llvm.select"(%0, %arg39, %arg40) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "sgt" %1, %arg39 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sgt_smax1_after := [llvm|
{
^0(%arg39 : i32, %arg40 : i32):
  %0 = llvm.icmp "sgt" %arg40, %arg39 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_smax1_proof : sgt_smax1_before ⊑ sgt_smax1_after := by
  unfold sgt_smax1_before sgt_smax1_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_smax1
  apply sgt_smax1_thm
  ---END sgt_smax1



def sgt_smax2_before := [llvm|
{
^0(%arg37 : i32, %arg38 : i32):
  %0 = llvm.icmp "sgt" %arg38, %arg37 : i32
  %1 = "llvm.select"(%0, %arg38, %arg37) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "sgt" %1, %arg37 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def sgt_smax2_after := [llvm|
{
^0(%arg37 : i32, %arg38 : i32):
  %0 = llvm.icmp "sgt" %arg38, %arg37 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_smax2_proof : sgt_smax2_before ⊑ sgt_smax2_after := by
  unfold sgt_smax2_before sgt_smax2_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_smax2
  apply sgt_smax2_thm
  ---END sgt_smax2



def sgt_smax3_before := [llvm|
{
^0(%arg35 : i32, %arg36 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg35, %0 : i32
  %2 = llvm.icmp "sgt" %1, %arg36 : i32
  %3 = "llvm.select"(%2, %1, %arg36) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "slt" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_smax3_after := [llvm|
{
^0(%arg35 : i32, %arg36 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg35, %0 : i32
  %2 = llvm.icmp "sgt" %arg36, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_smax3_proof : sgt_smax3_before ⊑ sgt_smax3_after := by
  unfold sgt_smax3_before sgt_smax3_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_smax3
  apply sgt_smax3_thm
  ---END sgt_smax3



def sgt_smax4_before := [llvm|
{
^0(%arg33 : i32, %arg34 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg33, %0 : i32
  %2 = llvm.icmp "sgt" %arg34, %1 : i32
  %3 = "llvm.select"(%2, %arg34, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "slt" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_smax4_after := [llvm|
{
^0(%arg33 : i32, %arg34 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg33, %0 : i32
  %2 = llvm.icmp "sgt" %arg34, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_smax4_proof : sgt_smax4_before ⊑ sgt_smax4_after := by
  unfold sgt_smax4_before sgt_smax4_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_smax4
  apply sgt_smax4_thm
  ---END sgt_smax4


