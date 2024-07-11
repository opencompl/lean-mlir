
def test1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def invert_icmp_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i32, i32) -> i1
  %2 = llvm.xor %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def invert_icmp_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem invert_icmp_proof : invert_icmp_before ⊑ invert_icmp_after := by
  sorry



def not_not_cmp_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def not_not_cmp_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem not_not_cmp_proof : not_not_cmp_before ⊑ not_not_cmp_after := by
  sorry



def not_not_cmp_vector_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.xor %arg0, %0 : vector<2xi32>
  %2 = llvm.xor %arg1, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 8 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def not_not_cmp_vector_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
theorem not_not_cmp_vector_proof : not_not_cmp_vector_before ⊑ not_not_cmp_vector_after := by
  sorry



def not_cmp_constant_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 42 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def not_cmp_constant_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -43 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem not_cmp_constant_proof : not_cmp_constant_before ⊑ not_cmp_constant_after := by
  sorry



def not_cmp_constant_vector_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.xor %arg0, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def not_cmp_constant_vector_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-43> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem not_cmp_constant_vector_proof : not_cmp_constant_vector_before ⊑ not_cmp_constant_vector_after := by
  sorry



def test7_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = llvm.xor %2, %1 : vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  sorry



def not_sub_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def not_sub_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -124 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem not_sub_proof : not_sub_before ⊑ not_sub_after := by
  sorry



def not_sub_splat_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<123> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.sub %0, %arg0 : vector<2xi32>
  %3 = llvm.xor %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def not_sub_splat_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-124> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.add %arg0, %0 : vector<2xi32>
  "llvm.return"(%1) : (vector<2xi32>) -> ()
}
]
theorem not_sub_splat_proof : not_sub_splat_before ⊑ not_sub_splat_after := by
  sorry



def not_sub_vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[42, 123]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.sub %0, %arg0 : vector<2xi32>
  %3 = llvm.xor %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def not_sub_vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-43, -124]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.add %arg0, %0 : vector<2xi32>
  "llvm.return"(%1) : (vector<2xi32>) -> ()
}
]
theorem not_sub_vec_proof : not_sub_vec_before ⊑ not_sub_vec_after := by
  sorry



def not_add_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def not_add_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -124 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem not_add_proof : not_add_before ⊑ not_add_after := by
  sorry



def not_add_splat_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<123> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = llvm.xor %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def not_add_splat_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-124> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.sub %0, %arg0 : vector<2xi32>
  "llvm.return"(%1) : (vector<2xi32>) -> ()
}
]
theorem not_add_splat_proof : not_add_splat_before ⊑ not_add_splat_after := by
  sorry



def not_add_vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[42, 123]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = llvm.xor %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def not_add_vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-43, -124]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.sub %0, %arg0 : vector<2xi32>
  "llvm.return"(%1) : (vector<2xi32>) -> ()
}
]
theorem not_add_vec_proof : not_add_vec_before ⊑ not_add_vec_after := by
  sorry



def not_or_neg_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg1 : i8
  %3 = llvm.or %2, %arg0 : i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def not_or_neg_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.add %arg1, %0 : i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.and %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem not_or_neg_proof : not_or_neg_before ⊑ not_or_neg_after := by
  sorry



def invert_both_cmp_operands_add_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.add %arg1, %2 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def invert_both_cmp_operands_add_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.sub %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem invert_both_cmp_operands_add_proof : invert_both_cmp_operands_add_before ⊑ invert_both_cmp_operands_add_after := by
  sorry



def invert_both_cmp_operands_sub_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 42 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.sub %2, %arg1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def invert_both_cmp_operands_sub_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -43 : i32}> : () -> i32
  %1 = llvm.add %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem invert_both_cmp_operands_sub_proof : invert_both_cmp_operands_sub_before ⊑ invert_both_cmp_operands_sub_after := by
  sorry



def test_invert_demorgan_and3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 4095 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.add %arg1, %3 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test_invert_demorgan_and3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 4095 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.add %3, %arg1 : i32
  %5 = llvm.and %4, %1 : i32
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
theorem test_invert_demorgan_and3_proof : test_invert_demorgan_and3_before ⊑ test_invert_demorgan_and3_after := by
  sorry


