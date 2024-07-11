
def icmp_shl_ugt_1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def icmp_shl_ugt_1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_shl_ugt_1_proof : icmp_shl_ugt_1_before ⊑ icmp_shl_ugt_1_after := by
  sorry



def icmp_shl_ugt_2_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %0, %arg0 : vector<2xi32>
  %3 = llvm.shl %2, %1 : vector<2xi32>
  %4 = "llvm.icmp"(%2, %3) <{"predicate" = 8 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def icmp_shl_ugt_2_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<42> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = llvm.add %arg0, %0 : vector<2xi32>
  %4 = "llvm.icmp"(%3, %2) <{"predicate" = 2 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
theorem icmp_shl_ugt_2_proof : icmp_shl_ugt_2_before ⊑ icmp_shl_ugt_2_after := by
  sorry



def icmp_shl_uge_1_before := [llvm|
{
^0(%arg0 : vector<3xi7>):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i7}> : () -> i7
  %1 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<3xi7>}> : () -> vector<3xi7>
  %2 = llvm.shl %arg0, %1 : vector<3xi7>
  %3 = "llvm.icmp"(%2, %arg0) <{"predicate" = 9 : i64}> : (vector<3xi7>, vector<3xi7>) -> vector<3xi1>
  "llvm.return"(%3) : (vector<3xi1>) -> ()
}
]
def icmp_shl_uge_1_after := [llvm|
{
^0(%arg0 : vector<3xi7>):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i7}> : () -> i7
  %1 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<3xi7>}> : () -> vector<3xi7>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 4 : i64}> : (vector<3xi7>, vector<3xi7>) -> vector<3xi1>
  "llvm.return"(%2) : (vector<3xi1>) -> ()
}
]
theorem icmp_shl_uge_1_proof : icmp_shl_uge_1_before ⊑ icmp_shl_uge_1_after := by
  sorry



def icmp_shl_uge_2_before := [llvm|
{
^0(%arg0 : i5):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i5}> : () -> i5
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i5}> : () -> i5
  %2 = llvm.add %0, %arg0 : i5
  %3 = llvm.shl %2, %1 : i5
  %4 = "llvm.icmp"(%2, %3) <{"predicate" = 9 : i64}> : (i5, i5) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_shl_uge_2_after := [llvm|
{
^0(%arg0 : i5):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i5}> : () -> i5
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i5}> : () -> i5
  %2 = llvm.add %arg0, %0 : i5
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i5, i5) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem icmp_shl_uge_2_proof : icmp_shl_uge_2_before ⊑ icmp_shl_uge_2_after := by
  sorry



def icmp_shl_ule_2_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = llvm.add %0, %arg0 : i8
  %3 = llvm.shl %2, %1 : i8
  %4 = "llvm.icmp"(%2, %3) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def icmp_shl_ule_2_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 4 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem icmp_shl_ule_2_proof : icmp_shl_ule_2_before ⊑ icmp_shl_ule_2_after := by
  sorry



def icmp_shl_eq_1_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = llvm.shl %arg0, %0 : i8
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def icmp_shl_eq_1_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem icmp_shl_eq_1_proof : icmp_shl_eq_1_before ⊑ icmp_shl_eq_1_after := by
  sorry



def icmp_shl_ne_1_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.shl %arg0, %0 : vector<2xi8>
  %2 = "llvm.icmp"(%1, %arg0) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
def icmp_shl_ne_1_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem icmp_shl_ne_1_proof : icmp_shl_ne_1_before ⊑ icmp_shl_ne_1_after := by
  sorry


