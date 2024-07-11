
def test_shift_and_cmp_changed2_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -64 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 32 : i8}> : () -> i8
  %3 = llvm.shl %arg0, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_shift_and_cmp_changed2_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem test_shift_and_cmp_changed2_proof : test_shift_and_cmp_changed2_before ⊑ test_shift_and_cmp_changed2_after := by
  sorry



def test_shift_and_cmp_changed2_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<5> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-64> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.mlir.constant"() <{"value" = dense<32> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.shl %arg0, %0 : vector<2xi8>
  %4 = llvm.and %3, %1 : vector<2xi8>
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 6 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def test_shift_and_cmp_changed2_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.and %arg0, %0 : vector<2xi8>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
theorem test_shift_and_cmp_changed2_vec_proof : test_shift_and_cmp_changed2_vec_before ⊑ test_shift_and_cmp_changed2_vec_after := by
  sorry


