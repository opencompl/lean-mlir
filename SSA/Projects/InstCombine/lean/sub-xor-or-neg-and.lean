
def sub_to_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.sub %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sub_to_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sub_to_and_proof : sub_to_and_before ⊑ sub_to_and_after := by
  sorry



def sub_to_and_or_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg1, %arg0 : i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.sub %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sub_to_and_or_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sub_to_and_or_commuted_proof : sub_to_and_or_commuted_before ⊑ sub_to_and_or_commuted_after := by
  sorry



def sub_to_and_and_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.sub %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sub_to_and_and_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.sub %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem sub_to_and_and_commuted_proof : sub_to_and_and_commuted_before ⊑ sub_to_and_and_commuted_after := by
  sorry



def sub_to_and_vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = llvm.or %arg0, %arg1 : vector<2xi32>
  %1 = llvm.xor %arg1, %arg0 : vector<2xi32>
  %2 = llvm.sub %1, %0 : vector<2xi32>
  "llvm.return"(%2) : (vector<2xi32>) -> ()
}
]
def sub_to_and_vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.and %arg1, %arg0 : vector<2xi32>
  %3 = llvm.sub %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem sub_to_and_vec_proof : sub_to_and_vec_before ⊑ sub_to_and_vec_after := by
  sorry


