
def test_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.add %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.xor %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test_proof : test_before ⊑ test_after := by
  sorry


