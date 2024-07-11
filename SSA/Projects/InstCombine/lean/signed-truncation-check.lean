
def positive_with_signbit_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 256 : i32}> : () -> i32
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = llvm.add %arg0, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def positive_with_signbit_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem positive_with_signbit_proof : positive_with_signbit_before ⊑ positive_with_signbit_after := by
  sorry



def positive_with_mask_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1107296256 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 256 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.add %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def positive_with_mask_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem positive_with_mask_proof : positive_with_mask_before ⊑ positive_with_mask_after := by
  sorry



def positive_with_icmp_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 512 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 256 : i32}> : () -> i32
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %4 = llvm.add %arg0, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def positive_with_icmp_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem positive_with_icmp_proof : positive_with_icmp_before ⊑ positive_with_icmp_after := by
  sorry



def positive_with_aggressive_icmp_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 256 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 512 : i32}> : () -> i32
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %4 = llvm.add %arg0, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def positive_with_aggressive_icmp_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem positive_with_aggressive_icmp_proof : positive_with_aggressive_icmp_before ⊑ positive_with_aggressive_icmp_after := by
  sorry



def positive_with_extra_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 256 : i32}> : () -> i32
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = llvm.add %arg0, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %3, %arg1 : i1
  %7 = llvm.and %5, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def positive_with_extra_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %2 = llvm.and %1, %arg1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem positive_with_extra_and_proof : positive_with_extra_and_before ⊑ positive_with_extra_and_after := by
  sorry



def positive_vec_splat_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<128> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.mlir.constant"() <{"value" = dense<256> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %4 = llvm.add %arg0, %1 : vector<2xi32>
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 6 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %6 = llvm.and %3, %5 : vector<2xi1>
  "llvm.return"(%6) : (vector<2xi1>) -> ()
}
]
def positive_vec_splat_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<128> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem positive_vec_splat_proof : positive_vec_splat_before ⊑ positive_vec_splat_after := by
  sorry



def negative_not_less_than_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 256 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %3 = llvm.add %arg0, %1 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def negative_not_less_than_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem negative_not_less_than_proof : negative_not_less_than_before ⊑ negative_not_less_than_after := by
  sorry



def negative_not_power_of_two_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 255 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 256 : i32}> : () -> i32
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = llvm.add %arg0, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def negative_not_power_of_two_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem negative_not_power_of_two_proof : negative_not_power_of_two_before ⊑ negative_not_power_of_two_after := by
  sorry



def negative_not_next_power_of_two_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 64 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 256 : i32}> : () -> i32
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = llvm.add %arg0, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def negative_not_next_power_of_two_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 192 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem negative_not_next_power_of_two_proof : negative_not_next_power_of_two_before ⊑ negative_not_next_power_of_two_after := by
  sorry



def two_signed_truncation_checks_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 512 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1024 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 256 : i32}> : () -> i32
  %4 = llvm.add %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %6 = llvm.add %arg0, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def two_signed_truncation_checks_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 256 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem two_signed_truncation_checks_proof : two_signed_truncation_checks_before ⊑ two_signed_truncation_checks_after := by
  sorry


