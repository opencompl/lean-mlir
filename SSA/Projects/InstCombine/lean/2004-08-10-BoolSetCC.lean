
def test_before := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test_proof : test_before ⊑ test_after := by
  sorry


