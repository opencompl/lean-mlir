
def or_ugt_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def or_ugt_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.or %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem or_ugt_proof : or_ugt_before ⊑ or_ugt_after := by
  sorry



def or_ule_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = llvm.or %arg0, %arg1 : vector<2xi8>
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 7 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
def or_ule_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = llvm.or %arg0, %arg1 : vector<2xi8>
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem or_ule_proof : or_ule_before ⊑ or_ule_after := by
  sorry



def or_eq_notY_eq_0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.or %arg0, %1 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_eq_notY_eq_0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.and %arg0, %arg1 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem or_eq_notY_eq_0_proof : or_eq_notY_eq_0_before ⊑ or_eq_notY_eq_0_after := by
  sorry



def or_ne_notY_eq_1s_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.or %arg0, %1 : i8
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_ne_notY_eq_1s_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.or %arg0, %arg1 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem or_ne_notY_eq_1s_proof : or_ne_notY_eq_1s_before ⊑ or_ne_notY_eq_1s_after := by
  sorry



def or_ne_notY_eq_1s_fail_bad_not_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.or %arg0, %1 : i8
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_ne_notY_eq_1s_fail_bad_not_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.xor %arg1, %0 : i8
  %3 = llvm.or %2, %arg0 : i8
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem or_ne_notY_eq_1s_fail_bad_not_proof : or_ne_notY_eq_1s_fail_bad_not_before ⊑ or_ne_notY_eq_1s_fail_bad_not_after := by
  sorry



def or_ne_vecC_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[9, 42]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.or %arg0, %0 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def or_ne_vecC_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-10, -43]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.and %arg0, %0 : vector<2xi8>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
theorem or_ne_vecC_proof : or_ne_vecC_before ⊑ or_ne_vecC_after := by
  sorry



def or_simplify_ule_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = llvm.and %arg1, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_simplify_ule_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = llvm.and %arg1, %0 : i8
  %3 = llvm.or %arg0, %arg1 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem or_simplify_ule_proof : or_simplify_ule_before ⊑ or_simplify_ule_after := by
  sorry



def or_simplify_uge_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = -127 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = llvm.and %arg1, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = "llvm.icmp"(%3, %4) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_simplify_uge_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem or_simplify_uge_proof : or_simplify_uge_before ⊑ or_simplify_uge_after := by
  sorry



def or_simplify_ule_fail_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 64 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = llvm.and %arg1, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_simplify_ule_fail_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 64 : i8}> : () -> i8
  %2 = llvm.and %arg1, %0 : i8
  %3 = llvm.or %2, %arg0 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem or_simplify_ule_fail_proof : or_simplify_ule_fail_before ⊑ or_simplify_ule_fail_after := by
  sorry



def or_simplify_ugt_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = llvm.and %arg1, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_simplify_ugt_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = llvm.and %arg1, %0 : i8
  %3 = llvm.or %arg0, %arg1 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem or_simplify_ugt_proof : or_simplify_ugt_before ⊑ or_simplify_ugt_after := by
  sorry



def or_simplify_ult_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 36 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -5 : i8}> : () -> i8
  %2 = llvm.or %arg0, %0 : i8
  %3 = llvm.and %arg1, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = "llvm.icmp"(%3, %4) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_simplify_ult_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 36 : i8}> : () -> i8
  %2 = llvm.and %arg1, %0 : i8
  %3 = llvm.or %arg0, %arg1 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = "llvm.icmp"(%2, %4) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem or_simplify_ult_proof : or_simplify_ult_before ⊑ or_simplify_ult_after := by
  sorry



def or_simplify_ugt_fail_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.or %arg1, %1 : i8
  %4 = llvm.or %2, %3 : i8
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def or_simplify_ugt_fail_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = llvm.or %arg1, %0 : i8
  %2 = llvm.or %1, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem or_simplify_ugt_fail_proof : or_simplify_ugt_fail_before ⊑ or_simplify_ugt_fail_after := by
  sorry



def icmp_eq_x_invertable_y2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.or %arg0, %1 : i8
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_x_invertable_y2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.and %arg0, %arg1 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem icmp_eq_x_invertable_y2_proof : icmp_eq_x_invertable_y2_before ⊑ icmp_eq_x_invertable_y2_after := by
  sorry



def PR38139_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -64 : i8}> : () -> i8
  %1 = llvm.or %arg0, %0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def PR38139_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -64 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem PR38139_proof : PR38139_before ⊑ PR38139_after := by
  sorry


