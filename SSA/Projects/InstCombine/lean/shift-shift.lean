
def shl_shl_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 28 : i32}> : () -> i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_shl_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem shl_shl_proof : shl_shl_before ⊑ shl_shl_after := by
  sorry



def shl_shl_splat_vec_before := [llvm|
{
^0(%arg0 : vector<2xi33>):
  %0 = "llvm.mlir.constant"() <{"value" = 5 : i33}> : () -> i33
  %1 = "llvm.mlir.constant"() <{"value" = dense<5> : vector<2xi33>}> : () -> vector<2xi33>
  %2 = "llvm.mlir.constant"() <{"value" = 28 : i33}> : () -> i33
  %3 = "llvm.mlir.constant"() <{"value" = dense<28> : vector<2xi33>}> : () -> vector<2xi33>
  %4 = llvm.shl %arg0, %1 : vector<2xi33>
  %5 = llvm.shl %4, %3 : vector<2xi33>
  "llvm.return"(%5) : (vector<2xi33>) -> ()
}
]
def shl_shl_splat_vec_after := [llvm|
{
^0(%arg0 : vector<2xi33>):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i33}> : () -> i33
  %1 = "llvm.mlir.constant"() <{"value" = dense<0> : vector<2xi33>}> : () -> vector<2xi33>
  "llvm.return"(%1) : (vector<2xi33>) -> ()
}
]
theorem shl_shl_splat_vec_proof : shl_shl_splat_vec_before ⊑ shl_shl_splat_vec_after := by
  sorry


