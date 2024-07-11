
def set_low_bit_mask_eq_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 19 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def set_low_bit_mask_eq_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 18 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem set_low_bit_mask_eq_proof : set_low_bit_mask_eq_before ⊑ set_low_bit_mask_eq_after := by
  sorry



def set_low_bit_mask_ne_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<19> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.or %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def set_low_bit_mask_ne_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-4> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<16> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.and %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem set_low_bit_mask_ne_proof : set_low_bit_mask_ne_before ⊑ set_low_bit_mask_ne_after := by
  sorry



def set_low_bit_mask_ugt_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 19 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def set_low_bit_mask_ugt_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 19 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem set_low_bit_mask_ugt_proof : set_low_bit_mask_ugt_before ⊑ set_low_bit_mask_ugt_after := by
  sorry



def set_low_bit_mask_uge_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 20 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def set_low_bit_mask_uge_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 19 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem set_low_bit_mask_uge_proof : set_low_bit_mask_uge_before ⊑ set_low_bit_mask_uge_after := by
  sorry



def set_low_bit_mask_ule_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 18 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def set_low_bit_mask_ule_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 19 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem set_low_bit_mask_ule_proof : set_low_bit_mask_ule_before ⊑ set_low_bit_mask_ule_after := by
  sorry



def set_low_bit_mask_sge_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 51 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def set_low_bit_mask_sge_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 50 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem set_low_bit_mask_sge_proof : set_low_bit_mask_sge_before ⊑ set_low_bit_mask_sge_after := by
  sorry



def set_low_bit_mask_sle_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 63 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 68 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def set_low_bit_mask_sle_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 63 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 69 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem set_low_bit_mask_sle_proof : set_low_bit_mask_sle_before ⊑ set_low_bit_mask_sle_after := by
  sorry



def eq_const_mask_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = llvm.or %arg0, %0 : i8
  %2 = llvm.or %arg1, %0 : i8
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_const_mask_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -43 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %arg1 : i8
  %3 = llvm.and %2, %0 : i8
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem eq_const_mask_proof : eq_const_mask_before ⊑ eq_const_mask_after := by
  sorry



def ne_const_mask_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-106, 5]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.or %arg0, %0 : vector<2xi8>
  %2 = llvm.or %arg1, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def ne_const_mask_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[105, -6]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.xor %arg0, %arg1 : vector<2xi8>
  %4 = llvm.and %3, %0 : vector<2xi8>
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
theorem ne_const_mask_proof : ne_const_mask_before ⊑ ne_const_mask_after := by
  sorry



def eq_const_mask_wrong_opcode_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = llvm.or %arg0, %0 : i8
  %2 = llvm.xor %arg1, %0 : i8
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_const_mask_wrong_opcode_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = llvm.or %arg0, %0 : i8
  %2 = llvm.xor %1, %arg1 : i8
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem eq_const_mask_wrong_opcode_proof : eq_const_mask_wrong_opcode_before ⊑ eq_const_mask_wrong_opcode_after := by
  sorry



def decrement_slt_0_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.add %arg0, %0 : vector<2xi8>
  %4 = llvm.or %3, %arg0 : vector<2xi8>
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def decrement_slt_0_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem decrement_slt_0_proof : decrement_slt_0_before ⊑ decrement_slt_0_after := by
  sorry



def decrement_sgt_n1_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.add %arg0, %0 : vector<2xi8>
  %2 = llvm.or %1, %arg0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def decrement_sgt_n1_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem decrement_sgt_n1_proof : decrement_sgt_n1_before ⊑ decrement_sgt_n1_after := by
  sorry



def icmp_or_xor_2_eq_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.xor %arg0, %arg1 : i64
  %2 = llvm.xor %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_or_xor_2_eq_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem icmp_or_xor_2_eq_proof : icmp_or_xor_2_eq_before ⊑ icmp_or_xor_2_eq_after := by
  sorry



def icmp_or_xor_2_ne_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.xor %arg0, %arg1 : i64
  %2 = llvm.xor %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_or_xor_2_ne_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  %2 = llvm.or %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem icmp_or_xor_2_ne_proof : icmp_or_xor_2_ne_before ⊑ icmp_or_xor_2_ne_after := by
  sorry



def icmp_or_xor_3_1_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.xor %arg0, %arg1 : i64
  %2 = llvm.xor %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg4, %arg5 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = "llvm.icmp"(%5, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_3_1_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem icmp_or_xor_3_1_proof : icmp_or_xor_3_1_before ⊑ icmp_or_xor_3_1_after := by
  sorry



def icmp_or_xor_3_3_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.xor %arg0, %arg1 : i64
  %2 = llvm.xor %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg4, %arg5 : i64
  %5 = llvm.or %4, %3 : i64
  %6 = "llvm.icmp"(%5, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_3_3_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem icmp_or_xor_3_3_proof : icmp_or_xor_3_3_before ⊑ icmp_or_xor_3_3_after := by
  sorry



def icmp_or_xor_4_1_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64, %arg6 : i64, %arg7 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.xor %arg0, %arg1 : i64
  %2 = llvm.xor %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg4, %arg5 : i64
  %5 = llvm.xor %arg6, %arg7 : i64
  %6 = llvm.or %4, %5 : i64
  %7 = llvm.or %3, %6 : i64
  %8 = "llvm.icmp"(%7, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def icmp_or_xor_4_1_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64, %arg6 : i64, %arg7 : i64):
  %0 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg6, %arg7) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  %5 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
theorem icmp_or_xor_4_1_proof : icmp_or_xor_4_1_before ⊑ icmp_or_xor_4_1_after := by
  sorry



def icmp_or_xor_4_2_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64, %arg6 : i64, %arg7 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.xor %arg0, %arg1 : i64
  %2 = llvm.xor %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg4, %arg5 : i64
  %5 = llvm.xor %arg6, %arg7 : i64
  %6 = llvm.or %4, %5 : i64
  %7 = llvm.or %6, %3 : i64
  %8 = "llvm.icmp"(%7, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def icmp_or_xor_4_2_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64, %arg6 : i64, %arg7 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  %5 = "llvm.icmp"(%arg6, %arg7) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
theorem icmp_or_xor_4_2_proof : icmp_or_xor_4_2_before ⊑ icmp_or_xor_4_2_after := by
  sorry



def icmp_or_sub_2_eq_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.sub %arg0, %arg1 : i64
  %2 = llvm.sub %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_or_sub_2_eq_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem icmp_or_sub_2_eq_proof : icmp_or_sub_2_eq_before ⊑ icmp_or_sub_2_eq_after := by
  sorry



def icmp_or_sub_2_ne_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.sub %arg0, %arg1 : i64
  %2 = llvm.sub %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_or_sub_2_ne_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  %2 = llvm.or %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem icmp_or_sub_2_ne_proof : icmp_or_sub_2_ne_before ⊑ icmp_or_sub_2_ne_after := by
  sorry



def icmp_or_sub_3_1_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.sub %arg0, %arg1 : i64
  %2 = llvm.sub %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg4, %arg5 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = "llvm.icmp"(%5, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_sub_3_1_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem icmp_or_sub_3_1_proof : icmp_or_sub_3_1_before ⊑ icmp_or_sub_3_1_after := by
  sorry



def icmp_or_sub_3_3_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.sub %arg0, %arg1 : i64
  %2 = llvm.sub %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg4, %arg5 : i64
  %5 = llvm.or %4, %3 : i64
  %6 = "llvm.icmp"(%5, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_sub_3_3_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem icmp_or_sub_3_3_proof : icmp_or_sub_3_3_before ⊑ icmp_or_sub_3_3_after := by
  sorry



def icmp_or_sub_4_1_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64, %arg6 : i64, %arg7 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.sub %arg0, %arg1 : i64
  %2 = llvm.sub %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg4, %arg5 : i64
  %5 = llvm.sub %arg6, %arg7 : i64
  %6 = llvm.or %4, %5 : i64
  %7 = llvm.or %3, %6 : i64
  %8 = "llvm.icmp"(%7, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def icmp_or_sub_4_1_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64, %arg6 : i64, %arg7 : i64):
  %0 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg6, %arg7) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  %5 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
theorem icmp_or_sub_4_1_proof : icmp_or_sub_4_1_before ⊑ icmp_or_sub_4_1_after := by
  sorry



def icmp_or_sub_4_2_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64, %arg6 : i64, %arg7 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.sub %arg0, %arg1 : i64
  %2 = llvm.sub %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg4, %arg5 : i64
  %5 = llvm.sub %arg6, %arg7 : i64
  %6 = llvm.or %4, %5 : i64
  %7 = llvm.or %6, %3 : i64
  %8 = "llvm.icmp"(%7, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def icmp_or_sub_4_2_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64, %arg6 : i64, %arg7 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  %5 = "llvm.icmp"(%arg6, %arg7) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
theorem icmp_or_sub_4_2_proof : icmp_or_sub_4_2_before ⊑ icmp_or_sub_4_2_after := by
  sorry



def icmp_or_xor_with_sub_2_eq_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.xor %arg0, %arg1 : i64
  %2 = llvm.sub %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_2_eq_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem icmp_or_xor_with_sub_2_eq_proof : icmp_or_xor_with_sub_2_eq_before ⊑ icmp_or_xor_with_sub_2_eq_after := by
  sorry



def icmp_or_xor_with_sub_2_ne_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.xor %arg0, %arg1 : i64
  %2 = llvm.sub %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_2_ne_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  %2 = llvm.or %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem icmp_or_xor_with_sub_2_ne_proof : icmp_or_xor_with_sub_2_ne_before ⊑ icmp_or_xor_with_sub_2_ne_after := by
  sorry



def icmp_or_xor_with_sub_3_1_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.xor %arg0, %arg1 : i64
  %2 = llvm.xor %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg4, %arg5 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = "llvm.icmp"(%5, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_3_1_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem icmp_or_xor_with_sub_3_1_proof : icmp_or_xor_with_sub_3_1_before ⊑ icmp_or_xor_with_sub_3_1_after := by
  sorry



def icmp_or_xor_with_sub_3_2_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.xor %arg0, %arg1 : i64
  %2 = llvm.sub %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg4, %arg5 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = "llvm.icmp"(%5, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_3_2_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem icmp_or_xor_with_sub_3_2_proof : icmp_or_xor_with_sub_3_2_before ⊑ icmp_or_xor_with_sub_3_2_after := by
  sorry



def icmp_or_xor_with_sub_3_3_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.xor %arg0, %arg1 : i64
  %2 = llvm.sub %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg4, %arg5 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = "llvm.icmp"(%5, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_3_3_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem icmp_or_xor_with_sub_3_3_proof : icmp_or_xor_with_sub_3_3_before ⊑ icmp_or_xor_with_sub_3_3_after := by
  sorry



def icmp_or_xor_with_sub_3_4_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.sub %arg0, %arg1 : i64
  %2 = llvm.xor %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg4, %arg5 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = "llvm.icmp"(%5, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_3_4_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem icmp_or_xor_with_sub_3_4_proof : icmp_or_xor_with_sub_3_4_before ⊑ icmp_or_xor_with_sub_3_4_after := by
  sorry



def icmp_or_xor_with_sub_3_5_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.sub %arg0, %arg1 : i64
  %2 = llvm.xor %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.sub %arg4, %arg5 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = "llvm.icmp"(%5, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_3_5_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem icmp_or_xor_with_sub_3_5_proof : icmp_or_xor_with_sub_3_5_before ⊑ icmp_or_xor_with_sub_3_5_after := by
  sorry



def icmp_or_xor_with_sub_3_6_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.sub %arg0, %arg1 : i64
  %2 = llvm.sub %arg2, %arg3 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.xor %arg4, %arg5 : i64
  %5 = llvm.or %3, %4 : i64
  %6 = "llvm.icmp"(%5, %0) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def icmp_or_xor_with_sub_3_6_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64, %arg2 : i64, %arg3 : i64, %arg4 : i64, %arg5 : i64):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %1 = "llvm.icmp"(%arg2, %arg3) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %2 = llvm.and %0, %1 : i1
  %3 = "llvm.icmp"(%arg4, %arg5) <{"predicate" = 0 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem icmp_or_xor_with_sub_3_6_proof : icmp_or_xor_with_sub_3_6_before ⊑ icmp_or_xor_with_sub_3_6_after := by
  sorry



def or_disjoint_with_constants_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 19 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_disjoint_with_constants_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 18 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem or_disjoint_with_constants_proof : or_disjoint_with_constants_before ⊑ or_disjoint_with_constants_after := by
  sorry


