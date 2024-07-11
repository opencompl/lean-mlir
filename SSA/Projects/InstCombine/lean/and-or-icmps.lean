
def PR1817_1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def PR1817_1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem PR1817_1_proof : PR1817_1_before ⊑ PR1817_1_after := by
  sorry



def PR1817_2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def PR1817_2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem PR1817_2_proof : PR1817_2_before ⊑ PR1817_2_after := by
  sorry



def PR2330_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def PR2330_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = llvm.or %arg1, %arg0 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem PR2330_proof : PR2330_before ⊑ PR2330_after := by
  sorry



def or_eq_with_one_bit_diff_constants1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 50 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 51 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_eq_with_one_bit_diff_constants1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 50 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem or_eq_with_one_bit_diff_constants1_proof : or_eq_with_one_bit_diff_constants1_before ⊑ or_eq_with_one_bit_diff_constants1_after := by
  sorry



def and_ne_with_one_bit_diff_constants1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 51 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 50 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_ne_with_one_bit_diff_constants1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -52 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem and_ne_with_one_bit_diff_constants1_proof : and_ne_with_one_bit_diff_constants1_before ⊑ and_ne_with_one_bit_diff_constants1_after := by
  sorry



def or_eq_with_one_bit_diff_constants2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 97 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 65 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_eq_with_one_bit_diff_constants2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -33 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 65 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem or_eq_with_one_bit_diff_constants2_proof : or_eq_with_one_bit_diff_constants2_before ⊑ or_eq_with_one_bit_diff_constants2_after := by
  sorry



def and_ne_with_one_bit_diff_constants2_before := [llvm|
{
^0(%arg0 : i19):
  %0 = "llvm.mlir.constant"() <{"value" = 65 : i19}> : () -> i19
  %1 = "llvm.mlir.constant"() <{"value" = 193 : i19}> : () -> i19
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i19, i19) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (i19, i19) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_ne_with_one_bit_diff_constants2_after := [llvm|
{
^0(%arg0 : i19):
  %0 = "llvm.mlir.constant"() <{"value" = -129 : i19}> : () -> i19
  %1 = "llvm.mlir.constant"() <{"value" = 65 : i19}> : () -> i19
  %2 = llvm.and %arg0, %0 : i19
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i19, i19) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem and_ne_with_one_bit_diff_constants2_proof : and_ne_with_one_bit_diff_constants2_before ⊑ and_ne_with_one_bit_diff_constants2_after := by
  sorry



def or_eq_with_one_bit_diff_constants3_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 126 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_eq_with_one_bit_diff_constants3_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 126 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem or_eq_with_one_bit_diff_constants3_proof : or_eq_with_one_bit_diff_constants3_before ⊑ or_eq_with_one_bit_diff_constants3_after := by
  sorry



def and_ne_with_one_bit_diff_constants3_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 65 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -63 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_ne_with_one_bit_diff_constants3_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 65 : i8}> : () -> i8
  %2 = llvm.and %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem and_ne_with_one_bit_diff_constants3_proof : and_ne_with_one_bit_diff_constants3_before ⊑ and_ne_with_one_bit_diff_constants3_after := by
  sorry



def or_eq_with_diff_one_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 13 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 14 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_eq_with_diff_one_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -13 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem or_eq_with_diff_one_proof : or_eq_with_diff_one_before ⊑ or_eq_with_diff_one_after := by
  sorry



def and_ne_with_diff_one_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 40 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 39 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_ne_with_diff_one_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -41 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem and_ne_with_diff_one_proof : and_ne_with_diff_one_before ⊑ and_ne_with_diff_one_after := by
  sorry



def or_eq_with_diff_one_signed_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def or_eq_with_diff_one_signed_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem or_eq_with_diff_one_signed_proof : or_eq_with_diff_one_signed_before ⊑ or_eq_with_diff_one_signed_after := by
  sorry



def and_ne_with_diff_one_signed_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (i64, i64) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def and_ne_with_diff_one_signed_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = -2 : i64}> : () -> i64
  %2 = llvm.add %arg0, %0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem and_ne_with_diff_one_signed_proof : and_ne_with_diff_one_signed_before ⊑ and_ne_with_diff_one_signed_after := by
  sorry



def or_eq_with_one_bit_diff_constants2_splatvec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<97> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<65> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %4 = llvm.or %2, %3 : vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def or_eq_with_one_bit_diff_constants2_splatvec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-33> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<65> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.and %arg0, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 0 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem or_eq_with_one_bit_diff_constants2_splatvec_proof : or_eq_with_one_bit_diff_constants2_splatvec_before ⊑ or_eq_with_one_bit_diff_constants2_splatvec_after := by
  sorry



def and_ne_with_diff_one_splatvec_before := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<40> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<39> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %4 = llvm.and %2, %3 : vector<2xi1>
  "llvm.return"(%4) : (vector<2xi1>) -> ()
}
]
def and_ne_with_diff_one_splatvec_after := [llvm|
{
^0(%arg0 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-41> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-2> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.add %arg0, %0 : vector<2xi32>
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem and_ne_with_diff_one_splatvec_proof : and_ne_with_diff_one_splatvec_before ⊑ and_ne_with_diff_one_splatvec_after := by
  sorry



def PR42691_1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483646 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem PR42691_1_proof : PR42691_1_before ⊑ PR42691_1_after := by
  sorry



def PR42691_2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem PR42691_2_proof : PR42691_2_before ⊑ PR42691_2_after := by
  sorry



def PR42691_3_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_3_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483647 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem PR42691_3_proof : PR42691_3_before ⊑ PR42691_3_after := by
  sorry



def PR42691_4_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_4_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem PR42691_4_proof : PR42691_4_before ⊑ PR42691_4_after := by
  sorry



def PR42691_5_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_5_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2147483646 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem PR42691_5_proof : PR42691_5_before ⊑ PR42691_5_after := by
  sorry



def PR42691_6_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_6_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2147483646 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem PR42691_6_proof : PR42691_6_before ⊑ PR42691_6_after := by
  sorry



def PR42691_7_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 0 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_7_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem PR42691_7_proof : PR42691_7_before ⊑ PR42691_7_after := by
  sorry



def PR42691_8_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 14 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2147483648 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_8_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -2147483635 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem PR42691_8_proof : PR42691_8_before ⊑ PR42691_8_after := by
  sorry



def PR42691_9_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 13 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2147483647 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_9_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -14 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2147483633 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem PR42691_9_proof : PR42691_9_before ⊑ PR42691_9_after := by
  sorry



def PR42691_10_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 13 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 8 : i64}> : (i32, i32) -> i1
  %3 = "llvm.icmp"(%arg0, %1) <{"predicate" = 1 : i64}> : (i32, i32) -> i1
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def PR42691_10_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -14 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -15 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i32, i32) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem PR42691_10_proof : PR42691_10_before ⊑ PR42691_10_after := by
  sorry



def substitute_constant_and_eq_eq_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def substitute_constant_and_eq_eq_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem substitute_constant_and_eq_eq_proof : substitute_constant_and_eq_eq_before ⊑ substitute_constant_and_eq_eq_after := by
  sorry



def substitute_constant_and_eq_eq_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def substitute_constant_and_eq_eq_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem substitute_constant_and_eq_eq_commute_proof : substitute_constant_and_eq_eq_commute_before ⊑ substitute_constant_and_eq_eq_commute_after := by
  sorry



def substitute_constant_and_eq_ugt_swap_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def substitute_constant_and_eq_ugt_swap_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem substitute_constant_and_eq_ugt_swap_proof : substitute_constant_and_eq_ugt_swap_before ⊑ substitute_constant_and_eq_ugt_swap_after := by
  sorry



def substitute_constant_and_eq_ne_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[42, 97]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %3 = llvm.and %1, %2 : vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
def substitute_constant_and_eq_ne_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[42, 97]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 1 : i64}> : (vector<2xi8>, vector<2xi8>) -> vector<2xi1>
  %3 = llvm.and %1, %2 : vector<2xi1>
  "llvm.return"(%3) : (vector<2xi1>) -> ()
}
]
theorem substitute_constant_and_eq_ne_vec_proof : substitute_constant_and_eq_ne_vec_before ⊑ substitute_constant_and_eq_ne_vec_after := by
  sorry



def substitute_constant_or_ne_swap_sle_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg1, %arg0) <{"predicate" = 3 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def substitute_constant_or_ne_swap_sle_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 43 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = "llvm.icmp"(%arg1, %1) <{"predicate" = 2 : i64}> : (i8, i8) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem substitute_constant_or_ne_swap_sle_proof : substitute_constant_or_ne_swap_sle_before ⊑ substitute_constant_or_ne_swap_sle_after := by
  sorry



def substitute_constant_or_ne_uge_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %2 = "llvm.icmp"(%arg0, %arg1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def substitute_constant_or_ne_uge_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 43 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg0, %0) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %3 = "llvm.icmp"(%arg1, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
theorem substitute_constant_or_ne_uge_commute_proof : substitute_constant_or_ne_uge_commute_before ⊑ substitute_constant_or_ne_uge_commute_after := by
  sorry



def or_ranges_overlap_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 10 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 20 : i8}> : () -> i8
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %5 = llvm.and %3, %4 : i1
  %6 = "llvm.icmp"(%arg0, %1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %7 = "llvm.icmp"(%arg0, %2) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %8 = llvm.and %6, %7 : i1
  %9 = llvm.or %5, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def or_ranges_overlap_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 16 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem or_ranges_overlap_proof : or_ranges_overlap_before ⊑ or_ranges_overlap_after := by
  sorry



def or_ranges_adjacent_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 10 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 11 : i8}> : () -> i8
  %3 = "llvm.mlir.constant"() <{"value" = 20 : i8}> : () -> i8
  %4 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %5 = "llvm.icmp"(%arg0, %1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %6 = llvm.and %4, %5 : i1
  %7 = "llvm.icmp"(%arg0, %2) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %8 = "llvm.icmp"(%arg0, %3) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %9 = llvm.and %7, %8 : i1
  %10 = llvm.or %6, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def or_ranges_adjacent_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 16 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem or_ranges_adjacent_proof : or_ranges_adjacent_before ⊑ or_ranges_adjacent_after := by
  sorry



def or_ranges_separated_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 10 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 12 : i8}> : () -> i8
  %3 = "llvm.mlir.constant"() <{"value" = 20 : i8}> : () -> i8
  %4 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %5 = "llvm.icmp"(%arg0, %1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %6 = llvm.and %4, %5 : i1
  %7 = "llvm.icmp"(%arg0, %2) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %8 = "llvm.icmp"(%arg0, %3) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %9 = llvm.and %7, %8 : i1
  %10 = llvm.or %6, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def or_ranges_separated_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 6 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = -12 : i8}> : () -> i8
  %3 = "llvm.mlir.constant"() <{"value" = 9 : i8}> : () -> i8
  %4 = llvm.add %arg0, %0 : i8
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %6 = llvm.add %arg0, %2 : i8
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
theorem or_ranges_separated_proof : or_ranges_separated_before ⊑ or_ranges_separated_after := by
  sorry



def or_ranges_single_elem_right_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 10 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 11 : i8}> : () -> i8
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %5 = llvm.and %3, %4 : i1
  %6 = "llvm.icmp"(%arg0, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %7 = llvm.or %5, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def or_ranges_single_elem_right_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem or_ranges_single_elem_right_proof : or_ranges_single_elem_right_before ⊑ or_ranges_single_elem_right_after := by
  sorry



def or_ranges_single_elem_left_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 10 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %5 = llvm.and %3, %4 : i1
  %6 = "llvm.icmp"(%arg0, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %7 = llvm.or %5, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def or_ranges_single_elem_left_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -4 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem or_ranges_single_elem_left_proof : or_ranges_single_elem_left_before ⊑ or_ranges_single_elem_left_after := by
  sorry



def and_ranges_overlap_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 10 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 7 : i8}> : () -> i8
  %3 = "llvm.mlir.constant"() <{"value" = 20 : i8}> : () -> i8
  %4 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %5 = "llvm.icmp"(%arg0, %1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %6 = llvm.and %4, %5 : i1
  %7 = "llvm.icmp"(%arg0, %2) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %8 = "llvm.icmp"(%arg0, %3) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %9 = llvm.and %7, %8 : i1
  %10 = llvm.and %6, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def and_ranges_overlap_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 4 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem and_ranges_overlap_proof : and_ranges_overlap_before ⊑ and_ranges_overlap_after := by
  sorry



def and_ranges_overlap_single_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 10 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 20 : i8}> : () -> i8
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %5 = llvm.and %3, %4 : i1
  %6 = "llvm.icmp"(%arg0, %1) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %7 = "llvm.icmp"(%arg0, %2) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %8 = llvm.and %6, %7 : i1
  %9 = llvm.and %5, %8 : i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def and_ranges_overlap_single_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i8}> : () -> i8
  %1 = "llvm.icmp"(%arg0, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
theorem and_ranges_overlap_single_proof : and_ranges_overlap_single_before ⊑ and_ranges_overlap_single_after := by
  sorry



def and_ranges_no_overlap_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 10 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 11 : i8}> : () -> i8
  %3 = "llvm.mlir.constant"() <{"value" = 20 : i8}> : () -> i8
  %4 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %5 = "llvm.icmp"(%arg0, %1) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %6 = llvm.and %4, %5 : i1
  %7 = "llvm.icmp"(%arg0, %2) <{"predicate" = 9 : i64}> : (i8, i8) -> i1
  %8 = "llvm.icmp"(%arg0, %3) <{"predicate" = 7 : i64}> : (i8, i8) -> i1
  %9 = llvm.and %7, %8 : i1
  %10 = llvm.and %6, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def and_ranges_no_overlap_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = false}> : () -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem and_ranges_no_overlap_proof : and_ranges_no_overlap_before ⊑ and_ranges_no_overlap_after := by
  sorry



def and_ranges_signed_pred_before := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = 1024 : i64}> : () -> i64
  %2 = "llvm.mlir.constant"() <{"value" = 128 : i64}> : () -> i64
  %3 = "llvm.mlir.constant"() <{"value" = 256 : i64}> : () -> i64
  %4 = llvm.add %arg0, %0 : i64
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 2 : i64}> : (i64, i64) -> i1
  %6 = llvm.add %arg0, %2 : i64
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 2 : i64}> : (i64, i64) -> i1
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def and_ranges_signed_pred_after := [llvm|
{
^0(%arg0 : i64):
  %0 = "llvm.mlir.constant"() <{"value" = -9223372036854775681 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = -9223372036854775553 : i64}> : () -> i64
  %2 = llvm.add %arg0, %0 : i64
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 6 : i64}> : (i64, i64) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem and_ranges_signed_pred_proof : and_ranges_signed_pred_before ⊑ and_ranges_signed_pred_after := by
  sorry



def and_two_ranges_to_mask_and_range_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -97 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 25 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = -65 : i8}> : () -> i8
  %3 = llvm.add %arg0, %0 : i8
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %5 = llvm.add %arg0, %2 : i8
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def and_two_ranges_to_mask_and_range_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -33 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -91 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = -26 : i8}> : () -> i8
  %3 = llvm.and %arg0, %0 : i8
  %4 = llvm.add %3, %1 : i8
  %5 = "llvm.icmp"(%4, %2) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
theorem and_two_ranges_to_mask_and_range_proof : and_two_ranges_to_mask_and_range_before ⊑ and_two_ranges_to_mask_and_range_after := by
  sorry



def and_two_ranges_to_mask_and_range_not_pow2_diff_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -97 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 25 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = -64 : i8}> : () -> i8
  %3 = llvm.add %arg0, %0 : i8
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %5 = llvm.add %arg0, %2 : i8
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def and_two_ranges_to_mask_and_range_not_pow2_diff_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -26 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = -90 : i8}> : () -> i8
  %3 = llvm.add %arg0, %0 : i8
  %4 = "llvm.icmp"(%3, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %5 = llvm.add %arg0, %2 : i8
  %6 = "llvm.icmp"(%5, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
theorem and_two_ranges_to_mask_and_range_not_pow2_diff_proof : and_two_ranges_to_mask_and_range_not_pow2_diff_before ⊑ and_two_ranges_to_mask_and_range_not_pow2_diff_after := by
  sorry



def and_two_ranges_to_mask_and_range_different_sizes_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -97 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 25 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = -65 : i8}> : () -> i8
  %3 = "llvm.mlir.constant"() <{"value" = 24 : i8}> : () -> i8
  %4 = llvm.add %arg0, %0 : i8
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %6 = llvm.add %arg0, %2 : i8
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 8 : i64}> : (i8, i8) -> i1
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def and_two_ranges_to_mask_and_range_different_sizes_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -123 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -26 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = -90 : i8}> : () -> i8
  %3 = "llvm.mlir.constant"() <{"value" = -25 : i8}> : () -> i8
  %4 = llvm.add %arg0, %0 : i8
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %6 = llvm.add %arg0, %2 : i8
  %7 = "llvm.icmp"(%6, %3) <{"predicate" = 6 : i64}> : (i8, i8) -> i1
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
theorem and_two_ranges_to_mask_and_range_different_sizes_proof : and_two_ranges_to_mask_and_range_different_sizes_before ⊑ and_two_ranges_to_mask_and_range_different_sizes_after := by
  sorry



def and_two_ranges_to_mask_and_range_no_add_on_one_range_before := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{"value" = 16 : i16}> : () -> i16
  %2 = "llvm.mlir.constant"() <{"value" = 28 : i16}> : () -> i16
  %3 = "llvm.icmp"(%arg0, %0) <{"predicate" = 9 : i64}> : (i16, i16) -> i1
  %4 = "llvm.icmp"(%arg0, %1) <{"predicate" = 6 : i64}> : (i16, i16) -> i1
  %5 = "llvm.icmp"(%arg0, %2) <{"predicate" = 9 : i64}> : (i16, i16) -> i1
  %6 = llvm.or %4, %5 : i1
  %7 = llvm.and %3, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def and_two_ranges_to_mask_and_range_no_add_on_one_range_after := [llvm|
{
^0(%arg0 : i16):
  %0 = "llvm.mlir.constant"() <{"value" = -20 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{"value" = 11 : i16}> : () -> i16
  %2 = llvm.and %arg0, %0 : i16
  %3 = "llvm.icmp"(%2, %1) <{"predicate" = 8 : i64}> : (i16, i16) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
theorem and_two_ranges_to_mask_and_range_no_add_on_one_range_proof : and_two_ranges_to_mask_and_range_no_add_on_one_range_before ⊑ and_two_ranges_to_mask_and_range_no_add_on_one_range_after := by
  sorry



def bitwise_and_bitwise_and_icmps_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %4 = llvm.and %arg0, %1 : i8
  %5 = llvm.shl %1, %arg2 : i8
  %6 = llvm.and %arg0, %5 : i8
  %7 = "llvm.icmp"(%4, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %8 = "llvm.icmp"(%6, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %9 = llvm.and %3, %7 : i1
  %10 = llvm.and %9, %8 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_and_bitwise_and_icmps_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.shl %1, %arg2 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %4, %arg0 : i8
  %6 = "llvm.icmp"(%5, %4) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %7 = llvm.and %2, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
theorem bitwise_and_bitwise_and_icmps_proof : bitwise_and_bitwise_and_icmps_before ⊑ bitwise_and_bitwise_and_icmps_after := by
  sorry



def bitwise_and_bitwise_and_icmps_comm1_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %4 = llvm.and %arg0, %1 : i8
  %5 = llvm.shl %1, %arg2 : i8
  %6 = llvm.and %arg0, %5 : i8
  %7 = "llvm.icmp"(%4, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %8 = "llvm.icmp"(%6, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %9 = llvm.and %3, %7 : i1
  %10 = llvm.and %8, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_and_bitwise_and_icmps_comm1_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.shl %1, %arg2 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %4, %arg0 : i8
  %6 = "llvm.icmp"(%5, %4) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %7 = llvm.and %2, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
theorem bitwise_and_bitwise_and_icmps_comm1_proof : bitwise_and_bitwise_and_icmps_comm1_before ⊑ bitwise_and_bitwise_and_icmps_comm1_after := by
  sorry



def bitwise_and_bitwise_and_icmps_comm2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %4 = llvm.and %arg0, %1 : i8
  %5 = llvm.shl %1, %arg2 : i8
  %6 = llvm.and %arg0, %5 : i8
  %7 = "llvm.icmp"(%4, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %8 = "llvm.icmp"(%6, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %9 = llvm.and %7, %3 : i1
  %10 = llvm.and %9, %8 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_and_bitwise_and_icmps_comm2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.shl %1, %arg2 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %4, %arg0 : i8
  %6 = "llvm.icmp"(%5, %4) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %7 = llvm.and %6, %2 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
theorem bitwise_and_bitwise_and_icmps_comm2_proof : bitwise_and_bitwise_and_icmps_comm2_before ⊑ bitwise_and_bitwise_and_icmps_comm2_after := by
  sorry



def bitwise_and_bitwise_and_icmps_comm3_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %4 = llvm.and %arg0, %1 : i8
  %5 = llvm.shl %1, %arg2 : i8
  %6 = llvm.and %arg0, %5 : i8
  %7 = "llvm.icmp"(%4, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %8 = "llvm.icmp"(%6, %2) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %9 = llvm.and %7, %3 : i1
  %10 = llvm.and %8, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_and_bitwise_and_icmps_comm3_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.shl %1, %arg2 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %4, %arg0 : i8
  %6 = "llvm.icmp"(%5, %4) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %7 = llvm.and %6, %2 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
theorem bitwise_and_bitwise_and_icmps_comm3_proof : bitwise_and_bitwise_and_icmps_comm3_before ⊑ bitwise_and_bitwise_and_icmps_comm3_after := by
  sorry



def bitwise_or_bitwise_or_icmps_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %4 = llvm.and %arg0, %1 : i8
  %5 = llvm.shl %1, %arg2 : i8
  %6 = llvm.and %arg0, %5 : i8
  %7 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %8 = "llvm.icmp"(%6, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %9 = llvm.or %3, %7 : i1
  %10 = llvm.or %9, %8 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_or_bitwise_or_icmps_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.shl %1, %arg2 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %4, %arg0 : i8
  %6 = "llvm.icmp"(%5, %4) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %7 = llvm.or %2, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
theorem bitwise_or_bitwise_or_icmps_proof : bitwise_or_bitwise_or_icmps_before ⊑ bitwise_or_bitwise_or_icmps_after := by
  sorry



def bitwise_or_bitwise_or_icmps_comm1_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %4 = llvm.and %arg0, %1 : i8
  %5 = llvm.shl %1, %arg2 : i8
  %6 = llvm.and %arg0, %5 : i8
  %7 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %8 = "llvm.icmp"(%6, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %9 = llvm.or %3, %7 : i1
  %10 = llvm.or %8, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_or_bitwise_or_icmps_comm1_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.shl %1, %arg2 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %4, %arg0 : i8
  %6 = "llvm.icmp"(%5, %4) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %7 = llvm.or %2, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
theorem bitwise_or_bitwise_or_icmps_comm1_proof : bitwise_or_bitwise_or_icmps_comm1_before ⊑ bitwise_or_bitwise_or_icmps_comm1_after := by
  sorry



def bitwise_or_bitwise_or_icmps_comm2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %4 = llvm.and %arg0, %1 : i8
  %5 = llvm.shl %1, %arg2 : i8
  %6 = llvm.and %arg0, %5 : i8
  %7 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %8 = "llvm.icmp"(%6, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %9 = llvm.or %7, %3 : i1
  %10 = llvm.or %9, %8 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_or_bitwise_or_icmps_comm2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.shl %1, %arg2 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %4, %arg0 : i8
  %6 = "llvm.icmp"(%5, %4) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %7 = llvm.or %6, %2 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
theorem bitwise_or_bitwise_or_icmps_comm2_proof : bitwise_or_bitwise_or_icmps_comm2_before ⊑ bitwise_or_bitwise_or_icmps_comm2_after := by
  sorry



def bitwise_or_bitwise_or_icmps_comm3_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %3 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %4 = llvm.and %arg0, %1 : i8
  %5 = llvm.shl %1, %arg2 : i8
  %6 = llvm.and %arg0, %5 : i8
  %7 = "llvm.icmp"(%4, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %8 = "llvm.icmp"(%6, %2) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %9 = llvm.or %7, %3 : i1
  %10 = llvm.or %8, %9 : i1
  "llvm.return"(%10) : (i1) -> ()
}
]
def bitwise_or_bitwise_or_icmps_comm3_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8, %arg2 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %2 = "llvm.icmp"(%arg1, %0) <{"predicate" = 0 : i64}> : (i8, i8) -> i1
  %3 = llvm.shl %1, %arg2 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.and %4, %arg0 : i8
  %6 = "llvm.icmp"(%5, %4) <{"predicate" = 1 : i64}> : (i8, i8) -> i1
  %7 = llvm.or %6, %2 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
theorem bitwise_or_bitwise_or_icmps_comm3_proof : bitwise_or_bitwise_or_icmps_comm3_before ⊑ bitwise_or_bitwise_or_icmps_comm3_after := by
  sorry



def samesign_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %arg0, %arg1 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %6 = llvm.or %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem samesign_proof : samesign_before ⊑ samesign_after := by
  sorry



def samesign_different_sign_bittest1_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.and %arg0, %arg1 : vector<2xi32>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 3 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %3 = llvm.or %arg0, %arg1 : vector<2xi32>
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 4 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  %5 = llvm.or %2, %4 : vector<2xi1>
  "llvm.return"(%5) : (vector<2xi1>) -> ()
}
]
def samesign_different_sign_bittest1_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.xor %arg0, %arg1 : vector<2xi32>
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (vector<2xi32>, vector<2xi32>) -> vector<2xi1>
  "llvm.return"(%2) : (vector<2xi1>) -> ()
}
]
theorem samesign_different_sign_bittest1_proof : samesign_different_sign_bittest1_before ⊑ samesign_different_sign_bittest1_after := by
  sorry



def samesign_different_sign_bittest2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %3 = llvm.or %arg0, %arg1 : i32
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  %5 = llvm.or %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def samesign_different_sign_bittest2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem samesign_different_sign_bittest2_proof : samesign_different_sign_bittest2_before ⊑ samesign_different_sign_bittest2_after := by
  sorry



def samesign_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %arg0, %arg1 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %6 = llvm.or %5, %3 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem samesign_commute1_proof : samesign_commute1_before ⊑ samesign_commute1_after := by
  sorry



def samesign_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %arg1, %arg0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %6 = llvm.or %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem samesign_commute2_proof : samesign_commute2_before ⊑ samesign_commute2_after := by
  sorry



def samesign_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %arg1, %arg0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %6 = llvm.or %5, %3 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem samesign_commute3_proof : samesign_commute3_before ⊑ samesign_commute3_after := by
  sorry



def samesign_inverted_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %arg0, %arg1 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_inverted_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem samesign_inverted_proof : samesign_inverted_before ⊑ samesign_inverted_after := by
  sorry



def samesign_inverted_different_sign_bittest1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 5 : i64}> : (i32, i32) -> i1
  %3 = llvm.or %arg0, %arg1 : i32
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def samesign_inverted_different_sign_bittest1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem samesign_inverted_different_sign_bittest1_proof : samesign_inverted_different_sign_bittest1_before ⊑ samesign_inverted_different_sign_bittest1_after := by
  sorry



def samesign_inverted_different_sign_bittest2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %3 = llvm.or %arg0, %arg1 : i32
  %4 = "llvm.icmp"(%3, %0) <{"predicate" = 3 : i64}> : (i32, i32) -> i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def samesign_inverted_different_sign_bittest2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem samesign_inverted_different_sign_bittest2_proof : samesign_inverted_different_sign_bittest2_before ⊑ samesign_inverted_different_sign_bittest2_after := by
  sorry



def samesign_inverted_commute1_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %arg0, %arg1 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %5, %3 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_inverted_commute1_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem samesign_inverted_commute1_proof : samesign_inverted_commute1_before ⊑ samesign_inverted_commute1_after := by
  sorry



def samesign_inverted_commute2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %arg1, %arg0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_inverted_commute2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem samesign_inverted_commute2_proof : samesign_inverted_commute2_before ⊑ samesign_inverted_commute2_after := by
  sorry



def samesign_inverted_commute3_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %2 = llvm.and %arg0, %arg1 : i32
  %3 = "llvm.icmp"(%2, %0) <{"predicate" = 4 : i64}> : (i32, i32) -> i1
  %4 = llvm.or %arg1, %arg0 : i32
  %5 = "llvm.icmp"(%4, %1) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  %6 = llvm.and %5, %3 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def samesign_inverted_commute3_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.xor %arg1, %arg0 : i32
  %2 = "llvm.icmp"(%1, %0) <{"predicate" = 2 : i64}> : (i32, i32) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
theorem samesign_inverted_commute3_proof : samesign_inverted_commute3_before ⊑ samesign_inverted_commute3_after := by
  sorry


