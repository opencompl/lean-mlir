
def slt_to_ult_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.xor %arg1, %0 : i8
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_to_ult_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem slt_to_ult_proof : slt_to_ult_before ⊑ slt_to_ult_after := by
  sorry



def slt_to_ult_splat_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.xor %arg0, %0 : vector<2xi8>
  %2 = llvm.xor %arg1, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def slt_to_ult_splat_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
theorem slt_to_ult_splat_proof : slt_to_ult_splat_before ⊑ slt_to_ult_splat_after := by
  sorry



def ult_to_slt_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.xor %arg1, %0 : i8
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_to_slt_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ult_to_slt_proof : ult_to_slt_before ⊑ ult_to_slt_after := by
  sorry



def ult_to_slt_splat_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.xor %arg0, %0 : vector<2xi8>
  %2 = llvm.xor %arg1, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 6 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def ult_to_slt_splat_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
theorem ult_to_slt_splat_proof : ult_to_slt_splat_before ⊑ ult_to_slt_splat_after := by
  sorry



def slt_to_ugt_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.xor %arg1, %0 : i8
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_to_ugt_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem slt_to_ugt_proof : slt_to_ugt_before ⊑ slt_to_ugt_after := by
  sorry



def slt_to_ugt_splat_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<127> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.xor %arg0, %0 : vector<2xi8>
  %2 = llvm.xor %arg1, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def slt_to_ugt_splat_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
theorem slt_to_ugt_splat_proof : slt_to_ugt_splat_before ⊑ slt_to_ugt_splat_after := by
  sorry



def ult_to_sgt_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.xor %arg1, %0 : i8
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_to_sgt_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ult_to_sgt_proof : ult_to_sgt_before ⊑ ult_to_sgt_after := by
  sorry



def ult_to_sgt_splat_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<127> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.xor %arg0, %0 : vector<2xi8>
  %2 = llvm.xor %arg1, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 6 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def ult_to_sgt_splat_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
theorem ult_to_sgt_splat_proof : ult_to_sgt_splat_before ⊑ ult_to_sgt_splat_after := by
  sorry



def sge_to_ugt_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 15 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_to_ugt_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -114 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sge_to_ugt_proof : sge_to_ugt_before ⊑ sge_to_ugt_after := by
  sorry



def sge_to_ugt_splat_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.xor %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 5 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def sge_to_ugt_splat_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-114> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem sge_to_ugt_splat_proof : sge_to_ugt_splat_before ⊑ sge_to_ugt_splat_after := by
  sorry



def uge_to_sgt_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 15 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_to_sgt_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -114 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem uge_to_sgt_proof : uge_to_sgt_before ⊑ uge_to_sgt_after := by
  sorry



def uge_to_sgt_splat_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-128> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.xor %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 9 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def uge_to_sgt_splat_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-114> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem uge_to_sgt_splat_proof : uge_to_sgt_splat_before ⊑ uge_to_sgt_splat_after := by
  sorry



def sge_to_ult_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 15 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_to_ult_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 113 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sge_to_ult_proof : sge_to_ult_before ⊑ sge_to_ult_after := by
  sorry



def sge_to_ult_splat_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<127> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.xor %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 5 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def sge_to_ult_splat_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<113> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem sge_to_ult_splat_proof : sge_to_ult_splat_before ⊑ sge_to_ult_splat_after := by
  sorry



def uge_to_slt_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 15 : i8}> : () -> i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_to_slt_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 113 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem uge_to_slt_proof : uge_to_slt_before ⊑ uge_to_slt_after := by
  sorry



def uge_to_slt_splat_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<127> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<15> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.xor %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 9 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def uge_to_slt_splat_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<113> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem uge_to_slt_splat_proof : uge_to_slt_splat_before ⊑ uge_to_slt_splat_after := by
  sorry


