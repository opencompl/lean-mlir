
def test_with_even_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = llvm.shl %0, %arg0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test_with_even_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test_with_even_proof : test_with_even_before ⊑ test_with_even_after := by
  sorry



def test_with_neg_even_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = llvm.shl %0, %arg0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test_with_neg_even_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test_with_neg_even_proof : test_with_neg_even_before ⊑ test_with_neg_even_after := by
  sorry



def test1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry



def test3_before := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %1 = llvm.and %arg0, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry



def test4_before := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = llvm.and %arg0, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i1):
  "llvm.return"(%arg0) : (i1) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  sorry



def test5_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.and %arg0, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  sorry



def test6_before := [llvm|
{
^0(%arg0 : i1):
  %0 = llvm.and %arg0, %arg0 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg0 : i1):
  "llvm.return"(%arg0) : (i1) -> ()
}
]
theorem test6_proof : test6_before ⊑ test6_after := by
  sorry



def test7_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %arg0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  sorry



def test8_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  sorry



def test9_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  sorry



def test9a_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test9a_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test9a_proof : test9a_before ⊑ test9a_after := by
  sorry



def test10_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test10_proof : test10_before ⊑ test10_after := by
  sorry



def test12_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 7 : i64}> : (i32, i32) -> i1
  %2 = llvm.and %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test12_proof : test12_before ⊑ test12_after := by
  sorry



def test13_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  %2 = llvm.and %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test13_proof : test13_before ⊑ test13_after := by
  sorry



def test14_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test14_proof : test14_before ⊑ test14_after := by
  sorry



def test16_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem test16_proof : test16_before ⊑ test16_after := by
  sorry



def test18_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test18_proof : test18_before ⊑ test18_after := by
  sorry



def test18_vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = llvm.and %arg0, %0 : vector<2xi32>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def test18_vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<127> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem test18_vec_proof : test18_vec_before ⊑ test18_vec_after := by
  sorry



def test18a_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test18a_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test18a_proof : test18a_before ⊑ test18a_after := by
  sorry



def test18a_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.and %arg0, %0 : vector<2xi8>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def test18a_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem test18a_vec_proof : test18a_vec_before ⊑ test18a_vec_after := by
  sorry



def test19_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test19_proof : test19_before ⊑ test19_after := by
  sorry



def test23_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 3 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def test23_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test23_proof : test23_before ⊑ test23_after := by
  sorry



def test23vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 3 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %4 = llvm.and %2, %3 : vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def test23vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem test23vec_proof : test23vec_before ⊑ test23vec_after := by
  sorry



def test24_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def test24_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test24_proof : test24_before ⊑ test24_after := by
  sorry



def test25_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 50 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 100 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def test25_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -50 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 50 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem test25_proof : test25_before ⊑ test25_after := by
  sorry



def test25vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<50> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<100> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 5 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %4 = llvm.and %2, %3 : vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def test25vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-50> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<50> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem test25vec_proof : test25vec_before ⊑ test25vec_after := by
  sorry



def test27_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 16 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = -16 : i8}> : () -> i8
  %3 = llvm.and %arg0, %0 : i8
  %4 = llvm.sub %3, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.add %5, %1 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def test27_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem test27_proof : test27_before ⊑ test27_after := by
  sorry



def and_demanded_bits_splat_vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<7> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = llvm.and %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def and_demanded_bits_splat_vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<7> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.and %arg0, %0 : vector<2xi32>
  "llvm.return"(%1) : (vector<2xi32>) -> ()
}
]
theorem and_demanded_bits_splat_vec_proof : and_demanded_bits_splat_vec_before ⊑ and_demanded_bits_splat_vec_after := by
  sorry



def test33_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %arg0, %1 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test33_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test33_proof : test33_before ⊑ test33_after := by
  sorry



def test33b_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %arg0, %1 : i32
  %5 = llvm.or %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test33b_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test33b_proof : test33b_before ⊑ test33b_after := by
  sorry



def test33vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.and %arg0, %0 : vector<2xi32>
  %3 = llvm.xor %2, %0 : vector<2xi32>
  %4 = llvm.and %arg0, %1 : vector<2xi32>
  %5 = llvm.or %4, %3 : vector<2xi32>
  "llvm.return"(%5) : (vector<2xi32>) -> ()
}
]
def test33vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.xor %arg0, %0 : vector<2xi32>
  "llvm.return"(%1) : (vector<2xi32>) -> ()
}
]
theorem test33vec_proof : test33vec_before ⊑ test33vec_after := by
  sorry



def test33vecb_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.and %arg0, %0 : vector<2xi32>
  %3 = llvm.xor %2, %0 : vector<2xi32>
  %4 = llvm.and %arg0, %1 : vector<2xi32>
  %5 = llvm.or %3, %4 : vector<2xi32>
  "llvm.return"(%5) : (vector<2xi32>) -> ()
}
]
def test33vecb_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.xor %arg0, %0 : vector<2xi32>
  "llvm.return"(%1) : (vector<2xi32>) -> ()
}
]
theorem test33vecb_proof : test33vecb_before ⊑ test33vecb_after := by
  sorry



def test34_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg1, %arg0 : i32
  %1 = llvm.and %0, %arg1 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test34_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  "llvm.return"(%arg1) : (i32) -> ()
}
]
theorem test34_proof : test34_before ⊑ test34_after := by
  sorry



def test42_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg2 : i32
  %2 = llvm.or %arg0, %1 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test42_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.mul %arg1, %arg2 : i32
  %1 = llvm.and %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test42_proof : test42_before ⊑ test42_after := by
  sorry



def test43_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg2 : i32
  %2 = llvm.or %arg0, %1 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test43_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.mul %arg1, %arg2 : i32
  %1 = llvm.and %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test43_proof : test43_before ⊑ test43_after := by
  sorry



def test44_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.and %2, %arg1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test44_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test44_proof : test44_before ⊑ test44_after := by
  sorry



def test45_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %arg0, %1 : i32
  %3 = llvm.and %2, %arg1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test45_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test45_proof : test45_before ⊑ test45_after := by
  sorry



def test46_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.and %arg1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test46_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test46_proof : test46_before ⊑ test46_after := by
  sorry



def test47_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %arg0, %1 : i32
  %3 = llvm.and %arg1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test47_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test47_proof : test47_before ⊑ test47_after := by
  sorry



def and_orn_cmp_1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %3, %2 : i1
  %5 = llvm.and %1, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def and_orn_cmp_1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem and_orn_cmp_1_proof : and_orn_cmp_1_before ⊑ and_orn_cmp_1_after := by
  sorry



def and_orn_cmp_2_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[42, 47]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 5 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %4 = llvm.or %3, %2 : vector<2xi1>
  %5 = llvm.and %4, %1 : vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def and_orn_cmp_2_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[42, 47]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 5 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %2 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = llvm.and %2, %1 : vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem and_orn_cmp_2_proof : and_orn_cmp_2_before ⊑ and_orn_cmp_2_after := by
  sorry



def and_orn_cmp_3_before := [llvm|
{
^0(%arg0 : i72, %arg1 : i72, %arg2 : i72):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i72}> : () -> i72
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i72, i72) -> i1
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 7 : i64}> : (i72, i72) -> i1
  %3 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (i72, i72) -> i1
  %4 = llvm.or %2, %3 : i1
  %5 = llvm.and %1, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def and_orn_cmp_3_after := [llvm|
{
^0(%arg0 : i72, %arg1 : i72, %arg2 : i72):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i72}> : () -> i72
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i72, i72) -> i1
  %2 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (i72, i72) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem and_orn_cmp_3_proof : and_orn_cmp_3_before ⊑ and_orn_cmp_3_after := by
  sorry



def or_andn_cmp_4_before := [llvm|
{
^0(%arg0 : vector<3xi32>, %arg1 : vector<3xi32>, %arg2 : vector<3xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[42, 43, -1]> : vector<3xi32>}> : () -> vector<3xi32>
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
  %3 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
  %4 = llvm.or %2, %3 : vector<3xi1>
  %5 = llvm.and %4, %1 : vector<3xi1>
  "llvm.return"(%5) : (vector<3xi1>) -> ()
}
]
def or_andn_cmp_4_after := [llvm|
{
^0(%arg0 : vector<3xi32>, %arg1 : vector<3xi32>, %arg2 : vector<3xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[42, 43, -1]> : vector<3xi32>}> : () -> vector<3xi32>
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
  %2 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
  %3 = llvm.and %2, %1 : vector<3xi1>
  "llvm.return"(%3) : (vector<3xi1>) -> ()
}
]
theorem or_andn_cmp_4_proof : or_andn_cmp_4_before ⊑ or_andn_cmp_4_after := by
  sorry



def andn_or_cmp_1_before := [llvm|
{
^0(%arg0 : i37, %arg1 : i37, %arg2 : i37):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i37}> : () -> i37
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i37, i37) -> i1
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i37, i37) -> i1
  %3 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (i37, i37) -> i1
  %4 = llvm.or %3, %1 : i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def andn_or_cmp_1_after := [llvm|
{
^0(%arg0 : i37, %arg1 : i37, %arg2 : i37):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i37}> : () -> i37
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i37, i37) -> i1
  %2 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (i37, i37) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem andn_or_cmp_1_proof : andn_or_cmp_1_before ⊑ andn_or_cmp_1_after := by
  sorry



def andn_or_cmp_2_before := [llvm|
{
^0(%arg0 : i16, %arg1 : i16, %arg2 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i16}> : () -> i16
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 5 : i64}> : (i16, i16) -> i1
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (i16, i16) -> i1
  %3 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (i16, i16) -> i1
  %4 = llvm.or %3, %1 : i1
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def andn_or_cmp_2_after := [llvm|
{
^0(%arg0 : i16, %arg1 : i16, %arg2 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i16}> : () -> i16
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (i16, i16) -> i1
  %2 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (i16, i16) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem andn_or_cmp_2_proof : andn_or_cmp_2_before ⊑ andn_or_cmp_2_after := by
  sorry



def andn_or_cmp_3_before := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>, %arg2 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[42, 0, 1, -1]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 7 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  %3 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  %4 = llvm.or %1, %3 : vector<4xi1>
  %5 = llvm.and %2, %4 : vector<4xi1>
  "llvm.return"(%5) : (vector<4xi1>) -> ()
}
]
def andn_or_cmp_3_after := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>, %arg2 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[42, 0, 1, -1]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 7 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  %2 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
  %3 = llvm.and %1, %2 : vector<4xi1>
  "llvm.return"(%3) : (vector<4xi1>) -> ()
}
]
theorem andn_or_cmp_3_proof : andn_or_cmp_3_before ⊑ andn_or_cmp_3_after := by
  sorry



def andn_or_cmp_4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %1, %3 : i1
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def andn_or_cmp_4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg2, %0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem andn_or_cmp_4_proof : andn_or_cmp_4_before ⊑ andn_or_cmp_4_after := by
  sorry



def lowmask_add_2_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -64 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 63 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def lowmask_add_2_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 63 : i8}> : () -> i8
  %1 = llvm.and %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem lowmask_add_2_proof : lowmask_add_2_before ⊑ lowmask_add_2_after := by
  sorry



def flip_masked_bit_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 16 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = llvm.and %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def flip_masked_bit_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 16 : i8}> : () -> i8
  %1 = llvm.and %arg0, %0 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem flip_masked_bit_proof : flip_masked_bit_before ⊑ flip_masked_bit_after := by
  sorry



def flip_masked_bit_uniform_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<16> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.add %arg0, %0 : vector<2xi8>
  %2 = llvm.and %1, %0 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
def flip_masked_bit_uniform_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<16> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.and %arg0, %0 : vector<2xi8>
  %2 = llvm.xor %1, %0 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
theorem flip_masked_bit_uniform_proof : flip_masked_bit_uniform_before ⊑ flip_masked_bit_uniform_after := by
  sorry



def flip_masked_bit_nonuniform_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[16, 4]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.add %arg0, %0 : vector<2xi8>
  %2 = llvm.and %1, %0 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
def flip_masked_bit_nonuniform_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[16, 4]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.xor %arg0, %0 : vector<2xi8>
  %3 = llvm.and %2, %1 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
theorem flip_masked_bit_nonuniform_proof : flip_masked_bit_nonuniform_before ⊑ flip_masked_bit_nonuniform_after := by
  sorry



def add_constant_equal_with_the_top_bit_of_demandedbits_pass_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 16 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 24 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_constant_equal_with_the_top_bit_of_demandedbits_pass_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 24 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 16 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem add_constant_equal_with_the_top_bit_of_demandedbits_pass_proof : add_constant_equal_with_the_top_bit_of_demandedbits_pass_before ⊑ add_constant_equal_with_the_top_bit_of_demandedbits_pass_after := by
  sorry



def add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector_before := [llvm|
{
^0(%arg0 : vector<2xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<16> : vector<2xi16>}> : () -> vector<2xi16>
  %1 = "llvm.mlir.constant"() <{"value" = dense<24> : vector<2xi16>}> : () -> vector<2xi16>
  %2 = llvm.add %arg0, %0 : vector<2xi16>
  %3 = llvm.and %2, %1 : vector<2xi16>
  "llvm.return"(%3) : (vector<2xi16>) -> ()
}
]
def add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector_after := [llvm|
{
^0(%arg0 : vector<2xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<24> : vector<2xi16>}> : () -> vector<2xi16>
  %1 = "llvm.mlir.constant"() <{"value" = dense<16> : vector<2xi16>}> : () -> vector<2xi16>
  %2 = llvm.and %arg0, %0 : vector<2xi16>
  %3 = llvm.xor %2, %1 : vector<2xi16>
  "llvm.return"(%3) : (vector<2xi16>) -> ()
}
]
theorem add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector_proof : add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector_before ⊑ add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector_after := by
  sorry



def add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 16 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 24 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.or %2, %arg1 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 16 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 24 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %2, %arg1 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_proof : add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_before ⊑ add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_after := by
  sorry


