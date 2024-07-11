
def test_nuw_and_unsigned_pred_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_nuw_and_unsigned_pred_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i64}> : () -> i64
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i64, i64) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_nuw_and_unsigned_pred_proof : test_nuw_and_unsigned_pred_before ⊑ test_nuw_and_unsigned_pred_after := by
  sorry



def test_nsw_and_signed_pred_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 10 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_nsw_and_signed_pred_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -7 : i64}> : () -> i64
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i64, i64) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_nsw_and_signed_pred_proof : test_nsw_and_signed_pred_before ⊑ test_nsw_and_signed_pred_after := by
  sorry



def test_nuw_nsw_and_unsigned_pred_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 7 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_nuw_nsw_and_unsigned_pred_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i64}> : () -> i64
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i64, i64) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_nuw_nsw_and_unsigned_pred_proof : test_nuw_nsw_and_unsigned_pred_before ⊑ test_nuw_nsw_and_unsigned_pred_after := by
  sorry



def test_nuw_nsw_and_signed_pred_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_nuw_nsw_and_signed_pred_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i64}> : () -> i64
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i64, i64) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_nuw_nsw_and_signed_pred_proof : test_nuw_nsw_and_signed_pred_before ⊑ test_nuw_nsw_and_signed_pred_after := by
  sorry



def test_negative_nuw_and_signed_pred_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_negative_nuw_and_signed_pred_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -11 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = -4 : i64}> : () -> i64
  %2 = llvm.add %arg0, %0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem test_negative_nuw_and_signed_pred_proof : test_negative_nuw_and_signed_pred_before ⊑ test_negative_nuw_and_signed_pred_after := by
  sorry



def test_negative_nsw_and_unsigned_pred_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_negative_nsw_and_unsigned_pred_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -8 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i64}> : () -> i64
  %2 = llvm.add %arg0, %0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem test_negative_nsw_and_unsigned_pred_proof : test_negative_nsw_and_unsigned_pred_before ⊑ test_negative_nsw_and_unsigned_pred_after := by
  sorry



def test_negative_combined_sub_unsigned_overflow_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 11 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_negative_combined_sub_unsigned_overflow_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test_negative_combined_sub_unsigned_overflow_proof : test_negative_combined_sub_unsigned_overflow_before ⊑ test_negative_combined_sub_unsigned_overflow_after := by
  sorry



def test_negative_combined_sub_signed_overflow_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_negative_combined_sub_signed_overflow_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test_negative_combined_sub_signed_overflow_proof : test_negative_combined_sub_signed_overflow_before ⊑ test_negative_combined_sub_signed_overflow_after := by
  sorry



def test_sub_0_Y_eq_0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_sub_0_Y_eq_0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_sub_0_Y_eq_0_proof : test_sub_0_Y_eq_0_before ⊑ test_sub_0_Y_eq_0_after := by
  sorry



def test_sub_0_Y_ne_0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_sub_0_Y_ne_0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_sub_0_Y_ne_0_proof : test_sub_0_Y_ne_0_before ⊑ test_sub_0_Y_ne_0_after := by
  sorry



def test_sub_4_Y_ne_4_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_sub_4_Y_ne_4_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_sub_4_Y_ne_4_proof : test_sub_4_Y_ne_4_before ⊑ test_sub_4_Y_ne_4_after := by
  sorry



def test_sub_127_Y_eq_127_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_sub_127_Y_eq_127_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_sub_127_Y_eq_127_proof : test_sub_127_Y_eq_127_before ⊑ test_sub_127_Y_eq_127_after := by
  sorry



def test_sub_255_Y_eq_255_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test_sub_255_Y_eq_255_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_sub_255_Y_eq_255_proof : test_sub_255_Y_eq_255_before ⊑ test_sub_255_Y_eq_255_after := by
  sorry



def test_sub_255_Y_eq_255_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.sub %0, %arg0 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def test_sub_255_Y_eq_255_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem test_sub_255_Y_eq_255_vec_proof : test_sub_255_Y_eq_255_vec_before ⊑ test_sub_255_Y_eq_255_vec_after := by
  sorry



def icmp_eq_sub_non_splat_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[15, 16]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<10> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.sub %0, %arg0 : vector<2xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def icmp_eq_sub_non_splat_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[5, 6]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem icmp_eq_sub_non_splat_proof : icmp_eq_sub_non_splat_before ⊑ icmp_eq_sub_non_splat_after := by
  sorry



def neg_sgt_42_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 42 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_sgt_42_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -43 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem neg_sgt_42_proof : neg_sgt_42_before ⊑ neg_sgt_42_after := by
  sorry



def neg_slt_42_before := [llvm|
{
^0(%arg0 : i128):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i128}> : () -> i128
  %1 = "llvm.mlir.constant"() <{"value" = 42 : i128}> : () -> i128
  %2 = llvm.sub %0, %arg0 : i128
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i128, i128) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_slt_42_after := [llvm|
{
^0(%arg0 : i128):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i128}> : () -> i128
  %1 = "llvm.mlir.constant"() <{"value" = -43 : i128}> : () -> i128
  %2 = llvm.add %arg0, %0 : i128
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i128, i128) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem neg_slt_42_proof : neg_slt_42_before ⊑ neg_slt_42_after := by
  sorry



def neg_ugt_42_splat_before := [llvm|
{
^0(%arg0 : vector<2xi7>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i7}> : () -> i7
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi7>}> : () -> vector<2xi7>
  %2 = "llvm.mlir.constant"() <{"value" = 42 : i7}> : () -> i7
  %3 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi7>}> : () -> vector<2xi7>
  %4 = llvm.sub %1, %arg0 : vector<2xi7>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 8 : i64}> : (vector<2xi7>, vector<2xi7>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def neg_ugt_42_splat_after := [llvm|
{
^0(%arg0 : vector<2xi7>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i7}> : () -> i7
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi7>}> : () -> vector<2xi7>
  %2 = "llvm.mlir.constant"() <{"value" = -43 : i7}> : () -> i7
  %3 = "llvm.mlir.constant"() <{"value" = dense<-43> : vector<2xi7>}> : () -> vector<2xi7>
  %4 = llvm.add %arg0, %1 : vector<2xi7>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 6 : i64}> : (vector<2xi7>, vector<2xi7>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
theorem neg_ugt_42_splat_proof : neg_ugt_42_splat_before ⊑ neg_ugt_42_splat_after := by
  sorry



def neg_slt_n1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_slt_n1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem neg_slt_n1_proof : neg_slt_n1_before ⊑ neg_slt_n1_after := by
  sorry



def neg_slt_0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def neg_slt_0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem neg_slt_0_proof : neg_slt_0_before ⊑ neg_slt_0_after := by
  sorry



def neg_slt_1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_slt_1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem neg_slt_1_proof : neg_slt_1_before ⊑ neg_slt_1_after := by
  sorry



def neg_sgt_n1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_sgt_n1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem neg_sgt_n1_proof : neg_sgt_n1_before ⊑ neg_sgt_n1_after := by
  sorry



def neg_sgt_0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def neg_sgt_0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem neg_sgt_0_proof : neg_sgt_0_before ⊑ neg_sgt_0_after := by
  sorry



def neg_sgt_1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_sgt_1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem neg_sgt_1_proof : neg_sgt_1_before ⊑ neg_sgt_1_after := by
  sorry



def neg_nsw_slt_n1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_nsw_slt_n1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem neg_nsw_slt_n1_proof : neg_nsw_slt_n1_before ⊑ neg_nsw_slt_n1_after := by
  sorry



def neg_nsw_slt_0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def neg_nsw_slt_0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem neg_nsw_slt_0_proof : neg_nsw_slt_0_before ⊑ neg_nsw_slt_0_after := by
  sorry



def neg_nsw_slt_1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_nsw_slt_1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem neg_nsw_slt_1_proof : neg_nsw_slt_1_before ⊑ neg_nsw_slt_1_after := by
  sorry



def neg_nsw_sgt_n1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_nsw_sgt_n1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem neg_nsw_sgt_n1_proof : neg_nsw_sgt_n1_before ⊑ neg_nsw_sgt_n1_after := by
  sorry



def neg_nsw_sgt_0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def neg_nsw_sgt_0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem neg_nsw_sgt_0_proof : neg_nsw_sgt_0_before ⊑ neg_nsw_sgt_0_after := by
  sorry



def neg_nsw_sgt_1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def neg_nsw_sgt_1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem neg_nsw_sgt_1_proof : neg_nsw_sgt_1_before ⊑ neg_nsw_sgt_1_after := by
  sorry



def PR60818_ne_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def PR60818_ne_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem PR60818_ne_proof : PR60818_ne_before ⊑ PR60818_ne_after := by
  sorry



def PR60818_eq_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def PR60818_eq_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem PR60818_eq_proof : PR60818_eq_before ⊑ PR60818_eq_after := by
  sorry



def PR60818_eq_commuted_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 43 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.mul %arg0, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  %4 = "llvm.icmp"(%2, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR60818_eq_commuted_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 43 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %3 = llvm.mul %arg0, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem PR60818_eq_commuted_proof : PR60818_eq_commuted_before ⊑ PR60818_eq_commuted_after := by
  sorry



def PR60818_ne_vector_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.sub %1, %arg0 : vector<2xi32>
  %3 = "llvm.icmp"(%arg0, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def PR60818_ne_vector_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2147483647> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = llvm.and %arg0, %0 : vector<2xi32>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
theorem PR60818_ne_vector_proof : PR60818_ne_vector_before ⊑ PR60818_ne_vector_after := by
  sorry


