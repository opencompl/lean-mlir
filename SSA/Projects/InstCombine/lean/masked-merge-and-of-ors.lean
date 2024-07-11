
def p_commutative0_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg2, %0 : i32
  %2 = llvm.or %arg0, %1 : i32
  %3 = llvm.or %arg1, %arg2 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative0_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg2, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.or %arg1, %arg2 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative0_proof : p_commutative0_before ⊑ p_commutative0_after := by
  sorry



def p_commutative4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg2, %0 : i32
  %2 = llvm.or %arg0, %1 : i32
  %3 = llvm.or %arg1, %arg2 : i32
  %4 = llvm.and %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg2, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.or %arg1, %arg2 : i32
  %4 = llvm.and %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative4_proof : p_commutative4_before ⊑ p_commutative4_after := by
  sorry



def n3_constmask_samemask_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -65281 : i32}> : () -> i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.or %arg1, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def n3_constmask_samemask_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -65281 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.or %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem n3_constmask_samemask_proof : n3_constmask_samemask_before ⊑ n3_constmask_samemask_after := by
  sorry


