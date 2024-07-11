
def f_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.mul %arg0, %0 : vector<2xi8>
  "llvm.return"(%1) : (vector<2xi8>) -> ()
}
]
def f_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  "llvm.return"(%arg0) : (vector<2xi8>) -> ()
}
]
theorem f_proof : f_before ⊑ f_after := by
  sorry



def g_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.mul %arg0, %0 : vector<2xi8>
  "llvm.return"(%1) : (vector<2xi8>) -> ()
}
]
def g_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.sub %1, %arg0 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
theorem g_proof : g_before ⊑ g_after := by
  sorry


