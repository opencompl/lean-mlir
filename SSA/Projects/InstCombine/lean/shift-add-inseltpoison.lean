
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


