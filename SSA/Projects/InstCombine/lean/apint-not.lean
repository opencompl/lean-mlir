
def test1_before := [llvm|
{
^0(%arg0 : i33):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i33}> : () -> i33
  %1 = llvm.xor %arg0, %0 : i33
  %2 = llvm.xor %1, %0 : i33
  "llvm.return"(%2) : (i33) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i33):
  "llvm.return"(%arg0) : (i33) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : i52, %arg1 : i52):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 7 : i64}> : (i52, i52) -> i1
  %2 = llvm.xor %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i52, %arg1 : i52):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i52, i52) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry


