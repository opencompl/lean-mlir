
def test0_before := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %1 = llvm.xor %arg0, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test0_after := [llvm|
{
^0(%arg0 : i1):
  "llvm.return"(%arg0) : (i1) -> ()
}
]
theorem test0_proof : test0_before ⊑ test0_after := by
  sorry



def test1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : i1):
  %0 = llvm.xor %arg0, %arg0 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry



def test3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.xor %arg0, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry



def test4_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %0, %arg0 : i32
  %2 = llvm.xor %arg0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  sorry



def test5_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i32}> : () -> i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -124 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  sorry



def test6_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 17 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg0 : i8):
  "llvm.return"(%arg0) : (i8) -> ()
}
]
theorem test6_proof : test6_before ⊑ test6_after := by
  sorry



def test7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  sorry



def test9_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 34 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 89 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  sorry



def test9vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<123> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<34> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.xor %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def test9vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<89> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem test9vec_proof : test9vec_before ⊑ test9vec_after := by
  sorry



def test10_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem test10_proof : test10_before ⊑ test10_after := by
  sorry



def test11_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -13 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  sorry



def test12_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test12_proof : test12_before ⊑ test12_after := by
  sorry



def test12vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.xor %arg0, %0 : vector<2xi8>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def test12vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem test12vec_proof : test12vec_before ⊑ test12vec_after := by
  sorry



def test18_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 123 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 124 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test18_proof : test18_before ⊑ test18_after := by
  sorry



def test19_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = llvm.xor %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  "llvm.return"(%arg1) : (i32) -> ()
}
]
theorem test19_proof : test19_before ⊑ test19_after := by
  sorry



def test23_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg1, %arg0 : i32
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test23_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test23_proof : test23_before ⊑ test23_after := by
  sorry



def test24_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg1, %arg0 : i32
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test24_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg1, %0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test24_proof : test24_before ⊑ test24_after := by
  sorry



def test25_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %arg0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test25_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test25_proof : test25_before ⊑ test25_after := by
  sorry



def test28_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test28_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test28_proof : test28_before ⊑ test28_after := by
  sorry



def test28vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483647> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = llvm.xor %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def test28vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.add %arg0, %0 : vector<2xi32>
  "llvm.return"(%1) : (vector<2xi32>) -> ()
}
]
theorem test28vec_proof : test28vec_before ⊑ test28vec_after := by
  sorry



def test28_sub_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test28_sub_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test28_sub_proof : test28_sub_before ⊑ test28_sub_after := by
  sorry



def test28_subvec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483647> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.sub %0, %arg0 : vector<2xi32>
  %3 = llvm.xor %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def test28_subvec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.sub %0, %arg0 : vector<2xi32>
  "llvm.return"(%1) : (vector<2xi32>) -> ()
}
]
theorem test28_subvec_proof : test28_subvec_before ⊑ test28_subvec_after := by
  sorry



def or_or_xor_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.or %arg2, %arg0 : i4
  %1 = llvm.or %arg2, %arg1 : i4
  %2 = llvm.xor %0, %1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def or_or_xor_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg2, %0 : i4
  %2 = llvm.xor %arg0, %arg1 : i4
  %3 = llvm.and %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem or_or_xor_proof : or_or_xor_before ⊑ or_or_xor_after := by
  sorry



def or_or_xor_commute1_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.or %arg0, %arg2 : i4
  %1 = llvm.or %arg2, %arg1 : i4
  %2 = llvm.xor %0, %1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def or_or_xor_commute1_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg2, %0 : i4
  %2 = llvm.xor %arg0, %arg1 : i4
  %3 = llvm.and %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem or_or_xor_commute1_proof : or_or_xor_commute1_before ⊑ or_or_xor_commute1_after := by
  sorry



def or_or_xor_commute2_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.or %arg2, %arg0 : i4
  %1 = llvm.or %arg1, %arg2 : i4
  %2 = llvm.xor %0, %1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def or_or_xor_commute2_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg2, %0 : i4
  %2 = llvm.xor %arg0, %arg1 : i4
  %3 = llvm.and %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem or_or_xor_commute2_proof : or_or_xor_commute2_before ⊑ or_or_xor_commute2_after := by
  sorry



def or_or_xor_commute3_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = llvm.or %arg0, %arg2 : vector<2xi4>
  %1 = llvm.or %arg1, %arg2 : vector<2xi4>
  %2 = llvm.xor %0, %1 : vector<2xi4>
  "llvm.return"(%2) : (vector<2xi4>) -> ()
}
]
def or_or_xor_commute3_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg2, %1 : vector<2xi4>
  %3 = llvm.xor %arg0, %arg1 : vector<2xi4>
  %4 = llvm.and %3, %2 : vector<2xi4>
  "llvm.return"(%4) : (vector<2xi4>) -> ()
}
]
theorem or_or_xor_commute3_proof : or_or_xor_commute3_before ⊑ or_or_xor_commute3_after := by
  sorry



def not_is_canonical_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1073741823 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.add %2, %arg1 : i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def not_is_canonical_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.add %2, %arg1 : i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_is_canonical_proof : not_is_canonical_before ⊑ not_is_canonical_after := by
  sorry



def not_shl_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def not_shl_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem not_shl_proof : not_shl_before ⊑ not_shl_after := by
  sorry



def not_shl_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<5> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-32> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.shl %arg0, %0 : vector<2xi8>
  %3 = llvm.xor %2, %1 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
def not_shl_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<5> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.xor %arg0, %0 : vector<2xi8>
  %3 = llvm.shl %2, %1 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
theorem not_shl_vec_proof : not_shl_vec_before ⊑ not_shl_vec_after := by
  sorry



def xor_andn_commute1_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.xor %arg0, %0 : vector<2xi32>
  %2 = llvm.and %1, %arg1 : vector<2xi32>
  %3 = llvm.xor %2, %arg0 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def xor_andn_commute1_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = llvm.or %arg0, %arg1 : vector<2xi32>
  "llvm.return"(%0) : (vector<2xi32>) -> ()
}
]
theorem xor_andn_commute1_proof : xor_andn_commute1_before ⊑ xor_andn_commute1_after := by
  sorry



def xor_orn_before := [llvm|
{
^0(%arg0 : vector<2xi64>, %arg1 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = llvm.xor %arg0, %0 : vector<2xi64>
  %2 = llvm.or %1, %arg1 : vector<2xi64>
  %3 = llvm.xor %2, %arg0 : vector<2xi64>
  "llvm.return"(%3) : (vector<2xi64>) -> ()
}
]
def xor_orn_after := [llvm|
{
^0(%arg0 : vector<2xi64>, %arg1 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = llvm.and %arg0, %arg1 : vector<2xi64>
  %2 = llvm.xor %1, %0 : vector<2xi64>
  "llvm.return"(%2) : (vector<2xi64>) -> ()
}
]
theorem xor_orn_proof : xor_orn_before ⊑ xor_orn_after := by
  sorry



def PR96857_xor_with_noundef_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.and %arg2, %arg0 : i4
  %2 = llvm.xor %arg2, %0 : i4
  %3 = llvm.and %2, %arg1 : i4
  %4 = llvm.xor %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def PR96857_xor_with_noundef_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.and %arg2, %arg0 : i4
  %2 = llvm.xor %arg2, %0 : i4
  %3 = llvm.and %2, %arg1 : i4
  %4 = llvm.or %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
theorem PR96857_xor_with_noundef_proof : PR96857_xor_with_noundef_before ⊑ PR96857_xor_with_noundef_after := by
  sorry



def PR96857_xor_without_noundef_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.and %arg2, %arg0 : i4
  %2 = llvm.xor %arg2, %0 : i4
  %3 = llvm.and %2, %arg1 : i4
  %4 = llvm.xor %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def PR96857_xor_without_noundef_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.and %arg2, %arg0 : i4
  %2 = llvm.xor %arg2, %0 : i4
  %3 = llvm.and %2, %arg1 : i4
  %4 = llvm.or %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
theorem PR96857_xor_without_noundef_proof : PR96857_xor_without_noundef_before ⊑ PR96857_xor_without_noundef_after := by
  sorry


