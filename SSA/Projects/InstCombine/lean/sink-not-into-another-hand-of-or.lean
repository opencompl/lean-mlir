
def n2_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i8, %arg2 : i8, %arg3 : i8, %arg4 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.icmp"(%arg1, %arg2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %2 = llvm.xor %arg0, %0 : i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def n2_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i8, %arg2 : i8, %arg3 : i8, %arg4 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.icmp"(%arg1, %arg2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %2 = llvm.xor %arg0, %0 : i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem n2_proof : n2_before ⊑ n2_after := by
  sorry


