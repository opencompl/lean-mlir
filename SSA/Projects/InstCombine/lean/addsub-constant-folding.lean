
def add_const_add_const_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_const_add_const_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem add_const_add_const_proof : add_const_add_const_before ⊑ add_const_add_const_after := by
  sorry



def vec_add_const_add_const_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.add %arg0, %0 : vector<4xi32>
  %3 = llvm.add %2, %1 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def vec_add_const_add_const_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<10> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.add %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem vec_add_const_add_const_proof : vec_add_const_add_const_before ⊑ vec_add_const_add_const_after := by
  sorry



def add_const_sub_const_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.sub %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_const_sub_const_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem add_const_sub_const_proof : add_const_sub_const_before ⊑ add_const_sub_const_after := by
  sorry



def vec_add_const_sub_const_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.add %arg0, %0 : vector<4xi32>
  %3 = llvm.sub %2, %1 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def vec_add_const_sub_const_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.add %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem vec_add_const_sub_const_proof : vec_add_const_sub_const_before ⊑ vec_add_const_sub_const_after := by
  sorry



def add_const_const_sub_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.add %arg0, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_const_const_sub_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -6 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem add_const_const_sub_proof : add_const_const_sub_before ⊑ add_const_const_sub_after := by
  sorry



def add_nsw_const_const_sub_nsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -127 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_nsw_const_const_sub_nsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem add_nsw_const_const_sub_nsw_proof : add_nsw_const_const_sub_nsw_before ⊑ add_nsw_const_const_sub_nsw_after := by
  sorry



def add_nsw_const_const_sub_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -127 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_nsw_const_const_sub_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem add_nsw_const_const_sub_proof : add_nsw_const_const_sub_before ⊑ add_nsw_const_const_sub_after := by
  sorry



def add_const_const_sub_nsw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -127 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_const_const_sub_nsw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem add_const_const_sub_nsw_proof : add_const_const_sub_nsw_before ⊑ add_const_const_sub_nsw_after := by
  sorry



def add_nsw_const_const_sub_nsw_ov_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -127 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_nsw_const_const_sub_nsw_ov_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 127 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem add_nsw_const_const_sub_nsw_ov_proof : add_nsw_const_const_sub_nsw_ov_before ⊑ add_nsw_const_const_sub_nsw_ov_after := by
  sorry



def add_nuw_const_const_sub_nuw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -127 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_nuw_const_const_sub_nuw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem add_nuw_const_const_sub_nuw_proof : add_nuw_const_const_sub_nuw_before ⊑ add_nuw_const_const_sub_nuw_after := by
  sorry



def add_nuw_const_const_sub_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -127 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_nuw_const_const_sub_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem add_nuw_const_const_sub_proof : add_nuw_const_const_sub_before ⊑ add_nuw_const_const_sub_after := by
  sorry



def add_const_const_sub_nuw_before := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{"value" = -127 : i8}> : () -> i8
  %2 = llvm.add %arg0, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_const_const_sub_nuw_after := [llvm|
{
^0(%arg0 : i8):
  %0 = "llvm.mlir.constant"() <{"value" = -128 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
theorem add_const_const_sub_nuw_proof : add_const_const_sub_nuw_before ⊑ add_const_const_sub_nuw_after := by
  sorry



def non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[2, 0]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[-125, -126]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.add %arg0, %0 : vector<2xi8>
  %3 = llvm.sub %1, %2 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
def non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-127, -126]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.sub %0, %arg0 : vector<2xi8>
  "llvm.return"(%1) : (vector<2xi8>) -> ()
}
]
theorem non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1_proof : non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1_before ⊑ non_splat_vec_add_nsw_const_const_sub_nsw_not_ov1_after := by
  sorry



def non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[1, 2]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[-125, -126]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.add %arg0, %0 : vector<2xi8>
  %3 = llvm.sub %1, %2 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
def non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-126, -128]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.sub %0, %arg0 : vector<2xi8>
  "llvm.return"(%1) : (vector<2xi8>) -> ()
}
]
theorem non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2_proof : non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2_before ⊑ non_splat_vec_add_nsw_const_const_sub_nsw_not_ov2_after := by
  sorry



def non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[0, 1]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[-120, -126]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.add %arg0, %0 : vector<2xi8>
  %3 = llvm.sub %1, %2 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
def non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-120, -127]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.sub %0, %arg0 : vector<2xi8>
  "llvm.return"(%1) : (vector<2xi8>) -> ()
}
]
theorem non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3_proof : non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3_before ⊑ non_splat_vec_add_nsw_const_const_sub_nsw_not_ov3_after := by
  sorry



def non_splat_vec_add_nsw_const_const_sub_nsw_ov_before := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[1, 2]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = "llvm.mlir.constant"() <{"value" = dense<[-126, -127]> : vector<2xi8>}> : () -> vector<2xi8>
  %2 = llvm.add %arg0, %0 : vector<2xi8>
  %3 = llvm.sub %1, %2 : vector<2xi8>
  "llvm.return"(%3) : (vector<2xi8>) -> ()
}
]
def non_splat_vec_add_nsw_const_const_sub_nsw_ov_after := [llvm|
{
^0(%arg0 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[-127, 127]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.sub %0, %arg0 : vector<2xi8>
  "llvm.return"(%1) : (vector<2xi8>) -> ()
}
]
theorem non_splat_vec_add_nsw_const_const_sub_nsw_ov_proof : non_splat_vec_add_nsw_const_const_sub_nsw_ov_before ⊑ non_splat_vec_add_nsw_const_const_sub_nsw_ov_after := by
  sorry



def vec_add_const_const_sub_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.add %arg0, %0 : vector<4xi32>
  %3 = llvm.sub %1, %2 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def vec_add_const_const_sub_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-6> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.sub %0, %arg0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem vec_add_const_const_sub_proof : vec_add_const_const_sub_before ⊑ vec_add_const_const_sub_after := by
  sorry



def sub_const_add_const_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.sub %arg0, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sub_const_add_const_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -6 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem sub_const_add_const_proof : sub_const_add_const_before ⊑ sub_const_add_const_after := by
  sorry



def vec_sub_const_add_const_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.sub %arg0, %0 : vector<4xi32>
  %3 = llvm.add %2, %1 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def vec_sub_const_add_const_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-6> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.add %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem vec_sub_const_add_const_proof : vec_sub_const_add_const_before ⊑ vec_sub_const_add_const_after := by
  sorry



def sub_const_sub_const_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.sub %arg0, %0 : i32
  %3 = llvm.sub %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sub_const_sub_const_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -10 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem sub_const_sub_const_proof : sub_const_sub_const_before ⊑ sub_const_sub_const_after := by
  sorry



def vec_sub_const_sub_const_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.sub %arg0, %0 : vector<4xi32>
  %3 = llvm.sub %2, %1 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def vec_sub_const_sub_const_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-10> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.add %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem vec_sub_const_sub_const_proof : vec_sub_const_sub_const_before ⊑ vec_sub_const_sub_const_after := by
  sorry



def sub_const_const_sub_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.sub %arg0, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sub_const_const_sub_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem sub_const_const_sub_proof : sub_const_const_sub_before ⊑ sub_const_const_sub_after := by
  sorry



def vec_sub_const_const_sub_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.sub %arg0, %0 : vector<4xi32>
  %3 = llvm.sub %1, %2 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def vec_sub_const_const_sub_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<10> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.sub %0, %arg0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem vec_sub_const_const_sub_proof : vec_sub_const_const_sub_before ⊑ vec_sub_const_const_sub_after := by
  sorry



def const_sub_add_const_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def const_sub_add_const_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem const_sub_add_const_proof : const_sub_add_const_before ⊑ const_sub_add_const_after := by
  sorry



def vec_const_sub_add_const_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.sub %0, %arg0 : vector<4xi32>
  %3 = llvm.add %2, %1 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def vec_const_sub_add_const_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<10> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.sub %0, %arg0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem vec_const_sub_add_const_proof : vec_const_sub_add_const_before ⊑ vec_const_sub_add_const_after := by
  sorry



def const_sub_sub_const_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.sub %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def const_sub_sub_const_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 6 : i32}> : () -> i32
  %1 = llvm.sub %0, %arg0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem const_sub_sub_const_proof : const_sub_sub_const_before ⊑ const_sub_sub_const_after := by
  sorry



def vec_const_sub_sub_const_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.sub %0, %arg0 : vector<4xi32>
  %3 = llvm.sub %2, %1 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def vec_const_sub_sub_const_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<6> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.sub %0, %arg0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem vec_const_sub_sub_const_proof : vec_const_sub_sub_const_before ⊑ vec_const_sub_sub_const_after := by
  sorry



def const_sub_const_sub_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
  %2 = llvm.sub %0, %arg0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def const_sub_const_sub_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -6 : i32}> : () -> i32
  %1 = llvm.add %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem const_sub_const_sub_proof : const_sub_const_sub_before ⊑ const_sub_const_sub_after := by
  sorry



def vec_const_sub_const_sub_before := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<8> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
  %2 = llvm.sub %0, %arg0 : vector<4xi32>
  %3 = llvm.sub %1, %2 : vector<4xi32>
  "llvm.return"(%3) : (vector<4xi32>) -> ()
}
]
def vec_const_sub_const_sub_after := [llvm|
{
^0(%arg0 : vector<4xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-6> : vector<4xi32>}> : () -> vector<4xi32>
  %1 = llvm.add %arg0, %0 : vector<4xi32>
  "llvm.return"(%1) : (vector<4xi32>) -> ()
}
]
theorem vec_const_sub_const_sub_proof : vec_const_sub_const_sub_before ⊑ vec_const_sub_const_sub_after := by
  sorry



def addsub_combine_constants_before := [llvm|
{
^0(%arg0 : i7, %arg1 : i7):
  %0 = "llvm.mlir.constant"() <{"value" = 42 : i7}> : () -> i7
  %1 = "llvm.mlir.constant"() <{"value" = 10 : i7}> : () -> i7
  %2 = llvm.add %arg0, %0 : i7
  %3 = llvm.sub %1, %arg1 : i7
  %4 = llvm.add %2, %3 : i7
  "llvm.return"(%4) : (i7) -> ()
}
]
def addsub_combine_constants_after := [llvm|
{
^0(%arg0 : i7, %arg1 : i7):
  %0 = "llvm.mlir.constant"() <{"value" = 52 : i7}> : () -> i7
  %1 = llvm.sub %arg0, %arg1 : i7
  %2 = llvm.add %1, %0 : i7
  "llvm.return"(%2) : (i7) -> ()
}
]
theorem addsub_combine_constants_proof : addsub_combine_constants_before ⊑ addsub_combine_constants_after := by
  sorry



def sub_from_constant_before := [llvm|
{
^0(%arg0 : i5, %arg1 : i5):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i5}> : () -> i5
  %1 = llvm.sub %0, %arg0 : i5
  %2 = llvm.add %1, %arg1 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def sub_from_constant_after := [llvm|
{
^0(%arg0 : i5, %arg1 : i5):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i5}> : () -> i5
  %1 = llvm.sub %arg1, %arg0 : i5
  %2 = llvm.add %1, %0 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
theorem sub_from_constant_proof : sub_from_constant_before ⊑ sub_from_constant_after := by
  sorry



def sub_from_constant_commute_before := [llvm|
{
^0(%arg0 : i5, %arg1 : i5):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i5}> : () -> i5
  %1 = llvm.mul %arg1, %arg1 : i5
  %2 = llvm.sub %0, %arg0 : i5
  %3 = llvm.add %1, %2 : i5
  "llvm.return"(%3) : (i5) -> ()
}
]
def sub_from_constant_commute_after := [llvm|
{
^0(%arg0 : i5, %arg1 : i5):
  %0 = "llvm.mlir.constant"() <{"value" = 10 : i5}> : () -> i5
  %1 = llvm.mul %arg1, %arg1 : i5
  %2 = llvm.sub %1, %arg0 : i5
  %3 = llvm.add %2, %0 : i5
  "llvm.return"(%3) : (i5) -> ()
}
]
theorem sub_from_constant_commute_proof : sub_from_constant_commute_before ⊑ sub_from_constant_commute_after := by
  sorry



def sub_from_constant_vec_before := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[2, -42]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.sub %0, %arg0 : vector<2xi8>
  %2 = llvm.add %1, %arg1 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
def sub_from_constant_vec_after := [llvm|
{
^0(%arg0 : vector<2xi8>, %arg1 : vector<2xi8>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<[2, -42]> : vector<2xi8>}> : () -> vector<2xi8>
  %1 = llvm.sub %arg1, %arg0 : vector<2xi8>
  %2 = llvm.add %1, %0 : vector<2xi8>
  "llvm.return"(%2) : (vector<2xi8>) -> ()
}
]
theorem sub_from_constant_vec_proof : sub_from_constant_vec_before ⊑ sub_from_constant_vec_after := by
  sorry


