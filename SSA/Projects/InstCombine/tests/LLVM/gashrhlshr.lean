import SSA.Projects.InstCombine.tests.LLVM.gashrhlshr_proof
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
section gashrhlshr_statements
                                                    
def ashr_known_pos_exact_before := [llvm|
{
^0(%arg23 : i8, %arg24 : i8):
  %0 = "llvm.mlir.constant"() <{value = 127 : i8}> : () -> i8
  %1 = llvm.and %arg23, %0 : i8
  %2 = llvm.ashr %1, %arg24 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def ashr_known_pos_exact_after := [llvm|
{
^0(%arg23 : i8, %arg24 : i8):
  %0 = "llvm.mlir.constant"() <{value = 127 : i8}> : () -> i8
  %1 = llvm.and %arg23, %0 : i8
  %2 = llvm.lshr %1, %arg24 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem ashr_known_pos_exact_proof : ashr_known_pos_exact_before ⊑ ashr_known_pos_exact_after := by
  unfold ashr_known_pos_exact_before ashr_known_pos_exact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_known_pos_exact
  apply ashr_known_pos_exact_thm
  ---END ashr_known_pos_exact



def lshr_mul_times_3_div_2_before := [llvm|
{
^0(%arg20 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.mul %arg20, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_3_div_2_after := [llvm|
{
^0(%arg20 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.lshr %arg20, %0 : i32
  %2 = llvm.add %1, %arg20 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem lshr_mul_times_3_div_2_proof : lshr_mul_times_3_div_2_before ⊑ lshr_mul_times_3_div_2_after := by
  unfold lshr_mul_times_3_div_2_before lshr_mul_times_3_div_2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_mul_times_3_div_2
  apply lshr_mul_times_3_div_2_thm
  ---END lshr_mul_times_3_div_2



def lshr_mul_times_3_div_2_exact_before := [llvm|
{
^0(%arg19 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.mul %arg19, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_3_div_2_exact_after := [llvm|
{
^0(%arg19 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.lshr %arg19, %0 : i32
  %2 = llvm.add %1, %arg19 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem lshr_mul_times_3_div_2_exact_proof : lshr_mul_times_3_div_2_exact_before ⊑ lshr_mul_times_3_div_2_exact_after := by
  unfold lshr_mul_times_3_div_2_exact_before lshr_mul_times_3_div_2_exact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_mul_times_3_div_2_exact
  apply lshr_mul_times_3_div_2_exact_thm
  ---END lshr_mul_times_3_div_2_exact



def lshr_mul_times_3_div_2_exact_2_before := [llvm|
{
^0(%arg16 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.mul %arg16, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_3_div_2_exact_2_after := [llvm|
{
^0(%arg16 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.lshr %arg16, %0 : i32
  %2 = llvm.add %1, %arg16 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem lshr_mul_times_3_div_2_exact_2_proof : lshr_mul_times_3_div_2_exact_2_before ⊑ lshr_mul_times_3_div_2_exact_2_after := by
  unfold lshr_mul_times_3_div_2_exact_2_before lshr_mul_times_3_div_2_exact_2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_mul_times_3_div_2_exact_2
  apply lshr_mul_times_3_div_2_exact_2_thm
  ---END lshr_mul_times_3_div_2_exact_2



def lshr_mul_times_5_div_4_before := [llvm|
{
^0(%arg15 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.mul %arg15, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_5_div_4_after := [llvm|
{
^0(%arg15 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.lshr %arg15, %0 : i32
  %2 = llvm.add %1, %arg15 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem lshr_mul_times_5_div_4_proof : lshr_mul_times_5_div_4_before ⊑ lshr_mul_times_5_div_4_after := by
  unfold lshr_mul_times_5_div_4_before lshr_mul_times_5_div_4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_mul_times_5_div_4
  apply lshr_mul_times_5_div_4_thm
  ---END lshr_mul_times_5_div_4



def lshr_mul_times_5_div_4_exact_before := [llvm|
{
^0(%arg14 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.mul %arg14, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_5_div_4_exact_after := [llvm|
{
^0(%arg14 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.lshr %arg14, %0 : i32
  %2 = llvm.add %1, %arg14 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem lshr_mul_times_5_div_4_exact_proof : lshr_mul_times_5_div_4_exact_before ⊑ lshr_mul_times_5_div_4_exact_after := by
  unfold lshr_mul_times_5_div_4_exact_before lshr_mul_times_5_div_4_exact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_mul_times_5_div_4_exact
  apply lshr_mul_times_5_div_4_exact_thm
  ---END lshr_mul_times_5_div_4_exact



def lshr_mul_times_5_div_4_exact_2_before := [llvm|
{
^0(%arg11 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.mul %arg11, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def lshr_mul_times_5_div_4_exact_2_after := [llvm|
{
^0(%arg11 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.lshr %arg11, %0 : i32
  %2 = llvm.add %1, %arg11 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem lshr_mul_times_5_div_4_exact_2_proof : lshr_mul_times_5_div_4_exact_2_before ⊑ lshr_mul_times_5_div_4_exact_2_after := by
  unfold lshr_mul_times_5_div_4_exact_2_before lshr_mul_times_5_div_4_exact_2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_mul_times_5_div_4_exact_2
  apply lshr_mul_times_5_div_4_exact_2_thm
  ---END lshr_mul_times_5_div_4_exact_2



def ashr_mul_times_3_div_2_before := [llvm|
{
^0(%arg10 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.mul %arg10, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_3_div_2_after := [llvm|
{
^0(%arg10 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.ashr %arg10, %0 : i32
  %2 = llvm.add %1, %arg10 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem ashr_mul_times_3_div_2_proof : ashr_mul_times_3_div_2_before ⊑ ashr_mul_times_3_div_2_after := by
  unfold ashr_mul_times_3_div_2_before ashr_mul_times_3_div_2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_mul_times_3_div_2
  apply ashr_mul_times_3_div_2_thm
  ---END ashr_mul_times_3_div_2



def ashr_mul_times_3_div_2_exact_before := [llvm|
{
^0(%arg9 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.mul %arg9, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_3_div_2_exact_after := [llvm|
{
^0(%arg9 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.ashr %arg9, %0 : i32
  %2 = llvm.add %1, %arg9 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem ashr_mul_times_3_div_2_exact_proof : ashr_mul_times_3_div_2_exact_before ⊑ ashr_mul_times_3_div_2_exact_after := by
  unfold ashr_mul_times_3_div_2_exact_before ashr_mul_times_3_div_2_exact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_mul_times_3_div_2_exact
  apply ashr_mul_times_3_div_2_exact_thm
  ---END ashr_mul_times_3_div_2_exact



def ashr_mul_times_3_div_2_exact_2_before := [llvm|
{
^0(%arg5 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.mul %arg5, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_3_div_2_exact_2_after := [llvm|
{
^0(%arg5 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.ashr %arg5, %0 : i32
  %2 = llvm.add %1, %arg5 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem ashr_mul_times_3_div_2_exact_2_proof : ashr_mul_times_3_div_2_exact_2_before ⊑ ashr_mul_times_3_div_2_exact_2_after := by
  unfold ashr_mul_times_3_div_2_exact_2_before ashr_mul_times_3_div_2_exact_2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_mul_times_3_div_2_exact_2
  apply ashr_mul_times_3_div_2_exact_2_thm
  ---END ashr_mul_times_3_div_2_exact_2



def ashr_mul_times_5_div_4_before := [llvm|
{
^0(%arg4 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.mul %arg4, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_5_div_4_after := [llvm|
{
^0(%arg4 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.ashr %arg4, %0 : i32
  %2 = llvm.add %1, %arg4 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem ashr_mul_times_5_div_4_proof : ashr_mul_times_5_div_4_before ⊑ ashr_mul_times_5_div_4_after := by
  unfold ashr_mul_times_5_div_4_before ashr_mul_times_5_div_4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_mul_times_5_div_4
  apply ashr_mul_times_5_div_4_thm
  ---END ashr_mul_times_5_div_4



def ashr_mul_times_5_div_4_exact_before := [llvm|
{
^0(%arg3 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.mul %arg3, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_5_div_4_exact_after := [llvm|
{
^0(%arg3 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.ashr %arg3, %0 : i32
  %2 = llvm.add %1, %arg3 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem ashr_mul_times_5_div_4_exact_proof : ashr_mul_times_5_div_4_exact_before ⊑ ashr_mul_times_5_div_4_exact_after := by
  unfold ashr_mul_times_5_div_4_exact_before ashr_mul_times_5_div_4_exact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_mul_times_5_div_4_exact
  apply ashr_mul_times_5_div_4_exact_thm
  ---END ashr_mul_times_5_div_4_exact



def ashr_mul_times_5_div_4_exact_2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.mul %arg0, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_mul_times_5_div_4_exact_2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = llvm.ashr %arg0, %0 : i32
  %2 = llvm.add %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem ashr_mul_times_5_div_4_exact_2_proof : ashr_mul_times_5_div_4_exact_2_before ⊑ ashr_mul_times_5_div_4_exact_2_after := by
  unfold ashr_mul_times_5_div_4_exact_2_before ashr_mul_times_5_div_4_exact_2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_mul_times_5_div_4_exact_2
  apply ashr_mul_times_5_div_4_exact_2_thm
  ---END ashr_mul_times_5_div_4_exact_2


