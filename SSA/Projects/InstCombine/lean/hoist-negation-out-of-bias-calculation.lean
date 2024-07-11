
def t0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg1 : i8
  %2 = llvm.and %1, %arg0 : i8
  %3 = llvm.sub %2, %arg0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.add %arg1, %0 : i8
  %3 = llvm.and %2, %arg0 : i8
  %4 = llvm.sub %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  sorry



def t2_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.sub %1, %arg1 : vector<2xi8>
  %3 = llvm.and %2, %arg0 : vector<2xi8>
  %4 = llvm.sub %3, %arg0 : vector<2xi8>
  "llvm.return"(%4) : (vector<2xi8>) -> ()
}
]
def t2_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.add %arg1, %0 : vector<2xi8>
  %4 = llvm.and %3, %arg0 : vector<2xi8>
  %5 = llvm.sub %2, %4 : vector<2xi8>
  "llvm.return"(%5) : (vector<2xi8>) -> ()
}
]
theorem t2_vec_proof : t2_vec_before ⊑ t2_vec_after := by
  sorry



def n7_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg1 : i8
  %2 = llvm.and %1, %arg0 : i8
  %3 = llvm.sub %arg0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def n7_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.add %arg1, %0 : i8
  %2 = llvm.and %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem n7_proof : n7_before ⊑ n7_after := by
  sorry



def n9_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg2 : i8
  %2 = llvm.and %arg1, %1 : i8
  %3 = llvm.sub %2, %arg0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def n9_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg2 : i8
  %2 = llvm.and %1, %arg1 : i8
  %3 = llvm.sub %2, %arg0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem n9_proof : n9_before ⊑ n9_after := by
  sorry


