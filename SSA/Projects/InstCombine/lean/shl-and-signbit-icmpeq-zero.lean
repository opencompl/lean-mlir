
def scalar_i8_shl_and_signbit_eq_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %arg1 : i8
  %3 = llvm.and %2, %0 : i8
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i8_shl_and_signbit_eq_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %arg1 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem scalar_i8_shl_and_signbit_eq_proof : scalar_i8_shl_and_signbit_eq_before ⊑ scalar_i8_shl_and_signbit_eq_after := by
  sorry



def scalar_i16_shl_and_signbit_eq_before := [llvm|
{
^0(%arg0 : i16, %arg1 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = -32768 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i16}> : () -> i16
  %2 = llvm.shl %arg0, %arg1 : i16
  %3 = llvm.and %2, %0 : i16
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i16, i16) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i16_shl_and_signbit_eq_after := [llvm|
{
^0(%arg0 : i16, %arg1 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i16}> : () -> i16
  %1 = llvm.shl %arg0, %arg1 : i16
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i16, i16) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem scalar_i16_shl_and_signbit_eq_proof : scalar_i16_shl_and_signbit_eq_before ⊑ scalar_i16_shl_and_signbit_eq_after := by
  sorry



def scalar_i32_shl_and_signbit_eq_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %arg1 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i32_shl_and_signbit_eq_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem scalar_i32_shl_and_signbit_eq_proof : scalar_i32_shl_and_signbit_eq_before ⊑ scalar_i32_shl_and_signbit_eq_after := by
  sorry



def scalar_i64_shl_and_signbit_eq_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -9223372036854775808 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %2 = llvm.shl %arg0, %arg1 : i64
  %3 = llvm.and %2, %0 : i64
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i64_shl_and_signbit_eq_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i64}> : () -> i64
  %1 = llvm.shl %arg0, %arg1 : i64
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i64, i64) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem scalar_i64_shl_and_signbit_eq_proof : scalar_i64_shl_and_signbit_eq_before ⊑ scalar_i64_shl_and_signbit_eq_after := by
  sorry



def scalar_i32_shl_and_signbit_ne_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %arg1 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i32_shl_and_signbit_ne_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem scalar_i32_shl_and_signbit_ne_proof : scalar_i32_shl_and_signbit_ne_before ⊑ scalar_i32_shl_and_signbit_ne_after := by
  sorry



def vec_4xi32_shl_and_signbit_eq_before := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
  %3 = llvm.shl %arg0, %arg1 : vector<4xi32>
  %4 = llvm.and %3, %0 : vector<4xi32>
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  "llvm.return"(%5) : (vector<4xi1>) -> ()
}
]
def vec_4xi32_shl_and_signbit_eq_after := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.shl %arg0, %arg1 : vector<4xi32>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  "llvm.return"(%2) : (vector<4xi1>) -> ()
}
]
theorem vec_4xi32_shl_and_signbit_eq_proof : vec_4xi32_shl_and_signbit_eq_before ⊑ vec_4xi32_shl_and_signbit_eq_after := by
  sorry



def scalar_i32_shl_and_signbit_eq_X_is_constant1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12345 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = llvm.shl %0, %arg0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def scalar_i32_shl_and_signbit_eq_X_is_constant1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12345 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.shl %0, %arg0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem scalar_i32_shl_and_signbit_eq_X_is_constant1_proof : scalar_i32_shl_and_signbit_eq_X_is_constant1_before ⊑ scalar_i32_shl_and_signbit_eq_X_is_constant1_after := by
  sorry



def scalar_i32_shl_and_signbit_eq_X_is_constant2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = llvm.shl %0, %arg0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def scalar_i32_shl_and_signbit_eq_X_is_constant2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem scalar_i32_shl_and_signbit_eq_X_is_constant2_proof : scalar_i32_shl_and_signbit_eq_X_is_constant2_before ⊑ scalar_i32_shl_and_signbit_eq_X_is_constant2_after := by
  sorry



def scalar_i32_shl_and_signbit_slt_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %arg1 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i32_shl_and_signbit_slt_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem scalar_i32_shl_and_signbit_slt_proof : scalar_i32_shl_and_signbit_slt_before ⊑ scalar_i32_shl_and_signbit_slt_after := by
  sorry



def scalar_i32_shl_and_signbit_eq_nonzero_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %arg1 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def scalar_i32_shl_and_signbit_eq_nonzero_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem scalar_i32_shl_and_signbit_eq_nonzero_proof : scalar_i32_shl_and_signbit_eq_nonzero_before ⊑ scalar_i32_shl_and_signbit_eq_nonzero_after := by
  sorry


