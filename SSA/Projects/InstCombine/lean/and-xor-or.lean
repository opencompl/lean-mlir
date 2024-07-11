
def and_xor_common_op_constant_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[1, 2, 3, 4]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.xor %arg0, %0 : vector<4xi32>
  %2 = llvm.and %0, %1 : vector<4xi32>
  "llvm.return"(%2) : (vector<4xi32>) -> ()
}
]
def and_xor_common_op_constant_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[1, 2, 3, 4]> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.xor %arg0, %0 : vector<4xi32>
  %3 = llvm.and %2, %1 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
theorem and_xor_common_op_constant_proof : and_xor_common_op_constant_before ⊑ and_xor_common_op_constant_after := by
  sorry



def and_xor_not_common_op_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg0, %1 : i32
  %3 = llvm.and %2, %arg0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_xor_not_common_op_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem and_xor_not_common_op_proof : and_xor_not_common_op_before ⊑ and_xor_not_common_op_after := by
  sorry



def and_not_xor_common_op_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def and_not_xor_common_op_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem and_not_xor_common_op_proof : and_not_xor_common_op_before ⊑ and_not_xor_common_op_after := by
  sorry



def or_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.and %arg1, %arg0 : i64
  %1 = llvm.xor %arg1, %arg0 : i64
  %2 = llvm.add %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def or_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.or %arg1, %arg0 : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
theorem or_proof : or_before ⊑ or_after := by
  sorry



def or2_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.and %arg1, %arg0 : i64
  %1 = llvm.xor %arg1, %arg0 : i64
  %2 = llvm.or %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def or2_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.or %arg1, %arg0 : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
theorem or2_proof : or2_before ⊑ or2_after := by
  sorry



def and_xor_or_negative_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = llvm.and %arg1, %arg0 : i64
  %1 = llvm.xor %arg2, %0 : i64
  %2 = llvm.or %arg3, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def and_xor_or_negative_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = llvm.and %arg1, %arg0 : i64
  %1 = llvm.xor %0, %arg2 : i64
  %2 = llvm.or %1, %arg3 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
theorem and_xor_or_negative_proof : and_xor_or_negative_before ⊑ and_xor_or_negative_after := by
  sorry



def and_shl_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.shl %arg0, %arg3 : i8
  %1 = llvm.shl %arg1, %arg3 : i8
  %2 = llvm.and %0, %arg2 : i8
  %3 = llvm.and %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def and_shl_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.and %arg0, %arg1 : i8
  %1 = llvm.shl %0, %arg3 : i8
  %2 = llvm.and %1, %arg2 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem and_shl_proof : and_shl_before ⊑ and_shl_after := by
  sorry



def or_shl_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.shl %arg0, %arg3 : i8
  %1 = llvm.shl %arg1, %arg3 : i8
  %2 = llvm.or %0, %arg2 : i8
  %3 = llvm.or %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_shl_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  %1 = llvm.shl %0, %arg3 : i8
  %2 = llvm.or %1, %arg2 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem or_shl_proof : or_shl_before ⊑ or_shl_after := by
  sorry



def not_and_and_not_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %1, %arg0 : i32
  %4 = llvm.and %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def not_and_and_not_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_not_commute1_proof : not_and_and_not_commute1_before ⊑ not_and_and_not_commute1_after := by
  sorry



def not_or_or_not_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.or %1, %arg0 : i32
  %4 = llvm.or %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def not_or_or_not_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_not_commute1_proof : not_or_or_not_commute1_before ⊑ not_or_or_not_commute1_after := by
  sorry



def or_not_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %arg0, %arg2 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg1 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_not_and_proof : or_not_and_before ⊑ or_not_and_after := by
  sorry



def or_not_and_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %arg2, %arg0 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg1 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_not_and_commute3_proof : or_not_and_commute3_before ⊑ or_not_and_commute3_after := by
  sorry



def or_not_and_commute6_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %arg2, %arg0 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg1 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_commute6_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_not_and_commute6_proof : or_not_and_commute6_before ⊑ or_not_and_commute6_after := by
  sorry



def or_not_and_commute7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %arg0, %arg2 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.and %5, %arg1 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_commute7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_not_and_commute7_proof : or_not_and_commute7_before ⊑ or_not_and_commute7_after := by
  sorry



def and_not_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %arg0, %arg2 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg1 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_not_or_proof : and_not_or_before ⊑ and_not_or_after := by
  sorry



def and_not_or_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %arg2, %arg0 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg1 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_not_or_commute3_proof : and_not_or_commute3_before ⊑ and_not_or_commute3_after := by
  sorry



def and_not_or_commute6_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %arg2, %arg0 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg1 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_commute6_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_not_or_commute6_proof : and_not_or_commute6_before ⊑ and_not_or_commute6_after := by
  sorry



def and_not_or_commute7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %arg0, %arg2 : i32
  %5 = llvm.xor %4, %0 : i32
  %6 = llvm.or %5, %arg1 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_commute7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_not_or_commute7_proof : and_not_or_commute7_before ⊑ and_not_or_commute7_after := by
  sorry



def or_and_not_not_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_and_not_not_proof : or_and_not_not_before ⊑ or_and_not_not_after := by
  sorry



def or_and_not_not_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_and_not_not_commute2_proof : or_and_not_not_commute2_before ⊑ or_and_not_not_commute2_after := by
  sorry



def or_and_not_not_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg2, %arg0 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_and_not_not_commute3_proof : or_and_not_not_commute3_before ⊑ or_and_not_not_commute3_after := by
  sorry



def or_and_not_not_commute4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_and_not_not_commute4_proof : or_and_not_not_commute4_before ⊑ or_and_not_not_commute4_after := by
  sorry



def or_and_not_not_commute5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %2, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_and_not_not_commute5_proof : or_and_not_not_commute5_before ⊑ or_and_not_not_commute5_after := by
  sorry



def or_and_not_not_commute7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %arg2, %arg0 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_and_not_not_commute7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem or_and_not_not_commute7_proof : or_and_not_not_commute7_before ⊑ or_and_not_not_commute7_after := by
  sorry



def and_or_not_not_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_or_not_not_proof : and_or_not_not_before ⊑ and_or_not_not_after := by
  sorry



def and_or_not_not_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_or_not_not_commute2_proof : and_or_not_not_commute2_before ⊑ and_or_not_not_commute2_after := by
  sorry



def and_or_not_not_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg2, %arg0 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_or_not_not_commute3_proof : and_or_not_not_commute3_before ⊑ and_or_not_not_commute3_after := by
  sorry



def and_or_not_not_commute4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_or_not_not_commute4_proof : and_or_not_not_commute4_before ⊑ and_or_not_not_commute4_after := by
  sorry



def and_or_not_not_commute5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %2, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_or_not_not_commute5_proof : and_or_not_not_commute5_before ⊑ and_or_not_not_commute5_after := by
  sorry



def and_or_not_not_commute7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg2, %arg0 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_commute7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem and_or_not_not_commute7_proof : and_or_not_not_commute7_before ⊑ and_or_not_not_commute7_after := by
  sorry



def and_or_not_not_wrong_a_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32, %arg3 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg3 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %arg0, %arg2 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_or_not_not_wrong_a_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32, %arg3 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg3 : i32
  %2 = llvm.and %arg0, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %3, %arg1 : i32
  %5 = llvm.xor %1, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_or_not_not_wrong_a_proof : and_or_not_not_wrong_a_before ⊑ and_or_not_not_wrong_a_after := by
  sorry



def and_not_or_or_not_or_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.or %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %arg1, %arg2 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_not_or_or_not_or_xor_proof : and_not_or_or_not_or_xor_before ⊑ and_not_or_or_not_or_xor_after := by
  sorry



def and_not_or_or_not_or_xor_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.or %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg1 : i32
  %2 = llvm.xor %arg1, %arg2 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_not_or_or_not_or_xor_commute1_proof : and_not_or_or_not_or_xor_commute1_before ⊑ and_not_or_or_not_or_xor_commute1_after := by
  sorry



def and_not_or_or_not_or_xor_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.xor %arg2, %arg1 : i32
  %5 = llvm.or %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.or %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %arg2, %arg1 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_not_or_or_not_or_xor_commute3_proof : and_not_or_or_not_or_xor_commute3_before ⊑ and_not_or_or_not_or_xor_commute3_after := by
  sorry



def and_not_or_or_not_or_xor_commute5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.or %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def and_not_or_or_not_or_xor_commute5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.xor %arg1, %arg2 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.and %1, %3 : i32
  %5 = llvm.xor %4, %0 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
theorem and_not_or_or_not_or_xor_commute5_proof : and_not_or_or_not_or_xor_commute5_before ⊑ and_not_or_or_not_or_xor_commute5_after := by
  sorry



def or_not_and_and_not_and_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem or_not_and_and_not_and_xor_proof : or_not_and_and_not_and_xor_before ⊑ or_not_and_and_not_and_xor_after := by
  sorry



def or_not_and_and_not_and_xor_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem or_not_and_and_not_and_xor_commute1_proof : or_not_and_and_not_and_xor_commute1_before ⊑ or_not_and_and_not_and_xor_commute1_after := by
  sorry



def or_not_and_and_not_and_xor_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg2, %arg1 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.and %3, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg2, %arg1 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem or_not_and_and_not_and_xor_commute3_proof : or_not_and_and_not_and_xor_commute3_before ⊑ or_not_and_and_not_and_xor_commute3_after := by
  sorry



def or_not_and_and_not_and_xor_commute5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %0 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def or_not_and_and_not_and_xor_commute5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.or %2, %arg0 : i32
  %4 = llvm.xor %arg1, %arg2 : i32
  %5 = llvm.and %4, %arg0 : i32
  %6 = llvm.xor %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem or_not_and_and_not_and_xor_commute5_proof : or_not_and_and_not_and_xor_commute5_before ⊑ or_not_and_and_not_and_xor_commute5_after := by
  sorry



def not_and_and_or_not_or_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.or %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.and %5, %arg2 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_proof : not_and_and_or_not_or_or_before ⊑ not_and_and_or_not_or_or_after := by
  sorry



def not_and_and_or_not_or_or_commute1_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg2, %arg0 : i32
  %2 = llvm.or %1, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.and %5, %arg2 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute1_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_commute1_or_proof : not_and_and_or_not_or_or_commute1_or_before ⊑ not_and_and_or_not_or_or_commute1_or_after := by
  sorry



def not_and_and_or_not_or_or_commute2_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg2 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.and %5, %arg2 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute2_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_commute2_or_proof : not_and_and_or_not_or_or_commute2_or_before ⊑ not_and_and_or_not_or_or_commute2_or_after := by
  sorry



def not_and_and_or_not_or_or_commute1_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.or %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.and %4, %arg2 : i32
  %6 = llvm.and %5, %arg1 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute1_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_commute1_and_proof : not_and_and_or_not_or_or_commute1_and_before ⊑ not_and_and_or_not_or_or_commute1_and_after := by
  sorry



def not_and_and_or_not_or_or_commute2_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.or %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.and %arg1, %arg2 : i32
  %6 = llvm.and %5, %4 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute2_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_commute2_and_proof : not_and_and_or_not_or_or_commute2_and_before ⊑ not_and_and_or_not_or_or_commute2_and_after := by
  sorry



def not_and_and_or_not_or_or_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.or %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.and %5, %arg2 : i32
  %7 = llvm.or %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_and_and_or_not_or_or_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg2, %arg1 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_and_and_or_not_or_or_commute1_proof : not_and_and_or_not_or_or_commute1_before ⊑ not_and_and_or_not_or_or_commute1_after := by
  sorry



def not_or_or_and_not_and_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.and %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.or %5, %arg2 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg2, %arg1 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_proof : not_or_or_and_not_and_and_before ⊑ not_or_or_and_not_and_and_after := by
  sorry



def not_or_or_and_not_and_and_commute1_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg0 : i32
  %2 = llvm.and %1, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.or %5, %arg2 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute1_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg2, %arg1 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_commute1_and_proof : not_or_or_and_not_and_and_commute1_and_before ⊑ not_or_or_and_not_and_and_commute1_and_after := by
  sorry



def not_or_or_and_not_and_and_commute2_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg2 : i32
  %2 = llvm.and %1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.or %5, %arg2 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute2_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg2, %arg1 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_commute2_and_proof : not_or_or_and_not_and_and_commute2_and_before ⊑ not_or_or_and_not_and_and_commute2_and_after := by
  sorry



def not_or_or_and_not_and_and_commute1_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.and %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.or %4, %arg2 : i32
  %6 = llvm.or %5, %arg1 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute1_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %arg2 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_commute1_or_proof : not_or_or_and_not_and_and_commute1_or_before ⊑ not_or_or_and_not_and_and_commute1_or_after := by
  sorry



def not_or_or_and_not_and_and_commute2_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.and %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.or %arg1, %arg2 : i32
  %6 = llvm.or %5, %4 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute2_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %arg2 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_commute2_or_proof : not_or_or_and_not_and_and_commute2_or_before ⊑ not_or_or_and_not_and_and_commute2_or_after := by
  sorry



def not_or_or_and_not_and_and_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.and %1, %arg2 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.xor %arg0, %0 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.or %5, %arg2 : i32
  %7 = llvm.and %6, %3 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def not_or_or_and_not_and_and_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg2, %arg1 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem not_or_or_and_not_and_and_commute1_proof : not_or_or_and_not_and_and_commute1_before ⊑ not_or_or_and_not_and_and_commute1_after := by
  sorry



def not_and_and_or_no_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.and %3, %arg1 : i32
  %5 = llvm.and %4, %arg2 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_or_no_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_and_and_or_no_or_proof : not_and_and_or_no_or_before ⊑ not_and_and_or_no_or_after := by
  sorry



def not_and_and_or_no_or_commute1_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.and %arg2, %arg1 : i32
  %5 = llvm.and %4, %3 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_or_no_or_commute1_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_and_and_or_no_or_commute1_and_proof : not_and_and_or_no_or_commute1_and_before ⊑ not_and_and_or_no_or_commute1_and_after := by
  sorry



def not_and_and_or_no_or_commute2_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.and %3, %arg2 : i32
  %5 = llvm.and %4, %arg1 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_or_no_or_commute2_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_and_and_or_no_or_commute2_and_proof : not_and_and_or_no_or_commute2_and_before ⊑ not_and_and_or_no_or_commute2_and_after := by
  sorry



def not_and_and_or_no_or_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.and %3, %arg1 : i32
  %5 = llvm.and %4, %arg2 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_and_and_or_no_or_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.or %2, %arg2 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_and_and_or_no_or_commute1_proof : not_and_and_or_no_or_commute1_before ⊑ not_and_and_or_no_or_commute1_after := by
  sorry



def not_or_or_and_no_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.or %3, %arg1 : i32
  %5 = llvm.or %4, %arg2 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_and_no_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_or_or_and_no_and_proof : not_or_or_and_no_and_before ⊑ not_or_or_and_no_and_after := by
  sorry



def not_or_or_and_no_and_commute1_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.or %arg2, %arg1 : i32
  %5 = llvm.or %4, %3 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_and_no_and_commute1_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_or_or_and_no_and_commute1_or_proof : not_or_or_and_no_and_commute1_or_before ⊑ not_or_or_and_no_and_commute1_or_after := by
  sorry



def not_or_or_and_no_and_commute2_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.or %3, %arg2 : i32
  %5 = llvm.or %4, %arg1 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_and_no_and_commute2_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_or_or_and_no_and_commute2_or_proof : not_or_or_and_no_and_commute2_or_before ⊑ not_or_or_and_no_and_commute2_or_after := by
  sorry



def not_or_or_and_no_and_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  %3 = llvm.xor %arg0, %0 : i32
  %4 = llvm.or %3, %arg1 : i32
  %5 = llvm.or %4, %arg2 : i32
  %6 = llvm.and %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def not_or_or_and_no_and_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %arg1, %0 : i32
  %3 = llvm.and %2, %arg2 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem not_or_or_and_no_and_commute1_proof : not_or_or_and_no_and_commute1_before ⊑ not_or_or_and_no_and_commute1_after := by
  sorry



def and_orn_xor_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %arg1 : i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.or %2, %arg1 : i4
  %4 = llvm.and %3, %1 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def and_orn_xor_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.xor %arg0, %0 : i4
  %2 = llvm.and %1, %arg1 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
theorem and_orn_xor_proof : and_orn_xor_before ⊑ and_orn_xor_after := by
  sorry



def and_orn_xor_commute8_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %arg0 : i32
  %2 = llvm.mul %arg1, %arg1 : i32
  %3 = llvm.xor %2, %1 : i32
  %4 = llvm.xor %1, %0 : i32
  %5 = llvm.or %2, %4 : i32
  %6 = llvm.and %3, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def and_orn_xor_commute8_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %arg0 : i32
  %2 = llvm.mul %arg1, %arg1 : i32
  %3 = llvm.xor %1, %0 : i32
  %4 = llvm.and %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem and_orn_xor_commute8_proof : and_orn_xor_commute8_before ⊑ and_orn_xor_commute8_after := by
  sorry



def canonicalize_logic_first_or0_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def canonicalize_logic_first_or0_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 112 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem canonicalize_logic_first_or0_proof : canonicalize_logic_first_or0_before ⊑ canonicalize_logic_first_or0_after := by
  sorry



def canonicalize_logic_first_or0_nsw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def canonicalize_logic_first_or0_nsw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 112 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem canonicalize_logic_first_or0_nsw_proof : canonicalize_logic_first_or0_nsw_before ⊑ canonicalize_logic_first_or0_nsw_after := by
  sorry



def canonicalize_logic_first_or0_nswnuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 112 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def canonicalize_logic_first_or0_nswnuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 15 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 112 : i32}> : () -> i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem canonicalize_logic_first_or0_nswnuw_proof : canonicalize_logic_first_or0_nswnuw_before ⊑ canonicalize_logic_first_or0_nswnuw_after := by
  sorry



def canonicalize_logic_first_or_vector0_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<112> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.or %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_or_vector0_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<112> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.or %arg0, %0 : vector<2xi32>
  %3 = llvm.add %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_or_vector0_proof : canonicalize_logic_first_or_vector0_before ⊑ canonicalize_logic_first_or_vector0_after := by
  sorry



def canonicalize_logic_first_or_vector0_nsw_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<112> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.or %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_or_vector0_nsw_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<112> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.or %arg0, %0 : vector<2xi32>
  %3 = llvm.add %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_or_vector0_nsw_proof : canonicalize_logic_first_or_vector0_nsw_before ⊑ canonicalize_logic_first_or_vector0_nsw_after := by
  sorry



def canonicalize_logic_first_or_vector0_nswnuw_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<112> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.or %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_or_vector0_nswnuw_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<112> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.or %arg0, %0 : vector<2xi32>
  %3 = llvm.add %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_or_vector0_nswnuw_proof : canonicalize_logic_first_or_vector0_nswnuw_before ⊑ canonicalize_logic_first_or_vector0_nswnuw_after := by
  sorry



def canonicalize_logic_first_or_vector1_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-8388608, 2071986176]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[32783, 2063]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.or %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_or_vector1_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-8388608, 2071986176]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[32783, 2063]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = llvm.or %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_or_vector1_proof : canonicalize_logic_first_or_vector1_before ⊑ canonicalize_logic_first_or_vector1_after := by
  sorry



def canonicalize_logic_first_or_vector1_nsw_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-8388608, 2071986176]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[32783, 2063]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.or %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_or_vector1_nsw_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-8388608, 2071986176]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[32783, 2063]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = llvm.or %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_or_vector1_nsw_proof : canonicalize_logic_first_or_vector1_nsw_before ⊑ canonicalize_logic_first_or_vector1_nsw_after := by
  sorry



def canonicalize_logic_first_or_vector1_nswnuw_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-8388608, 2071986176]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[32783, 2063]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.or %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_or_vector1_nswnuw_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-8388608, 2071986176]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[32783, 2063]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = llvm.or %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_or_vector1_nswnuw_proof : canonicalize_logic_first_or_vector1_nswnuw_before ⊑ canonicalize_logic_first_or_vector1_nswnuw_after := by
  sorry



def canonicalize_logic_first_or_vector2_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[2147483632, 2147483640]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[32783, 2063]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.or %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_or_vector2_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[2147483632, 2147483640]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[32783, 2063]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = llvm.or %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_or_vector2_proof : canonicalize_logic_first_or_vector2_before ⊑ canonicalize_logic_first_or_vector2_after := by
  sorry



def canonicalize_logic_first_and0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 48 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -10 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_and0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -10 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 48 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem canonicalize_logic_first_and0_proof : canonicalize_logic_first_and0_before ⊑ canonicalize_logic_first_and0_after := by
  sorry



def canonicalize_logic_first_and0_nsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 48 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -10 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_and0_nsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -10 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 48 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem canonicalize_logic_first_and0_nsw_proof : canonicalize_logic_first_and0_nsw_before ⊑ canonicalize_logic_first_and0_nsw_after := by
  sorry



def canonicalize_logic_first_and0_nswnuw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 48 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -10 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_and0_nswnuw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -10 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 48 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem canonicalize_logic_first_and0_nswnuw_proof : canonicalize_logic_first_and0_nswnuw_before ⊑ canonicalize_logic_first_and0_nswnuw_after := by
  sorry



def canonicalize_logic_first_and_vector0_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<48> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-10> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.add %0, %arg0 : vector<2xi8>
  %3 = llvm.and %1, %2 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
def canonicalize_logic_first_and_vector0_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-10> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<48> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.and %arg0, %0 : vector<2xi8>
  %3 = llvm.add %2, %1 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
theorem canonicalize_logic_first_and_vector0_proof : canonicalize_logic_first_and_vector0_before ⊑ canonicalize_logic_first_and_vector0_after := by
  sorry



def canonicalize_logic_first_and_vector0_nsw_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<48> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-10> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.add %0, %arg0 : vector<2xi8>
  %3 = llvm.and %1, %2 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
def canonicalize_logic_first_and_vector0_nsw_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-10> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<48> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.and %arg0, %0 : vector<2xi8>
  %3 = llvm.add %2, %1 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
theorem canonicalize_logic_first_and_vector0_nsw_proof : canonicalize_logic_first_and_vector0_nsw_before ⊑ canonicalize_logic_first_and_vector0_nsw_after := by
  sorry



def canonicalize_logic_first_and_vector0_nswnuw_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<48> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-10> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.add %0, %arg0 : vector<2xi8>
  %3 = llvm.and %1, %2 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
def canonicalize_logic_first_and_vector0_nswnuw_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-10> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<48> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.and %arg0, %0 : vector<2xi8>
  %3 = llvm.add %2, %1 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
theorem canonicalize_logic_first_and_vector0_nswnuw_proof : canonicalize_logic_first_and_vector0_nswnuw_before ⊑ canonicalize_logic_first_and_vector0_nswnuw_after := by
  sorry



def canonicalize_logic_first_and_vector1_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[48, 32]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[-10, -4]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.add %0, %arg0 : vector<2xi8>
  %3 = llvm.and %1, %2 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
def canonicalize_logic_first_and_vector1_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[48, 32]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[-10, -4]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.add %arg0, %0 : vector<2xi8>
  %3 = llvm.and %2, %1 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
theorem canonicalize_logic_first_and_vector1_proof : canonicalize_logic_first_and_vector1_before ⊑ canonicalize_logic_first_and_vector1_after := by
  sorry



def canonicalize_logic_first_and_vector2_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<612368384> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[-65536, -32768]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.and %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_and_vector2_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<612368384> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[-65536, -32768]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = llvm.and %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_and_vector2_proof : canonicalize_logic_first_and_vector2_before ⊑ canonicalize_logic_first_and_vector2_after := by
  sorry



def canonicalize_logic_first_and_vector3_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[32768, 16384]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[-65536, -32768]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.and %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_and_vector3_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[32768, 16384]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[-65536, -32768]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = llvm.and %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_and_vector3_proof : canonicalize_logic_first_and_vector3_before ⊑ canonicalize_logic_first_and_vector3_after := by
  sorry



def canonicalize_logic_first_xor_0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 96 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 31 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_xor_0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 96 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem canonicalize_logic_first_xor_0_proof : canonicalize_logic_first_xor_0_before ⊑ canonicalize_logic_first_xor_0_after := by
  sorry



def canonicalize_logic_first_xor_0_nsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 96 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 31 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_xor_0_nsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 96 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem canonicalize_logic_first_xor_0_nsw_proof : canonicalize_logic_first_xor_0_nsw_before ⊑ canonicalize_logic_first_xor_0_nsw_after := by
  sorry



def canonicalize_logic_first_xor_0_nswnuw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 96 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 31 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def canonicalize_logic_first_xor_0_nswnuw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 96 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem canonicalize_logic_first_xor_0_nswnuw_proof : canonicalize_logic_first_xor_0_nswnuw_before ⊑ canonicalize_logic_first_xor_0_nswnuw_after := by
  sorry



def canonicalize_logic_first_xor_vector0_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-8388608> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<32783> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.xor %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_xor_vector0_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<32783> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-8388608> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.xor %arg0, %0 : vector<2xi32>
  %3 = llvm.add %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_xor_vector0_proof : canonicalize_logic_first_xor_vector0_before ⊑ canonicalize_logic_first_xor_vector0_after := by
  sorry



def canonicalize_logic_first_xor_vector0_nsw_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-8388608> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<32783> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.xor %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_xor_vector0_nsw_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<32783> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-8388608> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.xor %arg0, %0 : vector<2xi32>
  %3 = llvm.add %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_xor_vector0_nsw_proof : canonicalize_logic_first_xor_vector0_nsw_before ⊑ canonicalize_logic_first_xor_vector0_nsw_after := by
  sorry



def canonicalize_logic_first_xor_vector0_nswnuw_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-8388608> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<32783> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.xor %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_xor_vector0_nswnuw_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<32783> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-8388608> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.xor %arg0, %0 : vector<2xi32>
  %3 = llvm.add %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_xor_vector0_nswnuw_proof : canonicalize_logic_first_xor_vector0_nswnuw_before ⊑ canonicalize_logic_first_xor_vector0_nswnuw_after := by
  sorry



def canonicalize_logic_first_xor_vector1_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-8388608, 2071986176]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[32783, 2063]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.xor %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_xor_vector1_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-8388608, 2071986176]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[32783, 2063]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = llvm.xor %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_xor_vector1_proof : canonicalize_logic_first_xor_vector1_before ⊑ canonicalize_logic_first_xor_vector1_after := by
  sorry



def canonicalize_logic_first_xor_vector2_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[2147483632, 2147483640]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[32783, 2063]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.xor %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def canonicalize_logic_first_xor_vector2_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[2147483632, 2147483640]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[32783, 2063]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = llvm.xor %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem canonicalize_logic_first_xor_vector2_proof : canonicalize_logic_first_xor_vector2_before ⊑ canonicalize_logic_first_xor_vector2_after := by
  sorry



def test_and_xor_freely_invertable_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i1):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %1 = llvm.xor %0, %arg2 : i1
  %2 = llvm.and %1, %arg2 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_and_xor_freely_invertable_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i1):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i32, i32) -> i1
  %1 = llvm.and %0, %arg2 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_and_xor_freely_invertable_proof : test_and_xor_freely_invertable_before ⊑ test_and_xor_freely_invertable_after := by
  sorry


