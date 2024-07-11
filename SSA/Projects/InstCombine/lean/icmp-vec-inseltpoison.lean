
def sge_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-127, 127]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 5 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
def sge_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-128, 126]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem sge_proof : sge_before ⊑ sge_after := by
  sorry



def uge_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-1, 1]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
def uge_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-2, 0]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem uge_proof : uge_before ⊑ uge_after := by
  sorry



def sle_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[126, -128]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 3 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
def sle_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[127, -127]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem sle_proof : sle_before ⊑ sle_after := by
  sorry



def ule_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-2, 0]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 7 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
def ule_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-1, 1]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem ule_proof : ule_before ⊑ ule_after := by
  sorry



def ult_min_signed_value_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
def ult_min_signed_value_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem ult_min_signed_value_proof : ult_min_signed_value_before ⊑ ult_min_signed_value_after := by
  sorry



def sge_zero_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 5 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def sge_zero_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem sge_zero_proof : sge_zero_before ⊑ sge_zero_after := by
  sorry



def uge_zero_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 9 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def uge_zero_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem uge_zero_proof : uge_zero_before ⊑ uge_zero_after := by
  sorry



def sle_zero_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 3 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def sle_zero_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem sle_zero_proof : sle_zero_before ⊑ sle_zero_after := by
  sorry



def ule_zero_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 7 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def ule_zero_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem ule_zero_proof : ule_zero_before ⊑ ule_zero_after := by
  sorry



def sge_weird_before := [llvm|
{
^0(%arg0 : vector<3xi3>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i3}> : () -> i3
  %1 = "llvm.mlir.constant"() <{"value" = 3 : i3}> : () -> i3
  %2 = "llvm.mlir.constant"() <{"value" = -3 : i3}> : () -> i3
  %3 = "llvm.mlir.constant"() <{"value" = dense<[-3, 3, 0]> : vector<3xi3>}> : () -> vector<3xi3>
  %4 = "llvm.icmp"(%arg0, %3) <{"predicate" = 5 : i64}> : (vector<3xi3>, vector<3xi3>) -> vector<3xi1>
  "llvm.return"(%4) : (vector<3xi1>) -> ()
}
]
def sge_weird_after := [llvm|
{
^0(%arg0 : vector<3xi3>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i3}> : () -> i3
  %2 = "llvm.mlir.constant"() <{"value" = -4 : i3}> : () -> i3
  %3 = "llvm.mlir.constant"() <{"value" = dense<[-4, 2, -1]> : vector<3xi3>}> : () -> vector<3xi3>
  %4 = "llvm.icmp"(%arg0, %3) <{"predicate" = 4 : i64}> : (vector<3xi3>, vector<3xi3>) -> vector<3xi1>
  "llvm.return"(%4) : (vector<3xi1>) -> ()
}
]
theorem sge_weird_proof : sge_weird_before ⊑ sge_weird_after := by
  sorry



def uge_weird_before := [llvm|
{
^0(%arg0 : vector<3xi3>):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i3}> : () -> i3
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i3}> : () -> i3
  %2 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %3 = "llvm.mlir.constant"() <{"value" = dense<[-1, 1, 2]> : vector<3xi3>}> : () -> vector<3xi3>
  %4 = "llvm.icmp"(%arg0, %3) <{"predicate" = 9 : i64}> : (vector<3xi3>, vector<3xi3>) -> vector<3xi1>
  "llvm.return"(%4) : (vector<3xi1>) -> ()
}
]
def uge_weird_after := [llvm|
{
^0(%arg0 : vector<3xi3>):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i3}> : () -> i3
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i3}> : () -> i3
  %2 = "llvm.mlir.constant"() <{"value" = -2 : i3}> : () -> i3
  %3 = "llvm.mlir.constant"() <{"value" = dense<[-2, 0, 1]> : vector<3xi3>}> : () -> vector<3xi3>
  %4 = "llvm.icmp"(%arg0, %3) <{"predicate" = 8 : i64}> : (vector<3xi3>, vector<3xi3>) -> vector<3xi1>
  "llvm.return"(%4) : (vector<3xi1>) -> ()
}
]
theorem uge_weird_proof : uge_weird_before ⊑ uge_weird_after := by
  sorry



def sle_weird_before := [llvm|
{
^0(%arg0 : vector<3xi3>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i3}> : () -> i3
  %1 = "llvm.mlir.constant"() <{"value" = -4 : i3}> : () -> i3
  %2 = "llvm.mlir.constant"() <{"value" = 2 : i3}> : () -> i3
  %3 = "llvm.mlir.constant"() <{"value" = dense<[2, -4, 0]> : vector<3xi3>}> : () -> vector<3xi3>
  %4 = "llvm.icmp"(%arg0, %3) <{"predicate" = 3 : i64}> : (vector<3xi3>, vector<3xi3>) -> vector<3xi1>
  "llvm.return"(%4) : (vector<3xi1>) -> ()
}
]
def sle_weird_after := [llvm|
{
^0(%arg0 : vector<3xi3>):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i3}> : () -> i3
  %1 = "llvm.mlir.constant"() <{"value" = -3 : i3}> : () -> i3
  %2 = "llvm.mlir.constant"() <{"value" = 3 : i3}> : () -> i3
  %3 = "llvm.mlir.constant"() <{"value" = dense<[3, -3, 1]> : vector<3xi3>}> : () -> vector<3xi3>
  %4 = "llvm.icmp"(%arg0, %3) <{"predicate" = 2 : i64}> : (vector<3xi3>, vector<3xi3>) -> vector<3xi1>
  "llvm.return"(%4) : (vector<3xi1>) -> ()
}
]
theorem sle_weird_proof : sle_weird_before ⊑ sle_weird_after := by
  sorry



def ule_weird_before := [llvm|
{
^0(%arg0 : vector<3xi3>):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i3}> : () -> i3
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i3}> : () -> i3
  %2 = "llvm.mlir.constant"() <{"value" = -2 : i3}> : () -> i3
  %3 = "llvm.mlir.constant"() <{"value" = dense<[-2, 0, 1]> : vector<3xi3>}> : () -> vector<3xi3>
  %4 = "llvm.icmp"(%arg0, %3) <{"predicate" = 7 : i64}> : (vector<3xi3>, vector<3xi3>) -> vector<3xi1>
  "llvm.return"(%4) : (vector<3xi1>) -> ()
}
]
def ule_weird_after := [llvm|
{
^0(%arg0 : vector<3xi3>):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i3}> : () -> i3
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i3}> : () -> i3
  %2 = "llvm.mlir.constant"() <{"value" = -1 : i3}> : () -> i3
  %3 = "llvm.mlir.constant"() <{"value" = dense<[-1, 1, 2]> : vector<3xi3>}> : () -> vector<3xi3>
  %4 = "llvm.icmp"(%arg0, %3) <{"predicate" = 6 : i64}> : (vector<3xi3>, vector<3xi3>) -> vector<3xi1>
  "llvm.return"(%4) : (vector<3xi1>) -> ()
}
]
theorem ule_weird_proof : ule_weird_before ⊑ ule_weird_after := by
  sorry


