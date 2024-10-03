
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
section gsignext_statements
                                                    
def sextinreg_before := [llvm|
{
^0(%arg14 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -32768 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 32768 : i32}> : () -> i32
  %3 = llvm.and %arg14, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def sextinreg_after := [llvm|
{
^0(%arg14 : i32):
  %0 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %1 = llvm.shl %arg14, %0 : i32
  %2 = llvm.ashr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sextinreg_proof : sextinreg_before ⊑ sextinreg_after := by
  unfold sextinreg_before sextinreg_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sextinreg
  all_goals (try extract_goal ; sorry)
  ---END sextinreg



def sextinreg_alt_before := [llvm|
{
^0(%arg11 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 32768 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -32768 : i32}> : () -> i32
  %3 = llvm.and %arg11, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def sextinreg_alt_after := [llvm|
{
^0(%arg11 : i32):
  %0 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %1 = llvm.shl %arg11, %0 : i32
  %2 = llvm.ashr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sextinreg_alt_proof : sextinreg_alt_before ⊑ sextinreg_alt_after := by
  unfold sextinreg_alt_before sextinreg_alt_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sextinreg_alt
  all_goals (try extract_goal ; sorry)
  ---END sextinreg_alt



def sextinreg2_before := [llvm|
{
^0(%arg6 : i32):
  %0 = "llvm.mlir.constant"() <{value = 255 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 128 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -128 : i32}> : () -> i32
  %3 = llvm.and %arg6, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def sextinreg2_after := [llvm|
{
^0(%arg6 : i32):
  %0 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %1 = llvm.shl %arg6, %0 : i32
  %2 = llvm.ashr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sextinreg2_proof : sextinreg2_before ⊑ sextinreg2_after := by
  unfold sextinreg2_before sextinreg2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN sextinreg2
  all_goals (try extract_goal ; sorry)
  ---END sextinreg2



def ashr_before := [llvm|
{
^0(%arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 67108864 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -67108864 : i32}> : () -> i32
  %3 = llvm.lshr %arg1, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def ashr_after := [llvm|
{
^0(%arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = llvm.ashr %arg1, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem ashr_proof : ashr_before ⊑ ashr_after := by
  unfold ashr_before ashr_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr
  all_goals (try extract_goal ; sorry)
  ---END ashr


