
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
section gnot_statements

def test1_before := [llvm|
{
^0(%arg153 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg153, %0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg153 : i32):
  "llvm.return"(%arg153) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def not_ashr_not_before := [llvm|
{
^0(%arg139 : i32, %arg140 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg139, %0 : i32
  %2 = llvm.ashr %1, %arg140 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def not_ashr_not_after := [llvm|
{
^0(%arg139 : i32, %arg140 : i32):
  %0 = llvm.ashr %arg139, %arg140 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem not_ashr_not_proof : not_ashr_not_before ⊑ not_ashr_not_after := by
  unfold not_ashr_not_before not_ashr_not_after
  simp_alive_peephole
  ---BEGIN not_ashr_not
  all_goals (try extract_goal ; sorry)
  ---END not_ashr_not



def not_ashr_const_before := [llvm|
{
^0(%arg138 : i8):
  %0 = llvm.mlir.constant(-42 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.ashr %0, %arg138 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def not_ashr_const_after := [llvm|
{
^0(%arg138 : i8):
  %0 = llvm.mlir.constant(41 : i8) : i8
  %1 = llvm.lshr %0, %arg138 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem not_ashr_const_proof : not_ashr_const_before ⊑ not_ashr_const_after := by
  unfold not_ashr_const_before not_ashr_const_after
  simp_alive_peephole
  ---BEGIN not_ashr_const
  all_goals (try extract_goal ; sorry)
  ---END not_ashr_const



def not_lshr_const_before := [llvm|
{
^0(%arg135 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.lshr %0, %arg135 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def not_lshr_const_after := [llvm|
{
^0(%arg135 : i8):
  %0 = llvm.mlir.constant(-43 : i8) : i8
  %1 = llvm.ashr %0, %arg135 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem not_lshr_const_proof : not_lshr_const_before ⊑ not_lshr_const_after := by
  unfold not_lshr_const_before not_lshr_const_after
  simp_alive_peephole
  ---BEGIN not_lshr_const
  all_goals (try extract_goal ; sorry)
  ---END not_lshr_const



def not_sub_before := [llvm|
{
^0(%arg133 : i32):
  %0 = llvm.mlir.constant(123 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sub %0, %arg133 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def not_sub_after := [llvm|
{
^0(%arg133 : i32):
  %0 = llvm.mlir.constant(-124 : i32) : i32
  %1 = llvm.add %arg133, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem not_sub_proof : not_sub_before ⊑ not_sub_after := by
  unfold not_sub_before not_sub_after
  simp_alive_peephole
  ---BEGIN not_sub
  all_goals (try extract_goal ; sorry)
  ---END not_sub



def not_add_before := [llvm|
{
^0(%arg124 : i32):
  %0 = llvm.mlir.constant(123 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.add %arg124, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def not_add_after := [llvm|
{
^0(%arg124 : i32):
  %0 = llvm.mlir.constant(-124 : i32) : i32
  %1 = llvm.sub %0, %arg124 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem not_add_proof : not_add_before ⊑ not_add_after := by
  unfold not_add_before not_add_after
  simp_alive_peephole
  ---BEGIN not_add
  all_goals (try extract_goal ; sorry)
  ---END not_add



def not_or_neg_before := [llvm|
{
^0(%arg79 : i8, %arg80 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sub %0, %arg80 : i8
  %3 = llvm.or %2, %arg79 : i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def not_or_neg_after := [llvm|
{
^0(%arg79 : i8, %arg80 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.add %arg80, %0 : i8
  %2 = llvm.xor %arg79, %0 : i8
  %3 = llvm.and %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem not_or_neg_proof : not_or_neg_before ⊑ not_or_neg_after := by
  unfold not_or_neg_before not_or_neg_after
  simp_alive_peephole
  ---BEGIN not_or_neg
  all_goals (try extract_goal ; sorry)
  ---END not_or_neg



def not_select_bool_const1_before := [llvm|
{
^0(%arg68 : i1, %arg69 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg68, %arg69, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.xor %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def not_select_bool_const1_after := [llvm|
{
^0(%arg68 : i1, %arg69 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg69, %0 : i1
  %3 = "llvm.select"(%arg68, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem not_select_bool_const1_proof : not_select_bool_const1_before ⊑ not_select_bool_const1_after := by
  unfold not_select_bool_const1_before not_select_bool_const1_after
  simp_alive_peephole
  ---BEGIN not_select_bool_const1
  all_goals (try extract_goal ; sorry)
  ---END not_select_bool_const1



def not_select_bool_const4_before := [llvm|
{
^0(%arg62 : i1, %arg63 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg62, %0, %arg63) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = llvm.xor %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def not_select_bool_const4_after := [llvm|
{
^0(%arg62 : i1, %arg63 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg63, %0 : i1
  %2 = "llvm.select"(%arg62, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem not_select_bool_const4_proof : not_select_bool_const4_before ⊑ not_select_bool_const4_after := by
  unfold not_select_bool_const4_before not_select_bool_const4_after
  simp_alive_peephole
  ---BEGIN not_select_bool_const4
  all_goals (try extract_goal ; sorry)
  ---END not_select_bool_const4



def not_logicalAnd_not_op1_before := [llvm|
{
^0(%arg58 : i1, %arg59 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg59, %0 : i1
  %3 = "llvm.select"(%arg58, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.xor %3, %0 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def not_logicalAnd_not_op1_after := [llvm|
{
^0(%arg58 : i1, %arg59 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg58, %0 : i1
  %2 = "llvm.select"(%1, %0, %arg59) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem not_logicalAnd_not_op1_proof : not_logicalAnd_not_op1_before ⊑ not_logicalAnd_not_op1_after := by
  unfold not_logicalAnd_not_op1_before not_logicalAnd_not_op1_after
  simp_alive_peephole
  ---BEGIN not_logicalAnd_not_op1
  all_goals (try extract_goal ; sorry)
  ---END not_logicalAnd_not_op1



def not_logicalOr_not_op1_before := [llvm|
{
^0(%arg50 : i1, %arg51 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg51, %0 : i1
  %2 = "llvm.select"(%arg50, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = llvm.xor %2, %0 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def not_logicalOr_not_op1_after := [llvm|
{
^0(%arg50 : i1, %arg51 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg50, %0 : i1
  %3 = "llvm.select"(%2, %arg51, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem not_logicalOr_not_op1_proof : not_logicalOr_not_op1_before ⊑ not_logicalOr_not_op1_after := by
  unfold not_logicalOr_not_op1_before not_logicalOr_not_op1_after
  simp_alive_peephole
  ---BEGIN not_logicalOr_not_op1
  all_goals (try extract_goal ; sorry)
  ---END not_logicalOr_not_op1



def test_zext_nneg_before := [llvm|
{
^0(%arg25 : i32, %arg26 : i64, %arg27 : i64):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(-5) : i64
  %2 = llvm.xor %arg25, %0 : i32
  %3 = llvm.zext %2 : i32 to i64
  %4 = llvm.add %arg26, %1 : i64
  %5 = llvm.add %3, %arg27 : i64
  %6 = llvm.sub %4, %5 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def test_zext_nneg_after := [llvm|
{
^0(%arg25 : i32, %arg26 : i64, %arg27 : i64):
  %0 = llvm.mlir.constant(-4) : i64
  %1 = llvm.add %arg26, %0 : i64
  %2 = llvm.sext %arg25 : i32 to i64
  %3 = llvm.sub %2, %arg27 : i64
  %4 = llvm.add %1, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
theorem test_zext_nneg_proof : test_zext_nneg_before ⊑ test_zext_nneg_after := by
  unfold test_zext_nneg_before test_zext_nneg_after
  simp_alive_peephole
  ---BEGIN test_zext_nneg
  all_goals (try extract_goal ; sorry)
  ---END test_zext_nneg



def test_invert_demorgan_and2_before := [llvm|
{
^0(%arg7 : i64):
  %0 = llvm.mlir.constant(9223372036854775807) : i64
  %1 = llvm.mlir.constant(-1) : i64
  %2 = llvm.add %arg7, %0 : i64
  %3 = llvm.and %2, %0 : i64
  %4 = llvm.xor %3, %1 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test_invert_demorgan_and2_after := [llvm|
{
^0(%arg7 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.mlir.constant(-9223372036854775808) : i64
  %2 = llvm.sub %0, %arg7 : i64
  %3 = llvm.or %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
theorem test_invert_demorgan_and2_proof : test_invert_demorgan_and2_before ⊑ test_invert_demorgan_and2_after := by
  unfold test_invert_demorgan_and2_before test_invert_demorgan_and2_after
  simp_alive_peephole
  ---BEGIN test_invert_demorgan_and2
  all_goals (try extract_goal ; sorry)
  ---END test_invert_demorgan_and2


