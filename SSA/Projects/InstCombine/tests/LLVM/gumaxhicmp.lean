
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
section gumaxhicmp_statements

def eq_umax1_before := [llvm|
{
^0(%arg60 : i32, %arg61 : i32):
  %0 = llvm.icmp "ugt" %arg60, %arg61 : i32
  %1 = "llvm.select"(%0, %arg60, %arg61) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "eq" %1, %arg60 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def eq_umax1_after := [llvm|
{
^0(%arg60 : i32, %arg61 : i32):
  %0 = llvm.icmp "uge" %arg60, %arg61 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_umax1_proof : eq_umax1_before ⊑ eq_umax1_after := by
  unfold eq_umax1_before eq_umax1_after
  simp_alive_peephole
  intros
  ---BEGIN eq_umax1
  all_goals (try extract_goal ; sorry)
  ---END eq_umax1



def eq_umax2_before := [llvm|
{
^0(%arg58 : i32, %arg59 : i32):
  %0 = llvm.icmp "ugt" %arg59, %arg58 : i32
  %1 = "llvm.select"(%0, %arg59, %arg58) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "eq" %1, %arg58 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def eq_umax2_after := [llvm|
{
^0(%arg58 : i32, %arg59 : i32):
  %0 = llvm.icmp "uge" %arg58, %arg59 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_umax2_proof : eq_umax2_before ⊑ eq_umax2_after := by
  unfold eq_umax2_before eq_umax2_after
  simp_alive_peephole
  intros
  ---BEGIN eq_umax2
  all_goals (try extract_goal ; sorry)
  ---END eq_umax2



def eq_umax3_before := [llvm|
{
^0(%arg56 : i32, %arg57 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg56, %0 : i32
  %2 = llvm.icmp "ugt" %1, %arg57 : i32
  %3 = "llvm.select"(%2, %1, %arg57) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "eq" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def eq_umax3_after := [llvm|
{
^0(%arg56 : i32, %arg57 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg56, %0 : i32
  %2 = llvm.icmp "uge" %1, %arg57 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_umax3_proof : eq_umax3_before ⊑ eq_umax3_after := by
  unfold eq_umax3_before eq_umax3_after
  simp_alive_peephole
  intros
  ---BEGIN eq_umax3
  all_goals (try extract_goal ; sorry)
  ---END eq_umax3



def eq_umax4_before := [llvm|
{
^0(%arg54 : i32, %arg55 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg54, %0 : i32
  %2 = llvm.icmp "ugt" %arg55, %1 : i32
  %3 = "llvm.select"(%2, %arg55, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "eq" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def eq_umax4_after := [llvm|
{
^0(%arg54 : i32, %arg55 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg54, %0 : i32
  %2 = llvm.icmp "uge" %1, %arg55 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_umax4_proof : eq_umax4_before ⊑ eq_umax4_after := by
  unfold eq_umax4_before eq_umax4_after
  simp_alive_peephole
  intros
  ---BEGIN eq_umax4
  all_goals (try extract_goal ; sorry)
  ---END eq_umax4



def ule_umax1_before := [llvm|
{
^0(%arg52 : i32, %arg53 : i32):
  %0 = llvm.icmp "ugt" %arg52, %arg53 : i32
  %1 = "llvm.select"(%0, %arg52, %arg53) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ule" %1, %arg52 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ule_umax1_after := [llvm|
{
^0(%arg52 : i32, %arg53 : i32):
  %0 = llvm.icmp "ule" %arg53, %arg52 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_umax1_proof : ule_umax1_before ⊑ ule_umax1_after := by
  unfold ule_umax1_before ule_umax1_after
  simp_alive_peephole
  intros
  ---BEGIN ule_umax1
  all_goals (try extract_goal ; sorry)
  ---END ule_umax1



def ule_umax2_before := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.icmp "ugt" %arg51, %arg50 : i32
  %1 = "llvm.select"(%0, %arg51, %arg50) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ule" %1, %arg50 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ule_umax2_after := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.icmp "ule" %arg51, %arg50 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_umax2_proof : ule_umax2_before ⊑ ule_umax2_after := by
  unfold ule_umax2_before ule_umax2_after
  simp_alive_peephole
  intros
  ---BEGIN ule_umax2
  all_goals (try extract_goal ; sorry)
  ---END ule_umax2



def ule_umax3_before := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg48, %0 : i32
  %2 = llvm.icmp "ugt" %1, %arg49 : i32
  %3 = "llvm.select"(%2, %1, %arg49) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "uge" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ule_umax3_after := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg48, %0 : i32
  %2 = llvm.icmp "ule" %arg49, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_umax3_proof : ule_umax3_before ⊑ ule_umax3_after := by
  unfold ule_umax3_before ule_umax3_after
  simp_alive_peephole
  intros
  ---BEGIN ule_umax3
  all_goals (try extract_goal ; sorry)
  ---END ule_umax3



def ule_umax4_before := [llvm|
{
^0(%arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg46, %0 : i32
  %2 = llvm.icmp "ugt" %arg47, %1 : i32
  %3 = "llvm.select"(%2, %arg47, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "uge" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ule_umax4_after := [llvm|
{
^0(%arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg46, %0 : i32
  %2 = llvm.icmp "ule" %arg47, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_umax4_proof : ule_umax4_before ⊑ ule_umax4_after := by
  unfold ule_umax4_before ule_umax4_after
  simp_alive_peephole
  intros
  ---BEGIN ule_umax4
  all_goals (try extract_goal ; sorry)
  ---END ule_umax4



def ne_umax1_before := [llvm|
{
^0(%arg44 : i32, %arg45 : i32):
  %0 = llvm.icmp "ugt" %arg44, %arg45 : i32
  %1 = "llvm.select"(%0, %arg44, %arg45) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ne" %1, %arg44 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ne_umax1_after := [llvm|
{
^0(%arg44 : i32, %arg45 : i32):
  %0 = llvm.icmp "ult" %arg44, %arg45 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_umax1_proof : ne_umax1_before ⊑ ne_umax1_after := by
  unfold ne_umax1_before ne_umax1_after
  simp_alive_peephole
  intros
  ---BEGIN ne_umax1
  all_goals (try extract_goal ; sorry)
  ---END ne_umax1



def ne_umax2_before := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.icmp "ugt" %arg43, %arg42 : i32
  %1 = "llvm.select"(%0, %arg43, %arg42) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ne" %1, %arg42 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ne_umax2_after := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.icmp "ult" %arg42, %arg43 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_umax2_proof : ne_umax2_before ⊑ ne_umax2_after := by
  unfold ne_umax2_before ne_umax2_after
  simp_alive_peephole
  intros
  ---BEGIN ne_umax2
  all_goals (try extract_goal ; sorry)
  ---END ne_umax2



def ne_umax3_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg40, %0 : i32
  %2 = llvm.icmp "ugt" %1, %arg41 : i32
  %3 = "llvm.select"(%2, %1, %arg41) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ne_umax3_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg40, %0 : i32
  %2 = llvm.icmp "ult" %1, %arg41 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_umax3_proof : ne_umax3_before ⊑ ne_umax3_after := by
  unfold ne_umax3_before ne_umax3_after
  simp_alive_peephole
  intros
  ---BEGIN ne_umax3
  all_goals (try extract_goal ; sorry)
  ---END ne_umax3



def ne_umax4_before := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg38, %0 : i32
  %2 = llvm.icmp "ugt" %arg39, %1 : i32
  %3 = "llvm.select"(%2, %arg39, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ne_umax4_after := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg38, %0 : i32
  %2 = llvm.icmp "ult" %1, %arg39 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_umax4_proof : ne_umax4_before ⊑ ne_umax4_after := by
  unfold ne_umax4_before ne_umax4_after
  simp_alive_peephole
  intros
  ---BEGIN ne_umax4
  all_goals (try extract_goal ; sorry)
  ---END ne_umax4



def ugt_umax1_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.icmp "ugt" %arg36, %arg37 : i32
  %1 = "llvm.select"(%0, %arg36, %arg37) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ugt" %1, %arg36 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ugt_umax1_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.icmp "ugt" %arg37, %arg36 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_umax1_proof : ugt_umax1_before ⊑ ugt_umax1_after := by
  unfold ugt_umax1_before ugt_umax1_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_umax1
  all_goals (try extract_goal ; sorry)
  ---END ugt_umax1



def ugt_umax2_before := [llvm|
{
^0(%arg34 : i32, %arg35 : i32):
  %0 = llvm.icmp "ugt" %arg35, %arg34 : i32
  %1 = "llvm.select"(%0, %arg35, %arg34) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ugt" %1, %arg34 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ugt_umax2_after := [llvm|
{
^0(%arg34 : i32, %arg35 : i32):
  %0 = llvm.icmp "ugt" %arg35, %arg34 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_umax2_proof : ugt_umax2_before ⊑ ugt_umax2_after := by
  unfold ugt_umax2_before ugt_umax2_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_umax2
  all_goals (try extract_goal ; sorry)
  ---END ugt_umax2



def ugt_umax3_before := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg32, %0 : i32
  %2 = llvm.icmp "ugt" %1, %arg33 : i32
  %3 = "llvm.select"(%2, %1, %arg33) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ult" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ugt_umax3_after := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg32, %0 : i32
  %2 = llvm.icmp "ugt" %arg33, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_umax3_proof : ugt_umax3_before ⊑ ugt_umax3_after := by
  unfold ugt_umax3_before ugt_umax3_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_umax3
  all_goals (try extract_goal ; sorry)
  ---END ugt_umax3



def ugt_umax4_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg30, %0 : i32
  %2 = llvm.icmp "ugt" %arg31, %1 : i32
  %3 = "llvm.select"(%2, %arg31, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ult" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ugt_umax4_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg30, %0 : i32
  %2 = llvm.icmp "ugt" %arg31, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_umax4_proof : ugt_umax4_before ⊑ ugt_umax4_after := by
  unfold ugt_umax4_before ugt_umax4_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_umax4
  all_goals (try extract_goal ; sorry)
  ---END ugt_umax4


