
def test_FoldShiftByConstant_CreateSHL_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[0, -1, 0, -1]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<5> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.mul %arg0, %0 : vector<4xi32>
  %3 = llvm.shl %2, %1 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def test_FoldShiftByConstant_CreateSHL_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[0, -32, 0, -32]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.mul %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem test_FoldShiftByConstant_CreateSHL_proof : test_FoldShiftByConstant_CreateSHL_before ⊑ test_FoldShiftByConstant_CreateSHL_after := by
  sorry



def test_FoldShiftByConstant_CreateSHL2_before := [llvm|
{
^0(%arg0 : vector<8xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[0, -1, 0, -1, 0, -1, 0, -1]> : vector<8xi16>}> : () -> vector<8xi16>
  %1 = "llvm.mlir.constant"() <{"value" = dense<5> : vector<8xi16>}> : () -> vector<8xi16>
  %2 = llvm.mul %arg0, %0 : vector<8xi16>
  %3 = llvm.shl %2, %1 : vector<8xi16>
  "llvm.return"(%3) : (vector<8xi16>) -> ()
}
]
def test_FoldShiftByConstant_CreateSHL2_after := [llvm|
{
^0(%arg0 : vector<8xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[0, -32, 0, -32, 0, -32, 0, -32]> : vector<8xi16>}> : () -> vector<8xi16>
  %1 = llvm.mul %arg0, %0 : vector<8xi16>
  "llvm.return"(%1) : (vector<8xi16>) -> ()
}
]
theorem test_FoldShiftByConstant_CreateSHL2_proof : test_FoldShiftByConstant_CreateSHL2_before ⊑ test_FoldShiftByConstant_CreateSHL2_after := by
  sorry


