
def t0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -42 : i8}> : () -> i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  sorry



def t2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -42 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.sub %arg0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = llvm.shl %0, %arg1 : i8
  %2 = llvm.add %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t2_proof : t2_before ⊑ t2_after := by
  sorry



def t9_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %arg1, %arg0 : i8
  %2 = llvm.sub %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t9_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem t9_proof : t9_before ⊑ t9_after := by
  sorry



def neg_of_sub_from_constant_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def neg_of_sub_from_constant_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -42 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem neg_of_sub_from_constant_proof : neg_of_sub_from_constant_before ⊑ neg_of_sub_from_constant_after := by
  sorry



def sub_from_constant_of_sub_from_constant_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 11 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def sub_from_constant_of_sub_from_constant_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -31 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem sub_from_constant_of_sub_from_constant_proof : sub_from_constant_of_sub_from_constant_before ⊑ sub_from_constant_of_sub_from_constant_after := by
  sorry



def sub_from_variable_of_sub_from_constant_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = llvm.sub %arg1, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sub_from_variable_of_sub_from_constant_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -42 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = llvm.add %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem sub_from_variable_of_sub_from_constant_proof : sub_from_variable_of_sub_from_constant_before ⊑ sub_from_variable_of_sub_from_constant_after := by
  sorry



def neg_of_add_with_constant_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def neg_of_add_with_constant_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -42 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem neg_of_add_with_constant_proof : neg_of_add_with_constant_before ⊑ neg_of_add_with_constant_after := by
  sorry



def sub_from_constant_of_add_with_constant_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 11 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def sub_from_constant_of_add_with_constant_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -31 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem sub_from_constant_of_add_with_constant_proof : sub_from_constant_of_add_with_constant_before ⊑ sub_from_constant_of_add_with_constant_after := by
  sorry



def negate_xor_before := [llvm|
{
^0(%arg0 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.sub %1, %2 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def negate_xor_after := [llvm|
{
^0(%arg0 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -6 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.add %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem negate_xor_proof : negate_xor_before ⊑ negate_xor_after := by
  sorry



def negate_xor_vec_before := [llvm|
{
^0(%arg0 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -6 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 5 : i4}> : () -> i4
  %2 = "llvm.mlir.constant"() <{"value" = dense<[5, -6]> : vector<2xi4>}> : () -> vector<2xi4>
  %3 = "llvm.mlir.constant"() <{"value" = 0 : i4}> : () -> i4
  %4 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi4>}> : () -> vector<2xi4>
  %5 = llvm.xor %arg0, %2 : vector<2xi4>
  %6 = llvm.sub %4, %5 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
def negate_xor_vec_after := [llvm|
{
^0(%arg0 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = -6 : i4}> : () -> i4
  %2 = "llvm.mlir.constant"() <{"value" = dense<[-6, 5]> : vector<2xi4>}> : () -> vector<2xi4>
  %3 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %4 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi4>}> : () -> vector<2xi4>
  %5 = llvm.xor %arg0, %2 : vector<2xi4>
  %6 = llvm.add %5, %4 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
theorem negate_xor_vec_proof : negate_xor_vec_before ⊑ negate_xor_vec_after := by
  sorry



def negate_shl_xor_before := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.shl %2, %arg1 : i4
  %4 = llvm.sub %1, %3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def negate_shl_xor_after := [llvm|
{
^0(%arg0 : i4, %arg1 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -6 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i4}> : () -> i4
  %2 = llvm.xor %arg0, %0 : i4
  %3 = llvm.add %2, %1 : i4
  %4 = llvm.shl %3, %arg1 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
theorem negate_shl_xor_proof : negate_shl_xor_before ⊑ negate_shl_xor_after := by
  sorry



def negation_of_increment_via_or_with_no_common_bits_set_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = llvm.shl %arg1, %0 : i8
  %2 = llvm.or %1, %0 : i8
  %3 = llvm.sub %arg0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def negation_of_increment_via_or_with_no_common_bits_set_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.shl %arg1, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.add %3, %arg0 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem negation_of_increment_via_or_with_no_common_bits_set_proof : negation_of_increment_via_or_with_no_common_bits_set_before ⊑ negation_of_increment_via_or_with_no_common_bits_set_after := by
  sorry



def negate_add_with_single_negatible_operand_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def negate_add_with_single_negatible_operand_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -42 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem negate_add_with_single_negatible_operand_proof : negate_add_with_single_negatible_operand_before ⊑ negate_add_with_single_negatible_operand_after := by
  sorry



def negate_add_with_single_negatible_operand_depth2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.mul %2, %arg1 : i8
  %4 = llvm.sub %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def negate_add_with_single_negatible_operand_depth2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -21 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = llvm.mul %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem negate_add_with_single_negatible_operand_depth2_proof : negate_add_with_single_negatible_operand_depth2_before ⊑ negate_add_with_single_negatible_operand_depth2_after := by
  sorry


