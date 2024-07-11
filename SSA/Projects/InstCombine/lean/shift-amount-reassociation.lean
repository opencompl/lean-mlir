
def t6_shl_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg1 : i32
  %3 = llvm.shl %arg0, %2 : i32
  %4 = llvm.add %arg1, %1 : i32
  %5 = llvm.shl %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t6_shl_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 30 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t6_shl_proof : t6_shl_before ⊑ t6_shl_after := by
  sorry



def t10_shl_nuw_flag_preservation_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg1 : i32
  %3 = llvm.shl %arg0, %2 : i32
  %4 = llvm.add %arg1, %1 : i32
  %5 = llvm.shl %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t10_shl_nuw_flag_preservation_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 30 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t10_shl_nuw_flag_preservation_proof : t10_shl_nuw_flag_preservation_before ⊑ t10_shl_nuw_flag_preservation_after := by
  sorry



def t11_shl_nsw_flag_preservation_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg1 : i32
  %3 = llvm.shl %arg0, %2 : i32
  %4 = llvm.add %arg1, %1 : i32
  %5 = llvm.shl %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def t11_shl_nsw_flag_preservation_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 30 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem t11_shl_nsw_flag_preservation_proof : t11_shl_nsw_flag_preservation_before ⊑ t11_shl_nsw_flag_preservation_after := by
  sorry


