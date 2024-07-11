
def p0_scalar_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def p0_scalar_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  %2 = llvm.add %1, %arg1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem p0_scalar_proof : p0_scalar_before ⊑ p0_scalar_after := by
  sorry



def p1_vector_splat_before := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.xor %arg0, %0 : vector<4xi32>
  %2 = llvm.sub %arg1, %1 : vector<4xi32>
  "llvm.return"(%2) : (vector<4xi32>) -> ()
}
]
def p1_vector_splat_after := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.add %arg0, %0 : vector<4xi32>
  %2 = llvm.add %1, %arg1 : vector<4xi32>
  "llvm.return"(%2) : (vector<4xi32>) -> ()
}
]
theorem p1_vector_splat_proof : p1_vector_splat_before ⊑ p1_vector_splat_after := by
  sorry


