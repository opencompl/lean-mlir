import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  double-float-shrink-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_shrink_libcall_floor_before := [llvmfunc|
  llvm.func @test_shrink_libcall_floor(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @floor(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_libcall_ceil_before := [llvmfunc|
  llvm.func @test_shrink_libcall_ceil(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @ceil(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_libcall_round_before := [llvmfunc|
  llvm.func @test_shrink_libcall_round(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @round(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_libcall_roundeven_before := [llvmfunc|
  llvm.func @test_shrink_libcall_roundeven(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @roundeven(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_libcall_nearbyint_before := [llvmfunc|
  llvm.func @test_shrink_libcall_nearbyint(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @nearbyint(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_libcall_trunc_before := [llvmfunc|
  llvm.func @test_shrink_libcall_trunc(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @trunc(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_libcall_fabs_before := [llvmfunc|
  llvm.func @test_shrink_libcall_fabs(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @fabs(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_libcall_fabs_fast_before := [llvmfunc|
  llvm.func @test_shrink_libcall_fabs_fast(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @fabs(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_intrin_ceil_before := [llvmfunc|
  llvm.func @test_shrink_intrin_ceil(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.ceil(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_intrin_fabs_before := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.fabs(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_intrin_floor_before := [llvmfunc|
  llvm.func @test_shrink_intrin_floor(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.floor(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_intrin_nearbyint_before := [llvmfunc|
  llvm.func @test_shrink_intrin_nearbyint(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.nearbyint(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_intrin_rint_before := [llvmfunc|
  llvm.func @test_shrink_intrin_rint(%arg0: f16) -> f16 {
    %0 = llvm.fpext %arg0 : f16 to f32
    %1 = llvm.intr.rint(%0)  : (f32) -> f32
    %2 = llvm.fptrunc %1 : f32 to f16
    llvm.return %2 : f16
  }]

def test_shrink_intrin_round_before := [llvmfunc|
  llvm.func @test_shrink_intrin_round(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.round(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_intrin_roundeven_before := [llvmfunc|
  llvm.func @test_shrink_intrin_roundeven(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.roundeven(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_intrin_trunc_before := [llvmfunc|
  llvm.func @test_shrink_intrin_trunc(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.trunc(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_intrin_ceil_multi_use_before := [llvmfunc|
  llvm.func @test_shrink_intrin_ceil_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.intr.ceil(%0)  : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }]

def test_shrink_intrin_fabs_multi_use_before := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.intr.fabs(%0)  : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%1) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }]

def test_shrink_intrin_floor_multi_use_before := [llvmfunc|
  llvm.func @test_shrink_intrin_floor_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.intr.floor(%0)  : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.call @use_v2f64(%1) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }]

def test_shrink_intrin_nearbyint_multi_use_before := [llvmfunc|
  llvm.func @test_shrink_intrin_nearbyint_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.intr.nearbyint(%0)  : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }]

def test_shrink_intrin_rint_multi_use_before := [llvmfunc|
  llvm.func @test_shrink_intrin_rint_multi_use(%arg0: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf32>
    %1 = llvm.intr.rint(%0)  : (vector<2xf32>) -> vector<2xf32>
    %2 = llvm.fptrunc %1 : vector<2xf32> to vector<2xf16>
    llvm.call @use_v2f32(%1) : (vector<2xf32>) -> ()
    llvm.return %2 : vector<2xf16>
  }]

def test_shrink_intrin_round_multi_use_before := [llvmfunc|
  llvm.func @test_shrink_intrin_round_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.intr.round(%0)  : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.call @use_v2f64(%1) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }]

def test_shrink_intrin_roundeven_multi_use_before := [llvmfunc|
  llvm.func @test_shrink_intrin_roundeven_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.intr.roundeven(%0)  : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.call @use_v2f64(%1) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }]

def test_shrink_intrin_trunc_multi_use_before := [llvmfunc|
  llvm.func @test_shrink_intrin_trunc_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.intr.trunc(%0)  : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }]

def test_shrink_intrin_fabs_fast_before := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs_fast(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_no_shrink_intrin_floor_before := [llvmfunc|
  llvm.func @test_no_shrink_intrin_floor(%arg0: f64) -> f32 {
    %0 = llvm.intr.floor(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

def test_no_shrink_intrin_ceil_before := [llvmfunc|
  llvm.func @test_no_shrink_intrin_ceil(%arg0: f64) -> f32 {
    %0 = llvm.intr.ceil(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

def test_no_shrink_intrin_round_before := [llvmfunc|
  llvm.func @test_no_shrink_intrin_round(%arg0: f64) -> f32 {
    %0 = llvm.intr.round(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

def test_no_shrink_intrin_roundeven_before := [llvmfunc|
  llvm.func @test_no_shrink_intrin_roundeven(%arg0: f64) -> f32 {
    %0 = llvm.intr.roundeven(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

def test_no_shrink_intrin_nearbyint_before := [llvmfunc|
  llvm.func @test_no_shrink_intrin_nearbyint(%arg0: f64) -> f32 {
    %0 = llvm.intr.nearbyint(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

def test_no_shrink_intrin_trunc_before := [llvmfunc|
  llvm.func @test_no_shrink_intrin_trunc(%arg0: f64) -> f32 {
    %0 = llvm.intr.trunc(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

def test_shrink_intrin_fabs_double_src_before := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs_double_src(%arg0: f64) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

def test_shrink_intrin_fabs_fast_double_src_before := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs_fast_double_src(%arg0: f64) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

def test_shrink_float_convertible_constant_intrin_floor_before := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_floor() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.intr.floor(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_float_convertible_constant_intrin_ceil_before := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_ceil() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.intr.ceil(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_float_convertible_constant_intrin_round_before := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_round() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.intr.round(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_float_convertible_constant_intrin_roundeven_before := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_roundeven() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.intr.roundeven(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_float_convertible_constant_intrin_nearbyint_before := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_nearbyint() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.intr.nearbyint(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_float_convertible_constant_intrin_trunc_before := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_trunc() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.intr.trunc(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_float_convertible_constant_intrin_fabs_before := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_fabs() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_float_convertible_constant_intrin_fabs_fast_before := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_fabs_fast() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_no_shrink_mismatched_type_intrin_floor_before := [llvmfunc|
  llvm.func @test_no_shrink_mismatched_type_intrin_floor(%arg0: f64) -> f16 {
    %0 = llvm.intr.floor(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

def test_no_shrink_mismatched_type_intrin_ceil_before := [llvmfunc|
  llvm.func @test_no_shrink_mismatched_type_intrin_ceil(%arg0: f64) -> f16 {
    %0 = llvm.intr.ceil(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

def test_no_shrink_mismatched_type_intrin_round_before := [llvmfunc|
  llvm.func @test_no_shrink_mismatched_type_intrin_round(%arg0: f64) -> f16 {
    %0 = llvm.intr.round(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

def test_no_shrink_mismatched_type_intrin_roundeven_before := [llvmfunc|
  llvm.func @test_no_shrink_mismatched_type_intrin_roundeven(%arg0: f64) -> f16 {
    %0 = llvm.intr.roundeven(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

def test_no_shrink_mismatched_type_intrin_nearbyint_before := [llvmfunc|
  llvm.func @test_no_shrink_mismatched_type_intrin_nearbyint(%arg0: f64) -> f16 {
    %0 = llvm.intr.nearbyint(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

def test_no_shrink_mismatched_type_intrin_trunc_before := [llvmfunc|
  llvm.func @test_no_shrink_mismatched_type_intrin_trunc(%arg0: f64) -> f16 {
    %0 = llvm.intr.trunc(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

def test_shrink_mismatched_type_intrin_fabs_double_src_before := [llvmfunc|
  llvm.func @test_shrink_mismatched_type_intrin_fabs_double_src(%arg0: f64) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

def test_mismatched_type_intrin_fabs_fast_double_src_before := [llvmfunc|
  llvm.func @test_mismatched_type_intrin_fabs_fast_double_src(%arg0: f64) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

def test_shrink_intrin_floor_fp16_vec_before := [llvmfunc|
  llvm.func @test_shrink_intrin_floor_fp16_vec(%arg0: vector<2xf16>) -> vector<2xf64> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %1 = llvm.intr.floor(%0)  {fastmathFlags = #llvm.fastmath<arcp>} : (vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def test_shrink_intrin_ceil_fp16_src_before := [llvmfunc|
  llvm.func @test_shrink_intrin_ceil_fp16_src(%arg0: f16) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.intr.ceil(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_intrin_round_fp16_vec_before := [llvmfunc|
  llvm.func @test_shrink_intrin_round_fp16_vec(%arg0: vector<2xf16>) -> vector<2xf64> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %1 = llvm.intr.round(%0)  : (vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def test_shrink_intrin_roundeven_fp16_vec_before := [llvmfunc|
  llvm.func @test_shrink_intrin_roundeven_fp16_vec(%arg0: vector<2xf16>) -> vector<2xf64> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %1 = llvm.intr.roundeven(%0)  : (vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def test_shrink_intrin_nearbyint_fp16_src_before := [llvmfunc|
  llvm.func @test_shrink_intrin_nearbyint_fp16_src(%arg0: f16) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.intr.nearbyint(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_intrin_trunc_fp16_src_before := [llvmfunc|
  llvm.func @test_shrink_intrin_trunc_fp16_src(%arg0: vector<2xf16>) -> vector<2xf64> {
    %0 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %1 = llvm.intr.trunc(%0)  : (vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def test_shrink_intrin_fabs_fp16_src_before := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs_fp16_src(%arg0: f16) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.intr.fabs(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_shrink_intrin_fabs_fast_fp16_src_before := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs_fast_fp16_src(%arg0: f16) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test_no_shrink_intrin_floor_multi_use_fpext_before := [llvmfunc|
  llvm.func @test_no_shrink_intrin_floor_multi_use_fpext(%arg0: f16) -> f32 {
    %0 = llvm.mlir.undef : !llvm.ptr
    %1 = llvm.fpext %arg0 : f16 to f64
    llvm.store volatile %1, %0 {alignment = 8 : i64} : f64, !llvm.ptr]

    %2 = llvm.intr.floor(%1)  : (f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test_no_shrink_intrin_fabs_multi_use_fpext_before := [llvmfunc|
  llvm.func @test_no_shrink_intrin_fabs_multi_use_fpext(%arg0: f16) -> f32 {
    %0 = llvm.mlir.undef : !llvm.ptr
    %1 = llvm.fpext %arg0 : f16 to f64
    llvm.store volatile %1, %0 {alignment = 8 : i64} : f64, !llvm.ptr]

    %2 = llvm.intr.fabs(%1)  : (f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test_shrink_libcall_floor_combined := [llvmfunc|
  llvm.func @test_shrink_libcall_floor(%arg0: f32) -> f32 {
    %0 = llvm.intr.floor(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_libcall_floor   : test_shrink_libcall_floor_before  ⊑  test_shrink_libcall_floor_combined := by
  unfold test_shrink_libcall_floor_before test_shrink_libcall_floor_combined
  simp_alive_peephole
  sorry
def test_shrink_libcall_ceil_combined := [llvmfunc|
  llvm.func @test_shrink_libcall_ceil(%arg0: f32) -> f32 {
    %0 = llvm.intr.ceil(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_libcall_ceil   : test_shrink_libcall_ceil_before  ⊑  test_shrink_libcall_ceil_combined := by
  unfold test_shrink_libcall_ceil_before test_shrink_libcall_ceil_combined
  simp_alive_peephole
  sorry
def test_shrink_libcall_round_combined := [llvmfunc|
  llvm.func @test_shrink_libcall_round(%arg0: f32) -> f32 {
    %0 = llvm.intr.round(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_libcall_round   : test_shrink_libcall_round_before  ⊑  test_shrink_libcall_round_combined := by
  unfold test_shrink_libcall_round_before test_shrink_libcall_round_combined
  simp_alive_peephole
  sorry
def test_shrink_libcall_roundeven_combined := [llvmfunc|
  llvm.func @test_shrink_libcall_roundeven(%arg0: f32) -> f32 {
    %0 = llvm.intr.roundeven(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_libcall_roundeven   : test_shrink_libcall_roundeven_before  ⊑  test_shrink_libcall_roundeven_combined := by
  unfold test_shrink_libcall_roundeven_before test_shrink_libcall_roundeven_combined
  simp_alive_peephole
  sorry
def test_shrink_libcall_nearbyint_combined := [llvmfunc|
  llvm.func @test_shrink_libcall_nearbyint(%arg0: f32) -> f32 {
    %0 = llvm.intr.nearbyint(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_libcall_nearbyint   : test_shrink_libcall_nearbyint_before  ⊑  test_shrink_libcall_nearbyint_combined := by
  unfold test_shrink_libcall_nearbyint_before test_shrink_libcall_nearbyint_combined
  simp_alive_peephole
  sorry
def test_shrink_libcall_trunc_combined := [llvmfunc|
  llvm.func @test_shrink_libcall_trunc(%arg0: f32) -> f32 {
    %0 = llvm.intr.trunc(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_libcall_trunc   : test_shrink_libcall_trunc_before  ⊑  test_shrink_libcall_trunc_combined := by
  unfold test_shrink_libcall_trunc_before test_shrink_libcall_trunc_combined
  simp_alive_peephole
  sorry
def test_shrink_libcall_fabs_combined := [llvmfunc|
  llvm.func @test_shrink_libcall_fabs(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_libcall_fabs   : test_shrink_libcall_fabs_before  ⊑  test_shrink_libcall_fabs_combined := by
  unfold test_shrink_libcall_fabs_before test_shrink_libcall_fabs_combined
  simp_alive_peephole
  sorry
def test_shrink_libcall_fabs_fast_combined := [llvmfunc|
  llvm.func @test_shrink_libcall_fabs_fast(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_test_shrink_libcall_fabs_fast   : test_shrink_libcall_fabs_fast_before  ⊑  test_shrink_libcall_fabs_fast_combined := by
  unfold test_shrink_libcall_fabs_fast_before test_shrink_libcall_fabs_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_libcall_fabs_fast   : test_shrink_libcall_fabs_fast_before  ⊑  test_shrink_libcall_fabs_fast_combined := by
  unfold test_shrink_libcall_fabs_fast_before test_shrink_libcall_fabs_fast_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_ceil_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_ceil(%arg0: f32) -> f32 {
    %0 = llvm.intr.ceil(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_intrin_ceil   : test_shrink_intrin_ceil_before  ⊑  test_shrink_intrin_ceil_combined := by
  unfold test_shrink_intrin_ceil_before test_shrink_intrin_ceil_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_fabs_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_intrin_fabs   : test_shrink_intrin_fabs_before  ⊑  test_shrink_intrin_fabs_combined := by
  unfold test_shrink_intrin_fabs_before test_shrink_intrin_fabs_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_floor_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_floor(%arg0: f32) -> f32 {
    %0 = llvm.intr.floor(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_intrin_floor   : test_shrink_intrin_floor_before  ⊑  test_shrink_intrin_floor_combined := by
  unfold test_shrink_intrin_floor_before test_shrink_intrin_floor_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_nearbyint_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_nearbyint(%arg0: f32) -> f32 {
    %0 = llvm.intr.nearbyint(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_intrin_nearbyint   : test_shrink_intrin_nearbyint_before  ⊑  test_shrink_intrin_nearbyint_combined := by
  unfold test_shrink_intrin_nearbyint_before test_shrink_intrin_nearbyint_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_rint_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_rint(%arg0: f16) -> f16 {
    %0 = llvm.intr.rint(%arg0)  : (f16) -> f16
    llvm.return %0 : f16
  }]

theorem inst_combine_test_shrink_intrin_rint   : test_shrink_intrin_rint_before  ⊑  test_shrink_intrin_rint_combined := by
  unfold test_shrink_intrin_rint_before test_shrink_intrin_rint_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_round_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_round(%arg0: f32) -> f32 {
    %0 = llvm.intr.round(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_intrin_round   : test_shrink_intrin_round_before  ⊑  test_shrink_intrin_round_combined := by
  unfold test_shrink_intrin_round_before test_shrink_intrin_round_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_roundeven_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_roundeven(%arg0: f32) -> f32 {
    %0 = llvm.intr.roundeven(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_intrin_roundeven   : test_shrink_intrin_roundeven_before  ⊑  test_shrink_intrin_roundeven_combined := by
  unfold test_shrink_intrin_roundeven_before test_shrink_intrin_roundeven_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_trunc_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_trunc(%arg0: f32) -> f32 {
    %0 = llvm.intr.trunc(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_intrin_trunc   : test_shrink_intrin_trunc_before  ⊑  test_shrink_intrin_trunc_combined := by
  unfold test_shrink_intrin_trunc_before test_shrink_intrin_trunc_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_ceil_multi_use_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_ceil_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.intr.ceil(%0)  : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_test_shrink_intrin_ceil_multi_use   : test_shrink_intrin_ceil_multi_use_before  ⊑  test_shrink_intrin_ceil_multi_use_combined := by
  unfold test_shrink_intrin_ceil_multi_use_before test_shrink_intrin_ceil_multi_use_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_fabs_multi_use_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.fpext %0 : vector<2xf32> to vector<2xf64>
    llvm.call @use_v2f64(%1) : (vector<2xf64>) -> ()
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_test_shrink_intrin_fabs_multi_use   : test_shrink_intrin_fabs_multi_use_before  ⊑  test_shrink_intrin_fabs_multi_use_combined := by
  unfold test_shrink_intrin_fabs_multi_use_before test_shrink_intrin_fabs_multi_use_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_floor_multi_use_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_floor_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.intr.floor(%0)  : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.call @use_v2f64(%1) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_test_shrink_intrin_floor_multi_use   : test_shrink_intrin_floor_multi_use_before  ⊑  test_shrink_intrin_floor_multi_use_combined := by
  unfold test_shrink_intrin_floor_multi_use_before test_shrink_intrin_floor_multi_use_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_nearbyint_multi_use_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_nearbyint_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.intr.nearbyint(%0)  : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_test_shrink_intrin_nearbyint_multi_use   : test_shrink_intrin_nearbyint_multi_use_before  ⊑  test_shrink_intrin_nearbyint_multi_use_combined := by
  unfold test_shrink_intrin_nearbyint_multi_use_before test_shrink_intrin_nearbyint_multi_use_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_rint_multi_use_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_rint_multi_use(%arg0: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.intr.rint(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    %1 = llvm.fpext %0 : vector<2xf16> to vector<2xf32>
    llvm.call @use_v2f32(%1) : (vector<2xf32>) -> ()
    llvm.return %0 : vector<2xf16>
  }]

theorem inst_combine_test_shrink_intrin_rint_multi_use   : test_shrink_intrin_rint_multi_use_before  ⊑  test_shrink_intrin_rint_multi_use_combined := by
  unfold test_shrink_intrin_rint_multi_use_before test_shrink_intrin_rint_multi_use_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_round_multi_use_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_round_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.intr.round(%0)  : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.call @use_v2f64(%1) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_test_shrink_intrin_round_multi_use   : test_shrink_intrin_round_multi_use_before  ⊑  test_shrink_intrin_round_multi_use_combined := by
  unfold test_shrink_intrin_round_multi_use_before test_shrink_intrin_round_multi_use_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_roundeven_multi_use_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_roundeven_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.intr.roundeven(%0)  : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.call @use_v2f64(%1) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_test_shrink_intrin_roundeven_multi_use   : test_shrink_intrin_roundeven_multi_use_before  ⊑  test_shrink_intrin_roundeven_multi_use_combined := by
  unfold test_shrink_intrin_roundeven_multi_use_before test_shrink_intrin_roundeven_multi_use_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_trunc_multi_use_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_trunc_multi_use(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.intr.trunc(%0)  : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.call @use_v2f64(%0) : (vector<2xf64>) -> ()
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_test_shrink_intrin_trunc_multi_use   : test_shrink_intrin_trunc_multi_use_before  ⊑  test_shrink_intrin_trunc_multi_use_combined := by
  unfold test_shrink_intrin_trunc_multi_use_before test_shrink_intrin_trunc_multi_use_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_fabs_fast_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs_fast(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_test_shrink_intrin_fabs_fast   : test_shrink_intrin_fabs_fast_before  ⊑  test_shrink_intrin_fabs_fast_combined := by
  unfold test_shrink_intrin_fabs_fast_before test_shrink_intrin_fabs_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_intrin_fabs_fast   : test_shrink_intrin_fabs_fast_before  ⊑  test_shrink_intrin_fabs_fast_combined := by
  unfold test_shrink_intrin_fabs_fast_before test_shrink_intrin_fabs_fast_combined
  simp_alive_peephole
  sorry
def test_no_shrink_intrin_floor_combined := [llvmfunc|
  llvm.func @test_no_shrink_intrin_floor(%arg0: f64) -> f32 {
    %0 = llvm.intr.floor(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_no_shrink_intrin_floor   : test_no_shrink_intrin_floor_before  ⊑  test_no_shrink_intrin_floor_combined := by
  unfold test_no_shrink_intrin_floor_before test_no_shrink_intrin_floor_combined
  simp_alive_peephole
  sorry
def test_no_shrink_intrin_ceil_combined := [llvmfunc|
  llvm.func @test_no_shrink_intrin_ceil(%arg0: f64) -> f32 {
    %0 = llvm.intr.ceil(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_no_shrink_intrin_ceil   : test_no_shrink_intrin_ceil_before  ⊑  test_no_shrink_intrin_ceil_combined := by
  unfold test_no_shrink_intrin_ceil_before test_no_shrink_intrin_ceil_combined
  simp_alive_peephole
  sorry
def test_no_shrink_intrin_round_combined := [llvmfunc|
  llvm.func @test_no_shrink_intrin_round(%arg0: f64) -> f32 {
    %0 = llvm.intr.round(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_no_shrink_intrin_round   : test_no_shrink_intrin_round_before  ⊑  test_no_shrink_intrin_round_combined := by
  unfold test_no_shrink_intrin_round_before test_no_shrink_intrin_round_combined
  simp_alive_peephole
  sorry
def test_no_shrink_intrin_roundeven_combined := [llvmfunc|
  llvm.func @test_no_shrink_intrin_roundeven(%arg0: f64) -> f32 {
    %0 = llvm.intr.roundeven(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_no_shrink_intrin_roundeven   : test_no_shrink_intrin_roundeven_before  ⊑  test_no_shrink_intrin_roundeven_combined := by
  unfold test_no_shrink_intrin_roundeven_before test_no_shrink_intrin_roundeven_combined
  simp_alive_peephole
  sorry
def test_no_shrink_intrin_nearbyint_combined := [llvmfunc|
  llvm.func @test_no_shrink_intrin_nearbyint(%arg0: f64) -> f32 {
    %0 = llvm.intr.nearbyint(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_no_shrink_intrin_nearbyint   : test_no_shrink_intrin_nearbyint_before  ⊑  test_no_shrink_intrin_nearbyint_combined := by
  unfold test_no_shrink_intrin_nearbyint_before test_no_shrink_intrin_nearbyint_combined
  simp_alive_peephole
  sorry
def test_no_shrink_intrin_trunc_combined := [llvmfunc|
  llvm.func @test_no_shrink_intrin_trunc(%arg0: f64) -> f32 {
    %0 = llvm.intr.trunc(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_no_shrink_intrin_trunc   : test_no_shrink_intrin_trunc_before  ⊑  test_no_shrink_intrin_trunc_combined := by
  unfold test_no_shrink_intrin_trunc_before test_no_shrink_intrin_trunc_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_fabs_double_src_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs_double_src(%arg0: f64) -> f32 {
    %0 = llvm.fptrunc %arg0 : f64 to f32
    %1 = llvm.intr.fabs(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_shrink_intrin_fabs_double_src   : test_shrink_intrin_fabs_double_src_before  ⊑  test_shrink_intrin_fabs_double_src_combined := by
  unfold test_shrink_intrin_fabs_double_src_before test_shrink_intrin_fabs_double_src_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_fabs_fast_double_src_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs_fast_double_src(%arg0: f64) -> f32 {
    %0 = llvm.fptrunc %arg0 : f64 to f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_test_shrink_intrin_fabs_fast_double_src   : test_shrink_intrin_fabs_fast_double_src_before  ⊑  test_shrink_intrin_fabs_fast_double_src_combined := by
  unfold test_shrink_intrin_fabs_fast_double_src_before test_shrink_intrin_fabs_fast_double_src_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_test_shrink_intrin_fabs_fast_double_src   : test_shrink_intrin_fabs_fast_double_src_before  ⊑  test_shrink_intrin_fabs_fast_double_src_combined := by
  unfold test_shrink_intrin_fabs_fast_double_src_before test_shrink_intrin_fabs_fast_double_src_combined
  simp_alive_peephole
  sorry
def test_shrink_float_convertible_constant_intrin_floor_combined := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_floor() -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_float_convertible_constant_intrin_floor   : test_shrink_float_convertible_constant_intrin_floor_before  ⊑  test_shrink_float_convertible_constant_intrin_floor_combined := by
  unfold test_shrink_float_convertible_constant_intrin_floor_before test_shrink_float_convertible_constant_intrin_floor_combined
  simp_alive_peephole
  sorry
def test_shrink_float_convertible_constant_intrin_ceil_combined := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_ceil() -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_float_convertible_constant_intrin_ceil   : test_shrink_float_convertible_constant_intrin_ceil_before  ⊑  test_shrink_float_convertible_constant_intrin_ceil_combined := by
  unfold test_shrink_float_convertible_constant_intrin_ceil_before test_shrink_float_convertible_constant_intrin_ceil_combined
  simp_alive_peephole
  sorry
def test_shrink_float_convertible_constant_intrin_round_combined := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_round() -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_float_convertible_constant_intrin_round   : test_shrink_float_convertible_constant_intrin_round_before  ⊑  test_shrink_float_convertible_constant_intrin_round_combined := by
  unfold test_shrink_float_convertible_constant_intrin_round_before test_shrink_float_convertible_constant_intrin_round_combined
  simp_alive_peephole
  sorry
def test_shrink_float_convertible_constant_intrin_roundeven_combined := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_roundeven() -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_float_convertible_constant_intrin_roundeven   : test_shrink_float_convertible_constant_intrin_roundeven_before  ⊑  test_shrink_float_convertible_constant_intrin_roundeven_combined := by
  unfold test_shrink_float_convertible_constant_intrin_roundeven_before test_shrink_float_convertible_constant_intrin_roundeven_combined
  simp_alive_peephole
  sorry
def test_shrink_float_convertible_constant_intrin_nearbyint_combined := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_nearbyint() -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_float_convertible_constant_intrin_nearbyint   : test_shrink_float_convertible_constant_intrin_nearbyint_before  ⊑  test_shrink_float_convertible_constant_intrin_nearbyint_combined := by
  unfold test_shrink_float_convertible_constant_intrin_nearbyint_before test_shrink_float_convertible_constant_intrin_nearbyint_combined
  simp_alive_peephole
  sorry
def test_shrink_float_convertible_constant_intrin_trunc_combined := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_trunc() -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_float_convertible_constant_intrin_trunc   : test_shrink_float_convertible_constant_intrin_trunc_before  ⊑  test_shrink_float_convertible_constant_intrin_trunc_combined := by
  unfold test_shrink_float_convertible_constant_intrin_trunc_before test_shrink_float_convertible_constant_intrin_trunc_combined
  simp_alive_peephole
  sorry
def test_shrink_float_convertible_constant_intrin_fabs_combined := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_fabs() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_float_convertible_constant_intrin_fabs   : test_shrink_float_convertible_constant_intrin_fabs_before  ⊑  test_shrink_float_convertible_constant_intrin_fabs_combined := by
  unfold test_shrink_float_convertible_constant_intrin_fabs_before test_shrink_float_convertible_constant_intrin_fabs_combined
  simp_alive_peephole
  sorry
def test_shrink_float_convertible_constant_intrin_fabs_fast_combined := [llvmfunc|
  llvm.func @test_shrink_float_convertible_constant_intrin_fabs_fast() -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_shrink_float_convertible_constant_intrin_fabs_fast   : test_shrink_float_convertible_constant_intrin_fabs_fast_before  ⊑  test_shrink_float_convertible_constant_intrin_fabs_fast_combined := by
  unfold test_shrink_float_convertible_constant_intrin_fabs_fast_before test_shrink_float_convertible_constant_intrin_fabs_fast_combined
  simp_alive_peephole
  sorry
def test_no_shrink_mismatched_type_intrin_floor_combined := [llvmfunc|
  llvm.func @test_no_shrink_mismatched_type_intrin_floor(%arg0: f64) -> f16 {
    %0 = llvm.intr.floor(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_test_no_shrink_mismatched_type_intrin_floor   : test_no_shrink_mismatched_type_intrin_floor_before  ⊑  test_no_shrink_mismatched_type_intrin_floor_combined := by
  unfold test_no_shrink_mismatched_type_intrin_floor_before test_no_shrink_mismatched_type_intrin_floor_combined
  simp_alive_peephole
  sorry
def test_no_shrink_mismatched_type_intrin_ceil_combined := [llvmfunc|
  llvm.func @test_no_shrink_mismatched_type_intrin_ceil(%arg0: f64) -> f16 {
    %0 = llvm.intr.ceil(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_test_no_shrink_mismatched_type_intrin_ceil   : test_no_shrink_mismatched_type_intrin_ceil_before  ⊑  test_no_shrink_mismatched_type_intrin_ceil_combined := by
  unfold test_no_shrink_mismatched_type_intrin_ceil_before test_no_shrink_mismatched_type_intrin_ceil_combined
  simp_alive_peephole
  sorry
def test_no_shrink_mismatched_type_intrin_round_combined := [llvmfunc|
  llvm.func @test_no_shrink_mismatched_type_intrin_round(%arg0: f64) -> f16 {
    %0 = llvm.intr.round(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_test_no_shrink_mismatched_type_intrin_round   : test_no_shrink_mismatched_type_intrin_round_before  ⊑  test_no_shrink_mismatched_type_intrin_round_combined := by
  unfold test_no_shrink_mismatched_type_intrin_round_before test_no_shrink_mismatched_type_intrin_round_combined
  simp_alive_peephole
  sorry
def test_no_shrink_mismatched_type_intrin_roundeven_combined := [llvmfunc|
  llvm.func @test_no_shrink_mismatched_type_intrin_roundeven(%arg0: f64) -> f16 {
    %0 = llvm.intr.roundeven(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_test_no_shrink_mismatched_type_intrin_roundeven   : test_no_shrink_mismatched_type_intrin_roundeven_before  ⊑  test_no_shrink_mismatched_type_intrin_roundeven_combined := by
  unfold test_no_shrink_mismatched_type_intrin_roundeven_before test_no_shrink_mismatched_type_intrin_roundeven_combined
  simp_alive_peephole
  sorry
def test_no_shrink_mismatched_type_intrin_nearbyint_combined := [llvmfunc|
  llvm.func @test_no_shrink_mismatched_type_intrin_nearbyint(%arg0: f64) -> f16 {
    %0 = llvm.intr.nearbyint(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_test_no_shrink_mismatched_type_intrin_nearbyint   : test_no_shrink_mismatched_type_intrin_nearbyint_before  ⊑  test_no_shrink_mismatched_type_intrin_nearbyint_combined := by
  unfold test_no_shrink_mismatched_type_intrin_nearbyint_before test_no_shrink_mismatched_type_intrin_nearbyint_combined
  simp_alive_peephole
  sorry
def test_no_shrink_mismatched_type_intrin_trunc_combined := [llvmfunc|
  llvm.func @test_no_shrink_mismatched_type_intrin_trunc(%arg0: f64) -> f16 {
    %0 = llvm.intr.trunc(%arg0)  : (f64) -> f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_test_no_shrink_mismatched_type_intrin_trunc   : test_no_shrink_mismatched_type_intrin_trunc_before  ⊑  test_no_shrink_mismatched_type_intrin_trunc_combined := by
  unfold test_no_shrink_mismatched_type_intrin_trunc_before test_no_shrink_mismatched_type_intrin_trunc_combined
  simp_alive_peephole
  sorry
def test_shrink_mismatched_type_intrin_fabs_double_src_combined := [llvmfunc|
  llvm.func @test_shrink_mismatched_type_intrin_fabs_double_src(%arg0: f64) -> f16 {
    %0 = llvm.fptrunc %arg0 : f64 to f16
    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_test_shrink_mismatched_type_intrin_fabs_double_src   : test_shrink_mismatched_type_intrin_fabs_double_src_before  ⊑  test_shrink_mismatched_type_intrin_fabs_double_src_combined := by
  unfold test_shrink_mismatched_type_intrin_fabs_double_src_before test_shrink_mismatched_type_intrin_fabs_double_src_combined
  simp_alive_peephole
  sorry
def test_mismatched_type_intrin_fabs_fast_double_src_combined := [llvmfunc|
  llvm.func @test_mismatched_type_intrin_fabs_fast_double_src(%arg0: f64) -> f16 {
    %0 = llvm.fptrunc %arg0 : f64 to f16
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f16) -> f16]

theorem inst_combine_test_mismatched_type_intrin_fabs_fast_double_src   : test_mismatched_type_intrin_fabs_fast_double_src_before  ⊑  test_mismatched_type_intrin_fabs_fast_double_src_combined := by
  unfold test_mismatched_type_intrin_fabs_fast_double_src_before test_mismatched_type_intrin_fabs_fast_double_src_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f16
  }]

theorem inst_combine_test_mismatched_type_intrin_fabs_fast_double_src   : test_mismatched_type_intrin_fabs_fast_double_src_before  ⊑  test_mismatched_type_intrin_fabs_fast_double_src_combined := by
  unfold test_mismatched_type_intrin_fabs_fast_double_src_before test_mismatched_type_intrin_fabs_fast_double_src_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_floor_fp16_vec_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_floor_fp16_vec(%arg0: vector<2xf16>) -> vector<2xf64> {
    %0 = llvm.intr.floor(%arg0)  {fastmathFlags = #llvm.fastmath<arcp>} : (vector<2xf16>) -> vector<2xf16>]

theorem inst_combine_test_shrink_intrin_floor_fp16_vec   : test_shrink_intrin_floor_fp16_vec_before  ⊑  test_shrink_intrin_floor_fp16_vec_combined := by
  unfold test_shrink_intrin_floor_fp16_vec_before test_shrink_intrin_floor_fp16_vec_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fpext %0 : vector<2xf16> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_test_shrink_intrin_floor_fp16_vec   : test_shrink_intrin_floor_fp16_vec_before  ⊑  test_shrink_intrin_floor_fp16_vec_combined := by
  unfold test_shrink_intrin_floor_fp16_vec_before test_shrink_intrin_floor_fp16_vec_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_ceil_fp16_src_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_ceil_fp16_src(%arg0: f16) -> f32 {
    %0 = llvm.intr.ceil(%arg0)  : (f16) -> f16
    %1 = llvm.fpext %0 : f16 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_shrink_intrin_ceil_fp16_src   : test_shrink_intrin_ceil_fp16_src_before  ⊑  test_shrink_intrin_ceil_fp16_src_combined := by
  unfold test_shrink_intrin_ceil_fp16_src_before test_shrink_intrin_ceil_fp16_src_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_round_fp16_vec_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_round_fp16_vec(%arg0: vector<2xf16>) -> vector<2xf64> {
    %0 = llvm.intr.round(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    %1 = llvm.fpext %0 : vector<2xf16> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_test_shrink_intrin_round_fp16_vec   : test_shrink_intrin_round_fp16_vec_before  ⊑  test_shrink_intrin_round_fp16_vec_combined := by
  unfold test_shrink_intrin_round_fp16_vec_before test_shrink_intrin_round_fp16_vec_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_roundeven_fp16_vec_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_roundeven_fp16_vec(%arg0: vector<2xf16>) -> vector<2xf64> {
    %0 = llvm.intr.roundeven(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    %1 = llvm.fpext %0 : vector<2xf16> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_test_shrink_intrin_roundeven_fp16_vec   : test_shrink_intrin_roundeven_fp16_vec_before  ⊑  test_shrink_intrin_roundeven_fp16_vec_combined := by
  unfold test_shrink_intrin_roundeven_fp16_vec_before test_shrink_intrin_roundeven_fp16_vec_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_nearbyint_fp16_src_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_nearbyint_fp16_src(%arg0: f16) -> f32 {
    %0 = llvm.intr.nearbyint(%arg0)  : (f16) -> f16
    %1 = llvm.fpext %0 : f16 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_shrink_intrin_nearbyint_fp16_src   : test_shrink_intrin_nearbyint_fp16_src_before  ⊑  test_shrink_intrin_nearbyint_fp16_src_combined := by
  unfold test_shrink_intrin_nearbyint_fp16_src_before test_shrink_intrin_nearbyint_fp16_src_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_trunc_fp16_src_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_trunc_fp16_src(%arg0: vector<2xf16>) -> vector<2xf64> {
    %0 = llvm.intr.trunc(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    %1 = llvm.fpext %0 : vector<2xf16> to vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_test_shrink_intrin_trunc_fp16_src   : test_shrink_intrin_trunc_fp16_src_before  ⊑  test_shrink_intrin_trunc_fp16_src_combined := by
  unfold test_shrink_intrin_trunc_fp16_src_before test_shrink_intrin_trunc_fp16_src_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_fabs_fp16_src_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs_fp16_src(%arg0: f16) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %1 = llvm.fpext %0 : f16 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_shrink_intrin_fabs_fp16_src   : test_shrink_intrin_fabs_fp16_src_before  ⊑  test_shrink_intrin_fabs_fp16_src_combined := by
  unfold test_shrink_intrin_fabs_fp16_src_before test_shrink_intrin_fabs_fp16_src_combined
  simp_alive_peephole
  sorry
def test_shrink_intrin_fabs_fast_fp16_src_combined := [llvmfunc|
  llvm.func @test_shrink_intrin_fabs_fast_fp16_src(%arg0: f16) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f16) -> f16]

theorem inst_combine_test_shrink_intrin_fabs_fast_fp16_src   : test_shrink_intrin_fabs_fast_fp16_src_before  ⊑  test_shrink_intrin_fabs_fast_fp16_src_combined := by
  unfold test_shrink_intrin_fabs_fast_fp16_src_before test_shrink_intrin_fabs_fast_fp16_src_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fpext %0 : f16 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_shrink_intrin_fabs_fast_fp16_src   : test_shrink_intrin_fabs_fast_fp16_src_before  ⊑  test_shrink_intrin_fabs_fast_fp16_src_combined := by
  unfold test_shrink_intrin_fabs_fast_fp16_src_before test_shrink_intrin_fabs_fast_fp16_src_combined
  simp_alive_peephole
  sorry
def test_no_shrink_intrin_floor_multi_use_fpext_combined := [llvmfunc|
  llvm.func @test_no_shrink_intrin_floor_multi_use_fpext(%arg0: f16) -> f32 {
    %0 = llvm.mlir.undef : !llvm.ptr
    %1 = llvm.fpext %arg0 : f16 to f64
    llvm.store volatile %1, %0 {alignment = 4 : i64} : f64, !llvm.ptr]

theorem inst_combine_test_no_shrink_intrin_floor_multi_use_fpext   : test_no_shrink_intrin_floor_multi_use_fpext_before  ⊑  test_no_shrink_intrin_floor_multi_use_fpext_combined := by
  unfold test_no_shrink_intrin_floor_multi_use_fpext_before test_no_shrink_intrin_floor_multi_use_fpext_combined
  simp_alive_peephole
  sorry
    %2 = llvm.intr.floor(%1)  : (f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_test_no_shrink_intrin_floor_multi_use_fpext   : test_no_shrink_intrin_floor_multi_use_fpext_before  ⊑  test_no_shrink_intrin_floor_multi_use_fpext_combined := by
  unfold test_no_shrink_intrin_floor_multi_use_fpext_before test_no_shrink_intrin_floor_multi_use_fpext_combined
  simp_alive_peephole
  sorry
def test_no_shrink_intrin_fabs_multi_use_fpext_combined := [llvmfunc|
  llvm.func @test_no_shrink_intrin_fabs_multi_use_fpext(%arg0: f16) -> f32 {
    %0 = llvm.mlir.undef : !llvm.ptr
    %1 = llvm.fpext %arg0 : f16 to f64
    llvm.store volatile %1, %0 {alignment = 4 : i64} : f64, !llvm.ptr]

theorem inst_combine_test_no_shrink_intrin_fabs_multi_use_fpext   : test_no_shrink_intrin_fabs_multi_use_fpext_before  ⊑  test_no_shrink_intrin_fabs_multi_use_fpext_combined := by
  unfold test_no_shrink_intrin_fabs_multi_use_fpext_before test_no_shrink_intrin_fabs_multi_use_fpext_combined
  simp_alive_peephole
  sorry
    %2 = llvm.intr.fabs(%1)  : (f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_test_no_shrink_intrin_fabs_multi_use_fpext   : test_no_shrink_intrin_fabs_multi_use_fpext_before  ⊑  test_no_shrink_intrin_fabs_multi_use_fpext_combined := by
  unfold test_no_shrink_intrin_fabs_multi_use_fpext_before test_no_shrink_intrin_fabs_multi_use_fpext_combined
  simp_alive_peephole
  sorry
