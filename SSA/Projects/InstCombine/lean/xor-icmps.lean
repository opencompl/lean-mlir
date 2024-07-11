
def slt_zero_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i4}> : () -> i4
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i4, i4) -> i1
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 2 : i64}> : (i4, i4) -> i1
  %3 = llvm.xor %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_zero_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %arg1 : i4
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i4, i4) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem slt_zero_proof : slt_zero_before ⊑ slt_zero_after := by
  sorry



def sgt_minus1_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i4, i4) -> i1
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 4 : i64}> : (i4, i4) -> i1
  %3 = llvm.xor %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_minus1_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %arg1 : i4
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i4, i4) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem sgt_minus1_proof : sgt_minus1_before ⊑ sgt_minus1_after := by
  sorry



def slt_zero_sgt_minus1_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i4, i4) -> i1
  %3 = "llvm.icmp"(%arg1, %1) <{"predicate" = 4 : i64}> : (i4, i4) -> i1
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_zero_sgt_minus1_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %arg1 : i4
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i4, i4) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem slt_zero_sgt_minus1_proof : slt_zero_sgt_minus1_before ⊑ slt_zero_sgt_minus1_after := by
  sorry



def sgt_minus1_slt_zero_sgt_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 4 : i64}> : (vector<2xi4>, vector<2xi4>) -> vector<2xi1>
  %5 = "llvm.icmp"(%arg1, %3) <{"predicate" = 2 : i64}> : (vector<2xi4>, vector<2xi4>) -> vector<2xi1>
  %6 = llvm.xor %5, %4 : vector<2xi1>
  "llvm.return"(%6) : (vector<2xi1>) -> ()
}
]
def sgt_minus1_slt_zero_sgt_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg1, %arg0 : vector<2xi4>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (vector<2xi4>, vector<2xi4>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem sgt_minus1_slt_zero_sgt_proof : sgt_minus1_slt_zero_sgt_before ⊑ sgt_minus1_slt_zero_sgt_after := by
  sorry



def test13_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %2 = llvm.xor %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test13_proof : test13_before ⊑ test13_after := by
  sorry



def test14_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %2 = llvm.xor %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test14_proof : test14_before ⊑ test14_after := by
  sorry



def xor_icmp_true_signed_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_icmp_true_signed_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem xor_icmp_true_signed_proof : xor_icmp_true_signed_before ⊑ xor_icmp_true_signed_after := by
  sorry



def xor_icmp_true_signed_commuted_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_icmp_true_signed_commuted_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem xor_icmp_true_signed_commuted_proof : xor_icmp_true_signed_commuted_before ⊑ xor_icmp_true_signed_commuted_after := by
  sorry



def xor_icmp_true_unsigned_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_icmp_true_unsigned_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem xor_icmp_true_unsigned_proof : xor_icmp_true_unsigned_before ⊑ xor_icmp_true_unsigned_after := by
  sorry



def xor_icmp_to_ne_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_icmp_to_ne_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem xor_icmp_to_ne_proof : xor_icmp_to_ne_before ⊑ xor_icmp_to_ne_after := by
  sorry



def xor_icmp_to_icmp_add_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_icmp_to_icmp_add_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -6 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem xor_icmp_to_icmp_add_proof : xor_icmp_to_icmp_add_before ⊑ xor_icmp_to_icmp_add_after := by
  sorry



def xor_icmp_invalid_range_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_icmp_invalid_range_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem xor_icmp_invalid_range_proof : xor_icmp_invalid_range_before ⊑ xor_icmp_invalid_range_after := by
  sorry


