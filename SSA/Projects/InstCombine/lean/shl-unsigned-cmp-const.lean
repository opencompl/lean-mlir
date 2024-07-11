
def scalar_i8_shl_ult_const_1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 64 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i8_shl_ult_const_1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem scalar_i8_shl_ult_const_1_proof : scalar_i8_shl_ult_const_1_before ⊑ scalar_i8_shl_ult_const_1_after := by
  sorry



def scalar_i8_shl_ult_const_2_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 64 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i8_shl_ult_const_2_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem scalar_i8_shl_ult_const_2_proof : scalar_i8_shl_ult_const_2_before ⊑ scalar_i8_shl_ult_const_2_after := by
  sorry



def scalar_i8_shl_ult_const_3_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 64 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i8_shl_ult_const_3_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem scalar_i8_shl_ult_const_3_proof : scalar_i8_shl_ult_const_3_before ⊑ scalar_i8_shl_ult_const_3_after := by
  sorry



def scalar_i16_shl_ult_const_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{"value" = 1024 : i16}> : () -> i16
  %2 = llvm.shl %arg0, %0 : i16
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i16, i16) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i16_shl_ult_const_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 252 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i16}> : () -> i16
  %2 = llvm.and %arg0, %0 : i16
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i16, i16) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem scalar_i16_shl_ult_const_proof : scalar_i16_shl_ult_const_before ⊑ scalar_i16_shl_ult_const_after := by
  sorry



def scalar_i32_shl_ult_const_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 11 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 131072 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i32_shl_ult_const_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2097088 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem scalar_i32_shl_ult_const_proof : scalar_i32_shl_ult_const_before ⊑ scalar_i32_shl_ult_const_after := by
  sorry



def scalar_i64_shl_ult_const_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 25 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 8589934592 : i64}> : () -> i64
  %2 = llvm.shl %arg0, %0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i64_shl_ult_const_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 549755813632 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %2 = llvm.and %arg0, %0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem scalar_i64_shl_ult_const_proof : scalar_i64_shl_ult_const_before ⊑ scalar_i64_shl_ult_const_after := by
  sorry



def scalar_i8_shl_uge_const_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 64 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i8_shl_uge_const_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem scalar_i8_shl_uge_const_proof : scalar_i8_shl_uge_const_before ⊑ scalar_i8_shl_uge_const_after := by
  sorry



def scalar_i8_shl_ule_const_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 63 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i8_shl_ule_const_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem scalar_i8_shl_ule_const_proof : scalar_i8_shl_ule_const_before ⊑ scalar_i8_shl_ule_const_after := by
  sorry



def scalar_i8_shl_ugt_const_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 63 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i8_shl_ugt_const_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem scalar_i8_shl_ugt_const_proof : scalar_i8_shl_ugt_const_before ⊑ scalar_i8_shl_ugt_const_after := by
  sorry



def vector_4xi32_shl_ult_const_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<11> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<131072> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.shl %arg0, %0 : vector<4xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  "llvm.return"(%3) : (vector<4xi1>) -> ()
}
]
def vector_4xi32_shl_ult_const_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2097088> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
  %3 = llvm.and %arg0, %0 : vector<4xi32>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 0 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  "llvm.return"(%4) : (vector<4xi1>) -> ()
}
]
theorem vector_4xi32_shl_ult_const_proof : vector_4xi32_shl_ult_const_before ⊑ vector_4xi32_shl_ult_const_after := by
  sorry



def vector_4xi32_shl_uge_const_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<11> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<131072> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.shl %arg0, %0 : vector<4xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 9 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  "llvm.return"(%3) : (vector<4xi1>) -> ()
}
]
def vector_4xi32_shl_uge_const_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2097088> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
  %3 = llvm.and %arg0, %0 : vector<4xi32>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 1 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  "llvm.return"(%4) : (vector<4xi1>) -> ()
}
]
theorem vector_4xi32_shl_uge_const_proof : vector_4xi32_shl_uge_const_before ⊑ vector_4xi32_shl_uge_const_after := by
  sorry



def vector_4xi32_shl_ule_const_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<11> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<131071> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.shl %arg0, %0 : vector<4xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 7 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  "llvm.return"(%3) : (vector<4xi1>) -> ()
}
]
def vector_4xi32_shl_ule_const_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2097088> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
  %3 = llvm.and %arg0, %0 : vector<4xi32>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 0 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  "llvm.return"(%4) : (vector<4xi1>) -> ()
}
]
theorem vector_4xi32_shl_ule_const_proof : vector_4xi32_shl_ule_const_before ⊑ vector_4xi32_shl_ule_const_after := by
  sorry



def vector_4xi32_shl_ugt_const_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<11> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<131071> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.shl %arg0, %0 : vector<4xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  "llvm.return"(%3) : (vector<4xi1>) -> ()
}
]
def vector_4xi32_shl_ugt_const_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2097088> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
  %3 = llvm.and %arg0, %0 : vector<4xi32>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 1 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  "llvm.return"(%4) : (vector<4xi1>) -> ()
}
]
theorem vector_4xi32_shl_ugt_const_proof : vector_4xi32_shl_ugt_const_before ⊑ vector_4xi32_shl_ugt_const_after := by
  sorry


