
def dec_mask_neg_i32_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def dec_mask_neg_i32_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem dec_mask_neg_i32_proof : dec_mask_neg_i32_before ⊑ dec_mask_neg_i32_after := by
  sorry



def dec_commute_mask_neg_i32_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.and %2, %arg0 : i32
  %4 = llvm.add %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def dec_commute_mask_neg_i32_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.and %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem dec_commute_mask_neg_i32_proof : dec_commute_mask_neg_i32_before ⊑ dec_commute_mask_neg_i32_after := by
  sorry



def dec_mask_neg_v2i32_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = llvm.sub %1, %arg0 : vector<2xi32>
  %4 = llvm.and %3, %arg0 : vector<2xi32>
  %5 = llvm.add %4, %2 : vector<2xi32>
  "llvm.return"(%5) : (vector<2xi32>) -> ()
}
]
def dec_mask_neg_v2i32_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.add %arg0, %0 : vector<2xi32>
  %2 = llvm.xor %arg0, %0 : vector<2xi32>
  %3 = llvm.and %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem dec_mask_neg_v2i32_proof : dec_mask_neg_v2i32_before ⊑ dec_mask_neg_v2i32_after := by
  sorry


