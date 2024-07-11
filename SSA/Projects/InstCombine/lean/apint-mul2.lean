
def test1_before := [llvm|
{
^0(%arg0 : i177):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i177}> : () -> i177
  %1 = "llvm.mlir.constant"() <{"value" = 155 : i177}> : () -> i177
  %2 = llvm.shl %0, %1 : i177
  %3 = llvm.mul %arg0, %2 : i177
  "llvm.return"(%3) : (i177) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i177):
  %0 = "llvm.mlir.constant"() <{"value" = 155 : i177}> : () -> i177
  %1 = llvm.shl %arg0, %0 : i177
  "llvm.return"(%1) : (i177) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : vector<2xi177>):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i177}> : () -> i177
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi177>}> : () -> vector<2xi177>
  %2 = "llvm.mlir.constant"() <{"value" = 155 : i177}> : () -> i177
  %3 = "llvm.mlir.constant"() <{"value" = dense<155> : vector<2xi177>}> : () -> vector<2xi177>
  %4 = llvm.shl %1, %3 : vector<2xi177>
  %5 = llvm.mul %arg0, %4 : vector<2xi177>
  "llvm.return"(%5) : (vector<2xi177>) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : vector<2xi177>):
  %0 = "llvm.mlir.constant"() <{"value" = 155 : i177}> : () -> i177
  %1 = "llvm.mlir.constant"() <{"value" = dense<155> : vector<2xi177>}> : () -> vector<2xi177>
  %2 = llvm.shl %arg0, %1 : vector<2xi177>
  "llvm.return"(%2) : (vector<2xi177>) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  sorry



def test3_before := [llvm|
{
^0(%arg0 : vector<2xi177>):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i177}> : () -> i177
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi177>}> : () -> vector<2xi177>
  %2 = "llvm.mlir.constant"() <{"value" = 155 : i177}> : () -> i177
  %3 = "llvm.mlir.constant"() <{"value" = 150 : i177}> : () -> i177
  %4 = "llvm.mlir.constant"() <{"value" = dense<[150, 155]> : vector<2xi177>}> : () -> vector<2xi177>
  %5 = llvm.shl %1, %4 : vector<2xi177>
  %6 = llvm.mul %arg0, %5 : vector<2xi177>
  "llvm.return"(%6) : (vector<2xi177>) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : vector<2xi177>):
  %0 = "llvm.mlir.constant"() <{"value" = 155 : i177}> : () -> i177
  %1 = "llvm.mlir.constant"() <{"value" = 150 : i177}> : () -> i177
  %2 = "llvm.mlir.constant"() <{"value" = dense<[150, 155]> : vector<2xi177>}> : () -> vector<2xi177>
  %3 = llvm.shl %arg0, %2 : vector<2xi177>
  "llvm.return"(%3) : (vector<2xi177>) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry


