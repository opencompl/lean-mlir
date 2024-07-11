
def eq_basic_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_basic_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = "llvm.icmp"(%1, %arg1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem eq_basic_proof : eq_basic_before ⊑ eq_basic_after := by
  sorry



def ne_basic_equal_5_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %4 = "llvm.icmp"(%2, %arg1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def ne_basic_equal_5_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -6 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = "llvm.icmp"(%1, %arg1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem ne_basic_equal_5_proof : ne_basic_equal_5_before ⊑ ne_basic_equal_5_after := by
  sorry



def eq_basic_equal_minus_1_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %4 = "llvm.icmp"(%2, %arg1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def eq_basic_equal_minus_1_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem eq_basic_equal_minus_1_proof : eq_basic_equal_minus_1_before ⊑ eq_basic_equal_minus_1_after := by
  sorry



def ne_basic_equal_minus_7_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -7 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %4 = "llvm.icmp"(%2, %arg1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def ne_basic_equal_minus_7_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = "llvm.icmp"(%1, %arg1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem ne_basic_equal_minus_7_proof : ne_basic_equal_minus_7_before ⊑ ne_basic_equal_minus_7_after := by
  sorry



def eq_vector_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %3 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 8 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %4 = llvm.or %2, %3 : vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def eq_vector_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.add %arg0, %0 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %arg1) <{"predicate" = 9 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem eq_vector_proof : eq_vector_before ⊑ eq_vector_after := by
  sorry



def ne_vector_equal_5_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-5> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<5> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.add %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %4 = "llvm.icmp"(%2, %arg1) <{"predicate" = 7 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %5 = llvm.and %3, %4 : vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def ne_vector_equal_5_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-6> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.add %arg0, %0 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %arg1) <{"predicate" = 6 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem ne_vector_equal_5_proof : ne_vector_equal_5_before ⊑ ne_vector_equal_5_after := by
  sorry



def eq_vector_equal_minus_1_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.add %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %4 = "llvm.icmp"(%2, %arg1) <{"predicate" = 8 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %5 = llvm.or %3, %4 : vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def eq_vector_equal_minus_1_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 9 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%0) : (vector<2xi1>) -> ()
}
]
theorem eq_vector_equal_minus_1_proof : eq_vector_equal_minus_1_before ⊑ eq_vector_equal_minus_1_after := by
  sorry



def ne_vector_equal_minus_7_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<7> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-7> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.add %arg0, %0 : vector<2xi8>
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %4 = "llvm.icmp"(%2, %arg1) <{"predicate" = 7 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %5 = llvm.and %3, %4 : vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def ne_vector_equal_minus_7_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.add %arg0, %0 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %arg1) <{"predicate" = 6 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem ne_vector_equal_minus_7_proof : ne_vector_equal_minus_7_before ⊑ ne_vector_equal_minus_7_after := by
  sorry


