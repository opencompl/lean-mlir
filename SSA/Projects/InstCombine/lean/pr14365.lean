
def test0_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1431655765 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %4, %2 : i32
  %6 = llvm.add %arg0, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test0_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1431655766 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test0_proof : test0_before ⊑ test0_after := by
  sorry



def test0_vec_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1431655765> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
  %3 = llvm.and %arg0, %0 : vector<4xi32>
  %4 = llvm.xor %3, %1 : vector<4xi32>
  %5 = llvm.add %4, %2 : vector<4xi32>
  %6 = llvm.add %arg0, %5 : vector<4xi32>
  "llvm.return"(%6) : (vector<4xi32>) -> ()
}
]
def test0_vec_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1431655766> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.and %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem test0_vec_proof : test0_vec_before ⊑ test0_vec_after := by
  sorry


