
def eq_t_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def eq_t_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem eq_t_not_proof : eq_t_not_before ⊑ eq_t_not_after := by
  sorry



def eq_f_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %3 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  %4 = llvm.xor %arg0, %1 : vector<2xi1>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 0 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def eq_f_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  "llvm.return"(%arg0) : (vector<2xi1>) -> ()
}
]
theorem eq_f_not_proof : eq_f_not_before ⊑ eq_f_not_after := by
  sorry



def ne_t_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def ne_t_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  "llvm.return"(%arg0) : (vector<2xi1>) -> ()
}
]
theorem ne_t_not_proof : ne_t_not_before ⊑ ne_t_not_after := by
  sorry



def ne_f_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %3 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  %4 = llvm.xor %arg0, %1 : vector<2xi1>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 1 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def ne_f_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem ne_f_not_proof : ne_f_not_before ⊑ ne_f_not_after := by
  sorry



def ugt_t_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def ugt_t_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem ugt_t_not_proof : ugt_t_not_before ⊑ ugt_t_not_after := by
  sorry



def ugt_f_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %3 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  %4 = llvm.xor %arg0, %1 : vector<2xi1>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 8 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def ugt_f_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem ugt_f_not_proof : ugt_f_not_before ⊑ ugt_f_not_after := by
  sorry



def ult_t_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def ult_t_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  "llvm.return"(%arg0) : (vector<2xi1>) -> ()
}
]
theorem ult_t_not_proof : ult_t_not_before ⊑ ult_t_not_after := by
  sorry



def ult_f_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %3 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  %4 = llvm.xor %arg0, %1 : vector<2xi1>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 6 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def ult_f_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem ult_f_not_proof : ult_f_not_before ⊑ ult_f_not_after := by
  sorry



def sgt_t_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def sgt_t_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  "llvm.return"(%arg0) : (vector<2xi1>) -> ()
}
]
theorem sgt_t_not_proof : sgt_t_not_before ⊑ sgt_t_not_after := by
  sorry



def sgt_f_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %3 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  %4 = llvm.xor %arg0, %1 : vector<2xi1>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 4 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def sgt_f_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem sgt_f_not_proof : sgt_f_not_before ⊑ sgt_f_not_after := by
  sorry



def slt_t_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def slt_t_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem slt_t_not_proof : slt_t_not_before ⊑ slt_t_not_after := by
  sorry



def slt_f_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %3 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  %4 = llvm.xor %arg0, %1 : vector<2xi1>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 2 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def slt_f_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem slt_f_not_proof : slt_f_not_before ⊑ slt_f_not_after := by
  sorry



def uge_t_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 9 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def uge_t_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem uge_t_not_proof : uge_t_not_before ⊑ uge_t_not_after := by
  sorry



def uge_f_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %3 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  %4 = llvm.xor %arg0, %1 : vector<2xi1>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 9 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def uge_f_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem uge_f_not_proof : uge_f_not_before ⊑ uge_f_not_after := by
  sorry



def ule_t_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 7 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def ule_t_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem ule_t_not_proof : ule_t_not_before ⊑ ule_t_not_after := by
  sorry



def ule_f_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %3 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  %4 = llvm.xor %arg0, %1 : vector<2xi1>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 7 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def ule_f_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  "llvm.return"(%arg0) : (vector<2xi1>) -> ()
}
]
theorem ule_f_not_proof : ule_f_not_before ⊑ ule_f_not_after := by
  sorry



def sge_t_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 5 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def sge_t_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem sge_t_not_proof : sge_t_not_before ⊑ sge_t_not_after := by
  sorry



def sge_f_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %3 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  %4 = llvm.xor %arg0, %1 : vector<2xi1>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 5 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def sge_f_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  "llvm.return"(%arg0) : (vector<2xi1>) -> ()
}
]
theorem sge_f_not_proof : sge_f_not_before ⊑ sge_f_not_after := by
  sorry



def sle_t_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 3 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def sle_t_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = llvm.xor %arg0, %1 : vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem sle_t_not_proof : sle_t_not_before ⊑ sle_t_not_after := by
  sorry



def sle_f_not_before := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  %2 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  %3 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi1>}> : () -> vector<2xi1>
  %4 = llvm.xor %arg0, %1 : vector<2xi1>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 3 : i64}> : (vector<2xi1>, vector<2xi1>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def sle_f_not_after := [llvm|
{
^0(%arg0 : vector<2xi1>):
  %0 = "llvm.mlir.constant"() <{"value" = true}> : () -> i1
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi1>}> : () -> vector<2xi1>
  "llvm.return"(%1) : (vector<2xi1>) -> ()
}
]
theorem sle_f_not_proof : sle_f_not_before ⊑ sle_f_not_after := by
  sorry


