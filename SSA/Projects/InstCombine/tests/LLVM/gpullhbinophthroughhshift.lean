import SSA.Projects.InstCombine.tests.LLVM.gpullhbinophthroughhshift_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def and_signbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_signbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_signbit_shl_proof : and_signbit_shl_before ⊑ and_signbit_shl_after := by
  unfold and_signbit_shl_before and_signbit_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_signbit_shl
  apply and_signbit_shl_thm
  ---END and_signbit_shl



def and_nosignbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_nosignbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_nosignbit_shl_proof : and_nosignbit_shl_before ⊑ and_nosignbit_shl_after := by
  unfold and_nosignbit_shl_before and_nosignbit_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_nosignbit_shl
  apply and_nosignbit_shl_thm
  ---END and_nosignbit_shl



def or_signbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def or_signbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_signbit_shl_proof : or_signbit_shl_before ⊑ or_signbit_shl_after := by
  unfold or_signbit_shl_before or_signbit_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_signbit_shl
  apply or_signbit_shl_thm
  ---END or_signbit_shl



def or_nosignbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def or_nosignbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_nosignbit_shl_proof : or_nosignbit_shl_before ⊑ or_nosignbit_shl_after := by
  unfold or_nosignbit_shl_before or_nosignbit_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_nosignbit_shl
  apply or_nosignbit_shl_thm
  ---END or_nosignbit_shl



def xor_signbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def xor_signbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_signbit_shl_proof : xor_signbit_shl_before ⊑ xor_signbit_shl_after := by
  unfold xor_signbit_shl_before xor_signbit_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_signbit_shl
  apply xor_signbit_shl_thm
  ---END xor_signbit_shl



def xor_nosignbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def xor_nosignbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_nosignbit_shl_proof : xor_nosignbit_shl_before ⊑ xor_nosignbit_shl_after := by
  unfold xor_nosignbit_shl_before xor_nosignbit_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_nosignbit_shl
  apply xor_nosignbit_shl_thm
  ---END xor_nosignbit_shl



def add_signbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_signbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem add_signbit_shl_proof : add_signbit_shl_before ⊑ add_signbit_shl_after := by
  unfold add_signbit_shl_before add_signbit_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_signbit_shl
  apply add_signbit_shl_thm
  ---END add_signbit_shl



def add_nosignbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_nosignbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem add_nosignbit_shl_proof : add_nosignbit_shl_before ⊑ add_nosignbit_shl_after := by
  unfold add_nosignbit_shl_before add_nosignbit_shl_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN add_nosignbit_shl
  apply add_nosignbit_shl_thm
  ---END add_nosignbit_shl



def and_signbit_lshr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_signbit_lshr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 16776960 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_signbit_lshr_proof : and_signbit_lshr_before ⊑ and_signbit_lshr_after := by
  unfold and_signbit_lshr_before and_signbit_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_signbit_lshr
  apply and_signbit_lshr_thm
  ---END and_signbit_lshr



def and_nosignbit_lshr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_nosignbit_lshr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8388352 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_nosignbit_lshr_proof : and_nosignbit_lshr_before ⊑ and_nosignbit_lshr_after := by
  unfold and_nosignbit_lshr_before and_nosignbit_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_nosignbit_lshr
  apply and_nosignbit_lshr_thm
  ---END and_nosignbit_lshr



def or_signbit_lshr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def or_signbit_lshr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 16776960 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_signbit_lshr_proof : or_signbit_lshr_before ⊑ or_signbit_lshr_after := by
  unfold or_signbit_lshr_before or_signbit_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_signbit_lshr
  apply or_signbit_lshr_thm
  ---END or_signbit_lshr



def or_nosignbit_lshr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def or_nosignbit_lshr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8388352 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_nosignbit_lshr_proof : or_nosignbit_lshr_before ⊑ or_nosignbit_lshr_after := by
  unfold or_nosignbit_lshr_before or_nosignbit_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_nosignbit_lshr
  apply or_nosignbit_lshr_thm
  ---END or_nosignbit_lshr



def xor_signbit_lshr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def xor_signbit_lshr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 16776960 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_signbit_lshr_proof : xor_signbit_lshr_before ⊑ xor_signbit_lshr_after := by
  unfold xor_signbit_lshr_before xor_signbit_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_signbit_lshr
  apply xor_signbit_lshr_thm
  ---END xor_signbit_lshr



def xor_nosignbit_lshr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def xor_nosignbit_lshr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8388352 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_nosignbit_lshr_proof : xor_nosignbit_lshr_before ⊑ xor_nosignbit_lshr_after := by
  unfold xor_nosignbit_lshr_before xor_nosignbit_lshr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_nosignbit_lshr
  apply xor_nosignbit_lshr_thm
  ---END xor_nosignbit_lshr



def and_signbit_ashr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_signbit_ashr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -256 : i32}> : () -> i32
  %2 = llvm.ashr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_signbit_ashr_proof : and_signbit_ashr_before ⊑ and_signbit_ashr_after := by
  unfold and_signbit_ashr_before and_signbit_ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_signbit_ashr
  apply and_signbit_ashr_thm
  ---END and_signbit_ashr



def and_nosignbit_ashr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_nosignbit_ashr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8388352 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_nosignbit_ashr_proof : and_nosignbit_ashr_before ⊑ and_nosignbit_ashr_after := by
  unfold and_nosignbit_ashr_before and_nosignbit_ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN and_nosignbit_ashr
  apply and_nosignbit_ashr_thm
  ---END and_nosignbit_ashr



def or_signbit_ashr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def or_signbit_ashr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -256 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_signbit_ashr_proof : or_signbit_ashr_before ⊑ or_signbit_ashr_after := by
  unfold or_signbit_ashr_before or_signbit_ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_signbit_ashr
  apply or_signbit_ashr_thm
  ---END or_signbit_ashr



def or_nosignbit_ashr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def or_nosignbit_ashr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8388352 : i32}> : () -> i32
  %2 = llvm.ashr %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_nosignbit_ashr_proof : or_nosignbit_ashr_before ⊑ or_nosignbit_ashr_after := by
  unfold or_nosignbit_ashr_before or_nosignbit_ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN or_nosignbit_ashr
  apply or_nosignbit_ashr_thm
  ---END or_nosignbit_ashr



def xor_signbit_ashr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def xor_signbit_ashr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -256 : i32}> : () -> i32
  %2 = llvm.ashr %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_signbit_ashr_proof : xor_signbit_ashr_before ⊑ xor_signbit_ashr_after := by
  unfold xor_signbit_ashr_before xor_signbit_ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_signbit_ashr
  apply xor_signbit_ashr_thm
  ---END xor_signbit_ashr



def xor_nosignbit_ashr_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def xor_nosignbit_ashr_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8388352 : i32}> : () -> i32
  %2 = llvm.ashr %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_nosignbit_ashr_proof : xor_nosignbit_ashr_before ⊑ xor_nosignbit_ashr_after := by
  unfold xor_nosignbit_ashr_before xor_nosignbit_ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN xor_nosignbit_ashr
  apply xor_nosignbit_ashr_thm
  ---END xor_nosignbit_ashr


