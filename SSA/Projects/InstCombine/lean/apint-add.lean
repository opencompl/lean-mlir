
def test1_before := [llvm|
{
^0(%arg0 : i1):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = llvm.xor %arg0, %0 : i1
  %2 = llvm.add %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i1):
  "llvm.return"(%arg0) : (i1) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  sorry



def test2_before := [llvm|
{
^0(%arg0 : i47):
  %0 = "llvm.mlir.constant"() <{"value" = -70368744177664 : i47}> : () -> i47
  %1 = llvm.xor %arg0, %0 : i47
  %2 = llvm.add %1, %0 : i47
  "llvm.return"(%2) : (i47) -> ()
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
^0(%arg0 : i15):
  %0 = "llvm.mlir.constant"() <{"value" = -16384 : i15}> : () -> i15
  %1 = llvm.xor %arg0, %0 : i15
  %2 = llvm.add %1, %0 : i15
  "llvm.return"(%2) : (i15) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg0 : i15):
  "llvm.return"(%arg0) : (i15) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  sorry



def test3vec_before := [llvm|
{
^0(%arg0 : vector<2xi5>):
  %0 = "llvm.mlir.constant"() <{"value" = -16 : i5}> : () -> i5
  %1 = "llvm.mlir.constant"() <{"value" = dense<-16> : vector<2xi5>}> : () -> vector<2xi5>
  %2 = llvm.add %arg0, %1 : vector<2xi5>
  "llvm.return"(%2) : (vector<2xi5>) -> ()
}
]
def test3vec_after := [llvm|
{
^0(%arg0 : vector<2xi5>):
  %0 = "llvm.mlir.constant"() <{"value" = -16 : i5}> : () -> i5
  %1 = "llvm.mlir.constant"() <{"value" = dense<-16> : vector<2xi5>}> : () -> vector<2xi5>
  %2 = llvm.xor %arg0, %1 : vector<2xi5>
  "llvm.return"(%2) : (vector<2xi5>) -> ()
}
]
theorem test3vec_proof : test3vec_before ⊑ test3vec_after := by
  sorry



def test4_before := [llvm|
{
^0(%arg0 : i49):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i49}> : () -> i49
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i49}> : () -> i49
  %2 = llvm.and %arg0, %0 : i49
  %3 = llvm.add %2, %1 : i49
  "llvm.return"(%3) : (i49) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i49):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i49}> : () -> i49
  %1 = llvm.or %arg0, %0 : i49
  "llvm.return"(%1) : (i49) -> ()
}
]
theorem test4_proof : test4_before ⊑ test4_after := by
  sorry



def test5_before := [llvm|
{
^0(%arg0 : i111):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i111}> : () -> i111
  %1 = "llvm.mlir.constant"() <{"value" = 110 : i111}> : () -> i111
  %2 = llvm.shl %0, %1 : i111
  %3 = llvm.xor %arg0, %2 : i111
  %4 = llvm.add %3, %2 : i111
  "llvm.return"(%4) : (i111) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i111):
  "llvm.return"(%arg0) : (i111) -> ()
}
]
theorem test5_proof : test5_before ⊑ test5_after := by
  sorry



def test6_before := [llvm|
{
^0(%arg0 : i65):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i65}> : () -> i65
  %1 = "llvm.mlir.constant"() <{"value" = 64 : i65}> : () -> i65
  %2 = llvm.shl %0, %1 : i65
  %3 = llvm.xor %arg0, %2 : i65
  %4 = llvm.add %3, %2 : i65
  "llvm.return"(%4) : (i65) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg0 : i65):
  "llvm.return"(%arg0) : (i65) -> ()
}
]
theorem test6_proof : test6_before ⊑ test6_after := by
  sorry



def test7_before := [llvm|
{
^0(%arg0 : i1024):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i1024}> : () -> i1024
  %1 = "llvm.mlir.constant"() <{"value" = 1023 : i1024}> : () -> i1024
  %2 = llvm.shl %0, %1 : i1024
  %3 = llvm.xor %arg0, %2 : i1024
  %4 = llvm.add %3, %2 : i1024
  "llvm.return"(%4) : (i1024) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg0 : i1024):
  "llvm.return"(%arg0) : (i1024) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  sorry



def test9_before := [llvm|
{
^0(%arg0 : i77):
  %0 = "llvm.mlir.constant"() <{"value" = 562949953421310 : i77}> : () -> i77
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i77}> : () -> i77
  %2 = llvm.and %arg0, %0 : i77
  %3 = llvm.add %2, %1 : i77
  "llvm.return"(%3) : (i77) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg0 : i77):
  %0 = "llvm.mlir.constant"() <{"value" = 562949953421310 : i77}> : () -> i77
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i77}> : () -> i77
  %2 = llvm.and %arg0, %0 : i77
  %3 = llvm.or %2, %1 : i77
  "llvm.return"(%3) : (i77) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  sorry


