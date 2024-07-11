
def lshr_C1_add_A_C2_i32_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 65535 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 5 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.shl %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lshr_C1_add_A_C2_i32_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 65535 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 192 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem lshr_C1_add_A_C2_i32_proof : lshr_C1_add_A_C2_i32_before ⊑ lshr_C1_add_A_C2_i32_after := by
  sorry



def shl_add_nuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_add_nuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 192 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_add_nuw_proof : shl_add_nuw_before ⊑ shl_add_nuw_after := by
  sorry



def shl_nuw_add_nuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  %2 = llvm.shl %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_nuw_add_nuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_nuw_add_nuw_proof : shl_nuw_add_nuw_before ⊑ shl_nuw_add_nuw_after := by
  sorry



def shl_nsw_add_nuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_add_nuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_nsw_add_nuw_proof : shl_nsw_add_nuw_before ⊑ shl_nsw_add_nuw_after := by
  sorry



def shl_nsw_add_negative_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_add_negative_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem shl_nsw_add_negative_proof : shl_nsw_add_negative_before ⊑ shl_nsw_add_negative_after := by
  sorry



def shl_nsw_add_negative_invalid_constant3_before := [llvm|
{
^0(%arg0 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -8 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i4}> : () -> i4
  %2 = llvm.add %arg0, %0 : i4
  %3 = llvm.shl %1, %2 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def shl_nsw_add_negative_invalid_constant3_after := [llvm|
{
^0(%arg0 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -8 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.shl %1, %2 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem shl_nsw_add_negative_invalid_constant3_proof : shl_nsw_add_negative_invalid_constant3_before ⊑ shl_nsw_add_negative_invalid_constant3_after := by
  sorry


