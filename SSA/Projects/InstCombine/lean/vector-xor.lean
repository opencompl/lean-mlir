
def test_v4i32_xor_repeated_and_0_before := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>, %arg2 : vector<4xi32>):
  %0 = llvm.and %arg0, %arg1 : vector<4xi32>
  %1 = llvm.and %arg0, %arg2 : vector<4xi32>
  %2 = llvm.xor %0, %1 : vector<4xi32>
  "llvm.return"(%2) : (vector<4xi32>) -> ()
}
]
def test_v4i32_xor_repeated_and_0_after := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>, %arg2 : vector<4xi32>):
  %0 = llvm.xor %arg1, %arg2 : vector<4xi32>
  %1 = llvm.and %0, %arg0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem test_v4i32_xor_repeated_and_0_proof : test_v4i32_xor_repeated_and_0_before ⊑ test_v4i32_xor_repeated_and_0_after := by
  sorry



def test_v4i32_xor_repeated_and_1_before := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>, %arg2 : vector<4xi32>):
  %0 = llvm.and %arg0, %arg1 : vector<4xi32>
  %1 = llvm.and %arg2, %arg0 : vector<4xi32>
  %2 = llvm.xor %0, %1 : vector<4xi32>
  "llvm.return"(%2) : (vector<4xi32>) -> ()
}
]
def test_v4i32_xor_repeated_and_1_after := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>, %arg2 : vector<4xi32>):
  %0 = llvm.xor %arg1, %arg2 : vector<4xi32>
  %1 = llvm.and %0, %arg0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem test_v4i32_xor_repeated_and_1_proof : test_v4i32_xor_repeated_and_1_before ⊑ test_v4i32_xor_repeated_and_1_after := by
  sorry



def test_v4i32_demorgan_and_before := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.xor %0, %arg0 : vector<4xi32>
  %2 = llvm.and %1, %arg1 : vector<4xi32>
  %3 = llvm.xor %0, %2 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def test_v4i32_demorgan_and_after := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.xor %arg1, %0 : vector<4xi32>
  %2 = llvm.or %1, %arg0 : vector<4xi32>
  "llvm.return"(%2) : (vector<4xi32>) -> ()
}
]
theorem test_v4i32_demorgan_and_proof : test_v4i32_demorgan_and_before ⊑ test_v4i32_demorgan_and_after := by
  sorry



def test_v4i32_demorgan_or_before := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.xor %0, %arg0 : vector<4xi32>
  %2 = llvm.or %1, %arg1 : vector<4xi32>
  %3 = llvm.xor %0, %2 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def test_v4i32_demorgan_or_after := [llvm|
{
^0(%arg0 : vector<4xi32>, %arg1 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.xor %arg1, %0 : vector<4xi32>
  %2 = llvm.and %1, %arg0 : vector<4xi32>
  "llvm.return"(%2) : (vector<4xi32>) -> ()
}
]
theorem test_v4i32_demorgan_or_proof : test_v4i32_demorgan_or_before ⊑ test_v4i32_demorgan_or_after := by
  sorry



def test_v4i32_not_sub_splatconst_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.sub %0, %arg0 : vector<4xi32>
  %3 = llvm.xor %1, %2 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def test_v4i32_not_sub_splatconst_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-4> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.add %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem test_v4i32_not_sub_splatconst_proof : test_v4i32_not_sub_splatconst_before ⊑ test_v4i32_not_sub_splatconst_after := by
  sorry



def test_v4i32_not_sub_const_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[3, 5, -1, 15]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.sub %0, %arg0 : vector<4xi32>
  %3 = llvm.xor %1, %2 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def test_v4i32_not_sub_const_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-4, -6, 0, -16]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.add %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem test_v4i32_not_sub_const_proof : test_v4i32_not_sub_const_before ⊑ test_v4i32_not_sub_const_after := by
  sorry



def test_v4i32_xor_signmask_sub_splatconst_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.sub %0, %arg0 : vector<4xi32>
  %3 = llvm.xor %1, %2 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def test_v4i32_xor_signmask_sub_splatconst_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483645> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.sub %0, %arg0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem test_v4i32_xor_signmask_sub_splatconst_proof : test_v4i32_xor_signmask_sub_splatconst_before ⊑ test_v4i32_xor_signmask_sub_splatconst_after := by
  sorry



def test_v4i32_xor_signmask_sub_const_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[3, 5, -1, 15]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.sub %0, %arg0 : vector<4xi32>
  %3 = llvm.xor %1, %2 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def test_v4i32_xor_signmask_sub_const_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[3, 5, -1, 15]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.sub %0, %arg0 : vector<4xi32>
  %3 = llvm.xor %2, %1 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
theorem test_v4i32_xor_signmask_sub_const_proof : test_v4i32_xor_signmask_sub_const_before ⊑ test_v4i32_xor_signmask_sub_const_after := by
  sorry



def test_v4i32_xor_signmask_add_splatconst_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.add %0, %arg0 : vector<4xi32>
  %3 = llvm.xor %1, %2 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def test_v4i32_xor_signmask_add_splatconst_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-2147483645> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.add %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem test_v4i32_xor_signmask_add_splatconst_proof : test_v4i32_xor_signmask_add_splatconst_before ⊑ test_v4i32_xor_signmask_add_splatconst_after := by
  sorry



def test_v4i32_xor_signmask_add_const_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[3, 5, -1, 15]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.add %0, %arg0 : vector<4xi32>
  %3 = llvm.xor %1, %2 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def test_v4i32_xor_signmask_add_const_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[3, 5, -1, 15]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2147483648> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.add %arg0, %0 : vector<4xi32>
  %3 = llvm.xor %2, %1 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
theorem test_v4i32_xor_signmask_add_const_proof : test_v4i32_xor_signmask_add_const_before ⊑ test_v4i32_xor_signmask_add_const_after := by
  sorry


