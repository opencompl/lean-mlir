
def slt_and_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_and_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem slt_and_max_proof : slt_and_max_before ⊑ slt_and_max_after := by
  sorry



def slt_and_max_commute_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<127> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %3 = llvm.and %2, %1 : vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def slt_and_max_commute_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem slt_and_max_commute_proof : slt_and_max_commute_before ⊑ slt_and_max_commute_after := by
  sorry



def slt_swap_and_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_swap_and_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem slt_swap_and_max_proof : slt_swap_and_max_before ⊑ slt_swap_and_max_after := by
  sorry



def slt_swap_and_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_swap_and_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem slt_swap_and_max_commute_proof : slt_swap_and_max_commute_before ⊑ slt_swap_and_max_commute_after := by
  sorry



def ult_and_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_and_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ult_and_max_proof : ult_and_max_before ⊑ ult_and_max_after := by
  sorry



def ult_and_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_and_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ult_and_max_commute_proof : ult_and_max_commute_before ⊑ ult_and_max_commute_after := by
  sorry



def ult_swap_and_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_swap_and_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ult_swap_and_max_proof : ult_swap_and_max_before ⊑ ult_swap_and_max_after := by
  sorry



def ult_swap_and_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_swap_and_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ult_swap_and_max_commute_proof : ult_swap_and_max_commute_before ⊑ ult_swap_and_max_commute_after := by
  sorry



def sgt_and_min_before := [llvm|
{
^0(%arg0 : i9, %arg1 : i9):
  %0 = "llvm.mlir.constant"() <{"value" = -256 : i9}> : () -> i9
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i9, i9) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i9, i9) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_and_min_after := [llvm|
{
^0(%arg0 : i9, %arg1 : i9):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sgt_and_min_proof : sgt_and_min_before ⊑ sgt_and_min_after := by
  sorry



def sgt_and_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_and_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sgt_and_min_commute_proof : sgt_and_min_commute_before ⊑ sgt_and_min_commute_after := by
  sorry



def sgt_swap_and_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_swap_and_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sgt_swap_and_min_proof : sgt_swap_and_min_before ⊑ sgt_swap_and_min_after := by
  sorry



def sgt_swap_and_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_swap_and_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sgt_swap_and_min_commute_proof : sgt_swap_and_min_commute_before ⊑ sgt_swap_and_min_commute_after := by
  sorry



def ugt_and_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_and_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ugt_and_min_proof : ugt_and_min_before ⊑ ugt_and_min_after := by
  sorry



def ugt_and_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_and_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ugt_and_min_commute_proof : ugt_and_min_commute_before ⊑ ugt_and_min_commute_after := by
  sorry



def ugt_swap_and_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_swap_and_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ugt_swap_and_min_proof : ugt_swap_and_min_before ⊑ ugt_swap_and_min_after := by
  sorry



def ugt_swap_and_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_swap_and_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ugt_swap_and_min_commute_proof : ugt_swap_and_min_commute_before ⊑ ugt_swap_and_min_commute_after := by
  sorry



def sge_or_not_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_or_not_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sge_or_not_max_proof : sge_or_not_max_before ⊑ sge_or_not_max_after := by
  sorry



def sge_or_not_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_or_not_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sge_or_not_max_commute_proof : sge_or_not_max_commute_before ⊑ sge_or_not_max_commute_after := by
  sorry



def sge_swap_or_not_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_swap_or_not_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sge_swap_or_not_max_proof : sge_swap_or_not_max_before ⊑ sge_swap_or_not_max_after := by
  sorry



def sge_swap_or_not_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_swap_or_not_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sge_swap_or_not_max_commute_proof : sge_swap_or_not_max_commute_before ⊑ sge_swap_or_not_max_commute_after := by
  sorry



def uge_or_not_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_or_not_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem uge_or_not_max_proof : uge_or_not_max_before ⊑ uge_or_not_max_after := by
  sorry



def uge_or_not_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_or_not_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem uge_or_not_max_commute_proof : uge_or_not_max_commute_before ⊑ uge_or_not_max_commute_after := by
  sorry



def uge_swap_or_not_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_swap_or_not_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem uge_swap_or_not_max_proof : uge_swap_or_not_max_before ⊑ uge_swap_or_not_max_after := by
  sorry



def uge_swap_or_not_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_swap_or_not_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem uge_swap_or_not_max_commute_proof : uge_swap_or_not_max_commute_before ⊑ uge_swap_or_not_max_commute_after := by
  sorry



def sle_or_not_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_or_not_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sle_or_not_min_proof : sle_or_not_min_before ⊑ sle_or_not_min_after := by
  sorry



def sle_or_not_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_or_not_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sle_or_not_min_commute_proof : sle_or_not_min_commute_before ⊑ sle_or_not_min_commute_after := by
  sorry



def sle_swap_or_not_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_swap_or_not_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sle_swap_or_not_min_proof : sle_swap_or_not_min_before ⊑ sle_swap_or_not_min_after := by
  sorry



def sle_swap_or_not_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_swap_or_not_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sle_swap_or_not_min_commute_proof : sle_swap_or_not_min_commute_before ⊑ sle_swap_or_not_min_commute_after := by
  sorry



def ule_or_not_min_before := [llvm|
{
^0(%arg0 : i427, %arg1 : i427):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i427}> : () -> i427
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 7 : i64}> : (i427, i427) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i427, i427) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_or_not_min_after := [llvm|
{
^0(%arg0 : i427, %arg1 : i427):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ule_or_not_min_proof : ule_or_not_min_before ⊑ ule_or_not_min_after := by
  sorry



def ule_or_not_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_or_not_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ule_or_not_min_commute_proof : ule_or_not_min_commute_before ⊑ ule_or_not_min_commute_after := by
  sorry



def ule_swap_or_not_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_swap_or_not_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ule_swap_or_not_min_proof : ule_swap_or_not_min_before ⊑ ule_swap_or_not_min_after := by
  sorry



def ule_swap_or_not_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_swap_or_not_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ule_swap_or_not_min_commute_proof : ule_swap_or_not_min_commute_before ⊑ ule_swap_or_not_min_commute_after := by
  sorry



def sge_and_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_and_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sge_and_max_proof : sge_and_max_before ⊑ sge_and_max_after := by
  sorry



def sge_and_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_and_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sge_and_max_commute_proof : sge_and_max_commute_before ⊑ sge_and_max_commute_after := by
  sorry



def sge_swap_and_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_swap_and_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sge_swap_and_max_proof : sge_swap_and_max_before ⊑ sge_swap_and_max_after := by
  sorry



def sge_swap_and_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_swap_and_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sge_swap_and_max_commute_proof : sge_swap_and_max_commute_before ⊑ sge_swap_and_max_commute_after := by
  sorry



def uge_and_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_and_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem uge_and_max_proof : uge_and_max_before ⊑ uge_and_max_after := by
  sorry



def uge_and_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_and_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem uge_and_max_commute_proof : uge_and_max_commute_before ⊑ uge_and_max_commute_after := by
  sorry



def uge_swap_and_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_swap_and_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem uge_swap_and_max_proof : uge_swap_and_max_before ⊑ uge_swap_and_max_after := by
  sorry



def uge_swap_and_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_swap_and_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem uge_swap_and_max_commute_proof : uge_swap_and_max_commute_before ⊑ uge_swap_and_max_commute_after := by
  sorry



def sle_and_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_and_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sle_and_min_proof : sle_and_min_before ⊑ sle_and_min_after := by
  sorry



def sle_and_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_and_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sle_and_min_commute_proof : sle_and_min_commute_before ⊑ sle_and_min_commute_after := by
  sorry



def sle_swap_and_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_swap_and_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sle_swap_and_min_proof : sle_swap_and_min_before ⊑ sle_swap_and_min_after := by
  sorry



def sle_swap_and_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_swap_and_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sle_swap_and_min_commute_proof : sle_swap_and_min_commute_before ⊑ sle_swap_and_min_commute_after := by
  sorry



def ule_and_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_and_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ule_and_min_proof : ule_and_min_before ⊑ ule_and_min_after := by
  sorry



def ule_and_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_and_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ule_and_min_commute_proof : ule_and_min_commute_before ⊑ ule_and_min_commute_after := by
  sorry



def ule_swap_and_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_swap_and_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ule_swap_and_min_proof : ule_swap_and_min_before ⊑ ule_swap_and_min_after := by
  sorry



def ule_swap_and_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_swap_and_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ule_swap_and_min_commute_proof : ule_swap_and_min_commute_before ⊑ ule_swap_and_min_commute_after := by
  sorry



def sge_or_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_or_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sge_or_max_proof : sge_or_max_before ⊑ sge_or_max_after := by
  sorry



def sge_or_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_or_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sge_or_max_commute_proof : sge_or_max_commute_before ⊑ sge_or_max_commute_after := by
  sorry



def sge_swap_or_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_swap_or_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sge_swap_or_max_proof : sge_swap_or_max_before ⊑ sge_swap_or_max_after := by
  sorry



def sge_swap_or_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_swap_or_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sge_swap_or_max_commute_proof : sge_swap_or_max_commute_before ⊑ sge_swap_or_max_commute_after := by
  sorry



def uge_or_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_or_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem uge_or_max_proof : uge_or_max_before ⊑ uge_or_max_after := by
  sorry



def uge_or_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_or_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem uge_or_max_commute_proof : uge_or_max_commute_before ⊑ uge_or_max_commute_after := by
  sorry



def uge_swap_or_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_swap_or_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem uge_swap_or_max_proof : uge_swap_or_max_before ⊑ uge_swap_or_max_after := by
  sorry



def uge_swap_or_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_swap_or_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem uge_swap_or_max_commute_proof : uge_swap_or_max_commute_before ⊑ uge_swap_or_max_commute_after := by
  sorry



def sle_or_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_or_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sle_or_min_proof : sle_or_min_before ⊑ sle_or_min_after := by
  sorry



def sle_or_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_or_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sle_or_min_commute_proof : sle_or_min_commute_before ⊑ sle_or_min_commute_after := by
  sorry



def sle_swap_or_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_swap_or_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sle_swap_or_min_proof : sle_swap_or_min_before ⊑ sle_swap_or_min_after := by
  sorry



def sle_swap_or_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_swap_or_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sle_swap_or_min_commute_proof : sle_swap_or_min_commute_before ⊑ sle_swap_or_min_commute_after := by
  sorry



def ule_or_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_or_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ule_or_min_proof : ule_or_min_before ⊑ ule_or_min_after := by
  sorry



def ule_or_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_or_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ule_or_min_commute_proof : ule_or_min_commute_before ⊑ ule_or_min_commute_after := by
  sorry



def ule_swap_or_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_swap_or_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ule_swap_or_min_proof : ule_swap_or_min_before ⊑ ule_swap_or_min_after := by
  sorry



def ule_swap_or_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_swap_or_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ule_swap_or_min_commute_proof : ule_swap_or_min_commute_before ⊑ ule_swap_or_min_commute_after := by
  sorry



def slt_and_not_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_and_not_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem slt_and_not_max_proof : slt_and_not_max_before ⊑ slt_and_not_max_after := by
  sorry



def slt_and_not_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_and_not_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem slt_and_not_max_commute_proof : slt_and_not_max_commute_before ⊑ slt_and_not_max_commute_after := by
  sorry



def slt_swap_and_not_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_swap_and_not_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem slt_swap_and_not_max_proof : slt_swap_and_not_max_before ⊑ slt_swap_and_not_max_after := by
  sorry



def slt_swap_and_not_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_swap_and_not_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem slt_swap_and_not_max_commute_proof : slt_swap_and_not_max_commute_before ⊑ slt_swap_and_not_max_commute_after := by
  sorry



def ult_and_not_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_and_not_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ult_and_not_max_proof : ult_and_not_max_before ⊑ ult_and_not_max_after := by
  sorry



def ult_and_not_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_and_not_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ult_and_not_max_commute_proof : ult_and_not_max_commute_before ⊑ ult_and_not_max_commute_after := by
  sorry



def ult_swap_and_not_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_swap_and_not_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ult_swap_and_not_max_proof : ult_swap_and_not_max_before ⊑ ult_swap_and_not_max_after := by
  sorry



def ult_swap_and_not_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_swap_and_not_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ult_swap_and_not_max_commute_proof : ult_swap_and_not_max_commute_before ⊑ ult_swap_and_not_max_commute_after := by
  sorry



def sgt_and_not_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_and_not_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sgt_and_not_min_proof : sgt_and_not_min_before ⊑ sgt_and_not_min_after := by
  sorry



def sgt_and_not_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_and_not_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sgt_and_not_min_commute_proof : sgt_and_not_min_commute_before ⊑ sgt_and_not_min_commute_after := by
  sorry



def sgt_swap_and_not_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_swap_and_not_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sgt_swap_and_not_min_proof : sgt_swap_and_not_min_before ⊑ sgt_swap_and_not_min_after := by
  sorry



def sgt_swap_and_not_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_swap_and_not_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem sgt_swap_and_not_min_commute_proof : sgt_swap_and_not_min_commute_before ⊑ sgt_swap_and_not_min_commute_after := by
  sorry



def ugt_and_not_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_and_not_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ugt_and_not_min_proof : ugt_and_not_min_before ⊑ ugt_and_not_min_after := by
  sorry



def ugt_and_not_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_and_not_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ugt_and_not_min_commute_proof : ugt_and_not_min_commute_before ⊑ ugt_and_not_min_commute_after := by
  sorry



def ugt_swap_and_not_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_swap_and_not_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ugt_swap_and_not_min_proof : ugt_swap_and_not_min_before ⊑ ugt_swap_and_not_min_after := by
  sorry



def ugt_swap_and_not_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_swap_and_not_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem ugt_swap_and_not_min_commute_proof : ugt_swap_and_not_min_commute_before ⊑ ugt_swap_and_not_min_commute_after := by
  sorry



def slt_or_not_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_or_not_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem slt_or_not_max_proof : slt_or_not_max_before ⊑ slt_or_not_max_after := by
  sorry



def slt_or_not_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_or_not_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem slt_or_not_max_commute_proof : slt_or_not_max_commute_before ⊑ slt_or_not_max_commute_after := by
  sorry



def slt_swap_or_not_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_swap_or_not_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem slt_swap_or_not_max_proof : slt_swap_or_not_max_before ⊑ slt_swap_or_not_max_after := by
  sorry



def slt_swap_or_not_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_swap_or_not_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem slt_swap_or_not_max_commute_proof : slt_swap_or_not_max_commute_before ⊑ slt_swap_or_not_max_commute_after := by
  sorry



def ult_or_not_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_or_not_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ult_or_not_max_proof : ult_or_not_max_before ⊑ ult_or_not_max_after := by
  sorry



def ult_or_not_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_or_not_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ult_or_not_max_commute_proof : ult_or_not_max_commute_before ⊑ ult_or_not_max_commute_after := by
  sorry



def ult_swap_or_not_max_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_swap_or_not_max_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ult_swap_or_not_max_proof : ult_swap_or_not_max_before ⊑ ult_swap_or_not_max_after := by
  sorry



def ult_swap_or_not_max_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_swap_or_not_max_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ult_swap_or_not_max_commute_proof : ult_swap_or_not_max_commute_before ⊑ ult_swap_or_not_max_commute_after := by
  sorry



def sgt_or_not_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_or_not_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sgt_or_not_min_proof : sgt_or_not_min_before ⊑ sgt_or_not_min_after := by
  sorry



def sgt_or_not_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_or_not_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sgt_or_not_min_commute_proof : sgt_or_not_min_commute_before ⊑ sgt_or_not_min_commute_after := by
  sorry



def sgt_swap_or_not_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_swap_or_not_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sgt_swap_or_not_min_proof : sgt_swap_or_not_min_before ⊑ sgt_swap_or_not_min_after := by
  sorry



def sgt_swap_or_not_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_swap_or_not_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem sgt_swap_or_not_min_commute_proof : sgt_swap_or_not_min_commute_before ⊑ sgt_swap_or_not_min_commute_after := by
  sorry



def ugt_or_not_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_or_not_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ugt_or_not_min_proof : ugt_or_not_min_before ⊑ ugt_or_not_min_after := by
  sorry



def ugt_or_not_min_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_or_not_min_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ugt_or_not_min_commute_proof : ugt_or_not_min_commute_before ⊑ ugt_or_not_min_commute_after := by
  sorry



def ugt_swap_or_not_min_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_swap_or_not_min_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ugt_swap_or_not_min_proof : ugt_swap_or_not_min_before ⊑ ugt_swap_or_not_min_after := by
  sorry



def ugt_swap_or_not_min_commute_before := [llvm|
{
^0(%arg0 : i823, %arg1 : i823):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i823}> : () -> i823
  %1 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 6 : i64}> : (i823, i823) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i823, i823) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_swap_or_not_min_commute_after := [llvm|
{
^0(%arg0 : i823, %arg1 : i823):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i823}> : () -> i823
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i823, i823) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem ugt_swap_or_not_min_commute_proof : ugt_swap_or_not_min_commute_before ⊑ ugt_swap_or_not_min_commute_after := by
  sorry


