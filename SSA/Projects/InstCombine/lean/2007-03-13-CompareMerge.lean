
def test_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %2 = llvm.or %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i32, i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test_proof : test_before ⊑ test_after := by
  sorry


