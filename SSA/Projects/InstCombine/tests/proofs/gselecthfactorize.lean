import SSA.Projects.InstCombine.tests.proofs.gselecthfactorize_proof
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
section gselecthfactorize_statements

def logic_and_logic_or_1_before := [llvm|
{
^0(%arg177 : i1, %arg178 : i1, %arg179 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg177, %arg178, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg177, %arg179, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_and_logic_or_1_after := [llvm|
{
^0(%arg177 : i1, %arg178 : i1, %arg179 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg178, %0, %arg179) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg177, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_and_logic_or_1_proof : logic_and_logic_or_1_before ⊑ logic_and_logic_or_1_after := by
  unfold logic_and_logic_or_1_before logic_and_logic_or_1_after
  simp_alive_peephole
  intros
  ---BEGIN logic_and_logic_or_1
  apply logic_and_logic_or_1_thm
  ---END logic_and_logic_or_1



def logic_and_logic_or_2_before := [llvm|
{
^0(%arg174 : i1, %arg175 : i1, %arg176 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg175, %arg174, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg174, %arg176, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_and_logic_or_2_after := [llvm|
{
^0(%arg174 : i1, %arg175 : i1, %arg176 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg175, %0, %arg176) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg174, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_and_logic_or_2_proof : logic_and_logic_or_2_before ⊑ logic_and_logic_or_2_after := by
  unfold logic_and_logic_or_2_before logic_and_logic_or_2_after
  simp_alive_peephole
  intros
  ---BEGIN logic_and_logic_or_2
  apply logic_and_logic_or_2_thm
  ---END logic_and_logic_or_2



def logic_and_logic_or_3_before := [llvm|
{
^0(%arg171 : i1, %arg172 : i1, %arg173 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg172, %arg171, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg173, %arg171, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_and_logic_or_3_after := [llvm|
{
^0(%arg171 : i1, %arg172 : i1, %arg173 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg172, %0, %arg173) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%2, %arg171, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_and_logic_or_3_proof : logic_and_logic_or_3_before ⊑ logic_and_logic_or_3_after := by
  unfold logic_and_logic_or_3_before logic_and_logic_or_3_after
  simp_alive_peephole
  intros
  ---BEGIN logic_and_logic_or_3
  apply logic_and_logic_or_3_thm
  ---END logic_and_logic_or_3



def logic_and_logic_or_4_before := [llvm|
{
^0(%arg168 : i1, %arg169 : i1, %arg170 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg168, %arg169, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg170, %arg168, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_and_logic_or_4_after := [llvm|
{
^0(%arg168 : i1, %arg169 : i1, %arg170 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg169, %0, %arg170) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg168, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_and_logic_or_4_proof : logic_and_logic_or_4_before ⊑ logic_and_logic_or_4_after := by
  unfold logic_and_logic_or_4_before logic_and_logic_or_4_after
  simp_alive_peephole
  intros
  ---BEGIN logic_and_logic_or_4
  apply logic_and_logic_or_4_thm
  ---END logic_and_logic_or_4



def logic_and_logic_or_5_before := [llvm|
{
^0(%arg165 : i1, %arg166 : i1, %arg167 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg165, %arg166, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg165, %arg167, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_and_logic_or_5_after := [llvm|
{
^0(%arg165 : i1, %arg166 : i1, %arg167 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg167, %0, %arg166) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg165, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_and_logic_or_5_proof : logic_and_logic_or_5_before ⊑ logic_and_logic_or_5_after := by
  unfold logic_and_logic_or_5_before logic_and_logic_or_5_after
  simp_alive_peephole
  intros
  ---BEGIN logic_and_logic_or_5
  apply logic_and_logic_or_5_thm
  ---END logic_and_logic_or_5



def logic_and_logic_or_6_before := [llvm|
{
^0(%arg162 : i1, %arg163 : i1, %arg164 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg163, %arg162, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg162, %arg164, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_and_logic_or_6_after := [llvm|
{
^0(%arg162 : i1, %arg163 : i1, %arg164 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg164, %0, %arg163) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg162, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_and_logic_or_6_proof : logic_and_logic_or_6_before ⊑ logic_and_logic_or_6_after := by
  unfold logic_and_logic_or_6_before logic_and_logic_or_6_after
  simp_alive_peephole
  intros
  ---BEGIN logic_and_logic_or_6
  apply logic_and_logic_or_6_thm
  ---END logic_and_logic_or_6



def logic_and_logic_or_7_before := [llvm|
{
^0(%arg159 : i1, %arg160 : i1, %arg161 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg160, %arg159, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg161, %arg159, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_and_logic_or_7_after := [llvm|
{
^0(%arg159 : i1, %arg160 : i1, %arg161 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg161, %0, %arg160) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%2, %arg159, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_and_logic_or_7_proof : logic_and_logic_or_7_before ⊑ logic_and_logic_or_7_after := by
  unfold logic_and_logic_or_7_before logic_and_logic_or_7_after
  simp_alive_peephole
  intros
  ---BEGIN logic_and_logic_or_7
  apply logic_and_logic_or_7_thm
  ---END logic_and_logic_or_7



def logic_and_logic_or_8_before := [llvm|
{
^0(%arg156 : i1, %arg157 : i1, %arg158 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg156, %arg157, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg158, %arg156, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_and_logic_or_8_after := [llvm|
{
^0(%arg156 : i1, %arg157 : i1, %arg158 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg158, %0, %arg157) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg156, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_and_logic_or_8_proof : logic_and_logic_or_8_before ⊑ logic_and_logic_or_8_after := by
  unfold logic_and_logic_or_8_before logic_and_logic_or_8_after
  simp_alive_peephole
  intros
  ---BEGIN logic_and_logic_or_8
  apply logic_and_logic_or_8_thm
  ---END logic_and_logic_or_8



def and_logic_and_logic_or_1_before := [llvm|
{
^0(%arg138 : i1, %arg139 : i1, %arg140 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.and %arg138, %arg139 : i1
  %3 = "llvm.select"(%arg138, %arg140, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_logic_and_logic_or_1_after := [llvm|
{
^0(%arg138 : i1, %arg139 : i1, %arg140 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg139, %0, %arg140) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg138, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_logic_and_logic_or_1_proof : and_logic_and_logic_or_1_before ⊑ and_logic_and_logic_or_1_after := by
  unfold and_logic_and_logic_or_1_before and_logic_and_logic_or_1_after
  simp_alive_peephole
  intros
  ---BEGIN and_logic_and_logic_or_1
  apply and_logic_and_logic_or_1_thm
  ---END and_logic_and_logic_or_1



def and_logic_and_logic_or_2_before := [llvm|
{
^0(%arg135 : i1, %arg136 : i1, %arg137 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.and %arg135, %arg136 : i1
  %3 = "llvm.select"(%arg137, %arg135, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_logic_and_logic_or_2_after := [llvm|
{
^0(%arg135 : i1, %arg136 : i1, %arg137 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg136, %0, %arg137) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg135, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_logic_and_logic_or_2_proof : and_logic_and_logic_or_2_before ⊑ and_logic_and_logic_or_2_after := by
  unfold and_logic_and_logic_or_2_before and_logic_and_logic_or_2_after
  simp_alive_peephole
  intros
  ---BEGIN and_logic_and_logic_or_2
  apply and_logic_and_logic_or_2_thm
  ---END and_logic_and_logic_or_2



def and_logic_and_logic_or_3_before := [llvm|
{
^0(%arg132 : i1, %arg133 : i1, %arg134 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.and %arg133, %arg132 : i1
  %3 = "llvm.select"(%arg132, %arg134, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_logic_and_logic_or_3_after := [llvm|
{
^0(%arg132 : i1, %arg133 : i1, %arg134 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg133, %0, %arg134) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg132, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_logic_and_logic_or_3_proof : and_logic_and_logic_or_3_before ⊑ and_logic_and_logic_or_3_after := by
  unfold and_logic_and_logic_or_3_before and_logic_and_logic_or_3_after
  simp_alive_peephole
  intros
  ---BEGIN and_logic_and_logic_or_3
  apply and_logic_and_logic_or_3_thm
  ---END and_logic_and_logic_or_3



def and_logic_and_logic_or_4_before := [llvm|
{
^0(%arg129 : i1, %arg130 : i1, %arg131 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.and %arg130, %arg129 : i1
  %3 = "llvm.select"(%arg131, %arg129, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_logic_and_logic_or_4_after := [llvm|
{
^0(%arg129 : i1, %arg130 : i1, %arg131 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg130, %0, %arg131) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg129, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_logic_and_logic_or_4_proof : and_logic_and_logic_or_4_before ⊑ and_logic_and_logic_or_4_after := by
  unfold and_logic_and_logic_or_4_before and_logic_and_logic_or_4_after
  simp_alive_peephole
  intros
  ---BEGIN and_logic_and_logic_or_4
  apply and_logic_and_logic_or_4_thm
  ---END and_logic_and_logic_or_4



def and_logic_and_logic_or_5_before := [llvm|
{
^0(%arg126 : i1, %arg127 : i1, %arg128 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.and %arg126, %arg127 : i1
  %3 = "llvm.select"(%arg126, %arg128, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_logic_and_logic_or_5_after := [llvm|
{
^0(%arg126 : i1, %arg127 : i1, %arg128 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg128, %0, %arg127) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg126, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_logic_and_logic_or_5_proof : and_logic_and_logic_or_5_before ⊑ and_logic_and_logic_or_5_after := by
  unfold and_logic_and_logic_or_5_before and_logic_and_logic_or_5_after
  simp_alive_peephole
  intros
  ---BEGIN and_logic_and_logic_or_5
  apply and_logic_and_logic_or_5_thm
  ---END and_logic_and_logic_or_5



def and_logic_and_logic_or_6_before := [llvm|
{
^0(%arg123 : i1, %arg124 : i1, %arg125 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.and %arg123, %arg124 : i1
  %3 = "llvm.select"(%arg125, %arg123, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_logic_and_logic_or_6_after := [llvm|
{
^0(%arg123 : i1, %arg124 : i1, %arg125 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg125, %0, %arg124) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %arg123, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_logic_and_logic_or_6_proof : and_logic_and_logic_or_6_before ⊑ and_logic_and_logic_or_6_after := by
  unfold and_logic_and_logic_or_6_before and_logic_and_logic_or_6_after
  simp_alive_peephole
  intros
  ---BEGIN and_logic_and_logic_or_6
  apply and_logic_and_logic_or_6_thm
  ---END and_logic_and_logic_or_6



def and_logic_and_logic_or_7_before := [llvm|
{
^0(%arg120 : i1, %arg121 : i1, %arg122 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.and %arg121, %arg120 : i1
  %3 = "llvm.select"(%arg120, %arg122, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_logic_and_logic_or_7_after := [llvm|
{
^0(%arg120 : i1, %arg121 : i1, %arg122 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg122, %0, %arg121) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg120, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_logic_and_logic_or_7_proof : and_logic_and_logic_or_7_before ⊑ and_logic_and_logic_or_7_after := by
  unfold and_logic_and_logic_or_7_before and_logic_and_logic_or_7_after
  simp_alive_peephole
  intros
  ---BEGIN and_logic_and_logic_or_7
  apply and_logic_and_logic_or_7_thm
  ---END and_logic_and_logic_or_7



def and_logic_and_logic_or_8_before := [llvm|
{
^0(%arg117 : i1, %arg118 : i1, %arg119 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.and %arg118, %arg117 : i1
  %3 = "llvm.select"(%arg119, %arg117, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_logic_and_logic_or_8_after := [llvm|
{
^0(%arg117 : i1, %arg118 : i1, %arg119 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg119, %0, %arg118) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %arg117, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_logic_and_logic_or_8_proof : and_logic_and_logic_or_8_before ⊑ and_logic_and_logic_or_8_after := by
  unfold and_logic_and_logic_or_8_before and_logic_and_logic_or_8_after
  simp_alive_peephole
  intros
  ---BEGIN and_logic_and_logic_or_8
  apply and_logic_and_logic_or_8_thm
  ---END and_logic_and_logic_or_8



def and_and_logic_or_1_before := [llvm|
{
^0(%arg102 : i1, %arg103 : i1, %arg104 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg102, %arg103 : i1
  %2 = llvm.and %arg102, %arg104 : i1
  %3 = "llvm.select"(%1, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def and_and_logic_or_1_after := [llvm|
{
^0(%arg102 : i1, %arg103 : i1, %arg104 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg103, %0, %arg104) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %arg102, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_and_logic_or_1_proof : and_and_logic_or_1_before ⊑ and_and_logic_or_1_after := by
  unfold and_and_logic_or_1_before and_and_logic_or_1_after
  simp_alive_peephole
  intros
  ---BEGIN and_and_logic_or_1
  apply and_and_logic_or_1_thm
  ---END and_and_logic_or_1



def and_and_logic_or_2_before := [llvm|
{
^0(%arg99 : i1, %arg100 : i1, %arg101 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg100, %arg99 : i1
  %2 = llvm.and %arg99, %arg101 : i1
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def and_and_logic_or_2_after := [llvm|
{
^0(%arg99 : i1, %arg100 : i1, %arg101 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg101, %0, %arg100) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %arg99, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_and_logic_or_2_proof : and_and_logic_or_2_before ⊑ and_and_logic_or_2_after := by
  unfold and_and_logic_or_2_before and_and_logic_or_2_after
  simp_alive_peephole
  intros
  ---BEGIN and_and_logic_or_2
  apply and_and_logic_or_2_thm
  ---END and_and_logic_or_2



def logic_or_logic_and_1_before := [llvm|
{
^0(%arg87 : i1, %arg88 : i1, %arg89 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg87, %0, %arg88) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg87, %0, %arg89) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_or_logic_and_1_after := [llvm|
{
^0(%arg87 : i1, %arg88 : i1, %arg89 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg88, %arg89, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg87, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_or_logic_and_1_proof : logic_or_logic_and_1_before ⊑ logic_or_logic_and_1_after := by
  unfold logic_or_logic_and_1_before logic_or_logic_and_1_after
  simp_alive_peephole
  intros
  ---BEGIN logic_or_logic_and_1
  apply logic_or_logic_and_1_thm
  ---END logic_or_logic_and_1



def logic_or_logic_and_2_before := [llvm|
{
^0(%arg84 : i1, %arg85 : i1, %arg86 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg85, %0, %arg84) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg84, %0, %arg86) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_or_logic_and_2_after := [llvm|
{
^0(%arg84 : i1, %arg85 : i1, %arg86 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg85, %arg86, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg84, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_or_logic_and_2_proof : logic_or_logic_and_2_before ⊑ logic_or_logic_and_2_after := by
  unfold logic_or_logic_and_2_before logic_or_logic_and_2_after
  simp_alive_peephole
  intros
  ---BEGIN logic_or_logic_and_2
  apply logic_or_logic_and_2_thm
  ---END logic_or_logic_and_2



def logic_or_logic_and_3_before := [llvm|
{
^0(%arg81 : i1, %arg82 : i1, %arg83 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg82, %0, %arg81) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg83, %0, %arg81) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_or_logic_and_3_after := [llvm|
{
^0(%arg81 : i1, %arg82 : i1, %arg83 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg82, %arg83, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%2, %1, %arg81) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_or_logic_and_3_proof : logic_or_logic_and_3_before ⊑ logic_or_logic_and_3_after := by
  unfold logic_or_logic_and_3_before logic_or_logic_and_3_after
  simp_alive_peephole
  intros
  ---BEGIN logic_or_logic_and_3
  apply logic_or_logic_and_3_thm
  ---END logic_or_logic_and_3



def logic_or_logic_and_4_before := [llvm|
{
^0(%arg78 : i1, %arg79 : i1, %arg80 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg78, %0, %arg79) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg80, %0, %arg78) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_or_logic_and_4_after := [llvm|
{
^0(%arg78 : i1, %arg79 : i1, %arg80 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg79, %arg80, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg78, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_or_logic_and_4_proof : logic_or_logic_and_4_before ⊑ logic_or_logic_and_4_after := by
  unfold logic_or_logic_and_4_before logic_or_logic_and_4_after
  simp_alive_peephole
  intros
  ---BEGIN logic_or_logic_and_4
  apply logic_or_logic_and_4_thm
  ---END logic_or_logic_and_4



def logic_or_logic_and_5_before := [llvm|
{
^0(%arg75 : i1, %arg76 : i1, %arg77 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg75, %0, %arg76) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg75, %0, %arg77) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_or_logic_and_5_after := [llvm|
{
^0(%arg75 : i1, %arg76 : i1, %arg77 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg77, %arg76, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg75, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_or_logic_and_5_proof : logic_or_logic_and_5_before ⊑ logic_or_logic_and_5_after := by
  unfold logic_or_logic_and_5_before logic_or_logic_and_5_after
  simp_alive_peephole
  intros
  ---BEGIN logic_or_logic_and_5
  apply logic_or_logic_and_5_thm
  ---END logic_or_logic_and_5



def logic_or_logic_and_6_before := [llvm|
{
^0(%arg72 : i1, %arg73 : i1, %arg74 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg73, %0, %arg72) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg72, %0, %arg74) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_or_logic_and_6_after := [llvm|
{
^0(%arg72 : i1, %arg73 : i1, %arg74 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg74, %arg73, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg72, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_or_logic_and_6_proof : logic_or_logic_and_6_before ⊑ logic_or_logic_and_6_after := by
  unfold logic_or_logic_and_6_before logic_or_logic_and_6_after
  simp_alive_peephole
  intros
  ---BEGIN logic_or_logic_and_6
  apply logic_or_logic_and_6_thm
  ---END logic_or_logic_and_6



def logic_or_logic_and_7_before := [llvm|
{
^0(%arg69 : i1, %arg70 : i1, %arg71 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg70, %0, %arg69) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg71, %0, %arg69) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_or_logic_and_7_after := [llvm|
{
^0(%arg69 : i1, %arg70 : i1, %arg71 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg71, %arg70, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%2, %1, %arg69) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_or_logic_and_7_proof : logic_or_logic_and_7_before ⊑ logic_or_logic_and_7_after := by
  unfold logic_or_logic_and_7_before logic_or_logic_and_7_after
  simp_alive_peephole
  intros
  ---BEGIN logic_or_logic_and_7
  apply logic_or_logic_and_7_thm
  ---END logic_or_logic_and_7



def logic_or_logic_and_8_before := [llvm|
{
^0(%arg66 : i1, %arg67 : i1, %arg68 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg66, %0, %arg67) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg68, %0, %arg66) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def logic_or_logic_and_8_after := [llvm|
{
^0(%arg66 : i1, %arg67 : i1, %arg68 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg68, %arg67, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg66, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem logic_or_logic_and_8_proof : logic_or_logic_and_8_before ⊑ logic_or_logic_and_8_after := by
  unfold logic_or_logic_and_8_before logic_or_logic_and_8_after
  simp_alive_peephole
  intros
  ---BEGIN logic_or_logic_and_8
  apply logic_or_logic_and_8_thm
  ---END logic_or_logic_and_8



def or_logic_or_logic_and_1_before := [llvm|
{
^0(%arg48 : i1, %arg49 : i1, %arg50 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.or %arg48, %arg49 : i1
  %3 = "llvm.select"(%arg48, %0, %arg50) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_logic_or_logic_and_1_after := [llvm|
{
^0(%arg48 : i1, %arg49 : i1, %arg50 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg49, %arg50, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg48, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_logic_or_logic_and_1_proof : or_logic_or_logic_and_1_before ⊑ or_logic_or_logic_and_1_after := by
  unfold or_logic_or_logic_and_1_before or_logic_or_logic_and_1_after
  simp_alive_peephole
  intros
  ---BEGIN or_logic_or_logic_and_1
  apply or_logic_or_logic_and_1_thm
  ---END or_logic_or_logic_and_1



def or_logic_or_logic_and_2_before := [llvm|
{
^0(%arg45 : i1, %arg46 : i1, %arg47 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.or %arg45, %arg46 : i1
  %3 = "llvm.select"(%arg47, %0, %arg45) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_logic_or_logic_and_2_after := [llvm|
{
^0(%arg45 : i1, %arg46 : i1, %arg47 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg46, %arg47, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg45, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_logic_or_logic_and_2_proof : or_logic_or_logic_and_2_before ⊑ or_logic_or_logic_and_2_after := by
  unfold or_logic_or_logic_and_2_before or_logic_or_logic_and_2_after
  simp_alive_peephole
  intros
  ---BEGIN or_logic_or_logic_and_2
  apply or_logic_or_logic_and_2_thm
  ---END or_logic_or_logic_and_2



def or_logic_or_logic_and_3_before := [llvm|
{
^0(%arg42 : i1, %arg43 : i1, %arg44 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.or %arg42, %arg43 : i1
  %3 = "llvm.select"(%arg42, %0, %arg44) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_logic_or_logic_and_3_after := [llvm|
{
^0(%arg42 : i1, %arg43 : i1, %arg44 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg44, %arg43, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg42, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_logic_or_logic_and_3_proof : or_logic_or_logic_and_3_before ⊑ or_logic_or_logic_and_3_after := by
  unfold or_logic_or_logic_and_3_before or_logic_or_logic_and_3_after
  simp_alive_peephole
  intros
  ---BEGIN or_logic_or_logic_and_3
  apply or_logic_or_logic_and_3_thm
  ---END or_logic_or_logic_and_3



def or_logic_or_logic_and_4_before := [llvm|
{
^0(%arg39 : i1, %arg40 : i1, %arg41 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.or %arg39, %arg40 : i1
  %3 = "llvm.select"(%arg41, %0, %arg39) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_logic_or_logic_and_4_after := [llvm|
{
^0(%arg39 : i1, %arg40 : i1, %arg41 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg41, %arg40, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.or %arg39, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_logic_or_logic_and_4_proof : or_logic_or_logic_and_4_before ⊑ or_logic_or_logic_and_4_after := by
  unfold or_logic_or_logic_and_4_before or_logic_or_logic_and_4_after
  simp_alive_peephole
  intros
  ---BEGIN or_logic_or_logic_and_4
  apply or_logic_or_logic_and_4_thm
  ---END or_logic_or_logic_and_4



def or_logic_or_logic_and_5_before := [llvm|
{
^0(%arg36 : i1, %arg37 : i1, %arg38 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.or %arg37, %arg36 : i1
  %3 = "llvm.select"(%arg36, %0, %arg38) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_logic_or_logic_and_5_after := [llvm|
{
^0(%arg36 : i1, %arg37 : i1, %arg38 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg37, %arg38, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg36, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_logic_or_logic_and_5_proof : or_logic_or_logic_and_5_before ⊑ or_logic_or_logic_and_5_after := by
  unfold or_logic_or_logic_and_5_before or_logic_or_logic_and_5_after
  simp_alive_peephole
  intros
  ---BEGIN or_logic_or_logic_and_5
  apply or_logic_or_logic_and_5_thm
  ---END or_logic_or_logic_and_5



def or_logic_or_logic_and_6_before := [llvm|
{
^0(%arg33 : i1, %arg34 : i1, %arg35 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.or %arg34, %arg33 : i1
  %3 = "llvm.select"(%arg35, %0, %arg33) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_logic_or_logic_and_6_after := [llvm|
{
^0(%arg33 : i1, %arg34 : i1, %arg35 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg34, %arg35, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg33, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_logic_or_logic_and_6_proof : or_logic_or_logic_and_6_before ⊑ or_logic_or_logic_and_6_after := by
  unfold or_logic_or_logic_and_6_before or_logic_or_logic_and_6_after
  simp_alive_peephole
  intros
  ---BEGIN or_logic_or_logic_and_6
  apply or_logic_or_logic_and_6_thm
  ---END or_logic_or_logic_and_6



def or_logic_or_logic_and_7_before := [llvm|
{
^0(%arg30 : i1, %arg31 : i1, %arg32 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.or %arg31, %arg30 : i1
  %3 = "llvm.select"(%arg30, %0, %arg32) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_logic_or_logic_and_7_after := [llvm|
{
^0(%arg30 : i1, %arg31 : i1, %arg32 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg32, %arg31, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg30, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_logic_or_logic_and_7_proof : or_logic_or_logic_and_7_before ⊑ or_logic_or_logic_and_7_after := by
  unfold or_logic_or_logic_and_7_before or_logic_or_logic_and_7_after
  simp_alive_peephole
  intros
  ---BEGIN or_logic_or_logic_and_7
  apply or_logic_or_logic_and_7_thm
  ---END or_logic_or_logic_and_7



def or_logic_or_logic_and_8_before := [llvm|
{
^0(%arg27 : i1, %arg28 : i1, %arg29 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.or %arg28, %arg27 : i1
  %3 = "llvm.select"(%arg29, %0, %arg27) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_logic_or_logic_and_8_after := [llvm|
{
^0(%arg27 : i1, %arg28 : i1, %arg29 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg29, %arg28, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.or %arg27, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_logic_or_logic_and_8_proof : or_logic_or_logic_and_8_before ⊑ or_logic_or_logic_and_8_after := by
  unfold or_logic_or_logic_and_8_before or_logic_or_logic_and_8_after
  simp_alive_peephole
  intros
  ---BEGIN or_logic_or_logic_and_8
  apply or_logic_or_logic_and_8_thm
  ---END or_logic_or_logic_and_8



def or_or_logic_and_1_before := [llvm|
{
^0(%arg12 : i1, %arg13 : i1, %arg14 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.or %arg12, %arg13 : i1
  %2 = llvm.or %arg14, %arg12 : i1
  %3 = "llvm.select"(%1, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_or_logic_and_1_after := [llvm|
{
^0(%arg12 : i1, %arg13 : i1, %arg14 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg13, %arg14, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.or %arg12, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_logic_and_1_proof : or_or_logic_and_1_before ⊑ or_or_logic_and_1_after := by
  unfold or_or_logic_and_1_before or_or_logic_and_1_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_logic_and_1
  apply or_or_logic_and_1_thm
  ---END or_or_logic_and_1



def or_or_logic_and_2_before := [llvm|
{
^0(%arg9 : i1, %arg10 : i1, %arg11 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.or %arg9, %arg10 : i1
  %2 = llvm.or %arg11, %arg9 : i1
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_or_logic_and_2_after := [llvm|
{
^0(%arg9 : i1, %arg10 : i1, %arg11 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg11, %arg10, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.or %arg9, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_or_logic_and_2_proof : or_or_logic_and_2_before ⊑ or_or_logic_and_2_after := by
  unfold or_or_logic_and_2_before or_or_logic_and_2_after
  simp_alive_peephole
  intros
  ---BEGIN or_or_logic_and_2
  apply or_or_logic_and_2_thm
  ---END or_or_logic_and_2


