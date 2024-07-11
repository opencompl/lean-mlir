
def test_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.xor %arg0, %0 : vector<4xi32>
  %2 = llvm.and %1, %0 : vector<4xi32>
  "llvm.return"(%2) : (vector<4xi32>) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.xor %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem test_proof : test_before ⊑ test_after := by
  sorry


