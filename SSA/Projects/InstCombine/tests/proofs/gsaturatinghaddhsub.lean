import SSA.Projects.InstCombine.tests.proofs.gsaturatinghaddhsub_proof
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
section gsaturatinghaddhsub_statements

def test_simplify_decrement_invalid_ne_before := [llvm|
{
^0(%arg207 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "ne" %arg207, %0 : i8
  %3 = llvm.sub %arg207, %1 : i8
  %4 = "llvm.select"(%2, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def test_simplify_decrement_invalid_ne_after := [llvm|
{
^0(%arg207 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg207, %0 : i8
  %2 = llvm.sext %1 : i1 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_simplify_decrement_invalid_ne_proof : test_simplify_decrement_invalid_ne_before ⊑ test_simplify_decrement_invalid_ne_after := by
  unfold test_simplify_decrement_invalid_ne_before test_simplify_decrement_invalid_ne_after
  simp_alive_peephole
  intros
  ---BEGIN test_simplify_decrement_invalid_ne
  apply test_simplify_decrement_invalid_ne_thm
  ---END test_simplify_decrement_invalid_ne



def test_invalid_simplify_sub2_before := [llvm|
{
^0(%arg206 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.icmp "eq" %arg206, %0 : i8
  %3 = llvm.sub %arg206, %1 : i8
  %4 = "llvm.select"(%2, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def test_invalid_simplify_sub2_after := [llvm|
{
^0(%arg206 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.icmp "eq" %arg206, %0 : i8
  %3 = llvm.add %arg206, %1 : i8
  %4 = "llvm.select"(%2, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_invalid_simplify_sub2_proof : test_invalid_simplify_sub2_before ⊑ test_invalid_simplify_sub2_after := by
  unfold test_invalid_simplify_sub2_before test_invalid_simplify_sub2_after
  simp_alive_peephole
  intros
  ---BEGIN test_invalid_simplify_sub2
  apply test_invalid_simplify_sub2_thm
  ---END test_invalid_simplify_sub2



def test_invalid_simplify_eq2_before := [llvm|
{
^0(%arg205 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.icmp "eq" %arg205, %0 : i8
  %4 = llvm.sub %arg205, %1 : i8
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def test_invalid_simplify_eq2_after := [llvm|
{
^0(%arg205 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.icmp "eq" %arg205, %0 : i8
  %4 = llvm.add %arg205, %1 : i8
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_invalid_simplify_eq2_proof : test_invalid_simplify_eq2_before ⊑ test_invalid_simplify_eq2_after := by
  unfold test_invalid_simplify_eq2_before test_invalid_simplify_eq2_after
  simp_alive_peephole
  intros
  ---BEGIN test_invalid_simplify_eq2
  apply test_invalid_simplify_eq2_thm
  ---END test_invalid_simplify_eq2



def test_invalid_simplify_select_1_before := [llvm|
{
^0(%arg204 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg204, %0 : i8
  %3 = llvm.sub %arg204, %1 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def test_invalid_simplify_select_1_after := [llvm|
{
^0(%arg204 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(1 : i8) : i8
  %3 = llvm.icmp "eq" %arg204, %0 : i8
  %4 = llvm.add %arg204, %1 : i8
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_invalid_simplify_select_1_proof : test_invalid_simplify_select_1_before ⊑ test_invalid_simplify_select_1_after := by
  unfold test_invalid_simplify_select_1_before test_invalid_simplify_select_1_after
  simp_alive_peephole
  intros
  ---BEGIN test_invalid_simplify_select_1
  apply test_invalid_simplify_select_1_thm
  ---END test_invalid_simplify_select_1



def test_invalid_simplify_other_before := [llvm|
{
^0(%arg202 : i8, %arg203 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.icmp "eq" %arg202, %0 : i8
  %3 = llvm.sub %arg203, %1 : i8
  %4 = "llvm.select"(%2, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def test_invalid_simplify_other_after := [llvm|
{
^0(%arg202 : i8, %arg203 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.icmp "eq" %arg202, %0 : i8
  %3 = llvm.add %arg203, %1 : i8
  %4 = "llvm.select"(%2, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_invalid_simplify_other_proof : test_invalid_simplify_other_before ⊑ test_invalid_simplify_other_after := by
  unfold test_invalid_simplify_other_before test_invalid_simplify_other_after
  simp_alive_peephole
  intros
  ---BEGIN test_invalid_simplify_other
  apply test_invalid_simplify_other_thm
  ---END test_invalid_simplify_other



def uadd_sat_flipped_wrong_bounds_before := [llvm|
{
^0(%arg94 : i32):
  %0 = llvm.mlir.constant(-12 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.icmp "uge" %arg94, %0 : i32
  %4 = llvm.add %arg94, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def uadd_sat_flipped_wrong_bounds_after := [llvm|
{
^0(%arg94 : i32):
  %0 = llvm.mlir.constant(-13 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.icmp "ugt" %arg94, %0 : i32
  %4 = llvm.add %arg94, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uadd_sat_flipped_wrong_bounds_proof : uadd_sat_flipped_wrong_bounds_before ⊑ uadd_sat_flipped_wrong_bounds_after := by
  unfold uadd_sat_flipped_wrong_bounds_before uadd_sat_flipped_wrong_bounds_after
  simp_alive_peephole
  intros
  ---BEGIN uadd_sat_flipped_wrong_bounds
  apply uadd_sat_flipped_wrong_bounds_thm
  ---END uadd_sat_flipped_wrong_bounds



def uadd_sat_flipped_wrong_bounds4_before := [llvm|
{
^0(%arg91 : i32):
  %0 = llvm.mlir.constant(-8 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.icmp "uge" %arg91, %0 : i32
  %4 = llvm.add %arg91, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def uadd_sat_flipped_wrong_bounds4_after := [llvm|
{
^0(%arg91 : i32):
  %0 = llvm.mlir.constant(-9 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.icmp "ugt" %arg91, %0 : i32
  %4 = llvm.add %arg91, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uadd_sat_flipped_wrong_bounds4_proof : uadd_sat_flipped_wrong_bounds4_before ⊑ uadd_sat_flipped_wrong_bounds4_after := by
  unfold uadd_sat_flipped_wrong_bounds4_before uadd_sat_flipped_wrong_bounds4_after
  simp_alive_peephole
  intros
  ---BEGIN uadd_sat_flipped_wrong_bounds4
  apply uadd_sat_flipped_wrong_bounds4_thm
  ---END uadd_sat_flipped_wrong_bounds4



def uadd_sat_flipped_wrong_bounds6_before := [llvm|
{
^0(%arg89 : i32):
  %0 = llvm.mlir.constant(-12 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.icmp "ule" %arg89, %0 : i32
  %4 = llvm.add %arg89, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def uadd_sat_flipped_wrong_bounds6_after := [llvm|
{
^0(%arg89 : i32):
  %0 = llvm.mlir.constant(-11 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.icmp "ult" %arg89, %0 : i32
  %4 = llvm.add %arg89, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uadd_sat_flipped_wrong_bounds6_proof : uadd_sat_flipped_wrong_bounds6_before ⊑ uadd_sat_flipped_wrong_bounds6_after := by
  unfold uadd_sat_flipped_wrong_bounds6_before uadd_sat_flipped_wrong_bounds6_after
  simp_alive_peephole
  intros
  ---BEGIN uadd_sat_flipped_wrong_bounds6
  apply uadd_sat_flipped_wrong_bounds6_thm
  ---END uadd_sat_flipped_wrong_bounds6



def uadd_sat_flipped_wrong_bounds7_before := [llvm|
{
^0(%arg88 : i32):
  %0 = llvm.mlir.constant(-12 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.icmp "ule" %arg88, %0 : i32
  %4 = llvm.add %arg88, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def uadd_sat_flipped_wrong_bounds7_after := [llvm|
{
^0(%arg88 : i32):
  %0 = llvm.mlir.constant(-11 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.icmp "ult" %arg88, %0 : i32
  %4 = llvm.add %arg88, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uadd_sat_flipped_wrong_bounds7_proof : uadd_sat_flipped_wrong_bounds7_before ⊑ uadd_sat_flipped_wrong_bounds7_after := by
  unfold uadd_sat_flipped_wrong_bounds7_before uadd_sat_flipped_wrong_bounds7_after
  simp_alive_peephole
  intros
  ---BEGIN uadd_sat_flipped_wrong_bounds7
  apply uadd_sat_flipped_wrong_bounds7_thm
  ---END uadd_sat_flipped_wrong_bounds7



def uadd_sat_canon_nuw_before := [llvm|
{
^0(%arg31 : i32, %arg32 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.add %arg31, %arg32 overflow<nuw> : i32
  %2 = llvm.icmp "ult" %1, %arg31 : i32
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def uadd_sat_canon_nuw_after := [llvm|
{
^0(%arg31 : i32, %arg32 : i32):
  %0 = llvm.add %arg31, %arg32 overflow<nuw> : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uadd_sat_canon_nuw_proof : uadd_sat_canon_nuw_before ⊑ uadd_sat_canon_nuw_after := by
  unfold uadd_sat_canon_nuw_before uadd_sat_canon_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN uadd_sat_canon_nuw
  apply uadd_sat_canon_nuw_thm
  ---END uadd_sat_canon_nuw



def uadd_sat_canon_y_nuw_before := [llvm|
{
^0(%arg29 : i32, %arg30 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.add %arg29, %arg30 overflow<nuw> : i32
  %2 = llvm.icmp "ult" %1, %arg30 : i32
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def uadd_sat_canon_y_nuw_after := [llvm|
{
^0(%arg29 : i32, %arg30 : i32):
  %0 = llvm.add %arg29, %arg30 overflow<nuw> : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uadd_sat_canon_y_nuw_proof : uadd_sat_canon_y_nuw_before ⊑ uadd_sat_canon_y_nuw_after := by
  unfold uadd_sat_canon_y_nuw_before uadd_sat_canon_y_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN uadd_sat_canon_y_nuw
  apply uadd_sat_canon_y_nuw_thm
  ---END uadd_sat_canon_y_nuw



def uadd_sat_via_add_nonstrict_before := [llvm|
{
^0(%arg12 : i32, %arg13 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.add %arg12, %arg13 : i32
  %2 = llvm.icmp "ule" %1, %arg13 : i32
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def uadd_sat_via_add_nonstrict_after := [llvm|
{
^0(%arg12 : i32, %arg13 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.add %arg12, %arg13 : i32
  %2 = llvm.icmp "ugt" %1, %arg13 : i32
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uadd_sat_via_add_nonstrict_proof : uadd_sat_via_add_nonstrict_before ⊑ uadd_sat_via_add_nonstrict_after := by
  unfold uadd_sat_via_add_nonstrict_before uadd_sat_via_add_nonstrict_after
  simp_alive_peephole
  intros
  ---BEGIN uadd_sat_via_add_nonstrict
  apply uadd_sat_via_add_nonstrict_thm
  ---END uadd_sat_via_add_nonstrict



def uadd_sat_via_add_swapped_cmp_nonstrict_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.add %arg4, %arg5 : i32
  %2 = llvm.icmp "uge" %arg5, %1 : i32
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def uadd_sat_via_add_swapped_cmp_nonstrict_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.add %arg4, %arg5 : i32
  %2 = llvm.icmp "ult" %arg5, %1 : i32
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uadd_sat_via_add_swapped_cmp_nonstrict_proof : uadd_sat_via_add_swapped_cmp_nonstrict_before ⊑ uadd_sat_via_add_swapped_cmp_nonstrict_after := by
  unfold uadd_sat_via_add_swapped_cmp_nonstrict_before uadd_sat_via_add_swapped_cmp_nonstrict_after
  simp_alive_peephole
  intros
  ---BEGIN uadd_sat_via_add_swapped_cmp_nonstrict
  apply uadd_sat_via_add_swapped_cmp_nonstrict_thm
  ---END uadd_sat_via_add_swapped_cmp_nonstrict


