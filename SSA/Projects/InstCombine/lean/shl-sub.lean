
def shl_bad_sub2_i32_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = llvm.sub %arg0, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_bad_sub2_i32_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem shl_bad_sub2_i32_proof : shl_bad_sub2_i32_before ⊑ shl_bad_sub2_i32_after := by
  sorry



def bad_shl2_sub_i32_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = llvm.sub %arg0, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def bad_shl2_sub_i32_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem bad_shl2_sub_i32_proof : bad_shl2_sub_i32_before ⊑ bad_shl2_sub_i32_after := by
  sorry



def shl_const_op1_sub_const_op0_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_const_op1_sub_const_op0_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 336 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem shl_const_op1_sub_const_op0_proof : shl_const_op1_sub_const_op0_before ⊑ shl_const_op1_sub_const_op0_after := by
  sorry



def shl_const_op1_sub_const_op0_splat_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.sub %0, %arg0 : vector<2xi32>
  %3 = llvm.shl %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def shl_const_op1_sub_const_op0_splat_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<336> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.shl %arg0, %0 : vector<2xi32>
  %3 = llvm.sub %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem shl_const_op1_sub_const_op0_splat_proof : shl_const_op1_sub_const_op0_splat_before ⊑ shl_const_op1_sub_const_op0_splat_after := by
  sorry


