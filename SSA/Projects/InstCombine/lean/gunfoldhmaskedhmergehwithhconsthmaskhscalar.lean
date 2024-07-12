import SSA.Projects.InstCombine.lean.gunfoldhmaskedhmergehwithhconsthmaskhscalar_proof
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
                                                                       
def scalar0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %arg1 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def scalar0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %2 = llvm.and %arg0, %0 : i4
  %3 = llvm.and %arg1, %1 : i4
  %4 = llvm.or %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
theorem scalar0_proof : scalar0_before ⊑ scalar0_after := by
  unfold scalar0_before scalar0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN scalar0
  apply scalar0_thm
  ---END scalar0



def scalar1_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %arg1 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def scalar1_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %2 = llvm.and %arg0, %0 : i4
  %3 = llvm.and %arg1, %1 : i4
  %4 = llvm.or %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
theorem scalar1_proof : scalar1_before ⊑ scalar1_after := by
  unfold scalar1_before scalar1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN scalar1
  apply scalar1_thm
  ---END scalar1



def in_constant_varx_mone_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_varx_mone_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = llvm.or %arg0, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem in_constant_varx_mone_proof : in_constant_varx_mone_before ⊑ in_constant_varx_mone_after := by
  unfold in_constant_varx_mone_before in_constant_varx_mone_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN in_constant_varx_mone
  apply in_constant_varx_mone_thm
  ---END in_constant_varx_mone



def in_constant_varx_14_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_varx_14_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = llvm.or %arg0, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem in_constant_varx_14_proof : in_constant_varx_14_before ⊑ in_constant_varx_14_after := by
  unfold in_constant_varx_14_before in_constant_varx_14_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN in_constant_varx_14
  apply in_constant_varx_14_thm
  ---END in_constant_varx_14



def in_constant_mone_vary_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_mone_vary_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %1 = llvm.or %arg0, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem in_constant_mone_vary_proof : in_constant_mone_vary_before ⊑ in_constant_mone_vary_after := by
  unfold in_constant_mone_vary_before in_constant_mone_vary_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN in_constant_mone_vary
  apply in_constant_mone_vary_thm
  ---END in_constant_mone_vary



def in_constant_14_vary_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_14_vary_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = llvm.and %arg0, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem in_constant_14_vary_proof : in_constant_14_vary_before ⊑ in_constant_14_vary_after := by
  unfold in_constant_14_vary_before in_constant_14_vary_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN in_constant_14_vary
  apply in_constant_14_vary_thm
  ---END in_constant_14_vary



def c_1_0_0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = llvm.xor %arg1, %arg0 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def c_1_0_0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %2 = llvm.and %arg0, %0 : i4
  %3 = llvm.and %arg1, %1 : i4
  %4 = llvm.or %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
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
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %arg1 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg0 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def c_0_1_0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %2 = llvm.and %arg1, %0 : i4
  %3 = llvm.and %arg0, %1 : i4
  %4 = llvm.or %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
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
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = llvm.xor %arg1, %arg0 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg0 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def c_1_1_0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %2 = llvm.and %arg1, %0 : i4
  %3 = llvm.and %arg0, %1 : i4
  %4 = llvm.or %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
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



def commutativity_constant_14_vary_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{value = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %arg0, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def commutativity_constant_14_vary_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{value = -2 : i4}> : () -> i4
  %1 = llvm.and %arg0, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem commutativity_constant_14_vary_proof : commutativity_constant_14_vary_before ⊑ commutativity_constant_14_vary_after := by
  unfold commutativity_constant_14_vary_before commutativity_constant_14_vary_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN commutativity_constant_14_vary
  apply commutativity_constant_14_vary_thm
  ---END commutativity_constant_14_vary


