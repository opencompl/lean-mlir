
def t1_before := [llvm|
{
^0(%arg0 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = -4 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = -6 : i4}> : () -> i4
  %2 = llvm.or %arg0, %0 : i4
  %3 = llvm.xor %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
def t1_after := [llvm|
{
^0(%arg0 : i4):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %2 = llvm.and %arg0, %0 : i4
  %3 = llvm.xor %2, %1 : i4
  "llvm.return"(%3) : (i4) -> ()
}
]
theorem t1_proof : t1_before ⊑ t1_after := by
  sorry



def t3_before := [llvm|
{
^0(%arg0 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -4 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<-4> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = -6 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<-6> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.or %arg0, %1 : vector<2xi4>
  %5 = llvm.xor %4, %3 : vector<2xi4>
  "llvm.return"(%5) : (vector<2xi4>) -> ()
}
]
def t3_after := [llvm|
{
^0(%arg0 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<2xi4>}> : () -> vector<2xi4>
  %2 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %3 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.and %arg0, %1 : vector<2xi4>
  %5 = llvm.xor %4, %3 : vector<2xi4>
  "llvm.return"(%5) : (vector<2xi4>) -> ()
}
]
theorem t3_proof : t3_before ⊑ t3_after := by
  sorry



def t4_before := [llvm|
{
^0(%arg0 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = -6 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = -4 : i4}> : () -> i4
  %2 = "llvm.mlir.constant"() <{"value" = dense<[-4, -6]> : vector<2xi4>}> : () -> vector<2xi4>
  %3 = "llvm.mlir.constant"() <{"value" = dense<[-6, -4]> : vector<2xi4>}> : () -> vector<2xi4>
  %4 = llvm.or %arg0, %2 : vector<2xi4>
  %5 = llvm.xor %4, %3 : vector<2xi4>
  "llvm.return"(%5) : (vector<2xi4>) -> ()
}
]
def t4_after := [llvm|
{
^0(%arg0 : vector<2xi4>):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i4}> : () -> i4
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i4}> : () -> i4
  %2 = "llvm.mlir.constant"() <{"value" = dense<[3, 5]> : vector<2xi4>}> : () -> vector<2xi4>
  %3 = "llvm.mlir.constant"() <{"value" = 6 : i4}> : () -> i4
  %4 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<2xi4>}> : () -> vector<2xi4>
  %5 = llvm.and %arg0, %2 : vector<2xi4>
  %6 = llvm.xor %5, %4 : vector<2xi4>
  "llvm.return"(%6) : (vector<2xi4>) -> ()
}
]
theorem t4_proof : t4_before ⊑ t4_after := by
  sorry


