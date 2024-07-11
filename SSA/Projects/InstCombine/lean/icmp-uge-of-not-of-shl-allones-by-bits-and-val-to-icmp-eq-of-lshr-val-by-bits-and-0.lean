
def both_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  %2 = llvm.xor %1, %0 : i8
  %3 = llvm.shl %0, %arg1 : i8
  %4 = llvm.xor %3, %0 : i8
  %5 = "llvm.icmp"(%2, %4) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def both_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  %2 = llvm.shl %0, %arg1 : i8
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem both_proof : both_before ⊑ both_after := by
  sorry


