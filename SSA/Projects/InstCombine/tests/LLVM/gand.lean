
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
section gand_statements
                                                    
def test_with_even_before := [llvm|
{
^0(%arg313 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.shl %0, %arg313 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test_with_even_after := [llvm|
{
^0(%arg313 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test_with_even_proof : test_with_even_before ⊑ test_with_even_after := by
  unfold test_with_even_before test_with_even_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test_with_even
  all_goals (try extract_goal ; sorry)
  ---END test_with_even



def test_with_neg_even_before := [llvm|
{
^0(%arg311 : i32):
  %0 = "llvm.mlir.constant"() <{value = -4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.shl %0, %arg311 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test_with_neg_even_after := [llvm|
{
^0(%arg311 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test_with_neg_even_proof : test_with_neg_even_before ⊑ test_with_neg_even_after := by
  unfold test_with_neg_even_before test_with_neg_even_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test_with_neg_even
  all_goals (try extract_goal ; sorry)
  ---END test_with_neg_even



def test1_before := [llvm|
{
^0(%arg309 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  %1 = llvm.and %arg309, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg309 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test2_before := [llvm|
{
^0(%arg308 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.and %arg308, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg308 : i32):
  "llvm.return"(%arg308) : (i32) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test2
  all_goals (try extract_goal ; sorry)
  ---END test2



def test3_before := [llvm|
{
^0(%arg307 : i1):
  %0 = "llvm.mlir.constant"() <{value = false}> : () -> i1
  %1 = llvm.and %arg307, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg307 : i1):
  %0 = "llvm.mlir.constant"() <{value = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test3
  all_goals (try extract_goal ; sorry)
  ---END test3



def test4_before := [llvm|
{
^0(%arg305 : i1):
  %0 = "llvm.mlir.constant"() <{value = true}> : () -> i1
  %1 = llvm.and %arg305, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg305 : i1):
  "llvm.return"(%arg305) : (i1) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test4
  all_goals (try extract_goal ; sorry)
  ---END test4



def test5_before := [llvm|
{
^0(%arg303 : i32):
  %0 = llvm.and %arg303, %arg303 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg303 : i32):
  "llvm.return"(%arg303) : (i32) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test5
  all_goals (try extract_goal ; sorry)
  ---END test5



def test6_before := [llvm|
{
^0(%arg302 : i1):
  %0 = llvm.and %arg302, %arg302 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg302 : i1):
  "llvm.return"(%arg302) : (i1) -> ()
}
]
theorem test6_proof : test6_before ⊑ test6_after := by
  unfold test6_before test6_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test6
  all_goals (try extract_goal ; sorry)
  ---END test6



def test7_before := [llvm|
{
^0(%arg300 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg300, %0 : i32
  %2 = llvm.and %arg300, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg300 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  unfold test7_before test7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test7
  all_goals (try extract_goal ; sorry)
  ---END test7



def test8_before := [llvm|
{
^0(%arg299 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %2 = llvm.and %arg299, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg299 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  unfold test8_before test8_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test8
  all_goals (try extract_goal ; sorry)
  ---END test8



def test10_before := [llvm|
{
^0(%arg296 : i32):
  %0 = "llvm.mlir.constant"() <{value = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 15 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %3 = llvm.and %arg296, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg296 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test10_proof : test10_before ⊑ test10_after := by
  unfold test10_before test10_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test10
  all_goals (try extract_goal ; sorry)
  ---END test10



def test15_before := [llvm|
{
^0(%arg284 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.lshr %arg284, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg284 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem test15_proof : test15_before ⊑ test15_after := by
  unfold test15_before test15_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test15
  all_goals (try extract_goal ; sorry)
  ---END test15



def test16_before := [llvm|
{
^0(%arg283 : i8):
  %0 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = llvm.shl %arg283, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg283 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem test16_proof : test16_before ⊑ test16_after := by
  unfold test16_before test16_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test16
  all_goals (try extract_goal ; sorry)
  ---END test16



def test19_before := [llvm|
{
^0(%arg278 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = llvm.shl %arg278, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg278 : i32):
  %0 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %1 = llvm.shl %arg278, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test19_proof : test19_before ⊑ test19_after := by
  unfold test19_before test19_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test19
  all_goals (try extract_goal ; sorry)
  ---END test19



def test20_before := [llvm|
{
^0(%arg277 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %2 = llvm.lshr %arg277, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test20_after := [llvm|
{
^0(%arg277 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = llvm.lshr %arg277, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem test20_proof : test20_before ⊑ test20_after := by
  unfold test20_before test20_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test20
  all_goals (try extract_goal ; sorry)
  ---END test20



def test27_before := [llvm|
{
^0(%arg268 : i8):
  %0 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = -16 : i8}> : () -> i8
  %3 = llvm.and %arg268, %0 : i8
  %4 = llvm.sub %3, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.add %5, %1 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def test27_after := [llvm|
{
^0(%arg268 : i8):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem test27_proof : test27_before ⊑ test27_after := by
  unfold test27_before test27_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test27
  all_goals (try extract_goal ; sorry)
  ---END test27



def ashr_lowmask_before := [llvm|
{
^0(%arg267 : i32):
  %0 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 255 : i32}> : () -> i32
  %2 = llvm.ashr %arg267, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_lowmask_after := [llvm|
{
^0(%arg267 : i32):
  %0 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %1 = llvm.lshr %arg267, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem ashr_lowmask_proof : ashr_lowmask_before ⊑ ashr_lowmask_after := by
  unfold ashr_lowmask_before ashr_lowmask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN ashr_lowmask
  all_goals (try extract_goal ; sorry)
  ---END ashr_lowmask



def test32_before := [llvm|
{
^0(%arg254 : i32):
  %0 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %3 = llvm.and %arg254, %0 : i32
  %4 = llvm.lshr %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test32_after := [llvm|
{
^0(%arg254 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test32_proof : test32_before ⊑ test32_after := by
  unfold test32_before test32_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test32
  all_goals (try extract_goal ; sorry)
  ---END test32



def test33_before := [llvm|
{
^0(%arg253 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = llvm.and %arg253, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %arg253, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test33_after := [llvm|
{
^0(%arg253 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.xor %arg253, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test33_proof : test33_before ⊑ test33_after := by
  unfold test33_before test33_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test33
  all_goals (try extract_goal ; sorry)
  ---END test33



def test33b_before := [llvm|
{
^0(%arg252 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %2 = llvm.and %arg252, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %arg252, %1 : i32
  %5 = llvm.or %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test33b_after := [llvm|
{
^0(%arg252 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.xor %arg252, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test33b_proof : test33b_before ⊑ test33b_after := by
  unfold test33b_before test33b_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test33b
  all_goals (try extract_goal ; sorry)
  ---END test33b



def test34_before := [llvm|
{
^0(%arg248 : i32, %arg249 : i32):
  %0 = llvm.or %arg249, %arg248 : i32
  %1 = llvm.and %0, %arg249 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test34_after := [llvm|
{
^0(%arg248 : i32, %arg249 : i32):
  "llvm.return"(%arg249) : (i32) -> ()
}
]
theorem test34_proof : test34_before ⊑ test34_after := by
  unfold test34_before test34_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test34
  all_goals (try extract_goal ; sorry)
  ---END test34



def test42_before := [llvm|
{
^0(%arg208 : i32, %arg209 : i32, %arg210 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg209, %arg210 : i32
  %2 = llvm.or %arg208, %1 : i32
  %3 = llvm.xor %arg208, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test42_after := [llvm|
{
^0(%arg208 : i32, %arg209 : i32, %arg210 : i32):
  %0 = llvm.mul %arg209, %arg210 : i32
  %1 = llvm.and %0, %arg208 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test42_proof : test42_before ⊑ test42_after := by
  unfold test42_before test42_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test42
  all_goals (try extract_goal ; sorry)
  ---END test42



def test43_before := [llvm|
{
^0(%arg205 : i32, %arg206 : i32, %arg207 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg206, %arg207 : i32
  %2 = llvm.or %arg205, %1 : i32
  %3 = llvm.xor %arg205, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test43_after := [llvm|
{
^0(%arg205 : i32, %arg206 : i32, %arg207 : i32):
  %0 = llvm.mul %arg206, %arg207 : i32
  %1 = llvm.and %0, %arg205 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test43_proof : test43_before ⊑ test43_after := by
  unfold test43_before test43_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test43
  all_goals (try extract_goal ; sorry)
  ---END test43



def test44_before := [llvm|
{
^0(%arg203 : i32, %arg204 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg204, %0 : i32
  %2 = llvm.or %1, %arg203 : i32
  %3 = llvm.and %2, %arg204 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test44_after := [llvm|
{
^0(%arg203 : i32, %arg204 : i32):
  %0 = llvm.and %arg203, %arg204 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test44_proof : test44_before ⊑ test44_after := by
  unfold test44_before test44_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test44
  all_goals (try extract_goal ; sorry)
  ---END test44



def test45_before := [llvm|
{
^0(%arg201 : i32, %arg202 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg202, %0 : i32
  %2 = llvm.or %arg201, %1 : i32
  %3 = llvm.and %2, %arg202 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test45_after := [llvm|
{
^0(%arg201 : i32, %arg202 : i32):
  %0 = llvm.and %arg201, %arg202 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test45_proof : test45_before ⊑ test45_after := by
  unfold test45_before test45_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test45
  all_goals (try extract_goal ; sorry)
  ---END test45



def test46_before := [llvm|
{
^0(%arg199 : i32, %arg200 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg200, %0 : i32
  %2 = llvm.or %1, %arg199 : i32
  %3 = llvm.and %arg200, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test46_after := [llvm|
{
^0(%arg199 : i32, %arg200 : i32):
  %0 = llvm.and %arg200, %arg199 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test46_proof : test46_before ⊑ test46_after := by
  unfold test46_before test46_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test46
  all_goals (try extract_goal ; sorry)
  ---END test46



def test47_before := [llvm|
{
^0(%arg197 : i32, %arg198 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg198, %0 : i32
  %2 = llvm.or %arg197, %1 : i32
  %3 = llvm.and %arg198, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test47_after := [llvm|
{
^0(%arg197 : i32, %arg198 : i32):
  %0 = llvm.and %arg198, %arg197 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test47_proof : test47_before ⊑ test47_after := by
  unfold test47_before test47_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test47
  all_goals (try extract_goal ; sorry)
  ---END test47



def lowmask_add_2_before := [llvm|
{
^0(%arg144 : i8):
  %0 = "llvm.mlir.constant"() <{value = -64 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 63 : i8}> : () -> i8
  %2 = llvm.add %arg144, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def lowmask_add_2_after := [llvm|
{
^0(%arg144 : i8):
  %0 = "llvm.mlir.constant"() <{value = 63 : i8}> : () -> i8
  %1 = llvm.and %arg144, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem lowmask_add_2_proof : lowmask_add_2_before ⊑ lowmask_add_2_after := by
  unfold lowmask_add_2_before lowmask_add_2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lowmask_add_2
  all_goals (try extract_goal ; sorry)
  ---END lowmask_add_2



def flip_masked_bit_before := [llvm|
{
^0(%arg132 : i8):
  %0 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %1 = llvm.add %arg132, %0 : i8
  %2 = llvm.and %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def flip_masked_bit_after := [llvm|
{
^0(%arg132 : i8):
  %0 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %1 = llvm.and %arg132, %0 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem flip_masked_bit_proof : flip_masked_bit_before ⊑ flip_masked_bit_after := by
  unfold flip_masked_bit_before flip_masked_bit_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN flip_masked_bit
  all_goals (try extract_goal ; sorry)
  ---END flip_masked_bit



def not_ashr_not_bitwidth_mask_before := [llvm|
{
^0(%arg97 : i8, %arg98 : i8):
  %0 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.ashr %arg97, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.and %3, %arg98 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def not_ashr_not_bitwidth_mask_after := [llvm|
{
^0(%arg97 : i8, %arg98 : i8):
  %0 = "llvm.mlir.constant"() <{value = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.ashr %arg97, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.and %arg98, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem not_ashr_not_bitwidth_mask_proof : not_ashr_not_bitwidth_mask_before ⊑ not_ashr_not_bitwidth_mask_after := by
  unfold not_ashr_not_bitwidth_mask_before not_ashr_not_bitwidth_mask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN not_ashr_not_bitwidth_mask
  all_goals (try extract_goal ; sorry)
  ---END not_ashr_not_bitwidth_mask



def not_lshr_bitwidth_mask_before := [llvm|
{
^0(%arg95 : i8, %arg96 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.lshr %arg95, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.and %3, %arg96 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def not_lshr_bitwidth_mask_after := [llvm|
{
^0(%arg95 : i8, %arg96 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.lshr %arg95, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.and %arg96, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem not_lshr_bitwidth_mask_proof : not_lshr_bitwidth_mask_before ⊑ not_lshr_bitwidth_mask_after := by
  unfold not_lshr_bitwidth_mask_before not_lshr_bitwidth_mask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN not_lshr_bitwidth_mask
  all_goals (try extract_goal ; sorry)
  ---END not_lshr_bitwidth_mask



def shl_lshr_pow2_const_negative_overflow1_before := [llvm|
{
^0(%arg70 : i16):
  %0 = "llvm.mlir.constant"() <{value = 4096 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 6 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{value = 8 : i16}> : () -> i16
  %3 = llvm.shl %0, %arg70 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def shl_lshr_pow2_const_negative_overflow1_after := [llvm|
{
^0(%arg70 : i16):
  %0 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
  "llvm.return"(%0) : (i16) -> ()
}
]
theorem shl_lshr_pow2_const_negative_overflow1_proof : shl_lshr_pow2_const_negative_overflow1_before ⊑ shl_lshr_pow2_const_negative_overflow1_after := by
  unfold shl_lshr_pow2_const_negative_overflow1_before shl_lshr_pow2_const_negative_overflow1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_lshr_pow2_const_negative_overflow1
  all_goals (try extract_goal ; sorry)
  ---END shl_lshr_pow2_const_negative_overflow1



def shl_lshr_pow2_const_negative_overflow2_before := [llvm|
{
^0(%arg69 : i16):
  %0 = "llvm.mlir.constant"() <{value = 8 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 6 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{value = -32768 : i16}> : () -> i16
  %3 = llvm.shl %0, %arg69 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def shl_lshr_pow2_const_negative_overflow2_after := [llvm|
{
^0(%arg69 : i16):
  %0 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
  "llvm.return"(%0) : (i16) -> ()
}
]
theorem shl_lshr_pow2_const_negative_overflow2_proof : shl_lshr_pow2_const_negative_overflow2_before ⊑ shl_lshr_pow2_const_negative_overflow2_after := by
  unfold shl_lshr_pow2_const_negative_overflow2_before shl_lshr_pow2_const_negative_overflow2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN shl_lshr_pow2_const_negative_overflow2
  all_goals (try extract_goal ; sorry)
  ---END shl_lshr_pow2_const_negative_overflow2



def lshr_lshr_pow2_const_negative_nopow2_1_before := [llvm|
{
^0(%arg63 : i16):
  %0 = "llvm.mlir.constant"() <{value = 2047 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 6 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{value = 4 : i16}> : () -> i16
  %3 = llvm.lshr %0, %arg63 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def lshr_lshr_pow2_const_negative_nopow2_1_after := [llvm|
{
^0(%arg63 : i16):
  %0 = "llvm.mlir.constant"() <{value = 31 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 4 : i16}> : () -> i16
  %2 = llvm.lshr %0, %arg63 : i16
  %3 = llvm.and %2, %1 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
theorem lshr_lshr_pow2_const_negative_nopow2_1_proof : lshr_lshr_pow2_const_negative_nopow2_1_before ⊑ lshr_lshr_pow2_const_negative_nopow2_1_after := by
  unfold lshr_lshr_pow2_const_negative_nopow2_1_before lshr_lshr_pow2_const_negative_nopow2_1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_lshr_pow2_const_negative_nopow2_1
  all_goals (try extract_goal ; sorry)
  ---END lshr_lshr_pow2_const_negative_nopow2_1



def lshr_lshr_pow2_const_negative_nopow2_2_before := [llvm|
{
^0(%arg62 : i16):
  %0 = "llvm.mlir.constant"() <{value = 8192 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 6 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{value = 3 : i16}> : () -> i16
  %3 = llvm.lshr %0, %arg62 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def lshr_lshr_pow2_const_negative_nopow2_2_after := [llvm|
{
^0(%arg62 : i16):
  %0 = "llvm.mlir.constant"() <{value = 128 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 3 : i16}> : () -> i16
  %2 = llvm.lshr %0, %arg62 : i16
  %3 = llvm.and %2, %1 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
theorem lshr_lshr_pow2_const_negative_nopow2_2_proof : lshr_lshr_pow2_const_negative_nopow2_2_before ⊑ lshr_lshr_pow2_const_negative_nopow2_2_after := by
  unfold lshr_lshr_pow2_const_negative_nopow2_2_before lshr_lshr_pow2_const_negative_nopow2_2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_lshr_pow2_const_negative_nopow2_2
  all_goals (try extract_goal ; sorry)
  ---END lshr_lshr_pow2_const_negative_nopow2_2



def lshr_lshr_pow2_const_negative_overflow_before := [llvm|
{
^0(%arg61 : i16):
  %0 = "llvm.mlir.constant"() <{value = -32768 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 15 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{value = 4 : i16}> : () -> i16
  %3 = llvm.lshr %0, %arg61 : i16
  %4 = llvm.lshr %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def lshr_lshr_pow2_const_negative_overflow_after := [llvm|
{
^0(%arg61 : i16):
  %0 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
  "llvm.return"(%0) : (i16) -> ()
}
]
theorem lshr_lshr_pow2_const_negative_overflow_proof : lshr_lshr_pow2_const_negative_overflow_before ⊑ lshr_lshr_pow2_const_negative_overflow_after := by
  unfold lshr_lshr_pow2_const_negative_overflow_before lshr_lshr_pow2_const_negative_overflow_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_lshr_pow2_const_negative_overflow
  all_goals (try extract_goal ; sorry)
  ---END lshr_lshr_pow2_const_negative_overflow



def lshr_shl_pow2_const_overflow_before := [llvm|
{
^0(%arg57 : i16):
  %0 = "llvm.mlir.constant"() <{value = 8192 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 6 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{value = 32 : i16}> : () -> i16
  %3 = llvm.lshr %0, %arg57 : i16
  %4 = llvm.shl %3, %1 : i16
  %5 = llvm.and %4, %2 : i16
  "llvm.return"(%5) : (i16) -> ()
}
]
def lshr_shl_pow2_const_overflow_after := [llvm|
{
^0(%arg57 : i16):
  %0 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
  "llvm.return"(%0) : (i16) -> ()
}
]
theorem lshr_shl_pow2_const_overflow_proof : lshr_shl_pow2_const_overflow_before ⊑ lshr_shl_pow2_const_overflow_after := by
  unfold lshr_shl_pow2_const_overflow_before lshr_shl_pow2_const_overflow_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN lshr_shl_pow2_const_overflow
  all_goals (try extract_goal ; sorry)
  ---END lshr_shl_pow2_const_overflow



def add_constant_equal_with_the_top_bit_of_demandedbits_pass_before := [llvm|
{
^0(%arg9 : i32):
  %0 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %2 = llvm.add %arg9, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_constant_equal_with_the_top_bit_of_demandedbits_pass_after := [llvm|
{
^0(%arg9 : i32):
  %0 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %2 = llvm.and %arg9, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem add_constant_equal_with_the_top_bit_of_demandedbits_pass_proof : add_constant_equal_with_the_top_bit_of_demandedbits_pass_before ⊑ add_constant_equal_with_the_top_bit_of_demandedbits_pass_after := by
  unfold add_constant_equal_with_the_top_bit_of_demandedbits_pass_before add_constant_equal_with_the_top_bit_of_demandedbits_pass_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN add_constant_equal_with_the_top_bit_of_demandedbits_pass
  all_goals (try extract_goal ; sorry)
  ---END add_constant_equal_with_the_top_bit_of_demandedbits_pass



def add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %2 = llvm.add %arg4, %0 : i32
  %3 = llvm.or %2, %arg5 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
  %2 = llvm.xor %arg4, %0 : i32
  %3 = llvm.or %2, %arg5 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_proof : add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_before ⊑ add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_after := by
  unfold add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_before add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN add_constant_equal_with_the_top_bit_of_demandedbits_insertpt
  all_goals (try extract_goal ; sorry)
  ---END add_constant_equal_with_the_top_bit_of_demandedbits_insertpt


