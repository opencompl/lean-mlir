
def PR2539_B_before := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def PR2539_B_after := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem PR2539_B_proof : PR2539_B_before ⊑ PR2539_B_after := by
  sorry


