import SSA.Projects.InstCombine.tests.proofs.gshlhdemand_proof
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
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 30 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -2147483648 : i32}> : () -> i32
  %3 = llvm.srem %arg24, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_max_signbit_after := [llvm|
{
^0(%arg24 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2147483648 : i32}> : () -> i32
  %2 = llvm.srem %arg24, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem src_srem_shl_demand_max_signbit_proof : src_srem_shl_demand_max_signbit_before ⊑ src_srem_shl_demand_max_signbit_after := by
  unfold src_srem_shl_demand_max_signbit_before src_srem_shl_demand_max_signbit_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN src_srem_shl_demand_max_signbit
  apply src_srem_shl_demand_max_signbit_thm
  ---END src_srem_shl_demand_max_signbit



def src_srem_shl_demand_min_signbit_before := [llvm|
{
^0(%arg23 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1073741823 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -2147483648 : i32}> : () -> i32
  %3 = llvm.srem %arg23, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_min_signbit_after := [llvm|
{
^0(%arg23 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1073741823 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -2147483648 : i32}> : () -> i32
  %2 = llvm.srem %arg23, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem src_srem_shl_demand_min_signbit_proof : src_srem_shl_demand_min_signbit_before ⊑ src_srem_shl_demand_min_signbit_after := by
  unfold src_srem_shl_demand_min_signbit_before src_srem_shl_demand_min_signbit_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN src_srem_shl_demand_min_signbit
  apply src_srem_shl_demand_min_signbit_thm
  ---END src_srem_shl_demand_min_signbit



def src_srem_shl_demand_max_mask_before := [llvm|
{
^0(%arg22 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -4 : i32}> : () -> i32
  %3 = llvm.srem %arg22, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_max_mask_after := [llvm|
{
^0(%arg22 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -4 : i32}> : () -> i32
  %2 = llvm.srem %arg22, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem src_srem_shl_demand_max_mask_proof : src_srem_shl_demand_max_mask_before ⊑ src_srem_shl_demand_max_mask_after := by
  unfold src_srem_shl_demand_max_mask_before src_srem_shl_demand_max_mask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN src_srem_shl_demand_max_mask
  apply src_srem_shl_demand_max_mask_thm
  ---END src_srem_shl_demand_max_mask



def src_srem_shl_demand_max_signbit_mask_hit_first_demand_before := [llvm|
{
^0(%arg21 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 29 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -1073741824 : i32}> : () -> i32
  %3 = llvm.srem %arg21, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_max_signbit_mask_hit_first_demand_after := [llvm|
{
^0(%arg21 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 29 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -1073741824 : i32}> : () -> i32
  %3 = llvm.srem %arg21, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw> : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem src_srem_shl_demand_max_signbit_mask_hit_first_demand_proof : src_srem_shl_demand_max_signbit_mask_hit_first_demand_before ⊑ src_srem_shl_demand_max_signbit_mask_hit_first_demand_after := by
  unfold src_srem_shl_demand_max_signbit_mask_hit_first_demand_before src_srem_shl_demand_max_signbit_mask_hit_first_demand_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN src_srem_shl_demand_max_signbit_mask_hit_first_demand
  apply src_srem_shl_demand_max_signbit_mask_hit_first_demand_thm
  ---END src_srem_shl_demand_max_signbit_mask_hit_first_demand



def src_srem_shl_demand_min_signbit_mask_hit_last_demand_before := [llvm|
{
^0(%arg20 : i32):
  %0 = "llvm.mlir.constant"() <{value = 536870912 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -1073741822 : i32}> : () -> i32
  %3 = llvm.srem %arg20, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_min_signbit_mask_hit_last_demand_after := [llvm|
{
^0(%arg20 : i32):
  %0 = "llvm.mlir.constant"() <{value = 536870912 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -1073741822 : i32}> : () -> i32
  %3 = llvm.srem %arg20, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw> : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem src_srem_shl_demand_min_signbit_mask_hit_last_demand_proof : src_srem_shl_demand_min_signbit_mask_hit_last_demand_before ⊑ src_srem_shl_demand_min_signbit_mask_hit_last_demand_after := by
  unfold src_srem_shl_demand_min_signbit_mask_hit_last_demand_before src_srem_shl_demand_min_signbit_mask_hit_last_demand_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN src_srem_shl_demand_min_signbit_mask_hit_last_demand
  apply src_srem_shl_demand_min_signbit_mask_hit_last_demand_thm
  ---END src_srem_shl_demand_min_signbit_mask_hit_last_demand



def src_srem_shl_demand_eliminate_signbit_before := [llvm|
{
^0(%arg19 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1073741824 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %3 = llvm.srem %arg19, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_eliminate_signbit_after := [llvm|
{
^0(%arg19 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1073741824 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %3 = llvm.srem %arg19, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw> : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem src_srem_shl_demand_eliminate_signbit_proof : src_srem_shl_demand_eliminate_signbit_before ⊑ src_srem_shl_demand_eliminate_signbit_after := by
  unfold src_srem_shl_demand_eliminate_signbit_before src_srem_shl_demand_eliminate_signbit_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN src_srem_shl_demand_eliminate_signbit
  apply src_srem_shl_demand_eliminate_signbit_thm
  ---END src_srem_shl_demand_eliminate_signbit



def src_srem_shl_demand_max_mask_hit_demand_before := [llvm|
{
^0(%arg18 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -4 : i32}> : () -> i32
  %3 = llvm.srem %arg18, %0 : i32
  %4 = llvm.shl %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src_srem_shl_demand_max_mask_hit_demand_after := [llvm|
{
^0(%arg18 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -4 : i32}> : () -> i32
  %3 = llvm.srem %arg18, %0 : i32
  %4 = llvm.shl %3, %1 overflow<nsw> : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem src_srem_shl_demand_max_mask_hit_demand_proof : src_srem_shl_demand_max_mask_hit_demand_before ⊑ src_srem_shl_demand_max_mask_hit_demand_after := by
  unfold src_srem_shl_demand_max_mask_hit_demand_before src_srem_shl_demand_max_mask_hit_demand_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN src_srem_shl_demand_max_mask_hit_demand
  apply src_srem_shl_demand_max_mask_hit_demand_thm
  ---END src_srem_shl_demand_max_mask_hit_demand



def set_shl_mask_before := [llvm|
{
^0(%arg3 : i32, %arg4 : i32):
  %0 = "llvm.mlir.constant"() <{value = 196609 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 65536 : i32}> : () -> i32
  %2 = llvm.or %arg3, %0 : i32
  %3 = llvm.shl %2, %arg4 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def set_shl_mask_after := [llvm|
{
^0(%arg3 : i32, %arg4 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65537 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 65536 : i32}> : () -> i32
  %2 = llvm.or %arg3, %0 : i32
  %3 = llvm.shl %2, %arg4 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem set_shl_mask_proof : set_shl_mask_before ⊑ set_shl_mask_after := by
  unfold set_shl_mask_before set_shl_mask_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN set_shl_mask
  apply set_shl_mask_thm
  ---END set_shl_mask


