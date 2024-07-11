import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pow-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_simplify1_noerrno_before := [llvmfunc|
  llvm.func @test_simplify1_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_simplify1v_before := [llvmfunc|
  llvm.func @test_simplify1v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify2_noerrno_before := [llvmfunc|
  llvm.func @test_simplify2_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify2v_before := [llvmfunc|
  llvm.func @test_simplify2v(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_simplify3_noerrno_before := [llvmfunc|
  llvm.func @test_simplify3_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_simplify3n_noerrno_before := [llvmfunc|
  llvm.func @test_simplify3n_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.500000e-01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify3v_before := [llvmfunc|
  llvm.func @test_simplify3v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<2.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def test_simplify3vn_before := [llvmfunc|
  llvm.func @test_simplify3vn(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<4.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def test_simplify4_before := [llvmfunc|
  llvm.func @test_simplify4(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify4_noerrno_before := [llvmfunc|
  llvm.func @test_simplify4_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify4n_before := [llvmfunc|
  llvm.func @test_simplify4n(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(8.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_simplify4n_noerrno_before := [llvmfunc|
  llvm.func @test_simplify4n_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(8.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_simplify4v_before := [llvmfunc|
  llvm.func @test_simplify4v(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<2.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def test_simplify4vn_before := [llvmfunc|
  llvm.func @test_simplify4vn(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<5.000000e-01> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def test_simplify5_before := [llvmfunc|
  llvm.func @test_simplify5(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_simplify5_noerrno_before := [llvmfunc|
  llvm.func @test_simplify5_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_simplify5v_before := [llvmfunc|
  llvm.func @test_simplify5v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.pow(%arg0, %1)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def test_simplify6_before := [llvmfunc|
  llvm.func @test_simplify6(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify6_noerrno_before := [llvmfunc|
  llvm.func @test_simplify6_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify6v_before := [llvmfunc|
  llvm.func @test_simplify6v(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.pow(%arg0, %1)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }]

def powf_libcall_half_ninf_before := [llvmfunc|
  llvm.func @powf_libcall_half_ninf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_libcall_half_ninf_noerrno_before := [llvmfunc|
  llvm.func @powf_libcall_half_ninf_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_libcall_half_assume_ninf_noerrno_before := [llvmfunc|
  llvm.func @powf_libcall_half_assume_ninf_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %2 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %3 = llvm.fcmp "one" %2, %0 : f32
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.call @powf(%arg0, %1) : (f32, f32) -> f32
    llvm.return %4 : f32
  }]

def powf_libcall_half_ninf_tail_before := [llvmfunc|
  llvm.func @powf_libcall_half_ninf_tail(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_libcall_half_ninf_tail_noerrno_before := [llvmfunc|
  llvm.func @powf_libcall_half_ninf_tail_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_libcall_half_ninf_musttail_before := [llvmfunc|
  llvm.func @powf_libcall_half_ninf_musttail(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_libcall_half_ninf_musttail_noerrno_before := [llvmfunc|
  llvm.func @powf_libcall_half_ninf_musttail_noerrno(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_libcall_half_no_FMF_before := [llvmfunc|
  llvm.func @pow_libcall_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def pow_libcall_half_no_FMF_noerrno_before := [llvmfunc|
  llvm.func @pow_libcall_half_no_FMF_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify9_before := [llvmfunc|
  llvm.func @test_simplify9(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %2 = llvm.intr.pow(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

def test_simplify10_before := [llvmfunc|
  llvm.func @test_simplify10(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %2 = llvm.intr.pow(%0, %1)  : (f64, f64) -> f64
    llvm.return %2 : f64
  }]

def test_simplify11_before := [llvmfunc|
  llvm.func @test_simplify11(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_simplify11_noerrno_before := [llvmfunc|
  llvm.func @test_simplify11_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_simplify11v_before := [llvmfunc|
  llvm.func @test_simplify11v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def test_simplify12_before := [llvmfunc|
  llvm.func @test_simplify12(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify12_noerrno_before := [llvmfunc|
  llvm.func @test_simplify12_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify12v_before := [llvmfunc|
  llvm.func @test_simplify12v(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def pow2_strict_before := [llvmfunc|
  llvm.func @pow2_strict(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def pow2_strict_noerrno_before := [llvmfunc|
  llvm.func @pow2_strict_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def pow2_strictv_before := [llvmfunc|
  llvm.func @pow2_strictv(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<2.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def pow2_double_strict_before := [llvmfunc|
  llvm.func @pow2_double_strict(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def pow2_double_strict_noerrno_before := [llvmfunc|
  llvm.func @pow2_double_strict_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def pow2_double_strictv_before := [llvmfunc|
  llvm.func @pow2_double_strictv(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<2.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def pow2_fast_before := [llvmfunc|
  llvm.func @pow2_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow2_fast_noerrno_before := [llvmfunc|
  llvm.func @pow2_fast_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_neg1_strict_before := [llvmfunc|
  llvm.func @pow_neg1_strict(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def pow_neg1_strict_noerrno_before := [llvmfunc|
  llvm.func @pow_neg1_strict_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def pow_neg1_strictv_before := [llvmfunc|
  llvm.func @pow_neg1_strictv(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def pow_neg1_double_fast_before := [llvmfunc|
  llvm.func @pow_neg1_double_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_neg1_double_fast_noerrno_before := [llvmfunc|
  llvm.func @pow_neg1_double_fast_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_neg1_double_fastv_before := [llvmfunc|
  llvm.func @pow_neg1_double_fastv(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def pow_intrinsic_half_no_FMF_before := [llvmfunc|
  llvm.func @pow_intrinsic_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify18_before := [llvmfunc|
  llvm.func @test_simplify18(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_simplify18_noerrno_before := [llvmfunc|
  llvm.func @test_simplify18_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_simplify19_before := [llvmfunc|
  llvm.func @test_simplify19(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify19_noerrno_before := [llvmfunc|
  llvm.func @test_simplify19_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_libcall_powf_10_f32_noerrno_before := [llvmfunc|
  llvm.func @test_libcall_powf_10_f32_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_libcall_pow_10_f64_noerrno_before := [llvmfunc|
  llvm.func @test_libcall_pow_10_f64_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_pow_10_f16_before := [llvmfunc|
  llvm.func @test_pow_10_f16(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(1.000000e+01 : f16) : f16
    %1 = llvm.intr.pow(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

def test_pow_10_f32_before := [llvmfunc|
  llvm.func @test_pow_10_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.intr.pow(%0, %arg0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def test_pow_10_f64_before := [llvmfunc|
  llvm.func @test_pow_10_f64(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.intr.pow(%0, %arg0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def test_pow_10_fp128_before := [llvmfunc|
  llvm.func @test_pow_10_fp128(%arg0: f128) -> f128 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.fpext %0 : f64 to f128
    %2 = llvm.intr.pow(%1, %arg0)  : (f128, f128) -> f128
    llvm.return %2 : f128
  }]

def test_pow_10_bf16_before := [llvmfunc|
  llvm.func @test_pow_10_bf16(%arg0: bf16) -> bf16 {
    %0 = llvm.mlir.constant(1.000000e+01 : bf16) : bf16
    %1 = llvm.intr.pow(%0, %arg0)  : (bf16, bf16) -> bf16
    llvm.return %1 : bf16
  }]

def test_pow_10_v2f16_before := [llvmfunc|
  llvm.func @test_pow_10_v2f16(%arg0: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.mlir.constant(dense<1.000000e+01> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }]

def test_pow_10_v2f32_before := [llvmfunc|
  llvm.func @test_pow_10_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+01> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def test_pow_10_v2f64_before := [llvmfunc|
  llvm.func @test_pow_10_v2f64(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def test_pow_10_v2bf16_before := [llvmfunc|
  llvm.func @test_pow_10_v2bf16(%arg0: vector<2xbf16>) -> vector<2xbf16> {
    %0 = llvm.mlir.constant(dense<1.000000e+01> : vector<2xbf16>) : vector<2xbf16>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xbf16>, vector<2xbf16>) -> vector<2xbf16>
    llvm.return %1 : vector<2xbf16>
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify1_noerrno_combined := [llvmfunc|
  llvm.func @test_simplify1_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_simplify1_noerrno   : test_simplify1_noerrno_before  ⊑  test_simplify1_noerrno_combined := by
  unfold test_simplify1_noerrno_before test_simplify1_noerrno_combined
  simp_alive_peephole
  sorry
def test_simplify1v_combined := [llvmfunc|
  llvm.func @test_simplify1v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_test_simplify1v   : test_simplify1v_before  ⊑  test_simplify1v_combined := by
  unfold test_simplify1v_before test_simplify1v_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify2_noerrno_combined := [llvmfunc|
  llvm.func @test_simplify2_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_test_simplify2_noerrno   : test_simplify2_noerrno_before  ⊑  test_simplify2_noerrno_combined := by
  unfold test_simplify2_noerrno_before test_simplify2_noerrno_combined
  simp_alive_peephole
  sorry
def test_simplify2v_combined := [llvmfunc|
  llvm.func @test_simplify2v(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_test_simplify2v   : test_simplify2v_before  ⊑  test_simplify2v_combined := by
  unfold test_simplify2v_before test_simplify2v_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3(%arg0: f32) -> f32 {
    %0 = llvm.call @exp2f(%arg0) : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_simplify3_noerrno_combined := [llvmfunc|
  llvm.func @test_simplify3_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.intr.exp2(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_simplify3_noerrno   : test_simplify3_noerrno_before  ⊑  test_simplify3_noerrno_combined := by
  unfold test_simplify3_noerrno_before test_simplify3_noerrno_combined
  simp_alive_peephole
  sorry
def test_simplify3n_noerrno_combined := [llvmfunc|
  llvm.func @test_simplify3n_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-2.000000e+00 : f64) : f64
    %1 = llvm.fmul %arg0, %0  : f64
    %2 = llvm.intr.exp2(%1)  : (f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test_simplify3n_noerrno   : test_simplify3n_noerrno_before  ⊑  test_simplify3n_noerrno_combined := by
  unfold test_simplify3n_noerrno_before test_simplify3n_noerrno_combined
  simp_alive_peephole
  sorry
def test_simplify3v_combined := [llvmfunc|
  llvm.func @test_simplify3v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.exp2(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_test_simplify3v   : test_simplify3v_before  ⊑  test_simplify3v_combined := by
  unfold test_simplify3v_before test_simplify3v_combined
  simp_alive_peephole
  sorry
def test_simplify3vn_combined := [llvmfunc|
  llvm.func @test_simplify3vn(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<2.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fmul %arg0, %0  : vector<2xf64>
    %2 = llvm.intr.exp2(%1)  : (vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }]

theorem inst_combine_test_simplify3vn   : test_simplify3vn_before  ⊑  test_simplify3vn_combined := by
  unfold test_simplify3vn_before test_simplify3vn_combined
  simp_alive_peephole
  sorry
def test_simplify4_combined := [llvmfunc|
  llvm.func @test_simplify4(%arg0: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
def test_simplify4_noerrno_combined := [llvmfunc|
  llvm.func @test_simplify4_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_test_simplify4_noerrno   : test_simplify4_noerrno_before  ⊑  test_simplify4_noerrno_combined := by
  unfold test_simplify4_noerrno_before test_simplify4_noerrno_combined
  simp_alive_peephole
  sorry
def test_simplify4n_combined := [llvmfunc|
  llvm.func @test_simplify4n(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.call @exp2f(%1) : (f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test_simplify4n   : test_simplify4n_before  ⊑  test_simplify4n_combined := by
  unfold test_simplify4n_before test_simplify4n_combined
  simp_alive_peephole
  sorry
def test_simplify4n_noerrno_combined := [llvmfunc|
  llvm.func @test_simplify4n_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.intr.exp2(%1)  : (f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test_simplify4n_noerrno   : test_simplify4n_noerrno_before  ⊑  test_simplify4n_noerrno_combined := by
  unfold test_simplify4n_noerrno_before test_simplify4n_noerrno_combined
  simp_alive_peephole
  sorry
def test_simplify4v_combined := [llvmfunc|
  llvm.func @test_simplify4v(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.intr.exp2(%arg0)  : (vector<2xf64>) -> vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_test_simplify4v   : test_simplify4v_before  ⊑  test_simplify4v_combined := by
  unfold test_simplify4v_before test_simplify4v_combined
  simp_alive_peephole
  sorry
def test_simplify4vn_combined := [llvmfunc|
  llvm.func @test_simplify4vn(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.intr.exp2(%0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_test_simplify4vn   : test_simplify4vn_before  ⊑  test_simplify4vn_combined := by
  unfold test_simplify4vn_before test_simplify4vn_combined
  simp_alive_peephole
  sorry
def test_simplify5_combined := [llvmfunc|
  llvm.func @test_simplify5(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_simplify5   : test_simplify5_before  ⊑  test_simplify5_combined := by
  unfold test_simplify5_before test_simplify5_combined
  simp_alive_peephole
  sorry
def test_simplify5_noerrno_combined := [llvmfunc|
  llvm.func @test_simplify5_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_simplify5_noerrno   : test_simplify5_noerrno_before  ⊑  test_simplify5_noerrno_combined := by
  unfold test_simplify5_noerrno_before test_simplify5_noerrno_combined
  simp_alive_peephole
  sorry
def test_simplify5v_combined := [llvmfunc|
  llvm.func @test_simplify5v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_test_simplify5v   : test_simplify5v_before  ⊑  test_simplify5v_combined := by
  unfold test_simplify5v_before test_simplify5v_combined
  simp_alive_peephole
  sorry
def test_simplify6_combined := [llvmfunc|
  llvm.func @test_simplify6(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_test_simplify6   : test_simplify6_before  ⊑  test_simplify6_combined := by
  unfold test_simplify6_before test_simplify6_combined
  simp_alive_peephole
  sorry
def test_simplify6_noerrno_combined := [llvmfunc|
  llvm.func @test_simplify6_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_test_simplify6_noerrno   : test_simplify6_noerrno_before  ⊑  test_simplify6_noerrno_combined := by
  unfold test_simplify6_noerrno_before test_simplify6_noerrno_combined
  simp_alive_peephole
  sorry
def test_simplify6v_combined := [llvmfunc|
  llvm.func @test_simplify6v(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_test_simplify6v   : test_simplify6v_before  ⊑  test_simplify6v_combined := by
  unfold test_simplify6v_before test_simplify6v_combined
  simp_alive_peephole
  sorry
def powf_libcall_half_ninf_combined := [llvmfunc|
  llvm.func @powf_libcall_half_ninf(%arg0: f32) -> f32 {
    %0 = llvm.call @sqrtf(%arg0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_libcall_half_ninf   : powf_libcall_half_ninf_before  ⊑  powf_libcall_half_ninf_combined := by
  unfold powf_libcall_half_ninf_before powf_libcall_half_ninf_combined
  simp_alive_peephole
  sorry
def powf_libcall_half_ninf_noerrno_combined := [llvmfunc|
  llvm.func @powf_libcall_half_ninf_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_libcall_half_ninf_noerrno   : powf_libcall_half_ninf_noerrno_before  ⊑  powf_libcall_half_ninf_noerrno_combined := by
  unfold powf_libcall_half_ninf_noerrno_before powf_libcall_half_ninf_noerrno_combined
  simp_alive_peephole
  sorry
def powf_libcall_half_assume_ninf_noerrno_combined := [llvmfunc|
  llvm.func @powf_libcall_half_assume_ninf_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.sqrt(%arg0)  : (f32) -> f32
    %4 = llvm.intr.fabs(%3)  : (f32) -> f32
    llvm.return %4 : f32
  }]

theorem inst_combine_powf_libcall_half_assume_ninf_noerrno   : powf_libcall_half_assume_ninf_noerrno_before  ⊑  powf_libcall_half_assume_ninf_noerrno_combined := by
  unfold powf_libcall_half_assume_ninf_noerrno_before powf_libcall_half_assume_ninf_noerrno_combined
  simp_alive_peephole
  sorry
def powf_libcall_half_ninf_tail_combined := [llvmfunc|
  llvm.func @powf_libcall_half_ninf_tail(%arg0: f32) -> f32 {
    %0 = llvm.call @sqrtf(%arg0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_libcall_half_ninf_tail   : powf_libcall_half_ninf_tail_before  ⊑  powf_libcall_half_ninf_tail_combined := by
  unfold powf_libcall_half_ninf_tail_before powf_libcall_half_ninf_tail_combined
  simp_alive_peephole
  sorry
def powf_libcall_half_ninf_tail_noerrno_combined := [llvmfunc|
  llvm.func @powf_libcall_half_ninf_tail_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_libcall_half_ninf_tail_noerrno   : powf_libcall_half_ninf_tail_noerrno_before  ⊑  powf_libcall_half_ninf_tail_noerrno_combined := by
  unfold powf_libcall_half_ninf_tail_noerrno_before powf_libcall_half_ninf_tail_noerrno_combined
  simp_alive_peephole
  sorry
def powf_libcall_half_ninf_musttail_combined := [llvmfunc|
  llvm.func @powf_libcall_half_ninf_musttail(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_libcall_half_ninf_musttail   : powf_libcall_half_ninf_musttail_before  ⊑  powf_libcall_half_ninf_musttail_combined := by
  unfold powf_libcall_half_ninf_musttail_before powf_libcall_half_ninf_musttail_combined
  simp_alive_peephole
  sorry
def powf_libcall_half_ninf_musttail_noerrno_combined := [llvmfunc|
  llvm.func @powf_libcall_half_ninf_musttail_noerrno(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_libcall_half_ninf_musttail_noerrno   : powf_libcall_half_ninf_musttail_noerrno_before  ⊑  powf_libcall_half_ninf_musttail_noerrno_combined := by
  unfold powf_libcall_half_ninf_musttail_noerrno_before powf_libcall_half_ninf_musttail_noerrno_combined
  simp_alive_peephole
  sorry
def pow_libcall_half_no_FMF_combined := [llvmfunc|
  llvm.func @pow_libcall_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_libcall_half_no_FMF   : pow_libcall_half_no_FMF_before  ⊑  pow_libcall_half_no_FMF_combined := by
  unfold pow_libcall_half_no_FMF_before pow_libcall_half_no_FMF_combined
  simp_alive_peephole
  sorry
def pow_libcall_half_no_FMF_noerrno_combined := [llvmfunc|
  llvm.func @pow_libcall_half_no_FMF_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %2 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %3 = llvm.intr.fabs(%2)  : (f64) -> f64
    %4 = llvm.fcmp "oeq" %arg0, %0 : f64
    %5 = llvm.select %4, %1, %3 : i1, f64
    llvm.return %5 : f64
  }]

theorem inst_combine_pow_libcall_half_no_FMF_noerrno   : pow_libcall_half_no_FMF_noerrno_before  ⊑  pow_libcall_half_no_FMF_noerrno_combined := by
  unfold pow_libcall_half_no_FMF_noerrno_before pow_libcall_half_no_FMF_noerrno_combined
  simp_alive_peephole
  sorry
def test_simplify9_combined := [llvmfunc|
  llvm.func @test_simplify9(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test_simplify9   : test_simplify9_before  ⊑  test_simplify9_combined := by
  unfold test_simplify9_before test_simplify9_combined
  simp_alive_peephole
  sorry
def test_simplify10_combined := [llvmfunc|
  llvm.func @test_simplify10(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_test_simplify10   : test_simplify10_before  ⊑  test_simplify10_combined := by
  unfold test_simplify10_before test_simplify10_combined
  simp_alive_peephole
  sorry
def test_simplify11_combined := [llvmfunc|
  llvm.func @test_simplify11(%arg0: f32) -> f32 {
    llvm.return %arg0 : f32
  }]

theorem inst_combine_test_simplify11   : test_simplify11_before  ⊑  test_simplify11_combined := by
  unfold test_simplify11_before test_simplify11_combined
  simp_alive_peephole
  sorry
def test_simplify11_noerrno_combined := [llvmfunc|
  llvm.func @test_simplify11_noerrno(%arg0: f32) -> f32 {
    llvm.return %arg0 : f32
  }]

theorem inst_combine_test_simplify11_noerrno   : test_simplify11_noerrno_before  ⊑  test_simplify11_noerrno_combined := by
  unfold test_simplify11_noerrno_before test_simplify11_noerrno_combined
  simp_alive_peephole
  sorry
def test_simplify11v_combined := [llvmfunc|
  llvm.func @test_simplify11v(%arg0: vector<2xf32>) -> vector<2xf32> {
    llvm.return %arg0 : vector<2xf32>
  }]

theorem inst_combine_test_simplify11v   : test_simplify11v_before  ⊑  test_simplify11v_combined := by
  unfold test_simplify11v_before test_simplify11v_combined
  simp_alive_peephole
  sorry
def test_simplify12_combined := [llvmfunc|
  llvm.func @test_simplify12(%arg0: f64) -> f64 {
    llvm.return %arg0 : f64
  }]

theorem inst_combine_test_simplify12   : test_simplify12_before  ⊑  test_simplify12_combined := by
  unfold test_simplify12_before test_simplify12_combined
  simp_alive_peephole
  sorry
def test_simplify12_noerrno_combined := [llvmfunc|
  llvm.func @test_simplify12_noerrno(%arg0: f64) -> f64 {
    llvm.return %arg0 : f64
  }]

theorem inst_combine_test_simplify12_noerrno   : test_simplify12_noerrno_before  ⊑  test_simplify12_noerrno_combined := by
  unfold test_simplify12_noerrno_before test_simplify12_noerrno_combined
  simp_alive_peephole
  sorry
def test_simplify12v_combined := [llvmfunc|
  llvm.func @test_simplify12v(%arg0: vector<2xf64>) -> vector<2xf64> {
    llvm.return %arg0 : vector<2xf64>
  }]

theorem inst_combine_test_simplify12v   : test_simplify12v_before  ⊑  test_simplify12v_combined := by
  unfold test_simplify12v_before test_simplify12v_combined
  simp_alive_peephole
  sorry
def pow2_strict_combined := [llvmfunc|
  llvm.func @pow2_strict(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_pow2_strict   : pow2_strict_before  ⊑  pow2_strict_combined := by
  unfold pow2_strict_before pow2_strict_combined
  simp_alive_peephole
  sorry
def pow2_strict_noerrno_combined := [llvmfunc|
  llvm.func @pow2_strict_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_pow2_strict_noerrno   : pow2_strict_noerrno_before  ⊑  pow2_strict_noerrno_combined := by
  unfold pow2_strict_noerrno_before pow2_strict_noerrno_combined
  simp_alive_peephole
  sorry
def pow2_strictv_combined := [llvmfunc|
  llvm.func @pow2_strictv(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fmul %arg0, %arg0  : vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_pow2_strictv   : pow2_strictv_before  ⊑  pow2_strictv_combined := by
  unfold pow2_strictv_before pow2_strictv_combined
  simp_alive_peephole
  sorry
def pow2_double_strict_combined := [llvmfunc|
  llvm.func @pow2_double_strict(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_pow2_double_strict   : pow2_double_strict_before  ⊑  pow2_double_strict_combined := by
  unfold pow2_double_strict_before pow2_double_strict_combined
  simp_alive_peephole
  sorry
def pow2_double_strict_noerrno_combined := [llvmfunc|
  llvm.func @pow2_double_strict_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_pow2_double_strict_noerrno   : pow2_double_strict_noerrno_before  ⊑  pow2_double_strict_noerrno_combined := by
  unfold pow2_double_strict_noerrno_before pow2_double_strict_noerrno_combined
  simp_alive_peephole
  sorry
def pow2_double_strictv_combined := [llvmfunc|
  llvm.func @pow2_double_strictv(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fmul %arg0, %arg0  : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_pow2_double_strictv   : pow2_double_strictv_before  ⊑  pow2_double_strictv_combined := by
  unfold pow2_double_strictv_before pow2_double_strictv_combined
  simp_alive_peephole
  sorry
def pow2_fast_combined := [llvmfunc|
  llvm.func @pow2_fast(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_pow2_fast   : pow2_fast_before  ⊑  pow2_fast_combined := by
  unfold pow2_fast_before pow2_fast_combined
  simp_alive_peephole
  sorry
def pow2_fast_noerrno_combined := [llvmfunc|
  llvm.func @pow2_fast_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_pow2_fast_noerrno   : pow2_fast_noerrno_before  ⊑  pow2_fast_noerrno_combined := by
  unfold pow2_fast_noerrno_before pow2_fast_noerrno_combined
  simp_alive_peephole
  sorry
def pow_neg1_strict_combined := [llvmfunc|
  llvm.func @pow_neg1_strict(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fdiv %0, %arg0  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_pow_neg1_strict   : pow_neg1_strict_before  ⊑  pow_neg1_strict_combined := by
  unfold pow_neg1_strict_before pow_neg1_strict_combined
  simp_alive_peephole
  sorry
def pow_neg1_strict_noerrno_combined := [llvmfunc|
  llvm.func @pow_neg1_strict_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fdiv %0, %arg0  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_pow_neg1_strict_noerrno   : pow_neg1_strict_noerrno_before  ⊑  pow_neg1_strict_noerrno_combined := by
  unfold pow_neg1_strict_noerrno_before pow_neg1_strict_noerrno_combined
  simp_alive_peephole
  sorry
def pow_neg1_strictv_combined := [llvmfunc|
  llvm.func @pow_neg1_strictv(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fdiv %0, %arg0  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_pow_neg1_strictv   : pow_neg1_strictv_before  ⊑  pow_neg1_strictv_combined := by
  unfold pow_neg1_strictv_before pow_neg1_strictv_combined
  simp_alive_peephole
  sorry
def pow_neg1_double_fast_combined := [llvmfunc|
  llvm.func @pow_neg1_double_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_neg1_double_fast   : pow_neg1_double_fast_before  ⊑  pow_neg1_double_fast_combined := by
  unfold pow_neg1_double_fast_before pow_neg1_double_fast_combined
  simp_alive_peephole
  sorry
def pow_neg1_double_fast_noerrno_combined := [llvmfunc|
  llvm.func @pow_neg1_double_fast_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_neg1_double_fast_noerrno   : pow_neg1_double_fast_noerrno_before  ⊑  pow_neg1_double_fast_noerrno_combined := by
  unfold pow_neg1_double_fast_noerrno_before pow_neg1_double_fast_noerrno_combined
  simp_alive_peephole
  sorry
def pow_neg1_double_fastv_combined := [llvmfunc|
  llvm.func @pow_neg1_double_fastv(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_pow_neg1_double_fastv   : pow_neg1_double_fastv_before  ⊑  pow_neg1_double_fastv_combined := by
  unfold pow_neg1_double_fastv_before pow_neg1_double_fastv_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_half_no_FMF_combined := [llvmfunc|
  llvm.func @pow_intrinsic_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %2 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %3 = llvm.intr.fabs(%2)  : (f64) -> f64
    %4 = llvm.fcmp "oeq" %arg0, %0 : f64
    %5 = llvm.select %4, %1, %3 : i1, f64
    llvm.return %5 : f64
  }]

theorem inst_combine_pow_intrinsic_half_no_FMF   : pow_intrinsic_half_no_FMF_before  ⊑  pow_intrinsic_half_no_FMF_combined := by
  unfold pow_intrinsic_half_no_FMF_before pow_intrinsic_half_no_FMF_combined
  simp_alive_peephole
  sorry
def test_simplify18_combined := [llvmfunc|
  llvm.func @test_simplify18(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_simplify18   : test_simplify18_before  ⊑  test_simplify18_combined := by
  unfold test_simplify18_before test_simplify18_combined
  simp_alive_peephole
  sorry
def test_simplify18_noerrno_combined := [llvmfunc|
  llvm.func @test_simplify18_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_simplify18_noerrno   : test_simplify18_noerrno_before  ⊑  test_simplify18_noerrno_combined := by
  unfold test_simplify18_noerrno_before test_simplify18_noerrno_combined
  simp_alive_peephole
  sorry
def test_simplify19_combined := [llvmfunc|
  llvm.func @test_simplify19(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_simplify19   : test_simplify19_before  ⊑  test_simplify19_combined := by
  unfold test_simplify19_before test_simplify19_combined
  simp_alive_peephole
  sorry
def test_simplify19_noerrno_combined := [llvmfunc|
  llvm.func @test_simplify19_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_simplify19_noerrno   : test_simplify19_noerrno_before  ⊑  test_simplify19_noerrno_combined := by
  unfold test_simplify19_noerrno_before test_simplify19_noerrno_combined
  simp_alive_peephole
  sorry
def test_libcall_powf_10_f32_noerrno_combined := [llvmfunc|
  llvm.func @test_libcall_powf_10_f32_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_libcall_powf_10_f32_noerrno   : test_libcall_powf_10_f32_noerrno_before  ⊑  test_libcall_powf_10_f32_noerrno_combined := by
  unfold test_libcall_powf_10_f32_noerrno_before test_libcall_powf_10_f32_noerrno_combined
  simp_alive_peephole
  sorry
def test_libcall_pow_10_f64_noerrno_combined := [llvmfunc|
  llvm.func @test_libcall_pow_10_f64_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_libcall_pow_10_f64_noerrno   : test_libcall_pow_10_f64_noerrno_before  ⊑  test_libcall_pow_10_f64_noerrno_combined := by
  unfold test_libcall_pow_10_f64_noerrno_before test_libcall_pow_10_f64_noerrno_combined
  simp_alive_peephole
  sorry
def test_pow_10_f16_combined := [llvmfunc|
  llvm.func @test_pow_10_f16(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(1.000000e+01 : f16) : f16
    %1 = llvm.intr.pow(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_test_pow_10_f16   : test_pow_10_f16_before  ⊑  test_pow_10_f16_combined := by
  unfold test_pow_10_f16_before test_pow_10_f16_combined
  simp_alive_peephole
  sorry
def test_pow_10_f32_combined := [llvmfunc|
  llvm.func @test_pow_10_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.intr.pow(%0, %arg0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_pow_10_f32   : test_pow_10_f32_before  ⊑  test_pow_10_f32_combined := by
  unfold test_pow_10_f32_before test_pow_10_f32_combined
  simp_alive_peephole
  sorry
def test_pow_10_f64_combined := [llvmfunc|
  llvm.func @test_pow_10_f64(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.intr.pow(%0, %arg0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_pow_10_f64   : test_pow_10_f64_before  ⊑  test_pow_10_f64_combined := by
  unfold test_pow_10_f64_before test_pow_10_f64_combined
  simp_alive_peephole
  sorry
def test_pow_10_fp128_combined := [llvmfunc|
  llvm.func @test_pow_10_fp128(%arg0: f128) -> f128 {
    %0 = llvm.mlir.constant(1.000000e+01 : f128) : f128
    %1 = llvm.intr.pow(%0, %arg0)  : (f128, f128) -> f128
    llvm.return %1 : f128
  }]

theorem inst_combine_test_pow_10_fp128   : test_pow_10_fp128_before  ⊑  test_pow_10_fp128_combined := by
  unfold test_pow_10_fp128_before test_pow_10_fp128_combined
  simp_alive_peephole
  sorry
def test_pow_10_bf16_combined := [llvmfunc|
  llvm.func @test_pow_10_bf16(%arg0: bf16) -> bf16 {
    %0 = llvm.mlir.constant(1.000000e+01 : bf16) : bf16
    %1 = llvm.intr.pow(%0, %arg0)  : (bf16, bf16) -> bf16
    llvm.return %1 : bf16
  }]

theorem inst_combine_test_pow_10_bf16   : test_pow_10_bf16_before  ⊑  test_pow_10_bf16_combined := by
  unfold test_pow_10_bf16_before test_pow_10_bf16_combined
  simp_alive_peephole
  sorry
def test_pow_10_v2f16_combined := [llvmfunc|
  llvm.func @test_pow_10_v2f16(%arg0: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.mlir.constant(dense<1.000000e+01> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }]

theorem inst_combine_test_pow_10_v2f16   : test_pow_10_v2f16_before  ⊑  test_pow_10_v2f16_combined := by
  unfold test_pow_10_v2f16_before test_pow_10_v2f16_combined
  simp_alive_peephole
  sorry
def test_pow_10_v2f32_combined := [llvmfunc|
  llvm.func @test_pow_10_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+01> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_test_pow_10_v2f32   : test_pow_10_v2f32_before  ⊑  test_pow_10_v2f32_combined := by
  unfold test_pow_10_v2f32_before test_pow_10_v2f32_combined
  simp_alive_peephole
  sorry
def test_pow_10_v2f64_combined := [llvmfunc|
  llvm.func @test_pow_10_v2f64(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_test_pow_10_v2f64   : test_pow_10_v2f64_before  ⊑  test_pow_10_v2f64_combined := by
  unfold test_pow_10_v2f64_before test_pow_10_v2f64_combined
  simp_alive_peephole
  sorry
def test_pow_10_v2bf16_combined := [llvmfunc|
  llvm.func @test_pow_10_v2bf16(%arg0: vector<2xbf16>) -> vector<2xbf16> {
    %0 = llvm.mlir.constant(dense<1.000000e+01> : vector<2xbf16>) : vector<2xbf16>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xbf16>, vector<2xbf16>) -> vector<2xbf16>
    llvm.return %1 : vector<2xbf16>
  }]

theorem inst_combine_test_pow_10_v2bf16   : test_pow_10_v2bf16_before  ⊑  test_pow_10_v2bf16_combined := by
  unfold test_pow_10_v2bf16_before test_pow_10_v2bf16_combined
  simp_alive_peephole
  sorry
