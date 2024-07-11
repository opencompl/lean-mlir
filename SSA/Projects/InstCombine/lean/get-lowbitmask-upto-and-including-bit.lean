
def t9_nocse_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg0 : i8
  %3 = llvm.shl %0, %arg0 : i8
  %4 = llvm.add %2, %1 : i8
  %5 = llvm.or %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def t9_nocse_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg0 : i8
  %3 = llvm.shl %1, %arg0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem t9_nocse_proof : t9_nocse_before ⊑ t9_nocse_after := by
  sorry



def t17_nocse_mismatching_x_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg0 : i8
  %3 = llvm.shl %0, %arg1 : i8
  %4 = llvm.add %2, %1 : i8
  %5 = llvm.or %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def t17_nocse_mismatching_x_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg1 : i8
  %3 = llvm.shl %1, %arg0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem t17_nocse_mismatching_x_proof : t17_nocse_mismatching_x_before ⊑ t17_nocse_mismatching_x_after := by
  sorry


