import SSA.Projects.InstCombine.tests.proofs.guminhicmp_proof
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
section guminhicmp_statements

def eq_umin1_before := [llvm|
{
^0(%arg60 : i32, %arg61 : i32):
  %0 = llvm.icmp "ult" %arg60, %arg61 : i32
  %1 = "llvm.select"(%0, %arg60, %arg61) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "eq" %1, %arg60 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def eq_umin1_after := [llvm|
{
^0(%arg60 : i32, %arg61 : i32):
  %0 = llvm.icmp "ule" %arg60, %arg61 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_umin1_proof : eq_umin1_before ⊑ eq_umin1_after := by
  unfold eq_umin1_before eq_umin1_after
  simp_alive_peephole
  intros
  ---BEGIN eq_umin1
  apply eq_umin1_thm
  ---END eq_umin1



def eq_umin2_before := [llvm|
{
^0(%arg58 : i32, %arg59 : i32):
  %0 = llvm.icmp "ult" %arg59, %arg58 : i32
  %1 = "llvm.select"(%0, %arg59, %arg58) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "eq" %1, %arg58 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def eq_umin2_after := [llvm|
{
^0(%arg58 : i32, %arg59 : i32):
  %0 = llvm.icmp "ule" %arg58, %arg59 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_umin2_proof : eq_umin2_before ⊑ eq_umin2_after := by
  unfold eq_umin2_before eq_umin2_after
  simp_alive_peephole
  intros
  ---BEGIN eq_umin2
  apply eq_umin2_thm
  ---END eq_umin2



def eq_umin3_before := [llvm|
{
^0(%arg56 : i32, %arg57 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg56, %0 : i32
  %2 = llvm.icmp "ult" %1, %arg57 : i32
  %3 = "llvm.select"(%2, %1, %arg57) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "eq" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def eq_umin3_after := [llvm|
{
^0(%arg56 : i32, %arg57 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg56, %0 : i32
  %2 = llvm.icmp "ule" %1, %arg57 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_umin3_proof : eq_umin3_before ⊑ eq_umin3_after := by
  unfold eq_umin3_before eq_umin3_after
  simp_alive_peephole
  intros
  ---BEGIN eq_umin3
  apply eq_umin3_thm
  ---END eq_umin3



def eq_umin4_before := [llvm|
{
^0(%arg54 : i32, %arg55 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg54, %0 : i32
  %2 = llvm.icmp "ult" %arg55, %1 : i32
  %3 = "llvm.select"(%2, %arg55, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "eq" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def eq_umin4_after := [llvm|
{
^0(%arg54 : i32, %arg55 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg54, %0 : i32
  %2 = llvm.icmp "ule" %1, %arg55 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_umin4_proof : eq_umin4_before ⊑ eq_umin4_after := by
  unfold eq_umin4_before eq_umin4_after
  simp_alive_peephole
  intros
  ---BEGIN eq_umin4
  apply eq_umin4_thm
  ---END eq_umin4



def uge_umin1_before := [llvm|
{
^0(%arg52 : i32, %arg53 : i32):
  %0 = llvm.icmp "ult" %arg52, %arg53 : i32
  %1 = "llvm.select"(%0, %arg52, %arg53) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "uge" %1, %arg52 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def uge_umin1_after := [llvm|
{
^0(%arg52 : i32, %arg53 : i32):
  %0 = llvm.icmp "uge" %arg53, %arg52 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_umin1_proof : uge_umin1_before ⊑ uge_umin1_after := by
  unfold uge_umin1_before uge_umin1_after
  simp_alive_peephole
  intros
  ---BEGIN uge_umin1
  apply uge_umin1_thm
  ---END uge_umin1



def uge_umin2_before := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.icmp "ult" %arg51, %arg50 : i32
  %1 = "llvm.select"(%0, %arg51, %arg50) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "uge" %1, %arg50 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def uge_umin2_after := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.icmp "uge" %arg51, %arg50 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_umin2_proof : uge_umin2_before ⊑ uge_umin2_after := by
  unfold uge_umin2_before uge_umin2_after
  simp_alive_peephole
  intros
  ---BEGIN uge_umin2
  apply uge_umin2_thm
  ---END uge_umin2



def uge_umin3_before := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg48, %0 : i32
  %2 = llvm.icmp "ult" %1, %arg49 : i32
  %3 = "llvm.select"(%2, %1, %arg49) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ule" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def uge_umin3_after := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg48, %0 : i32
  %2 = llvm.icmp "uge" %arg49, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_umin3_proof : uge_umin3_before ⊑ uge_umin3_after := by
  unfold uge_umin3_before uge_umin3_after
  simp_alive_peephole
  intros
  ---BEGIN uge_umin3
  apply uge_umin3_thm
  ---END uge_umin3



def uge_umin4_before := [llvm|
{
^0(%arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg46, %0 : i32
  %2 = llvm.icmp "ult" %arg47, %1 : i32
  %3 = "llvm.select"(%2, %arg47, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ule" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def uge_umin4_after := [llvm|
{
^0(%arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg46, %0 : i32
  %2 = llvm.icmp "uge" %arg47, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_umin4_proof : uge_umin4_before ⊑ uge_umin4_after := by
  unfold uge_umin4_before uge_umin4_after
  simp_alive_peephole
  intros
  ---BEGIN uge_umin4
  apply uge_umin4_thm
  ---END uge_umin4



def ne_umin1_before := [llvm|
{
^0(%arg44 : i32, %arg45 : i32):
  %0 = llvm.icmp "ult" %arg44, %arg45 : i32
  %1 = "llvm.select"(%0, %arg44, %arg45) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ne" %1, %arg44 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ne_umin1_after := [llvm|
{
^0(%arg44 : i32, %arg45 : i32):
  %0 = llvm.icmp "ugt" %arg44, %arg45 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_umin1_proof : ne_umin1_before ⊑ ne_umin1_after := by
  unfold ne_umin1_before ne_umin1_after
  simp_alive_peephole
  intros
  ---BEGIN ne_umin1
  apply ne_umin1_thm
  ---END ne_umin1



def ne_umin2_before := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.icmp "ult" %arg43, %arg42 : i32
  %1 = "llvm.select"(%0, %arg43, %arg42) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ne" %1, %arg42 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ne_umin2_after := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.icmp "ugt" %arg42, %arg43 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_umin2_proof : ne_umin2_before ⊑ ne_umin2_after := by
  unfold ne_umin2_before ne_umin2_after
  simp_alive_peephole
  intros
  ---BEGIN ne_umin2
  apply ne_umin2_thm
  ---END ne_umin2



def ne_umin3_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg40, %0 : i32
  %2 = llvm.icmp "ult" %1, %arg41 : i32
  %3 = "llvm.select"(%2, %1, %arg41) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ne_umin3_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg40, %0 : i32
  %2 = llvm.icmp "ugt" %1, %arg41 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_umin3_proof : ne_umin3_before ⊑ ne_umin3_after := by
  unfold ne_umin3_before ne_umin3_after
  simp_alive_peephole
  intros
  ---BEGIN ne_umin3
  apply ne_umin3_thm
  ---END ne_umin3



def ne_umin4_before := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg38, %0 : i32
  %2 = llvm.icmp "ult" %arg39, %1 : i32
  %3 = "llvm.select"(%2, %arg39, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ne_umin4_after := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg38, %0 : i32
  %2 = llvm.icmp "ugt" %1, %arg39 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_umin4_proof : ne_umin4_before ⊑ ne_umin4_after := by
  unfold ne_umin4_before ne_umin4_after
  simp_alive_peephole
  intros
  ---BEGIN ne_umin4
  apply ne_umin4_thm
  ---END ne_umin4



def ult_umin1_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.icmp "ult" %arg36, %arg37 : i32
  %1 = "llvm.select"(%0, %arg36, %arg37) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ult" %1, %arg36 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ult_umin1_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.icmp "ult" %arg37, %arg36 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_umin1_proof : ult_umin1_before ⊑ ult_umin1_after := by
  unfold ult_umin1_before ult_umin1_after
  simp_alive_peephole
  intros
  ---BEGIN ult_umin1
  apply ult_umin1_thm
  ---END ult_umin1



def ult_umin2_before := [llvm|
{
^0(%arg34 : i32, %arg35 : i32):
  %0 = llvm.icmp "ult" %arg35, %arg34 : i32
  %1 = "llvm.select"(%0, %arg35, %arg34) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "ult" %1, %arg34 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def ult_umin2_after := [llvm|
{
^0(%arg34 : i32, %arg35 : i32):
  %0 = llvm.icmp "ult" %arg35, %arg34 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_umin2_proof : ult_umin2_before ⊑ ult_umin2_after := by
  unfold ult_umin2_before ult_umin2_after
  simp_alive_peephole
  intros
  ---BEGIN ult_umin2
  apply ult_umin2_thm
  ---END ult_umin2



def ult_umin3_before := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg32, %0 : i32
  %2 = llvm.icmp "ult" %1, %arg33 : i32
  %3 = "llvm.select"(%2, %1, %arg33) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ugt" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ult_umin3_after := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg32, %0 : i32
  %2 = llvm.icmp "ult" %arg33, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_umin3_proof : ult_umin3_before ⊑ ult_umin3_after := by
  unfold ult_umin3_before ult_umin3_after
  simp_alive_peephole
  intros
  ---BEGIN ult_umin3
  apply ult_umin3_thm
  ---END ult_umin3



def ult_umin4_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg30, %0 : i32
  %2 = llvm.icmp "ult" %arg31, %1 : i32
  %3 = "llvm.select"(%2, %arg31, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "ugt" %1, %3 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def ult_umin4_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.add %arg30, %0 : i32
  %2 = llvm.icmp "ult" %arg31, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_umin4_proof : ult_umin4_before ⊑ ult_umin4_after := by
  unfold ult_umin4_before ult_umin4_after
  simp_alive_peephole
  intros
  ---BEGIN ult_umin4
  apply ult_umin4_thm
  ---END ult_umin4


