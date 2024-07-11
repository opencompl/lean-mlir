
def t0_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.add %2, %arg1 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.sub %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  sorry



def t1_vec_splat_before := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.xor %arg0, %0 : vector<4xi32>
  %3 = llvm.add %2, %arg1 : vector<4xi32>
  %4 = llvm.add %3, %1 : vector<4xi32>
  "llvm.return"(%4) : (vector<4xi32>) -> ()
}
]
def t1_vec_splat_after := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = llvm.sub %arg1, %arg0 : vector<4xi32>
  "llvm.return"(%0) : (vector<4xi32>) -> ()
}
]
theorem t1_vec_splat_proof : t1_vec_splat_before ⊑ t1_vec_splat_after := by
  sorry


