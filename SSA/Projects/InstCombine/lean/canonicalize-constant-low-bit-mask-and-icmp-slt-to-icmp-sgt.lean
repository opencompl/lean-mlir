
def p0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = llvm.and %arg0, %0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def p0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem p0_proof : p0_before ⊑ p0_after := by
  sorry



def p1_vec_splat_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.and %arg0, %0 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def p1_vec_splat_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem p1_vec_splat_proof : p1_vec_splat_before ⊑ p1_vec_splat_after := by
  sorry



def p2_vec_nonsplat_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[3, 15]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.and %arg0, %0 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def p2_vec_nonsplat_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[3, 15]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem p2_vec_nonsplat_proof : p2_vec_nonsplat_before ⊑ p2_vec_nonsplat_after := by
  sorry


