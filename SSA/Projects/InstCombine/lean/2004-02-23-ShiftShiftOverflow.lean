
def test2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 17 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  %2 = llvm.shl %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry


