import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  load-store-forward
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def load_smaller_int_before := [llvmfunc|
  llvm.func @load_smaller_int(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(258 : i16) : i16
    llvm.store %0, %arg0 {alignment = 2 : i64} : i16, !llvm.ptr]

    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %1 : i8
  }]

def load_larger_int_before := [llvmfunc|
  llvm.func @load_larger_int(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(258 : i16) : i16
    llvm.store %0, %arg0 {alignment = 2 : i64} : i16, !llvm.ptr]

    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %1 : i32
  }]

def vec_store_load_first_before := [llvmfunc|
  llvm.func @vec_store_load_first(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    llvm.store %0, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %1 : i32
  }]

def vec_store_load_first_odd_size_before := [llvmfunc|
  llvm.func @vec_store_load_first_odd_size(%arg0: !llvm.ptr) -> i17 {
    %0 = llvm.mlir.constant(2 : i17) : i17
    %1 = llvm.mlir.constant(1 : i17) : i17
    %2 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi17>) : vector<2xi17>
    llvm.store %2, %arg0 {alignment = 8 : i64} : vector<2xi17>, !llvm.ptr]

    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i17]

    llvm.return %3 : i17
  }]

def vec_store_load_first_constexpr_before := [llvmfunc|
  llvm.func @vec_store_load_first_constexpr(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @vec_store_load_first : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.bitcast %1 : i64 to vector<2xi32>
    llvm.store %2, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %3 : i32
  }]

def vec_store_load_second_before := [llvmfunc|
  llvm.func @vec_store_load_second(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    llvm.store %0, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %3 : i32
  }]

def vec_store_load_whole_before := [llvmfunc|
  llvm.func @vec_store_load_whole(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    llvm.store %0, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64]

    llvm.return %1 : i64
  }]

def vec_store_load_overlap_before := [llvmfunc|
  llvm.func @vec_store_load_overlap(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(2 : i64) : i64
    llvm.store %0, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 2 : i64} : !llvm.ptr -> i32]

    llvm.return %3 : i32
  }]

def load_i32_store_nxv4i32_before := [llvmfunc|
  llvm.func @load_i32_store_nxv4i32(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr]

    %5 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %5 : i32
  }]

def load_i64_store_nxv8i8_before := [llvmfunc|
  llvm.func @load_i64_store_nxv8i8(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 8 x  i8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 8 x  i8>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0, 0, 0, 0, 0] : !llvm.vec<? x 8 x  i8> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[8]xi8>, !llvm.ptr]

    %5 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

    llvm.return %5 : i64
  }]

def load_i64_store_nxv4i32_before := [llvmfunc|
  llvm.func @load_i64_store_nxv4i32(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr]

    %5 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

    llvm.return %5 : i64
  }]

def load_i8_store_nxv4i32_before := [llvmfunc|
  llvm.func @load_i8_store_nxv4i32(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr]

    %5 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %5 : i8
  }]

def load_f32_store_nxv4f32_before := [llvmfunc|
  llvm.func @load_f32_store_nxv4f32(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  f32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  f32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xf32>, !llvm.ptr]

    %5 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.return %5 : f32
  }]

def load_i32_store_nxv4f32_before := [llvmfunc|
  llvm.func @load_i32_store_nxv4f32(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  f32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  f32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xf32>, !llvm.ptr]

    %5 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %5 : i32
  }]

def load_v4i32_store_nxv4i32_before := [llvmfunc|
  llvm.func @load_v4i32_store_nxv4i32(%arg0: !llvm.ptr) -> vector<4xi32> {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr]

    %5 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xi32>]

    llvm.return %5 : vector<4xi32>
  }]

def load_v4i16_store_nxv4i32_before := [llvmfunc|
  llvm.func @load_v4i16_store_nxv4i32(%arg0: !llvm.ptr) -> vector<4xi16> {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr]

    %5 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xi16>]

    llvm.return %5 : vector<4xi16>
  }]

def load_i64_store_nxv4i8_before := [llvmfunc|
  llvm.func @load_i64_store_nxv4i8(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i8>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i8> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi8>, !llvm.ptr]

    %5 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

    llvm.return %5 : i64
  }]

def load_nxv4i8_store_nxv4i32_before := [llvmfunc|
  llvm.func @load_nxv4i8_store_nxv4i32(%arg0: !llvm.ptr) -> !llvm.vec<? x 4 x  i8> {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr]

    %5 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i8>]

    llvm.return %5 : !llvm.vec<? x 4 x  i8>
  }]

def load_i8_store_i1_before := [llvmfunc|
  llvm.func @load_i8_store_i1(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.store %0, %arg0 {alignment = 1 : i64} : i1, !llvm.ptr]

    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %1 : i8
  }]

def load_i1_store_i8_before := [llvmfunc|
  llvm.func @load_i1_store_i8(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i1]

    llvm.return %1 : i1
  }]

def load_after_memset_0_before := [llvmfunc|
  llvm.func @load_after_memset_0(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def load_after_memset_0_float_before := [llvmfunc|
  llvm.func @load_after_memset_0_float(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.return %2 : f32
  }]

def load_after_memset_0_non_byte_sized_before := [llvmfunc|
  llvm.func @load_after_memset_0_non_byte_sized(%arg0: !llvm.ptr) -> i27 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i27]

    llvm.return %2 : i27
  }]

def load_after_memset_0_i1_before := [llvmfunc|
  llvm.func @load_after_memset_0_i1(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i1]

    llvm.return %2 : i1
  }]

def load_after_memset_0_vec_before := [llvmfunc|
  llvm.func @load_after_memset_0_vec(%arg0: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<4xi8>]

    llvm.return %2 : vector<4xi8>
  }]

def load_after_memset_1_before := [llvmfunc|
  llvm.func @load_after_memset_1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def load_after_memset_1_float_before := [llvmfunc|
  llvm.func @load_after_memset_1_float(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.return %2 : f32
  }]

def load_after_memset_1_non_byte_sized_before := [llvmfunc|
  llvm.func @load_after_memset_1_non_byte_sized(%arg0: !llvm.ptr) -> i27 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i27]

    llvm.return %2 : i27
  }]

def load_after_memset_1_i1_before := [llvmfunc|
  llvm.func @load_after_memset_1_i1(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i1]

    llvm.return %2 : i1
  }]

def load_after_memset_1_vec_before := [llvmfunc|
  llvm.func @load_after_memset_1_vec(%arg0: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<4xi8>]

    llvm.return %2 : vector<4xi8>
  }]

def load_after_memset_unknown_before := [llvmfunc|
  llvm.func @load_after_memset_unknown(%arg0: !llvm.ptr, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %1 : i32
  }]

def load_after_memset_0_offset_before := [llvmfunc|
  llvm.func @load_after_memset_0_offset(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(4 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %4 : i32
  }]

def load_after_memset_0_offset_too_large_before := [llvmfunc|
  llvm.func @load_after_memset_0_offset_too_large(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(13 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %4 : i32
  }]

def load_after_memset_0_offset_negative_before := [llvmfunc|
  llvm.func @load_after_memset_0_offset_negative(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %4 : i32
  }]

def load_after_memset_0_clobber_before := [llvmfunc|
  llvm.func @load_after_memset_0_clobber(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(1 : i8) : i8
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    llvm.store %2, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %3 : i32
  }]

def load_after_memset_0_too_small_before := [llvmfunc|
  llvm.func @load_after_memset_0_too_small(%arg0: !llvm.ptr) -> i256 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i256]

    llvm.return %2 : i256
  }]

def load_after_memset_0_too_small_by_one_bit_before := [llvmfunc|
  llvm.func @load_after_memset_0_too_small_by_one_bit(%arg0: !llvm.ptr) -> i129 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i129]

    llvm.return %2 : i129
  }]

def load_after_memset_0_unknown_length_before := [llvmfunc|
  llvm.func @load_after_memset_0_unknown_length(%arg0: !llvm.ptr, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    "llvm.intr.memset"(%arg0, %0, %arg1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %1 : i32
  }]

def load_after_memset_0_atomic_before := [llvmfunc|
  llvm.func @load_after_memset_0_atomic(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def load_after_memset_0_scalable_before := [llvmfunc|
  llvm.func @load_after_memset_0_scalable(%arg0: !llvm.ptr) -> !llvm.vec<? x 1 x  i32> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.vec<? x 1 x  i32>]

    llvm.return %2 : !llvm.vec<? x 1 x  i32>
  }]

def load_smaller_int_combined := [llvmfunc|
  llvm.func @load_smaller_int(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(258 : i16) : i16
    %1 = llvm.mlir.constant(2 : i8) : i8
    llvm.store %0, %arg0 {alignment = 2 : i64} : i16, !llvm.ptr]

theorem inst_combine_load_smaller_int   : load_smaller_int_before  ⊑  load_smaller_int_combined := by
  unfold load_smaller_int_before load_smaller_int_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_load_smaller_int   : load_smaller_int_before  ⊑  load_smaller_int_combined := by
  unfold load_smaller_int_before load_smaller_int_combined
  simp_alive_peephole
  sorry
def load_larger_int_combined := [llvmfunc|
  llvm.func @load_larger_int(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(258 : i16) : i16
    llvm.store %0, %arg0 {alignment = 2 : i64} : i16, !llvm.ptr]

theorem inst_combine_load_larger_int   : load_larger_int_before  ⊑  load_larger_int_combined := by
  unfold load_larger_int_before load_larger_int_combined
  simp_alive_peephole
  sorry
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_load_larger_int   : load_larger_int_before  ⊑  load_larger_int_combined := by
  unfold load_larger_int_before load_larger_int_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_load_larger_int   : load_larger_int_before  ⊑  load_larger_int_combined := by
  unfold load_larger_int_before load_larger_int_combined
  simp_alive_peephole
  sorry
def vec_store_load_first_combined := [llvmfunc|
  llvm.func @vec_store_load_first(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.store %0, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

theorem inst_combine_vec_store_load_first   : vec_store_load_first_before  ⊑  vec_store_load_first_combined := by
  unfold vec_store_load_first_before vec_store_load_first_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_vec_store_load_first   : vec_store_load_first_before  ⊑  vec_store_load_first_combined := by
  unfold vec_store_load_first_before vec_store_load_first_combined
  simp_alive_peephole
  sorry
def vec_store_load_first_odd_size_combined := [llvmfunc|
  llvm.func @vec_store_load_first_odd_size(%arg0: !llvm.ptr) -> i17 {
    %0 = llvm.mlir.constant(2 : i17) : i17
    %1 = llvm.mlir.constant(1 : i17) : i17
    %2 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi17>) : vector<2xi17>
    llvm.store %2, %arg0 {alignment = 8 : i64} : vector<2xi17>, !llvm.ptr]

theorem inst_combine_vec_store_load_first_odd_size   : vec_store_load_first_odd_size_before  ⊑  vec_store_load_first_odd_size_combined := by
  unfold vec_store_load_first_odd_size_before vec_store_load_first_odd_size_combined
  simp_alive_peephole
  sorry
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i17]

theorem inst_combine_vec_store_load_first_odd_size   : vec_store_load_first_odd_size_before  ⊑  vec_store_load_first_odd_size_combined := by
  unfold vec_store_load_first_odd_size_before vec_store_load_first_odd_size_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i17
  }]

theorem inst_combine_vec_store_load_first_odd_size   : vec_store_load_first_odd_size_before  ⊑  vec_store_load_first_odd_size_combined := by
  unfold vec_store_load_first_odd_size_before vec_store_load_first_odd_size_combined
  simp_alive_peephole
  sorry
def vec_store_load_first_constexpr_combined := [llvmfunc|
  llvm.func @vec_store_load_first_constexpr(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @vec_store_load_first : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.bitcast %1 : i64 to vector<2xi32>
    llvm.store %2, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

theorem inst_combine_vec_store_load_first_constexpr   : vec_store_load_first_constexpr_before  ⊑  vec_store_load_first_constexpr_combined := by
  unfold vec_store_load_first_constexpr_before vec_store_load_first_constexpr_combined
  simp_alive_peephole
  sorry
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_vec_store_load_first_constexpr   : vec_store_load_first_constexpr_before  ⊑  vec_store_load_first_constexpr_combined := by
  unfold vec_store_load_first_constexpr_before vec_store_load_first_constexpr_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i32
  }]

theorem inst_combine_vec_store_load_first_constexpr   : vec_store_load_first_constexpr_before  ⊑  vec_store_load_first_constexpr_combined := by
  unfold vec_store_load_first_constexpr_before vec_store_load_first_constexpr_combined
  simp_alive_peephole
  sorry
def vec_store_load_second_combined := [llvmfunc|
  llvm.func @vec_store_load_second(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    llvm.store %0, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

theorem inst_combine_vec_store_load_second   : vec_store_load_second_before  ⊑  vec_store_load_second_combined := by
  unfold vec_store_load_second_before vec_store_load_second_combined
  simp_alive_peephole
  sorry
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_vec_store_load_second   : vec_store_load_second_before  ⊑  vec_store_load_second_combined := by
  unfold vec_store_load_second_before vec_store_load_second_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i32
  }]

theorem inst_combine_vec_store_load_second   : vec_store_load_second_before  ⊑  vec_store_load_second_combined := by
  unfold vec_store_load_second_before vec_store_load_second_combined
  simp_alive_peephole
  sorry
def vec_store_load_whole_combined := [llvmfunc|
  llvm.func @vec_store_load_whole(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(8589934593 : i64) : i64
    llvm.store %0, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

theorem inst_combine_vec_store_load_whole   : vec_store_load_whole_before  ⊑  vec_store_load_whole_combined := by
  unfold vec_store_load_whole_before vec_store_load_whole_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i64
  }]

theorem inst_combine_vec_store_load_whole   : vec_store_load_whole_before  ⊑  vec_store_load_whole_combined := by
  unfold vec_store_load_whole_before vec_store_load_whole_combined
  simp_alive_peephole
  sorry
def vec_store_load_overlap_combined := [llvmfunc|
  llvm.func @vec_store_load_overlap(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(2 : i64) : i64
    llvm.store %0, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

theorem inst_combine_vec_store_load_overlap   : vec_store_load_overlap_before  ⊑  vec_store_load_overlap_combined := by
  unfold vec_store_load_overlap_before vec_store_load_overlap_combined
  simp_alive_peephole
  sorry
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 2 : i64} : !llvm.ptr -> i32]

theorem inst_combine_vec_store_load_overlap   : vec_store_load_overlap_before  ⊑  vec_store_load_overlap_combined := by
  unfold vec_store_load_overlap_before vec_store_load_overlap_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i32
  }]

theorem inst_combine_vec_store_load_overlap   : vec_store_load_overlap_before  ⊑  vec_store_load_overlap_combined := by
  unfold vec_store_load_overlap_before vec_store_load_overlap_combined
  simp_alive_peephole
  sorry
def load_i32_store_nxv4i32_combined := [llvmfunc|
  llvm.func @load_i32_store_nxv4i32(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr]

theorem inst_combine_load_i32_store_nxv4i32   : load_i32_store_nxv4i32_before  ⊑  load_i32_store_nxv4i32_combined := by
  unfold load_i32_store_nxv4i32_before load_i32_store_nxv4i32_combined
  simp_alive_peephole
  sorry
    %5 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_load_i32_store_nxv4i32   : load_i32_store_nxv4i32_before  ⊑  load_i32_store_nxv4i32_combined := by
  unfold load_i32_store_nxv4i32_before load_i32_store_nxv4i32_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i32
  }]

theorem inst_combine_load_i32_store_nxv4i32   : load_i32_store_nxv4i32_before  ⊑  load_i32_store_nxv4i32_combined := by
  unfold load_i32_store_nxv4i32_before load_i32_store_nxv4i32_combined
  simp_alive_peephole
  sorry
def load_i64_store_nxv8i8_combined := [llvmfunc|
  llvm.func @load_i64_store_nxv8i8(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 8 x  i8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 8 x  i8>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0, 0, 0, 0, 0] : !llvm.vec<? x 8 x  i8> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[8]xi8>, !llvm.ptr]

theorem inst_combine_load_i64_store_nxv8i8   : load_i64_store_nxv8i8_before  ⊑  load_i64_store_nxv8i8_combined := by
  unfold load_i64_store_nxv8i8_before load_i64_store_nxv8i8_combined
  simp_alive_peephole
  sorry
    %5 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

theorem inst_combine_load_i64_store_nxv8i8   : load_i64_store_nxv8i8_before  ⊑  load_i64_store_nxv8i8_combined := by
  unfold load_i64_store_nxv8i8_before load_i64_store_nxv8i8_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i64
  }]

theorem inst_combine_load_i64_store_nxv8i8   : load_i64_store_nxv8i8_before  ⊑  load_i64_store_nxv8i8_combined := by
  unfold load_i64_store_nxv8i8_before load_i64_store_nxv8i8_combined
  simp_alive_peephole
  sorry
def load_i64_store_nxv4i32_combined := [llvmfunc|
  llvm.func @load_i64_store_nxv4i32(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr]

theorem inst_combine_load_i64_store_nxv4i32   : load_i64_store_nxv4i32_before  ⊑  load_i64_store_nxv4i32_combined := by
  unfold load_i64_store_nxv4i32_before load_i64_store_nxv4i32_combined
  simp_alive_peephole
  sorry
    %5 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

theorem inst_combine_load_i64_store_nxv4i32   : load_i64_store_nxv4i32_before  ⊑  load_i64_store_nxv4i32_combined := by
  unfold load_i64_store_nxv4i32_before load_i64_store_nxv4i32_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i64
  }]

theorem inst_combine_load_i64_store_nxv4i32   : load_i64_store_nxv4i32_before  ⊑  load_i64_store_nxv4i32_combined := by
  unfold load_i64_store_nxv4i32_before load_i64_store_nxv4i32_combined
  simp_alive_peephole
  sorry
def load_i8_store_nxv4i32_combined := [llvmfunc|
  llvm.func @load_i8_store_nxv4i32(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr]

theorem inst_combine_load_i8_store_nxv4i32   : load_i8_store_nxv4i32_before  ⊑  load_i8_store_nxv4i32_combined := by
  unfold load_i8_store_nxv4i32_before load_i8_store_nxv4i32_combined
  simp_alive_peephole
  sorry
    %5 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_load_i8_store_nxv4i32   : load_i8_store_nxv4i32_before  ⊑  load_i8_store_nxv4i32_combined := by
  unfold load_i8_store_nxv4i32_before load_i8_store_nxv4i32_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i8
  }]

theorem inst_combine_load_i8_store_nxv4i32   : load_i8_store_nxv4i32_before  ⊑  load_i8_store_nxv4i32_combined := by
  unfold load_i8_store_nxv4i32_before load_i8_store_nxv4i32_combined
  simp_alive_peephole
  sorry
def load_f32_store_nxv4f32_combined := [llvmfunc|
  llvm.func @load_f32_store_nxv4f32(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  f32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  f32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xf32>, !llvm.ptr]

theorem inst_combine_load_f32_store_nxv4f32   : load_f32_store_nxv4f32_before  ⊑  load_f32_store_nxv4f32_combined := by
  unfold load_f32_store_nxv4f32_before load_f32_store_nxv4f32_combined
  simp_alive_peephole
  sorry
    %5 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine_load_f32_store_nxv4f32   : load_f32_store_nxv4f32_before  ⊑  load_f32_store_nxv4f32_combined := by
  unfold load_f32_store_nxv4f32_before load_f32_store_nxv4f32_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : f32
  }]

theorem inst_combine_load_f32_store_nxv4f32   : load_f32_store_nxv4f32_before  ⊑  load_f32_store_nxv4f32_combined := by
  unfold load_f32_store_nxv4f32_before load_f32_store_nxv4f32_combined
  simp_alive_peephole
  sorry
def load_i32_store_nxv4f32_combined := [llvmfunc|
  llvm.func @load_i32_store_nxv4f32(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  f32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  f32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xf32>, !llvm.ptr]

theorem inst_combine_load_i32_store_nxv4f32   : load_i32_store_nxv4f32_before  ⊑  load_i32_store_nxv4f32_combined := by
  unfold load_i32_store_nxv4f32_before load_i32_store_nxv4f32_combined
  simp_alive_peephole
  sorry
    %5 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_load_i32_store_nxv4f32   : load_i32_store_nxv4f32_before  ⊑  load_i32_store_nxv4f32_combined := by
  unfold load_i32_store_nxv4f32_before load_i32_store_nxv4f32_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i32
  }]

theorem inst_combine_load_i32_store_nxv4f32   : load_i32_store_nxv4f32_before  ⊑  load_i32_store_nxv4f32_combined := by
  unfold load_i32_store_nxv4f32_before load_i32_store_nxv4f32_combined
  simp_alive_peephole
  sorry
def load_v4i32_store_nxv4i32_combined := [llvmfunc|
  llvm.func @load_v4i32_store_nxv4i32(%arg0: !llvm.ptr) -> vector<4xi32> {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr]

theorem inst_combine_load_v4i32_store_nxv4i32   : load_v4i32_store_nxv4i32_before  ⊑  load_v4i32_store_nxv4i32_combined := by
  unfold load_v4i32_store_nxv4i32_before load_v4i32_store_nxv4i32_combined
  simp_alive_peephole
  sorry
    %5 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xi32>]

theorem inst_combine_load_v4i32_store_nxv4i32   : load_v4i32_store_nxv4i32_before  ⊑  load_v4i32_store_nxv4i32_combined := by
  unfold load_v4i32_store_nxv4i32_before load_v4i32_store_nxv4i32_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : vector<4xi32>
  }]

theorem inst_combine_load_v4i32_store_nxv4i32   : load_v4i32_store_nxv4i32_before  ⊑  load_v4i32_store_nxv4i32_combined := by
  unfold load_v4i32_store_nxv4i32_before load_v4i32_store_nxv4i32_combined
  simp_alive_peephole
  sorry
def load_v4i16_store_nxv4i32_combined := [llvmfunc|
  llvm.func @load_v4i16_store_nxv4i32(%arg0: !llvm.ptr) -> vector<4xi16> {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr]

theorem inst_combine_load_v4i16_store_nxv4i32   : load_v4i16_store_nxv4i32_before  ⊑  load_v4i16_store_nxv4i32_combined := by
  unfold load_v4i16_store_nxv4i32_before load_v4i16_store_nxv4i32_combined
  simp_alive_peephole
  sorry
    %5 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xi16>]

theorem inst_combine_load_v4i16_store_nxv4i32   : load_v4i16_store_nxv4i32_before  ⊑  load_v4i16_store_nxv4i32_combined := by
  unfold load_v4i16_store_nxv4i32_before load_v4i16_store_nxv4i32_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : vector<4xi16>
  }]

theorem inst_combine_load_v4i16_store_nxv4i32   : load_v4i16_store_nxv4i32_before  ⊑  load_v4i16_store_nxv4i32_combined := by
  unfold load_v4i16_store_nxv4i32_before load_v4i16_store_nxv4i32_combined
  simp_alive_peephole
  sorry
def load_i64_store_nxv4i8_combined := [llvmfunc|
  llvm.func @load_i64_store_nxv4i8(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i8>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i8> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi8>, !llvm.ptr]

theorem inst_combine_load_i64_store_nxv4i8   : load_i64_store_nxv4i8_before  ⊑  load_i64_store_nxv4i8_combined := by
  unfold load_i64_store_nxv4i8_before load_i64_store_nxv4i8_combined
  simp_alive_peephole
  sorry
    %5 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

theorem inst_combine_load_i64_store_nxv4i8   : load_i64_store_nxv4i8_before  ⊑  load_i64_store_nxv4i8_combined := by
  unfold load_i64_store_nxv4i8_before load_i64_store_nxv4i8_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i64
  }]

theorem inst_combine_load_i64_store_nxv4i8   : load_i64_store_nxv4i8_before  ⊑  load_i64_store_nxv4i8_combined := by
  unfold load_i64_store_nxv4i8_before load_i64_store_nxv4i8_combined
  simp_alive_peephole
  sorry
def load_nxv4i8_store_nxv4i32_combined := [llvmfunc|
  llvm.func @load_nxv4i8_store_nxv4i32(%arg0: !llvm.ptr) -> !llvm.vec<? x 4 x  i8> {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr]

theorem inst_combine_load_nxv4i8_store_nxv4i32   : load_nxv4i8_store_nxv4i32_before  ⊑  load_nxv4i8_store_nxv4i32_combined := by
  unfold load_nxv4i8_store_nxv4i32_before load_nxv4i8_store_nxv4i32_combined
  simp_alive_peephole
  sorry
    %5 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i8>]

theorem inst_combine_load_nxv4i8_store_nxv4i32   : load_nxv4i8_store_nxv4i32_before  ⊑  load_nxv4i8_store_nxv4i32_combined := by
  unfold load_nxv4i8_store_nxv4i32_before load_nxv4i8_store_nxv4i32_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : !llvm.vec<? x 4 x  i8>
  }]

theorem inst_combine_load_nxv4i8_store_nxv4i32   : load_nxv4i8_store_nxv4i32_before  ⊑  load_nxv4i8_store_nxv4i32_combined := by
  unfold load_nxv4i8_store_nxv4i32_before load_nxv4i8_store_nxv4i32_combined
  simp_alive_peephole
  sorry
def load_i8_store_i1_combined := [llvmfunc|
  llvm.func @load_i8_store_i1(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.store %0, %arg0 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_load_i8_store_i1   : load_i8_store_i1_before  ⊑  load_i8_store_i1_combined := by
  unfold load_i8_store_i1_before load_i8_store_i1_combined
  simp_alive_peephole
  sorry
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_load_i8_store_i1   : load_i8_store_i1_before  ⊑  load_i8_store_i1_combined := by
  unfold load_i8_store_i1_before load_i8_store_i1_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_load_i8_store_i1   : load_i8_store_i1_before  ⊑  load_i8_store_i1_combined := by
  unfold load_i8_store_i1_before load_i8_store_i1_combined
  simp_alive_peephole
  sorry
def load_i1_store_i8_combined := [llvmfunc|
  llvm.func @load_i1_store_i8(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_load_i1_store_i8   : load_i1_store_i8_before  ⊑  load_i1_store_i8_combined := by
  unfold load_i1_store_i8_before load_i1_store_i8_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_load_i1_store_i8   : load_i1_store_i8_before  ⊑  load_i1_store_i8_combined := by
  unfold load_i1_store_i8_before load_i1_store_i8_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_combined := [llvmfunc|
  llvm.func @load_after_memset_0(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0   : load_after_memset_0_before  ⊑  load_after_memset_0_combined := by
  unfold load_after_memset_0_before load_after_memset_0_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_load_after_memset_0   : load_after_memset_0_before  ⊑  load_after_memset_0_combined := by
  unfold load_after_memset_0_before load_after_memset_0_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_float_combined := [llvmfunc|
  llvm.func @load_after_memset_0_float(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0_float   : load_after_memset_0_float_before  ⊑  load_after_memset_0_float_combined := by
  unfold load_after_memset_0_float_before load_after_memset_0_float_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_load_after_memset_0_float   : load_after_memset_0_float_before  ⊑  load_after_memset_0_float_combined := by
  unfold load_after_memset_0_float_before load_after_memset_0_float_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_non_byte_sized_combined := [llvmfunc|
  llvm.func @load_after_memset_0_non_byte_sized(%arg0: !llvm.ptr) -> i27 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(0 : i27) : i27
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0_non_byte_sized   : load_after_memset_0_non_byte_sized_before  ⊑  load_after_memset_0_non_byte_sized_combined := by
  unfold load_after_memset_0_non_byte_sized_before load_after_memset_0_non_byte_sized_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i27
  }]

theorem inst_combine_load_after_memset_0_non_byte_sized   : load_after_memset_0_non_byte_sized_before  ⊑  load_after_memset_0_non_byte_sized_combined := by
  unfold load_after_memset_0_non_byte_sized_before load_after_memset_0_non_byte_sized_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_i1_combined := [llvmfunc|
  llvm.func @load_after_memset_0_i1(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0_i1   : load_after_memset_0_i1_before  ⊑  load_after_memset_0_i1_combined := by
  unfold load_after_memset_0_i1_before load_after_memset_0_i1_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_load_after_memset_0_i1   : load_after_memset_0_i1_before  ⊑  load_after_memset_0_i1_combined := by
  unfold load_after_memset_0_i1_before load_after_memset_0_i1_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_vec_combined := [llvmfunc|
  llvm.func @load_after_memset_0_vec(%arg0: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0_vec   : load_after_memset_0_vec_before  ⊑  load_after_memset_0_vec_combined := by
  unfold load_after_memset_0_vec_before load_after_memset_0_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_load_after_memset_0_vec   : load_after_memset_0_vec_before  ⊑  load_after_memset_0_vec_combined := by
  unfold load_after_memset_0_vec_before load_after_memset_0_vec_combined
  simp_alive_peephole
  sorry
def load_after_memset_1_combined := [llvmfunc|
  llvm.func @load_after_memset_1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(16843009 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_1   : load_after_memset_1_before  ⊑  load_after_memset_1_combined := by
  unfold load_after_memset_1_before load_after_memset_1_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_load_after_memset_1   : load_after_memset_1_before  ⊑  load_after_memset_1_combined := by
  unfold load_after_memset_1_before load_after_memset_1_combined
  simp_alive_peephole
  sorry
def load_after_memset_1_float_combined := [llvmfunc|
  llvm.func @load_after_memset_1_float(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(2.36942783E-38 : f32) : f32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_1_float   : load_after_memset_1_float_before  ⊑  load_after_memset_1_float_combined := by
  unfold load_after_memset_1_float_before load_after_memset_1_float_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_load_after_memset_1_float   : load_after_memset_1_float_before  ⊑  load_after_memset_1_float_combined := by
  unfold load_after_memset_1_float_before load_after_memset_1_float_combined
  simp_alive_peephole
  sorry
def load_after_memset_1_non_byte_sized_combined := [llvmfunc|
  llvm.func @load_after_memset_1_non_byte_sized(%arg0: !llvm.ptr) -> i27 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(16843009 : i27) : i27
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_1_non_byte_sized   : load_after_memset_1_non_byte_sized_before  ⊑  load_after_memset_1_non_byte_sized_combined := by
  unfold load_after_memset_1_non_byte_sized_before load_after_memset_1_non_byte_sized_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i27
  }]

theorem inst_combine_load_after_memset_1_non_byte_sized   : load_after_memset_1_non_byte_sized_before  ⊑  load_after_memset_1_non_byte_sized_combined := by
  unfold load_after_memset_1_non_byte_sized_before load_after_memset_1_non_byte_sized_combined
  simp_alive_peephole
  sorry
def load_after_memset_1_i1_combined := [llvmfunc|
  llvm.func @load_after_memset_1_i1(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_1_i1   : load_after_memset_1_i1_before  ⊑  load_after_memset_1_i1_combined := by
  unfold load_after_memset_1_i1_before load_after_memset_1_i1_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_load_after_memset_1_i1   : load_after_memset_1_i1_before  ⊑  load_after_memset_1_i1_combined := by
  unfold load_after_memset_1_i1_before load_after_memset_1_i1_combined
  simp_alive_peephole
  sorry
def load_after_memset_1_vec_combined := [llvmfunc|
  llvm.func @load_after_memset_1_vec(%arg0: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_1_vec   : load_after_memset_1_vec_before  ⊑  load_after_memset_1_vec_combined := by
  unfold load_after_memset_1_vec_before load_after_memset_1_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_load_after_memset_1_vec   : load_after_memset_1_vec_before  ⊑  load_after_memset_1_vec_combined := by
  unfold load_after_memset_1_vec_before load_after_memset_1_vec_combined
  simp_alive_peephole
  sorry
def load_after_memset_unknown_combined := [llvmfunc|
  llvm.func @load_after_memset_unknown(%arg0: !llvm.ptr, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_unknown   : load_after_memset_unknown_before  ⊑  load_after_memset_unknown_combined := by
  unfold load_after_memset_unknown_before load_after_memset_unknown_combined
  simp_alive_peephole
  sorry
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_load_after_memset_unknown   : load_after_memset_unknown_before  ⊑  load_after_memset_unknown_combined := by
  unfold load_after_memset_unknown_before load_after_memset_unknown_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_load_after_memset_unknown   : load_after_memset_unknown_before  ⊑  load_after_memset_unknown_combined := by
  unfold load_after_memset_unknown_before load_after_memset_unknown_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_offset_combined := [llvmfunc|
  llvm.func @load_after_memset_0_offset(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(4 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0_offset   : load_after_memset_0_offset_before  ⊑  load_after_memset_0_offset_combined := by
  unfold load_after_memset_0_offset_before load_after_memset_0_offset_combined
  simp_alive_peephole
  sorry
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_load_after_memset_0_offset   : load_after_memset_0_offset_before  ⊑  load_after_memset_0_offset_combined := by
  unfold load_after_memset_0_offset_before load_after_memset_0_offset_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i32
  }]

theorem inst_combine_load_after_memset_0_offset   : load_after_memset_0_offset_before  ⊑  load_after_memset_0_offset_combined := by
  unfold load_after_memset_0_offset_before load_after_memset_0_offset_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_offset_too_large_combined := [llvmfunc|
  llvm.func @load_after_memset_0_offset_too_large(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(13 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0_offset_too_large   : load_after_memset_0_offset_too_large_before  ⊑  load_after_memset_0_offset_too_large_combined := by
  unfold load_after_memset_0_offset_too_large_before load_after_memset_0_offset_too_large_combined
  simp_alive_peephole
  sorry
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_load_after_memset_0_offset_too_large   : load_after_memset_0_offset_too_large_before  ⊑  load_after_memset_0_offset_too_large_combined := by
  unfold load_after_memset_0_offset_too_large_before load_after_memset_0_offset_too_large_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i32
  }]

theorem inst_combine_load_after_memset_0_offset_too_large   : load_after_memset_0_offset_too_large_before  ⊑  load_after_memset_0_offset_too_large_combined := by
  unfold load_after_memset_0_offset_too_large_before load_after_memset_0_offset_too_large_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_offset_negative_combined := [llvmfunc|
  llvm.func @load_after_memset_0_offset_negative(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0_offset_negative   : load_after_memset_0_offset_negative_before  ⊑  load_after_memset_0_offset_negative_combined := by
  unfold load_after_memset_0_offset_negative_before load_after_memset_0_offset_negative_combined
  simp_alive_peephole
  sorry
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_load_after_memset_0_offset_negative   : load_after_memset_0_offset_negative_before  ⊑  load_after_memset_0_offset_negative_combined := by
  unfold load_after_memset_0_offset_negative_before load_after_memset_0_offset_negative_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i32
  }]

theorem inst_combine_load_after_memset_0_offset_negative   : load_after_memset_0_offset_negative_before  ⊑  load_after_memset_0_offset_negative_combined := by
  unfold load_after_memset_0_offset_negative_before load_after_memset_0_offset_negative_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_clobber_combined := [llvmfunc|
  llvm.func @load_after_memset_0_clobber(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(1 : i8) : i8
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0_clobber   : load_after_memset_0_clobber_before  ⊑  load_after_memset_0_clobber_combined := by
  unfold load_after_memset_0_clobber_before load_after_memset_0_clobber_combined
  simp_alive_peephole
  sorry
    llvm.store %2, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_load_after_memset_0_clobber   : load_after_memset_0_clobber_before  ⊑  load_after_memset_0_clobber_combined := by
  unfold load_after_memset_0_clobber_before load_after_memset_0_clobber_combined
  simp_alive_peephole
  sorry
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_load_after_memset_0_clobber   : load_after_memset_0_clobber_before  ⊑  load_after_memset_0_clobber_combined := by
  unfold load_after_memset_0_clobber_before load_after_memset_0_clobber_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i32
  }]

theorem inst_combine_load_after_memset_0_clobber   : load_after_memset_0_clobber_before  ⊑  load_after_memset_0_clobber_combined := by
  unfold load_after_memset_0_clobber_before load_after_memset_0_clobber_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_too_small_combined := [llvmfunc|
  llvm.func @load_after_memset_0_too_small(%arg0: !llvm.ptr) -> i256 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0_too_small   : load_after_memset_0_too_small_before  ⊑  load_after_memset_0_too_small_combined := by
  unfold load_after_memset_0_too_small_before load_after_memset_0_too_small_combined
  simp_alive_peephole
  sorry
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i256]

theorem inst_combine_load_after_memset_0_too_small   : load_after_memset_0_too_small_before  ⊑  load_after_memset_0_too_small_combined := by
  unfold load_after_memset_0_too_small_before load_after_memset_0_too_small_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i256
  }]

theorem inst_combine_load_after_memset_0_too_small   : load_after_memset_0_too_small_before  ⊑  load_after_memset_0_too_small_combined := by
  unfold load_after_memset_0_too_small_before load_after_memset_0_too_small_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_too_small_by_one_bit_combined := [llvmfunc|
  llvm.func @load_after_memset_0_too_small_by_one_bit(%arg0: !llvm.ptr) -> i129 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0_too_small_by_one_bit   : load_after_memset_0_too_small_by_one_bit_before  ⊑  load_after_memset_0_too_small_by_one_bit_combined := by
  unfold load_after_memset_0_too_small_by_one_bit_before load_after_memset_0_too_small_by_one_bit_combined
  simp_alive_peephole
  sorry
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i129]

theorem inst_combine_load_after_memset_0_too_small_by_one_bit   : load_after_memset_0_too_small_by_one_bit_before  ⊑  load_after_memset_0_too_small_by_one_bit_combined := by
  unfold load_after_memset_0_too_small_by_one_bit_before load_after_memset_0_too_small_by_one_bit_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i129
  }]

theorem inst_combine_load_after_memset_0_too_small_by_one_bit   : load_after_memset_0_too_small_by_one_bit_before  ⊑  load_after_memset_0_too_small_by_one_bit_combined := by
  unfold load_after_memset_0_too_small_by_one_bit_before load_after_memset_0_too_small_by_one_bit_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_unknown_length_combined := [llvmfunc|
  llvm.func @load_after_memset_0_unknown_length(%arg0: !llvm.ptr, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    "llvm.intr.memset"(%arg0, %0, %arg1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0_unknown_length   : load_after_memset_0_unknown_length_before  ⊑  load_after_memset_0_unknown_length_combined := by
  unfold load_after_memset_0_unknown_length_before load_after_memset_0_unknown_length_combined
  simp_alive_peephole
  sorry
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_load_after_memset_0_unknown_length   : load_after_memset_0_unknown_length_before  ⊑  load_after_memset_0_unknown_length_combined := by
  unfold load_after_memset_0_unknown_length_before load_after_memset_0_unknown_length_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_load_after_memset_0_unknown_length   : load_after_memset_0_unknown_length_before  ⊑  load_after_memset_0_unknown_length_combined := by
  unfold load_after_memset_0_unknown_length_before load_after_memset_0_unknown_length_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_atomic_combined := [llvmfunc|
  llvm.func @load_after_memset_0_atomic(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0_atomic   : load_after_memset_0_atomic_before  ⊑  load_after_memset_0_atomic_combined := by
  unfold load_after_memset_0_atomic_before load_after_memset_0_atomic_combined
  simp_alive_peephole
  sorry
    %2 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_load_after_memset_0_atomic   : load_after_memset_0_atomic_before  ⊑  load_after_memset_0_atomic_combined := by
  unfold load_after_memset_0_atomic_before load_after_memset_0_atomic_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_load_after_memset_0_atomic   : load_after_memset_0_atomic_before  ⊑  load_after_memset_0_atomic_combined := by
  unfold load_after_memset_0_atomic_before load_after_memset_0_atomic_combined
  simp_alive_peephole
  sorry
def load_after_memset_0_scalable_combined := [llvmfunc|
  llvm.func @load_after_memset_0_scalable(%arg0: !llvm.ptr) -> !llvm.vec<? x 1 x  i32> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_load_after_memset_0_scalable   : load_after_memset_0_scalable_before  ⊑  load_after_memset_0_scalable_combined := by
  unfold load_after_memset_0_scalable_before load_after_memset_0_scalable_combined
  simp_alive_peephole
  sorry
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.vec<? x 1 x  i32>]

theorem inst_combine_load_after_memset_0_scalable   : load_after_memset_0_scalable_before  ⊑  load_after_memset_0_scalable_combined := by
  unfold load_after_memset_0_scalable_before load_after_memset_0_scalable_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : !llvm.vec<? x 1 x  i32>
  }]

theorem inst_combine_load_after_memset_0_scalable   : load_after_memset_0_scalable_before  ⊑  load_after_memset_0_scalable_combined := by
  unfold load_after_memset_0_scalable_before load_after_memset_0_scalable_combined
  simp_alive_peephole
  sorry
