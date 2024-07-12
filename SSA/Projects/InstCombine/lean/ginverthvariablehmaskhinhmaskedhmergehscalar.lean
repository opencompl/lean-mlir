import SSA.Projects.InstCombine.lean.ginverthvariablehmaskhinhmaskedhmergehscalar_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def scalar_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg2, %0 : i4
  %2 = llvm.xor %arg0, %arg1 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg1 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def scalar_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.xor %arg0, %arg1 : i4
  %1 = llvm.and %0, %arg2 : i4
  %2 = llvm.xor %1, %arg0 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
theorem scalar_proof : scalar_before ⊑ scalar_after := by
  unfold scalar_before scalar_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN scalar
  apply scalar_thm
  ---END scalar



def in_constant_varx_mone_invmask_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg1, %0 : i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_varx_mone_invmask_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = llvm.or %arg0, %arg1 : i4
  "llvm.return"(%0) : (i4) -> ()
}
]
theorem in_constant_varx_mone_invmask_proof : in_constant_varx_mone_invmask_before ⊑ in_constant_varx_mone_invmask_after := by
  unfold in_constant_varx_mone_invmask_before in_constant_varx_mone_invmask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN in_constant_varx_mone_invmask
  apply in_constant_varx_mone_invmask_thm
  ---END in_constant_varx_mone_invmask



def in_constant_varx_6_invmask_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 6 : i4}> : () -> i4
  %2 = llvm.xor %arg1, %0 : i4
  %3 = llvm.xor %arg0, %1 : i4
  %4 = llvm.and %3, %2 : i4
  %5 = llvm.xor %4, %1 : i4
  "llvm.return"(%5) : (i4) -> ()
}
]
def in_constant_varx_6_invmask_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = 6 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %0 : i4
  %2 = llvm.and %1, %arg1 : i4
  %3 = llvm.xor %2, %arg0 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem in_constant_varx_6_invmask_proof : in_constant_varx_6_invmask_before ⊑ in_constant_varx_6_invmask_after := by
  unfold in_constant_varx_6_invmask_before in_constant_varx_6_invmask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN in_constant_varx_6_invmask
  apply in_constant_varx_6_invmask_thm
  ---END in_constant_varx_6_invmask



def in_constant_mone_vary_invmask_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg1, %0 : i4
  %2 = llvm.xor %0, %arg0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_mone_vary_invmask_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg1, %0 : i4
  %2 = llvm.or %1, %arg0 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
theorem in_constant_mone_vary_invmask_proof : in_constant_mone_vary_invmask_before ⊑ in_constant_mone_vary_invmask_after := by
  unfold in_constant_mone_vary_invmask_before in_constant_mone_vary_invmask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN in_constant_mone_vary_invmask
  apply in_constant_mone_vary_invmask_thm
  ---END in_constant_mone_vary_invmask



def in_constant_6_vary_invmask_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 6 : i4}> : () -> i4
  %2 = llvm.xor %arg1, %0 : i4
  %3 = llvm.xor %arg0, %1 : i4
  %4 = llvm.and %3, %2 : i4
  %5 = llvm.xor %4, %arg0 : i4
  "llvm.return"(%5) : (i4) -> ()
}
]
def in_constant_6_vary_invmask_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = 6 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %0 : i4
  %2 = llvm.and %1, %arg1 : i4
  %3 = llvm.xor %2, %0 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem in_constant_6_vary_invmask_proof : in_constant_6_vary_invmask_before ⊑ in_constant_6_vary_invmask_after := by
  unfold in_constant_6_vary_invmask_before in_constant_6_vary_invmask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN in_constant_6_vary_invmask
  apply in_constant_6_vary_invmask_thm
  ---END in_constant_6_vary_invmask



def c_1_0_0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg2, %0 : i4
  %2 = llvm.xor %arg1, %arg0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg1 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def c_1_0_0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.xor %arg1, %arg0 : i4
  %1 = llvm.and %0, %arg2 : i4
  %2 = llvm.xor %1, %arg0 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
theorem c_1_0_0_proof : c_1_0_0_before ⊑ c_1_0_0_after := by
  unfold c_1_0_0_before c_1_0_0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN c_1_0_0
  apply c_1_0_0_thm
  ---END c_1_0_0



def c_0_1_0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg2, %0 : i4
  %2 = llvm.xor %arg0, %arg1 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def c_0_1_0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.xor %arg0, %arg1 : i4
  %1 = llvm.and %0, %arg2 : i4
  %2 = llvm.xor %1, %arg1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
theorem c_0_1_0_proof : c_0_1_0_before ⊑ c_0_1_0_after := by
  unfold c_0_1_0_before c_0_1_0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN c_0_1_0
  apply c_0_1_0_thm
  ---END c_0_1_0



def c_1_1_0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg2, %0 : i4
  %2 = llvm.xor %arg1, %arg0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def c_1_1_0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.xor %arg1, %arg0 : i4
  %1 = llvm.and %0, %arg2 : i4
  %2 = llvm.xor %1, %arg1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
theorem c_1_1_0_proof : c_1_1_0_before ⊑ c_1_1_0_after := by
  unfold c_1_1_0_before c_1_1_0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN c_1_1_0
  apply c_1_1_0_thm
  ---END c_1_1_0



def commutativity_constant_varx_6_invmask_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 6 : i4}> : () -> i4
  %2 = llvm.xor %arg1, %0 : i4
  %3 = llvm.xor %arg0, %1 : i4
  %4 = llvm.and %2, %3 : i4
  %5 = llvm.xor %4, %1 : i4
  "llvm.return"(%5) : (i4) -> ()
}
]
def commutativity_constant_varx_6_invmask_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = 6 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %0 : i4
  %2 = llvm.and %1, %arg1 : i4
  %3 = llvm.xor %2, %arg0 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem commutativity_constant_varx_6_invmask_proof : commutativity_constant_varx_6_invmask_before ⊑ commutativity_constant_varx_6_invmask_after := by
  unfold commutativity_constant_varx_6_invmask_before commutativity_constant_varx_6_invmask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN commutativity_constant_varx_6_invmask
  apply commutativity_constant_varx_6_invmask_thm
  ---END commutativity_constant_varx_6_invmask



def commutativity_constant_6_vary_invmask_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 6 : i4}> : () -> i4
  %2 = llvm.xor %arg1, %0 : i4
  %3 = llvm.xor %arg0, %1 : i4
  %4 = llvm.and %2, %3 : i4
  %5 = llvm.xor %4, %arg0 : i4
  "llvm.return"(%5) : (i4) -> ()
}
]
def commutativity_constant_6_vary_invmask_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = 6 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %0 : i4
  %2 = llvm.and %1, %arg1 : i4
  %3 = llvm.xor %2, %0 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem commutativity_constant_6_vary_invmask_proof : commutativity_constant_6_vary_invmask_before ⊑ commutativity_constant_6_vary_invmask_after := by
  unfold commutativity_constant_6_vary_invmask_before commutativity_constant_6_vary_invmask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN commutativity_constant_6_vary_invmask
  apply commutativity_constant_6_vary_invmask_thm
  ---END commutativity_constant_6_vary_invmask


