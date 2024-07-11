
def test_before := [llvm|
{
^0(%arg0 : i26):
  %0 = "llvm.mlir.constant"() <{"value" = 2885 : i26}> : () -> i26
  %1 = "llvm.mlir.constant"() <{"value" = 2884 : i26}> : () -> i26
  %2 = llvm.mul %arg0, %0 : i26
  %3 = llvm.mul %arg0, %1 : i26
  %4 = llvm.sub %2, %3 : i26
  "llvm.return"(%4) : (i26) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i26):
  "llvm.return"(%arg0) : (i26) -> ()
}
]
theorem test_proof : test_before ⊑ test_after := by
  sorry


