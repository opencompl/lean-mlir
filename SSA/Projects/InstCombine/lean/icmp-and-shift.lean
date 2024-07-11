
def eq_and_shl_one_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.and %1, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_and_shl_one_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg1 : i8
  %3 = llvm.and %2, %arg0 : i8
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem eq_and_shl_one_proof : eq_and_shl_one_before ⊑ eq_and_shl_one_after := by
  sorry



def eq_and_shl_two_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.and %arg0, %1 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_and_shl_two_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.and %1, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem eq_and_shl_two_proof : eq_and_shl_two_before ⊑ eq_and_shl_two_after := by
  sorry



def slt_and_shl_one_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.and %arg0, %1 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_and_shl_one_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.and %1, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem slt_and_shl_one_proof : slt_and_shl_one_before ⊑ slt_and_shl_one_after := by
  sorry



def fold_ne_rhs_fail_shift_not_1s_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = llvm.xor %arg1, %0 : i8
  %4 = llvm.shl %1, %arg0 : i8
  %5 = llvm.and %3, %4 : i8
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def fold_ne_rhs_fail_shift_not_1s_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 122 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = llvm.xor %arg1, %0 : i8
  %4 = llvm.shl %1, %arg0 : i8
  %5 = llvm.and %3, %4 : i8
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
theorem fold_ne_rhs_fail_shift_not_1s_proof : fold_ne_rhs_fail_shift_not_1s_before ⊑ fold_ne_rhs_fail_shift_not_1s_after := by
  sorry


