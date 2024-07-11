
def foo_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg1, %arg0 : i32
  %1 = llvm.mul %0, %arg1 : i32
  %2 = llvm.mul %arg1, %arg1 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def foo_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mul %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem foo_proof : foo_before ⊑ foo_after := by
  sorry



def bar_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %2 = llvm.and %arg1, %arg0 : i64
  %3 = llvm.xor %2, %0 : i64
  %4 = llvm.and %arg1, %3 : i64
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bar_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %2 = llvm.xor %arg0, %0 : i64
  %3 = llvm.and %2, %arg1 : i64
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem bar_proof : bar_before ⊑ bar_after := by
  sorry


