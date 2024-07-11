
def src_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.or %arg1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def src_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem src_proof : src_before ⊑ src_after := by
  sorry



def src_vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.and %arg1, %arg0 : vector<2xi32>
  %2 = llvm.or %arg1, %arg0 : vector<2xi32>
  %3 = llvm.xor %2, %0 : vector<2xi32>
  %4 = llvm.add %1, %3 : vector<2xi32>
  "llvm.return"(%4) : (vector<2xi32>) -> ()
}
]
def src_vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.xor %arg1, %arg0 : vector<2xi32>
  %2 = llvm.xor %1, %0 : vector<2xi32>
  "llvm.return"(%2) : (vector<2xi32>) -> ()
}
]
theorem src_vec_proof : src_vec_before ⊑ src_vec_after := by
  sorry



def src2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.or %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def src2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem src2_proof : src2_before ⊑ src2_after := by
  sorry



def src3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %arg1, %0 : i32
  %4 = llvm.and %2, %3 : i32
  %5 = llvm.add %1, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def src3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem src3_proof : src3_before ⊑ src3_after := by
  sorry



def src4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.or %arg1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def src4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem src4_proof : src4_before ⊑ src4_after := by
  sorry



def src5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg1, %arg0 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def src5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem src5_proof : src5_before ⊑ src5_after := by
  sorry


