
def test1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.or %2, %3 : i32
  %5 = llvm.and %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.shl %arg1, %0 : i32
  %2 = llvm.or %arg0, %1 : i32
  %3 = llvm.and %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry



def or_test1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.or %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def or_test1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem or_test1_proof : or_test1_before ⊑ or_test1_after := by
  sorry



def or_test2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_test2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem or_test2_proof : or_test2_before ⊑ or_test2_after := by
  sorry


