import SSA.Projects.InstCombine.tests.proofs.gnot_proof
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
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  apply test1_thm
  ---END test1



def invert_icmp_before := [llvm|
{
^0(%arg151 : i32, %arg152 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "sle" %arg151, %arg152 : i32
  %2 = llvm.xor %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def invert_icmp_after := [llvm|
{
^0(%arg151 : i32, %arg152 : i32):
  %0 = llvm.icmp "sgt" %arg151, %arg152 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem invert_icmp_proof : invert_icmp_before ⊑ invert_icmp_after := by
  unfold invert_icmp_before invert_icmp_after
  simp_alive_peephole
  intros
  ---BEGIN invert_icmp
  apply invert_icmp_thm
  ---END invert_icmp



def not_not_cmp_before := [llvm|
{
^0(%arg147 : i32, %arg148 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg147, %0 : i32
  %2 = llvm.xor %arg148, %0 : i32
  %3 = llvm.icmp "slt" %1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def not_not_cmp_after := [llvm|
{
^0(%arg147 : i32, %arg148 : i32):
  %0 = llvm.icmp "sgt" %arg147, %arg148 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_not_cmp_proof : not_not_cmp_before ⊑ not_not_cmp_after := by
  unfold not_not_cmp_before not_not_cmp_after
  simp_alive_peephole
  intros
  ---BEGIN not_not_cmp
  apply not_not_cmp_thm
  ---END not_not_cmp



def not_cmp_constant_before := [llvm|
{
^0(%arg144 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.xor %arg144, %0 : i32
  %3 = llvm.icmp "ugt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def not_cmp_constant_after := [llvm|
{
^0(%arg144 : i32):
  %0 = llvm.mlir.constant(-43 : i32) : i32
  %1 = llvm.icmp "ult" %arg144, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_cmp_constant_proof : not_cmp_constant_before ⊑ not_cmp_constant_after := by
  unfold not_cmp_constant_before not_cmp_constant_after
  simp_alive_peephole
  intros
  ---BEGIN not_cmp_constant
  apply not_cmp_constant_thm
  ---END not_cmp_constant



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
set_option debug.skipKernelTC true in
theorem not_ashr_not_proof : not_ashr_not_before ⊑ not_ashr_not_after := by
  unfold not_ashr_not_before not_ashr_not_after
  simp_alive_peephole
  intros
  ---BEGIN not_ashr_not
  apply not_ashr_not_thm
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
set_option debug.skipKernelTC true in
theorem not_ashr_const_proof : not_ashr_const_before ⊑ not_ashr_const_after := by
  unfold not_ashr_const_before not_ashr_const_after
  simp_alive_peephole
  intros
  ---BEGIN not_ashr_const
  apply not_ashr_const_thm
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
set_option debug.skipKernelTC true in
theorem not_lshr_const_proof : not_lshr_const_before ⊑ not_lshr_const_after := by
  unfold not_lshr_const_before not_lshr_const_after
  simp_alive_peephole
  intros
  ---BEGIN not_lshr_const
  apply not_lshr_const_thm
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
set_option debug.skipKernelTC true in
theorem not_sub_proof : not_sub_before ⊑ not_sub_after := by
  unfold not_sub_before not_sub_after
  simp_alive_peephole
  intros
  ---BEGIN not_sub
  apply not_sub_thm
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
set_option debug.skipKernelTC true in
theorem not_add_proof : not_add_before ⊑ not_add_after := by
  unfold not_add_before not_add_after
  simp_alive_peephole
  intros
  ---BEGIN not_add
  apply not_add_thm
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
set_option debug.skipKernelTC true in
theorem not_or_neg_proof : not_or_neg_before ⊑ not_or_neg_after := by
  unfold not_or_neg_before not_or_neg_after
  simp_alive_peephole
  intros
  ---BEGIN not_or_neg
  apply not_or_neg_thm
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
set_option debug.skipKernelTC true in
theorem not_select_bool_const1_proof : not_select_bool_const1_before ⊑ not_select_bool_const1_after := by
  unfold not_select_bool_const1_before not_select_bool_const1_after
  simp_alive_peephole
  intros
  ---BEGIN not_select_bool_const1
  apply not_select_bool_const1_thm
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
set_option debug.skipKernelTC true in
theorem not_select_bool_const4_proof : not_select_bool_const4_before ⊑ not_select_bool_const4_after := by
  unfold not_select_bool_const4_before not_select_bool_const4_after
  simp_alive_peephole
  intros
  ---BEGIN not_select_bool_const4
  apply not_select_bool_const4_thm
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
set_option debug.skipKernelTC true in
theorem not_logicalAnd_not_op1_proof : not_logicalAnd_not_op1_before ⊑ not_logicalAnd_not_op1_after := by
  unfold not_logicalAnd_not_op1_before not_logicalAnd_not_op1_after
  simp_alive_peephole
  intros
  ---BEGIN not_logicalAnd_not_op1
  apply not_logicalAnd_not_op1_thm
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
set_option debug.skipKernelTC true in
theorem not_logicalOr_not_op1_proof : not_logicalOr_not_op1_before ⊑ not_logicalOr_not_op1_after := by
  unfold not_logicalOr_not_op1_before not_logicalOr_not_op1_after
  simp_alive_peephole
  intros
  ---BEGIN not_logicalOr_not_op1
  apply not_logicalOr_not_op1_thm
  ---END not_logicalOr_not_op1



def invert_both_cmp_operands_add_before := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.xor %arg38, %0 : i32
  %3 = llvm.add %arg39, %2 : i32
  %4 = llvm.icmp "sgt" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def invert_both_cmp_operands_add_after := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.sub %arg38, %arg39 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem invert_both_cmp_operands_add_proof : invert_both_cmp_operands_add_before ⊑ invert_both_cmp_operands_add_after := by
  unfold invert_both_cmp_operands_add_before invert_both_cmp_operands_add_after
  simp_alive_peephole
  intros
  ---BEGIN invert_both_cmp_operands_add
  apply invert_both_cmp_operands_add_thm
  ---END invert_both_cmp_operands_add



def invert_both_cmp_operands_sub_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.xor %arg36, %0 : i32
  %3 = llvm.sub %2, %arg37 : i32
  %4 = llvm.icmp "ult" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def invert_both_cmp_operands_sub_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.mlir.constant(-43 : i32) : i32
  %1 = llvm.add %arg36, %arg37 : i32
  %2 = llvm.icmp "ugt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem invert_both_cmp_operands_sub_proof : invert_both_cmp_operands_sub_before ⊑ invert_both_cmp_operands_sub_after := by
  unfold invert_both_cmp_operands_sub_before invert_both_cmp_operands_sub_after
  simp_alive_peephole
  intros
  ---BEGIN invert_both_cmp_operands_sub
  apply invert_both_cmp_operands_sub_thm
  ---END invert_both_cmp_operands_sub



def invert_both_cmp_operands_complex_before := [llvm|
{
^0(%arg32 : i1, %arg33 : i32, %arg34 : i32, %arg35 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg33, %0 : i32
  %2 = llvm.xor %arg34, %0 : i32
  %3 = llvm.xor %arg35, %0 : i32
  %4 = llvm.add %arg35, %1 : i32
  %5 = "llvm.select"(%arg32, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = llvm.icmp "sle" %5, %3 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
def invert_both_cmp_operands_complex_after := [llvm|
{
^0(%arg32 : i1, %arg33 : i32, %arg34 : i32, %arg35 : i32):
  %0 = llvm.sub %arg33, %arg35 : i32
  %1 = "llvm.select"(%arg32, %0, %arg34) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "sge" %1, %arg35 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem invert_both_cmp_operands_complex_proof : invert_both_cmp_operands_complex_before ⊑ invert_both_cmp_operands_complex_after := by
  unfold invert_both_cmp_operands_complex_before invert_both_cmp_operands_complex_after
  simp_alive_peephole
  intros
  ---BEGIN invert_both_cmp_operands_complex
  apply invert_both_cmp_operands_complex_thm
  ---END invert_both_cmp_operands_complex



def test_sext_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.icmp "eq" %arg30, %0 : i32
  %3 = llvm.sext %2 : i1 to i32
  %4 = llvm.add %arg31, %3 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test_sext_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg30, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.sub %2, %arg31 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sext_proof : test_sext_before ⊑ test_sext_after := by
  unfold test_sext_before test_sext_after
  simp_alive_peephole
  intros
  ---BEGIN test_sext
  apply test_sext_thm
  ---END test_sext



def test_zext_nneg_before := [llvm|
{
^0(%arg25 : i32, %arg26 : i64, %arg27 : i64):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(-5) : i64
  %2 = llvm.xor %arg25, %0 : i32
  %3 = llvm.zext nneg %2 : i32 to i64
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
set_option debug.skipKernelTC true in
theorem test_zext_nneg_proof : test_zext_nneg_before ⊑ test_zext_nneg_after := by
  unfold test_zext_nneg_before test_zext_nneg_after
  simp_alive_peephole
  intros
  ---BEGIN test_zext_nneg
  apply test_zext_nneg_thm
  ---END test_zext_nneg



def test_trunc_before := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i8) : i8
  %3 = llvm.zext %arg24 : i8 to i32
  %4 = llvm.add %3, %0 overflow<nsw> : i32
  %5 = llvm.ashr %4, %1 : i32
  %6 = llvm.trunc %5 : i32 to i8
  %7 = llvm.xor %6, %2 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def test_trunc_after := [llvm|
{
^0(%arg24 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg24, %0 : i8
  %2 = llvm.sext %1 : i1 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_trunc_proof : test_trunc_before ⊑ test_trunc_after := by
  unfold test_trunc_before test_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN test_trunc
  apply test_trunc_thm
  ---END test_trunc



def test_invert_demorgan_or2_before := [llvm|
{
^0(%arg15 : i64, %arg16 : i64, %arg17 : i64):
  %0 = llvm.mlir.constant(23) : i64
  %1 = llvm.mlir.constant(59) : i64
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "ugt" %arg15, %0 : i64
  %4 = llvm.icmp "ugt" %arg16, %1 : i64
  %5 = llvm.or %3, %4 : i1
  %6 = llvm.icmp "ugt" %arg17, %1 : i64
  %7 = llvm.or %5, %6 : i1
  %8 = llvm.xor %7, %2 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def test_invert_demorgan_or2_after := [llvm|
{
^0(%arg15 : i64, %arg16 : i64, %arg17 : i64):
  %0 = llvm.mlir.constant(24) : i64
  %1 = llvm.mlir.constant(60) : i64
  %2 = llvm.icmp "ult" %arg15, %0 : i64
  %3 = llvm.icmp "ult" %arg16, %1 : i64
  %4 = llvm.and %2, %3 : i1
  %5 = llvm.icmp "ult" %arg17, %1 : i64
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_invert_demorgan_or2_proof : test_invert_demorgan_or2_before ⊑ test_invert_demorgan_or2_after := by
  unfold test_invert_demorgan_or2_before test_invert_demorgan_or2_after
  simp_alive_peephole
  intros
  ---BEGIN test_invert_demorgan_or2
  apply test_invert_demorgan_or2_thm
  ---END test_invert_demorgan_or2



def test_invert_demorgan_or3_before := [llvm|
{
^0(%arg13 : i32, %arg14 : i32):
  %0 = llvm.mlir.constant(178206 : i32) : i32
  %1 = llvm.mlir.constant(-195102 : i32) : i32
  %2 = llvm.mlir.constant(1506 : i32) : i32
  %3 = llvm.mlir.constant(-201547 : i32) : i32
  %4 = llvm.mlir.constant(716213 : i32) : i32
  %5 = llvm.mlir.constant(-918000 : i32) : i32
  %6 = llvm.mlir.constant(196112 : i32) : i32
  %7 = llvm.mlir.constant(true) : i1
  %8 = llvm.icmp "eq" %arg13, %0 : i32
  %9 = llvm.add %arg14, %1 : i32
  %10 = llvm.icmp "ult" %9, %2 : i32
  %11 = llvm.add %arg14, %3 : i32
  %12 = llvm.icmp "ult" %11, %4 : i32
  %13 = llvm.add %arg14, %5 : i32
  %14 = llvm.icmp "ult" %13, %6 : i32
  %15 = llvm.or %8, %10 : i1
  %16 = llvm.or %15, %12 : i1
  %17 = llvm.or %16, %14 : i1
  %18 = llvm.xor %17, %7 : i1
  "llvm.return"(%18) : (i1) -> ()
}
]
def test_invert_demorgan_or3_after := [llvm|
{
^0(%arg13 : i32, %arg14 : i32):
  %0 = llvm.mlir.constant(178206 : i32) : i32
  %1 = llvm.mlir.constant(-196608 : i32) : i32
  %2 = llvm.mlir.constant(-1506 : i32) : i32
  %3 = llvm.mlir.constant(-917760 : i32) : i32
  %4 = llvm.mlir.constant(-716213 : i32) : i32
  %5 = llvm.mlir.constant(-1114112 : i32) : i32
  %6 = llvm.mlir.constant(-196112 : i32) : i32
  %7 = llvm.icmp "ne" %arg13, %0 : i32
  %8 = llvm.add %arg14, %1 : i32
  %9 = llvm.icmp "ult" %8, %2 : i32
  %10 = llvm.add %arg14, %3 : i32
  %11 = llvm.icmp "ult" %10, %4 : i32
  %12 = llvm.add %arg14, %5 : i32
  %13 = llvm.icmp "ult" %12, %6 : i32
  %14 = llvm.and %7, %9 : i1
  %15 = llvm.and %14, %11 : i1
  %16 = llvm.and %15, %13 : i1
  "llvm.return"(%16) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_invert_demorgan_or3_proof : test_invert_demorgan_or3_before ⊑ test_invert_demorgan_or3_after := by
  unfold test_invert_demorgan_or3_before test_invert_demorgan_or3_after
  simp_alive_peephole
  intros
  ---BEGIN test_invert_demorgan_or3
  apply test_invert_demorgan_or3_thm
  ---END test_invert_demorgan_or3



def test_invert_demorgan_logical_or_before := [llvm|
{
^0(%arg11 : i64, %arg12 : i64):
  %0 = llvm.mlir.constant(27) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg11, %0 : i64
  %4 = llvm.icmp "eq" %arg12, %1 : i64
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.icmp "eq" %arg11, %1 : i64
  %7 = llvm.or %6, %5 : i1
  %8 = llvm.xor %7, %2 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def test_invert_demorgan_logical_or_after := [llvm|
{
^0(%arg11 : i64, %arg12 : i64):
  %0 = llvm.mlir.constant(27) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ne" %arg11, %0 : i64
  %4 = llvm.icmp "ne" %arg12, %1 : i64
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.icmp "ne" %arg11, %1 : i64
  %7 = llvm.and %6, %5 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_invert_demorgan_logical_or_proof : test_invert_demorgan_logical_or_before ⊑ test_invert_demorgan_logical_or_after := by
  unfold test_invert_demorgan_logical_or_before test_invert_demorgan_logical_or_after
  simp_alive_peephole
  intros
  ---BEGIN test_invert_demorgan_logical_or
  apply test_invert_demorgan_logical_or_thm
  ---END test_invert_demorgan_logical_or



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
set_option debug.skipKernelTC true in
theorem test_invert_demorgan_and2_proof : test_invert_demorgan_and2_before ⊑ test_invert_demorgan_and2_after := by
  unfold test_invert_demorgan_and2_before test_invert_demorgan_and2_after
  simp_alive_peephole
  intros
  ---BEGIN test_invert_demorgan_and2
  apply test_invert_demorgan_and2_thm
  ---END test_invert_demorgan_and2



def test_invert_demorgan_and3_before := [llvm|
{
^0(%arg5 : i32, %arg6 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(4095 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.xor %arg5, %0 : i32
  %4 = llvm.add %arg6, %3 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = llvm.icmp "eq" %5, %2 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
def test_invert_demorgan_and3_after := [llvm|
{
^0(%arg5 : i32, %arg6 : i32):
  %0 = llvm.mlir.constant(4095 : i32) : i32
  %1 = llvm.sub %arg5, %arg6 : i32
  %2 = llvm.and %1, %0 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_invert_demorgan_and3_proof : test_invert_demorgan_and3_before ⊑ test_invert_demorgan_and3_after := by
  unfold test_invert_demorgan_and3_before test_invert_demorgan_and3_after
  simp_alive_peephole
  intros
  ---BEGIN test_invert_demorgan_and3
  apply test_invert_demorgan_and3_thm
  ---END test_invert_demorgan_and3



def test_invert_demorgan_logical_and_before := [llvm|
{
^0(%arg3 : i64, %arg4 : i64):
  %0 = llvm.mlir.constant(27) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.icmp "eq" %arg3, %0 : i64
  %5 = llvm.icmp "eq" %arg4, %1 : i64
  %6 = "llvm.select"(%4, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = llvm.icmp "eq" %arg3, %1 : i64
  %8 = llvm.or %7, %6 : i1
  %9 = llvm.xor %8, %3 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def test_invert_demorgan_logical_and_after := [llvm|
{
^0(%arg3 : i64, %arg4 : i64):
  %0 = llvm.mlir.constant(27) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "ne" %arg3, %0 : i64
  %4 = llvm.icmp "ne" %arg4, %1 : i64
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.icmp "ne" %arg3, %1 : i64
  %7 = llvm.and %6, %5 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_invert_demorgan_logical_and_proof : test_invert_demorgan_logical_and_before ⊑ test_invert_demorgan_logical_and_after := by
  unfold test_invert_demorgan_logical_and_before test_invert_demorgan_logical_and_after
  simp_alive_peephole
  intros
  ---BEGIN test_invert_demorgan_logical_and
  apply test_invert_demorgan_logical_and_thm
  ---END test_invert_demorgan_logical_and


