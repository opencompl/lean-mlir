
def test1_before := [llvm|
{
^0(%arg0 : i447, %arg1 : i447):
  %0 = "llvm.mlir.constant"() <{"value" = 70368744177664 : i447}> : () -> i447
  %1 = "llvm.mlir.constant"() <{"value" = 70368744177663 : i447}> : () -> i447
  %2 = llvm.and %arg0, %0 : i447
  %3 = llvm.and %arg1, %1 : i447
  %4 = llvm.xor %2, %3 : i447
  "llvm.return"(%4) : (i447) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i447, %arg1 : i447):
  %0 = "llvm.mlir.constant"() <{"value" = 70368744177664 : i447}> : () -> i447
  %1 = "llvm.mlir.constant"() <{"value" = 70368744177663 : i447}> : () -> i447
  %2 = llvm.and %arg0, %0 : i447
  %3 = llvm.and %arg1, %1 : i447
  %4 = llvm.or %2, %3 : i447
  "llvm.return"(%4) : (i447) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : i1005):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i1005}> : () -> i1005
  %1 = llvm.xor %arg0, %0 : i1005
  "llvm.return"(%1) : (i1005) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i1005):
  "llvm.return"(%arg0) : (i1005) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry



def test3_before := [llvm|
{
^0(%arg0 : i123):
  %0 = llvm.xor %arg0, %arg0 : i123
  "llvm.return"(%0) : (i123) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i123):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i123}> : () -> i123
  "llvm.return"(%0) : (i123) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry



def test4_before := [llvm|
{
^0(%arg0 : i737):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i737}> : () -> i737
  %1 = llvm.xor %0, %arg0 : i737
  %2 = llvm.xor %arg0, %1 : i737
  "llvm.return"(%2) : (i737) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i737):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i737}> : () -> i737
  "llvm.return"(%0) : (i737) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  sorry



def test5_before := [llvm|
{
^0(%arg0 : i700):
  %0 = "llvm.mlir.constant"() <{"value" = 288230376151711743 : i700}> : () -> i700
  %1 = llvm.or %arg0, %0 : i700
  %2 = llvm.xor %1, %0 : i700
  "llvm.return"(%2) : (i700) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i700):
  %0 = "llvm.mlir.constant"() <{"value" = -288230376151711744 : i700}> : () -> i700
  %1 = llvm.and %arg0, %0 : i700
  "llvm.return"(%1) : (i700) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  sorry



def test6_before := [llvm|
{
^0(%arg0 : i77):
  %0 = "llvm.mlir.constant"() <{"value" = 23 : i77}> : () -> i77
  %1 = llvm.xor %arg0, %0 : i77
  %2 = llvm.xor %1, %0 : i77
  "llvm.return"(%2) : (i77) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg0 : i77):
  "llvm.return"(%arg0) : (i77) -> ()
}
]
theorem test6_proof : test6_before ⊑ test6_after := by
  sorry



def test7_before := [llvm|
{
^0(%arg0 : i1023):
  %0 = "llvm.mlir.constant"() <{"value" = 70368744177663 : i1023}> : () -> i1023
  %1 = "llvm.mlir.constant"() <{"value" = 703687463 : i1023}> : () -> i1023
  %2 = llvm.or %arg0, %0 : i1023
  %3 = llvm.xor %2, %1 : i1023
  "llvm.return"(%3) : (i1023) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : i1023):
  %0 = "llvm.mlir.constant"() <{"value" = -70368744177664 : i1023}> : () -> i1023
  %1 = "llvm.mlir.constant"() <{"value" = 70368040490200 : i1023}> : () -> i1023
  %2 = llvm.and %arg0, %0 : i1023
  %3 = llvm.or %2, %1 : i1023
  "llvm.return"(%3) : (i1023) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  sorry


