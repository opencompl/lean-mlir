
def masked_and_notallzeroes_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 39 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %2 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_and_notallzeroes_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_and_notallzeroes_proof : masked_and_notallzeroes_before ⊑ masked_and_notallzeroes_after := by
  sorry



def masked_and_notallzeroes_splat_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<7> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = "llvm.mlir.constant"() <{"value" = dense<39> : vector<2xi32>}> : () -> vector<2xi32>
  %4 = llvm.and %arg0, %0 : vector<2xi32>
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %6 = llvm.and %arg0, %3 : vector<2xi32>
  %7 = "llvm.icmp"(%6, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %8 = llvm.and %5, %7 : vector<2xi1>
  "llvm.return"(%8) : (vector<2xi1>) -> ()
}
]
def masked_and_notallzeroes_splat_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<7> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = llvm.and %arg0, %0 : vector<2xi32>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
theorem masked_and_notallzeroes_splat_proof : masked_and_notallzeroes_splat_before ⊑ masked_and_notallzeroes_splat_after := by
  sorry



def masked_or_allzeroes_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 39 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %2 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_or_allzeroes_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_or_allzeroes_proof : masked_or_allzeroes_before ⊑ masked_or_allzeroes_after := by
  sorry



def masked_and_notallones_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 39 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %arg0, %1 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def masked_and_notallones_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem masked_and_notallones_proof : masked_and_notallones_before ⊑ masked_and_notallones_after := by
  sorry



def masked_or_allones_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 39 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %arg0, %1 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.or %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def masked_or_allones_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem masked_or_allones_proof : masked_or_allones_before ⊑ masked_or_allones_after := by
  sorry



def masked_and_notA_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 14 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 78 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %arg0, %1 : i32
  %5 = "llvm.icmp"(%4, %arg0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def masked_and_notA_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -79 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_and_notA_proof : masked_and_notA_before ⊑ masked_and_notA_after := by
  sorry



def masked_and_notA_slightly_optimized_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 39 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %arg0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def masked_and_notA_slightly_optimized_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -40 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_and_notA_slightly_optimized_proof : masked_and_notA_slightly_optimized_before ⊑ masked_and_notA_slightly_optimized_after := by
  sorry



def masked_or_A_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 14 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 78 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %arg0, %1 : i32
  %5 = "llvm.icmp"(%4, %arg0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.or %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def masked_or_A_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -79 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_or_A_proof : masked_or_A_before ⊑ masked_or_A_after := by
  sorry



def masked_or_A_slightly_optimized_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 39 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %arg0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = llvm.or %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def masked_or_A_slightly_optimized_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -40 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_or_A_slightly_optimized_proof : masked_or_A_slightly_optimized_before ⊑ masked_or_A_slightly_optimized_after := by
  sorry



def nomask_lhs_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = llvm.or %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def nomask_lhs_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem nomask_lhs_proof : nomask_lhs_before ⊑ nomask_lhs_after := by
  sorry



def nomask_rhs_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def nomask_rhs_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem nomask_rhs_proof : nomask_rhs_before ⊑ nomask_rhs_after := by
  sorry



def fold_mask_cmps_to_false_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %4, %3 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def fold_mask_cmps_to_false_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem fold_mask_cmps_to_false_proof : fold_mask_cmps_to_false_before ⊑ fold_mask_cmps_to_false_after := by
  sorry



def fold_mask_cmps_to_true_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.or %4, %3 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def fold_mask_cmps_to_true_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem fold_mask_cmps_to_true_proof : fold_mask_cmps_to_true_before ⊑ fold_mask_cmps_to_true_after := by
  sorry



def cmpeq_bitwise_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %arg1 : i8
  %2 = llvm.xor %arg2, %arg3 : i8
  %3 = llvm.or %1, %2 : i8
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def cmpeq_bitwise_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %2 = llvm.and %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem cmpeq_bitwise_proof : cmpeq_bitwise_before ⊑ cmpeq_bitwise_after := by
  sorry



def cmpne_bitwise_before := [llvm|
{
^0(%arg0 : vector<2xi64>, %arg1 : vector<2xi64>, %arg2 : vector<2xi64>, %arg3 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi64>}> : () -> vector<2xi64>
  %2 = llvm.xor %arg0, %arg1 : vector<2xi64>
  %3 = llvm.xor %arg2, %arg3 : vector<2xi64>
  %4 = llvm.or %2, %3 : vector<2xi64>
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def cmpne_bitwise_after := [llvm|
{
^0(%arg0 : vector<2xi64>, %arg1 : vector<2xi64>, %arg2 : vector<2xi64>, %arg3 : vector<2xi64>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 1 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  %2 = llvm.or %0, %1 : vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem cmpne_bitwise_proof : cmpne_bitwise_before ⊑ cmpne_bitwise_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 9 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_1_proof : masked_icmps_mask_notallzeros_bmask_mixed_1_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_1_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_1_vector_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<12> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = "llvm.mlir.constant"() <{"value" = dense<7> : vector<2xi32>}> : () -> vector<2xi32>
  %4 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %5 = llvm.and %arg0, %0 : vector<2xi32>
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %7 = llvm.and %arg0, %3 : vector<2xi32>
  %8 = "llvm.icmp"(%7, %4) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %9 = llvm.and %6, %8 : vector<2xi1>
  "llvm.return"(%9) : (vector<2xi1>) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_1_vector_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<9> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.and %arg0, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_1_vector_proof : masked_icmps_mask_notallzeros_bmask_mixed_1_vector_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_1_vector_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %2 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_2_proof : masked_icmps_mask_notallzeros_bmask_mixed_2_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_2_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %2 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_3_proof : masked_icmps_mask_notallzeros_bmask_mixed_3_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_3_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_4_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 255 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_4_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_4_proof : masked_icmps_mask_notallzeros_bmask_mixed_4_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_4_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_5_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %0 : i32
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_5_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_5_proof : masked_icmps_mask_notallzeros_bmask_mixed_5_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_5_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_6_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_6_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_6_proof : masked_icmps_mask_notallzeros_bmask_mixed_6_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_6_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_7_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_7_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_7_proof : masked_icmps_mask_notallzeros_bmask_mixed_7_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_7_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_7b_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_7b_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_7b_proof : masked_icmps_mask_notallzeros_bmask_mixed_7b_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_7b_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 9 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_1_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_1_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_1_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %2 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_2_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_2_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_2_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %2 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_3_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_3_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_3_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_4_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 255 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_4_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_4_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_4_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_4_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_5_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %0 : i32
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_5_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_5_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_5_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_5_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_6_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_6_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_6_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_6_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_6_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_7_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_7_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_7_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_7_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_7_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 9 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %2 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %7 = llvm.and %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %2 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %7 = llvm.and %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 255 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %0 : i32
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %7 = llvm.and %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %8 = llvm.or %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 9 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %2 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %7 = llvm.or %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %2 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %7 = llvm.or %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 255 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %8 = llvm.or %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %arg0, %0 : i32
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %7 = llvm.or %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %8 = llvm.or %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %8 = llvm.or %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_after := by
  sorry



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %8 = llvm.or %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_after := by
  sorry



def masked_icmps_bmask_notmixed_or_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 255 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 243 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_bmask_notmixed_or_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_bmask_notmixed_or_proof : masked_icmps_bmask_notmixed_or_before ⊑ masked_icmps_bmask_notmixed_or_after := by
  sorry



def masked_icmps_bmask_notmixed_or_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = "llvm.mlir.constant"() <{"value" = dense<-13> : vector<2xi8>}> : () -> vector<2xi8>
  %4 = llvm.and %arg0, %0 : vector<2xi8>
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %6 = llvm.and %arg0, %2 : vector<2xi8>
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %8 = llvm.or %5, %7 : vector<2xi1>
  "llvm.return"(%8) : (vector<2xi1>) -> ()
}
]
def masked_icmps_bmask_notmixed_or_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.and %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem masked_icmps_bmask_notmixed_or_vec_proof : masked_icmps_bmask_notmixed_or_vec_before ⊑ masked_icmps_bmask_notmixed_or_vec_after := by
  sorry



def masked_icmps_bmask_notmixed_and_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 255 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 243 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_bmask_notmixed_and_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_bmask_notmixed_and_proof : masked_icmps_bmask_notmixed_and_before ⊑ masked_icmps_bmask_notmixed_and_after := by
  sorry



def masked_icmps_bmask_notmixed_and_expected_false_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 255 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 242 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_bmask_notmixed_and_expected_false_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 255 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 242 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem masked_icmps_bmask_notmixed_and_expected_false_proof : masked_icmps_bmask_notmixed_and_expected_false_before ⊑ masked_icmps_bmask_notmixed_and_expected_false_after := by
  sorry


