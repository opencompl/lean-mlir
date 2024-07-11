
def test_xor_ne_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg2, %0 : i8
  %2 = llvm.xor %arg1, %0 : i8
  %3 = llvm.xor %2, %arg0 : i8
  %4 = "llvm.icmp"(%1, %3) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def test_xor_ne_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.xor %arg1, %arg0 : i8
  %1 = "llvm.icmp"(%0, %arg2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_xor_ne_proof : test_xor_ne_before ⊑ test_xor_ne_after := by
  sorry



def test_xor_eq_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg2, %0 : i8
  %2 = llvm.xor %arg1, %0 : i8
  %3 = llvm.xor %2, %arg0 : i8
  %4 = "llvm.icmp"(%1, %3) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def test_xor_eq_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = llvm.xor %arg1, %arg0 : i8
  %1 = "llvm.icmp"(%0, %arg2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_xor_eq_proof : test_xor_eq_before ⊑ test_xor_eq_after := by
  sorry



def test_slt_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_slt_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_slt_xor_proof : test_slt_xor_before ⊑ test_slt_xor_after := by
  sorry



def test_sle_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %0 : i32
  %2 = llvm.xor %1, %arg0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 3 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_sle_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg1, %arg0 : i32
  %1 = "llvm.icmp"(%0, %arg1) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_sle_xor_proof : test_sle_xor_before ⊑ test_sle_xor_after := by
  sorry



def test_sgt_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_sgt_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_sgt_xor_proof : test_sgt_xor_before ⊑ test_sgt_xor_after := by
  sorry



def test_sge_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_sge_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 3 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_sge_xor_proof : test_sge_xor_before ⊑ test_sge_xor_after := by
  sorry



def test_ult_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_ult_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_ult_xor_proof : test_ult_xor_before ⊑ test_ult_xor_after := by
  sorry



def test_ule_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 7 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_ule_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 9 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_ule_xor_proof : test_ule_xor_before ⊑ test_ule_xor_after := by
  sorry



def test_ugt_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_ugt_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_ugt_xor_proof : test_ugt_xor_before ⊑ test_ugt_xor_after := by
  sorry



def test_uge_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %0 : i32
  %2 = llvm.xor %1, %arg1 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 9 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test_uge_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.xor %arg0, %arg1 : i32
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 7 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test_uge_xor_proof : test_uge_xor_before ⊑ test_uge_xor_after := by
  sorry



def xor_ule_2_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[9, 8]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.or %arg1, %0 : vector<2xi8>
  %2 = llvm.xor %1, %arg0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 7 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def xor_ule_2_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[9, 8]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.or %arg1, %0 : vector<2xi8>
  %2 = llvm.xor %1, %arg0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 6 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem xor_ule_2_proof : xor_ule_2_before ⊑ xor_ule_2_after := by
  sorry



def xor_sge_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = llvm.mul %arg0, %arg0 : i8
  %2 = llvm.or %arg1, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = "llvm.icmp"(%1, %3) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_sge_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = llvm.mul %arg0, %arg0 : i8
  %2 = llvm.or %arg1, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem xor_sge_proof : xor_sge_before ⊑ xor_sge_after := by
  sorry



def xor_sgt_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<31> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<64> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.and %arg1, %0 : vector<2xi8>
  %3 = llvm.or %2, %1 : vector<2xi8>
  %4 = llvm.xor %arg0, %3 : vector<2xi8>
  %5 = "llvm.icmp"(%4, %arg0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def xor_sgt_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<31> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<64> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.and %arg1, %0 : vector<2xi8>
  %3 = llvm.or %2, %1 : vector<2xi8>
  %4 = llvm.xor %3, %arg0 : vector<2xi8>
  %5 = "llvm.icmp"(%4, %arg0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
theorem xor_sgt_proof : xor_sgt_before ⊑ xor_sgt_after := by
  sorry



def xor_sgt_fail_no_known_msb_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<63> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.and %arg1, %0 : vector<2xi8>
  %3 = llvm.or %2, %1 : vector<2xi8>
  %4 = llvm.xor %arg0, %3 : vector<2xi8>
  %5 = "llvm.icmp"(%4, %arg0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def xor_sgt_fail_no_known_msb_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<55> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.and %arg1, %0 : vector<2xi8>
  %3 = llvm.or %2, %1 : vector<2xi8>
  %4 = llvm.xor %3, %arg0 : vector<2xi8>
  %5 = "llvm.icmp"(%4, %arg0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
theorem xor_sgt_fail_no_known_msb_proof : xor_sgt_fail_no_known_msb_before ⊑ xor_sgt_fail_no_known_msb_after := by
  sorry



def xor_slt_2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 88 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def xor_slt_2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 88 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem xor_slt_2_proof : xor_slt_2_before ⊑ xor_slt_2_after := by
  sorry


