
def icmp_ult_x_y_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.and %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def icmp_ult_x_y_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.and %arg0, %arg1 : i8
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_ult_x_y_proof : icmp_ult_x_y_before ⊑ icmp_ult_x_y_after := by
  sorry



def icmp_ult_x_y_2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mul %arg0, %arg0 : i8
  %1 = llvm.and %0, %arg1 : i8
  %2 = "llvm.icmp"(%0, %1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def icmp_ult_x_y_2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mul %arg0, %arg0 : i8
  %1 = llvm.and %0, %arg1 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem icmp_ult_x_y_2_proof : icmp_ult_x_y_2_before ⊑ icmp_ult_x_y_2_after := by
  sorry



def icmp_uge_x_y_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = llvm.and %arg0, %arg1 : vector<2xi8>
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 9 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
def icmp_uge_x_y_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = llvm.and %arg0, %arg1 : vector<2xi8>
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem icmp_uge_x_y_proof : icmp_uge_x_y_before ⊑ icmp_uge_x_y_after := by
  sorry



def icmp_uge_x_y_2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mul %arg0, %arg0 : i8
  %1 = llvm.and %0, %arg1 : i8
  %2 = "llvm.icmp"(%0, %1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def icmp_uge_x_y_2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mul %arg0, %arg0 : i8
  %1 = llvm.and %0, %arg1 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem icmp_uge_x_y_2_proof : icmp_uge_x_y_2_before ⊑ icmp_uge_x_y_2_after := by
  sorry



def icmp_eq_x_invertable_y_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.and %arg0, %1 : i8
  %3 = "llvm.icmp"(%arg0, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_x_invertable_y_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.and %1, %arg0 : i8
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem icmp_eq_x_invertable_y_proof : icmp_eq_x_invertable_y_before ⊑ icmp_eq_x_invertable_y_after := by
  sorry



def icmp_eq_x_invertable_y2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.and %arg0, %1 : i8
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_x_invertable_y2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.and %1, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem icmp_eq_x_invertable_y2_proof : icmp_eq_x_invertable_y2_before ⊑ icmp_eq_x_invertable_y2_after := by
  sorry


