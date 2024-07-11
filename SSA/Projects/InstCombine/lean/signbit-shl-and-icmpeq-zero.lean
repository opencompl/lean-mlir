
def scalar_i32_signbit_shl_and_eq_X_is_constant1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 12345 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = llvm.shl %0, %arg0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def scalar_i32_signbit_shl_and_eq_X_is_constant1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem scalar_i32_signbit_shl_and_eq_X_is_constant1_proof : scalar_i32_signbit_shl_and_eq_X_is_constant1_before ⊑ scalar_i32_signbit_shl_and_eq_X_is_constant1_after := by
  sorry



def scalar_i32_signbit_shl_and_eq_X_is_constant2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = llvm.shl %0, %arg0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def scalar_i32_signbit_shl_and_eq_X_is_constant2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem scalar_i32_signbit_shl_and_eq_X_is_constant2_proof : scalar_i32_signbit_shl_and_eq_X_is_constant2_before ⊑ scalar_i32_signbit_shl_and_eq_X_is_constant2_after := by
  sorry



def scalar_i32_signbit_shl_and_slt_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.shl %0, %arg1 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i32_signbit_shl_and_slt_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.shl %0, %arg1 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem scalar_i32_signbit_shl_and_slt_proof : scalar_i32_signbit_shl_and_slt_before ⊑ scalar_i32_signbit_shl_and_slt_after := by
  sorry



def scalar_i32_signbit_shl_and_eq_nonzero_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = llvm.shl %0, %arg1 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i32_signbit_shl_and_eq_nonzero_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem scalar_i32_signbit_shl_and_eq_nonzero_proof : scalar_i32_signbit_shl_and_eq_nonzero_before ⊑ scalar_i32_signbit_shl_and_eq_nonzero_after := by
  sorry


