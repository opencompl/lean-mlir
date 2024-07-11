
def test1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 65280 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 65280 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test1vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<65280> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.and %arg0, %0 : vector<2xi32>
  %2 = llvm.and %arg1, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def test1vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<65280> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = llvm.xor %arg0, %arg1 : vector<2xi32>
  %4 = llvm.and %3, %0 : vector<2xi32>
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
theorem test1vec_proof : test1vec_before ⊑ test1vec_after := by
  sorry


