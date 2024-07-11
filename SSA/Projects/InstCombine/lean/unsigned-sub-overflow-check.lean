
def t0_basic_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def t0_basic_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem t0_basic_proof : t0_basic_before ⊑ t0_basic_after := by
  sorry



def t1_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = llvm.sub %arg0, %arg1 : vector<2xi8>
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 8 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
def t1_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 8 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
theorem t1_vec_proof : t1_vec_before ⊑ t1_vec_after := by
  sorry



def t2_commutative_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def t2_commutative_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem t2_commutative_proof : t2_commutative_before ⊑ t2_commutative_after := by
  sorry



def n7_wrong_pred2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def n7_wrong_pred2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem n7_wrong_pred2_proof : n7_wrong_pred2_before ⊑ n7_wrong_pred2_after := by
  sorry



def n8_wrong_pred3_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def n8_wrong_pred3_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem n8_wrong_pred3_proof : n8_wrong_pred3_before ⊑ n8_wrong_pred3_after := by
  sorry


