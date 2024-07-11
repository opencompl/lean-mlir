
def test1_before := [llvm|
{
^0(%arg0 : i17):
  %0 = "llvm.mlir.constant"() <{"value" = 1024 : i17}> : () -> i17
  %1 = llvm.mul %arg0, %0 : i17
  "llvm.return"(%1) : (i17) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i17):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i17}> : () -> i17
  %1 = llvm.shl %arg0, %0 : i17
  "llvm.return"(%1) : (i17) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : vector<2xi17>):
  %0 = "llvm.mlir.constant"() <{"value" = 1024 : i17}> : () -> i17
  %1 = "llvm.mlir.constant"() <{"value" = dense<1024> : vector<2xi17>}> : () -> vector<2xi17>
  %2 = llvm.mul %arg0, %1 : vector<2xi17>
  "llvm.return"(%2) : (vector<2xi17>) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : vector<2xi17>):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i17}> : () -> i17
  %1 = "llvm.mlir.constant"() <{"value" = dense<10> : vector<2xi17>}> : () -> vector<2xi17>
  %2 = llvm.shl %arg0, %1 : vector<2xi17>
  "llvm.return"(%2) : (vector<2xi17>) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry



def test3_before := [llvm|
{
^0(%arg0 : vector<2xi17>):
  %0 = "llvm.mlir.constant"() <{"value" = 256 : i17}> : () -> i17
  %1 = "llvm.mlir.constant"() <{"value" = 1024 : i17}> : () -> i17
  %2 = "llvm.mlir.constant"() <{"value" = dense<[1024, 256]> : vector<2xi17>}> : () -> vector<2xi17>
  %3 = llvm.mul %arg0, %2 : vector<2xi17>
  "llvm.return"(%3) : (vector<2xi17>) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : vector<2xi17>):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i17}> : () -> i17
  %1 = "llvm.mlir.constant"() <{"value" = 10 : i17}> : () -> i17
  %2 = "llvm.mlir.constant"() <{"value" = dense<[10, 8]> : vector<2xi17>}> : () -> vector<2xi17>
  %3 = llvm.shl %arg0, %2 : vector<2xi17>
  "llvm.return"(%3) : (vector<2xi17>) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry


