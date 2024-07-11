
def squared_nsw_eq0_before := [llvm|
{
^0(%arg0 : i5):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i5}> : () -> i5
  %1 = llvm.mul %arg0, %arg0 : i5
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (i5, i5) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def squared_nsw_eq0_after := [llvm|
{
^0(%arg0 : i5):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i5}> : () -> i5
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i5, i5) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem squared_nsw_eq0_proof : squared_nsw_eq0_before ⊑ squared_nsw_eq0_after := by
  sorry



def squared_nuw_eq0_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.mul %arg0, %arg0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def squared_nuw_eq0_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem squared_nuw_eq0_proof : squared_nuw_eq0_before ⊑ squared_nuw_eq0_after := by
  sorry



def squared_nsw_sgt0_before := [llvm|
{
^0(%arg0 : i5):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i5}> : () -> i5
  %1 = llvm.mul %arg0, %arg0 : i5
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i5, i5) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def squared_nsw_sgt0_after := [llvm|
{
^0(%arg0 : i5):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i5}> : () -> i5
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i5, i5) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem squared_nsw_sgt0_proof : squared_nsw_sgt0_before ⊑ squared_nsw_sgt0_after := by
  sorry



def slt_positive_multip_rem_zero_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_positive_multip_rem_zero_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem slt_positive_multip_rem_zero_proof : slt_positive_multip_rem_zero_before ⊑ slt_positive_multip_rem_zero_after := by
  sorry



def slt_negative_multip_rem_zero_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_negative_multip_rem_zero_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -3 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem slt_negative_multip_rem_zero_proof : slt_negative_multip_rem_zero_before ⊑ slt_negative_multip_rem_zero_after := by
  sorry



def slt_positive_multip_rem_nz_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_positive_multip_rem_nz_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem slt_positive_multip_rem_nz_proof : slt_positive_multip_rem_nz_before ⊑ slt_positive_multip_rem_nz_after := by
  sorry



def ult_rem_zero_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_rem_zero_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ult_rem_zero_proof : ult_rem_zero_before ⊑ ult_rem_zero_after := by
  sorry



def ult_rem_zero_nsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_rem_zero_nsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ult_rem_zero_nsw_proof : ult_rem_zero_nsw_before ⊑ ult_rem_zero_nsw_after := by
  sorry



def ult_rem_nz_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_rem_nz_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ult_rem_nz_proof : ult_rem_nz_before ⊑ ult_rem_nz_after := by
  sorry



def ult_rem_nz_nsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_rem_nz_nsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ult_rem_nz_nsw_proof : ult_rem_nz_nsw_before ⊑ ult_rem_nz_nsw_after := by
  sorry



def sgt_positive_multip_rem_zero_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_positive_multip_rem_zero_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sgt_positive_multip_rem_zero_proof : sgt_positive_multip_rem_zero_before ⊑ sgt_positive_multip_rem_zero_after := by
  sorry



def sgt_negative_multip_rem_zero_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_negative_multip_rem_zero_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -3 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sgt_negative_multip_rem_zero_proof : sgt_negative_multip_rem_zero_before ⊑ sgt_negative_multip_rem_zero_after := by
  sorry



def sgt_positive_multip_rem_nz_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_positive_multip_rem_nz_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sgt_positive_multip_rem_nz_proof : sgt_positive_multip_rem_nz_before ⊑ sgt_positive_multip_rem_nz_after := by
  sorry



def ugt_rem_zero_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_rem_zero_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ugt_rem_zero_proof : ugt_rem_zero_before ⊑ ugt_rem_zero_after := by
  sorry



def ugt_rem_zero_nsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_rem_zero_nsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ugt_rem_zero_nsw_proof : ugt_rem_zero_nsw_before ⊑ ugt_rem_zero_nsw_after := by
  sorry



def ugt_rem_nz_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_rem_nz_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ugt_rem_nz_proof : ugt_rem_nz_before ⊑ ugt_rem_nz_after := by
  sorry



def ugt_rem_nz_nsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_rem_nz_nsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ugt_rem_nz_nsw_proof : ugt_rem_nz_nsw_before ⊑ ugt_rem_nz_nsw_after := by
  sorry



def eq_nsw_rem_zero_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 20 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_nsw_rem_zero_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -4 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem eq_nsw_rem_zero_proof : eq_nsw_rem_zero_before ⊑ eq_nsw_rem_zero_after := by
  sorry



def ne_nsw_rem_zero_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<5> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-30> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.mul %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def ne_nsw_rem_zero_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-6> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem ne_nsw_rem_zero_proof : ne_nsw_rem_zero_before ⊑ ne_nsw_rem_zero_after := by
  sorry



def eq_nsw_rem_nz_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -11 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_nsw_rem_nz_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem eq_nsw_rem_nz_proof : eq_nsw_rem_nz_before ⊑ eq_nsw_rem_nz_after := by
  sorry



def ne_nsw_rem_nz_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -126 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ne_nsw_rem_nz_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ne_nsw_rem_nz_proof : ne_nsw_rem_nz_before ⊑ ne_nsw_rem_nz_after := by
  sorry



def eq_nuw_rem_zero_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<5> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<20> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.mul %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def eq_nuw_rem_zero_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem eq_nuw_rem_zero_proof : eq_nuw_rem_zero_before ⊑ eq_nuw_rem_zero_after := by
  sorry



def ne_nuw_rem_zero_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -126 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ne_nuw_rem_zero_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 26 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ne_nuw_rem_zero_proof : ne_nuw_rem_zero_before ⊑ ne_nuw_rem_zero_after := by
  sorry



def eq_nuw_rem_nz_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 20 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_nuw_rem_nz_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem eq_nuw_rem_nz_proof : eq_nuw_rem_nz_before ⊑ eq_nuw_rem_nz_after := by
  sorry



def ne_nuw_rem_nz_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -30 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ne_nuw_rem_nz_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ne_nuw_rem_nz_proof : ne_nuw_rem_nz_before ⊑ ne_nuw_rem_nz_after := by
  sorry



def sgt_minnum_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_minnum_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sgt_minnum_proof : sgt_minnum_before ⊑ sgt_minnum_after := by
  sorry



def ule_bignum_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_bignum_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ule_bignum_proof : ule_bignum_before ⊑ ule_bignum_after := by
  sorry



def sgt_mulzero_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 21 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_mulzero_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sgt_mulzero_proof : sgt_mulzero_before ⊑ sgt_mulzero_after := by
  sorry



def eq_rem_zero_nonuw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 20 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_rem_zero_nonuw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem eq_rem_zero_nonuw_proof : eq_rem_zero_nonuw_before ⊑ eq_rem_zero_nonuw_after := by
  sorry



def ne_rem_zero_nonuw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 30 : i8}> : () -> i8
  %2 = llvm.mul %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ne_rem_zero_nonuw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ne_rem_zero_nonuw_proof : ne_rem_zero_nonuw_before ⊑ ne_rem_zero_nonuw_after := by
  sorry



def mul_constant_eq_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_constant_eq_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem mul_constant_eq_proof : mul_constant_eq_before ⊑ mul_constant_eq_after := by
  sorry



def mul_constant_ne_splat_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<5> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.mul %arg0, %0 : vector<2xi32>
  %2 = llvm.mul %arg1, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def mul_constant_ne_splat_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
theorem mul_constant_ne_splat_proof : mul_constant_ne_splat_before ⊑ mul_constant_ne_splat_after := by
  sorry



def mul_constant_eq_nsw_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_constant_eq_nsw_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem mul_constant_eq_nsw_proof : mul_constant_eq_nsw_before ⊑ mul_constant_eq_nsw_after := by
  sorry



def mul_constant_ne_nsw_splat_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<12> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.mul %arg0, %0 : vector<2xi32>
  %2 = llvm.mul %arg1, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def mul_constant_ne_nsw_splat_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
theorem mul_constant_ne_nsw_splat_proof : mul_constant_ne_nsw_splat_before ⊑ mul_constant_ne_nsw_splat_after := by
  sorry



def mul_constant_nuw_eq_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 22 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_constant_nuw_eq_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem mul_constant_nuw_eq_proof : mul_constant_nuw_eq_before ⊑ mul_constant_nuw_eq_after := by
  sorry



def mul_constant_ne_nuw_splat_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<10> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.mul %arg0, %0 : vector<2xi32>
  %2 = llvm.mul %arg1, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def mul_constant_ne_nuw_splat_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
theorem mul_constant_ne_nuw_splat_proof : mul_constant_ne_nuw_splat_before ⊑ mul_constant_ne_nuw_splat_after := by
  sorry



def mul_constant_partial_nuw_eq_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 44 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_constant_partial_nuw_eq_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1073741823 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem mul_constant_partial_nuw_eq_proof : mul_constant_partial_nuw_eq_before ⊑ mul_constant_partial_nuw_eq_after := by
  sorry



def mul_constant_mismatch_wrap_eq_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 54 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def mul_constant_mismatch_wrap_eq_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem mul_constant_mismatch_wrap_eq_proof : mul_constant_mismatch_wrap_eq_before ⊑ mul_constant_mismatch_wrap_eq_after := by
  sorry



def eq_mul_constants_with_tz_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %0 : i32
  %2 = llvm.mul %arg1, %0 : i32
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_mul_constants_with_tz_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1073741823 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %arg1 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem eq_mul_constants_with_tz_proof : eq_mul_constants_with_tz_before ⊑ eq_mul_constants_with_tz_after := by
  sorry



def eq_mul_constants_with_tz_splat_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<12> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.mul %arg0, %0 : vector<2xi32>
  %2 = llvm.mul %arg1, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%1, %2) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def eq_mul_constants_with_tz_splat_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1073741823> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = llvm.xor %arg0, %arg1 : vector<2xi32>
  %4 = llvm.and %3, %0 : vector<2xi32>
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
theorem eq_mul_constants_with_tz_splat_proof : eq_mul_constants_with_tz_splat_before ⊑ eq_mul_constants_with_tz_splat_after := by
  sorry



def mul_of_bool_commute_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 255 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_of_bool_commute_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem mul_of_bool_commute_proof : mul_of_bool_commute_before ⊑ mul_of_bool_commute_after := by
  sorry



def mul_of_bools_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %0 : i32
  %4 = llvm.mul %2, %3 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def mul_of_bools_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem mul_of_bools_proof : mul_of_bools_before ⊑ mul_of_bools_after := by
  sorry



def mul_of_pow2_commute_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 255 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 1020 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = llvm.and %arg1, %1 : i32
  %5 = llvm.mul %4, %3 : i32
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def mul_of_pow2_commute_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem mul_of_pow2_commute_proof : mul_of_pow2_commute_before ⊑ mul_of_pow2_commute_after := by
  sorry



def mul_of_pow2s_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 16 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = llvm.and %arg1, %1 : i32
  %5 = llvm.mul %3, %4 : i32
  %6 = llvm.or %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def mul_of_pow2s_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 128 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem mul_of_pow2s_proof : mul_of_pow2s_before ⊑ mul_of_pow2s_after := by
  sorry



def mul_oddC_ne_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<12> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.mul %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def mul_oddC_ne_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem mul_oddC_ne_vec_proof : mul_oddC_ne_vec_before ⊑ mul_oddC_ne_vec_after := by
  sorry



def mul_mixed_nuw_nsw_xy_z_setodd_ult_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = llvm.or %arg2, %0 : i8
  %2 = llvm.mul %arg0, %1 : i8
  %3 = llvm.mul %arg1, %1 : i8
  %4 = "llvm.icmp"(%2, %3) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def mul_mixed_nuw_nsw_xy_z_setodd_ult_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = llvm.or %arg2, %0 : i8
  %2 = llvm.mul %1, %arg0 : i8
  %3 = llvm.mul %1, %arg1 : i8
  %4 = "llvm.icmp"(%2, %3) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem mul_mixed_nuw_nsw_xy_z_setodd_ult_proof : mul_mixed_nuw_nsw_xy_z_setodd_ult_before ⊑ mul_mixed_nuw_nsw_xy_z_setodd_ult_after := by
  sorry



def mul_nuw_xy_z_setnonzero_vec_eq_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>, %arg2 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[41, 12]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.or %arg2, %0 : vector<2xi8>
  %2 = llvm.mul %1, %arg0 : vector<2xi8>
  %3 = llvm.mul %1, %arg1 : vector<2xi8>
  %4 = "llvm.icmp"(%2, %3) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def mul_nuw_xy_z_setnonzero_vec_eq_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>, %arg2 : vector<2xi8>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
theorem mul_nuw_xy_z_setnonzero_vec_eq_proof : mul_nuw_xy_z_setnonzero_vec_eq_before ⊑ mul_nuw_xy_z_setnonzero_vec_eq_after := by
  sorry



def mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>, %arg2 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[1, 3]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.or %arg2, %0 : vector<2xi8>
  %2 = llvm.mul %arg0, %1 : vector<2xi8>
  %3 = llvm.mul %1, %arg1 : vector<2xi8>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 7 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>, %arg2 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[1, 3]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.or %arg2, %0 : vector<2xi8>
  %2 = llvm.mul %1, %arg0 : vector<2xi8>
  %3 = llvm.mul %1, %arg1 : vector<2xi8>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 7 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
theorem mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule_proof : mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule_before ⊑ mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule_after := by
  sorry


