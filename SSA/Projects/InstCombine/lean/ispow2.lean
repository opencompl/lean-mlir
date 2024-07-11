
def is_pow2_fail_pr63327_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  %2 = llvm.and %arg0, %1 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def is_pow2_fail_pr63327_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem is_pow2_fail_pr63327_proof : is_pow2_fail_pr63327_before ⊑ is_pow2_fail_pr63327_after := by
  sorry



def blsmsk_isnt_p2_or_z_fail_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  %2 = llvm.xor %arg0, %1 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 7 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def blsmsk_isnt_p2_or_z_fail_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  %2 = llvm.xor %1, %arg0 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 7 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem blsmsk_isnt_p2_or_z_fail_proof : blsmsk_isnt_p2_or_z_fail_before ⊑ blsmsk_isnt_p2_or_z_fail_after := by
  sorry



def blsmsk_isnt_p2_or_z_fail_wrong_add_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.add %arg1, %0 : i32
  %2 = llvm.xor %arg0, %1 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def blsmsk_isnt_p2_or_z_fail_wrong_add_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.add %arg1, %0 : i32
  %2 = llvm.xor %1, %arg0 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem blsmsk_isnt_p2_or_z_fail_wrong_add_proof : blsmsk_isnt_p2_or_z_fail_wrong_add_before ⊑ blsmsk_isnt_p2_or_z_fail_wrong_add_after := by
  sorry



def blsmsk_isnt_p2_or_z_fail_bad_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  %2 = llvm.xor %arg1, %1 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def blsmsk_isnt_p2_or_z_fail_bad_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem blsmsk_isnt_p2_or_z_fail_bad_xor_proof : blsmsk_isnt_p2_or_z_fail_bad_xor_before ⊑ blsmsk_isnt_p2_or_z_fail_bad_xor_after := by
  sorry



def blsmsk_is_p2_or_z_fail_bad_cmp_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  %2 = llvm.xor %arg0, %1 : i32
  %3 = "llvm.icmp"(%2, %arg1) <{"predicate" = 9 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def blsmsk_is_p2_or_z_fail_bad_cmp_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  %2 = llvm.xor %1, %arg0 : i32
  %3 = "llvm.icmp"(%2, %arg1) <{"predicate" = 9 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem blsmsk_is_p2_or_z_fail_bad_cmp_proof : blsmsk_is_p2_or_z_fail_bad_cmp_before ⊑ blsmsk_is_p2_or_z_fail_bad_cmp_after := by
  sorry


