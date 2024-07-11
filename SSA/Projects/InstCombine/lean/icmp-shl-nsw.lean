
def icmp_shl_nsw_sgt_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 21 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_shl_nsw_sgt_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_shl_nsw_sgt_proof : icmp_shl_nsw_sgt_before ⊑ icmp_shl_nsw_sgt_after := by
  sorry



def icmp_shl_nsw_sge0_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 21 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_shl_nsw_sge0_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_shl_nsw_sge0_proof : icmp_shl_nsw_sge0_before ⊑ icmp_shl_nsw_sge0_after := by
  sorry



def icmp_shl_nsw_sge1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 21 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_shl_nsw_sge1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_shl_nsw_sge1_proof : icmp_shl_nsw_sge1_before ⊑ icmp_shl_nsw_sge1_after := by
  sorry



def icmp_shl_nsw_sge1_vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<21> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.shl %arg0, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 5 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def icmp_shl_nsw_sge1_vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 4 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem icmp_shl_nsw_sge1_vec_proof : icmp_shl_nsw_sge1_vec_before ⊑ icmp_shl_nsw_sge1_vec_after := by
  sorry



def icmp_shl_nsw_eq_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_shl_nsw_eq_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_shl_nsw_eq_proof : icmp_shl_nsw_eq_before ⊑ icmp_shl_nsw_eq_after := by
  sorry



def icmp_shl_nsw_eq_vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<5> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = llvm.shl %arg0, %0 : vector<2xi32>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def icmp_shl_nsw_eq_vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem icmp_shl_nsw_eq_vec_proof : icmp_shl_nsw_eq_vec_before ⊑ icmp_shl_nsw_eq_vec_after := by
  sorry



def icmp_sgt1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -64 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sgt1_proof : icmp_sgt1_before ⊑ icmp_sgt1_after := by
  sorry



def icmp_sgt2_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -127 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt2_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -64 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sgt2_proof : icmp_sgt2_before ⊑ icmp_sgt2_after := by
  sorry



def icmp_sgt3_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -16 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt3_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -8 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sgt3_proof : icmp_sgt3_before ⊑ icmp_sgt3_after := by
  sorry



def icmp_sgt4_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt4_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sgt4_proof : icmp_sgt4_before ⊑ icmp_sgt4_after := by
  sorry



def icmp_sgt5_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %0 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def icmp_sgt5_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sgt5_proof : icmp_sgt5_before ⊑ icmp_sgt5_after := by
  sorry



def icmp_sgt6_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 16 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt6_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sgt6_proof : icmp_sgt6_before ⊑ icmp_sgt6_after := by
  sorry



def icmp_sgt7_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 124 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt7_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 62 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sgt7_proof : icmp_sgt7_before ⊑ icmp_sgt7_after := by
  sorry



def icmp_sgt8_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 125 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt8_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 63 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sgt8_proof : icmp_sgt8_before ⊑ icmp_sgt8_after := by
  sorry



def icmp_sgt9_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt9_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sgt9_proof : icmp_sgt9_before ⊑ icmp_sgt9_after := by
  sorry



def icmp_sgt10_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -127 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt10_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sgt10_proof : icmp_sgt10_before ⊑ icmp_sgt10_after := by
  sorry



def icmp_sgt11_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sgt11_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sgt11_proof : icmp_sgt11_before ⊑ icmp_sgt11_after := by
  sorry



def icmp_sgt11_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<7> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.shl %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def icmp_sgt11_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem icmp_sgt11_vec_proof : icmp_sgt11_vec_before ⊑ icmp_sgt11_vec_after := by
  sorry



def icmp_sle1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -64 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sle1_proof : icmp_sle1_before ⊑ icmp_sle1_after := by
  sorry



def icmp_sle2_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -127 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle2_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -63 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sle2_proof : icmp_sle2_before ⊑ icmp_sle2_after := by
  sorry



def icmp_sle3_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -16 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle3_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -7 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sle3_proof : icmp_sle3_before ⊑ icmp_sle3_after := by
  sorry



def icmp_sle4_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle4_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sle4_proof : icmp_sle4_before ⊑ icmp_sle4_after := by
  sorry



def icmp_sle5_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %0 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def icmp_sle5_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sle5_proof : icmp_sle5_before ⊑ icmp_sle5_after := by
  sorry



def icmp_sle6_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 16 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle6_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 9 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sle6_proof : icmp_sle6_before ⊑ icmp_sle6_after := by
  sorry



def icmp_sle7_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 124 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle7_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 63 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sle7_proof : icmp_sle7_before ⊑ icmp_sle7_after := by
  sorry



def icmp_sle8_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 125 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle8_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 63 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sle8_proof : icmp_sle8_before ⊑ icmp_sle8_after := by
  sorry



def icmp_sle9_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle9_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sle9_proof : icmp_sle9_before ⊑ icmp_sle9_after := by
  sorry



def icmp_sle10_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -127 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle10_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sle10_proof : icmp_sle10_before ⊑ icmp_sle10_after := by
  sorry



def icmp_sle11_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_sle11_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_sle11_proof : icmp_sle11_before ⊑ icmp_sle11_after := by
  sorry



def icmp_eq1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 12 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_eq1_proof : icmp_eq1_before ⊑ icmp_eq1_after := by
  sorry



def icmp_ne1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_ne1_proof : icmp_ne1_before ⊑ icmp_ne1_after := by
  sorry


