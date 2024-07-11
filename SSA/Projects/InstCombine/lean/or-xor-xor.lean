
def or_xor_xor_normal_variant1_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.and %arg0, %arg1 : i1
  %1 = llvm.xor %0, %arg0 : i1
  %2 = llvm.xor %0, %arg1 : i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def or_xor_xor_normal_variant1_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.xor %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem or_xor_xor_normal_variant1_proof : or_xor_xor_normal_variant1_before ⊑ or_xor_xor_normal_variant1_after := by
  sorry



def or_xor_xor_normal_variant2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.and %arg0, %arg1 : i8
  %1 = llvm.xor %0, %arg1 : i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.or %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def or_xor_xor_normal_variant2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.xor %arg0, %arg1 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem or_xor_xor_normal_variant2_proof : or_xor_xor_normal_variant2_before ⊑ or_xor_xor_normal_variant2_after := by
  sorry



def or_xor_xor_normal_variant3_before := [llvm|
{
^0(%arg0 : i16, %arg1 : i16):
  %0 = llvm.and %arg1, %arg0 : i16
  %1 = llvm.xor %arg1, %0 : i16
  %2 = llvm.xor %arg0, %0 : i16
  %3 = llvm.or %1, %2 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def or_xor_xor_normal_variant3_after := [llvm|
{
^0(%arg0 : i16, %arg1 : i16):
  %0 = llvm.xor %arg1, %arg0 : i16
  "llvm.return"(%0) : (i16) -> ()
}
]
theorem or_xor_xor_normal_variant3_proof : or_xor_xor_normal_variant3_before ⊑ or_xor_xor_normal_variant3_after := by
  sorry



def or_xor_xor_normal_variant4_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.and %arg1, %arg0 : i64
  %1 = llvm.xor %0, %arg1 : i64
  %2 = llvm.xor %0, %arg0 : i64
  %3 = llvm.or %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def or_xor_xor_normal_variant4_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.xor %arg1, %arg0 : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
theorem or_xor_xor_normal_variant4_proof : or_xor_xor_normal_variant4_before ⊑ or_xor_xor_normal_variant4_after := by
  sorry



def or_xor_xor_normal_binops_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg0, %arg2 : i32
  %1 = llvm.xor %arg1, %arg2 : i32
  %2 = llvm.and %1, %0 : i32
  %3 = llvm.xor %1, %2 : i32
  %4 = llvm.xor %0, %2 : i32
  %5 = llvm.or %3, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def or_xor_xor_normal_binops_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = llvm.xor %arg1, %arg0 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem or_xor_xor_normal_binops_proof : or_xor_xor_normal_binops_before ⊑ or_xor_xor_normal_binops_after := by
  sorry



def or_xor_xor_normal_vector_before := [llvm|
{
^0(%arg0 : vector<3xi1>, %arg1 : vector<3xi1>):
  %0 = llvm.and %arg0, %arg1 : vector<3xi1>
  %1 = llvm.xor %0, %arg1 : vector<3xi1>
  %2 = llvm.xor %0, %arg0 : vector<3xi1>
  %3 = llvm.or %1, %2 : vector<3xi1>
  "llvm.return"(%3) : (vector<3xi1>) -> ()
}
]
def or_xor_xor_normal_vector_after := [llvm|
{
^0(%arg0 : vector<3xi1>, %arg1 : vector<3xi1>):
  %0 = llvm.xor %arg0, %arg1 : vector<3xi1>
  "llvm.return"(%0) : (vector<3xi1>) -> ()
}
]
theorem or_xor_xor_normal_vector_proof : or_xor_xor_normal_vector_before ⊑ or_xor_xor_normal_vector_after := by
  sorry


