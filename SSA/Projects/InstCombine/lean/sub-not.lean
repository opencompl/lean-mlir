
def sub_not_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.sub %arg0, %arg1 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sub_not_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.add %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem sub_not_proof : sub_not_before ⊑ sub_not_after := by
  sorry



def dec_sub_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.sub %arg0, %arg1 : i8
  %2 = llvm.add %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def dec_sub_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.add %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem dec_sub_proof : dec_sub_before ⊑ dec_sub_after := by
  sorry



def sub_inc_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = llvm.sub %arg1, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sub_inc_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.add %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem sub_inc_proof : sub_inc_before ⊑ sub_inc_after := by
  sorry



def sub_dec_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = llvm.sub %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sub_dec_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.add %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem sub_dec_proof : sub_dec_before ⊑ sub_dec_after := by
  sorry


