
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
section gshlhdemand_statements

def src_srem_shl_demand_max_signbit_before := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(30 : i32) : i32
  %2 = llvm.mlir.constant(-2147483648 : i32) : i32
  %3 = llvm.srem %arg24, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_max_signbit_after := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.srem %arg24, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_srem_shl_demand_max_signbit_proof : src_srem_shl_demand_max_signbit_before ⊑ src_srem_shl_demand_max_signbit_after := by
  unfold src_srem_shl_demand_max_signbit_before src_srem_shl_demand_max_signbit_after
  simp_alive_peephole
  intros
  ---BEGIN src_srem_shl_demand_max_signbit
  all_goals (try extract_goal ; sorry)
  ---END src_srem_shl_demand_max_signbit



def src_srem_shl_demand_min_signbit_before := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(-2147483648 : i32) : i32
  %3 = llvm.srem %arg23, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_min_signbit_after := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(1073741823 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.srem %arg23, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_srem_shl_demand_min_signbit_proof : src_srem_shl_demand_min_signbit_before ⊑ src_srem_shl_demand_min_signbit_after := by
  unfold src_srem_shl_demand_min_signbit_before src_srem_shl_demand_min_signbit_after
  simp_alive_peephole
  intros
  ---BEGIN src_srem_shl_demand_min_signbit
  all_goals (try extract_goal ; sorry)
  ---END src_srem_shl_demand_min_signbit



def src_srem_shl_demand_max_mask_before := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(-4 : i32) : i32
  %3 = llvm.srem %arg22, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_max_mask_after := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-4 : i32) : i32
  %2 = llvm.srem %arg22, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_srem_shl_demand_max_mask_proof : src_srem_shl_demand_max_mask_before ⊑ src_srem_shl_demand_max_mask_after := by
  unfold src_srem_shl_demand_max_mask_before src_srem_shl_demand_max_mask_after
  simp_alive_peephole
  intros
  ---BEGIN src_srem_shl_demand_max_mask
  all_goals (try extract_goal ; sorry)
  ---END src_srem_shl_demand_max_mask



def src_srem_shl_demand_max_signbit_mask_hit_first_demand_before := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(29 : i32) : i32
  %2 = llvm.mlir.constant(-1073741824 : i32) : i32
  %3 = llvm.srem %arg21, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_max_signbit_mask_hit_first_demand_after := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(29 : i32) : i32
  %2 = llvm.mlir.constant(-1073741824 : i32) : i32
  %3 = llvm.srem %arg21, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw> : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_srem_shl_demand_max_signbit_mask_hit_first_demand_proof : src_srem_shl_demand_max_signbit_mask_hit_first_demand_before ⊑ src_srem_shl_demand_max_signbit_mask_hit_first_demand_after := by
  unfold src_srem_shl_demand_max_signbit_mask_hit_first_demand_before src_srem_shl_demand_max_signbit_mask_hit_first_demand_after
  simp_alive_peephole
  intros
  ---BEGIN src_srem_shl_demand_max_signbit_mask_hit_first_demand
  all_goals (try extract_goal ; sorry)
  ---END src_srem_shl_demand_max_signbit_mask_hit_first_demand



def src_srem_shl_demand_min_signbit_mask_hit_last_demand_before := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(536870912 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(-1073741822 : i32) : i32
  %3 = llvm.srem %arg20, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_min_signbit_mask_hit_last_demand_after := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(536870912 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(-1073741822 : i32) : i32
  %3 = llvm.srem %arg20, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw> : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_srem_shl_demand_min_signbit_mask_hit_last_demand_proof : src_srem_shl_demand_min_signbit_mask_hit_last_demand_before ⊑ src_srem_shl_demand_min_signbit_mask_hit_last_demand_after := by
  unfold src_srem_shl_demand_min_signbit_mask_hit_last_demand_before src_srem_shl_demand_min_signbit_mask_hit_last_demand_after
  simp_alive_peephole
  intros
  ---BEGIN src_srem_shl_demand_min_signbit_mask_hit_last_demand
  all_goals (try extract_goal ; sorry)
  ---END src_srem_shl_demand_min_signbit_mask_hit_last_demand



def src_srem_shl_demand_eliminate_signbit_before := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.srem %arg19, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_eliminate_signbit_after := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.srem %arg19, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw> : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_srem_shl_demand_eliminate_signbit_proof : src_srem_shl_demand_eliminate_signbit_before ⊑ src_srem_shl_demand_eliminate_signbit_after := by
  unfold src_srem_shl_demand_eliminate_signbit_before src_srem_shl_demand_eliminate_signbit_after
  simp_alive_peephole
  intros
  ---BEGIN src_srem_shl_demand_eliminate_signbit
  all_goals (try extract_goal ; sorry)
  ---END src_srem_shl_demand_eliminate_signbit



def src_srem_shl_demand_max_mask_hit_demand_before := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(-4 : i32) : i32
  %3 = llvm.srem %arg18, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_max_mask_hit_demand_after := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(-4 : i32) : i32
  %3 = llvm.srem %arg18, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw> : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_srem_shl_demand_max_mask_hit_demand_proof : src_srem_shl_demand_max_mask_hit_demand_before ⊑ src_srem_shl_demand_max_mask_hit_demand_after := by
  unfold src_srem_shl_demand_max_mask_hit_demand_before src_srem_shl_demand_max_mask_hit_demand_after
  simp_alive_peephole
  intros
  ---BEGIN src_srem_shl_demand_max_mask_hit_demand
  all_goals (try extract_goal ; sorry)
  ---END src_srem_shl_demand_max_mask_hit_demand



def sext_shl_trunc_same_size_before := [llvm|
{
^0(%arg13 : i16, %arg14 : i32):
  %0 = llvm.sext %arg13 : i16 to i32
  %1 = llvm.shl %0, %arg14 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def sext_shl_trunc_same_size_after := [llvm|
{
^0(%arg13 : i16, %arg14 : i32):
  %0 = llvm.zext %arg13 : i16 to i32
  %1 = llvm.shl %0, %arg14 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_shl_trunc_same_size_proof : sext_shl_trunc_same_size_before ⊑ sext_shl_trunc_same_size_after := by
  unfold sext_shl_trunc_same_size_before sext_shl_trunc_same_size_after
  simp_alive_peephole
  intros
  ---BEGIN sext_shl_trunc_same_size
  all_goals (try extract_goal ; sorry)
  ---END sext_shl_trunc_same_size



def sext_shl_trunc_smaller_before := [llvm|
{
^0(%arg11 : i16, %arg12 : i32):
  %0 = llvm.sext %arg11 : i16 to i32
  %1 = llvm.shl %0, %arg12 : i32
  %2 = llvm.trunc %1 : i32 to i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def sext_shl_trunc_smaller_after := [llvm|
{
^0(%arg11 : i16, %arg12 : i32):
  %0 = llvm.zext %arg11 : i16 to i32
  %1 = llvm.shl %0, %arg12 : i32
  %2 = llvm.trunc %1 : i32 to i5
  "llvm.return"(%2) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_shl_trunc_smaller_proof : sext_shl_trunc_smaller_before ⊑ sext_shl_trunc_smaller_after := by
  unfold sext_shl_trunc_smaller_before sext_shl_trunc_smaller_after
  simp_alive_peephole
  intros
  ---BEGIN sext_shl_trunc_smaller
  all_goals (try extract_goal ; sorry)
  ---END sext_shl_trunc_smaller



def sext_shl_mask_before := [llvm|
{
^0(%arg7 : i16, %arg8 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.sext %arg7 : i16 to i32
  %2 = llvm.shl %1, %arg8 : i32
  %3 = llvm.and %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sext_shl_mask_after := [llvm|
{
^0(%arg7 : i16, %arg8 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.zext %arg7 : i16 to i32
  %2 = llvm.shl %1, %arg8 : i32
  %3 = llvm.and %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_shl_mask_proof : sext_shl_mask_before ⊑ sext_shl_mask_after := by
  unfold sext_shl_mask_before sext_shl_mask_after
  simp_alive_peephole
  intros
  ---BEGIN sext_shl_mask
  all_goals (try extract_goal ; sorry)
  ---END sext_shl_mask



def set_shl_mask_before := [llvm|
{
^0(%arg3 : i32, %arg4 : i32):
  %0 = llvm.mlir.constant(196609 : i32) : i32
  %1 = llvm.mlir.constant(65536 : i32) : i32
  %2 = llvm.or %arg3, %0 : i32
  %3 = llvm.shl %2, %arg4 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def set_shl_mask_after := [llvm|
{
^0(%arg3 : i32, %arg4 : i32):
  %0 = llvm.mlir.constant(65537 : i32) : i32
  %1 = llvm.mlir.constant(65536 : i32) : i32
  %2 = llvm.or %arg3, %0 : i32
  %3 = llvm.shl %2, %arg4 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem set_shl_mask_proof : set_shl_mask_before ⊑ set_shl_mask_after := by
  unfold set_shl_mask_before set_shl_mask_after
  simp_alive_peephole
  intros
  ---BEGIN set_shl_mask
  all_goals (try extract_goal ; sorry)
  ---END set_shl_mask



def must_drop_poison_before := [llvm|
{
^0(%arg1 : i32, %arg2 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.and %arg1, %0 : i32
  %2 = llvm.shl %1, %arg2 overflow<nsw,nuw> : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def must_drop_poison_after := [llvm|
{
^0(%arg1 : i32, %arg2 : i32):
  %0 = llvm.shl %arg1, %arg2 : i32
  %1 = llvm.trunc %0 : i32 to i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem must_drop_poison_proof : must_drop_poison_before ⊑ must_drop_poison_after := by
  unfold must_drop_poison_before must_drop_poison_after
  simp_alive_peephole
  intros
  ---BEGIN must_drop_poison
  all_goals (try extract_goal ; sorry)
  ---END must_drop_poison



def f_t15_t01_t09_before := [llvm|
{
^0(%arg0 : i40):
  %0 = llvm.mlir.constant(31 : i40) : i40
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(31 : i32) : i32
  %3 = llvm.ashr %arg0, %0 : i40
  %4 = llvm.trunc %3 : i40 to i32
  %5 = llvm.shl %4, %1 : i32
  %6 = llvm.ashr %5, %1 : i32
  %7 = llvm.shl %6, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def f_t15_t01_t09_after := [llvm|
{
^0(%arg0 : i40):
  %0 = llvm.mlir.constant(15 : i40) : i40
  %1 = llvm.mlir.constant(-65536 : i32) : i32
  %2 = llvm.ashr %arg0, %0 : i40
  %3 = llvm.trunc %2 overflow<nsw> : i40 to i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem f_t15_t01_t09_proof : f_t15_t01_t09_before ⊑ f_t15_t01_t09_after := by
  unfold f_t15_t01_t09_before f_t15_t01_t09_after
  simp_alive_peephole
  intros
  ---BEGIN f_t15_t01_t09
  all_goals (try extract_goal ; sorry)
  ---END f_t15_t01_t09


