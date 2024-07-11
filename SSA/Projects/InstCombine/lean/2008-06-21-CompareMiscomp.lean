
def test_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 13 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_proof : test_before ⊑ test_after := by
  sorry


