
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
section gorhxor_statements

def test1_before := [llvm|
{
^0(%arg232 : i32, %arg233 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg232, %arg233 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg232, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg232 : i32, %arg233 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg233, %0 : i32
  %2 = llvm.or %arg232, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test2_before := [llvm|
{
^0(%arg230 : i32, %arg231 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg230, %arg231 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg231, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg230 : i32, %arg231 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg230, %0 : i32
  %2 = llvm.or %arg231, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  intros
  ---BEGIN test2
  all_goals (try extract_goal ; sorry)
  ---END test2



def test3_before := [llvm|
{
^0(%arg228 : i32, %arg229 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg228, %arg229 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg228, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg228 : i32, %arg229 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg229, %0 : i32
  %2 = llvm.or %arg228, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  intros
  ---BEGIN test3
  all_goals (try extract_goal ; sorry)
  ---END test3



def test4_before := [llvm|
{
^0(%arg226 : i32, %arg227 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg226, %arg227 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg227, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg226 : i32, %arg227 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg226, %0 : i32
  %2 = llvm.or %arg227, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  intros
  ---BEGIN test4
  all_goals (try extract_goal ; sorry)
  ---END test4



def test5_before := [llvm|
{
^0(%arg224 : i32, %arg225 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg224, %arg225 : i32
  %2 = llvm.xor %arg224, %0 : i32
  %3 = llvm.or %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg224 : i32, %arg225 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg224, %arg225 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  intros
  ---BEGIN test5
  all_goals (try extract_goal ; sorry)
  ---END test5



def test5_commuted_x_y_before := [llvm|
{
^0(%arg220 : i64, %arg221 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.xor %arg221, %arg220 : i64
  %2 = llvm.xor %arg220, %0 : i64
  %3 = llvm.or %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test5_commuted_x_y_after := [llvm|
{
^0(%arg220 : i64, %arg221 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.and %arg221, %arg220 : i64
  %2 = llvm.xor %1, %0 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test5_commuted_x_y_proof : test5_commuted_x_y_before ⊑ test5_commuted_x_y_after := by
  unfold test5_commuted_x_y_before test5_commuted_x_y_after
  simp_alive_peephole
  intros
  ---BEGIN test5_commuted_x_y
  all_goals (try extract_goal ; sorry)
  ---END test5_commuted_x_y



def xor_common_op_commute0_before := [llvm|
{
^0(%arg208 : i8, %arg209 : i8):
  %0 = llvm.xor %arg208, %arg209 : i8
  %1 = llvm.or %0, %arg208 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def xor_common_op_commute0_after := [llvm|
{
^0(%arg208 : i8, %arg209 : i8):
  %0 = llvm.or %arg209, %arg208 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_common_op_commute0_proof : xor_common_op_commute0_before ⊑ xor_common_op_commute0_after := by
  unfold xor_common_op_commute0_before xor_common_op_commute0_after
  simp_alive_peephole
  intros
  ---BEGIN xor_common_op_commute0
  all_goals (try extract_goal ; sorry)
  ---END xor_common_op_commute0



def xor_common_op_commute2_before := [llvm|
{
^0(%arg204 : i8, %arg205 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.xor %arg204, %0 : i8
  %2 = llvm.xor %1, %arg205 : i8
  %3 = llvm.or %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def xor_common_op_commute2_after := [llvm|
{
^0(%arg204 : i8, %arg205 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.xor %arg204, %0 : i8
  %2 = llvm.or %1, %arg205 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_common_op_commute2_proof : xor_common_op_commute2_before ⊑ xor_common_op_commute2_after := by
  unfold xor_common_op_commute2_before xor_common_op_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN xor_common_op_commute2
  all_goals (try extract_goal ; sorry)
  ---END xor_common_op_commute2



def xor_common_op_commute3_before := [llvm|
{
^0(%arg202 : i8, %arg203 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.xor %arg202, %0 : i8
  %2 = llvm.mul %arg203, %arg203 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_common_op_commute3_after := [llvm|
{
^0(%arg202 : i8, %arg203 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.xor %arg202, %0 : i8
  %2 = llvm.mul %arg203, %arg203 : i8
  %3 = llvm.or %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_common_op_commute3_proof : xor_common_op_commute3_before ⊑ xor_common_op_commute3_after := by
  unfold xor_common_op_commute3_before xor_common_op_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN xor_common_op_commute3
  all_goals (try extract_goal ; sorry)
  ---END xor_common_op_commute3



def test8_before := [llvm|
{
^0(%arg200 : i32, %arg201 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg201, %0 : i32
  %2 = llvm.xor %arg200, %1 : i32
  %3 = llvm.or %arg201, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg200 : i32, %arg201 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg200, %0 : i32
  %2 = llvm.or %arg201, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test8_proof : test8_before ⊑ test8_after := by
  unfold test8_before test8_after
  simp_alive_peephole
  intros
  ---BEGIN test8
  all_goals (try extract_goal ; sorry)
  ---END test8



def test9_before := [llvm|
{
^0(%arg198 : i32, %arg199 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg198, %0 : i32
  %2 = llvm.xor %1, %arg199 : i32
  %3 = llvm.or %arg198, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg198 : i32, %arg199 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg199, %0 : i32
  %2 = llvm.or %arg198, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  intros
  ---BEGIN test9
  all_goals (try extract_goal ; sorry)
  ---END test9



def test10_before := [llvm|
{
^0(%arg196 : i32, %arg197 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg197, %arg196 : i32
  %2 = llvm.xor %arg196, %0 : i32
  %3 = llvm.xor %2, %arg197 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg196 : i32, %arg197 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg197, %arg196 : i32
  %2 = llvm.xor %arg196, %arg197 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test10_proof : test10_before ⊑ test10_after := by
  unfold test10_before test10_after
  simp_alive_peephole
  intros
  ---BEGIN test10
  all_goals (try extract_goal ; sorry)
  ---END test10



def test10_commuted_before := [llvm|
{
^0(%arg194 : i32, %arg195 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg195, %arg194 : i32
  %2 = llvm.xor %arg194, %0 : i32
  %3 = llvm.xor %2, %arg195 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test10_commuted_after := [llvm|
{
^0(%arg194 : i32, %arg195 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg195, %arg194 : i32
  %2 = llvm.xor %arg194, %arg195 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test10_commuted_proof : test10_commuted_before ⊑ test10_commuted_after := by
  unfold test10_commuted_before test10_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN test10_commuted
  all_goals (try extract_goal ; sorry)
  ---END test10_commuted



def test11_before := [llvm|
{
^0(%arg184 : i32, %arg185 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg184, %arg185 : i32
  %2 = llvm.xor %arg184, %0 : i32
  %3 = llvm.xor %2, %arg185 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg184 : i32, %arg185 : i32):
  %0 = llvm.and %arg185, %arg184 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test11_proof : test11_before ⊑ test11_after := by
  unfold test11_before test11_after
  simp_alive_peephole
  intros
  ---BEGIN test11
  all_goals (try extract_goal ; sorry)
  ---END test11



def test12_before := [llvm|
{
^0(%arg182 : i32, %arg183 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg182, %0 : i32
  %2 = llvm.xor %1, %arg183 : i32
  %3 = llvm.or %arg182, %arg183 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg182 : i32, %arg183 : i32):
  %0 = llvm.and %arg183, %arg182 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test12_proof : test12_before ⊑ test12_after := by
  unfold test12_before test12_after
  simp_alive_peephole
  intros
  ---BEGIN test12
  all_goals (try extract_goal ; sorry)
  ---END test12



def test12_commuted_before := [llvm|
{
^0(%arg180 : i32, %arg181 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg180, %0 : i32
  %2 = llvm.xor %1, %arg181 : i32
  %3 = llvm.or %arg181, %arg180 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test12_commuted_after := [llvm|
{
^0(%arg180 : i32, %arg181 : i32):
  %0 = llvm.and %arg181, %arg180 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test12_commuted_proof : test12_commuted_before ⊑ test12_commuted_after := by
  unfold test12_commuted_before test12_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN test12_commuted
  all_goals (try extract_goal ; sorry)
  ---END test12_commuted



def test13_before := [llvm|
{
^0(%arg178 : i32, %arg179 : i32):
  %0 = llvm.xor %arg179, %arg178 : i32
  %1 = llvm.or %arg179, %arg178 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg178 : i32, %arg179 : i32):
  %0 = llvm.and %arg178, %arg179 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  intros
  ---BEGIN test13
  all_goals (try extract_goal ; sorry)
  ---END test13



def test14_before := [llvm|
{
^0(%arg176 : i32, %arg177 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg177, %0 : i32
  %2 = llvm.xor %arg176, %0 : i32
  %3 = llvm.or %arg176, %1 : i32
  %4 = llvm.or %2, %arg177 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg176 : i32, %arg177 : i32):
  %0 = llvm.xor %arg176, %arg177 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test14_proof : test14_before ⊑ test14_after := by
  unfold test14_before test14_after
  simp_alive_peephole
  intros
  ---BEGIN test14
  all_goals (try extract_goal ; sorry)
  ---END test14



def test14_commuted_before := [llvm|
{
^0(%arg174 : i32, %arg175 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg175, %0 : i32
  %2 = llvm.xor %arg174, %0 : i32
  %3 = llvm.or %1, %arg174 : i32
  %4 = llvm.or %2, %arg175 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test14_commuted_after := [llvm|
{
^0(%arg174 : i32, %arg175 : i32):
  %0 = llvm.xor %arg174, %arg175 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test14_commuted_proof : test14_commuted_before ⊑ test14_commuted_after := by
  unfold test14_commuted_before test14_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN test14_commuted
  all_goals (try extract_goal ; sorry)
  ---END test14_commuted



def test15_before := [llvm|
{
^0(%arg172 : i32, %arg173 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg173, %0 : i32
  %2 = llvm.xor %arg172, %0 : i32
  %3 = llvm.and %arg172, %1 : i32
  %4 = llvm.and %2, %arg173 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg172 : i32, %arg173 : i32):
  %0 = llvm.xor %arg172, %arg173 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15_proof : test15_before ⊑ test15_after := by
  unfold test15_before test15_after
  simp_alive_peephole
  intros
  ---BEGIN test15
  all_goals (try extract_goal ; sorry)
  ---END test15



def test15_commuted_before := [llvm|
{
^0(%arg170 : i32, %arg171 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg171, %0 : i32
  %2 = llvm.xor %arg170, %0 : i32
  %3 = llvm.and %1, %arg170 : i32
  %4 = llvm.and %2, %arg171 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test15_commuted_after := [llvm|
{
^0(%arg170 : i32, %arg171 : i32):
  %0 = llvm.xor %arg170, %arg171 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15_commuted_proof : test15_commuted_before ⊑ test15_commuted_after := by
  unfold test15_commuted_before test15_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN test15_commuted
  all_goals (try extract_goal ; sorry)
  ---END test15_commuted



def or_and_xor_not_constant_commute0_before := [llvm|
{
^0(%arg168 : i32, %arg169 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.xor %arg168, %arg169 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.and %arg169, %1 : i32
  %5 = llvm.or %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def or_and_xor_not_constant_commute0_after := [llvm|
{
^0(%arg168 : i32, %arg169 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.and %arg168, %0 : i32
  %2 = llvm.xor %1, %arg169 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_xor_not_constant_commute0_proof : or_and_xor_not_constant_commute0_before ⊑ or_and_xor_not_constant_commute0_after := by
  unfold or_and_xor_not_constant_commute0_before or_and_xor_not_constant_commute0_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_xor_not_constant_commute0
  all_goals (try extract_goal ; sorry)
  ---END or_and_xor_not_constant_commute0



def or_and_xor_not_constant_commute1_before := [llvm|
{
^0(%arg166 : i9, %arg167 : i9):
  %0 = llvm.mlir.constant(42 : i9) : i9
  %1 = llvm.mlir.constant(-43 : i9) : i9
  %2 = llvm.xor %arg167, %arg166 : i9
  %3 = llvm.and %2, %0 : i9
  %4 = llvm.and %arg167, %1 : i9
  %5 = llvm.or %3, %4 : i9
  "llvm.return"(%5) : (i9) -> ()
}
]
def or_and_xor_not_constant_commute1_after := [llvm|
{
^0(%arg166 : i9, %arg167 : i9):
  %0 = llvm.mlir.constant(42 : i9) : i9
  %1 = llvm.and %arg166, %0 : i9
  %2 = llvm.xor %1, %arg167 : i9
  "llvm.return"(%2) : (i9) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_and_xor_not_constant_commute1_proof : or_and_xor_not_constant_commute1_before ⊑ or_and_xor_not_constant_commute1_after := by
  unfold or_and_xor_not_constant_commute1_before or_and_xor_not_constant_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN or_and_xor_not_constant_commute1
  all_goals (try extract_goal ; sorry)
  ---END or_and_xor_not_constant_commute1



def not_or_xor_before := [llvm|
{
^0(%arg160 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.mlir.constant(12 : i8) : i8
  %3 = llvm.xor %arg160, %0 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.xor %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def not_or_xor_after := [llvm|
{
^0(%arg160 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.mlir.constant(-13 : i8) : i8
  %2 = llvm.and %arg160, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_or_xor_proof : not_or_xor_before ⊑ not_or_xor_after := by
  unfold not_or_xor_before not_or_xor_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_xor
  all_goals (try extract_goal ; sorry)
  ---END not_or_xor



def xor_or_before := [llvm|
{
^0(%arg159 : i8):
  %0 = llvm.mlir.constant(32 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.xor %arg159, %0 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def xor_or_after := [llvm|
{
^0(%arg159 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.mlir.constant(39 : i8) : i8
  %2 = llvm.and %arg159, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_or_proof : xor_or_before ⊑ xor_or_after := by
  unfold xor_or_before xor_or_after
  simp_alive_peephole
  intros
  ---BEGIN xor_or
  all_goals (try extract_goal ; sorry)
  ---END xor_or



def xor_or2_before := [llvm|
{
^0(%arg158 : i8):
  %0 = llvm.mlir.constant(33 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.xor %arg158, %0 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def xor_or2_after := [llvm|
{
^0(%arg158 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.mlir.constant(39 : i8) : i8
  %2 = llvm.and %arg158, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_or2_proof : xor_or2_before ⊑ xor_or2_after := by
  unfold xor_or2_before xor_or2_after
  simp_alive_peephole
  intros
  ---BEGIN xor_or2
  all_goals (try extract_goal ; sorry)
  ---END xor_or2



def xor_or_xor_before := [llvm|
{
^0(%arg157 : i8):
  %0 = llvm.mlir.constant(33 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.mlir.constant(12 : i8) : i8
  %3 = llvm.xor %arg157, %0 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.xor %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def xor_or_xor_after := [llvm|
{
^0(%arg157 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.mlir.constant(43 : i8) : i8
  %2 = llvm.and %arg157, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_or_xor_proof : xor_or_xor_before ⊑ xor_or_xor_after := by
  unfold xor_or_xor_before xor_or_xor_after
  simp_alive_peephole
  intros
  ---BEGIN xor_or_xor
  all_goals (try extract_goal ; sorry)
  ---END xor_or_xor



def or_xor_or_before := [llvm|
{
^0(%arg156 : i8):
  %0 = llvm.mlir.constant(33 : i8) : i8
  %1 = llvm.mlir.constant(12 : i8) : i8
  %2 = llvm.mlir.constant(7 : i8) : i8
  %3 = llvm.or %arg156, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def or_xor_or_after := [llvm|
{
^0(%arg156 : i8):
  %0 = llvm.mlir.constant(-40 : i8) : i8
  %1 = llvm.mlir.constant(47 : i8) : i8
  %2 = llvm.and %arg156, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_or_proof : or_xor_or_before ⊑ or_xor_or_after := by
  unfold or_xor_or_before or_xor_or_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_or
  all_goals (try extract_goal ; sorry)
  ---END or_xor_or



def test17_before := [llvm|
{
^0(%arg154 : i8, %arg155 : i8):
  %0 = llvm.mlir.constant(33 : i8) : i8
  %1 = llvm.xor %arg155, %arg154 : i8
  %2 = llvm.xor %arg154, %0 : i8
  %3 = llvm.xor %2, %arg155 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def test17_after := [llvm|
{
^0(%arg154 : i8, %arg155 : i8):
  %0 = llvm.mlir.constant(33 : i8) : i8
  %1 = llvm.xor %arg155, %arg154 : i8
  %2 = llvm.xor %arg154, %arg155 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test17_proof : test17_before ⊑ test17_after := by
  unfold test17_before test17_after
  simp_alive_peephole
  intros
  ---BEGIN test17
  all_goals (try extract_goal ; sorry)
  ---END test17



def test18_before := [llvm|
{
^0(%arg152 : i8, %arg153 : i8):
  %0 = llvm.mlir.constant(33 : i8) : i8
  %1 = llvm.xor %arg153, %arg152 : i8
  %2 = llvm.xor %arg152, %0 : i8
  %3 = llvm.xor %2, %arg153 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg152 : i8, %arg153 : i8):
  %0 = llvm.mlir.constant(33 : i8) : i8
  %1 = llvm.xor %arg153, %arg152 : i8
  %2 = llvm.xor %arg152, %arg153 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test18_proof : test18_before ⊑ test18_after := by
  unfold test18_before test18_after
  simp_alive_peephole
  intros
  ---BEGIN test18
  all_goals (try extract_goal ; sorry)
  ---END test18



def test19_before := [llvm|
{
^0(%arg150 : i32, %arg151 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg151, %0 : i32
  %2 = llvm.xor %arg150, %0 : i32
  %3 = llvm.or %arg150, %arg151 : i32
  %4 = llvm.or %2, %1 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg150 : i32, %arg151 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg150, %arg151 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test19_proof : test19_before ⊑ test19_after := by
  unfold test19_before test19_after
  simp_alive_peephole
  intros
  ---BEGIN test19
  all_goals (try extract_goal ; sorry)
  ---END test19



def test20_before := [llvm|
{
^0(%arg148 : i32, %arg149 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg149, %0 : i32
  %2 = llvm.xor %arg148, %0 : i32
  %3 = llvm.or %arg148, %arg149 : i32
  %4 = llvm.or %1, %2 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test20_after := [llvm|
{
^0(%arg148 : i32, %arg149 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg148, %arg149 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test20_proof : test20_before ⊑ test20_after := by
  unfold test20_before test20_after
  simp_alive_peephole
  intros
  ---BEGIN test20
  all_goals (try extract_goal ; sorry)
  ---END test20



def test21_before := [llvm|
{
^0(%arg146 : i32, %arg147 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg147, %0 : i32
  %2 = llvm.xor %arg146, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = llvm.or %arg146, %arg147 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test21_after := [llvm|
{
^0(%arg146 : i32, %arg147 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg146, %arg147 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test21_proof : test21_before ⊑ test21_after := by
  unfold test21_before test21_after
  simp_alive_peephole
  intros
  ---BEGIN test21
  all_goals (try extract_goal ; sorry)
  ---END test21



def test22_before := [llvm|
{
^0(%arg144 : i32, %arg145 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg145, %0 : i32
  %2 = llvm.xor %arg144, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = llvm.or %arg145, %arg144 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test22_after := [llvm|
{
^0(%arg144 : i32, %arg145 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg145, %arg144 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test22_proof : test22_before ⊑ test22_after := by
  unfold test22_before test22_after
  simp_alive_peephole
  intros
  ---BEGIN test22
  all_goals (try extract_goal ; sorry)
  ---END test22



def test23_before := [llvm|
{
^0(%arg143 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.mlir.constant(13 : i8) : i8
  %2 = llvm.mlir.constant(1 : i8) : i8
  %3 = llvm.mlir.constant(12 : i8) : i8
  %4 = llvm.or %arg143, %0 : i8
  %5 = llvm.xor %4, %1 : i8
  %6 = llvm.or %5, %2 : i8
  %7 = llvm.xor %6, %3 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def test23_after := [llvm|
{
^0(%arg143 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test23_proof : test23_before ⊑ test23_after := by
  unfold test23_before test23_after
  simp_alive_peephole
  intros
  ---BEGIN test23
  all_goals (try extract_goal ; sorry)
  ---END test23



def PR45977_f1_before := [llvm|
{
^0(%arg140 : i32, %arg141 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg140, %0 : i32
  %2 = llvm.and %1, %arg141 : i32
  %3 = llvm.or %arg140, %arg141 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def PR45977_f1_after := [llvm|
{
^0(%arg140 : i32, %arg141 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg140, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR45977_f1_proof : PR45977_f1_before ⊑ PR45977_f1_after := by
  unfold PR45977_f1_before PR45977_f1_after
  simp_alive_peephole
  intros
  ---BEGIN PR45977_f1
  all_goals (try extract_goal ; sorry)
  ---END PR45977_f1



def PR45977_f2_before := [llvm|
{
^0(%arg138 : i32, %arg139 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg138, %arg139 : i32
  %2 = llvm.xor %arg139, %0 : i32
  %3 = llvm.or %arg138, %2 : i32
  %4 = llvm.xor %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def PR45977_f2_after := [llvm|
{
^0(%arg138 : i32, %arg139 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg138, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR45977_f2_proof : PR45977_f2_before ⊑ PR45977_f2_after := by
  unfold PR45977_f2_before PR45977_f2_after
  simp_alive_peephole
  intros
  ---BEGIN PR45977_f2
  all_goals (try extract_goal ; sorry)
  ---END PR45977_f2



def or_xor_common_op_commute0_before := [llvm|
{
^0(%arg135 : i8, %arg136 : i8, %arg137 : i8):
  %0 = llvm.or %arg135, %arg136 : i8
  %1 = llvm.xor %arg135, %arg137 : i8
  %2 = llvm.or %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def or_xor_common_op_commute0_after := [llvm|
{
^0(%arg135 : i8, %arg136 : i8, %arg137 : i8):
  %0 = llvm.or %arg135, %arg136 : i8
  %1 = llvm.or %0, %arg137 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_common_op_commute0_proof : or_xor_common_op_commute0_before ⊑ or_xor_common_op_commute0_after := by
  unfold or_xor_common_op_commute0_before or_xor_common_op_commute0_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_common_op_commute0
  all_goals (try extract_goal ; sorry)
  ---END or_xor_common_op_commute0



def or_xor_common_op_commute5_before := [llvm|
{
^0(%arg120 : i8, %arg121 : i8, %arg122 : i8):
  %0 = llvm.or %arg121, %arg120 : i8
  %1 = llvm.xor %arg120, %arg122 : i8
  %2 = llvm.or %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def or_xor_common_op_commute5_after := [llvm|
{
^0(%arg120 : i8, %arg121 : i8, %arg122 : i8):
  %0 = llvm.or %arg121, %arg120 : i8
  %1 = llvm.or %0, %arg122 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_common_op_commute5_proof : or_xor_common_op_commute5_before ⊑ or_xor_common_op_commute5_after := by
  unfold or_xor_common_op_commute5_before or_xor_common_op_commute5_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_common_op_commute5
  all_goals (try extract_goal ; sorry)
  ---END or_xor_common_op_commute5



def or_xor_common_op_commute6_before := [llvm|
{
^0(%arg117 : i8, %arg118 : i8, %arg119 : i8):
  %0 = llvm.or %arg117, %arg118 : i8
  %1 = llvm.xor %arg119, %arg117 : i8
  %2 = llvm.or %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def or_xor_common_op_commute6_after := [llvm|
{
^0(%arg117 : i8, %arg118 : i8, %arg119 : i8):
  %0 = llvm.or %arg117, %arg118 : i8
  %1 = llvm.or %0, %arg119 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_common_op_commute6_proof : or_xor_common_op_commute6_before ⊑ or_xor_common_op_commute6_after := by
  unfold or_xor_common_op_commute6_before or_xor_common_op_commute6_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_common_op_commute6
  all_goals (try extract_goal ; sorry)
  ---END or_xor_common_op_commute6



def or_xor_common_op_commute7_before := [llvm|
{
^0(%arg114 : i8, %arg115 : i8, %arg116 : i8):
  %0 = llvm.or %arg115, %arg114 : i8
  %1 = llvm.xor %arg116, %arg114 : i8
  %2 = llvm.or %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def or_xor_common_op_commute7_after := [llvm|
{
^0(%arg114 : i8, %arg115 : i8, %arg116 : i8):
  %0 = llvm.or %arg115, %arg114 : i8
  %1 = llvm.or %0, %arg116 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_common_op_commute7_proof : or_xor_common_op_commute7_before ⊑ or_xor_common_op_commute7_after := by
  unfold or_xor_common_op_commute7_before or_xor_common_op_commute7_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_common_op_commute7
  all_goals (try extract_goal ; sorry)
  ---END or_xor_common_op_commute7



def or_not_xor_common_op_commute0_before := [llvm|
{
^0(%arg107 : i4, %arg108 : i4, %arg109 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.xor %arg107, %0 : i4
  %2 = llvm.xor %arg107, %arg108 : i4
  %3 = llvm.or %1, %arg109 : i4
  %4 = llvm.or %3, %2 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def or_not_xor_common_op_commute0_after := [llvm|
{
^0(%arg107 : i4, %arg108 : i4, %arg109 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.and %arg107, %arg108 : i4
  %2 = llvm.xor %1, %0 : i4
  %3 = llvm.or %arg109, %2 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_xor_common_op_commute0_proof : or_not_xor_common_op_commute0_before ⊑ or_not_xor_common_op_commute0_after := by
  unfold or_not_xor_common_op_commute0_before or_not_xor_common_op_commute0_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_xor_common_op_commute0
  all_goals (try extract_goal ; sorry)
  ---END or_not_xor_common_op_commute0



def or_not_xor_common_op_commute2_before := [llvm|
{
^0(%arg101 : i8, %arg102 : i8, %arg103 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg103 : i8
  %3 = llvm.xor %arg101, %1 : i8
  %4 = llvm.xor %arg101, %arg102 : i8
  %5 = llvm.or %2, %3 : i8
  %6 = llvm.or %4, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def or_not_xor_common_op_commute2_after := [llvm|
{
^0(%arg101 : i8, %arg102 : i8, %arg103 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg103 : i8
  %3 = llvm.and %arg101, %arg102 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_xor_common_op_commute2_proof : or_not_xor_common_op_commute2_before ⊑ or_not_xor_common_op_commute2_after := by
  unfold or_not_xor_common_op_commute2_before or_not_xor_common_op_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_xor_common_op_commute2
  all_goals (try extract_goal ; sorry)
  ---END or_not_xor_common_op_commute2



def or_not_xor_common_op_commute3_before := [llvm|
{
^0(%arg98 : i8, %arg99 : i8, %arg100 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg100 : i8
  %3 = llvm.xor %arg98, %1 : i8
  %4 = llvm.xor %arg98, %arg99 : i8
  %5 = llvm.or %2, %3 : i8
  %6 = llvm.or %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def or_not_xor_common_op_commute3_after := [llvm|
{
^0(%arg98 : i8, %arg99 : i8, %arg100 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg100 : i8
  %3 = llvm.and %arg98, %arg99 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_xor_common_op_commute3_proof : or_not_xor_common_op_commute3_before ⊑ or_not_xor_common_op_commute3_after := by
  unfold or_not_xor_common_op_commute3_before or_not_xor_common_op_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_xor_common_op_commute3
  all_goals (try extract_goal ; sorry)
  ---END or_not_xor_common_op_commute3



def or_not_xor_common_op_commute5_before := [llvm|
{
^0(%arg92 : i8, %arg93 : i8, %arg94 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg92, %0 : i8
  %2 = llvm.xor %arg93, %arg92 : i8
  %3 = llvm.or %1, %arg94 : i8
  %4 = llvm.or %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def or_not_xor_common_op_commute5_after := [llvm|
{
^0(%arg92 : i8, %arg93 : i8, %arg94 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.and %arg93, %arg92 : i8
  %2 = llvm.xor %1, %0 : i8
  %3 = llvm.or %arg94, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_xor_common_op_commute5_proof : or_not_xor_common_op_commute5_before ⊑ or_not_xor_common_op_commute5_after := by
  unfold or_not_xor_common_op_commute5_before or_not_xor_common_op_commute5_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_xor_common_op_commute5
  all_goals (try extract_goal ; sorry)
  ---END or_not_xor_common_op_commute5



def or_not_xor_common_op_commute6_before := [llvm|
{
^0(%arg89 : i8, %arg90 : i8, %arg91 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg91 : i8
  %3 = llvm.xor %arg89, %1 : i8
  %4 = llvm.xor %arg90, %arg89 : i8
  %5 = llvm.or %2, %3 : i8
  %6 = llvm.or %4, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def or_not_xor_common_op_commute6_after := [llvm|
{
^0(%arg89 : i8, %arg90 : i8, %arg91 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg91 : i8
  %3 = llvm.and %arg90, %arg89 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_xor_common_op_commute6_proof : or_not_xor_common_op_commute6_before ⊑ or_not_xor_common_op_commute6_after := by
  unfold or_not_xor_common_op_commute6_before or_not_xor_common_op_commute6_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_xor_common_op_commute6
  all_goals (try extract_goal ; sorry)
  ---END or_not_xor_common_op_commute6



def or_not_xor_common_op_commute7_before := [llvm|
{
^0(%arg86 : i8, %arg87 : i8, %arg88 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg88 : i8
  %3 = llvm.xor %arg86, %1 : i8
  %4 = llvm.xor %arg87, %arg86 : i8
  %5 = llvm.or %2, %3 : i8
  %6 = llvm.or %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def or_not_xor_common_op_commute7_after := [llvm|
{
^0(%arg86 : i8, %arg87 : i8, %arg88 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg88 : i8
  %3 = llvm.and %arg87, %arg86 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_not_xor_common_op_commute7_proof : or_not_xor_common_op_commute7_before ⊑ or_not_xor_common_op_commute7_after := by
  unfold or_not_xor_common_op_commute7_before or_not_xor_common_op_commute7_after
  simp_alive_peephole
  intros
  ---BEGIN or_not_xor_common_op_commute7
  all_goals (try extract_goal ; sorry)
  ---END or_not_xor_common_op_commute7



def or_nand_xor_common_op_commute0_before := [llvm|
{
^0(%arg77 : i4, %arg78 : i4, %arg79 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.and %arg77, %arg79 : i4
  %2 = llvm.xor %1, %0 : i4
  %3 = llvm.xor %arg77, %arg78 : i4
  %4 = llvm.or %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def or_nand_xor_common_op_commute0_after := [llvm|
{
^0(%arg77 : i4, %arg78 : i4, %arg79 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.and %arg77, %arg79 : i4
  %2 = llvm.and %1, %arg78 : i4
  %3 = llvm.xor %2, %0 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_nand_xor_common_op_commute0_proof : or_nand_xor_common_op_commute0_before ⊑ or_nand_xor_common_op_commute0_after := by
  unfold or_nand_xor_common_op_commute0_before or_nand_xor_common_op_commute0_after
  simp_alive_peephole
  intros
  ---BEGIN or_nand_xor_common_op_commute0
  all_goals (try extract_goal ; sorry)
  ---END or_nand_xor_common_op_commute0



def PR75692_1_before := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(-5 : i32) : i32
  %2 = llvm.xor %arg61, %0 : i32
  %3 = llvm.xor %arg61, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def PR75692_1_after := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR75692_1_proof : PR75692_1_before ⊑ PR75692_1_after := by
  unfold PR75692_1_before PR75692_1_after
  simp_alive_peephole
  intros
  ---BEGIN PR75692_1
  all_goals (try extract_goal ; sorry)
  ---END PR75692_1



def or_xor_not_before := [llvm|
{
^0(%arg56 : i32, %arg57 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg57, %0 : i32
  %2 = llvm.xor %arg56, %1 : i32
  %3 = llvm.or %2, %arg57 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def or_xor_not_after := [llvm|
{
^0(%arg56 : i32, %arg57 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg56, %0 : i32
  %2 = llvm.or %arg57, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_not_proof : or_xor_not_before ⊑ or_xor_not_after := by
  unfold or_xor_not_before or_xor_not_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_not
  all_goals (try extract_goal ; sorry)
  ---END or_xor_not



def or_xor_and_commuted1_before := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mul %arg51, %arg51 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %2, %arg50 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_xor_and_commuted1_after := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mul %arg51, %arg51 : i32
  %2 = llvm.xor %arg50, %0 : i32
  %3 = llvm.or %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_and_commuted1_proof : or_xor_and_commuted1_before ⊑ or_xor_and_commuted1_after := by
  unfold or_xor_and_commuted1_before or_xor_and_commuted1_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_and_commuted1
  all_goals (try extract_goal ; sorry)
  ---END or_xor_and_commuted1



def or_xor_and_commuted2_before := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mul %arg49, %arg49 : i32
  %2 = llvm.mul %arg48, %arg48 : i32
  %3 = llvm.xor %1, %0 : i32
  %4 = llvm.xor %2, %3 : i32
  %5 = llvm.or %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def or_xor_and_commuted2_after := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mul %arg49, %arg49 : i32
  %2 = llvm.mul %arg48, %arg48 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_and_commuted2_proof : or_xor_and_commuted2_before ⊑ or_xor_and_commuted2_after := by
  unfold or_xor_and_commuted2_before or_xor_and_commuted2_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_and_commuted2
  all_goals (try extract_goal ; sorry)
  ---END or_xor_and_commuted2



def or_xor_tree_0000_before := [llvm|
{
^0(%arg45 : i32, %arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg45, %0 : i32
  %2 = llvm.mul %arg46, %0 : i32
  %3 = llvm.mul %arg47, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.xor %2, %3 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_0000_after := [llvm|
{
^0(%arg45 : i32, %arg46 : i32, %arg47 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg45, %0 : i32
  %2 = llvm.mul %arg46, %0 : i32
  %3 = llvm.mul %arg47, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_0000_proof : or_xor_tree_0000_before ⊑ or_xor_tree_0000_after := by
  unfold or_xor_tree_0000_before or_xor_tree_0000_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_0000
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_0000



def or_xor_tree_0001_before := [llvm|
{
^0(%arg42 : i32, %arg43 : i32, %arg44 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg42, %0 : i32
  %2 = llvm.mul %arg43, %0 : i32
  %3 = llvm.mul %arg44, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.xor %2, %3 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_0001_after := [llvm|
{
^0(%arg42 : i32, %arg43 : i32, %arg44 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg42, %0 : i32
  %2 = llvm.mul %arg43, %0 : i32
  %3 = llvm.mul %arg44, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_0001_proof : or_xor_tree_0001_before ⊑ or_xor_tree_0001_after := by
  unfold or_xor_tree_0001_before or_xor_tree_0001_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_0001
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_0001



def or_xor_tree_0010_before := [llvm|
{
^0(%arg39 : i32, %arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg39, %0 : i32
  %2 = llvm.mul %arg40, %0 : i32
  %3 = llvm.mul %arg41, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.xor %3, %2 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_0010_after := [llvm|
{
^0(%arg39 : i32, %arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg39, %0 : i32
  %2 = llvm.mul %arg40, %0 : i32
  %3 = llvm.mul %arg41, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_0010_proof : or_xor_tree_0010_before ⊑ or_xor_tree_0010_after := by
  unfold or_xor_tree_0010_before or_xor_tree_0010_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_0010
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_0010



def or_xor_tree_0011_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i32, %arg38 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg36, %0 : i32
  %2 = llvm.mul %arg37, %0 : i32
  %3 = llvm.mul %arg38, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.xor %3, %2 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_0011_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i32, %arg38 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg36, %0 : i32
  %2 = llvm.mul %arg37, %0 : i32
  %3 = llvm.mul %arg38, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_0011_proof : or_xor_tree_0011_before ⊑ or_xor_tree_0011_after := by
  unfold or_xor_tree_0011_before or_xor_tree_0011_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_0011
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_0011



def or_xor_tree_0100_before := [llvm|
{
^0(%arg33 : i32, %arg34 : i32, %arg35 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg33, %0 : i32
  %2 = llvm.mul %arg34, %0 : i32
  %3 = llvm.mul %arg35, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.xor %2, %3 : i32
  %6 = llvm.xor %1, %5 : i32
  %7 = llvm.or %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_0100_after := [llvm|
{
^0(%arg33 : i32, %arg34 : i32, %arg35 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg33, %0 : i32
  %2 = llvm.mul %arg34, %0 : i32
  %3 = llvm.mul %arg35, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_0100_proof : or_xor_tree_0100_before ⊑ or_xor_tree_0100_after := by
  unfold or_xor_tree_0100_before or_xor_tree_0100_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_0100
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_0100



def or_xor_tree_0101_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i32, %arg32 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg30, %0 : i32
  %2 = llvm.mul %arg31, %0 : i32
  %3 = llvm.mul %arg32, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.xor %2, %3 : i32
  %6 = llvm.xor %1, %5 : i32
  %7 = llvm.or %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_0101_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i32, %arg32 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg30, %0 : i32
  %2 = llvm.mul %arg31, %0 : i32
  %3 = llvm.mul %arg32, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_0101_proof : or_xor_tree_0101_before ⊑ or_xor_tree_0101_after := by
  unfold or_xor_tree_0101_before or_xor_tree_0101_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_0101
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_0101



def or_xor_tree_0110_before := [llvm|
{
^0(%arg27 : i32, %arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg27, %0 : i32
  %2 = llvm.mul %arg28, %0 : i32
  %3 = llvm.mul %arg29, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.xor %3, %2 : i32
  %6 = llvm.xor %1, %5 : i32
  %7 = llvm.or %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_0110_after := [llvm|
{
^0(%arg27 : i32, %arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg27, %0 : i32
  %2 = llvm.mul %arg28, %0 : i32
  %3 = llvm.mul %arg29, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_0110_proof : or_xor_tree_0110_before ⊑ or_xor_tree_0110_after := by
  unfold or_xor_tree_0110_before or_xor_tree_0110_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_0110
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_0110



def or_xor_tree_0111_before := [llvm|
{
^0(%arg24 : i32, %arg25 : i32, %arg26 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg24, %0 : i32
  %2 = llvm.mul %arg25, %0 : i32
  %3 = llvm.mul %arg26, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.xor %3, %2 : i32
  %6 = llvm.xor %1, %5 : i32
  %7 = llvm.or %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_0111_after := [llvm|
{
^0(%arg24 : i32, %arg25 : i32, %arg26 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg24, %0 : i32
  %2 = llvm.mul %arg25, %0 : i32
  %3 = llvm.mul %arg26, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_0111_proof : or_xor_tree_0111_before ⊑ or_xor_tree_0111_after := by
  unfold or_xor_tree_0111_before or_xor_tree_0111_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_0111
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_0111



def or_xor_tree_1000_before := [llvm|
{
^0(%arg21 : i32, %arg22 : i32, %arg23 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg21, %0 : i32
  %2 = llvm.mul %arg22, %0 : i32
  %3 = llvm.mul %arg23, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.xor %2, %3 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %6, %4 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_1000_after := [llvm|
{
^0(%arg21 : i32, %arg22 : i32, %arg23 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg21, %0 : i32
  %2 = llvm.mul %arg22, %0 : i32
  %3 = llvm.mul %arg23, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_1000_proof : or_xor_tree_1000_before ⊑ or_xor_tree_1000_after := by
  unfold or_xor_tree_1000_before or_xor_tree_1000_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_1000
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_1000



def or_xor_tree_1001_before := [llvm|
{
^0(%arg18 : i32, %arg19 : i32, %arg20 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg18, %0 : i32
  %2 = llvm.mul %arg19, %0 : i32
  %3 = llvm.mul %arg20, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.xor %2, %3 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %6, %4 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_1001_after := [llvm|
{
^0(%arg18 : i32, %arg19 : i32, %arg20 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg18, %0 : i32
  %2 = llvm.mul %arg19, %0 : i32
  %3 = llvm.mul %arg20, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_1001_proof : or_xor_tree_1001_before ⊑ or_xor_tree_1001_after := by
  unfold or_xor_tree_1001_before or_xor_tree_1001_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_1001
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_1001



def or_xor_tree_1010_before := [llvm|
{
^0(%arg15 : i32, %arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg15, %0 : i32
  %2 = llvm.mul %arg16, %0 : i32
  %3 = llvm.mul %arg17, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.xor %3, %2 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %6, %4 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_1010_after := [llvm|
{
^0(%arg15 : i32, %arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg15, %0 : i32
  %2 = llvm.mul %arg16, %0 : i32
  %3 = llvm.mul %arg17, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_1010_proof : or_xor_tree_1010_before ⊑ or_xor_tree_1010_after := by
  unfold or_xor_tree_1010_before or_xor_tree_1010_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_1010
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_1010



def or_xor_tree_1011_before := [llvm|
{
^0(%arg12 : i32, %arg13 : i32, %arg14 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg12, %0 : i32
  %2 = llvm.mul %arg13, %0 : i32
  %3 = llvm.mul %arg14, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.xor %3, %2 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %6, %4 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_1011_after := [llvm|
{
^0(%arg12 : i32, %arg13 : i32, %arg14 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg12, %0 : i32
  %2 = llvm.mul %arg13, %0 : i32
  %3 = llvm.mul %arg14, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_1011_proof : or_xor_tree_1011_before ⊑ or_xor_tree_1011_after := by
  unfold or_xor_tree_1011_before or_xor_tree_1011_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_1011
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_1011



def or_xor_tree_1100_before := [llvm|
{
^0(%arg9 : i32, %arg10 : i32, %arg11 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg9, %0 : i32
  %2 = llvm.mul %arg10, %0 : i32
  %3 = llvm.mul %arg11, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.xor %2, %3 : i32
  %6 = llvm.xor %1, %5 : i32
  %7 = llvm.or %6, %4 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_1100_after := [llvm|
{
^0(%arg9 : i32, %arg10 : i32, %arg11 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg9, %0 : i32
  %2 = llvm.mul %arg10, %0 : i32
  %3 = llvm.mul %arg11, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_1100_proof : or_xor_tree_1100_before ⊑ or_xor_tree_1100_after := by
  unfold or_xor_tree_1100_before or_xor_tree_1100_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_1100
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_1100



def or_xor_tree_1101_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg6, %0 : i32
  %2 = llvm.mul %arg7, %0 : i32
  %3 = llvm.mul %arg8, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.xor %2, %3 : i32
  %6 = llvm.xor %1, %5 : i32
  %7 = llvm.or %6, %4 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_1101_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg6, %0 : i32
  %2 = llvm.mul %arg7, %0 : i32
  %3 = llvm.mul %arg8, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_1101_proof : or_xor_tree_1101_before ⊑ or_xor_tree_1101_after := by
  unfold or_xor_tree_1101_before or_xor_tree_1101_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_1101
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_1101



def or_xor_tree_1110_before := [llvm|
{
^0(%arg3 : i32, %arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg3, %0 : i32
  %2 = llvm.mul %arg4, %0 : i32
  %3 = llvm.mul %arg5, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.xor %3, %2 : i32
  %6 = llvm.xor %1, %5 : i32
  %7 = llvm.or %6, %4 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_1110_after := [llvm|
{
^0(%arg3 : i32, %arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg3, %0 : i32
  %2 = llvm.mul %arg4, %0 : i32
  %3 = llvm.mul %arg5, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_1110_proof : or_xor_tree_1110_before ⊑ or_xor_tree_1110_after := by
  unfold or_xor_tree_1110_before or_xor_tree_1110_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_1110
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_1110



def or_xor_tree_1111_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = llvm.mul %arg2, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.xor %3, %2 : i32
  %6 = llvm.xor %1, %5 : i32
  %7 = llvm.or %6, %4 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_1111_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = llvm.mul %arg2, %0 : i32
  %4 = llvm.xor %2, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_xor_tree_1111_proof : or_xor_tree_1111_before ⊑ or_xor_tree_1111_after := by
  unfold or_xor_tree_1111_before or_xor_tree_1111_after
  simp_alive_peephole
  intros
  ---BEGIN or_xor_tree_1111
  all_goals (try extract_goal ; sorry)
  ---END or_xor_tree_1111


