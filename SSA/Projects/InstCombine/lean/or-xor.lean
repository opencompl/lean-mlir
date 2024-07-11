
def test1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg0, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.or %1, %arg1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry



def test3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg0, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry



def test4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.or %1, %arg1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  sorry



def test5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  sorry



def test5_commuted_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg0, %arg1 : vector<2xi4>
  %3 = llvm.xor %arg0, %1 : vector<2xi4>
  %4 = llvm.or %3, %2 : vector<2xi4>
  "llvm.return"(%4) : (vector<2xi4>) -> ()
}
]
def test5_commuted_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.and %arg0, %arg1 : vector<2xi4>
  %3 = llvm.xor %2, %1 : vector<2xi4>
  "llvm.return"(%3) : (vector<2xi4>) -> ()
}
]
theorem test5_commuted_proof : test5_commuted_before ⊑ test5_commuted_after := by
  sorry



def test5_commuted_x_y_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i64}> : () -> i64
  %1 = llvm.xor %arg1, %arg0 : i64
  %2 = llvm.xor %arg0, %0 : i64
  %3 = llvm.or %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test5_commuted_x_y_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i64}> : () -> i64
  %1 = llvm.and %arg1, %arg0 : i64
  %2 = llvm.xor %1, %0 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
theorem test5_commuted_x_y_proof : test5_commuted_x_y_before ⊑ test5_commuted_x_y_after := by
  sorry



def xor_common_op_commute0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.xor %arg0, %arg1 : i8
  %1 = llvm.or %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def xor_common_op_commute0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem xor_common_op_commute0_proof : xor_common_op_commute0_before ⊑ xor_common_op_commute0_after := by
  sorry



def xor_common_op_commute2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.xor %1, %arg1 : i8
  %3 = llvm.or %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def xor_common_op_commute2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.or %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem xor_common_op_commute2_proof : xor_common_op_commute2_before ⊑ xor_common_op_commute2_after := by
  sorry



def xor_common_op_commute3_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.mul %arg1, %arg1 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_common_op_commute3_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.mul %arg1, %arg1 : i8
  %3 = llvm.or %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem xor_common_op_commute3_proof : xor_common_op_commute3_before ⊑ xor_common_op_commute3_after := by
  sorry



def test8_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %1 : i32
  %3 = llvm.or %arg1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.or %1, %arg1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  sorry



def test9_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = llvm.or %arg0, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.or %1, %arg0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  sorry



def test10_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test10_proof : test10_before ⊑ test10_after := by
  sorry



def test10_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test10_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test10_commuted_proof : test10_commuted_before ⊑ test10_commuted_after := by
  sorry



def test11_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  sorry



def test12_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = llvm.or %arg0, %arg1 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test12_proof : test12_before ⊑ test12_after := by
  sorry



def test12_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = llvm.or %arg1, %arg0 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test12_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test12_commuted_proof : test12_commuted_before ⊑ test12_commuted_after := by
  sorry



def test13_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg1, %arg0 : i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test13_proof : test13_before ⊑ test13_after := by
  sorry



def test14_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %arg0, %1 : i32
  %4 = llvm.or %2, %arg1 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test14_proof : test14_before ⊑ test14_after := by
  sorry



def test14_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %1, %arg0 : i32
  %4 = llvm.or %2, %arg1 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test14_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test14_commuted_proof : test14_commuted_before ⊑ test14_commuted_after := by
  sorry



def test15_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %arg0, %1 : i32
  %4 = llvm.and %2, %arg1 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test15_proof : test15_before ⊑ test15_after := by
  sorry



def test15_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %arg0 : i32
  %4 = llvm.and %2, %arg1 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test15_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test15_commuted_proof : test15_commuted_before ⊑ test15_commuted_after := by
  sorry



def or_and_xor_not_constant_commute0_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.and %arg1, %1 : i32
  %5 = llvm.or %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def or_and_xor_not_constant_commute0_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem or_and_xor_not_constant_commute0_proof : or_and_xor_not_constant_commute0_before ⊑ or_and_xor_not_constant_commute0_after := by
  sorry



def or_and_xor_not_constant_commute1_before := [llvm|
{
^0(%arg0 : i9, %arg1 : i9):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i9}> : () -> i9
  %1 = "llvm.mlir.constant"() <{"value" = -43 : i9}> : () -> i9
  %2 = llvm.xor %arg1, %arg0 : i9
  %3 = llvm.and %2, %0 : i9
  %4 = llvm.and %arg1, %1 : i9
  %5 = llvm.or %3, %4 : i9
  "llvm.return"(%5) : (i9) -> ()
}
]
def or_and_xor_not_constant_commute1_after := [llvm|
{
^0(%arg0 : i9, %arg1 : i9):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i9}> : () -> i9
  %1 = llvm.and %arg0, %0 : i9
  %2 = llvm.xor %1, %arg1 : i9
  "llvm.return"(%2) : (i9) -> ()
}
]
theorem or_and_xor_not_constant_commute1_proof : or_and_xor_not_constant_commute1_before ⊑ or_and_xor_not_constant_commute1_after := by
  sorry



def or_and_xor_not_constant_commute2_splat_before := [llvm|
{
^0(%arg0 : vector<2xi9>, %arg1 : vector<2xi9>):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i9}> : () -> i9
  %1 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi9>}> : () -> vector<2xi9>
  %2 = "llvm.mlir.constant"() <{"value" = -43 : i9}> : () -> i9
  %3 = "llvm.mlir.constant"() <{"value" = dense<-43> : vector<2xi9>}> : () -> vector<2xi9>
  %4 = llvm.xor %arg1, %arg0 : vector<2xi9>
  %5 = llvm.and %4, %1 : vector<2xi9>
  %6 = llvm.and %arg1, %3 : vector<2xi9>
  %7 = llvm.or %6, %5 : vector<2xi9>
  "llvm.return"(%7) : (vector<2xi9>) -> ()
}
]
def or_and_xor_not_constant_commute2_splat_after := [llvm|
{
^0(%arg0 : vector<2xi9>, %arg1 : vector<2xi9>):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i9}> : () -> i9
  %1 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi9>}> : () -> vector<2xi9>
  %2 = llvm.and %arg0, %1 : vector<2xi9>
  %3 = llvm.xor %2, %arg1 : vector<2xi9>
  "llvm.return"(%3) : (vector<2xi9>) -> ()
}
]
theorem or_and_xor_not_constant_commute2_splat_proof : or_and_xor_not_constant_commute2_splat_before ⊑ or_and_xor_not_constant_commute2_splat_after := by
  sorry



def or_and_xor_not_constant_commute3_splat_before := [llvm|
{
^0(%arg0 : vector<2xi9>, %arg1 : vector<2xi9>):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i9}> : () -> i9
  %1 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi9>}> : () -> vector<2xi9>
  %2 = "llvm.mlir.constant"() <{"value" = -43 : i9}> : () -> i9
  %3 = "llvm.mlir.constant"() <{"value" = dense<-43> : vector<2xi9>}> : () -> vector<2xi9>
  %4 = llvm.xor %arg0, %arg1 : vector<2xi9>
  %5 = llvm.and %4, %1 : vector<2xi9>
  %6 = llvm.and %arg1, %3 : vector<2xi9>
  %7 = llvm.or %6, %5 : vector<2xi9>
  "llvm.return"(%7) : (vector<2xi9>) -> ()
}
]
def or_and_xor_not_constant_commute3_splat_after := [llvm|
{
^0(%arg0 : vector<2xi9>, %arg1 : vector<2xi9>):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i9}> : () -> i9
  %1 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi9>}> : () -> vector<2xi9>
  %2 = llvm.and %arg0, %1 : vector<2xi9>
  %3 = llvm.xor %2, %arg1 : vector<2xi9>
  "llvm.return"(%3) : (vector<2xi9>) -> ()
}
]
theorem or_and_xor_not_constant_commute3_splat_proof : or_and_xor_not_constant_commute3_splat_before ⊑ or_and_xor_not_constant_commute3_splat_after := by
  sorry



def not_or_xor_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 12 : i8}> : () -> i8
  %3 = llvm.xor %arg0, %0 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.xor %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def not_or_xor_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -8 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -13 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem not_or_xor_proof : not_or_xor_before ⊑ not_or_xor_after := by
  sorry



def xor_or_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 32 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def xor_or_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -8 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 39 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem xor_or_proof : xor_or_before ⊑ xor_or_after := by
  sorry



def xor_or2_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 33 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def xor_or2_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -8 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 39 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem xor_or2_proof : xor_or2_before ⊑ xor_or2_after := by
  sorry



def xor_or_xor_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 33 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 12 : i8}> : () -> i8
  %3 = llvm.xor %arg0, %0 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.xor %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def xor_or_xor_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -8 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 43 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem xor_or_xor_proof : xor_or_xor_before ⊑ xor_or_xor_after := by
  sorry



def or_xor_or_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 33 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 12 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %3 = llvm.or %arg0, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def or_xor_or_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -40 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 47 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem or_xor_or_proof : or_xor_or_before ⊑ or_xor_or_after := by
  sorry



def test17_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.xor %2, %arg1 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def test17_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.or %1, %3 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem test17_proof : test17_before ⊑ test17_after := by
  sorry



def test18_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.xor %2, %arg1 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 33 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %arg0 : i8
  %2 = llvm.xor %arg0, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem test18_proof : test18_before ⊑ test18_after := by
  sorry



def test19_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %arg0, %arg1 : i32
  %4 = llvm.or %2, %1 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test19_proof : test19_before ⊑ test19_after := by
  sorry



def test20_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %arg0, %arg1 : i32
  %4 = llvm.or %1, %2 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test20_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test20_proof : test20_before ⊑ test20_after := by
  sorry



def test21_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = llvm.or %arg0, %arg1 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test21_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test21_proof : test21_before ⊑ test21_after := by
  sorry



def test22_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  %4 = llvm.or %arg1, %arg0 : i32
  %5 = llvm.xor %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test22_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test22_proof : test22_before ⊑ test22_after := by
  sorry



def test23_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 13 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %3 = "llvm.mlir.constant"() <{"value" = 12 : i8}> : () -> i8
  %4 = llvm.or %arg0, %0 : i8
  %5 = llvm.xor %4, %1 : i8
  %6 = llvm.or %5, %2 : i8
  %7 = llvm.xor %6, %3 : i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def test23_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem test23_proof : test23_before ⊑ test23_after := by
  sorry



def PR45977_f1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.or %arg0, %arg1 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def PR45977_f1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem PR45977_f1_proof : PR45977_f1_before ⊑ PR45977_f1_after := by
  sorry



def PR45977_f2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.or %arg0, %2 : i32
  %4 = llvm.xor %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def PR45977_f2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem PR45977_f2_proof : PR45977_f2_before ⊑ PR45977_f2_after := by
  sorry



def or_xor_common_op_commute0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  %1 = llvm.xor %arg0, %arg2 : i8
  %2 = llvm.or %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def or_xor_common_op_commute0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  %1 = llvm.or %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem or_xor_common_op_commute0_proof : or_xor_common_op_commute0_before ⊑ or_xor_common_op_commute0_after := by
  sorry



def or_xor_common_op_commute4_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>, %arg2 : vector<2xi8>):
  %0 = llvm.or %arg0, %arg1 : vector<2xi8>
  %1 = llvm.xor %arg0, %arg2 : vector<2xi8>
  %2 = llvm.or %1, %0 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
def or_xor_common_op_commute4_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>, %arg2 : vector<2xi8>):
  %0 = llvm.or %arg0, %arg1 : vector<2xi8>
  %1 = llvm.or %0, %arg2 : vector<2xi8>
  "llvm.return"(%1) : (vector<2xi8>) -> ()
}
]
theorem or_xor_common_op_commute4_proof : or_xor_common_op_commute4_before ⊑ or_xor_common_op_commute4_after := by
  sorry



def or_xor_common_op_commute5_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg1, %arg0 : i8
  %1 = llvm.xor %arg0, %arg2 : i8
  %2 = llvm.or %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def or_xor_common_op_commute5_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg1, %arg0 : i8
  %1 = llvm.or %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem or_xor_common_op_commute5_proof : or_xor_common_op_commute5_before ⊑ or_xor_common_op_commute5_after := by
  sorry



def or_xor_common_op_commute6_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  %1 = llvm.xor %arg2, %arg0 : i8
  %2 = llvm.or %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def or_xor_common_op_commute6_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  %1 = llvm.or %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem or_xor_common_op_commute6_proof : or_xor_common_op_commute6_before ⊑ or_xor_common_op_commute6_after := by
  sorry



def or_xor_common_op_commute7_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg1, %arg0 : i8
  %1 = llvm.xor %arg2, %arg0 : i8
  %2 = llvm.or %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def or_xor_common_op_commute7_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.or %arg1, %arg0 : i8
  %1 = llvm.or %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem or_xor_common_op_commute7_proof : or_xor_common_op_commute7_before ⊑ or_xor_common_op_commute7_after := by
  sorry



def or_not_xor_common_op_commute0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %0 : i4
  %2 = llvm.xor %arg0, %arg1 : i4
  %3 = llvm.or %1, %arg2 : i4
  %4 = llvm.or %3, %2 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def or_not_xor_common_op_commute0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.and %arg0, %arg1 : i4
  %2 = llvm.xor %1, %0 : i4
  %3 = llvm.or %2, %arg2 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem or_not_xor_common_op_commute0_proof : or_not_xor_common_op_commute0_before ⊑ or_not_xor_common_op_commute0_after := by
  sorry



def or_not_xor_common_op_commute2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.xor %arg0, %1 : i8
  %4 = llvm.xor %arg0, %arg1 : i8
  %5 = llvm.or %2, %3 : i8
  %6 = llvm.or %4, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def or_not_xor_common_op_commute2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.and %arg0, %arg1 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem or_not_xor_common_op_commute2_proof : or_not_xor_common_op_commute2_before ⊑ or_not_xor_common_op_commute2_after := by
  sorry



def or_not_xor_common_op_commute3_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.xor %arg0, %1 : i8
  %4 = llvm.xor %arg0, %arg1 : i8
  %5 = llvm.or %2, %3 : i8
  %6 = llvm.or %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def or_not_xor_common_op_commute3_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.and %arg0, %arg1 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem or_not_xor_common_op_commute3_proof : or_not_xor_common_op_commute3_before ⊑ or_not_xor_common_op_commute3_after := by
  sorry



def or_not_xor_common_op_commute4_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.xor %arg0, %1 : vector<2xi4>
  %3 = llvm.xor %arg1, %arg0 : vector<2xi4>
  %4 = llvm.or %2, %arg2 : vector<2xi4>
  %5 = llvm.or %4, %3 : vector<2xi4>
  "llvm.return"(%5) : (vector<2xi4>) -> ()
}
]
def or_not_xor_common_op_commute4_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.and %arg1, %arg0 : vector<2xi4>
  %3 = llvm.xor %2, %1 : vector<2xi4>
  %4 = llvm.or %3, %arg2 : vector<2xi4>
  "llvm.return"(%4) : (vector<2xi4>) -> ()
}
]
theorem or_not_xor_common_op_commute4_proof : or_not_xor_common_op_commute4_before ⊑ or_not_xor_common_op_commute4_after := by
  sorry



def or_not_xor_common_op_commute5_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.xor %arg1, %arg0 : i8
  %3 = llvm.or %1, %arg2 : i8
  %4 = llvm.or %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def or_not_xor_common_op_commute5_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.and %arg1, %arg0 : i8
  %2 = llvm.xor %1, %0 : i8
  %3 = llvm.or %2, %arg2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem or_not_xor_common_op_commute5_proof : or_not_xor_common_op_commute5_before ⊑ or_not_xor_common_op_commute5_after := by
  sorry



def or_not_xor_common_op_commute6_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.xor %arg0, %1 : i8
  %4 = llvm.xor %arg1, %arg0 : i8
  %5 = llvm.or %2, %3 : i8
  %6 = llvm.or %4, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def or_not_xor_common_op_commute6_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.and %arg1, %arg0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem or_not_xor_common_op_commute6_proof : or_not_xor_common_op_commute6_before ⊑ or_not_xor_common_op_commute6_after := by
  sorry



def or_not_xor_common_op_commute7_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.xor %arg0, %1 : i8
  %4 = llvm.xor %arg1, %arg0 : i8
  %5 = llvm.or %2, %3 : i8
  %6 = llvm.or %5, %4 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def or_not_xor_common_op_commute7_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg2 : i8
  %3 = llvm.and %arg1, %arg0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %4, %2 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem or_not_xor_common_op_commute7_proof : or_not_xor_common_op_commute7_before ⊑ or_not_xor_common_op_commute7_after := by
  sorry



def or_nand_xor_common_op_commute0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.and %arg0, %arg2 : i4
  %2 = llvm.xor %1, %0 : i4
  %3 = llvm.xor %arg0, %arg1 : i4
  %4 = llvm.or %2, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def or_nand_xor_common_op_commute0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.and %arg0, %arg2 : i4
  %2 = llvm.and %1, %arg1 : i4
  %3 = llvm.xor %2, %0 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem or_nand_xor_common_op_commute0_proof : or_nand_xor_common_op_commute0_before ⊑ or_nand_xor_common_op_commute0_after := by
  sorry



def PR75692_1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -5 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.xor %arg0, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def PR75692_1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem PR75692_1_proof : PR75692_1_before ⊑ PR75692_1_after := by
  sorry



def or_xor_not_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %1 : i32
  %3 = llvm.or %2, %arg1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def or_xor_not_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.or %1, %arg1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem or_xor_not_proof : or_xor_not_before ⊑ or_xor_not_after := by
  sorry



def or_xor_and_commuted1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %2, %arg0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_xor_and_commuted1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg1 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.or %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_xor_and_commuted1_proof : or_xor_and_commuted1_before ⊑ or_xor_and_commuted1_after := by
  sorry



def or_xor_and_commuted2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg1 : i32
  %2 = llvm.mul %arg0, %arg0 : i32
  %3 = llvm.xor %1, %0 : i32
  %4 = llvm.xor %2, %3 : i32
  %5 = llvm.or %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def or_xor_and_commuted2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg1, %arg1 : i32
  %2 = llvm.mul %arg0, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem or_xor_and_commuted2_proof : or_xor_and_commuted2_before ⊑ or_xor_and_commuted2_after := by
  sorry



def or_xor_tree_0000_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = llvm.mul %arg2, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.xor %2, %3 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %4, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_0000_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = llvm.mul %arg2, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem or_xor_tree_0000_proof : or_xor_tree_0000_before ⊑ or_xor_tree_0000_after := by
  sorry



def or_xor_tree_1000_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = llvm.mul %arg2, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.xor %2, %3 : i32
  %6 = llvm.xor %5, %1 : i32
  %7 = llvm.or %6, %4 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_xor_tree_1000_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = llvm.mul %arg2, %0 : i32
  %4 = llvm.xor %1, %2 : i32
  %5 = llvm.or %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem or_xor_tree_1000_proof : or_xor_tree_1000_before ⊑ or_xor_tree_1000_after := by
  sorry


