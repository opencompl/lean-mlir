
def vector_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg2, %1 : vector<2xi4>
  %3 = llvm.xor %arg0, %arg1 : vector<2xi4>
  %4 = llvm.and %3, %2 : vector<2xi4>
  %5 = llvm.xor %4, %arg1 : vector<2xi4>
  "llvm.return"(%5) : (vector<2xi4>) -> ()
}
]
def vector_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = llvm.xor %arg0, %arg1 : vector<2xi4>
  %1 = llvm.and %0, %arg2 : vector<2xi4>
  %2 = llvm.xor %1, %arg0 : vector<2xi4>
  "llvm.return"(%2) : (vector<2xi4>) -> ()
}
]
theorem vector_proof : vector_before ⊑ vector_after := by
  sorry



def in_constant_varx_mone_invmask_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg1, %1 : vector<2xi4>
  %3 = llvm.xor %arg0, %1 : vector<2xi4>
  %4 = llvm.and %3, %2 : vector<2xi4>
  %5 = llvm.xor %4, %1 : vector<2xi4>
  "llvm.return"(%5) : (vector<2xi4>) -> ()
}
]
def in_constant_varx_mone_invmask_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = llvm.or %arg0, %arg1 : vector<2xi4>
  "llvm.return"(%0) : (vector<2xi4>) -> ()
}
]
theorem in_constant_varx_mone_invmask_proof : in_constant_varx_mone_invmask_before ⊑ in_constant_varx_mone_invmask_after := by
  sorry



def in_constant_varx_6_invmask_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.xor %arg1, %1 : vector<2xi4>
  %5 = llvm.xor %arg0, %3 : vector<2xi4>
  %6 = llvm.and %5, %4 : vector<2xi4>
  %7 = llvm.xor %6, %3 : vector<2xi4>
  "llvm.return"(%7) : (vector<2xi4>) -> ()
}
]
def in_constant_varx_6_invmask_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg0, %1 : vector<2xi4>
  %3 = llvm.and %2, %arg1 : vector<2xi4>
  %4 = llvm.xor %3, %arg0 : vector<2xi4>
  "llvm.return"(%4) : (vector<2xi4>) -> ()
}
]
theorem in_constant_varx_6_invmask_proof : in_constant_varx_6_invmask_before ⊑ in_constant_varx_6_invmask_after := by
  sorry



def in_constant_varx_6_invmask_nonsplat_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %4 = "llvm.mlir.constant"() <{"value" = dense<[6, 7]> : vector<2xi4>}> : () -> vector<2xi4>
  %5 = llvm.xor %arg1, %1 : vector<2xi4>
  %6 = llvm.xor %arg0, %4 : vector<2xi4>
  %7 = llvm.and %6, %5 : vector<2xi4>
  %8 = llvm.xor %7, %4 : vector<2xi4>
  "llvm.return"(%8) : (vector<2xi4>) -> ()
}
]
def in_constant_varx_6_invmask_nonsplat_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %2 = "llvm.mlir.constant"() <{"value" = dense<[6, 7]> : vector<2xi4>}> : () -> vector<2xi4>
  %3 = llvm.xor %arg0, %2 : vector<2xi4>
  %4 = llvm.and %3, %arg1 : vector<2xi4>
  %5 = llvm.xor %4, %arg0 : vector<2xi4>
  "llvm.return"(%5) : (vector<2xi4>) -> ()
}
]
theorem in_constant_varx_6_invmask_nonsplat_proof : in_constant_varx_6_invmask_nonsplat_before ⊑ in_constant_varx_6_invmask_nonsplat_after := by
  sorry



def in_constant_mone_vary_invmask_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg1, %1 : vector<2xi4>
  %3 = llvm.xor %1, %arg0 : vector<2xi4>
  %4 = llvm.and %3, %2 : vector<2xi4>
  %5 = llvm.xor %4, %arg0 : vector<2xi4>
  "llvm.return"(%5) : (vector<2xi4>) -> ()
}
]
def in_constant_mone_vary_invmask_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg1, %1 : vector<2xi4>
  %3 = llvm.or %2, %arg0 : vector<2xi4>
  "llvm.return"(%3) : (vector<2xi4>) -> ()
}
]
theorem in_constant_mone_vary_invmask_proof : in_constant_mone_vary_invmask_before ⊑ in_constant_mone_vary_invmask_after := by
  sorry



def in_constant_6_vary_invmask_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.xor %arg1, %1 : vector<2xi4>
  %5 = llvm.xor %arg0, %3 : vector<2xi4>
  %6 = llvm.and %5, %4 : vector<2xi4>
  %7 = llvm.xor %6, %arg0 : vector<2xi4>
  "llvm.return"(%7) : (vector<2xi4>) -> ()
}
]
def in_constant_6_vary_invmask_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg0, %1 : vector<2xi4>
  %3 = llvm.and %2, %arg1 : vector<2xi4>
  %4 = llvm.xor %3, %1 : vector<2xi4>
  "llvm.return"(%4) : (vector<2xi4>) -> ()
}
]
theorem in_constant_6_vary_invmask_proof : in_constant_6_vary_invmask_before ⊑ in_constant_6_vary_invmask_after := by
  sorry



def in_constant_6_vary_invmask_nonsplat_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %4 = "llvm.mlir.constant"() <{"value" = dense<[6, 7]> : vector<2xi4>}> : () -> vector<2xi4>
  %5 = llvm.xor %arg1, %1 : vector<2xi4>
  %6 = llvm.xor %arg0, %4 : vector<2xi4>
  %7 = llvm.and %6, %5 : vector<2xi4>
  %8 = llvm.xor %7, %arg0 : vector<2xi4>
  "llvm.return"(%8) : (vector<2xi4>) -> ()
}
]
def in_constant_6_vary_invmask_nonsplat_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %2 = "llvm.mlir.constant"() <{"value" = dense<[6, 7]> : vector<2xi4>}> : () -> vector<2xi4>
  %3 = llvm.xor %arg0, %2 : vector<2xi4>
  %4 = llvm.and %3, %arg1 : vector<2xi4>
  %5 = llvm.xor %4, %2 : vector<2xi4>
  "llvm.return"(%5) : (vector<2xi4>) -> ()
}
]
theorem in_constant_6_vary_invmask_nonsplat_proof : in_constant_6_vary_invmask_nonsplat_before ⊑ in_constant_6_vary_invmask_nonsplat_after := by
  sorry



def c_1_0_0_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg2, %1 : vector<2xi4>
  %3 = llvm.xor %arg1, %arg0 : vector<2xi4>
  %4 = llvm.and %3, %2 : vector<2xi4>
  %5 = llvm.xor %4, %arg1 : vector<2xi4>
  "llvm.return"(%5) : (vector<2xi4>) -> ()
}
]
def c_1_0_0_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = llvm.xor %arg1, %arg0 : vector<2xi4>
  %1 = llvm.and %0, %arg2 : vector<2xi4>
  %2 = llvm.xor %1, %arg0 : vector<2xi4>
  "llvm.return"(%2) : (vector<2xi4>) -> ()
}
]
theorem c_1_0_0_proof : c_1_0_0_before ⊑ c_1_0_0_after := by
  sorry



def c_0_1_0_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg2, %1 : vector<2xi4>
  %3 = llvm.xor %arg0, %arg1 : vector<2xi4>
  %4 = llvm.and %3, %2 : vector<2xi4>
  %5 = llvm.xor %4, %arg0 : vector<2xi4>
  "llvm.return"(%5) : (vector<2xi4>) -> ()
}
]
def c_0_1_0_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = llvm.xor %arg0, %arg1 : vector<2xi4>
  %1 = llvm.and %0, %arg2 : vector<2xi4>
  %2 = llvm.xor %1, %arg1 : vector<2xi4>
  "llvm.return"(%2) : (vector<2xi4>) -> ()
}
]
theorem c_0_1_0_proof : c_0_1_0_before ⊑ c_0_1_0_after := by
  sorry



def c_1_1_0_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg2, %1 : vector<2xi4>
  %3 = llvm.xor %arg1, %arg0 : vector<2xi4>
  %4 = llvm.and %3, %2 : vector<2xi4>
  %5 = llvm.xor %4, %arg0 : vector<2xi4>
  "llvm.return"(%5) : (vector<2xi4>) -> ()
}
]
def c_1_1_0_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = llvm.xor %arg1, %arg0 : vector<2xi4>
  %1 = llvm.and %0, %arg2 : vector<2xi4>
  %2 = llvm.xor %1, %arg1 : vector<2xi4>
  "llvm.return"(%2) : (vector<2xi4>) -> ()
}
]
theorem c_1_1_0_proof : c_1_1_0_before ⊑ c_1_1_0_after := by
  sorry



def commutativity_constant_varx_6_invmask_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.xor %arg1, %1 : vector<2xi4>
  %5 = llvm.xor %arg0, %3 : vector<2xi4>
  %6 = llvm.and %4, %5 : vector<2xi4>
  %7 = llvm.xor %6, %3 : vector<2xi4>
  "llvm.return"(%7) : (vector<2xi4>) -> ()
}
]
def commutativity_constant_varx_6_invmask_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg0, %1 : vector<2xi4>
  %3 = llvm.and %2, %arg1 : vector<2xi4>
  %4 = llvm.xor %3, %arg0 : vector<2xi4>
  "llvm.return"(%4) : (vector<2xi4>) -> ()
}
]
theorem commutativity_constant_varx_6_invmask_proof : commutativity_constant_varx_6_invmask_before ⊑ commutativity_constant_varx_6_invmask_after := by
  sorry



def commutativity_constant_6_vary_invmask_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.xor %arg1, %1 : vector<2xi4>
  %5 = llvm.xor %arg0, %3 : vector<2xi4>
  %6 = llvm.and %4, %5 : vector<2xi4>
  %7 = llvm.xor %6, %arg0 : vector<2xi4>
  "llvm.return"(%7) : (vector<2xi4>) -> ()
}
]
def commutativity_constant_6_vary_invmask_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg0, %1 : vector<2xi4>
  %3 = llvm.and %2, %arg1 : vector<2xi4>
  %4 = llvm.xor %3, %1 : vector<2xi4>
  "llvm.return"(%4) : (vector<2xi4>) -> ()
}
]
theorem commutativity_constant_6_vary_invmask_proof : commutativity_constant_6_vary_invmask_before ⊑ commutativity_constant_6_vary_invmask_after := by
  sorry


