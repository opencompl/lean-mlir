
def test2_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.and %arg0, %arg1 : i1
  %1 = llvm.and %0, %arg0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i1):
  %0 = llvm.and %arg0, %arg1 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry



def test3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  %1 = llvm.and %arg1, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.and %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry



def test7_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %2, %arg1 : i1
  %5 = llvm.and %4, %3 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %2 = llvm.and %1, %arg1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  sorry



def test8_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 14 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 13 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  sorry



def test8vec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.mlir.constant"() <{"value" = dense<14> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %4 = "llvm.icmp"(%arg0, %2) <{"predicate" = 6 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %5 = llvm.and %3, %4 : vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def test8vec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<13> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem test8vec_proof : test8vec_before ⊑ test8vec_after := by
  sorry



def test9_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg0 : i64
  %3 = llvm.and %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i64}> : () -> i64
  %1 = llvm.and %arg0, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  sorry



def test9vec_before := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi64>}> : () -> vector<2xi64>
  %2 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi64>}> : () -> vector<2xi64>
  %3 = llvm.sub %1, %arg0 : vector<2xi64>
  %4 = llvm.and %3, %2 : vector<2xi64>
  "llvm.return"(%4) : (vector<2xi64>) -> ()
}
]
def test9vec_after := [llvm|
{
^0(%arg0 : vector<2xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi64>}> : () -> vector<2xi64>
  %1 = llvm.and %arg0, %0 : vector<2xi64>
  "llvm.return"(%1) : (vector<2xi64>) -> ()
}
]
theorem test9vec_proof : test9vec_before ⊑ test9vec_after := by
  sorry



def test10_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i64}> : () -> i64
  %2 = llvm.sub %0, %arg0 : i64
  %3 = llvm.and %2, %1 : i64
  %4 = llvm.add %2, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %2 = llvm.and %arg0, %0 : i64
  %3 = llvm.sub %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
theorem test10_proof : test10_before ⊑ test10_after := by
  sorry



def test11_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.add %2, %arg1 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  sorry



def test12_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.add %arg1, %2 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test12_proof : test12_before ⊑ test12_after := by
  sorry



def test13_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.sub %arg1, %2 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test13_proof : test13_before ⊑ test13_after := by
  sorry



def test14_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.sub %2, %arg1 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %3 = llvm.shl %arg0, %0 : i32
  %4 = llvm.sub %1, %arg1 : i32
  %5 = llvm.and %4, %2 : i32
  %6 = llvm.mul %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem test14_proof : test14_before ⊑ test14_after := by
  sorry


