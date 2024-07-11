
def test2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 32 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg0, %1 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 39 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry



def test4_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.add %arg0, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  sorry



def test5_before := [llvm|
{
^0(%arg0 : vector<2xi1>, %arg1 : vector<2xi1>):
  %0 = llvm.add %arg0, %arg1 : vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : vector<2xi1>, %arg1 : vector<2xi1>):
  %0 = llvm.xor %arg0, %arg1 : vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  sorry



def test6_before := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[2, 3]> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = llvm.shl %arg0, %0 : vector<2xi64>
  %2 = llvm.add %1, %arg0 : vector<2xi64>
  "llvm.return"(%2) : (vector<2xi64>) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[5, 9]> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = llvm.mul %arg0, %0 : vector<2xi64>
  "llvm.return"(%1) : (vector<2xi64>) -> ()
}
]
theorem test6_proof : test6_before ⊑ test6_after := by
  sorry



def test7_before := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[2, 3]> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[3, 4]> : vector<2xi64>}> : () -> vector<2xi64>
  %2 = llvm.shl %arg0, %0 : vector<2xi64>
  %3 = llvm.mul %arg0, %1 : vector<2xi64>
  %4 = llvm.add %2, %3 : vector<2xi64>
  "llvm.return"(%4) : (vector<2xi64>) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[7, 12]> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = llvm.mul %arg0, %0 : vector<2xi64>
  "llvm.return"(%1) : (vector<2xi64>) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  sorry



def test9_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{"value" = 32767 : i16}> : () -> i16
  %2 = llvm.mul %arg0, %0 : i16
  %3 = llvm.mul %arg0, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = -32767 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  sorry



def test11_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1431655766 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1431655765 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %3 = llvm.or %arg0, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %arg1, %2 : i32
  %6 = llvm.add %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1431655765 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  sorry



def test12_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1431655766 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 1431655765 : i32}> : () -> i32
  %3 = llvm.add %arg1, %0 : i32
  %4 = llvm.or %arg0, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.add %3, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1431655765 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test12_proof : test12_before ⊑ test12_after := by
  sorry



def test13_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1431655767 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1431655766 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %3 = llvm.or %arg0, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %arg1, %2 : i32
  %6 = llvm.add %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1431655766 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test13_proof : test13_before ⊑ test13_after := by
  sorry



def test14_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1431655767 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 1431655766 : i32}> : () -> i32
  %3 = llvm.add %arg1, %0 : i32
  %4 = llvm.or %arg0, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.add %3, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1431655766 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test14_proof : test14_before ⊑ test14_after := by
  sorry



def test15_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1431655767 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.add %arg1, %1 : i32
  %5 = llvm.add %4, %3 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1431655766 : i32}> : () -> i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test15_proof : test15_before ⊑ test15_after := by
  sorry



def test16_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1431655767 : i32}> : () -> i32
  %2 = llvm.add %arg1, %0 : i32
  %3 = llvm.and %arg0, %1 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1431655766 : i32}> : () -> i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test16_proof : test16_before ⊑ test16_after := by
  sorry



def test17_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1431655766 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1431655765 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = llvm.add %3, %arg1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test17_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1431655765 : i32}> : () -> i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test17_proof : test17_before ⊑ test17_after := by
  sorry



def test18_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1431655766 : i32}> : () -> i32
  %2 = llvm.add %arg1, %0 : i32
  %3 = llvm.and %arg0, %1 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1431655765 : i32}> : () -> i32
  %1 = llvm.or %arg0, %0 : i32
  %2 = llvm.sub %arg1, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test18_proof : test18_before ⊑ test18_after := by
  sorry



def add_nsw_mul_nsw_before := [llvm|
{
^0(%arg0 : i16):
  %0 = llvm.add %arg0, %arg0 : i16
  %1 = llvm.add %0, %arg0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
def add_nsw_mul_nsw_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem add_nsw_mul_nsw_proof : add_nsw_mul_nsw_before ⊑ add_nsw_mul_nsw_after := by
  sorry



def mul_add_to_mul_1_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  %2 = llvm.add %arg0, %1 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def mul_add_to_mul_1_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 9 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_1_proof : mul_add_to_mul_1_before ⊑ mul_add_to_mul_1_after := by
  sorry



def mul_add_to_mul_2_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  %2 = llvm.add %1, %arg0 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def mul_add_to_mul_2_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 9 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_2_proof : mul_add_to_mul_2_before ⊑ mul_add_to_mul_2_after := by
  sorry



def mul_add_to_mul_3_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i16}> : () -> i16
  %2 = llvm.mul %arg0, %0 : i16
  %3 = llvm.mul %arg0, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def mul_add_to_mul_3_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_3_proof : mul_add_to_mul_3_before ⊑ mul_add_to_mul_3_after := by
  sorry



def mul_add_to_mul_4_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i16}> : () -> i16
  %2 = llvm.mul %arg0, %0 : i16
  %3 = llvm.mul %arg0, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def mul_add_to_mul_4_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 9 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_4_proof : mul_add_to_mul_4_before ⊑ mul_add_to_mul_4_after := by
  sorry



def mul_add_to_mul_5_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i16}> : () -> i16
  %2 = llvm.mul %arg0, %0 : i16
  %3 = llvm.mul %arg0, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def mul_add_to_mul_5_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_5_proof : mul_add_to_mul_5_before ⊑ mul_add_to_mul_5_after := by
  sorry



def mul_add_to_mul_6_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %arg1 : i32
  %2 = llvm.mul %1, %0 : i32
  %3 = llvm.add %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def mul_add_to_mul_6_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %arg1 : i32
  %2 = llvm.mul %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem mul_add_to_mul_6_proof : mul_add_to_mul_6_before ⊑ mul_add_to_mul_6_after := by
  sorry



def mul_add_to_mul_7_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 32767 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  %2 = llvm.add %arg0, %1 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def mul_add_to_mul_7_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i16}> : () -> i16
  %1 = llvm.shl %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_7_proof : mul_add_to_mul_7_before ⊑ mul_add_to_mul_7_after := by
  sorry



def mul_add_to_mul_8_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 16383 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{"value" = 16384 : i16}> : () -> i16
  %2 = llvm.mul %arg0, %0 : i16
  %3 = llvm.mul %arg0, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def mul_add_to_mul_8_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 32767 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_8_proof : mul_add_to_mul_8_before ⊑ mul_add_to_mul_8_after := by
  sorry



def mul_add_to_mul_9_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 16384 : i16}> : () -> i16
  %1 = llvm.mul %arg0, %0 : i16
  %2 = llvm.mul %arg0, %0 : i16
  %3 = llvm.add %1, %2 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def mul_add_to_mul_9_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i16}> : () -> i16
  %1 = llvm.shl %arg0, %0 : i16
  "llvm.return"(%1) : (i16) -> ()
}
]
theorem mul_add_to_mul_9_proof : mul_add_to_mul_9_before ⊑ mul_add_to_mul_9_after := by
  sorry



def add_or_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_or_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_or_and_proof : add_or_and_before ⊑ add_or_and_after := by
  sorry



def add_or_and_commutative_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_or_and_commutative_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_or_and_commutative_proof : add_or_and_commutative_before ⊑ add_or_and_commutative_after := by
  sorry



def add_and_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.add %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_and_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_and_or_proof : add_and_or_before ⊑ add_and_or_after := by
  sorry



def add_and_or_commutative_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.add %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_and_or_commutative_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_and_or_commutative_proof : add_and_or_commutative_before ⊑ add_and_or_commutative_after := by
  sorry



def add_nsw_or_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_nsw_or_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_nsw_or_and_proof : add_nsw_or_and_before ⊑ add_nsw_or_and_after := by
  sorry



def add_nuw_or_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_nuw_or_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_nuw_or_and_proof : add_nuw_or_and_before ⊑ add_nuw_or_and_after := by
  sorry



def add_nuw_nsw_or_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def add_nuw_nsw_or_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem add_nuw_nsw_or_and_proof : add_nuw_nsw_or_and_before ⊑ add_nuw_nsw_or_and_after := by
  sorry



def add_of_mul_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.mul %arg0, %arg1 : i8
  %1 = llvm.mul %arg0, %arg2 : i8
  %2 = llvm.add %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def add_of_mul_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.mul %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem add_of_mul_proof : add_of_mul_before ⊑ add_of_mul_after := by
  sorry


