
def t0_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32, %arg3 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %2, %1 : i1
  %4 = llvm.xor %3, %0 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32, %arg3 : i32):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %2 = llvm.or %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  sorry



def n2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %2 = llvm.and %arg2, %1 : i1
  %3 = llvm.xor %2, %0 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def n2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %2 = llvm.and %1, %arg2 : i1
  %3 = llvm.xor %2, %0 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem n2_proof : n2_before ⊑ n2_after := by
  sorry


