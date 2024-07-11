
def icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1610612736 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1610612736 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_proof : icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_before ⊑ icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1610612736 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1610612736 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_proof : icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_before ⊑ icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_proof : icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_before ⊑ icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_proof : icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_before ⊑ icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_2147483648_805306368_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1073741824 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 805306368 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_2147483648_805306368_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 805306368 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_2147483648_805306368_proof : icmp_power2_and_icmp_shifted_mask_2147483648_805306368_before ⊑ icmp_power2_and_icmp_shifted_mask_2147483648_805306368_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1073741824 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 805306368 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 805306368 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_proof : icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_before ⊑ icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1073741824 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1073741823 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1073741823 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_proof : icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_before ⊑ icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1073741824 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1073741823 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1073741823 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_proof : icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_before ⊑ icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_8_7_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_8_7_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_8_7_proof : icmp_power2_and_icmp_shifted_mask_8_7_before ⊑ icmp_power2_and_icmp_shifted_mask_8_7_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_swapped_8_7_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_swapped_8_7_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_swapped_8_7_proof : icmp_power2_and_icmp_shifted_mask_swapped_8_7_before ⊑ icmp_power2_and_icmp_shifted_mask_swapped_8_7_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_8_6_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_8_6_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_8_6_proof : icmp_power2_and_icmp_shifted_mask_8_6_before ⊑ icmp_power2_and_icmp_shifted_mask_8_6_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_swapped_8_6_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_swapped_8_6_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_swapped_8_6_proof : icmp_power2_and_icmp_shifted_mask_swapped_8_6_before ⊑ icmp_power2_and_icmp_shifted_mask_swapped_8_6_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_2147483648_2147483647_before := [llvm|
{
^0(%arg0 : vector<1xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<1xi32>}> : () -> vector<1xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2147483647> : vector<1xi32>}> : () -> vector<1xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  %3 = llvm.and %arg0, %1 : vector<1xi32>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  %5 = llvm.and %2, %4 : vector<1xi1>
  "llvm.return"(%5) : (vector<1xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_2147483648_2147483647_after := [llvm|
{
^0(%arg0 : vector<1xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2147483647> : vector<1xi32>}> : () -> vector<1xi32>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  "llvm.return"(%1) : (vector<1xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_2147483648_2147483647_proof : icmp_power2_and_icmp_shifted_mask_vector_2147483648_2147483647_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_2147483648_2147483647_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_2147483647_before := [llvm|
{
^0(%arg0 : vector<1xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<1xi32>}> : () -> vector<1xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2147483647> : vector<1xi32>}> : () -> vector<1xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  %3 = llvm.and %arg0, %1 : vector<1xi32>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  %5 = llvm.and %4, %2 : vector<1xi1>
  "llvm.return"(%5) : (vector<1xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_2147483647_after := [llvm|
{
^0(%arg0 : vector<1xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2147483647> : vector<1xi32>}> : () -> vector<1xi32>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  "llvm.return"(%1) : (vector<1xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_2147483647_proof : icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_2147483647_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_2147483647_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_2147483648_1610612736_2147483647_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[1610612736, 2147483647]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = llvm.and %arg0, %1 : vector<2xi32>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %5 = llvm.and %2, %4 : vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_2147483648_1610612736_2147483647_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[1610612736, 2147483647]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_2147483648_1610612736_2147483647_proof : icmp_power2_and_icmp_shifted_mask_vector_2147483648_1610612736_2147483647_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_2147483648_1610612736_2147483647_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_1610612736_2147483647_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[1610612736, 2147483647]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = llvm.and %arg0, %1 : vector<2xi32>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %5 = llvm.and %4, %2 : vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_1610612736_2147483647_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[1610612736, 2147483647]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_1610612736_2147483647_proof : icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_1610612736_2147483647_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_1610612736_2147483647_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_128_others_before := [llvm|
{
^0(%arg0 : vector<7xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<7xi8>}> : () -> vector<7xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[127, 126, 124, 120, 112, 96, 64]> : vector<7xi8>}> : () -> vector<7xi8>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  %3 = llvm.and %arg0, %1 : vector<7xi8>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  %5 = llvm.and %2, %4 : vector<7xi1>
  "llvm.return"(%5) : (vector<7xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_128_others_after := [llvm|
{
^0(%arg0 : vector<7xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[127, 126, 124, 120, 112, 96, 64]> : vector<7xi8>}> : () -> vector<7xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  "llvm.return"(%1) : (vector<7xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_128_others_proof : icmp_power2_and_icmp_shifted_mask_vector_128_others_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_128_others_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_swapped_128_others_before := [llvm|
{
^0(%arg0 : vector<7xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<7xi8>}> : () -> vector<7xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[127, 126, 124, 120, 112, 96, 64]> : vector<7xi8>}> : () -> vector<7xi8>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  %3 = llvm.and %arg0, %1 : vector<7xi8>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  %5 = llvm.and %4, %2 : vector<7xi1>
  "llvm.return"(%5) : (vector<7xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_swapped_128_others_after := [llvm|
{
^0(%arg0 : vector<7xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[127, 126, 124, 120, 112, 96, 64]> : vector<7xi8>}> : () -> vector<7xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  "llvm.return"(%1) : (vector<7xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_swapped_128_others_proof : icmp_power2_and_icmp_shifted_mask_vector_swapped_128_others_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_swapped_128_others_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_64_others_before := [llvm|
{
^0(%arg0 : vector<6xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<64> : vector<6xi8>}> : () -> vector<6xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[63, 62, 60, 56, 48, 32]> : vector<6xi8>}> : () -> vector<6xi8>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  %3 = llvm.and %arg0, %1 : vector<6xi8>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  %5 = llvm.and %2, %4 : vector<6xi1>
  "llvm.return"(%5) : (vector<6xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_64_others_after := [llvm|
{
^0(%arg0 : vector<6xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[63, 62, 60, 56, 48, 32]> : vector<6xi8>}> : () -> vector<6xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  "llvm.return"(%1) : (vector<6xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_64_others_proof : icmp_power2_and_icmp_shifted_mask_vector_64_others_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_64_others_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_swapped_64_others_before := [llvm|
{
^0(%arg0 : vector<6xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<64> : vector<6xi8>}> : () -> vector<6xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[63, 62, 60, 56, 48, 32]> : vector<6xi8>}> : () -> vector<6xi8>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  %3 = llvm.and %arg0, %1 : vector<6xi8>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  %5 = llvm.and %2, %4 : vector<6xi1>
  "llvm.return"(%5) : (vector<6xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_swapped_64_others_after := [llvm|
{
^0(%arg0 : vector<6xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[63, 62, 60, 56, 48, 32]> : vector<6xi8>}> : () -> vector<6xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  "llvm.return"(%1) : (vector<6xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_swapped_64_others_proof : icmp_power2_and_icmp_shifted_mask_vector_swapped_64_others_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_swapped_64_others_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_2147483648_2147482647_gap_in_mask_fail_before := [llvm|
{
^0(%arg0 : vector<1xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<1xi32>}> : () -> vector<1xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2147482647> : vector<1xi32>}> : () -> vector<1xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  %3 = llvm.and %arg0, %1 : vector<1xi32>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  %5 = llvm.and %2, %4 : vector<1xi1>
  "llvm.return"(%5) : (vector<1xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_2147483648_2147482647_gap_in_mask_fail_after := [llvm|
{
^0(%arg0 : vector<1xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<1xi32>}> : () -> vector<1xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2147482647> : vector<1xi32>}> : () -> vector<1xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  %3 = llvm.and %arg0, %1 : vector<1xi32>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  %5 = llvm.and %2, %4 : vector<1xi1>
  "llvm.return"(%5) : (vector<1xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_2147483648_2147482647_gap_in_mask_fail_proof : icmp_power2_and_icmp_shifted_mask_vector_2147483648_2147482647_gap_in_mask_fail_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_2147483648_2147482647_gap_in_mask_fail_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_2147482647_gap_in_mask_fail_before := [llvm|
{
^0(%arg0 : vector<1xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<1xi32>}> : () -> vector<1xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2147482647> : vector<1xi32>}> : () -> vector<1xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  %3 = llvm.and %arg0, %1 : vector<1xi32>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  %5 = llvm.and %4, %2 : vector<1xi1>
  "llvm.return"(%5) : (vector<1xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_2147482647_gap_in_mask_fail_after := [llvm|
{
^0(%arg0 : vector<1xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<1xi32>}> : () -> vector<1xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2147482647> : vector<1xi32>}> : () -> vector<1xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  %3 = llvm.and %arg0, %1 : vector<1xi32>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
  %5 = llvm.and %4, %2 : vector<1xi1>
  "llvm.return"(%5) : (vector<1xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_2147482647_gap_in_mask_fail_proof : icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_2147482647_gap_in_mask_fail_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_2147482647_gap_in_mask_fail_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_2147483648_1073741823_gap_between_masks_fail_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[1610612736, 1073741823]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = llvm.and %arg0, %1 : vector<2xi32>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %5 = llvm.and %2, %4 : vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_2147483648_1073741823_gap_between_masks_fail_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[1610612736, 1073741823]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = llvm.and %arg0, %1 : vector<2xi32>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %5 = llvm.and %2, %4 : vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_2147483648_1073741823_gap_between_masks_fail_proof : icmp_power2_and_icmp_shifted_mask_vector_2147483648_1073741823_gap_between_masks_fail_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_2147483648_1073741823_gap_between_masks_fail_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_1073741823_gap_between_masks_fail_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[1610612736, 1073741823]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = llvm.and %arg0, %1 : vector<2xi32>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %5 = llvm.and %4, %2 : vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_1073741823_gap_between_masks_fail_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[1610612736, 1073741823]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = llvm.and %arg0, %1 : vector<2xi32>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %5 = llvm.and %4, %2 : vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_1073741823_gap_between_masks_fail_proof : icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_1073741823_gap_between_masks_fail_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_swapped_2147483648_1073741823_gap_between_masks_fail_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_128_1_of_7_fail_before := [llvm|
{
^0(%arg0 : vector<7xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<7xi8>}> : () -> vector<7xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[125, 122, 116, 104, 80, 32, 64]> : vector<7xi8>}> : () -> vector<7xi8>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  %3 = llvm.and %arg0, %1 : vector<7xi8>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  %5 = llvm.and %2, %4 : vector<7xi1>
  "llvm.return"(%5) : (vector<7xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_128_1_of_7_fail_after := [llvm|
{
^0(%arg0 : vector<7xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<7xi8>}> : () -> vector<7xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[125, 122, 116, 104, 80, 32, 64]> : vector<7xi8>}> : () -> vector<7xi8>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  %3 = llvm.and %arg0, %1 : vector<7xi8>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  %5 = llvm.and %2, %4 : vector<7xi1>
  "llvm.return"(%5) : (vector<7xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_128_1_of_7_fail_proof : icmp_power2_and_icmp_shifted_mask_vector_128_1_of_7_fail_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_128_1_of_7_fail_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_swapped_128_1_of_7_fail_before := [llvm|
{
^0(%arg0 : vector<7xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<7xi8>}> : () -> vector<7xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[125, 122, 116, 104, 80, 32, 64]> : vector<7xi8>}> : () -> vector<7xi8>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  %3 = llvm.and %arg0, %1 : vector<7xi8>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  %5 = llvm.and %4, %2 : vector<7xi1>
  "llvm.return"(%5) : (vector<7xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_swapped_128_1_of_7_fail_after := [llvm|
{
^0(%arg0 : vector<7xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<7xi8>}> : () -> vector<7xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[125, 122, 116, 104, 80, 32, 64]> : vector<7xi8>}> : () -> vector<7xi8>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  %3 = llvm.and %arg0, %1 : vector<7xi8>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<7xi8>, vector<7xi8>) -> vector<7xi1>
  %5 = llvm.and %4, %2 : vector<7xi1>
  "llvm.return"(%5) : (vector<7xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_swapped_128_1_of_7_fail_proof : icmp_power2_and_icmp_shifted_mask_vector_swapped_128_1_of_7_fail_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_swapped_128_1_of_7_fail_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_128_0_of_6_fail_before := [llvm|
{
^0(%arg0 : vector<6xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<6xi8>}> : () -> vector<6xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[125, 122, 116, 104, 80, 32]> : vector<6xi8>}> : () -> vector<6xi8>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  %3 = llvm.and %arg0, %1 : vector<6xi8>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  %5 = llvm.and %2, %4 : vector<6xi1>
  "llvm.return"(%5) : (vector<6xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_128_0_of_6_fail_after := [llvm|
{
^0(%arg0 : vector<6xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<6xi8>}> : () -> vector<6xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[125, 122, 116, 104, 80, 32]> : vector<6xi8>}> : () -> vector<6xi8>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  %3 = llvm.and %arg0, %1 : vector<6xi8>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  %5 = llvm.and %2, %4 : vector<6xi1>
  "llvm.return"(%5) : (vector<6xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_128_0_of_6_fail_proof : icmp_power2_and_icmp_shifted_mask_vector_128_0_of_6_fail_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_128_0_of_6_fail_after := by
  sorry



def icmp_power2_and_icmp_shifted_mask_vector_swapped_128_0_of_6_fail_before := [llvm|
{
^0(%arg0 : vector<6xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<6xi8>}> : () -> vector<6xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[125, 122, 116, 104, 80, 32]> : vector<6xi8>}> : () -> vector<6xi8>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  %3 = llvm.and %arg0, %1 : vector<6xi8>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  %5 = llvm.and %4, %2 : vector<6xi1>
  "llvm.return"(%5) : (vector<6xi1>) -> ()
}
]
def icmp_power2_and_icmp_shifted_mask_vector_swapped_128_0_of_6_fail_after := [llvm|
{
^0(%arg0 : vector<6xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<6xi8>}> : () -> vector<6xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[125, 122, 116, 104, 80, 32]> : vector<6xi8>}> : () -> vector<6xi8>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  %3 = llvm.and %arg0, %1 : vector<6xi8>
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (vector<6xi8>, vector<6xi8>) -> vector<6xi1>
  %5 = llvm.and %4, %2 : vector<6xi1>
  "llvm.return"(%5) : (vector<6xi1>) -> ()
}
]
theorem icmp_power2_and_icmp_shifted_mask_vector_swapped_128_0_of_6_fail_proof : icmp_power2_and_icmp_shifted_mask_vector_swapped_128_0_of_6_fail_before ⊑ icmp_power2_and_icmp_shifted_mask_vector_swapped_128_0_of_6_fail_after := by
  sorry


