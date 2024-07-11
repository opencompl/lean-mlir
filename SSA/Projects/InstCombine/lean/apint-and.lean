
def test0_before := [llvm|
{
^0(%arg0 : i39):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i39}> : () -> i39
  %1 = llvm.and %arg0, %0 : i39
  "llvm.return"(%1) : (i39) -> ()
}
]
def test0_after := [llvm|
{
^0(%arg0 : i39):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i39}> : () -> i39
  "llvm.return"(%0) : (i39) -> ()
}
]
theorem test0_proof : test0_before ⊑ test0_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : i15):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i15}> : () -> i15
  %1 = llvm.and %arg0, %0 : i15
  "llvm.return"(%1) : (i15) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i15):
  "llvm.return"(%arg0) : (i15) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry



def test3_before := [llvm|
{
^0(%arg0 : i23):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i23}> : () -> i23
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i23}> : () -> i23
  %2 = llvm.and %arg0, %0 : i23
  %3 = llvm.and %2, %1 : i23
  "llvm.return"(%3) : (i23) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i23):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i23}> : () -> i23
  "llvm.return"(%0) : (i23) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry



def test4_before := [llvm|
{
^0(%arg0 : i37):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i37}> : () -> i37
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i37}> : () -> i37
  %2 = llvm.and %arg0, %0 : i37
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i37, i37) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i37):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i37}> : () -> i37
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i37, i37) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  sorry



def test8_before := [llvm|
{
^0(%arg0 : i999):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i999}> : () -> i999
  %1 = llvm.and %arg0, %0 : i999
  "llvm.return"(%1) : (i999) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg0 : i999):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i999}> : () -> i999
  "llvm.return"(%0) : (i999) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  sorry



def test9_before := [llvm|
{
^0(%arg0 : i1005):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i1005}> : () -> i1005
  %1 = llvm.and %arg0, %0 : i1005
  "llvm.return"(%1) : (i1005) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i1005):
  "llvm.return"(%arg0) : (i1005) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  sorry



def test10_before := [llvm|
{
^0(%arg0 : i123):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i123}> : () -> i123
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i123}> : () -> i123
  %2 = llvm.and %arg0, %0 : i123
  %3 = llvm.and %2, %1 : i123
  "llvm.return"(%3) : (i123) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg0 : i123):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i123}> : () -> i123
  "llvm.return"(%0) : (i123) -> ()
}
]
theorem test10_proof : test10_before ⊑ test10_after := by
  sorry



def test11_before := [llvm|
{
^0(%arg0 : i737):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i737}> : () -> i737
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i737}> : () -> i737
  %2 = llvm.and %arg0, %0 : i737
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i737, i737) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i737):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i737}> : () -> i737
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i737, i737) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  sorry


