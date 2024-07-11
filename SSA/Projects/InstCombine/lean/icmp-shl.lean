
def shl_nuw_eq_0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %arg1 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def shl_nuw_eq_0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem shl_nuw_eq_0_proof : shl_nuw_eq_0_before ⊑ shl_nuw_eq_0_after := by
  sorry



def shl_nsw_ne_0_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.shl %arg0, %arg1 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def shl_nsw_ne_0_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem shl_nsw_ne_0_proof : shl_nsw_ne_0_before ⊑ shl_nsw_ne_0_after := by
  sorry



def shl_nsw_slt_1_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %arg1 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def shl_nsw_slt_1_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem shl_nsw_slt_1_proof : shl_nsw_slt_1_before ⊑ shl_nsw_slt_1_after := by
  sorry



def shl_nsw_sle_n1_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.shl %arg0, %arg1 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 3 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def shl_nsw_sle_n1_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.shl %arg0, %arg1 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem shl_nsw_sle_n1_proof : shl_nsw_sle_n1_before ⊑ shl_nsw_sle_n1_after := by
  sorry



def shl_nsw_sge_1_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.shl %arg0, %arg1 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 5 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def shl_nsw_sge_1_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem shl_nsw_sge_1_proof : shl_nsw_sge_1_before ⊑ shl_nsw_sge_1_after := by
  sorry



def shl_nsw_sgt_n1_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %arg1 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def shl_nsw_sgt_n1_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem shl_nsw_sgt_n1_proof : shl_nsw_sgt_n1_before ⊑ shl_nsw_sgt_n1_after := by
  sorry



def shl_nsw_nuw_ult_Csle0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -19 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %arg1 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def shl_nsw_nuw_ult_Csle0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -19 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem shl_nsw_nuw_ult_Csle0_proof : shl_nsw_nuw_ult_Csle0_before ⊑ shl_nsw_nuw_ult_Csle0_after := by
  sorry



def shl_nsw_ule_Csle0_fail_missing_flag_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -19 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %arg1 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def shl_nsw_ule_Csle0_fail_missing_flag_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -18 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %arg1 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem shl_nsw_ule_Csle0_fail_missing_flag_proof : shl_nsw_ule_Csle0_fail_missing_flag_before ⊑ shl_nsw_ule_Csle0_fail_missing_flag_after := by
  sorry



def shl_nsw_nuw_uge_Csle0_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -120 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %arg1 : i8
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def shl_nsw_nuw_uge_Csle0_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -121 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem shl_nsw_nuw_uge_Csle0_proof : shl_nsw_nuw_uge_Csle0_before ⊑ shl_nsw_nuw_uge_Csle0_after := by
  sorry



def shl_nsw_nuw_sgt_Csle0_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-10> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.shl %arg0, %arg1 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def shl_nsw_nuw_sgt_Csle0_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-10> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem shl_nsw_nuw_sgt_Csle0_proof : shl_nsw_nuw_sgt_Csle0_before ⊑ shl_nsw_nuw_sgt_Csle0_after := by
  sorry



def shl_nsw_nuw_sge_Csle0_todo_non_splat_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-10, -65]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.shl %arg0, %arg1 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 5 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def shl_nsw_nuw_sge_Csle0_todo_non_splat_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-11, -66]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.shl %arg0, %arg1 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem shl_nsw_nuw_sge_Csle0_todo_non_splat_proof : shl_nsw_nuw_sge_Csle0_todo_non_splat_before ⊑ shl_nsw_nuw_sge_Csle0_todo_non_splat_after := by
  sorry



def shl_nsw_nuw_sle_Csle0_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-6> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.shl %arg0, %arg1 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 3 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def shl_nsw_nuw_sle_Csle0_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-5> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem shl_nsw_nuw_sle_Csle0_proof : shl_nsw_nuw_sle_Csle0_before ⊑ shl_nsw_nuw_sle_Csle0_after := by
  sorry


