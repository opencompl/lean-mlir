
def test0_before := [llvm|
{
^0(%arg0 : i41, %arg1 : i41, %arg2 : i41):
  %0 = llvm.shl %arg0, %arg2 : i41
  %1 = llvm.shl %arg1, %arg2 : i41
  %2 = llvm.and %0, %1 : i41
  "llvm.return"(%2) : (i41) -> ()
}
]
def test0_after := [llvm|
{
^0(%arg0 : i41, %arg1 : i41, %arg2 : i41):
  %0 = llvm.and %arg0, %arg1 : i41
  %1 = llvm.shl %0, %arg2 : i41
  "llvm.return"(%1) : (i41) -> ()
}
]
theorem test0_proof : test0_before ⊑ test0_after := by
  sorry


