
def test1_before := [llvm|
{
^0(%arg0 : i23):
  %0 = llvm.sub %arg0, %arg0 : i23
  "llvm.return"(%0) : (i23) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i23):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i23}> : () -> i23
  "llvm.return"(%0) : (i23) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : i47):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i47}> : () -> i47
  %1 = llvm.sub %arg0, %0 : i47
  "llvm.return"(%1) : (i47) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i47):
  "llvm.return"(%arg0) : (i47) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry



def test3_before := [llvm|
{
^0(%arg0 : i97):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i97}> : () -> i97
  %1 = llvm.sub %0, %arg0 : i97
  %2 = llvm.sub %0, %1 : i97
  "llvm.return"(%2) : (i97) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i97):
  "llvm.return"(%arg0) : (i97) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry



def test4_before := [llvm|
{
^0(%arg0 : i108, %arg1 : i108):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i108}> : () -> i108
  %1 = llvm.sub %0, %arg0 : i108
  %2 = llvm.sub %arg1, %1 : i108
  "llvm.return"(%2) : (i108) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i108, %arg1 : i108):
  %0 = llvm.add %arg1, %arg0 : i108
  "llvm.return"(%0) : (i108) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  sorry



def test5_before := [llvm|
{
^0(%arg0 : i19, %arg1 : i19, %arg2 : i19):
  %0 = llvm.sub %arg1, %arg2 : i19
  %1 = llvm.sub %arg0, %0 : i19
  "llvm.return"(%1) : (i19) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i19, %arg1 : i19, %arg2 : i19):
  %0 = llvm.sub %arg2, %arg1 : i19
  %1 = llvm.add %0, %arg0 : i19
  "llvm.return"(%1) : (i19) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  sorry



def test6_before := [llvm|
{
^0(%arg0 : i57, %arg1 : i57):
  %0 = llvm.and %arg0, %arg1 : i57
  %1 = llvm.sub %arg0, %0 : i57
  "llvm.return"(%1) : (i57) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg0 : i57, %arg1 : i57):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i57}> : () -> i57
  %1 = llvm.xor %arg1, %0 : i57
  %2 = llvm.and %1, %arg0 : i57
  "llvm.return"(%2) : (i57) -> ()
}
]
theorem test6_proof : test6_before ⊑ test6_after := by
  sorry



def test7_before := [llvm|
{
^0(%arg0 : i77):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i77}> : () -> i77
  %1 = llvm.sub %0, %arg0 : i77
  "llvm.return"(%1) : (i77) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : i77):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i77}> : () -> i77
  %1 = llvm.xor %arg0, %0 : i77
  "llvm.return"(%1) : (i77) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  sorry



def test8_before := [llvm|
{
^0(%arg0 : i27):
  %0 = "llvm.mlir.constant"() <{"value" = 9 : i27}> : () -> i27
  %1 = llvm.mul %0, %arg0 : i27
  %2 = llvm.sub %1, %arg0 : i27
  "llvm.return"(%2) : (i27) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg0 : i27):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i27}> : () -> i27
  %1 = llvm.shl %arg0, %0 : i27
  "llvm.return"(%1) : (i27) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  sorry



def test9_before := [llvm|
{
^0(%arg0 : i42):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i42}> : () -> i42
  %1 = llvm.mul %0, %arg0 : i42
  %2 = llvm.sub %arg0, %1 : i42
  "llvm.return"(%2) : (i42) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i42):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i42}> : () -> i42
  %1 = llvm.mul %arg0, %0 : i42
  "llvm.return"(%1) : (i42) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  sorry



def test11_before := [llvm|
{
^0(%arg0 : i9, %arg1 : i9):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i9}> : () -> i9
  %1 = llvm.sub %arg0, %arg1 : i9
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 1 : i64}> : (i9, i9) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i9, %arg1 : i9):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (i9, i9) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  sorry



def test18_before := [llvm|
{
^0(%arg0 : i128):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i128}> : () -> i128
  %1 = llvm.shl %arg0, %0 : i128
  %2 = llvm.shl %arg0, %0 : i128
  %3 = llvm.sub %1, %2 : i128
  "llvm.return"(%3) : (i128) -> ()
}
]
def test18_after := [llvm|
{
^0(%arg0 : i128):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i128}> : () -> i128
  "llvm.return"(%0) : (i128) -> ()
}
]
theorem test18_proof : test18_before ⊑ test18_after := by
  sorry



def test19_before := [llvm|
{
^0(%arg0 : i39, %arg1 : i39):
  %0 = llvm.sub %arg0, %arg1 : i39
  %1 = llvm.add %0, %arg1 : i39
  "llvm.return"(%1) : (i39) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg0 : i39, %arg1 : i39):
  "llvm.return"(%arg0) : (i39) -> ()
}
]
theorem test19_proof : test19_before ⊑ test19_after := by
  sorry



def test20_before := [llvm|
{
^0(%arg0 : i33, %arg1 : i33):
  %0 = llvm.sub %arg0, %arg1 : i33
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 1 : i64}> : (i33, i33) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test20_after := [llvm|
{
^0(%arg0 : i33, %arg1 : i33):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i33}> : () -> i33
  %1 = "llvm.icmp"(%arg1, %0) <{"predicate" = 1 : i64}> : (i33, i33) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test20_proof : test20_before ⊑ test20_after := by
  sorry



def test21_before := [llvm|
{
^0(%arg0 : i256, %arg1 : i256):
  %0 = llvm.sub %arg0, %arg1 : i256
  %1 = "llvm.icmp"(%0, %arg0) <{"predicate" = 1 : i64}> : (i256, i256) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test21_after := [llvm|
{
^0(%arg0 : i256, %arg1 : i256):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i256}> : () -> i256
  %1 = "llvm.icmp"(%arg1, %0) <{"predicate" = 1 : i64}> : (i256, i256) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test21_proof : test21_before ⊑ test21_after := by
  sorry


