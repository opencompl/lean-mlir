
def t0_basic_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.add %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%0, %arg1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def t0_basic_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem t0_basic_proof : t0_basic_before ⊑ t0_basic_after := by
  sorry



def t1_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = llvm.add %arg0, %arg1 : vector<2xi8>
  %1 = "llvm.icmp"(%0, %arg1) <{"predicate" = 9 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
def t1_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.xor %arg1, %0 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 9 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem t1_vec_proof : t1_vec_before ⊑ t1_vec_after := by
  sorry



def t2_symmetry_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.add %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def t2_symmetry_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = "llvm.icmp"(%1, %arg1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem t2_symmetry_proof : t2_symmetry_before ⊑ t2_symmetry_after := by
  sorry



def t4_commutative_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.add %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%arg1, %0) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def t4_commutative_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem t4_commutative_proof : t4_commutative_before ⊑ t4_commutative_after := by
  sorry



def n10_wrong_pred2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.add %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%0, %arg1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def n10_wrong_pred2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem n10_wrong_pred2_proof : n10_wrong_pred2_before ⊑ n10_wrong_pred2_after := by
  sorry



def n11_wrong_pred3_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.add %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%0, %arg1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def n11_wrong_pred3_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem n11_wrong_pred3_proof : n11_wrong_pred3_before ⊑ n11_wrong_pred3_after := by
  sorry



def low_bitmask_ult_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = llvm.and %1, %0 : i8
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def low_bitmask_ult_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem low_bitmask_ult_proof : low_bitmask_ult_before ⊑ low_bitmask_ult_after := by
  sorry



def low_bitmask_ugt_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = llvm.mul %arg0, %arg0 : i8
  %2 = llvm.add %1, %0 : i8
  %3 = llvm.and %2, %0 : i8
  %4 = "llvm.icmp"(%1, %3) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def low_bitmask_ugt_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.mul %arg0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem low_bitmask_ugt_proof : low_bitmask_ugt_before ⊑ low_bitmask_ugt_after := by
  sorry



def low_bitmask_ule_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.mul %arg0, %arg0 : vector<2xi8>
  %2 = llvm.add %1, %0 : vector<2xi8>
  %3 = llvm.and %2, %0 : vector<2xi8>
  %4 = "llvm.icmp"(%1, %3) <{"predicate" = 7 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def low_bitmask_ule_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.mul %arg0, %arg0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem low_bitmask_ule_proof : low_bitmask_ule_before ⊑ low_bitmask_ule_after := by
  sorry


