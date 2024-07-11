
def test3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.icmp"(%arg0, %arg0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry



def test4_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.icmp"(%arg0, %arg0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  sorry



def test5_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.icmp"(%arg0, %arg0) <{"predicate" = 3 : i64}> : (i32, i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  sorry



def test6_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.icmp"(%arg0, %arg0) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test6_proof : test6_before ⊑ test6_after := by
  sorry



def test7_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  sorry



def test8_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  sorry



def test9_before := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  sorry



def test10_before := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test10_proof : test10_before ⊑ test10_after := by
  sorry



def test11_before := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 7 : i64}> : (i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  sorry



def test12_before := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test12_proof : test12_before ⊑ test12_after := by
  sorry



def test13_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 9 : i64}> : (i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = llvm.xor %arg1, %0 : i1
  %2 = llvm.or %1, %arg0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test13_proof : test13_before ⊑ test13_after := by
  sorry



def test13vec_before := [llvm|
{
^0(%arg0 : vector<2xi1>, %arg1 : vector<2xi1>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 9 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
def test13vec_after := [llvm|
{
^0(%arg0 : vector<2xi1>, %arg1 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg1, %1 : vector<2xi1>
  %3 = llvm.or %2, %arg0 : vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem test13vec_proof : test13vec_before ⊑ test13vec_after := by
  sorry



def test14_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = llvm.xor %arg0, %arg1 : i1
  %2 = llvm.xor %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test14_proof : test14_before ⊑ test14_after := by
  sorry



def test14vec_before := [llvm|
{
^0(%arg0 : vector<3xi1>, %arg1 : vector<3xi1>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (vector<3xi1>, vector<3xi1>) -> vector<3xi1>
  "llvm.return"(%0) : (vector<3xi1>) -> ()
}
]
def test14vec_after := [llvm|
{
^0(%arg0 : vector<3xi1>, %arg1 : vector<3xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<3xi1>}> : () -> vector<3xi1>
  %2 = llvm.xor %arg0, %arg1 : vector<3xi1>
  %3 = llvm.xor %2, %1 : vector<3xi1>
  "llvm.return"(%3) : (vector<3xi1>) -> ()
}
]
theorem test14vec_proof : test14vec_before ⊑ test14vec_after := by
  sorry



def bool_eq0_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i64}> : () -> i64
  %2 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i64, i64) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i1, i1) -> i1
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def bool_eq0_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i64}> : () -> i64
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i64, i64) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem bool_eq0_proof : bool_eq0_before ⊑ bool_eq0_after := by
  sorry



def xor_of_icmps_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i64}> : () -> i64
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i64, i64) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_of_icmps_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i64}> : () -> i64
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i64, i64) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem xor_of_icmps_proof : xor_of_icmps_before ⊑ xor_of_icmps_after := by
  sorry



def xor_of_icmps_commute_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i64}> : () -> i64
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i64, i64) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_of_icmps_commute_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i64}> : () -> i64
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i64, i64) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem xor_of_icmps_commute_proof : xor_of_icmps_commute_before ⊑ xor_of_icmps_commute_after := by
  sorry



def xor_of_icmps_to_ne_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i64}> : () -> i64
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i64, i64) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (i64, i64) -> i1
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_of_icmps_to_ne_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i64}> : () -> i64
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem xor_of_icmps_to_ne_proof : xor_of_icmps_to_ne_before ⊑ xor_of_icmps_to_ne_after := by
  sorry



def xor_of_icmps_to_ne_commute_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i64}> : () -> i64
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i64, i64) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (i64, i64) -> i1
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_of_icmps_to_ne_commute_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i64}> : () -> i64
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem xor_of_icmps_to_ne_commute_proof : xor_of_icmps_to_ne_commute_before ⊑ xor_of_icmps_to_ne_commute_after := by
  sorry



def xor_of_icmps_neg_to_ne_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -6 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = -4 : i64}> : () -> i64
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i64, i64) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (i64, i64) -> i1
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_of_icmps_neg_to_ne_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -5 : i64}> : () -> i64
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem xor_of_icmps_neg_to_ne_proof : xor_of_icmps_neg_to_ne_before ⊑ xor_of_icmps_neg_to_ne_after := by
  sorry



def xor_of_icmps_to_ne_vector_before := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<2xi64>}> : () -> vector<2xi64>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  %4 = llvm.xor %2, %3 : vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def xor_of_icmps_to_ne_vector_after := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<5> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem xor_of_icmps_to_ne_vector_proof : xor_of_icmps_to_ne_vector_before ⊑ xor_of_icmps_to_ne_vector_after := by
  sorry



def xor_of_icmps_to_eq_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 126 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_of_icmps_to_eq_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem xor_of_icmps_to_eq_proof : xor_of_icmps_to_eq_before ⊑ xor_of_icmps_to_eq_after := by
  sorry



def test16_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test16_proof : test16_before ⊑ test16_after := by
  sorry



def test17_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test17_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test17_proof : test17_before ⊑ test17_after := by
  sorry



def test22_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 100663295 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 268435456 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %3 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %arg1, %2 : i32
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def test22_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test22_proof : test22_before ⊑ test22_after := by
  sorry



def test25_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test25_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test25_proof : test25_before ⊑ test25_after := by
  sorry


