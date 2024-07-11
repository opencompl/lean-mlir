
def icmp_ugt_32_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 32 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 4294967295 : i64}> : () -> i64
  %2 = llvm.shl %arg0, %0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ugt_32_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_ugt_32_proof : icmp_ugt_32_before ⊑ icmp_ugt_32_after := by
  sorry



def icmp_ule_64_before := [llvm|
{
^0(%arg0 : i128):
  %0 = "llvm.mlir.constant"() <{"value" = 64 : i128}> : () -> i128
  %1 = "llvm.mlir.constant"() <{"value" = 18446744073709551615 : i128}> : () -> i128
  %2 = llvm.shl %arg0, %0 : i128
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 7 : i64}> : (i128, i128) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ule_64_after := [llvm|
{
^0(%arg0 : i128):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i128}> : () -> i128
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i128, i128) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_ule_64_proof : icmp_ule_64_before ⊑ icmp_ule_64_after := by
  sorry



def icmp_ugt_16_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 16 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 1048575 : i64}> : () -> i64
  %2 = llvm.shl %arg0, %0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ugt_16_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i64}> : () -> i64
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i64, i64) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_ugt_16_proof : icmp_ugt_16_before ⊑ icmp_ugt_16_after := by
  sorry



def icmp_ule_16x2_before := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<16> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = "llvm.mlir.constant"() <{"value" = dense<65535> : vector<2xi64>}> : () -> vector<2xi64>
  %2 = llvm.shl %arg0, %0 : vector<2xi64>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 7 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def icmp_ule_16x2_after := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi64>}> : () -> vector<2xi64>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem icmp_ule_16x2_proof : icmp_ule_16x2_before ⊑ icmp_ule_16x2_after := by
  sorry



def icmp_ule_16x2_nonzero_before := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<16> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = "llvm.mlir.constant"() <{"value" = dense<196608> : vector<2xi64>}> : () -> vector<2xi64>
  %2 = llvm.shl %arg0, %0 : vector<2xi64>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 7 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def icmp_ule_16x2_nonzero_after := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem icmp_ule_16x2_nonzero_proof : icmp_ule_16x2_nonzero_before ⊑ icmp_ule_16x2_nonzero_after := by
  sorry



def icmp_ule_12x2_before := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<12> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = "llvm.mlir.constant"() <{"value" = dense<12288> : vector<2xi64>}> : () -> vector<2xi64>
  %2 = llvm.shl %arg0, %0 : vector<2xi64>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 7 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def icmp_ule_12x2_after := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem icmp_ule_12x2_proof : icmp_ule_12x2_before ⊑ icmp_ule_12x2_after := by
  sorry



def icmp_ult_8_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 4095 : i64}> : () -> i64
  %2 = llvm.shl %arg0, %0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ult_8_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 16 : i64}> : () -> i64
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i64, i64) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_ult_8_proof : icmp_ult_8_before ⊑ icmp_ult_8_after := by
  sorry



def icmp_uge_8x2_before := [llvm|
{
^0(%arg0 : vector<2xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<2xi16>}> : () -> vector<2xi16>
  %1 = "llvm.mlir.constant"() <{"value" = dense<4095> : vector<2xi16>}> : () -> vector<2xi16>
  %2 = llvm.shl %arg0, %0 : vector<2xi16>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 9 : i64}> : (vector<2xi16>, vector<2xi16>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def icmp_uge_8x2_after := [llvm|
{
^0(%arg0 : vector<2xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi16>}> : () -> vector<2xi16>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (vector<2xi16>, vector<2xi16>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem icmp_uge_8x2_proof : icmp_uge_8x2_before ⊑ icmp_uge_8x2_after := by
  sorry



def icmp_ugt_16x2_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<16> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<1048575> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.shl %arg0, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def icmp_ugt_16x2_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem icmp_ugt_16x2_proof : icmp_ugt_16x2_before ⊑ icmp_ugt_16x2_after := by
  sorry


