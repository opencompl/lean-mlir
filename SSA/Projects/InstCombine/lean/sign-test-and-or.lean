
def test1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test1_splat_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 2 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = "llvm.icmp"(%arg1, %1) <{"predicate" = 2 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %4 = llvm.or %2, %3 : vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def test1_splat_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.or %arg0, %arg1 : vector<2xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem test1_splat_proof : test1_splat_before ⊑ test1_splat_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry



def test3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry



def test4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  sorry



def test9_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1073741824 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = "llvm.icmp"(%arg0, %2) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1073741824 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 1073741824 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  sorry



def test10_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = "llvm.icmp"(%arg0, %2) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test10_proof : test10_before ⊑ test10_after := by
  sorry



def test11_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 3 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = "llvm.icmp"(%arg0, %2) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  %6 = llvm.or %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  sorry


