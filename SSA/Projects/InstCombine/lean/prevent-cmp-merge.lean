
def test3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 31 : i32}> : () -> i32
  %2 = llvm.sub %arg0, %arg1 : i32
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i32}> : () -> i32
  %1 = llvm.sub %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry


