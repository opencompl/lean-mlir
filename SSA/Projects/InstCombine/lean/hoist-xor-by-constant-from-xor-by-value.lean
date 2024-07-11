
def t0_scalar_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.xor %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t0_scalar_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %arg1 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t0_scalar_proof : t0_scalar_before ⊑ t0_scalar_after := by
  sorry



def t1_splatvec_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.xor %arg0, %0 : vector<2xi8>
  %2 = llvm.xor %1, %arg1 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
def t1_splatvec_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.xor %arg0, %arg1 : vector<2xi8>
  %2 = llvm.xor %1, %0 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
theorem t1_splatvec_proof : t1_splatvec_before ⊑ t1_splatvec_after := by
  sorry



def t2_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[42, 24]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.xor %arg0, %0 : vector<2xi8>
  %2 = llvm.xor %1, %arg1 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
def t2_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[42, 24]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.xor %arg0, %arg1 : vector<2xi8>
  %2 = llvm.xor %1, %0 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
theorem t2_vec_proof : t2_vec_before ⊑ t2_vec_after := by
  sorry


