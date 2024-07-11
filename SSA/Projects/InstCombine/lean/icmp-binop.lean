
def mul_unkV_oddC_eq_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.mul %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_unkV_oddC_eq_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem mul_unkV_oddC_eq_proof : mul_unkV_oddC_eq_before ⊑ mul_unkV_oddC_eq_after := by
  sorry



def mul_unkV_oddC_ne_vec_before := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi64>}> : () -> vector<2xi64>
  %3 = llvm.mul %arg0, %0 : vector<2xi64>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 1 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def mul_unkV_oddC_ne_vec_after := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi64>}> : () -> vector<2xi64>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem mul_unkV_oddC_ne_vec_proof : mul_unkV_oddC_ne_vec_before ⊑ mul_unkV_oddC_ne_vec_after := by
  sorry



def mul_unkV_oddC_sge_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_unkV_oddC_sge_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem mul_unkV_oddC_sge_proof : mul_unkV_oddC_sge_before ⊑ mul_unkV_oddC_sge_after := by
  sorry



def mul_setoddV_unkV_ne_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = llvm.or %arg0, %0 : vector<2xi32>
  %4 = llvm.mul %3, %arg1 : vector<2xi32>
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def mul_setoddV_unkV_ne_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg1, %1) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem mul_setoddV_unkV_ne_proof : mul_setoddV_unkV_ne_before ⊑ mul_setoddV_unkV_ne_after := by
  sorry



def mul_unkV_evenC_ne_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %2 = llvm.mul %arg0, %0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_unkV_evenC_ne_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 4611686018427387903 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %2 = llvm.and %arg0, %0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem mul_unkV_evenC_ne_proof : mul_unkV_evenC_ne_before ⊑ mul_unkV_evenC_ne_after := by
  sorry



def mul_setnzV_unkV_nuw_eq_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = llvm.mul %2, %arg1 : i8
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def mul_setnzV_unkV_nuw_eq_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem mul_setnzV_unkV_nuw_eq_proof : mul_setnzV_unkV_nuw_eq_before ⊑ mul_setnzV_unkV_nuw_eq_after := by
  sorry


