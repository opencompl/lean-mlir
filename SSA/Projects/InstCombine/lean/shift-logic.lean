
def shl_and_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.and %2, %arg1 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_and_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %1 : i8
  %4 = llvm.and %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_and_proof : shl_and_before ⊑ shl_and_after := by
  sorry



def shl_and_nonuniform_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[3, 4]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[2, 0]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.shl %arg0, %0 : vector<2xi8>
  %3 = llvm.and %2, %arg1 : vector<2xi8>
  %4 = llvm.shl %3, %1 : vector<2xi8>
  "llvm.return"(%4) : (vector<2xi8>) -> ()
}
]
def shl_and_nonuniform_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[5, 4]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[2, 0]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.shl %arg0, %0 : vector<2xi8>
  %3 = llvm.shl %arg1, %1 : vector<2xi8>
  %4 = llvm.and %2, %3 : vector<2xi8>
  "llvm.return"(%4) : (vector<2xi8>) -> ()
}
]
theorem shl_and_nonuniform_proof : shl_and_nonuniform_before ⊑ shl_and_nonuniform_after := by
  sorry



def shl_xor_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.xor %2, %arg1 : i32
  %4 = llvm.shl %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def shl_xor_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 12 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 7 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.shl %arg1, %1 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem shl_xor_proof : shl_xor_before ⊑ shl_xor_after := by
  sorry



def shl_xor_nonuniform_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[5, 6]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[7, 8]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.shl %arg0, %0 : vector<2xi32>
  %3 = llvm.xor %2, %arg1 : vector<2xi32>
  %4 = llvm.shl %3, %1 : vector<2xi32>
  "llvm.return"(%4) : (vector<2xi32>) -> ()
}
]
def shl_xor_nonuniform_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[12, 14]> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[7, 8]> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.shl %arg0, %0 : vector<2xi32>
  %3 = llvm.shl %arg1, %1 : vector<2xi32>
  %4 = llvm.xor %2, %3 : vector<2xi32>
  "llvm.return"(%4) : (vector<2xi32>) -> ()
}
]
theorem shl_xor_nonuniform_proof : shl_xor_nonuniform_before ⊑ shl_xor_nonuniform_after := by
  sorry



def shl_add_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.add %2, %arg1 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_add_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %1 : i8
  %4 = llvm.add %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_add_proof : shl_add_before ⊑ shl_add_after := by
  sorry



def shl_add_nonuniform_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[3, 4]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[2, 0]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.shl %arg0, %0 : vector<2xi8>
  %3 = llvm.add %2, %arg1 : vector<2xi8>
  %4 = llvm.shl %3, %1 : vector<2xi8>
  "llvm.return"(%4) : (vector<2xi8>) -> ()
}
]
def shl_add_nonuniform_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[5, 4]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[2, 0]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.shl %arg0, %0 : vector<2xi8>
  %3 = llvm.shl %arg1, %1 : vector<2xi8>
  %4 = llvm.add %2, %3 : vector<2xi8>
  "llvm.return"(%4) : (vector<2xi8>) -> ()
}
]
theorem shl_add_nonuniform_proof : shl_add_nonuniform_before ⊑ shl_add_nonuniform_after := by
  sorry



def shl_sub_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.sub %2, %arg1 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_sub_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg0, %0 : i8
  %3 = llvm.shl %arg1, %1 : i8
  %4 = llvm.sub %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_sub_proof : shl_sub_before ⊑ shl_sub_after := by
  sorry



def shl_sub_no_commute_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg1, %0 : i8
  %3 = llvm.sub %arg0, %2 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def shl_sub_no_commute_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %2 = llvm.shl %arg1, %0 : i8
  %3 = llvm.shl %arg0, %1 : i8
  %4 = llvm.sub %3, %2 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_sub_no_commute_proof : shl_sub_no_commute_before ⊑ shl_sub_no_commute_after := by
  sorry



def shl_sub_nonuniform_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[3, 4]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[2, 0]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.shl %arg0, %0 : vector<2xi8>
  %3 = llvm.sub %2, %arg1 : vector<2xi8>
  %4 = llvm.shl %3, %1 : vector<2xi8>
  "llvm.return"(%4) : (vector<2xi8>) -> ()
}
]
def shl_sub_nonuniform_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[5, 4]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[2, 0]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.shl %arg0, %0 : vector<2xi8>
  %3 = llvm.shl %arg1, %1 : vector<2xi8>
  %4 = llvm.sub %2, %3 : vector<2xi8>
  "llvm.return"(%4) : (vector<2xi8>) -> ()
}
]
theorem shl_sub_nonuniform_proof : shl_sub_nonuniform_before ⊑ shl_sub_nonuniform_after := by
  sorry


