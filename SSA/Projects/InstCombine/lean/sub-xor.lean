
def low_mask_nsw_nuw_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 63 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def low_mask_nsw_nuw_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 63 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem low_mask_nsw_nuw_proof : low_mask_nsw_nuw_before ⊑ low_mask_nsw_nuw_after := by
  sorry



def low_mask_nsw_nuw_vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<31> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<63> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.and %arg0, %0 : vector<2xi32>
  %3 = llvm.sub %1, %2 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
def low_mask_nsw_nuw_vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<31> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<63> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.and %arg0, %0 : vector<2xi32>
  %3 = llvm.xor %2, %1 : vector<2xi32>
  "llvm.return"(%3) : (vector<2xi32>) -> ()
}
]
theorem low_mask_nsw_nuw_vec_proof : low_mask_nsw_nuw_vec_before ⊑ low_mask_nsw_nuw_vec_after := by
  sorry



def xor_add_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 42 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def xor_add_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 31 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 73 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
theorem xor_add_proof : xor_add_before ⊑ xor_add_after := by
  sorry



def xor_add_splat_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<24> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<63> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.and %arg0, %0 : vector<2xi8>
  %4 = llvm.xor %3, %1 : vector<2xi8>
  %5 = llvm.add %4, %2 : vector<2xi8>
  "llvm.return"(%5) : (vector<2xi8>) -> ()
}
]
def xor_add_splat_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<24> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<105> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.and %arg0, %0 : vector<2xi8>
  %3 = llvm.sub %1, %2 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
theorem xor_add_splat_proof : xor_add_splat_before ⊑ xor_add_splat_after := by
  sorry


