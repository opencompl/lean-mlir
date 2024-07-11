
def foo_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %2 = llvm.or %0, %1 : i32
  %3 = llvm.and %arg0, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def foo_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem foo_proof : foo_before ⊑ foo_after := by
  sorry


