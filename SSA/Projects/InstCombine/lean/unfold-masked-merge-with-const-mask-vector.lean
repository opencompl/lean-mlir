
def splat_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg0, %arg1 : vector<2xi4>
  %3 = llvm.and %2, %1 : vector<2xi4>
  %4 = llvm.xor %3, %arg1 : vector<2xi4>
  "llvm.return"(%4) : (vector<2xi4>) -> ()
}
]
def splat_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.and %arg0, %1 : vector<2xi4>
  %5 = llvm.and %arg1, %3 : vector<2xi4>
  %6 = llvm.or %4, %5 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
theorem splat_proof : splat_before ⊑ splat_after := by
  sorry



def nonsplat_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %2 = "llvm.mlir.constant"() <{"value" = dense<[-2, 1]> : vector<2xi4>}> : () -> vector<2xi4>
  %3 = llvm.xor %arg0, %arg1 : vector<2xi4>
  %4 = llvm.and %3, %2 : vector<2xi4>
  %5 = llvm.xor %4, %arg1 : vector<2xi4>
  "llvm.return"(%5) : (vector<2xi4>) -> ()
}
]
def nonsplat_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %2 = "llvm.mlir.constant"() <{"value" = dense<[-2, 1]> : vector<2xi4>}> : () -> vector<2xi4>
  %3 = "llvm.mlir.constant"() <{"value" = dense<[1, -2]> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.and %arg0, %2 : vector<2xi4>
  %5 = llvm.and %arg1, %3 : vector<2xi4>
  %6 = llvm.or %4, %5 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
theorem nonsplat_proof : nonsplat_before ⊑ nonsplat_after := by
  sorry



def in_constant_varx_mone_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.xor %arg0, %1 : vector<2xi4>
  %5 = llvm.and %4, %3 : vector<2xi4>
  %6 = llvm.xor %5, %1 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
def in_constant_varx_mone_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.or %arg0, %1 : vector<2xi4>
  "llvm.return"(%2) : (vector<2xi4>) -> ()
}
]
theorem in_constant_varx_mone_proof : in_constant_varx_mone_before ⊑ in_constant_varx_mone_after := by
  sorry



def in_constant_varx_14_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.xor %arg0, %1 : vector<2xi4>
  %5 = llvm.and %4, %3 : vector<2xi4>
  %6 = llvm.xor %5, %1 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
def in_constant_varx_14_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.or %arg0, %1 : vector<2xi4>
  "llvm.return"(%2) : (vector<2xi4>) -> ()
}
]
theorem in_constant_varx_14_proof : in_constant_varx_14_before ⊑ in_constant_varx_14_after := by
  sorry



def in_constant_varx_14_nonsplat_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %2 = "llvm.mlir.constant"() <{"value" = dense<[-2, 7]> : vector<2xi4>}> : () -> vector<2xi4>
  %3 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %4 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %5 = llvm.xor %arg0, %2 : vector<2xi4>
  %6 = llvm.and %5, %4 : vector<2xi4>
  %7 = llvm.xor %6, %2 : vector<2xi4>
  "llvm.return"(%7) : (vector<2xi4>) -> ()
}
]
def in_constant_varx_14_nonsplat_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %4 = "llvm.mlir.constant"() <{"value" = dense<[-2, 6]> : vector<2xi4>}> : () -> vector<2xi4>
  %5 = llvm.and %arg0, %1 : vector<2xi4>
  %6 = llvm.or %5, %4 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
theorem in_constant_varx_14_nonsplat_proof : in_constant_varx_14_nonsplat_before ⊑ in_constant_varx_14_nonsplat_after := by
  sorry



def in_constant_mone_vary_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.xor %arg0, %1 : vector<2xi4>
  %5 = llvm.and %4, %3 : vector<2xi4>
  %6 = llvm.xor %5, %arg0 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
def in_constant_mone_vary_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.or %arg0, %1 : vector<2xi4>
  "llvm.return"(%2) : (vector<2xi4>) -> ()
}
]
theorem in_constant_mone_vary_proof : in_constant_mone_vary_before ⊑ in_constant_mone_vary_after := by
  sorry



def in_constant_14_vary_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.xor %arg0, %1 : vector<2xi4>
  %5 = llvm.and %4, %3 : vector<2xi4>
  %6 = llvm.xor %5, %arg0 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
def in_constant_14_vary_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.and %arg0, %1 : vector<2xi4>
  "llvm.return"(%2) : (vector<2xi4>) -> ()
}
]
theorem in_constant_14_vary_proof : in_constant_14_vary_before ⊑ in_constant_14_vary_after := by
  sorry



def in_constant_14_vary_nonsplat_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %2 = "llvm.mlir.constant"() <{"value" = dense<[-2, 7]> : vector<2xi4>}> : () -> vector<2xi4>
  %3 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %4 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %5 = llvm.xor %arg0, %2 : vector<2xi4>
  %6 = llvm.and %5, %4 : vector<2xi4>
  %7 = llvm.xor %6, %arg0 : vector<2xi4>
  "llvm.return"(%7) : (vector<2xi4>) -> ()
}
]
def in_constant_14_vary_nonsplat_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = 0 : i4}> : () -> i4
  %4 = "llvm.mlir.constant"() <{"value" = dense<[0, 1]> : vector<2xi4>}> : () -> vector<2xi4>
  %5 = llvm.and %arg0, %1 : vector<2xi4>
  %6 = llvm.or %5, %4 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
theorem in_constant_14_vary_nonsplat_proof : in_constant_14_vary_nonsplat_before ⊑ in_constant_14_vary_nonsplat_after := by
  sorry



def c_1_0_0_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg1, %arg0 : vector<2xi4>
  %3 = llvm.and %2, %1 : vector<2xi4>
  %4 = llvm.xor %3, %arg1 : vector<2xi4>
  "llvm.return"(%4) : (vector<2xi4>) -> ()
}
]
def c_1_0_0_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.and %arg0, %1 : vector<2xi4>
  %5 = llvm.and %arg1, %3 : vector<2xi4>
  %6 = llvm.or %4, %5 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
theorem c_1_0_0_proof : c_1_0_0_before ⊑ c_1_0_0_after := by
  sorry



def c_0_1_0_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg0, %arg1 : vector<2xi4>
  %3 = llvm.and %2, %1 : vector<2xi4>
  %4 = llvm.xor %3, %arg0 : vector<2xi4>
  "llvm.return"(%4) : (vector<2xi4>) -> ()
}
]
def c_0_1_0_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.and %arg1, %1 : vector<2xi4>
  %5 = llvm.and %arg0, %3 : vector<2xi4>
  %6 = llvm.or %4, %5 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
theorem c_0_1_0_proof : c_0_1_0_before ⊑ c_0_1_0_after := by
  sorry



def c_1_1_0_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg1, %arg0 : vector<2xi4>
  %3 = llvm.and %2, %1 : vector<2xi4>
  %4 = llvm.xor %3, %arg0 : vector<2xi4>
  "llvm.return"(%4) : (vector<2xi4>) -> ()
}
]
def c_1_1_0_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.and %arg1, %1 : vector<2xi4>
  %5 = llvm.and %arg0, %3 : vector<2xi4>
  %6 = llvm.or %4, %5 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
theorem c_1_1_0_proof : c_1_1_0_before ⊑ c_1_1_0_after := by
  sorry



def commutativity_constant_14_vary_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.xor %arg0, %1 : vector<2xi4>
  %5 = llvm.and %4, %3 : vector<2xi4>
  %6 = llvm.xor %arg0, %5 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
def commutativity_constant_14_vary_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.and %arg0, %1 : vector<2xi4>
  "llvm.return"(%2) : (vector<2xi4>) -> ()
}
]
theorem commutativity_constant_14_vary_proof : commutativity_constant_14_vary_before ⊑ commutativity_constant_14_vary_after := by
  sorry


