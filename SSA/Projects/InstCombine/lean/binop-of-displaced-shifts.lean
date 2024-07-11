
def shl_or_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %3 = llvm.shl %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.or %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_or_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 22 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_or_proof : shl_or_before ⊑ shl_or_after := by
  sorry



def shl_xor_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %3 = llvm.shl %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.xor %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_xor_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 22 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_xor_proof : shl_xor_before ⊑ shl_xor_after := by
  sorry



def shl_and_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 48 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 8 : i8}> : () -> i8
  %3 = llvm.shl %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.and %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_and_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 16 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_and_proof : shl_and_before ⊑ shl_and_after := by
  sorry



def shl_add_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %3 = llvm.shl %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.add %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_add_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 30 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_add_proof : shl_add_before ⊑ shl_add_after := by
  sorry



def shl_or_commuted_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %3 = llvm.shl %0, %arg0 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.or %5, %3 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_or_commuted_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 22 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_or_commuted_proof : shl_or_commuted_before ⊑ shl_or_commuted_after := by
  sorry



def shl_or_splat_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<16> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.shl %0, %arg0 : vector<2xi8>
  %4 = llvm.add %arg0, %1 : vector<2xi8>
  %5 = llvm.shl %2, %4 : vector<2xi8>
  %6 = llvm.or %3, %5 : vector<2xi8>
  "llvm.return"(%6) : (vector<2xi8>) -> ()
}
]
def shl_or_splat_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<22> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.shl %0, %arg0 : vector<2xi8>
  "llvm.return"(%1) : (vector<2xi8>) -> ()
}
]
theorem shl_or_splat_proof : shl_or_splat_before ⊑ shl_or_splat_after := by
  sorry



def shl_or_non_splat_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[16, 32]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[1, 2]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.mlir.constant"() <{"value" = dense<[3, 7]> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.shl %0, %arg0 : vector<2xi8>
  %4 = llvm.add %arg0, %1 : vector<2xi8>
  %5 = llvm.shl %2, %4 : vector<2xi8>
  %6 = llvm.or %3, %5 : vector<2xi8>
  "llvm.return"(%6) : (vector<2xi8>) -> ()
}
]
def shl_or_non_splat_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[22, 60]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.shl %0, %arg0 : vector<2xi8>
  "llvm.return"(%1) : (vector<2xi8>) -> ()
}
]
theorem shl_or_non_splat_proof : shl_or_non_splat_before ⊑ shl_or_non_splat_after := by
  sorry



def shl_or_with_or_disjoint_instead_of_add_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %3 = llvm.shl %0, %arg0 : i8
  %4 = llvm.or %arg0, %1 : i8
  %5 = llvm.shl %2, %4 : i8
  %6 = llvm.or %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_or_with_or_disjoint_instead_of_add_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 22 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem shl_or_with_or_disjoint_instead_of_add_proof : shl_or_with_or_disjoint_instead_of_add_before ⊑ shl_or_with_or_disjoint_instead_of_add_after := by
  sorry


