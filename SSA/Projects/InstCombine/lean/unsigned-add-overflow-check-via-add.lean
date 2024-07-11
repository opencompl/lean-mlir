
def t6_no_extrause_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.add %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%0, %arg1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def t6_no_extrause_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem t6_no_extrause_proof : t6_no_extrause_before ⊑ t6_no_extrause_after := by
  sorry


