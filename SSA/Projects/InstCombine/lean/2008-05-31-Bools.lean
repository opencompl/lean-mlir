
def foo1_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.sub %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def foo1_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.xor %arg1, %arg0 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem foo1_proof : foo1_before ⊑ foo1_after := by
  sorry



def foo2_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.mul %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def foo2_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.and %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem foo2_proof : foo2_before ⊑ foo2_after := by
  sorry


