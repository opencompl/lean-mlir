
def test1_before := [llvm|
{
^0(%arg0 : i17, %arg1 : i17):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i17}> : () -> i17
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i17}> : () -> i17
  %2 = llvm.and %arg0, %0 : i17
  %3 = llvm.and %arg1, %1 : i17
  %4 = llvm.or %2, %3 : i17
  %5 = llvm.and %4, %0 : i17
  "llvm.return"(%5) : (i17) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i17, %arg1 : i17):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i17}> : () -> i17
  %1 = llvm.and %arg0, %0 : i17
  "llvm.return"(%1) : (i17) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test3_before := [llvm|
{
^0(%arg0 : i49, %arg1 : i49):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i49}> : () -> i49
  %1 = llvm.shl %arg1, %0 : i49
  %2 = llvm.or %arg0, %1 : i49
  %3 = llvm.and %2, %0 : i49
  "llvm.return"(%3) : (i49) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i49, %arg1 : i49):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i49}> : () -> i49
  %1 = llvm.and %arg0, %0 : i49
  "llvm.return"(%1) : (i49) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry



def or_test1_before := [llvm|
{
^0(%arg0 : i231, %arg1 : i231):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i231}> : () -> i231
  %1 = llvm.and %arg0, %0 : i231
  %2 = llvm.or %1, %0 : i231
  "llvm.return"(%2) : (i231) -> ()
}
]
def or_test1_after := [llvm|
{
^0(%arg0 : i231, %arg1 : i231):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i231}> : () -> i231
  "llvm.return"(%0) : (i231) -> ()
}
]
theorem or_test1_proof : or_test1_before ⊑ or_test1_after := by
  sorry



def or_test2_before := [llvm|
{
^0(%arg0 : i7, %arg1 : i7):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i7}> : () -> i7
  %1 = "llvm.mlir.constant"() <{"value" = -64 : i7}> : () -> i7
  %2 = llvm.shl %arg0, %0 : i7
  %3 = llvm.or %2, %1 : i7
  "llvm.return"(%3) : (i7) -> ()
}
]
def or_test2_after := [llvm|
{
^0(%arg0 : i7, %arg1 : i7):
  %0 = "llvm.mlir.constant"() <{"value" = -64 : i7}> : () -> i7
  "llvm.return"(%0) : (i7) -> ()
}
]
theorem or_test2_proof : or_test2_before ⊑ or_test2_after := by
  sorry


