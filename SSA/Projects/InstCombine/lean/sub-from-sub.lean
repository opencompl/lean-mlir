
def t0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  sorry



def t1_flags_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_proof : t1_flags_before ⊑ t1_flags_after := by
  sorry



def t1_flags_nuw_only_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_only_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_nuw_only_proof : t1_flags_nuw_only_before ⊑ t1_flags_nuw_only_after := by
  sorry



def t1_flags_sub_nsw_sub_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_sub_nsw_sub_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_sub_nsw_sub_proof : t1_flags_sub_nsw_sub_before ⊑ t1_flags_sub_nsw_sub_after := by
  sorry



def t1_flags_nuw_first_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_first_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_nuw_first_proof : t1_flags_nuw_first_before ⊑ t1_flags_nuw_first_after := by
  sorry



def t1_flags_nuw_second_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_second_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_nuw_second_proof : t1_flags_nuw_second_before ⊑ t1_flags_nuw_second_after := by
  sorry



def t1_flags_nuw_nsw_first_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_nsw_first_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_nuw_nsw_first_proof : t1_flags_nuw_nsw_first_before ⊑ t1_flags_nuw_nsw_first_after := by
  sorry



def t1_flags_nuw_nsw_second_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  %1 = llvm.sub %0, %arg2 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_nsw_second_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.add %arg1, %arg2 : i8
  %1 = llvm.sub %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t1_flags_nuw_nsw_second_proof : t1_flags_nuw_nsw_second_before ⊑ t1_flags_nuw_nsw_second_after := by
  sorry



def t3_c0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = llvm.sub %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t3_c0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = llvm.add %arg0, %arg1 : i8
  %2 = llvm.sub %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t3_c0_proof : t3_c0_before ⊑ t3_c0_after := by
  sorry



def t4_c1_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = llvm.sub %arg0, %0 : i8
  %2 = llvm.sub %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t4_c1_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -42 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = llvm.sub %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t4_c1_proof : t4_c1_before ⊑ t4_c1_after := by
  sorry



def t5_c2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = llvm.sub %arg0, %arg1 : i8
  %2 = llvm.sub %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t5_c2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -42 : i8}> : () -> i8
  %1 = llvm.sub %arg0, %arg1 : i8
  %2 = llvm.add %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t5_c2_proof : t5_c2_before ⊑ t5_c2_after := by
  sorry



def t9_c0_c2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 24 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg0 : i8
  %3 = llvm.sub %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t9_c0_c2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 18 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t9_c0_c2_proof : t9_c0_c2_before ⊑ t9_c0_c2_after := by
  sorry



def t10_c1_c2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 24 : i8}> : () -> i8
  %2 = llvm.sub %arg0, %0 : i8
  %3 = llvm.sub %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t10_c1_c2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -66 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem t10_c1_c2_proof : t10_c1_c2_before ⊑ t10_c1_c2_after := by
  sorry


