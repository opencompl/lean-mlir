
def add_or_sub_comb_i32_commuted1_nuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  %2 = llvm.or %1, %arg0 : i32
  %3 = llvm.add %2, %arg0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_or_sub_comb_i32_commuted1_nuw_after := [llvm|
{
^0(%arg0 : i32):
  "llvm.return"(%arg0) : (i32) -> ()
}
]
theorem add_or_sub_comb_i32_commuted1_nuw_proof : add_or_sub_comb_i32_commuted1_nuw_before ⊑ add_or_sub_comb_i32_commuted1_nuw_after := by
  sorry



def add_or_sub_comb_i8_commuted2_nsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.mul %arg0, %arg0 : i8
  %2 = llvm.sub %0, %1 : i8
  %3 = llvm.or %2, %1 : i8
  %4 = llvm.add %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def add_or_sub_comb_i8_commuted2_nsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.mul %arg0, %arg0 : i8
  %2 = llvm.add %1, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem add_or_sub_comb_i8_commuted2_nsw_proof : add_or_sub_comb_i8_commuted2_nsw_before ⊑ add_or_sub_comb_i8_commuted2_nsw_after := by
  sorry



def add_or_sub_comb_i128_commuted3_nuw_nsw_before := [llvm|
{
^0(%arg0 : i128):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i128}> : () -> i128
  %1 = llvm.mul %arg0, %arg0 : i128
  %2 = llvm.sub %0, %1 : i128
  %3 = llvm.or %1, %2 : i128
  %4 = llvm.add %3, %1 : i128
  "llvm.return"(%4) : (i128) -> ()
}
]
def add_or_sub_comb_i128_commuted3_nuw_nsw_after := [llvm|
{
^0(%arg0 : i128):
  %0 = llvm.mul %arg0, %arg0 : i128
  "llvm.return"(%0) : (i128) -> ()
}
]
theorem add_or_sub_comb_i128_commuted3_nuw_nsw_proof : add_or_sub_comb_i128_commuted3_nuw_nsw_before ⊑ add_or_sub_comb_i128_commuted3_nuw_nsw_after := by
  sorry



def add_or_sub_comb_i64_commuted4_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = llvm.mul %arg0, %arg0 : i64
  %2 = llvm.sub %0, %1 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.add %1, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def add_or_sub_comb_i64_commuted4_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i64}> : () -> i64
  %1 = llvm.mul %arg0, %arg0 : i64
  %2 = llvm.add %1, %0 : i64
  %3 = llvm.and %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
theorem add_or_sub_comb_i64_commuted4_proof : add_or_sub_comb_i64_commuted4_before ⊑ add_or_sub_comb_i64_commuted4_after := by
  sorry



def add_or_sub_comb_i32vec_before := [llvm|
{
^0(%arg0 : vector<3xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
  %2 = llvm.mul %arg0, %arg0 : vector<3xi32>
  %3 = llvm.sub %1, %2 : vector<3xi32>
  %4 = llvm.or %3, %2 : vector<3xi32>
  %5 = llvm.add %4, %2 : vector<3xi32>
  "llvm.return"(%5) : (vector<3xi32>) -> ()
}
]
def add_or_sub_comb_i32vec_after := [llvm|
{
^0(%arg0 : vector<3xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<3xi32>}> : () -> vector<3xi32>
  %1 = llvm.mul %arg0, %arg0 : vector<3xi32>
  %2 = llvm.add %1, %0 : vector<3xi32>
  %3 = llvm.and %2, %1 : vector<3xi32>
  "llvm.return"(%3) : (vector<3xi32>) -> ()
}
]
theorem add_or_sub_comb_i32vec_proof : add_or_sub_comb_i32vec_before ⊑ add_or_sub_comb_i32vec_after := by
  sorry


