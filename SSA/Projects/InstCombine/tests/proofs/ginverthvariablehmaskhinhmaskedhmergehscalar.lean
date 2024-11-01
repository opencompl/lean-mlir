import SSA.Projects.InstCombine.tests.proofs.ginverthvariablehmaskhinhmaskedhmergehscalar_proof
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
section ginverthvariablehmaskhinhmaskedhmergehscalar_statements

def scalar_before := [llvm|
{
^0(%arg43 : i4, %arg44 : i4, %arg45 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg45, %0 : i4
  %2 = llvm.xor %arg43, %arg44 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg44 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def scalar_after := [llvm|
{
^0(%arg43 : i4, %arg44 : i4, %arg45 : i4):
  %0 = llvm.xor %arg43, %arg44 : i4
  %1 = llvm.and %0, %arg45 : i4
  %2 = llvm.xor %1, %arg43 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_proof : scalar_before ⊑ scalar_after := by
  unfold scalar_before scalar_after
  simp_alive_peephole
  intros
  ---BEGIN scalar
  apply scalar_thm
  ---END scalar



def in_constant_varx_mone_invmask_before := [llvm|
{
^0(%arg41 : i4, %arg42 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg42, %0 : i4
  %2 = llvm.xor %arg41, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_varx_mone_invmask_after := [llvm|
{
^0(%arg41 : i4, %arg42 : i4):
  %0 = llvm.or %arg41, %arg42 : i4
  "llvm.return"(%0) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem in_constant_varx_mone_invmask_proof : in_constant_varx_mone_invmask_before ⊑ in_constant_varx_mone_invmask_after := by
  unfold in_constant_varx_mone_invmask_before in_constant_varx_mone_invmask_after
  simp_alive_peephole
  intros
  ---BEGIN in_constant_varx_mone_invmask
  apply in_constant_varx_mone_invmask_thm
  ---END in_constant_varx_mone_invmask



def in_constant_varx_6_invmask_before := [llvm|
{
^0(%arg39 : i4, %arg40 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.xor %arg40, %0 : i4
  %3 = llvm.xor %arg39, %1 : i4
  %4 = llvm.and %3, %2 : i4
  %5 = llvm.xor %4, %1 : i4
  "llvm.return"(%5) : (i4) -> ()
}
]
def in_constant_varx_6_invmask_after := [llvm|
{
^0(%arg39 : i4, %arg40 : i4):
  %0 = llvm.mlir.constant(6 : i4) : i4
  %1 = llvm.xor %arg39, %0 : i4
  %2 = llvm.and %1, %arg40 : i4
  %3 = llvm.xor %2, %arg39 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem in_constant_varx_6_invmask_proof : in_constant_varx_6_invmask_before ⊑ in_constant_varx_6_invmask_after := by
  unfold in_constant_varx_6_invmask_before in_constant_varx_6_invmask_after
  simp_alive_peephole
  intros
  ---BEGIN in_constant_varx_6_invmask
  apply in_constant_varx_6_invmask_thm
  ---END in_constant_varx_6_invmask



def in_constant_mone_vary_invmask_before := [llvm|
{
^0(%arg37 : i4, %arg38 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg38, %0 : i4
  %2 = llvm.xor %0, %arg37 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg37 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_mone_vary_invmask_after := [llvm|
{
^0(%arg37 : i4, %arg38 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg38, %0 : i4
  %2 = llvm.or %arg37, %1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem in_constant_mone_vary_invmask_proof : in_constant_mone_vary_invmask_before ⊑ in_constant_mone_vary_invmask_after := by
  unfold in_constant_mone_vary_invmask_before in_constant_mone_vary_invmask_after
  simp_alive_peephole
  intros
  ---BEGIN in_constant_mone_vary_invmask
  apply in_constant_mone_vary_invmask_thm
  ---END in_constant_mone_vary_invmask



def in_constant_6_vary_invmask_before := [llvm|
{
^0(%arg35 : i4, %arg36 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.xor %arg36, %0 : i4
  %3 = llvm.xor %arg35, %1 : i4
  %4 = llvm.and %3, %2 : i4
  %5 = llvm.xor %4, %arg35 : i4
  "llvm.return"(%5) : (i4) -> ()
}
]
def in_constant_6_vary_invmask_after := [llvm|
{
^0(%arg35 : i4, %arg36 : i4):
  %0 = llvm.mlir.constant(6 : i4) : i4
  %1 = llvm.xor %arg35, %0 : i4
  %2 = llvm.and %1, %arg36 : i4
  %3 = llvm.xor %2, %0 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem in_constant_6_vary_invmask_proof : in_constant_6_vary_invmask_before ⊑ in_constant_6_vary_invmask_after := by
  unfold in_constant_6_vary_invmask_before in_constant_6_vary_invmask_after
  simp_alive_peephole
  intros
  ---BEGIN in_constant_6_vary_invmask
  apply in_constant_6_vary_invmask_thm
  ---END in_constant_6_vary_invmask



def c_1_0_0_before := [llvm|
{
^0(%arg32 : i4, %arg33 : i4, %arg34 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg34, %0 : i4
  %2 = llvm.xor %arg33, %arg32 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg33 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def c_1_0_0_after := [llvm|
{
^0(%arg32 : i4, %arg33 : i4, %arg34 : i4):
  %0 = llvm.xor %arg33, %arg32 : i4
  %1 = llvm.and %0, %arg34 : i4
  %2 = llvm.xor %1, %arg32 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem c_1_0_0_proof : c_1_0_0_before ⊑ c_1_0_0_after := by
  unfold c_1_0_0_before c_1_0_0_after
  simp_alive_peephole
  intros
  ---BEGIN c_1_0_0
  apply c_1_0_0_thm
  ---END c_1_0_0



def c_0_1_0_before := [llvm|
{
^0(%arg29 : i4, %arg30 : i4, %arg31 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg31, %0 : i4
  %2 = llvm.xor %arg29, %arg30 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg29 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def c_0_1_0_after := [llvm|
{
^0(%arg29 : i4, %arg30 : i4, %arg31 : i4):
  %0 = llvm.xor %arg29, %arg30 : i4
  %1 = llvm.and %0, %arg31 : i4
  %2 = llvm.xor %1, %arg30 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem c_0_1_0_proof : c_0_1_0_before ⊑ c_0_1_0_after := by
  unfold c_0_1_0_before c_0_1_0_after
  simp_alive_peephole
  intros
  ---BEGIN c_0_1_0
  apply c_0_1_0_thm
  ---END c_0_1_0



def c_1_1_0_before := [llvm|
{
^0(%arg25 : i4, %arg26 : i4, %arg27 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg27, %0 : i4
  %2 = llvm.xor %arg26, %arg25 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg25 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def c_1_1_0_after := [llvm|
{
^0(%arg25 : i4, %arg26 : i4, %arg27 : i4):
  %0 = llvm.xor %arg26, %arg25 : i4
  %1 = llvm.and %0, %arg27 : i4
  %2 = llvm.xor %1, %arg26 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem c_1_1_0_proof : c_1_1_0_before ⊑ c_1_1_0_after := by
  unfold c_1_1_0_before c_1_1_0_after
  simp_alive_peephole
  intros
  ---BEGIN c_1_1_0
  apply c_1_1_0_thm
  ---END c_1_1_0



def commutativity_constant_varx_6_invmask_before := [llvm|
{
^0(%arg18 : i4, %arg19 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.xor %arg19, %0 : i4
  %3 = llvm.xor %arg18, %1 : i4
  %4 = llvm.and %2, %3 : i4
  %5 = llvm.xor %4, %1 : i4
  "llvm.return"(%5) : (i4) -> ()
}
]
def commutativity_constant_varx_6_invmask_after := [llvm|
{
^0(%arg18 : i4, %arg19 : i4):
  %0 = llvm.mlir.constant(6 : i4) : i4
  %1 = llvm.xor %arg18, %0 : i4
  %2 = llvm.and %1, %arg19 : i4
  %3 = llvm.xor %2, %arg18 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem commutativity_constant_varx_6_invmask_proof : commutativity_constant_varx_6_invmask_before ⊑ commutativity_constant_varx_6_invmask_after := by
  unfold commutativity_constant_varx_6_invmask_before commutativity_constant_varx_6_invmask_after
  simp_alive_peephole
  intros
  ---BEGIN commutativity_constant_varx_6_invmask
  apply commutativity_constant_varx_6_invmask_thm
  ---END commutativity_constant_varx_6_invmask



def commutativity_constant_6_vary_invmask_before := [llvm|
{
^0(%arg16 : i4, %arg17 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.xor %arg17, %0 : i4
  %3 = llvm.xor %arg16, %1 : i4
  %4 = llvm.and %2, %3 : i4
  %5 = llvm.xor %4, %arg16 : i4
  "llvm.return"(%5) : (i4) -> ()
}
]
def commutativity_constant_6_vary_invmask_after := [llvm|
{
^0(%arg16 : i4, %arg17 : i4):
  %0 = llvm.mlir.constant(6 : i4) : i4
  %1 = llvm.xor %arg16, %0 : i4
  %2 = llvm.and %1, %arg17 : i4
  %3 = llvm.xor %2, %0 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem commutativity_constant_6_vary_invmask_proof : commutativity_constant_6_vary_invmask_before ⊑ commutativity_constant_6_vary_invmask_after := by
  unfold commutativity_constant_6_vary_invmask_before commutativity_constant_6_vary_invmask_after
  simp_alive_peephole
  intros
  ---BEGIN commutativity_constant_6_vary_invmask
  apply commutativity_constant_6_vary_invmask_thm
  ---END commutativity_constant_6_vary_invmask


