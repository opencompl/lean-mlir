
def test_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -16777216 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 167772160 : i32}> : () -> i32
  %3 = llvm.shl %arg0, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 16711680 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 655360 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem test_proof : test_before ⊑ test_after := by
  sorry


