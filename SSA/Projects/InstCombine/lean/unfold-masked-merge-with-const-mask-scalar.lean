
def scalar0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %arg1 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def scalar0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %2 = llvm.and %arg0, %0 : i4
  %3 = llvm.and %arg1, %1 : i4
  %4 = llvm.or %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
theorem scalar0_proof : scalar0_before ⊑ scalar0_after := by
  sorry



def scalar1_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %arg1 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def scalar1_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %2 = llvm.and %arg0, %0 : i4
  %3 = llvm.and %arg1, %1 : i4
  %4 = llvm.or %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
theorem scalar1_proof : scalar1_before ⊑ scalar1_after := by
  sorry



def in_constant_varx_mone_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_varx_mone_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = llvm.or %arg0, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem in_constant_varx_mone_proof : in_constant_varx_mone_before ⊑ in_constant_varx_mone_after := by
  sorry



def in_constant_varx_14_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_varx_14_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = llvm.or %arg0, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem in_constant_varx_14_proof : in_constant_varx_14_before ⊑ in_constant_varx_14_after := by
  sorry



def in_constant_mone_vary_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_mone_vary_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %1 = llvm.or %arg0, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem in_constant_mone_vary_proof : in_constant_mone_vary_before ⊑ in_constant_mone_vary_after := by
  sorry



def in_constant_14_vary_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def in_constant_14_vary_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = llvm.and %arg0, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem in_constant_14_vary_proof : in_constant_14_vary_before ⊑ in_constant_14_vary_after := by
  sorry



def c_1_0_0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = llvm.xor %arg1, %arg0 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def c_1_0_0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %2 = llvm.and %arg0, %0 : i4
  %3 = llvm.and %arg1, %1 : i4
  %4 = llvm.or %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
theorem c_1_0_0_proof : c_1_0_0_before ⊑ c_1_0_0_after := by
  sorry



def c_0_1_0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %arg1 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg0 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def c_0_1_0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %2 = llvm.and %arg1, %0 : i4
  %3 = llvm.and %arg0, %1 : i4
  %4 = llvm.or %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
theorem c_0_1_0_proof : c_0_1_0_before ⊑ c_0_1_0_after := by
  sorry



def c_1_1_0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = llvm.xor %arg1, %arg0 : i4
  %2 = llvm.and %1, %0 : i4
  %3 = llvm.xor %2, %arg0 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def c_1_1_0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %2 = llvm.and %arg1, %0 : i4
  %3 = llvm.and %arg0, %1 : i4
  %4 = llvm.or %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
theorem c_1_1_0_proof : c_1_1_0_before ⊑ c_1_1_0_after := by
  sorry



def commutativity_constant_14_vary_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.and %2, %1 : i4
  %4 = llvm.xor %arg0, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def commutativity_constant_14_vary_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = llvm.and %arg0, %0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem commutativity_constant_14_vary_proof : commutativity_constant_14_vary_before ⊑ commutativity_constant_14_vary_after := by
  sorry


