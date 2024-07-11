
def t0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = llvm.and %arg0, %0 : i8
  %2 = llvm.sub %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -43 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  sorry



def t1_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.and %arg0, %0 : vector<2xi8>
  %2 = llvm.sub %1, %arg0 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
def t1_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-43> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.and %arg0, %0 : vector<2xi8>
  %4 = llvm.sub %2, %3 : vector<2xi8>
  "llvm.return"(%4) : (vector<2xi8>) -> ()
}
]
theorem t1_vec_proof : t1_vec_before ⊑ t1_vec_after := by
  sorry



def t3_vec_nonsplat_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[42, 44]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.and %arg0, %0 : vector<2xi8>
  %2 = llvm.sub %1, %arg0 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
def t3_vec_nonsplat_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-43, -45]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %3 = llvm.and %arg0, %0 : vector<2xi8>
  %4 = llvm.sub %2, %3 : vector<2xi8>
  "llvm.return"(%4) : (vector<2xi8>) -> ()
}
]
theorem t3_vec_nonsplat_proof : t3_vec_nonsplat_before ⊑ t3_vec_nonsplat_after := by
  sorry



def n5_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = llvm.and %arg0, %0 : i8
  %2 = llvm.sub %arg0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def n5_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -43 : i8}> : () -> i8
  %1 = llvm.and %arg0, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem n5_proof : n5_before ⊑ n5_after := by
  sorry


