
def test_and1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %2) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_and1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = llvm.and %arg1, %0 : i32
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test_and1_proof : test_and1_before ⊑ test_and1_after := by
  sorry



def test_and2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %2) <{"predicate" = 3 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_and2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = llvm.and %arg1, %0 : i32
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 9 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test_and2_proof : test_and2_before ⊑ test_and2_after := by
  sorry



def test_and3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_and3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = llvm.and %arg1, %0 : i32
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test_and3_proof : test_and3_before ⊑ test_and3_after := by
  sorry



def test_and4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_and4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = llvm.and %arg1, %0 : i32
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 9 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test_and4_proof : test_and4_before ⊑ test_and4_after := by
  sorry



def test_or1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %2) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_or1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = llvm.and %arg1, %0 : i32
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 7 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test_or1_proof : test_or1_before ⊑ test_or1_after := by
  sorry



def test_or2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 3 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %2) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_or2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = llvm.and %arg1, %0 : i32
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test_or2_proof : test_or2_before ⊑ test_or2_after := by
  sorry



def test_or3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 3 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_or3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = llvm.and %arg1, %0 : i32
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 7 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test_or3_proof : test_or3_before ⊑ test_or3_after := by
  sorry



def test_or4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_or4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = llvm.and %arg1, %0 : i32
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test_or4_proof : test_or4_before ⊑ test_or4_after := by
  sorry



def negative1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%arg0, %2) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def negative1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem negative1_proof : negative1_before ⊑ negative1_after := by
  sorry



def negative2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def negative2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem negative2_proof : negative2_before ⊑ negative2_after := by
  sorry



def negative3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg2, %0 : i32
  %3 = "llvm.icmp"(%arg0, %2) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg1, %1) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def negative3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.and %arg2, %0 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg1, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem negative3_proof : negative3_before ⊑ negative3_after := by
  sorry



def negative4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%arg0, %2) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def negative4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem negative4_proof : negative4_before ⊑ negative4_after := by
  sorry



def negative5_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%arg0, %2) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def negative5_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem negative5_proof : negative5_before ⊑ negative5_after := by
  sorry


