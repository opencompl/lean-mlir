
def flip_add_of_shift_neg_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = llvm.shl %1, %arg1 : i8
  %3 = llvm.add %2, %arg2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def flip_add_of_shift_neg_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.shl %arg0, %arg1 : i8
  %1 = llvm.sub %arg2, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem flip_add_of_shift_neg_proof : flip_add_of_shift_neg_before ⊑ flip_add_of_shift_neg_after := by
  sorry



def flip_add_of_shift_neg_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>, %arg2 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.mul %arg2, %arg2 : vector<2xi8>
  %3 = llvm.sub %1, %arg0 : vector<2xi8>
  %4 = llvm.shl %3, %arg1 : vector<2xi8>
  %5 = llvm.add %2, %4 : vector<2xi8>
  "llvm.return"(%5) : (vector<2xi8>) -> ()
}
]
def flip_add_of_shift_neg_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>, %arg2 : vector<2xi8>):
  %0 = llvm.mul %arg2, %arg2 : vector<2xi8>
  %1 = llvm.shl %arg0, %arg1 : vector<2xi8>
  %2 = llvm.sub %0, %1 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
theorem flip_add_of_shift_neg_vec_proof : flip_add_of_shift_neg_vec_before ⊑ flip_add_of_shift_neg_vec_after := by
  sorry


