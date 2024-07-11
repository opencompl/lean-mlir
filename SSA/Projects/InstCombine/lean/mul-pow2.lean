
def shl_add_log_may_cause_poison_pr62175_fail_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  %2 = llvm.mul %arg1, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def shl_add_log_may_cause_poison_pr62175_fail_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  %2 = llvm.mul %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem shl_add_log_may_cause_poison_pr62175_fail_proof : shl_add_log_may_cause_poison_pr62175_fail_before ⊑ shl_add_log_may_cause_poison_pr62175_fail_after := by
  sorry



def shl_add_log_may_cause_poison_pr62175_with_nuw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  %2 = llvm.mul %arg1, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def shl_add_log_may_cause_poison_pr62175_with_nuw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = llvm.shl %arg1, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem shl_add_log_may_cause_poison_pr62175_with_nuw_proof : shl_add_log_may_cause_poison_pr62175_with_nuw_before ⊑ shl_add_log_may_cause_poison_pr62175_with_nuw_after := by
  sorry



def shl_add_log_may_cause_poison_pr62175_with_nsw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  %2 = llvm.mul %arg1, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def shl_add_log_may_cause_poison_pr62175_with_nsw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = llvm.shl %arg1, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem shl_add_log_may_cause_poison_pr62175_with_nsw_proof : shl_add_log_may_cause_poison_pr62175_with_nsw_before ⊑ shl_add_log_may_cause_poison_pr62175_with_nsw_after := by
  sorry


