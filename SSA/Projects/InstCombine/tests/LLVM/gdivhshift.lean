
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
section gdivhshift_statements

def t1_before := [llvm|
{
^0(%arg241 : i16, %arg242 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.zext %arg241 : i16 to i32
  %2 = llvm.shl %0, %arg242 : i32
  %3 = llvm.sdiv %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def t1_after := [llvm|
{
^0(%arg241 : i16, %arg242 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.zext %arg241 : i16 to i32
  %2 = llvm.add %arg242, %0 : i32
  %3 = llvm.lshr %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_proof : t1_before ⊑ t1_after := by
  unfold t1_before t1_after
  simp_alive_peephole
  intros
  ---BEGIN t1
  all_goals (try extract_goal ; sorry)
  ---END t1



def t2_before := [llvm|
{
^0(%arg237 : i64, %arg238 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg238 : i32
  %2 = llvm.zext %1 : i32 to i64
  %3 = llvm.udiv %arg237, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def t2_after := [llvm|
{
^0(%arg237 : i64, %arg238 : i32):
  %0 = llvm.zext nneg %arg238 : i32 to i64
  %1 = llvm.lshr %arg237, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t2_proof : t2_before ⊑ t2_after := by
  unfold t2_before t2_after
  simp_alive_peephole
  intros
  ---BEGIN t2
  all_goals (try extract_goal ; sorry)
  ---END t2



def t3_before := [llvm|
{
^0(%arg235 : i64, %arg236 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.shl %0, %arg236 : i32
  %2 = llvm.zext %1 : i32 to i64
  %3 = llvm.udiv %arg235, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def t3_after := [llvm|
{
^0(%arg235 : i64, %arg236 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.add %arg236, %0 : i32
  %2 = llvm.zext nneg %1 : i32 to i64
  %3 = llvm.lshr %arg235, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t3_proof : t3_before ⊑ t3_after := by
  unfold t3_before t3_after
  simp_alive_peephole
  intros
  ---BEGIN t3
  all_goals (try extract_goal ; sorry)
  ---END t3



def t5_before := [llvm|
{
^0(%arg230 : i1, %arg231 : i1, %arg232 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(32 : i32) : i32
  %2 = llvm.mlir.constant(64 : i32) : i32
  %3 = llvm.shl %0, %arg232 : i32
  %4 = "llvm.select"(%arg230, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = "llvm.select"(%arg231, %4, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %6 = llvm.udiv %arg232, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def t5_after := [llvm|
{
^0(%arg230 : i1, %arg231 : i1, %arg232 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = "llvm.select"(%arg230, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = "llvm.select"(%arg231, %2, %arg232) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.lshr %arg232, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t5_proof : t5_before ⊑ t5_after := by
  unfold t5_before t5_after
  simp_alive_peephole
  intros
  ---BEGIN t5
  all_goals (try extract_goal ; sorry)
  ---END t5



def t7_before := [llvm|
{
^0(%arg209 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.shl %arg209, %0 overflow<nsw> : i32
  %2 = llvm.sdiv %1, %arg209 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def t7_after := [llvm|
{
^0(%arg209 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t7_proof : t7_before ⊑ t7_after := by
  unfold t7_before t7_after
  simp_alive_peephole
  intros
  ---BEGIN t7
  all_goals (try extract_goal ; sorry)
  ---END t7



def t10_before := [llvm|
{
^0(%arg205 : i32, %arg206 : i32):
  %0 = llvm.shl %arg205, %arg206 overflow<nsw> : i32
  %1 = llvm.sdiv %0, %arg205 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def t10_after := [llvm|
{
^0(%arg205 : i32, %arg206 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg206 overflow<nsw,nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t10_proof : t10_before ⊑ t10_after := by
  unfold t10_before t10_after
  simp_alive_peephole
  intros
  ---BEGIN t10
  all_goals (try extract_goal ; sorry)
  ---END t10



def t12_before := [llvm|
{
^0(%arg202 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.shl %arg202, %0 overflow<nuw> : i32
  %2 = llvm.udiv %1, %arg202 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def t12_after := [llvm|
{
^0(%arg202 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t12_proof : t12_before ⊑ t12_after := by
  unfold t12_before t12_after
  simp_alive_peephole
  intros
  ---BEGIN t12
  all_goals (try extract_goal ; sorry)
  ---END t12



def t15_before := [llvm|
{
^0(%arg198 : i32, %arg199 : i32):
  %0 = llvm.shl %arg198, %arg199 overflow<nuw> : i32
  %1 = llvm.udiv %0, %arg198 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def t15_after := [llvm|
{
^0(%arg198 : i32, %arg199 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg199 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t15_proof : t15_before ⊑ t15_after := by
  unfold t15_before t15_after
  simp_alive_peephole
  intros
  ---BEGIN t15
  all_goals (try extract_goal ; sorry)
  ---END t15



def sdiv_mul_shl_nsw_before := [llvm|
{
^0(%arg193 : i5, %arg194 : i5, %arg195 : i5):
  %0 = llvm.mul %arg193, %arg194 overflow<nsw> : i5
  %1 = llvm.shl %arg193, %arg195 overflow<nsw> : i5
  %2 = llvm.sdiv %0, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def sdiv_mul_shl_nsw_after := [llvm|
{
^0(%arg193 : i5, %arg194 : i5, %arg195 : i5):
  %0 = llvm.mlir.constant(1 : i5) : i5
  %1 = llvm.shl %0, %arg195 overflow<nuw> : i5
  %2 = llvm.sdiv %arg194, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_mul_shl_nsw_proof : sdiv_mul_shl_nsw_before ⊑ sdiv_mul_shl_nsw_after := by
  unfold sdiv_mul_shl_nsw_before sdiv_mul_shl_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_mul_shl_nsw
  all_goals (try extract_goal ; sorry)
  ---END sdiv_mul_shl_nsw



def sdiv_mul_shl_nsw_exact_commute1_before := [llvm|
{
^0(%arg190 : i5, %arg191 : i5, %arg192 : i5):
  %0 = llvm.mul %arg191, %arg190 overflow<nsw> : i5
  %1 = llvm.shl %arg190, %arg192 overflow<nsw> : i5
  %2 = llvm.sdiv exact %0, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def sdiv_mul_shl_nsw_exact_commute1_after := [llvm|
{
^0(%arg190 : i5, %arg191 : i5, %arg192 : i5):
  %0 = llvm.mlir.constant(1 : i5) : i5
  %1 = llvm.shl %0, %arg192 overflow<nuw> : i5
  %2 = llvm.sdiv exact %arg191, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_mul_shl_nsw_exact_commute1_proof : sdiv_mul_shl_nsw_exact_commute1_before ⊑ sdiv_mul_shl_nsw_exact_commute1_after := by
  unfold sdiv_mul_shl_nsw_exact_commute1_before sdiv_mul_shl_nsw_exact_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_mul_shl_nsw_exact_commute1
  all_goals (try extract_goal ; sorry)
  ---END sdiv_mul_shl_nsw_exact_commute1



def udiv_mul_shl_nuw_before := [llvm|
{
^0(%arg166 : i5, %arg167 : i5, %arg168 : i5):
  %0 = llvm.mul %arg166, %arg167 overflow<nuw> : i5
  %1 = llvm.shl %arg166, %arg168 overflow<nuw> : i5
  %2 = llvm.udiv %0, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def udiv_mul_shl_nuw_after := [llvm|
{
^0(%arg166 : i5, %arg167 : i5, %arg168 : i5):
  %0 = llvm.lshr %arg167, %arg168 : i5
  "llvm.return"(%0) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_mul_shl_nuw_proof : udiv_mul_shl_nuw_before ⊑ udiv_mul_shl_nuw_after := by
  unfold udiv_mul_shl_nuw_before udiv_mul_shl_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_mul_shl_nuw
  all_goals (try extract_goal ; sorry)
  ---END udiv_mul_shl_nuw



def udiv_mul_shl_nuw_exact_commute1_before := [llvm|
{
^0(%arg163 : i5, %arg164 : i5, %arg165 : i5):
  %0 = llvm.mul %arg164, %arg163 overflow<nuw> : i5
  %1 = llvm.shl %arg163, %arg165 overflow<nuw> : i5
  %2 = llvm.udiv exact %0, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def udiv_mul_shl_nuw_exact_commute1_after := [llvm|
{
^0(%arg163 : i5, %arg164 : i5, %arg165 : i5):
  %0 = llvm.lshr exact %arg164, %arg165 : i5
  "llvm.return"(%0) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_mul_shl_nuw_exact_commute1_proof : udiv_mul_shl_nuw_exact_commute1_before ⊑ udiv_mul_shl_nuw_exact_commute1_after := by
  unfold udiv_mul_shl_nuw_exact_commute1_before udiv_mul_shl_nuw_exact_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_mul_shl_nuw_exact_commute1
  all_goals (try extract_goal ; sorry)
  ---END udiv_mul_shl_nuw_exact_commute1



def udiv_shl_mul_nuw_before := [llvm|
{
^0(%arg148 : i5, %arg149 : i5, %arg150 : i5):
  %0 = llvm.shl %arg148, %arg150 overflow<nuw> : i5
  %1 = llvm.mul %arg148, %arg149 overflow<nuw> : i5
  %2 = llvm.udiv %0, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def udiv_shl_mul_nuw_after := [llvm|
{
^0(%arg148 : i5, %arg149 : i5, %arg150 : i5):
  %0 = llvm.mlir.constant(1 : i5) : i5
  %1 = llvm.shl %0, %arg150 overflow<nuw> : i5
  %2 = llvm.udiv %1, %arg149 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_shl_mul_nuw_proof : udiv_shl_mul_nuw_before ⊑ udiv_shl_mul_nuw_after := by
  unfold udiv_shl_mul_nuw_before udiv_shl_mul_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_shl_mul_nuw
  all_goals (try extract_goal ; sorry)
  ---END udiv_shl_mul_nuw



def udiv_shl_mul_nuw_swap_before := [llvm|
{
^0(%arg145 : i5, %arg146 : i5, %arg147 : i5):
  %0 = llvm.shl %arg145, %arg147 overflow<nuw> : i5
  %1 = llvm.mul %arg146, %arg145 overflow<nuw> : i5
  %2 = llvm.udiv %0, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def udiv_shl_mul_nuw_swap_after := [llvm|
{
^0(%arg145 : i5, %arg146 : i5, %arg147 : i5):
  %0 = llvm.mlir.constant(1 : i5) : i5
  %1 = llvm.shl %0, %arg147 overflow<nuw> : i5
  %2 = llvm.udiv %1, %arg146 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_shl_mul_nuw_swap_proof : udiv_shl_mul_nuw_swap_before ⊑ udiv_shl_mul_nuw_swap_after := by
  unfold udiv_shl_mul_nuw_swap_before udiv_shl_mul_nuw_swap_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_shl_mul_nuw_swap
  all_goals (try extract_goal ; sorry)
  ---END udiv_shl_mul_nuw_swap



def udiv_shl_mul_nuw_exact_before := [llvm|
{
^0(%arg142 : i5, %arg143 : i5, %arg144 : i5):
  %0 = llvm.shl %arg142, %arg144 overflow<nuw> : i5
  %1 = llvm.mul %arg142, %arg143 overflow<nuw> : i5
  %2 = llvm.udiv exact %0, %1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def udiv_shl_mul_nuw_exact_after := [llvm|
{
^0(%arg142 : i5, %arg143 : i5, %arg144 : i5):
  %0 = llvm.mlir.constant(1 : i5) : i5
  %1 = llvm.shl %0, %arg144 overflow<nuw> : i5
  %2 = llvm.udiv exact %1, %arg143 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_shl_mul_nuw_exact_proof : udiv_shl_mul_nuw_exact_before ⊑ udiv_shl_mul_nuw_exact_after := by
  unfold udiv_shl_mul_nuw_exact_before udiv_shl_mul_nuw_exact_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_shl_mul_nuw_exact
  all_goals (try extract_goal ; sorry)
  ---END udiv_shl_mul_nuw_exact



def udiv_lshr_mul_nuw_before := [llvm|
{
^0(%arg106 : i8, %arg107 : i8, %arg108 : i8):
  %0 = llvm.mul %arg106, %arg107 overflow<nuw> : i8
  %1 = llvm.lshr %0, %arg108 : i8
  %2 = llvm.udiv %1, %arg106 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def udiv_lshr_mul_nuw_after := [llvm|
{
^0(%arg106 : i8, %arg107 : i8, %arg108 : i8):
  %0 = llvm.lshr %arg107, %arg108 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_lshr_mul_nuw_proof : udiv_lshr_mul_nuw_before ⊑ udiv_lshr_mul_nuw_after := by
  unfold udiv_lshr_mul_nuw_before udiv_lshr_mul_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_lshr_mul_nuw
  all_goals (try extract_goal ; sorry)
  ---END udiv_lshr_mul_nuw



def sdiv_shl_shl_nsw2_nuw_before := [llvm|
{
^0(%arg82 : i8, %arg83 : i8, %arg84 : i8):
  %0 = llvm.shl %arg82, %arg84 overflow<nsw> : i8
  %1 = llvm.shl %arg83, %arg84 overflow<nsw,nuw> : i8
  %2 = llvm.sdiv %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sdiv_shl_shl_nsw2_nuw_after := [llvm|
{
^0(%arg82 : i8, %arg83 : i8, %arg84 : i8):
  %0 = llvm.sdiv %arg82, %arg83 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_shl_shl_nsw2_nuw_proof : sdiv_shl_shl_nsw2_nuw_before ⊑ sdiv_shl_shl_nsw2_nuw_after := by
  unfold sdiv_shl_shl_nsw2_nuw_before sdiv_shl_shl_nsw2_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_shl_shl_nsw2_nuw
  all_goals (try extract_goal ; sorry)
  ---END sdiv_shl_shl_nsw2_nuw



def udiv_shl_shl_nuw_nsw2_before := [llvm|
{
^0(%arg55 : i8, %arg56 : i8, %arg57 : i8):
  %0 = llvm.shl %arg55, %arg57 overflow<nsw,nuw> : i8
  %1 = llvm.shl %arg56, %arg57 overflow<nsw> : i8
  %2 = llvm.udiv %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def udiv_shl_shl_nuw_nsw2_after := [llvm|
{
^0(%arg55 : i8, %arg56 : i8, %arg57 : i8):
  %0 = llvm.udiv %arg55, %arg56 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_shl_shl_nuw_nsw2_proof : udiv_shl_shl_nuw_nsw2_before ⊑ udiv_shl_shl_nuw_nsw2_after := by
  unfold udiv_shl_shl_nuw_nsw2_before udiv_shl_shl_nuw_nsw2_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_shl_shl_nuw_nsw2
  all_goals (try extract_goal ; sorry)
  ---END udiv_shl_shl_nuw_nsw2



def sdiv_shl_pair_const_before := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.shl %arg47, %0 overflow<nsw> : i32
  %3 = llvm.shl %arg47, %1 overflow<nsw> : i32
  %4 = llvm.sdiv %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def sdiv_shl_pair_const_after := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_shl_pair_const_proof : sdiv_shl_pair_const_before ⊑ sdiv_shl_pair_const_after := by
  unfold sdiv_shl_pair_const_before sdiv_shl_pair_const_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_shl_pair_const
  all_goals (try extract_goal ; sorry)
  ---END sdiv_shl_pair_const



def udiv_shl_pair_const_before := [llvm|
{
^0(%arg46 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.shl %arg46, %0 overflow<nuw> : i32
  %3 = llvm.shl %arg46, %1 overflow<nuw> : i32
  %4 = llvm.udiv %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def udiv_shl_pair_const_after := [llvm|
{
^0(%arg46 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_shl_pair_const_proof : udiv_shl_pair_const_before ⊑ udiv_shl_pair_const_after := by
  unfold udiv_shl_pair_const_before udiv_shl_pair_const_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_shl_pair_const
  all_goals (try extract_goal ; sorry)
  ---END udiv_shl_pair_const



def sdiv_shl_pair1_before := [llvm|
{
^0(%arg43 : i32, %arg44 : i32, %arg45 : i32):
  %0 = llvm.shl %arg43, %arg44 overflow<nsw> : i32
  %1 = llvm.shl %arg43, %arg45 overflow<nsw,nuw> : i32
  %2 = llvm.sdiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sdiv_shl_pair1_after := [llvm|
{
^0(%arg43 : i32, %arg44 : i32, %arg45 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg44 overflow<nsw,nuw> : i32
  %2 = llvm.lshr %1, %arg45 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_shl_pair1_proof : sdiv_shl_pair1_before ⊑ sdiv_shl_pair1_after := by
  unfold sdiv_shl_pair1_before sdiv_shl_pair1_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_shl_pair1
  all_goals (try extract_goal ; sorry)
  ---END sdiv_shl_pair1



def sdiv_shl_pair2_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i32, %arg42 : i32):
  %0 = llvm.shl %arg40, %arg41 overflow<nsw,nuw> : i32
  %1 = llvm.shl %arg40, %arg42 overflow<nsw> : i32
  %2 = llvm.sdiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sdiv_shl_pair2_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i32, %arg42 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg41 overflow<nsw,nuw> : i32
  %2 = llvm.lshr %1, %arg42 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_shl_pair2_proof : sdiv_shl_pair2_before ⊑ sdiv_shl_pair2_after := by
  unfold sdiv_shl_pair2_before sdiv_shl_pair2_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_shl_pair2
  all_goals (try extract_goal ; sorry)
  ---END sdiv_shl_pair2



def sdiv_shl_pair3_before := [llvm|
{
^0(%arg37 : i32, %arg38 : i32, %arg39 : i32):
  %0 = llvm.shl %arg37, %arg38 overflow<nsw> : i32
  %1 = llvm.shl %arg37, %arg39 overflow<nsw> : i32
  %2 = llvm.sdiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sdiv_shl_pair3_after := [llvm|
{
^0(%arg37 : i32, %arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg38 overflow<nuw> : i32
  %2 = llvm.lshr %1, %arg39 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_shl_pair3_proof : sdiv_shl_pair3_before ⊑ sdiv_shl_pair3_after := by
  unfold sdiv_shl_pair3_before sdiv_shl_pair3_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_shl_pair3
  all_goals (try extract_goal ; sorry)
  ---END sdiv_shl_pair3



def udiv_shl_pair1_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i32, %arg32 : i32):
  %0 = llvm.shl %arg30, %arg31 overflow<nuw> : i32
  %1 = llvm.shl %arg30, %arg32 overflow<nuw> : i32
  %2 = llvm.udiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def udiv_shl_pair1_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i32, %arg32 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg31 overflow<nuw> : i32
  %2 = llvm.lshr %1, %arg32 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_shl_pair1_proof : udiv_shl_pair1_before ⊑ udiv_shl_pair1_after := by
  unfold udiv_shl_pair1_before udiv_shl_pair1_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_shl_pair1
  all_goals (try extract_goal ; sorry)
  ---END udiv_shl_pair1



def udiv_shl_pair2_before := [llvm|
{
^0(%arg27 : i32, %arg28 : i32, %arg29 : i32):
  %0 = llvm.shl %arg27, %arg28 overflow<nsw,nuw> : i32
  %1 = llvm.shl %arg27, %arg29 overflow<nuw> : i32
  %2 = llvm.udiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def udiv_shl_pair2_after := [llvm|
{
^0(%arg27 : i32, %arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg28 overflow<nsw,nuw> : i32
  %2 = llvm.lshr %1, %arg29 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_shl_pair2_proof : udiv_shl_pair2_before ⊑ udiv_shl_pair2_after := by
  unfold udiv_shl_pair2_before udiv_shl_pair2_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_shl_pair2
  all_goals (try extract_goal ; sorry)
  ---END udiv_shl_pair2



def udiv_shl_pair3_before := [llvm|
{
^0(%arg24 : i32, %arg25 : i32, %arg26 : i32):
  %0 = llvm.shl %arg24, %arg25 overflow<nuw> : i32
  %1 = llvm.shl %arg24, %arg26 overflow<nsw,nuw> : i32
  %2 = llvm.udiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def udiv_shl_pair3_after := [llvm|
{
^0(%arg24 : i32, %arg25 : i32, %arg26 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg25 overflow<nuw> : i32
  %2 = llvm.lshr %1, %arg26 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_shl_pair3_proof : udiv_shl_pair3_before ⊑ udiv_shl_pair3_after := by
  unfold udiv_shl_pair3_before udiv_shl_pair3_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_shl_pair3
  all_goals (try extract_goal ; sorry)
  ---END udiv_shl_pair3


