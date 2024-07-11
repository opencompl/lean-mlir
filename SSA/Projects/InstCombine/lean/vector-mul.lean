
def Zero_i8_before := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi8>}> : () -> vector<4xi8>
  %2 = llvm.mul %arg0, %1 : vector<4xi8>
  "llvm.return"(%2) : (vector<4xi8>) -> ()
}
]
def Zero_i8_after := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi8>}> : () -> vector<4xi8>
  "llvm.return"(%1) : (vector<4xi8>) -> ()
}
]
theorem Zero_i8_proof : Zero_i8_before ⊑ Zero_i8_after := by
  sorry



def Identity_i8_before := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<4xi8>}> : () -> vector<4xi8>
  %1 = llvm.mul %arg0, %0 : vector<4xi8>
  "llvm.return"(%1) : (vector<4xi8>) -> ()
}
]
def Identity_i8_after := [llvm|
{
^0(%arg0 : vector<4xi8>):
  "llvm.return"(%arg0) : (vector<4xi8>) -> ()
}
]
theorem Identity_i8_proof : Identity_i8_before ⊑ Identity_i8_after := by
  sorry



def AddToSelf_i8_before := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi8>}> : () -> vector<4xi8>
  %1 = llvm.mul %arg0, %0 : vector<4xi8>
  "llvm.return"(%1) : (vector<4xi8>) -> ()
}
]
def AddToSelf_i8_after := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<4xi8>}> : () -> vector<4xi8>
  %1 = llvm.shl %arg0, %0 : vector<4xi8>
  "llvm.return"(%1) : (vector<4xi8>) -> ()
}
]
theorem AddToSelf_i8_proof : AddToSelf_i8_before ⊑ AddToSelf_i8_after := by
  sorry



def SplatPow2Test1_i8_before := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<4xi8>}> : () -> vector<4xi8>
  %1 = llvm.mul %arg0, %0 : vector<4xi8>
  "llvm.return"(%1) : (vector<4xi8>) -> ()
}
]
def SplatPow2Test1_i8_after := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi8>}> : () -> vector<4xi8>
  %1 = llvm.shl %arg0, %0 : vector<4xi8>
  "llvm.return"(%1) : (vector<4xi8>) -> ()
}
]
theorem SplatPow2Test1_i8_proof : SplatPow2Test1_i8_before ⊑ SplatPow2Test1_i8_after := by
  sorry



def SplatPow2Test2_i8_before := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<4xi8>}> : () -> vector<4xi8>
  %1 = llvm.mul %arg0, %0 : vector<4xi8>
  "llvm.return"(%1) : (vector<4xi8>) -> ()
}
]
def SplatPow2Test2_i8_after := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<4xi8>}> : () -> vector<4xi8>
  %1 = llvm.shl %arg0, %0 : vector<4xi8>
  "llvm.return"(%1) : (vector<4xi8>) -> ()
}
]
theorem SplatPow2Test2_i8_proof : SplatPow2Test2_i8_before ⊑ SplatPow2Test2_i8_after := by
  sorry



def MulTest1_i8_before := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[1, 2, 4, 8]> : vector<4xi8>}> : () -> vector<4xi8>
  %1 = llvm.mul %arg0, %0 : vector<4xi8>
  "llvm.return"(%1) : (vector<4xi8>) -> ()
}
]
def MulTest1_i8_after := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[0, 1, 2, 3]> : vector<4xi8>}> : () -> vector<4xi8>
  %1 = llvm.shl %arg0, %0 : vector<4xi8>
  "llvm.return"(%1) : (vector<4xi8>) -> ()
}
]
theorem MulTest1_i8_proof : MulTest1_i8_before ⊑ MulTest1_i8_after := by
  sorry



def MulTest3_i8_before := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[4, 4, 2, 2]> : vector<4xi8>}> : () -> vector<4xi8>
  %1 = llvm.mul %arg0, %0 : vector<4xi8>
  "llvm.return"(%1) : (vector<4xi8>) -> ()
}
]
def MulTest3_i8_after := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[2, 2, 1, 1]> : vector<4xi8>}> : () -> vector<4xi8>
  %1 = llvm.shl %arg0, %0 : vector<4xi8>
  "llvm.return"(%1) : (vector<4xi8>) -> ()
}
]
theorem MulTest3_i8_proof : MulTest3_i8_before ⊑ MulTest3_i8_after := by
  sorry



def Zero_i16_before := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi16>}> : () -> vector<4xi16>
  %2 = llvm.mul %arg0, %1 : vector<4xi16>
  "llvm.return"(%2) : (vector<4xi16>) -> ()
}
]
def Zero_i16_after := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi16>}> : () -> vector<4xi16>
  "llvm.return"(%1) : (vector<4xi16>) -> ()
}
]
theorem Zero_i16_proof : Zero_i16_before ⊑ Zero_i16_after := by
  sorry



def Identity_i16_before := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<4xi16>}> : () -> vector<4xi16>
  %1 = llvm.mul %arg0, %0 : vector<4xi16>
  "llvm.return"(%1) : (vector<4xi16>) -> ()
}
]
def Identity_i16_after := [llvm|
{
^0(%arg0 : vector<4xi16>):
  "llvm.return"(%arg0) : (vector<4xi16>) -> ()
}
]
theorem Identity_i16_proof : Identity_i16_before ⊑ Identity_i16_after := by
  sorry



def AddToSelf_i16_before := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi16>}> : () -> vector<4xi16>
  %1 = llvm.mul %arg0, %0 : vector<4xi16>
  "llvm.return"(%1) : (vector<4xi16>) -> ()
}
]
def AddToSelf_i16_after := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<4xi16>}> : () -> vector<4xi16>
  %1 = llvm.shl %arg0, %0 : vector<4xi16>
  "llvm.return"(%1) : (vector<4xi16>) -> ()
}
]
theorem AddToSelf_i16_proof : AddToSelf_i16_before ⊑ AddToSelf_i16_after := by
  sorry



def SplatPow2Test1_i16_before := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<4xi16>}> : () -> vector<4xi16>
  %1 = llvm.mul %arg0, %0 : vector<4xi16>
  "llvm.return"(%1) : (vector<4xi16>) -> ()
}
]
def SplatPow2Test1_i16_after := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi16>}> : () -> vector<4xi16>
  %1 = llvm.shl %arg0, %0 : vector<4xi16>
  "llvm.return"(%1) : (vector<4xi16>) -> ()
}
]
theorem SplatPow2Test1_i16_proof : SplatPow2Test1_i16_before ⊑ SplatPow2Test1_i16_after := by
  sorry



def SplatPow2Test2_i16_before := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<4xi16>}> : () -> vector<4xi16>
  %1 = llvm.mul %arg0, %0 : vector<4xi16>
  "llvm.return"(%1) : (vector<4xi16>) -> ()
}
]
def SplatPow2Test2_i16_after := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<4xi16>}> : () -> vector<4xi16>
  %1 = llvm.shl %arg0, %0 : vector<4xi16>
  "llvm.return"(%1) : (vector<4xi16>) -> ()
}
]
theorem SplatPow2Test2_i16_proof : SplatPow2Test2_i16_before ⊑ SplatPow2Test2_i16_after := by
  sorry



def MulTest1_i16_before := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[1, 2, 4, 8]> : vector<4xi16>}> : () -> vector<4xi16>
  %1 = llvm.mul %arg0, %0 : vector<4xi16>
  "llvm.return"(%1) : (vector<4xi16>) -> ()
}
]
def MulTest1_i16_after := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[0, 1, 2, 3]> : vector<4xi16>}> : () -> vector<4xi16>
  %1 = llvm.shl %arg0, %0 : vector<4xi16>
  "llvm.return"(%1) : (vector<4xi16>) -> ()
}
]
theorem MulTest1_i16_proof : MulTest1_i16_before ⊑ MulTest1_i16_after := by
  sorry



def MulTest3_i16_before := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[4, 4, 2, 2]> : vector<4xi16>}> : () -> vector<4xi16>
  %1 = llvm.mul %arg0, %0 : vector<4xi16>
  "llvm.return"(%1) : (vector<4xi16>) -> ()
}
]
def MulTest3_i16_after := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[2, 2, 1, 1]> : vector<4xi16>}> : () -> vector<4xi16>
  %1 = llvm.shl %arg0, %0 : vector<4xi16>
  "llvm.return"(%1) : (vector<4xi16>) -> ()
}
]
theorem MulTest3_i16_proof : MulTest3_i16_before ⊑ MulTest3_i16_after := by
  sorry



def Zero_i32_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.mul %arg0, %1 : vector<4xi32>
  "llvm.return"(%2) : (vector<4xi32>) -> ()
}
]
def Zero_i32_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem Zero_i32_proof : Zero_i32_before ⊑ Zero_i32_after := by
  sorry



def Identity_i32_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.mul %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
def Identity_i32_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  "llvm.return"(%arg0) : (vector<4xi32>) -> ()
}
]
theorem Identity_i32_proof : Identity_i32_before ⊑ Identity_i32_after := by
  sorry



def AddToSelf_i32_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.mul %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
def AddToSelf_i32_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.shl %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem AddToSelf_i32_proof : AddToSelf_i32_before ⊑ AddToSelf_i32_after := by
  sorry



def SplatPow2Test1_i32_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.mul %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
def SplatPow2Test1_i32_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.shl %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem SplatPow2Test1_i32_proof : SplatPow2Test1_i32_before ⊑ SplatPow2Test1_i32_after := by
  sorry



def SplatPow2Test2_i32_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.mul %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
def SplatPow2Test2_i32_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.shl %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem SplatPow2Test2_i32_proof : SplatPow2Test2_i32_before ⊑ SplatPow2Test2_i32_after := by
  sorry



def MulTest1_i32_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[1, 2, 4, 8]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.mul %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
def MulTest1_i32_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[0, 1, 2, 3]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.shl %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem MulTest1_i32_proof : MulTest1_i32_before ⊑ MulTest1_i32_after := by
  sorry



def MulTest3_i32_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[4, 4, 2, 2]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.mul %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
def MulTest3_i32_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[2, 2, 1, 1]> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.shl %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem MulTest3_i32_proof : MulTest3_i32_before ⊑ MulTest3_i32_after := by
  sorry



def Zero_i64_before := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi64>}> : () -> vector<4xi64>
  %2 = llvm.mul %arg0, %1 : vector<4xi64>
  "llvm.return"(%2) : (vector<4xi64>) -> ()
}
]
def Zero_i64_after := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<4xi64>}> : () -> vector<4xi64>
  "llvm.return"(%1) : (vector<4xi64>) -> ()
}
]
theorem Zero_i64_proof : Zero_i64_before ⊑ Zero_i64_after := by
  sorry



def Identity_i64_before := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<4xi64>}> : () -> vector<4xi64>
  %1 = llvm.mul %arg0, %0 : vector<4xi64>
  "llvm.return"(%1) : (vector<4xi64>) -> ()
}
]
def Identity_i64_after := [llvm|
{
^0(%arg0 : vector<4xi64>):
  "llvm.return"(%arg0) : (vector<4xi64>) -> ()
}
]
theorem Identity_i64_proof : Identity_i64_before ⊑ Identity_i64_after := by
  sorry



def AddToSelf_i64_before := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi64>}> : () -> vector<4xi64>
  %1 = llvm.mul %arg0, %0 : vector<4xi64>
  "llvm.return"(%1) : (vector<4xi64>) -> ()
}
]
def AddToSelf_i64_after := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<1> : vector<4xi64>}> : () -> vector<4xi64>
  %1 = llvm.shl %arg0, %0 : vector<4xi64>
  "llvm.return"(%1) : (vector<4xi64>) -> ()
}
]
theorem AddToSelf_i64_proof : AddToSelf_i64_before ⊑ AddToSelf_i64_after := by
  sorry



def SplatPow2Test1_i64_before := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<4> : vector<4xi64>}> : () -> vector<4xi64>
  %1 = llvm.mul %arg0, %0 : vector<4xi64>
  "llvm.return"(%1) : (vector<4xi64>) -> ()
}
]
def SplatPow2Test1_i64_after := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi64>}> : () -> vector<4xi64>
  %1 = llvm.shl %arg0, %0 : vector<4xi64>
  "llvm.return"(%1) : (vector<4xi64>) -> ()
}
]
theorem SplatPow2Test1_i64_proof : SplatPow2Test1_i64_before ⊑ SplatPow2Test1_i64_after := by
  sorry



def SplatPow2Test2_i64_before := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<4xi64>}> : () -> vector<4xi64>
  %1 = llvm.mul %arg0, %0 : vector<4xi64>
  "llvm.return"(%1) : (vector<4xi64>) -> ()
}
]
def SplatPow2Test2_i64_after := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<4xi64>}> : () -> vector<4xi64>
  %1 = llvm.shl %arg0, %0 : vector<4xi64>
  "llvm.return"(%1) : (vector<4xi64>) -> ()
}
]
theorem SplatPow2Test2_i64_proof : SplatPow2Test2_i64_before ⊑ SplatPow2Test2_i64_after := by
  sorry



def MulTest1_i64_before := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[1, 2, 4, 8]> : vector<4xi64>}> : () -> vector<4xi64>
  %1 = llvm.mul %arg0, %0 : vector<4xi64>
  "llvm.return"(%1) : (vector<4xi64>) -> ()
}
]
def MulTest1_i64_after := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[0, 1, 2, 3]> : vector<4xi64>}> : () -> vector<4xi64>
  %1 = llvm.shl %arg0, %0 : vector<4xi64>
  "llvm.return"(%1) : (vector<4xi64>) -> ()
}
]
theorem MulTest1_i64_proof : MulTest1_i64_before ⊑ MulTest1_i64_after := by
  sorry



def MulTest3_i64_before := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[4, 4, 2, 2]> : vector<4xi64>}> : () -> vector<4xi64>
  %1 = llvm.mul %arg0, %0 : vector<4xi64>
  "llvm.return"(%1) : (vector<4xi64>) -> ()
}
]
def MulTest3_i64_after := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[2, 2, 1, 1]> : vector<4xi64>}> : () -> vector<4xi64>
  %1 = llvm.shl %arg0, %0 : vector<4xi64>
  "llvm.return"(%1) : (vector<4xi64>) -> ()
}
]
theorem MulTest3_i64_proof : MulTest3_i64_before ⊑ MulTest3_i64_after := by
  sorry



def ShiftMulTest1_before := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi8>}> : () -> vector<4xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<4xi8>}> : () -> vector<4xi8>
  %2 = llvm.shl %arg0, %0 : vector<4xi8>
  %3 = llvm.mul %2, %1 : vector<4xi8>
  "llvm.return"(%3) : (vector<4xi8>) -> ()
}
]
def ShiftMulTest1_after := [llvm|
{
^0(%arg0 : vector<4xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<12> : vector<4xi8>}> : () -> vector<4xi8>
  %1 = llvm.mul %arg0, %0 : vector<4xi8>
  "llvm.return"(%1) : (vector<4xi8>) -> ()
}
]
theorem ShiftMulTest1_proof : ShiftMulTest1_before ⊑ ShiftMulTest1_after := by
  sorry



def ShiftMulTest2_before := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi16>}> : () -> vector<4xi16>
  %1 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<4xi16>}> : () -> vector<4xi16>
  %2 = llvm.shl %arg0, %0 : vector<4xi16>
  %3 = llvm.mul %2, %1 : vector<4xi16>
  "llvm.return"(%3) : (vector<4xi16>) -> ()
}
]
def ShiftMulTest2_after := [llvm|
{
^0(%arg0 : vector<4xi16>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<12> : vector<4xi16>}> : () -> vector<4xi16>
  %1 = llvm.mul %arg0, %0 : vector<4xi16>
  "llvm.return"(%1) : (vector<4xi16>) -> ()
}
]
theorem ShiftMulTest2_proof : ShiftMulTest2_before ⊑ ShiftMulTest2_after := by
  sorry



def ShiftMulTest3_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.shl %arg0, %0 : vector<4xi32>
  %3 = llvm.mul %2, %1 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def ShiftMulTest3_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<12> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.mul %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem ShiftMulTest3_proof : ShiftMulTest3_before ⊑ ShiftMulTest3_after := by
  sorry



def ShiftMulTest4_before := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi64>}> : () -> vector<4xi64>
  %1 = "llvm.mlir.constant"() <{"value" = dense<3> : vector<4xi64>}> : () -> vector<4xi64>
  %2 = llvm.shl %arg0, %0 : vector<4xi64>
  %3 = llvm.mul %2, %1 : vector<4xi64>
  "llvm.return"(%3) : (vector<4xi64>) -> ()
}
]
def ShiftMulTest4_after := [llvm|
{
^0(%arg0 : vector<4xi64>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<12> : vector<4xi64>}> : () -> vector<4xi64>
  %1 = llvm.mul %arg0, %0 : vector<4xi64>
  "llvm.return"(%1) : (vector<4xi64>) -> ()
}
]
theorem ShiftMulTest4_proof : ShiftMulTest4_before ⊑ ShiftMulTest4_after := by
  sorry


