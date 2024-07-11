
def hang_2002-03-11_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"() : () -> ()
}
]
def hang_2002-03-11_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"() : () -> ()
}
]
theorem hang_2002-03-11_proof : hang_2002-03-11_before ⊑ hang_2002-03-11_after := by
  sorry



def missed_const_prop_2002-12-05_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.sub %0, %1 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.add %arg0, %4 : i32
  %6 = llvm.add %2, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def missed_const_prop_2002-12-05_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem missed_const_prop_2002-12-05_proof : missed_const_prop_2002-12-05_before ⊑ missed_const_prop_2002-12-05_after := by
  sorry


