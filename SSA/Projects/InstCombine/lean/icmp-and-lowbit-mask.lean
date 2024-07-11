
def src_is_mask_xor_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.add %arg1, %1 : i8
  %4 = llvm.xor %arg1, %3 : i8
  %5 = llvm.and %2, %4 : i8
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def src_is_mask_xor_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.add %arg1, %1 : i8
  %4 = llvm.xor %3, %arg1 : i8
  %5 = llvm.and %2, %4 : i8
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
theorem src_is_mask_xor_proof : src_is_mask_xor_before ⊑ src_is_mask_xor_after := by
  sorry



def src_is_mask_xor_fail_notmask_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.add %arg1, %1 : i8
  %4 = llvm.xor %arg1, %3 : i8
  %5 = llvm.xor %4, %1 : i8
  %6 = llvm.and %2, %5 : i8
  %7 = "llvm.icmp"(%6, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def src_is_mask_xor_fail_notmask_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.sub %1, %arg1 : i8
  %4 = llvm.xor %3, %arg1 : i8
  %5 = llvm.and %2, %4 : i8
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
theorem src_is_mask_xor_fail_notmask_proof : src_is_mask_xor_fail_notmask_before ⊑ src_is_mask_xor_fail_notmask_after := by
  sorry



def src_is_mask_p2_m1_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %3 = llvm.xor %arg0, %0 : i8
  %4 = llvm.shl %1, %arg1 : i8
  %5 = llvm.add %4, %2 : i8
  %6 = llvm.and %5, %3 : i8
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def src_is_mask_p2_m1_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %3 = llvm.xor %arg0, %0 : i8
  %4 = llvm.shl %1, %arg1 : i8
  %5 = llvm.add %4, %2 : i8
  %6 = llvm.and %5, %3 : i8
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
theorem src_is_mask_p2_m1_proof : src_is_mask_p2_m1_before ⊑ src_is_mask_p2_m1_after := by
  sorry



def src_is_notmask_neg_p2_fail_not_invertable_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.sub %1, %arg1 : i8
  %4 = llvm.and %3, %arg1 : i8
  %5 = llvm.sub %1, %4 : i8
  %6 = llvm.and %5, %2 : i8
  %7 = "llvm.icmp"(%1, %6) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def src_is_notmask_neg_p2_fail_not_invertable_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.sub %1, %arg1 : i8
  %4 = llvm.and %3, %arg1 : i8
  %5 = llvm.sub %1, %4 : i8
  %6 = llvm.and %2, %5 : i8
  %7 = "llvm.icmp"(%6, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
theorem src_is_notmask_neg_p2_fail_not_invertable_proof : src_is_notmask_neg_p2_fail_not_invertable_before ⊑ src_is_notmask_neg_p2_fail_not_invertable_after := by
  sorry



def src_is_mask_const_sgt_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  %4 = "llvm.icmp"(%2, %3) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def src_is_mask_const_sgt_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem src_is_mask_const_sgt_proof : src_is_mask_const_sgt_before ⊑ src_is_mask_const_sgt_after := by
  sorry



def src_is_mask_const_sge_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 31 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def src_is_mask_const_sge_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 32 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem src_is_mask_const_sge_proof : src_is_mask_const_sge_before ⊑ src_is_mask_const_sge_after := by
  sorry



def src_x_and_nmask_slt_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.and %arg0, %1 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def src_x_and_nmask_slt_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.and %1, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem src_x_and_nmask_slt_proof : src_x_and_nmask_slt_before ⊑ src_x_and_nmask_slt_after := by
  sorry



def src_x_and_nmask_sge_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.and %arg0, %1 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def src_x_and_nmask_sge_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.and %1, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem src_x_and_nmask_sge_proof : src_x_and_nmask_sge_before ⊑ src_x_and_nmask_sge_after := by
  sorry


