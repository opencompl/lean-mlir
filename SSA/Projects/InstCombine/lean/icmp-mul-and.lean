
def mul_mask_pow2_eq0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 44 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = llvm.mul %arg0, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_mask_pow2_eq0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem mul_mask_pow2_eq0_proof : mul_mask_pow2_eq0_before ⊑ mul_mask_pow2_eq0_after := by
  sorry



def mul_mask_pow2_sgt0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 44 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = llvm.mul %arg0, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_mask_pow2_sgt0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem mul_mask_pow2_sgt0_proof : mul_mask_pow2_sgt0_before ⊑ mul_mask_pow2_sgt0_after := by
  sorry



def mul_mask_fakepow2_ne0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 44 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = llvm.mul %arg0, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_mask_fakepow2_ne0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem mul_mask_fakepow2_ne0_proof : mul_mask_fakepow2_ne0_before ⊑ mul_mask_fakepow2_ne0_after := by
  sorry



def mul_mask_pow2_eq4_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 44 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def mul_mask_pow2_eq4_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem mul_mask_pow2_eq4_proof : mul_mask_pow2_eq4_before ⊑ mul_mask_pow2_eq4_after := by
  sorry



def mul_mask_notpow2_ne_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 60 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 12 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = llvm.mul %arg0, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_mask_notpow2_ne_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = llvm.and %2, %0 : i8
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem mul_mask_notpow2_ne_proof : mul_mask_notpow2_ne_before ⊑ mul_mask_notpow2_ne_after := by
  sorry



def pr40493_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = llvm.mul %arg0, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def pr40493_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem pr40493_proof : pr40493_before ⊑ pr40493_after := by
  sorry



def pr40493_neg1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 11 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = llvm.mul %arg0, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def pr40493_neg1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = llvm.mul %arg0, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem pr40493_neg1_proof : pr40493_neg1_before ⊑ pr40493_neg1_after := by
  sorry



def pr40493_neg2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = llvm.mul %arg0, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def pr40493_neg2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.mul %arg0, %0 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem pr40493_neg2_proof : pr40493_neg2_before ⊑ pr40493_neg2_after := by
  sorry



def pr40493_neg3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %2 = llvm.mul %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def pr40493_neg3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem pr40493_neg3_proof : pr40493_neg3_before ⊑ pr40493_neg3_after := by
  sorry



def pr40493_vec1_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<12> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
  %4 = llvm.mul %arg0, %0 : vector<4xi32>
  %5 = llvm.and %4, %1 : vector<4xi32>
  %6 = "llvm.icmp"(%5, %3) <{"predicate" = 0 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  "llvm.return"(%6) : (vector<4xi1>) -> ()
}
]
def pr40493_vec1_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
  %3 = llvm.and %arg0, %0 : vector<4xi32>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 0 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  "llvm.return"(%4) : (vector<4xi1>) -> ()
}
]
theorem pr40493_vec1_proof : pr40493_vec1_before ⊑ pr40493_vec1_after := by
  sorry



def pr51551_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %4 = llvm.and %arg1, %0 : i32
  %5 = llvm.or %4, %1 : i32
  %6 = llvm.mul %5, %arg0 : i32
  %7 = llvm.and %6, %2 : i32
  %8 = "llvm.icmp"(%7, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def pr51551_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem pr51551_proof : pr51551_before ⊑ pr51551_after := by
  sorry



def pr51551_2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = llvm.and %arg1, %0 : i32
  %4 = llvm.or %3, %1 : i32
  %5 = llvm.mul %4, %arg0 : i32
  %6 = llvm.and %5, %1 : i32
  %7 = "llvm.icmp"(%6, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def pr51551_2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem pr51551_2_proof : pr51551_2_before ⊑ pr51551_2_after := by
  sorry



def pr51551_neg1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %4 = llvm.and %arg1, %0 : i32
  %5 = llvm.or %4, %1 : i32
  %6 = llvm.mul %5, %arg0 : i32
  %7 = llvm.and %6, %2 : i32
  %8 = "llvm.icmp"(%7, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def pr51551_neg1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %4 = llvm.and %arg1, %0 : i32
  %5 = llvm.or %4, %1 : i32
  %6 = llvm.mul %5, %arg0 : i32
  %7 = llvm.and %6, %2 : i32
  %8 = "llvm.icmp"(%7, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
theorem pr51551_neg1_proof : pr51551_neg1_before ⊑ pr51551_neg1_after := by
  sorry



def pr51551_demand3bits_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = llvm.and %arg1, %0 : i32
  %4 = llvm.or %3, %1 : i32
  %5 = llvm.mul %4, %arg0 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def pr51551_demand3bits_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem pr51551_demand3bits_proof : pr51551_demand3bits_before ⊑ pr51551_demand3bits_after := by
  sorry


