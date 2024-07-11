
def test0_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test0_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test0_proof : test0_before ⊑ test0_after := by
  sorry



def test0vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.xor %arg0, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def test0vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem test0vec_proof : test0vec_before ⊑ test0vec_after := by
  sorry



def test1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12345 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 145 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 153 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry



def test3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 145 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 177 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 153 : i32}> : () -> i32
  %3 = llvm.or %arg0, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 32 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry



def test7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  sorry



def test8_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.or %arg0, %arg1 : i32
  %3 = llvm.xor %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  sorry



def test9_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  sorry



def test9b_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test9b_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test9b_proof : test9b_before ⊑ test9b_after := by
  sorry



def test10_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test10_proof : test10_before ⊑ test10_after := by
  sorry



def test10b_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test10b_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test10b_proof : test10b_before ⊑ test10b_after := by
  sorry



def test11_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  sorry



def test11b_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11b_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test11b_proof : test11b_before ⊑ test11b_after := by
  sorry



def test11c_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11c_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test11c_proof : test11c_before ⊑ test11c_after := by
  sorry



def test11d_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11d_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test11d_proof : test11d_before ⊑ test11d_after := by
  sorry



def test11e_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg2 : i32
  %2 = llvm.xor %1, %arg0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.xor %1, %3 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test11e_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg2 : i32
  %2 = llvm.xor %1, %arg0 : i32
  %3 = llvm.xor %1, %arg0 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem test11e_proof : test11e_before ⊑ test11e_after := by
  sorry



def test11f_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg2 : i32
  %2 = llvm.xor %1, %arg0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.xor %1, %3 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test11f_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg2 : i32
  %2 = llvm.xor %1, %arg0 : i32
  %3 = llvm.xor %1, %arg0 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem test11f_proof : test11f_before ⊑ test11f_after := by
  sorry



def test12_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.and %arg0, %1 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test12_proof : test12_before ⊑ test12_after := by
  sorry



def test12commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test12commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test12commuted_proof : test12commuted_before ⊑ test12commuted_after := by
  sorry



def test13_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.and %arg0, %2 : i32
  %4 = llvm.xor %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test13_proof : test13_before ⊑ test13_after := by
  sorry



def test13commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.xor %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test13commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test13commuted_proof : test13commuted_before ⊑ test13commuted_after := by
  sorry



def xor_or_xor_common_op_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg0, %arg2 : i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute1_proof : xor_or_xor_common_op_commute1_before ⊑ xor_or_xor_common_op_commute1_after := by
  sorry



def xor_or_xor_common_op_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg2, %arg0 : i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute2_proof : xor_or_xor_common_op_commute2_before ⊑ xor_or_xor_common_op_commute2_after := by
  sorry



def xor_or_xor_common_op_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg0, %arg2 : i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute3_proof : xor_or_xor_common_op_commute3_before ⊑ xor_or_xor_common_op_commute3_after := by
  sorry



def xor_or_xor_common_op_commute4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg2, %arg0 : i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute4_proof : xor_or_xor_common_op_commute4_before ⊑ xor_or_xor_common_op_commute4_after := by
  sorry



def xor_or_xor_common_op_commute5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg0, %arg2 : i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute5_proof : xor_or_xor_common_op_commute5_before ⊑ xor_or_xor_common_op_commute5_after := by
  sorry



def xor_or_xor_common_op_commute6_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg2, %arg0 : i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute6_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute6_proof : xor_or_xor_common_op_commute6_before ⊑ xor_or_xor_common_op_commute6_after := by
  sorry



def xor_or_xor_common_op_commute7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg0, %arg2 : i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute7_proof : xor_or_xor_common_op_commute7_before ⊑ xor_or_xor_common_op_commute7_after := by
  sorry



def xor_or_xor_common_op_commute8_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg2, %arg0 : i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute8_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %arg2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_or_xor_common_op_commute8_proof : xor_or_xor_common_op_commute8_before ⊑ xor_or_xor_common_op_commute8_after := by
  sorry



def test15_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.xor %2, %arg1 : i8
  %4 = llvm.and %1, %3 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.and %1, %3 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem test15_proof : test15_before ⊑ test15_after := by
  sorry



def test16_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.xor %2, %arg1 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem test16_proof : test16_before ⊑ test16_after := by
  sorry



def not_xor_to_or_not1_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %2, %1 : i3
  %4 = llvm.xor %3, %0 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def not_xor_to_or_not1_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem not_xor_to_or_not1_proof : not_xor_to_or_not1_before ⊑ not_xor_to_or_not1_after := by
  sorry



def not_xor_to_or_not2_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %2, %1 : i3
  %4 = llvm.xor %3, %0 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def not_xor_to_or_not2_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem not_xor_to_or_not2_proof : not_xor_to_or_not2_before ⊑ not_xor_to_or_not2_after := by
  sorry



def not_xor_to_or_not3_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %2, %1 : i3
  %4 = llvm.xor %3, %0 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def not_xor_to_or_not3_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem not_xor_to_or_not3_proof : not_xor_to_or_not3_before ⊑ not_xor_to_or_not3_after := by
  sorry



def not_xor_to_or_not4_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %2, %1 : i3
  %4 = llvm.xor %3, %0 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def not_xor_to_or_not4_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem not_xor_to_or_not4_proof : not_xor_to_or_not4_before ⊑ not_xor_to_or_not4_after := by
  sorry



def not_xor_to_or_not_vector_before := [llvm|
{
^0(%arg0 : vector<3xi5>, %arg1 : vector<3xi5>, %arg2 : vector<3xi5>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i5}> : () -> i5
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<3xi5>}> : () -> vector<3xi5>
  %2 = llvm.or %arg1, %arg2 : vector<3xi5>
  %3 = llvm.and %arg0, %arg2 : vector<3xi5>
  %4 = llvm.xor %2, %3 : vector<3xi5>
  %5 = llvm.xor %4, %1 : vector<3xi5>
  "llvm.return"(%5) : (vector<3xi5>) -> ()
}
]
def not_xor_to_or_not_vector_after := [llvm|
{
^0(%arg0 : vector<3xi5>, %arg1 : vector<3xi5>, %arg2 : vector<3xi5>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i5}> : () -> i5
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<3xi5>}> : () -> vector<3xi5>
  %2 = llvm.or %arg1, %arg2 : vector<3xi5>
  %3 = llvm.and %arg0, %arg2 : vector<3xi5>
  %4 = llvm.xor %2, %1 : vector<3xi5>
  %5 = llvm.or %3, %4 : vector<3xi5>
  "llvm.return"(%5) : (vector<3xi5>) -> ()
}
]
theorem not_xor_to_or_not_vector_proof : not_xor_to_or_not_vector_before ⊑ not_xor_to_or_not_vector_after := by
  sorry



def xor_notand_to_or_not1_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %2, %0 : i3
  %4 = llvm.xor %3, %1 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def xor_notand_to_or_not1_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem xor_notand_to_or_not1_proof : xor_notand_to_or_not1_before ⊑ xor_notand_to_or_not1_after := by
  sorry



def xor_notand_to_or_not2_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %2, %0 : i3
  %4 = llvm.xor %3, %1 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def xor_notand_to_or_not2_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg0, %arg2 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem xor_notand_to_or_not2_proof : xor_notand_to_or_not2_before ⊑ xor_notand_to_or_not2_after := by
  sorry



def xor_notand_to_or_not3_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %2, %0 : i3
  %4 = llvm.xor %3, %1 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def xor_notand_to_or_not3_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg2, %arg1 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem xor_notand_to_or_not3_proof : xor_notand_to_or_not3_before ⊑ xor_notand_to_or_not3_after := by
  sorry



def xor_notand_to_or_not4_before := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %2, %0 : i3
  %4 = llvm.xor %3, %1 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def xor_notand_to_or_not4_after := [llvm|
{
^0(%arg0 : i3, %arg1 : i3, %arg2 : i3):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = llvm.or %arg1, %arg2 : i3
  %2 = llvm.and %arg2, %arg0 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
theorem xor_notand_to_or_not4_proof : xor_notand_to_or_not4_before ⊑ xor_notand_to_or_not4_after := by
  sorry



def xor_notand_to_or_not_vector_before := [llvm|
{
^0(%arg0 : vector<3xi5>, %arg1 : vector<3xi5>, %arg2 : vector<3xi5>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i5}> : () -> i5
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<3xi5>}> : () -> vector<3xi5>
  %2 = llvm.or %arg1, %arg2 : vector<3xi5>
  %3 = llvm.and %arg0, %arg2 : vector<3xi5>
  %4 = llvm.xor %3, %1 : vector<3xi5>
  %5 = llvm.xor %4, %2 : vector<3xi5>
  "llvm.return"(%5) : (vector<3xi5>) -> ()
}
]
def xor_notand_to_or_not_vector_after := [llvm|
{
^0(%arg0 : vector<3xi5>, %arg1 : vector<3xi5>, %arg2 : vector<3xi5>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i5}> : () -> i5
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<3xi5>}> : () -> vector<3xi5>
  %2 = llvm.or %arg1, %arg2 : vector<3xi5>
  %3 = llvm.and %arg0, %arg2 : vector<3xi5>
  %4 = llvm.xor %2, %1 : vector<3xi5>
  %5 = llvm.or %3, %4 : vector<3xi5>
  "llvm.return"(%5) : (vector<3xi5>) -> ()
}
]
theorem xor_notand_to_or_not_vector_proof : xor_notand_to_or_not_vector_before ⊑ xor_notand_to_or_not_vector_after := by
  sorry


