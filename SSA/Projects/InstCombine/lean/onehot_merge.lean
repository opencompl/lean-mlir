
def and_consts_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %3 = llvm.and %0, %arg0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %2, %arg0 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def and_consts_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem and_consts_proof : and_consts_before ⊑ and_consts_after := by
  sorry



def and_consts_vector_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<2xi32>}> : () -> vector<2xi32>
  %4 = llvm.and %0, %arg0 : vector<2xi32>
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %6 = llvm.and %3, %arg0 : vector<2xi32>
  %7 = "llvm.icmp"(%6, %2) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %8 = llvm.or %5, %7 : vector<2xi1>
  "llvm.return"(%8) : (vector<2xi1>) -> ()
}
]
def and_consts_vector_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<12> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.and %arg0, %0 : vector<2xi32>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem and_consts_vector_proof : and_consts_vector_before ⊑ and_consts_vector_after := by
  sorry



def foo1_and_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.shl %0, %arg1 : i32
  %3 = llvm.shl %0, %arg2 : i32
  %4 = llvm.and %2, %arg0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %3, %arg0 : i32
  %7 = "llvm.icmp"(%6, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def foo1_and_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg1 : i32
  %2 = llvm.shl %0, %arg2 : i32
  %3 = llvm.or %1, %2 : i32
  %4 = llvm.and %3, %arg0 : i32
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem foo1_and_proof : foo1_and_before ⊑ foo1_and_after := by
  sorry



def foo1_and_vector_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = llvm.shl %0, %arg1 : vector<2xi32>
  %4 = llvm.shl %0, %arg2 : vector<2xi32>
  %5 = llvm.and %3, %arg0 : vector<2xi32>
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %7 = llvm.and %4, %arg0 : vector<2xi32>
  %8 = "llvm.icmp"(%7, %2) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %9 = llvm.or %6, %8 : vector<2xi1>
  "llvm.return"(%9) : (vector<2xi1>) -> ()
}
]
def foo1_and_vector_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.shl %0, %arg1 : vector<2xi32>
  %2 = llvm.shl %0, %arg2 : vector<2xi32>
  %3 = llvm.or %1, %2 : vector<2xi32>
  %4 = llvm.and %3, %arg0 : vector<2xi32>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
theorem foo1_and_vector_proof : foo1_and_vector_before ⊑ foo1_and_vector_after := by
  sorry



def foo1_and_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.mul %arg0, %arg0 : i32
  %3 = llvm.shl %0, %arg1 : i32
  %4 = llvm.shl %0, %arg2 : i32
  %5 = llvm.and %2, %3 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %7 = llvm.and %4, %2 : i32
  %8 = "llvm.icmp"(%7, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %9 = llvm.or %6, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def foo1_and_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %arg0 : i32
  %2 = llvm.shl %0, %arg1 : i32
  %3 = llvm.shl %0, %arg2 : i32
  %4 = llvm.or %2, %3 : i32
  %5 = llvm.and %1, %4 : i32
  %6 = "llvm.icmp"(%5, %4) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
theorem foo1_and_commuted_proof : foo1_and_commuted_before ⊑ foo1_and_commuted_after := by
  sorry



def foo1_and_commuted_vector_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = llvm.mul %arg0, %arg0 : vector<2xi32>
  %4 = llvm.shl %0, %arg1 : vector<2xi32>
  %5 = llvm.shl %0, %arg2 : vector<2xi32>
  %6 = llvm.and %3, %4 : vector<2xi32>
  %7 = "llvm.icmp"(%6, %2) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %8 = llvm.and %5, %3 : vector<2xi32>
  %9 = "llvm.icmp"(%8, %2) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %10 = llvm.or %7, %9 : vector<2xi1>
  "llvm.return"(%10) : (vector<2xi1>) -> ()
}
]
def foo1_and_commuted_vector_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.mul %arg0, %arg0 : vector<2xi32>
  %2 = llvm.shl %0, %arg1 : vector<2xi32>
  %3 = llvm.shl %0, %arg2 : vector<2xi32>
  %4 = llvm.or %2, %3 : vector<2xi32>
  %5 = llvm.and %1, %4 : vector<2xi32>
  %6 = "llvm.icmp"(%5, %4) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%6) : (vector<2xi1>) -> ()
}
]
theorem foo1_and_commuted_vector_proof : foo1_and_commuted_vector_before ⊑ foo1_and_commuted_vector_after := by
  sorry



def or_consts_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %3 = llvm.and %0, %arg0 : i32
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %2, %arg0 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def or_consts_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem or_consts_proof : or_consts_before ⊑ or_consts_after := by
  sorry



def or_consts_vector_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<2xi32>}> : () -> vector<2xi32>
  %4 = llvm.and %0, %arg0 : vector<2xi32>
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %6 = llvm.and %3, %arg0 : vector<2xi32>
  %7 = "llvm.icmp"(%6, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %8 = llvm.and %5, %7 : vector<2xi1>
  "llvm.return"(%8) : (vector<2xi1>) -> ()
}
]
def or_consts_vector_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<12> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.and %arg0, %0 : vector<2xi32>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem or_consts_vector_proof : or_consts_vector_before ⊑ or_consts_vector_after := by
  sorry



def foo1_or_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.shl %0, %arg1 : i32
  %3 = llvm.shl %0, %arg2 : i32
  %4 = llvm.and %2, %arg0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %3, %arg0 : i32
  %7 = "llvm.icmp"(%6, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def foo1_or_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.shl %0, %arg1 : i32
  %2 = llvm.shl %0, %arg2 : i32
  %3 = llvm.or %1, %2 : i32
  %4 = llvm.and %3, %arg0 : i32
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem foo1_or_proof : foo1_or_before ⊑ foo1_or_after := by
  sorry



def foo1_or_vector_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = llvm.shl %0, %arg1 : vector<2xi32>
  %4 = llvm.shl %0, %arg2 : vector<2xi32>
  %5 = llvm.and %3, %arg0 : vector<2xi32>
  %6 = "llvm.icmp"(%5, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %7 = llvm.and %4, %arg0 : vector<2xi32>
  %8 = "llvm.icmp"(%7, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %9 = llvm.and %6, %8 : vector<2xi1>
  "llvm.return"(%9) : (vector<2xi1>) -> ()
}
]
def foo1_or_vector_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.shl %0, %arg1 : vector<2xi32>
  %2 = llvm.shl %0, %arg2 : vector<2xi32>
  %3 = llvm.or %1, %2 : vector<2xi32>
  %4 = llvm.and %3, %arg0 : vector<2xi32>
  %5 = "llvm.icmp"(%4, %3) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
theorem foo1_or_vector_proof : foo1_or_vector_before ⊑ foo1_or_vector_after := by
  sorry



def foo1_or_commuted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.mul %arg0, %arg0 : i32
  %3 = llvm.shl %0, %arg1 : i32
  %4 = llvm.shl %0, %arg2 : i32
  %5 = llvm.and %2, %3 : i32
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %7 = llvm.and %4, %2 : i32
  %8 = "llvm.icmp"(%7, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %9 = llvm.and %6, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def foo1_or_commuted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = llvm.mul %arg0, %arg0 : i32
  %2 = llvm.shl %0, %arg1 : i32
  %3 = llvm.shl %0, %arg2 : i32
  %4 = llvm.or %2, %3 : i32
  %5 = llvm.and %1, %4 : i32
  %6 = "llvm.icmp"(%5, %4) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
theorem foo1_or_commuted_proof : foo1_or_commuted_before ⊑ foo1_or_commuted_after := by
  sorry



def foo1_or_commuted_vector_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %3 = llvm.mul %arg0, %arg0 : vector<2xi32>
  %4 = llvm.shl %0, %arg1 : vector<2xi32>
  %5 = llvm.shl %0, %arg2 : vector<2xi32>
  %6 = llvm.and %3, %4 : vector<2xi32>
  %7 = "llvm.icmp"(%6, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %8 = llvm.and %5, %3 : vector<2xi32>
  %9 = "llvm.icmp"(%8, %2) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %10 = llvm.and %7, %9 : vector<2xi1>
  "llvm.return"(%10) : (vector<2xi1>) -> ()
}
]
def foo1_or_commuted_vector_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.mul %arg0, %arg0 : vector<2xi32>
  %2 = llvm.shl %0, %arg1 : vector<2xi32>
  %3 = llvm.shl %0, %arg2 : vector<2xi32>
  %4 = llvm.or %2, %3 : vector<2xi32>
  %5 = llvm.and %1, %4 : vector<2xi32>
  %6 = "llvm.icmp"(%5, %4) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%6) : (vector<2xi1>) -> ()
}
]
theorem foo1_or_commuted_vector_proof : foo1_or_commuted_vector_before ⊑ foo1_or_commuted_vector_after := by
  sorry



def foo1_and_signbit_lshr_without_shifting_signbit_both_sides_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %3 = llvm.shl %arg0, %arg2 : i32
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %5 = llvm.or %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def foo1_and_signbit_lshr_without_shifting_signbit_both_sides_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %arg1 : i32
  %2 = llvm.shl %arg0, %arg2 : i32
  %3 = llvm.and %1, %2 : i32
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem foo1_and_signbit_lshr_without_shifting_signbit_both_sides_proof : foo1_and_signbit_lshr_without_shifting_signbit_both_sides_before ⊑ foo1_and_signbit_lshr_without_shifting_signbit_both_sides_after := by
  sorry



def foo1_or_signbit_lshr_without_shifting_signbit_both_sides_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %3 = llvm.shl %arg0, %arg2 : i32
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def foo1_or_signbit_lshr_without_shifting_signbit_both_sides_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %arg1 : i32
  %2 = llvm.shl %arg0, %arg2 : i32
  %3 = llvm.and %1, %2 : i32
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem foo1_or_signbit_lshr_without_shifting_signbit_both_sides_proof : foo1_or_signbit_lshr_without_shifting_signbit_both_sides_before ⊑ foo1_or_signbit_lshr_without_shifting_signbit_both_sides_after := by
  sorry



def foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.shl %arg0, %arg1 : vector<2xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %4 = llvm.shl %arg0, %arg2 : vector<2xi32>
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 2 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %6 = llvm.and %3, %5 : vector<2xi1>
  "llvm.return"(%6) : (vector<2xi1>) -> ()
}
]
def foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.shl %arg0, %arg1 : vector<2xi32>
  %3 = llvm.shl %arg0, %arg2 : vector<2xi32>
  %4 = llvm.and %2, %3 : vector<2xi32>
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 2 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
theorem foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat_proof : foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat_before ⊑ foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat_after := by
  sorry


