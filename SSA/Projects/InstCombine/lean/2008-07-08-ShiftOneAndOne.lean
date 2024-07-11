
def PR2330_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.shl %0, %arg0 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR2330_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem PR2330_proof : PR2330_before ⊑ PR2330_after := by
  sorry


