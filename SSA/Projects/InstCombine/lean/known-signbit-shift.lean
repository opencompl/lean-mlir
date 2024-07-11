
def test_shift_negative_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = llvm.or %arg0, %0 : i32
  %4 = llvm.and %arg1, %1 : i32
  %5 = llvm.shl %3, %4 : i32
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test_shift_negative_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test_shift_negative_proof : test_shift_negative_before ⊑ test_shift_negative_after := by
  sorry


