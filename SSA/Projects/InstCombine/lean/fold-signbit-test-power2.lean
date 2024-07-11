
def pow2_or_zero_is_negative_commute_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.mul %0, %arg0 : i8
  %3 = llvm.sub %1, %2 : i8
  %4 = llvm.and %3, %2 : i8
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def pow2_or_zero_is_negative_commute_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem pow2_or_zero_is_negative_commute_proof : pow2_or_zero_is_negative_commute_before ⊑ pow2_or_zero_is_negative_commute_after := by
  sorry



def pow2_or_zero_is_negative_vec_commute_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.mul %0, %arg0 : vector<2xi8>
  %4 = llvm.sub %2, %3 : vector<2xi8>
  %5 = llvm.and %4, %3 : vector<2xi8>
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%6) : (vector<2xi1>) -> ()
}
]
def pow2_or_zero_is_negative_vec_commute_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.mul %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem pow2_or_zero_is_negative_vec_commute_proof : pow2_or_zero_is_negative_vec_commute_before ⊑ pow2_or_zero_is_negative_vec_commute_after := by
  sorry



def pow2_or_zero_is_not_negative_commute_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %3 = llvm.mul %0, %arg0 : i8
  %4 = llvm.sub %1, %3 : i8
  %5 = llvm.and %4, %3 : i8
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def pow2_or_zero_is_not_negative_commute_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem pow2_or_zero_is_not_negative_commute_proof : pow2_or_zero_is_not_negative_commute_before ⊑ pow2_or_zero_is_not_negative_commute_after := by
  sorry



def pow2_or_zero_is_not_negative_vec_commute_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %4 = llvm.mul %0, %arg0 : vector<2xi8>
  %5 = llvm.sub %2, %4 : vector<2xi8>
  %6 = llvm.and %5, %4 : vector<2xi8>
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%7) : (vector<2xi1>) -> ()
}
]
def pow2_or_zero_is_not_negative_vec_commute_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.mul %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem pow2_or_zero_is_not_negative_vec_commute_proof : pow2_or_zero_is_not_negative_vec_commute_before ⊑ pow2_or_zero_is_not_negative_vec_commute_after := by
  sorry


