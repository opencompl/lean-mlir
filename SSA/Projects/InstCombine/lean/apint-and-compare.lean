
def test1_before := [llvm|
{
^0(%arg0 : i33, %arg1 : i33):
  %0 = "llvm.mlir.constant"() <{"value" = 65280 : i33}> : () -> i33
  %1 = llvm.and %arg0, %0 : i33
  %2 = llvm.and %arg1, %0 : i33
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 1 : i64}> : (i33, i33) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i33, %arg1 : i33):
  %0 = "llvm.mlir.constant"() <{"value" = 65280 : i33}> : () -> i33
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i33}> : () -> i33
  %2 = llvm.xor %arg0, %arg1 : i33
  %3 = llvm.and %2, %0 : i33
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i33, i33) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : i999, %arg1 : i999):
  %0 = "llvm.mlir.constant"() <{"value" = 65280 : i999}> : () -> i999
  %1 = llvm.and %arg0, %0 : i999
  %2 = llvm.and %arg1, %0 : i999
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 1 : i64}> : (i999, i999) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i999, %arg1 : i999):
  %0 = "llvm.mlir.constant"() <{"value" = 65280 : i999}> : () -> i999
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i999}> : () -> i999
  %2 = llvm.xor %arg0, %arg1 : i999
  %3 = llvm.and %2, %0 : i999
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i999, i999) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry


