
def factorize_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.or %arg0, %1 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def factorize_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem factorize_proof : factorize_before ⊑ factorize_after := by
  sorry



def factorize2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.mul %0, %arg0 : i32
  %3 = llvm.mul %1, %arg0 : i32
  %4 = llvm.sub %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def factorize2_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem factorize2_proof : factorize2_before ⊑ factorize2_after := by
  sorry



def factorize3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.or %arg1, %arg2 : i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.or %arg0, %arg2 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def factorize3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.or %arg2, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem factorize3_proof : factorize3_before ⊑ factorize3_after := by
  sorry



def factorize4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.shl %arg1, %0 : i32
  %2 = llvm.mul %1, %arg0 : i32
  %3 = llvm.mul %arg0, %arg1 : i32
  %4 = llvm.sub %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def factorize4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mul %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem factorize4_proof : factorize4_before ⊑ factorize4_after := by
  sorry



def factorize5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %0 : i32
  %2 = llvm.mul %1, %arg0 : i32
  %3 = llvm.mul %arg0, %arg1 : i32
  %4 = llvm.sub %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def factorize5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mul %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem factorize5_proof : factorize5_before ⊑ factorize5_after := by
  sorry



def expand_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = llvm.and %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def expand_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem expand_proof : expand_before ⊑ expand_after := by
  sorry


