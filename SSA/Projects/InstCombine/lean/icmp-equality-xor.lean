
def cmpeq_xor_cst1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = "llvm.icmp"(%1, %arg1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def cmpeq_xor_cst1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem cmpeq_xor_cst1_proof : cmpeq_xor_cst1_before ⊑ cmpeq_xor_cst1_after := by
  sorry



def cmpeq_xor_cst3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def cmpeq_xor_cst3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem cmpeq_xor_cst3_proof : cmpeq_xor_cst3_before ⊑ cmpeq_xor_cst3_after := by
  sorry



def cmpne_xor_cst1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = "llvm.icmp"(%1, %arg1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def cmpne_xor_cst1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem cmpne_xor_cst1_proof : cmpne_xor_cst1_before ⊑ cmpne_xor_cst1_after := by
  sorry



def cmpne_xor_cst3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def cmpne_xor_cst3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem cmpne_xor_cst3_proof : cmpne_xor_cst3_before ⊑ cmpne_xor_cst3_after := by
  sorry



def cmpeq_xor_cst1_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg1 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def cmpeq_xor_cst1_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg1 : i32
  %2 = llvm.xor %1, %arg0 : i32
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem cmpeq_xor_cst1_commuted_proof : cmpeq_xor_cst1_commuted_before ⊑ cmpeq_xor_cst1_commuted_after := by
  sorry



def cmpeq_xor_cst1_vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[10, 11]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.xor %arg0, %0 : vector<2xi32>
  %2 = "llvm.icmp"(%arg1, %1) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def cmpeq_xor_cst1_vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[10, 11]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.xor %arg0, %arg1 : vector<2xi32>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem cmpeq_xor_cst1_vec_proof : cmpeq_xor_cst1_vec_before ⊑ cmpeq_xor_cst1_vec_after := by
  sorry



def foo1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.xor %arg1, %1 : i32
  %4 = llvm.and %3, %0 : i32
  %5 = "llvm.icmp"(%2, %4) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def foo1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem foo1_proof : foo1_before ⊑ foo1_after := by
  sorry



def foo2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = "llvm.icmp"(%1, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def foo2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem foo2_proof : foo2_before ⊑ foo2_after := by
  sorry


