
def positive_easyinvert_before := [llvm|
{
^0(%arg0 : i16, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i16, i16) -> i1
  %4 = "llvm.icmp"(%arg1, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %5 = llvm.xor %4, %3 : i1
  %6 = llvm.xor %5, %2 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def positive_easyinvert_after := [llvm|
{
^0(%arg0 : i16, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i16}> : () -> i16
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 4 : i64}> : (i16, i16) -> i1
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem positive_easyinvert_proof : positive_easyinvert_before ⊑ positive_easyinvert_after := by
  sorry


