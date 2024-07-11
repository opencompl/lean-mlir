
def shl_and_and_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 88 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.and %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_and_and_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 80 : i8}> : () -> i8
  %2 = llvm.and %arg1, %arg0 : i8
  %3 = llvm.shl %2, %0 : i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_and_and_proof : shl_and_and_before ⊑ shl_and_and_after := by
  sorry



def shl_and_and_fail_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 88 : i8}> : () -> i8
  %3 = llvm.shl %arg0, %0 : i8
  %4 = llvm.shl %arg1, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.and %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_and_and_fail_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 64 : i8}> : () -> i8
  %3 = llvm.shl %arg0, %0 : i8
  %4 = llvm.shl %arg1, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.and %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
theorem shl_and_and_fail_proof : shl_and_and_fail_before ⊑ shl_and_and_fail_after := by
  sorry



def shl_add_add_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 48 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.add %3, %1 : i8
  %5 = llvm.add %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_add_add_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 48 : i8}> : () -> i8
  %2 = llvm.add %arg1, %arg0 : i8
  %3 = llvm.shl %2, %0 : i8
  %4 = llvm.add %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_add_add_proof : shl_add_add_before ⊑ shl_add_add_after := by
  sorry



def shl_and_xor_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 20 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.and %2, %1 : i8
  %5 = llvm.xor %3, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_and_xor_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.xor %2, %arg1 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_and_xor_proof : shl_and_xor_before ⊑ shl_and_xor_after := by
  sorry



def shl_and_add_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 119 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.add %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_and_add_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 59 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = llvm.and %arg1, %0 : i8
  %3 = llvm.add %2, %arg0 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_and_add_proof : shl_and_add_before ⊑ shl_and_add_after := by
  sorry



def shl_xor_xor_no_const_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.shl %arg0, %arg2 : i8
  %1 = llvm.shl %arg1, %arg2 : i8
  %2 = llvm.xor %1, %arg3 : i8
  %3 = llvm.xor %0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_xor_xor_no_const_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.xor %arg1, %arg0 : i8
  %1 = llvm.shl %0, %arg2 : i8
  %2 = llvm.xor %1, %arg3 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem shl_xor_xor_no_const_proof : shl_xor_xor_no_const_before ⊑ shl_xor_xor_no_const_after := by
  sorry



def shl_and_and_no_const_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>, %arg2 : vector<2xi8>, %arg3 : vector<2xi8>):
  %0 = llvm.shl %arg0, %arg2 : vector<2xi8>
  %1 = llvm.shl %arg1, %arg2 : vector<2xi8>
  %2 = llvm.and %1, %arg3 : vector<2xi8>
  %3 = llvm.and %0, %2 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
def shl_and_and_no_const_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>, %arg2 : vector<2xi8>, %arg3 : vector<2xi8>):
  %0 = llvm.and %arg1, %arg0 : vector<2xi8>
  %1 = llvm.shl %0, %arg2 : vector<2xi8>
  %2 = llvm.and %1, %arg3 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
theorem shl_and_and_no_const_proof : shl_and_and_no_const_before ⊑ shl_and_and_no_const_after := by
  sorry



def shl_add_add_no_const_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.shl %arg0, %arg2 : i8
  %1 = llvm.shl %arg1, %arg2 : i8
  %2 = llvm.add %1, %arg3 : i8
  %3 = llvm.add %0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_add_add_no_const_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8, %arg3 : i8):
  %0 = llvm.add %arg1, %arg0 : i8
  %1 = llvm.shl %0, %arg2 : i8
  %2 = llvm.add %1, %arg3 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem shl_add_add_no_const_proof : shl_add_add_no_const_before ⊑ shl_add_add_no_const_after := by
  sorry



def shl_or_or_good_mask_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[18, 24]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.shl %arg0, %0 : vector<2xi8>
  %3 = llvm.shl %arg1, %0 : vector<2xi8>
  %4 = llvm.or %3, %1 : vector<2xi8>
  %5 = llvm.or %2, %4 : vector<2xi8>
  "llvm.return"(%5) : (vector<2xi8>) -> ()
}
]
def shl_or_or_good_mask_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[18, 24]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.or %arg1, %arg0 : vector<2xi8>
  %3 = llvm.shl %2, %0 : vector<2xi8>
  %4 = llvm.or %3, %1 : vector<2xi8>
  "llvm.return"(%4) : (vector<2xi8>) -> ()
}
]
theorem shl_or_or_good_mask_proof : shl_or_or_good_mask_before ⊑ shl_or_or_good_mask_after := by
  sorry



def shl_or_or_fail_bad_mask_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[19, 24]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.shl %arg0, %0 : vector<2xi8>
  %3 = llvm.shl %arg1, %0 : vector<2xi8>
  %4 = llvm.or %3, %1 : vector<2xi8>
  %5 = llvm.or %2, %4 : vector<2xi8>
  "llvm.return"(%5) : (vector<2xi8>) -> ()
}
]
def shl_or_or_fail_bad_mask_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[19, 24]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.or %arg1, %arg0 : vector<2xi8>
  %3 = llvm.shl %2, %0 : vector<2xi8>
  %4 = llvm.or %3, %1 : vector<2xi8>
  "llvm.return"(%4) : (vector<2xi8>) -> ()
}
]
theorem shl_or_or_fail_bad_mask_proof : shl_or_or_fail_bad_mask_before ⊑ shl_or_or_fail_bad_mask_after := by
  sorry



def shl_xor_xor_good_mask_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 88 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.xor %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_xor_xor_good_mask_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 88 : i8}> : () -> i8
  %2 = llvm.xor %arg1, %arg0 : i8
  %3 = llvm.shl %2, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_xor_xor_good_mask_proof : shl_xor_xor_good_mask_before ⊑ shl_xor_xor_good_mask_after := by
  sorry



def shl_xor_xor_bad_mask_distribute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -68 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.xor %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_xor_xor_bad_mask_distribute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -68 : i8}> : () -> i8
  %2 = llvm.xor %arg1, %arg0 : i8
  %3 = llvm.shl %2, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_xor_xor_bad_mask_distribute_proof : shl_xor_xor_bad_mask_distribute_before ⊑ shl_xor_xor_bad_mask_distribute_after := by
  sorry



def shl_add_and_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 123 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %0 : i8
  %4 = llvm.add %3, %1 : i8
  %5 = llvm.and %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_add_and_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 61 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = llvm.add %arg1, %0 : i8
  %3 = llvm.and %2, %arg0 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_add_and_proof : shl_add_and_before ⊑ shl_add_and_after := by
  sorry



def lshr_and_add_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[4, 5]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[-67, 123]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.shl %arg0, %0 : vector<2xi8>
  %3 = llvm.shl %arg1, %0 : vector<2xi8>
  %4 = llvm.and %2, %1 : vector<2xi8>
  %5 = llvm.add %3, %4 : vector<2xi8>
  "llvm.return"(%5) : (vector<2xi8>) -> ()
}
]
def lshr_and_add_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[11, 3]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[4, 5]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.and %arg0, %0 : vector<2xi8>
  %3 = llvm.add %2, %arg1 : vector<2xi8>
  %4 = llvm.shl %3, %1 : vector<2xi8>
  "llvm.return"(%4) : (vector<2xi8>) -> ()
}
]
theorem lshr_and_add_proof : lshr_and_add_before ⊑ lshr_and_add_after := by
  sorry


