
def and_signbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_signbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_signbit_shl_proof : and_signbit_shl_before ⊑ and_signbit_shl_after := by
  sorry



def and_nosignbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_nosignbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_nosignbit_shl_proof : and_nosignbit_shl_before ⊑ and_nosignbit_shl_after := by
  sorry



def or_signbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def or_signbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_signbit_shl_proof : or_signbit_shl_before ⊑ or_signbit_shl_after := by
  sorry



def or_nosignbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def or_nosignbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_nosignbit_shl_proof : or_nosignbit_shl_before ⊑ or_nosignbit_shl_after := by
  sorry



def xor_signbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def xor_signbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_signbit_shl_proof : xor_signbit_shl_before ⊑ xor_signbit_shl_after := by
  sorry



def xor_nosignbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def xor_nosignbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_nosignbit_shl_proof : xor_nosignbit_shl_before ⊑ xor_nosignbit_shl_after := by
  sorry



def add_signbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -65536 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_signbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem add_signbit_shl_proof : add_signbit_shl_before ⊑ add_signbit_shl_after := by
  sorry



def add_nosignbit_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147418112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_nosignbit_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -16777216 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem add_nosignbit_shl_proof : add_nosignbit_shl_before ⊑ add_nosignbit_shl_after := by
  sorry


