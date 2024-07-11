
def t0_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  sorry



def t1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 5 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def t1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem t1_proof : t1_before ⊑ t1_after := by
  sorry



def t2_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def t2_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem t2_proof : t2_before ⊑ t2_after := by
  sorry



def t3_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def t3_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem t3_proof : t3_before ⊑ t3_after := by
  sorry



def t4_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def t4_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem t4_proof : t4_before ⊑ t4_after := by
  sorry



def t5_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def t5_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem t5_proof : t5_before ⊑ t5_after := by
  sorry



def t6_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def t6_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem t6_proof : t6_before ⊑ t6_after := by
  sorry



def t7_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def t7_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem t7_proof : t7_before ⊑ t7_after := by
  sorry



def t8_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def t8_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem t8_proof : t8_before ⊑ t8_after := by
  sorry



def t9_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def t9_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem t9_proof : t9_before ⊑ t9_after := by
  sorry


