
def and_to_xor1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_to_xor1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem and_to_xor1_proof : and_to_xor1_before ⊑ and_to_xor1_after := by
  sorry



def and_to_xor2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_to_xor2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem and_to_xor2_proof : and_to_xor2_before ⊑ and_to_xor2_after := by
  sorry



def and_to_xor3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.and %arg1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_to_xor3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem and_to_xor3_proof : and_to_xor3_before ⊑ and_to_xor3_after := by
  sorry



def and_to_xor4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_to_xor4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem and_to_xor4_proof : and_to_xor4_before ⊑ and_to_xor4_after := by
  sorry



def and_to_xor1_vec_before := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.or %arg0, %arg1 : vector<4xi32>
  %2 = llvm.and %arg0, %arg1 : vector<4xi32>
  %3 = llvm.xor %2, %0 : vector<4xi32>
  %4 = llvm.and %1, %3 : vector<4xi32>
  "llvm.return"(%4) : (vector<4xi32>) -> ()
}
]
def and_to_xor1_vec_after := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = llvm.xor %arg0, %arg1 : vector<4xi32>
  "llvm.return"(%0) : (vector<4xi32>) -> ()
}
]
theorem and_to_xor1_vec_proof : and_to_xor1_vec_before ⊑ and_to_xor1_vec_after := by
  sorry



def or_to_nxor1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.or %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_to_nxor1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem or_to_nxor1_proof : or_to_nxor1_before ⊑ or_to_nxor1_after := by
  sorry



def or_to_nxor2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.or %arg1, %arg0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_to_nxor2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem or_to_nxor2_proof : or_to_nxor2_before ⊑ or_to_nxor2_after := by
  sorry



def or_to_nxor3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.or %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_to_nxor3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem or_to_nxor3_proof : or_to_nxor3_before ⊑ or_to_nxor3_after := by
  sorry



def or_to_nxor4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.or %arg0, %arg1 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_to_nxor4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem or_to_nxor4_proof : or_to_nxor4_before ⊑ or_to_nxor4_after := by
  sorry



def xor_to_xor1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_to_xor1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem xor_to_xor1_proof : xor_to_xor1_before ⊑ xor_to_xor1_after := by
  sorry



def xor_to_xor2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_to_xor2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem xor_to_xor2_proof : xor_to_xor2_before ⊑ xor_to_xor2_after := by
  sorry



def xor_to_xor3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_to_xor3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem xor_to_xor3_proof : xor_to_xor3_before ⊑ xor_to_xor3_after := by
  sorry



def xor_to_xor4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.or %arg0, %arg1 : i32
  %1 = llvm.and %arg1, %arg0 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_to_xor4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem xor_to_xor4_proof : xor_to_xor4_before ⊑ xor_to_xor4_after := by
  sorry



def simplify_or_common_op_commute0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.and %arg0, %arg1 : i4
  %2 = llvm.and %1, %arg2 : i4
  %3 = llvm.xor %2, %0 : i4
  %4 = llvm.or %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def simplify_or_common_op_commute0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  "llvm.return"(%0) : (i4) -> ()
}
]
theorem simplify_or_common_op_commute0_proof : simplify_or_common_op_commute0_before ⊑ simplify_or_common_op_commute0_after := by
  sorry



def simplify_or_common_op_commute1_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.and %arg1, %arg0 : i4
  %2 = llvm.and %1, %arg2 : i4
  %3 = llvm.xor %2, %0 : i4
  %4 = llvm.or %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def simplify_or_common_op_commute1_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  "llvm.return"(%0) : (i4) -> ()
}
]
theorem simplify_or_common_op_commute1_proof : simplify_or_common_op_commute1_before ⊑ simplify_or_common_op_commute1_after := by
  sorry



def simplify_or_common_op_commute2_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4, %arg3 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.mul %arg2, %arg2 : i4
  %2 = llvm.and %arg0, %arg1 : i4
  %3 = llvm.and %1, %2 : i4
  %4 = llvm.and %3, %arg3 : i4
  %5 = llvm.xor %4, %0 : i4
  %6 = llvm.or %5, %arg0 : i4
  "llvm.return"(%6) : (i4) -> ()
}
]
def simplify_or_common_op_commute2_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4, %arg3 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  "llvm.return"(%0) : (i4) -> ()
}
]
theorem simplify_or_common_op_commute2_proof : simplify_or_common_op_commute2_before ⊑ simplify_or_common_op_commute2_after := by
  sorry



def simplify_or_common_op_commute3_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.mul %arg2, %arg2 : vector<2xi4>
  %3 = llvm.and %arg1, %arg0 : vector<2xi4>
  %4 = llvm.and %2, %3 : vector<2xi4>
  %5 = llvm.xor %4, %1 : vector<2xi4>
  %6 = llvm.or %arg0, %5 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
def simplify_or_common_op_commute3_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  "llvm.return"(%1) : (vector<2xi4>) -> ()
}
]
theorem simplify_or_common_op_commute3_proof : simplify_or_common_op_commute3_before ⊑ simplify_or_common_op_commute3_after := by
  sorry



def simplify_and_common_op_commute1_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.or %arg1, %arg0 : i4
  %2 = llvm.or %1, %arg2 : i4
  %3 = llvm.xor %2, %0 : i4
  %4 = llvm.and %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def simplify_and_common_op_commute1_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i4}> : () -> i4
  "llvm.return"(%0) : (i4) -> ()
}
]
theorem simplify_and_common_op_commute1_proof : simplify_and_common_op_commute1_before ⊑ simplify_and_common_op_commute1_after := by
  sorry



def simplify_and_common_op_commute2_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4, %arg3 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = llvm.mul %arg2, %arg2 : i4
  %2 = llvm.or %arg0, %arg1 : i4
  %3 = llvm.or %1, %2 : i4
  %4 = llvm.or %3, %arg3 : i4
  %5 = llvm.xor %4, %0 : i4
  %6 = llvm.and %5, %arg0 : i4
  "llvm.return"(%6) : (i4) -> ()
}
]
def simplify_and_common_op_commute2_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4, %arg3 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i4}> : () -> i4
  "llvm.return"(%0) : (i4) -> ()
}
]
theorem simplify_and_common_op_commute2_proof : simplify_and_common_op_commute2_before ⊑ simplify_and_common_op_commute2_after := by
  sorry



def simplify_and_common_op_commute3_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = llvm.mul %arg2, %arg2 : vector<2xi4>
  %3 = llvm.or %arg1, %arg0 : vector<2xi4>
  %4 = llvm.or %2, %3 : vector<2xi4>
  %5 = llvm.xor %4, %1 : vector<2xi4>
  %6 = llvm.and %arg0, %5 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
def simplify_and_common_op_commute3_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi4>}> : () -> vector<2xi4>
  "llvm.return"(%1) : (vector<2xi4>) -> ()
}
]
theorem simplify_and_common_op_commute3_proof : simplify_and_common_op_commute3_before ⊑ simplify_and_common_op_commute3_after := by
  sorry



def reduce_xor_common_op_commute0_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.xor %arg0, %arg1 : i4
  %1 = llvm.xor %0, %arg2 : i4
  %2 = llvm.or %1, %arg0 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def reduce_xor_common_op_commute0_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.xor %arg1, %arg2 : i4
  %1 = llvm.or %0, %arg0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem reduce_xor_common_op_commute0_proof : reduce_xor_common_op_commute0_before ⊑ reduce_xor_common_op_commute0_after := by
  sorry



def reduce_xor_common_op_commute1_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.xor %arg1, %arg0 : i4
  %1 = llvm.xor %0, %arg2 : i4
  %2 = llvm.or %1, %arg0 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def reduce_xor_common_op_commute1_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4):
  %0 = llvm.xor %arg1, %arg2 : i4
  %1 = llvm.or %0, %arg0 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
theorem reduce_xor_common_op_commute1_proof : reduce_xor_common_op_commute1_before ⊑ reduce_xor_common_op_commute1_after := by
  sorry



def annihilate_xor_common_op_commute2_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4, %arg3 : i4):
  %0 = llvm.mul %arg2, %arg2 : i4
  %1 = llvm.xor %arg0, %arg1 : i4
  %2 = llvm.xor %0, %1 : i4
  %3 = llvm.xor %2, %arg3 : i4
  %4 = llvm.xor %3, %arg0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def annihilate_xor_common_op_commute2_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4, %arg2 : i4, %arg3 : i4):
  %0 = llvm.mul %arg2, %arg2 : i4
  %1 = llvm.xor %0, %arg1 : i4
  %2 = llvm.xor %1, %arg3 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
theorem annihilate_xor_common_op_commute2_proof : annihilate_xor_common_op_commute2_before ⊑ annihilate_xor_common_op_commute2_after := by
  sorry



def reduce_xor_common_op_commute3_before := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = llvm.mul %arg2, %arg2 : vector<2xi4>
  %1 = llvm.xor %arg1, %arg0 : vector<2xi4>
  %2 = llvm.xor %0, %1 : vector<2xi4>
  %3 = llvm.or %arg0, %2 : vector<2xi4>
  "llvm.return"(%3) : (vector<2xi4>) -> ()
}
]
def reduce_xor_common_op_commute3_after := [llvm|
{
^0(%arg0 : vector<2xi4>, %arg1 : vector<2xi4>, %arg2 : vector<2xi4>):
  %0 = llvm.mul %arg2, %arg2 : vector<2xi4>
  %1 = llvm.xor %0, %arg1 : vector<2xi4>
  %2 = llvm.or %1, %arg0 : vector<2xi4>
  "llvm.return"(%2) : (vector<2xi4>) -> ()
}
]
theorem reduce_xor_common_op_commute3_proof : reduce_xor_common_op_commute3_before ⊑ reduce_xor_common_op_commute3_after := by
  sorry


