
def test1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.and %arg2, %arg0 : i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = llvm.and %0, %arg2 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.and %arg1, %arg0 : i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry



def PR75692_1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -5 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %arg0, %1 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def PR75692_1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem PR75692_1_proof : PR75692_1_before ⊑ PR75692_1_after := by
  sorry


