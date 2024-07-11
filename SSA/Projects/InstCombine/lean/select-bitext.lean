import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-bitext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sel_sext_constants_before := [llvmfunc|
  llvm.func @sel_sext_constants(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.sext %2 : i8 to i16
    llvm.return %3 : i16
  }]

def sel_zext_constants_before := [llvmfunc|
  llvm.func @sel_zext_constants(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.zext %2 : i8 to i16
    llvm.return %3 : i16
  }]

def sel_fpext_constants_before := [llvmfunc|
  llvm.func @sel_fpext_constants(%arg0: i1) -> f64 {
    %0 = llvm.mlir.constant(-2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def sel_sext_before := [llvmfunc|
  llvm.func @sel_sext(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.select %arg1, %arg0, %0 : i1, i32
    %2 = llvm.sext %1 : i32 to i64
    llvm.return %2 : i64
  }]

def sel_sext_vec_before := [llvmfunc|
  llvm.func @sel_sext_vec(%arg0: vector<4xi32>, %arg1: vector<4xi1>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.select %arg1, %arg0, %0 : vector<4xi1>, vector<4xi32>
    %2 = llvm.sext %1 : vector<4xi32> to vector<4xi64>
    llvm.return %2 : vector<4xi64>
  }]

def sel_zext_before := [llvmfunc|
  llvm.func @sel_zext(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.select %arg1, %arg0, %0 : i1, i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }]

def sel_zext_vec_before := [llvmfunc|
  llvm.func @sel_zext_vec(%arg0: vector<4xi32>, %arg1: vector<4xi1>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.select %arg1, %arg0, %0 : vector<4xi1>, vector<4xi32>
    %2 = llvm.zext %1 : vector<4xi32> to vector<4xi64>
    llvm.return %2 : vector<4xi64>
  }]

def trunc_sel_larger_sext_before := [llvmfunc|
  llvm.func @trunc_sel_larger_sext(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.select %arg1, %1, %0 : i1, i16
    %3 = llvm.sext %2 : i16 to i64
    llvm.return %3 : i64
  }]

def trunc_sel_larger_sext_vec_before := [llvmfunc|
  llvm.func @trunc_sel_larger_sext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi16>
    %3 = llvm.sext %2 : vector<2xi16> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def trunc_sel_smaller_sext_before := [llvmfunc|
  llvm.func @trunc_sel_smaller_sext(%arg0: i64, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.select %arg1, %1, %0 : i1, i16
    %3 = llvm.sext %2 : i16 to i32
    llvm.return %3 : i32
  }]

def trunc_sel_smaller_sext_vec_before := [llvmfunc|
  llvm.func @trunc_sel_smaller_sext_vec(%arg0: vector<2xi64>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi16>
    %3 = llvm.sext %2 : vector<2xi16> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def trunc_sel_equal_sext_before := [llvmfunc|
  llvm.func @trunc_sel_equal_sext(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.select %arg1, %1, %0 : i1, i16
    %3 = llvm.sext %2 : i16 to i32
    llvm.return %3 : i32
  }]

def trunc_sel_equal_sext_vec_before := [llvmfunc|
  llvm.func @trunc_sel_equal_sext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi16>
    %3 = llvm.sext %2 : vector<2xi16> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def trunc_sel_larger_zext_before := [llvmfunc|
  llvm.func @trunc_sel_larger_zext(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.select %arg1, %1, %0 : i1, i16
    %3 = llvm.zext %2 : i16 to i64
    llvm.return %3 : i64
  }]

def trunc_sel_larger_zext_vec_before := [llvmfunc|
  llvm.func @trunc_sel_larger_zext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi16>
    %3 = llvm.zext %2 : vector<2xi16> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def trunc_sel_smaller_zext_before := [llvmfunc|
  llvm.func @trunc_sel_smaller_zext(%arg0: i64, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.select %arg1, %1, %0 : i1, i16
    %3 = llvm.zext %2 : i16 to i32
    llvm.return %3 : i32
  }]

def trunc_sel_smaller_zext_vec_before := [llvmfunc|
  llvm.func @trunc_sel_smaller_zext_vec(%arg0: vector<2xi64>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi16>
    %3 = llvm.zext %2 : vector<2xi16> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def trunc_sel_equal_zext_before := [llvmfunc|
  llvm.func @trunc_sel_equal_zext(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.select %arg1, %1, %0 : i1, i16
    %3 = llvm.zext %2 : i16 to i32
    llvm.return %3 : i32
  }]

def trunc_sel_equal_zext_vec_before := [llvmfunc|
  llvm.func @trunc_sel_equal_zext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi16>
    %3 = llvm.zext %2 : vector<2xi16> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def trunc_sel_larger_fpext_before := [llvmfunc|
  llvm.func @trunc_sel_larger_fpext(%arg0: f32, %arg1: i1) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f16) : f16
    %1 = llvm.fptrunc %arg0 : f32 to f16
    %2 = llvm.select %arg1, %1, %0 : i1, f16
    %3 = llvm.fpext %2 : f16 to f64
    llvm.return %3 : f64
  }]

def trunc_sel_larger_fpext_vec_before := [llvmfunc|
  llvm.func @trunc_sel_larger_fpext_vec(%arg0: vector<2xf32>, %arg1: vector<2xi1>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 4.300000e+01]> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fptrunc %arg0 : vector<2xf32> to vector<2xf16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xf16>
    %3 = llvm.fpext %2 : vector<2xf16> to vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }]

def trunc_sel_smaller_fpext_before := [llvmfunc|
  llvm.func @trunc_sel_smaller_fpext(%arg0: f64, %arg1: i1) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f16) : f16
    %1 = llvm.fptrunc %arg0 : f64 to f16
    %2 = llvm.select %arg1, %1, %0 : i1, f16
    %3 = llvm.fpext %2 : f16 to f32
    llvm.return %3 : f32
  }]

def trunc_sel_smaller_fpext_vec_before := [llvmfunc|
  llvm.func @trunc_sel_smaller_fpext_vec(%arg0: vector<2xf64>, %arg1: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 4.300000e+01]> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fptrunc %arg0 : vector<2xf64> to vector<2xf16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xf16>
    %3 = llvm.fpext %2 : vector<2xf16> to vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def trunc_sel_equal_fpext_before := [llvmfunc|
  llvm.func @trunc_sel_equal_fpext(%arg0: f32, %arg1: i1) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f16) : f16
    %1 = llvm.fptrunc %arg0 : f32 to f16
    %2 = llvm.select %arg1, %1, %0 : i1, f16
    %3 = llvm.fpext %2 : f16 to f32
    llvm.return %3 : f32
  }]

def trunc_sel_equal_fpext_vec_before := [llvmfunc|
  llvm.func @trunc_sel_equal_fpext_vec(%arg0: vector<2xf32>, %arg1: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 4.300000e+01]> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fptrunc %arg0 : vector<2xf32> to vector<2xf16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xf16>
    %3 = llvm.fpext %2 : vector<2xf16> to vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def test_sext1_before := [llvmfunc|
  llvm.func @test_sext1(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

def test_sext2_before := [llvmfunc|
  llvm.func @test_sext2(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

def test_sext3_before := [llvmfunc|
  llvm.func @test_sext3(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

def test_sext4_before := [llvmfunc|
  llvm.func @test_sext4(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

def test_zext1_before := [llvmfunc|
  llvm.func @test_zext1(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

def test_zext2_before := [llvmfunc|
  llvm.func @test_zext2(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

def test_zext3_before := [llvmfunc|
  llvm.func @test_zext3(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

def test_zext4_before := [llvmfunc|
  llvm.func @test_zext4(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

def test_negative_sext_before := [llvmfunc|
  llvm.func @test_negative_sext(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

def test_negative_zext_before := [llvmfunc|
  llvm.func @test_negative_zext(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

def test_bits_sext_before := [llvmfunc|
  llvm.func @test_bits_sext(%arg0: i8, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

def test_bits_zext_before := [llvmfunc|
  llvm.func @test_bits_zext(%arg0: i8, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

def sel_sext_const_uses_before := [llvmfunc|
  llvm.func @sel_sext_const_uses(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "ugt" %arg1, %0 : i8
    %3 = llvm.sext %arg0 : i8 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.select %2, %3, %1 : i1, i32
    llvm.return %4 : i32
  }]

def sel_zext_const_uses_before := [llvmfunc|
  llvm.func @sel_zext_const_uses(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i8
    %3 = llvm.zext %arg0 : i8 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.select %2, %1, %3 : i1, i32
    llvm.return %4 : i32
  }]

def test_op_op_before := [llvmfunc|
  llvm.func @test_op_op(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sext %1 : i1 to i32
    %3 = llvm.icmp "sgt" %arg1, %0 : i32
    %4 = llvm.sext %3 : i1 to i32
    %5 = llvm.icmp "sgt" %arg2, %0 : i32
    %6 = llvm.select %5, %2, %4 : i1, i32
    llvm.return %6 : i32
  }]

def test_vectors_sext_before := [llvmfunc|
  llvm.func @test_vectors_sext(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %3 = llvm.select %arg1, %2, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def test_vectors_sext_nonsplat_before := [llvmfunc|
  llvm.func @test_vectors_sext_nonsplat(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[0, -1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def test_vectors_zext_before := [llvmfunc|
  llvm.func @test_vectors_zext(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %3 = llvm.select %arg1, %2, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def test_vectors_zext_nonsplat_before := [llvmfunc|
  llvm.func @test_vectors_zext_nonsplat(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def scalar_select_of_vectors_sext_before := [llvmfunc|
  llvm.func @scalar_select_of_vectors_sext(%arg0: vector<2xi1>, %arg1: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %3 = llvm.select %arg1, %2, %1 : i1, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def scalar_select_of_vectors_zext_before := [llvmfunc|
  llvm.func @scalar_select_of_vectors_zext(%arg0: vector<2xi1>, %arg1: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %3 = llvm.select %arg1, %2, %1 : i1, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def sext_true_val_must_be_all_ones_before := [llvmfunc|
  llvm.func @sext_true_val_must_be_all_ones(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg0, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

def sext_true_val_must_be_all_ones_vec_before := [llvmfunc|
  llvm.func @sext_true_val_must_be_all_ones_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 12]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.select %arg0, %1, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def zext_true_val_must_be_one_before := [llvmfunc|
  llvm.func @zext_true_val_must_be_one(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg0, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

def zext_true_val_must_be_one_vec_before := [llvmfunc|
  llvm.func @zext_true_val_must_be_one_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 12]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.select %arg0, %1, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def sext_false_val_must_be_zero_before := [llvmfunc|
  llvm.func @sext_false_val_must_be_zero(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

def sext_false_val_must_be_zero_vec_before := [llvmfunc|
  llvm.func @sext_false_val_must_be_zero_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 12]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def zext_false_val_must_be_zero_before := [llvmfunc|
  llvm.func @zext_false_val_must_be_zero(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

def zext_false_val_must_be_zero_vec_before := [llvmfunc|
  llvm.func @zext_false_val_must_be_zero_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 12]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def sel_sext_constants_combined := [llvmfunc|
  llvm.func @sel_sext_constants(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.mlir.constant(42 : i16) : i16
    %2 = llvm.select %arg0, %0, %1 : i1, i16
    llvm.return %2 : i16
  }]

theorem inst_combine_sel_sext_constants   : sel_sext_constants_before  ⊑  sel_sext_constants_combined := by
  unfold sel_sext_constants_before sel_sext_constants_combined
  simp_alive_peephole
  sorry
def sel_zext_constants_combined := [llvmfunc|
  llvm.func @sel_zext_constants(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.mlir.constant(42 : i16) : i16
    %2 = llvm.select %arg0, %0, %1 : i1, i16
    llvm.return %2 : i16
  }]

theorem inst_combine_sel_zext_constants   : sel_zext_constants_before  ⊑  sel_zext_constants_combined := by
  unfold sel_zext_constants_before sel_zext_constants_combined
  simp_alive_peephole
  sorry
def sel_fpext_constants_combined := [llvmfunc|
  llvm.func @sel_fpext_constants(%arg0: i1) -> f64 {
    %0 = llvm.mlir.constant(-2.550000e+02 : f64) : f64
    %1 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %2 = llvm.select %arg0, %0, %1 : i1, f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sel_fpext_constants   : sel_fpext_constants_before  ⊑  sel_fpext_constants_combined := by
  unfold sel_fpext_constants_before sel_fpext_constants_combined
  simp_alive_peephole
  sorry
def sel_sext_combined := [llvmfunc|
  llvm.func @sel_sext(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.sext %arg0 : i32 to i64
    %2 = llvm.select %arg1, %1, %0 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sel_sext   : sel_sext_before  ⊑  sel_sext_combined := by
  unfold sel_sext_before sel_sext_combined
  simp_alive_peephole
  sorry
def sel_sext_vec_combined := [llvmfunc|
  llvm.func @sel_sext_vec(%arg0: vector<4xi32>, %arg1: vector<4xi1>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.sext %arg0 : vector<4xi32> to vector<4xi64>
    %2 = llvm.select %arg1, %1, %0 : vector<4xi1>, vector<4xi64>
    llvm.return %2 : vector<4xi64>
  }]

theorem inst_combine_sel_sext_vec   : sel_sext_vec_before  ⊑  sel_sext_vec_combined := by
  unfold sel_sext_vec_before sel_sext_vec_combined
  simp_alive_peephole
  sorry
def sel_zext_combined := [llvmfunc|
  llvm.func @sel_zext(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.select %arg1, %1, %0 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sel_zext   : sel_zext_before  ⊑  sel_zext_combined := by
  unfold sel_zext_before sel_zext_combined
  simp_alive_peephole
  sorry
def sel_zext_vec_combined := [llvmfunc|
  llvm.func @sel_zext_vec(%arg0: vector<4xi32>, %arg1: vector<4xi1>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.zext %arg0 : vector<4xi32> to vector<4xi64>
    %2 = llvm.select %arg1, %1, %0 : vector<4xi1>, vector<4xi64>
    llvm.return %2 : vector<4xi64>
  }]

theorem inst_combine_sel_zext_vec   : sel_zext_vec_before  ⊑  sel_zext_vec_combined := by
  unfold sel_zext_vec_before sel_zext_vec_combined
  simp_alive_peephole
  sorry
def trunc_sel_larger_sext_combined := [llvmfunc|
  llvm.func @trunc_sel_larger_sext(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.sext %1 : i16 to i64
    %3 = llvm.select %arg1, %2, %0 : i1, i64
    llvm.return %3 : i64
  }]

theorem inst_combine_trunc_sel_larger_sext   : trunc_sel_larger_sext_before  ⊑  trunc_sel_larger_sext_combined := by
  unfold trunc_sel_larger_sext_before trunc_sel_larger_sext_combined
  simp_alive_peephole
  sorry
def trunc_sel_larger_sext_vec_combined := [llvmfunc|
  llvm.func @trunc_sel_larger_sext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi16>
    %2 = llvm.sext %1 : vector<2xi16> to vector<2xi64>
    %3 = llvm.select %arg1, %2, %0 : vector<2xi1>, vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_trunc_sel_larger_sext_vec   : trunc_sel_larger_sext_vec_before  ⊑  trunc_sel_larger_sext_vec_combined := by
  unfold trunc_sel_larger_sext_vec_before trunc_sel_larger_sext_vec_combined
  simp_alive_peephole
  sorry
def trunc_sel_smaller_sext_combined := [llvmfunc|
  llvm.func @trunc_sel_smaller_sext(%arg0: i64, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.sext %1 : i16 to i32
    %3 = llvm.select %arg1, %2, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_trunc_sel_smaller_sext   : trunc_sel_smaller_sext_before  ⊑  trunc_sel_smaller_sext_combined := by
  unfold trunc_sel_smaller_sext_before trunc_sel_smaller_sext_combined
  simp_alive_peephole
  sorry
def trunc_sel_smaller_sext_vec_combined := [llvmfunc|
  llvm.func @trunc_sel_smaller_sext_vec(%arg0: vector<2xi64>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi16>
    %2 = llvm.sext %1 : vector<2xi16> to vector<2xi32>
    %3 = llvm.select %arg1, %2, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_trunc_sel_smaller_sext_vec   : trunc_sel_smaller_sext_vec_before  ⊑  trunc_sel_smaller_sext_vec_combined := by
  unfold trunc_sel_smaller_sext_vec_before trunc_sel_smaller_sext_vec_combined
  simp_alive_peephole
  sorry
def trunc_sel_equal_sext_combined := [llvmfunc|
  llvm.func @trunc_sel_equal_sext(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    %4 = llvm.select %arg1, %3, %1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_trunc_sel_equal_sext   : trunc_sel_equal_sext_before  ⊑  trunc_sel_equal_sext_combined := by
  unfold trunc_sel_equal_sext_before trunc_sel_equal_sext_combined
  simp_alive_peephole
  sorry
def trunc_sel_equal_sext_vec_combined := [llvmfunc|
  llvm.func @trunc_sel_equal_sext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    %4 = llvm.select %arg1, %3, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_trunc_sel_equal_sext_vec   : trunc_sel_equal_sext_vec_before  ⊑  trunc_sel_equal_sext_vec_combined := by
  unfold trunc_sel_equal_sext_vec_before trunc_sel_equal_sext_vec_combined
  simp_alive_peephole
  sorry
def trunc_sel_larger_zext_combined := [llvmfunc|
  llvm.func @trunc_sel_larger_zext(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(42 : i64) : i64
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.select %arg1, %3, %1 : i1, i64
    llvm.return %4 : i64
  }]

theorem inst_combine_trunc_sel_larger_zext   : trunc_sel_larger_zext_before  ⊑  trunc_sel_larger_zext_combined := by
  unfold trunc_sel_larger_zext_before trunc_sel_larger_zext_combined
  simp_alive_peephole
  sorry
def trunc_sel_larger_zext_vec_combined := [llvmfunc|
  llvm.func @trunc_sel_larger_zext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.select %arg1, %3, %1 : vector<2xi1>, vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_trunc_sel_larger_zext_vec   : trunc_sel_larger_zext_vec_before  ⊑  trunc_sel_larger_zext_vec_combined := by
  unfold trunc_sel_larger_zext_vec_before trunc_sel_larger_zext_vec_combined
  simp_alive_peephole
  sorry
def trunc_sel_smaller_zext_combined := [llvmfunc|
  llvm.func @trunc_sel_smaller_zext(%arg0: i64, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.select %arg1, %3, %1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_trunc_sel_smaller_zext   : trunc_sel_smaller_zext_before  ⊑  trunc_sel_smaller_zext_combined := by
  unfold trunc_sel_smaller_zext_before trunc_sel_smaller_zext_combined
  simp_alive_peephole
  sorry
def trunc_sel_smaller_zext_vec_combined := [llvmfunc|
  llvm.func @trunc_sel_smaller_zext_vec(%arg0: vector<2xi64>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    %4 = llvm.select %arg1, %3, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_trunc_sel_smaller_zext_vec   : trunc_sel_smaller_zext_vec_before  ⊑  trunc_sel_smaller_zext_vec_combined := by
  unfold trunc_sel_smaller_zext_vec_before trunc_sel_smaller_zext_vec_combined
  simp_alive_peephole
  sorry
def trunc_sel_equal_zext_combined := [llvmfunc|
  llvm.func @trunc_sel_equal_zext(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.select %arg1, %2, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_trunc_sel_equal_zext   : trunc_sel_equal_zext_before  ⊑  trunc_sel_equal_zext_combined := by
  unfold trunc_sel_equal_zext_before trunc_sel_equal_zext_combined
  simp_alive_peephole
  sorry
def trunc_sel_equal_zext_vec_combined := [llvmfunc|
  llvm.func @trunc_sel_equal_zext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.select %arg1, %2, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_trunc_sel_equal_zext_vec   : trunc_sel_equal_zext_vec_before  ⊑  trunc_sel_equal_zext_vec_combined := by
  unfold trunc_sel_equal_zext_vec_before trunc_sel_equal_zext_vec_combined
  simp_alive_peephole
  sorry
def trunc_sel_larger_fpext_combined := [llvmfunc|
  llvm.func @trunc_sel_larger_fpext(%arg0: f32, %arg1: i1) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fptrunc %arg0 : f32 to f16
    %2 = llvm.fpext %1 : f16 to f64
    %3 = llvm.select %arg1, %2, %0 : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_trunc_sel_larger_fpext   : trunc_sel_larger_fpext_before  ⊑  trunc_sel_larger_fpext_combined := by
  unfold trunc_sel_larger_fpext_before trunc_sel_larger_fpext_combined
  simp_alive_peephole
  sorry
def trunc_sel_larger_fpext_vec_combined := [llvmfunc|
  llvm.func @trunc_sel_larger_fpext_vec(%arg0: vector<2xf32>, %arg1: vector<2xi1>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 4.300000e+01]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fptrunc %arg0 : vector<2xf32> to vector<2xf16>
    %2 = llvm.fpext %1 : vector<2xf16> to vector<2xf64>
    %3 = llvm.select %arg1, %2, %0 : vector<2xi1>, vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }]

theorem inst_combine_trunc_sel_larger_fpext_vec   : trunc_sel_larger_fpext_vec_before  ⊑  trunc_sel_larger_fpext_vec_combined := by
  unfold trunc_sel_larger_fpext_vec_before trunc_sel_larger_fpext_vec_combined
  simp_alive_peephole
  sorry
def trunc_sel_smaller_fpext_combined := [llvmfunc|
  llvm.func @trunc_sel_smaller_fpext(%arg0: f64, %arg1: i1) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fptrunc %arg0 : f64 to f16
    %2 = llvm.fpext %1 : f16 to f32
    %3 = llvm.select %arg1, %2, %0 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_trunc_sel_smaller_fpext   : trunc_sel_smaller_fpext_before  ⊑  trunc_sel_smaller_fpext_combined := by
  unfold trunc_sel_smaller_fpext_before trunc_sel_smaller_fpext_combined
  simp_alive_peephole
  sorry
def trunc_sel_smaller_fpext_vec_combined := [llvmfunc|
  llvm.func @trunc_sel_smaller_fpext_vec(%arg0: vector<2xf64>, %arg1: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 4.300000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fptrunc %arg0 : vector<2xf64> to vector<2xf16>
    %2 = llvm.fpext %1 : vector<2xf16> to vector<2xf32>
    %3 = llvm.select %arg1, %2, %0 : vector<2xi1>, vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

theorem inst_combine_trunc_sel_smaller_fpext_vec   : trunc_sel_smaller_fpext_vec_before  ⊑  trunc_sel_smaller_fpext_vec_combined := by
  unfold trunc_sel_smaller_fpext_vec_before trunc_sel_smaller_fpext_vec_combined
  simp_alive_peephole
  sorry
def trunc_sel_equal_fpext_combined := [llvmfunc|
  llvm.func @trunc_sel_equal_fpext(%arg0: f32, %arg1: i1) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fptrunc %arg0 : f32 to f16
    %2 = llvm.fpext %1 : f16 to f32
    %3 = llvm.select %arg1, %2, %0 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_trunc_sel_equal_fpext   : trunc_sel_equal_fpext_before  ⊑  trunc_sel_equal_fpext_combined := by
  unfold trunc_sel_equal_fpext_before trunc_sel_equal_fpext_combined
  simp_alive_peephole
  sorry
def trunc_sel_equal_fpext_vec_combined := [llvmfunc|
  llvm.func @trunc_sel_equal_fpext_vec(%arg0: vector<2xf32>, %arg1: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 4.300000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fptrunc %arg0 : vector<2xf32> to vector<2xf16>
    %2 = llvm.fpext %1 : vector<2xf16> to vector<2xf32>
    %3 = llvm.select %arg1, %2, %0 : vector<2xi1>, vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

theorem inst_combine_trunc_sel_equal_fpext_vec   : trunc_sel_equal_fpext_vec_before  ⊑  trunc_sel_equal_fpext_vec_combined := by
  unfold trunc_sel_equal_fpext_vec_before trunc_sel_equal_fpext_vec_combined
  simp_alive_peephole
  sorry
def test_sext1_combined := [llvmfunc|
  llvm.func @test_sext1(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.sext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_sext1   : test_sext1_before  ⊑  test_sext1_combined := by
  unfold test_sext1_before test_sext1_combined
  simp_alive_peephole
  sorry
def test_sext2_combined := [llvmfunc|
  llvm.func @test_sext2(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.sext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_sext2   : test_sext2_before  ⊑  test_sext2_combined := by
  unfold test_sext2_before test_sext2_combined
  simp_alive_peephole
  sorry
def test_sext3_combined := [llvmfunc|
  llvm.func @test_sext3(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    %4 = llvm.sext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_sext3   : test_sext3_before  ⊑  test_sext3_combined := by
  unfold test_sext3_before test_sext3_combined
  simp_alive_peephole
  sorry
def test_sext4_combined := [llvmfunc|
  llvm.func @test_sext4(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    %3 = llvm.sext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_sext4   : test_sext4_before  ⊑  test_sext4_combined := by
  unfold test_sext4_before test_sext4_combined
  simp_alive_peephole
  sorry
def test_zext1_combined := [llvmfunc|
  llvm.func @test_zext1(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg0, %0 : i1, i1
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_zext1   : test_zext1_before  ⊑  test_zext1_combined := by
  unfold test_zext1_before test_zext1_combined
  simp_alive_peephole
  sorry
def test_zext2_combined := [llvmfunc|
  llvm.func @test_zext2(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_zext2   : test_zext2_before  ⊑  test_zext2_combined := by
  unfold test_zext2_before test_zext2_combined
  simp_alive_peephole
  sorry
def test_zext3_combined := [llvmfunc|
  llvm.func @test_zext3(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_zext3   : test_zext3_before  ⊑  test_zext3_combined := by
  unfold test_zext3_before test_zext3_combined
  simp_alive_peephole
  sorry
def test_zext4_combined := [llvmfunc|
  llvm.func @test_zext4(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_zext4   : test_zext4_before  ⊑  test_zext4_combined := by
  unfold test_zext4_before test_zext4_combined
  simp_alive_peephole
  sorry
def test_negative_sext_combined := [llvmfunc|
  llvm.func @test_negative_sext(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_negative_sext   : test_negative_sext_before  ⊑  test_negative_sext_combined := by
  unfold test_negative_sext_before test_negative_sext_combined
  simp_alive_peephole
  sorry
def test_negative_zext_combined := [llvmfunc|
  llvm.func @test_negative_zext(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_negative_zext   : test_negative_zext_before  ⊑  test_negative_zext_combined := by
  unfold test_negative_zext_before test_negative_zext_combined
  simp_alive_peephole
  sorry
def test_bits_sext_combined := [llvmfunc|
  llvm.func @test_bits_sext(%arg0: i8, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_bits_sext   : test_bits_sext_before  ⊑  test_bits_sext_combined := by
  unfold test_bits_sext_before test_bits_sext_combined
  simp_alive_peephole
  sorry
def test_bits_zext_combined := [llvmfunc|
  llvm.func @test_bits_zext(%arg0: i8, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_bits_zext   : test_bits_zext_before  ⊑  test_bits_zext_combined := by
  unfold test_bits_zext_before test_bits_zext_combined
  simp_alive_peephole
  sorry
def sel_sext_const_uses_combined := [llvmfunc|
  llvm.func @sel_sext_const_uses(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "ugt" %arg1, %0 : i8
    %3 = llvm.sext %arg0 : i8 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.select %2, %3, %1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_sel_sext_const_uses   : sel_sext_const_uses_before  ⊑  sel_sext_const_uses_combined := by
  unfold sel_sext_const_uses_before sel_sext_const_uses_combined
  simp_alive_peephole
  sorry
def sel_zext_const_uses_combined := [llvmfunc|
  llvm.func @sel_zext_const_uses(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i8
    %3 = llvm.zext %arg0 : i8 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.select %2, %1, %3 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_sel_zext_const_uses   : sel_zext_const_uses_before  ⊑  sel_zext_const_uses_combined := by
  unfold sel_zext_const_uses_before sel_zext_const_uses_combined
  simp_alive_peephole
  sorry
def test_op_op_combined := [llvmfunc|
  llvm.func @test_op_op(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg2, %0 : i32
    %2 = llvm.select %1, %arg0, %arg1 : i1, i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.sext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_op_op   : test_op_op_before  ⊑  test_op_op_combined := by
  unfold test_op_op_before test_op_op_combined
  simp_alive_peephole
  sorry
def test_vectors_sext_combined := [llvmfunc|
  llvm.func @test_vectors_sext(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.select %arg1, %arg0, %1 : vector<2xi1>, vector<2xi1>
    %3 = llvm.sext %2 : vector<2xi1> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test_vectors_sext   : test_vectors_sext_before  ⊑  test_vectors_sext_combined := by
  unfold test_vectors_sext_before test_vectors_sext_combined
  simp_alive_peephole
  sorry
def test_vectors_sext_nonsplat_combined := [llvmfunc|
  llvm.func @test_vectors_sext_nonsplat(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(dense<[false, true]> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.select %arg1, %arg0, %2 : vector<2xi1>, vector<2xi1>
    %4 = llvm.sext %3 : vector<2xi1> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_test_vectors_sext_nonsplat   : test_vectors_sext_nonsplat_before  ⊑  test_vectors_sext_nonsplat_combined := by
  unfold test_vectors_sext_nonsplat_before test_vectors_sext_nonsplat_combined
  simp_alive_peephole
  sorry
def test_vectors_zext_combined := [llvmfunc|
  llvm.func @test_vectors_zext(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.select %arg1, %arg0, %1 : vector<2xi1>, vector<2xi1>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test_vectors_zext   : test_vectors_zext_before  ⊑  test_vectors_zext_combined := by
  unfold test_vectors_zext_before test_vectors_zext_combined
  simp_alive_peephole
  sorry
def test_vectors_zext_nonsplat_combined := [llvmfunc|
  llvm.func @test_vectors_zext_nonsplat(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.select %arg1, %arg0, %2 : vector<2xi1>, vector<2xi1>
    %4 = llvm.zext %3 : vector<2xi1> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_test_vectors_zext_nonsplat   : test_vectors_zext_nonsplat_before  ⊑  test_vectors_zext_nonsplat_combined := by
  unfold test_vectors_zext_nonsplat_before test_vectors_zext_nonsplat_combined
  simp_alive_peephole
  sorry
def scalar_select_of_vectors_sext_combined := [llvmfunc|
  llvm.func @scalar_select_of_vectors_sext(%arg0: vector<2xi1>, %arg1: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.select %arg1, %arg0, %1 : i1, vector<2xi1>
    %3 = llvm.sext %2 : vector<2xi1> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_scalar_select_of_vectors_sext   : scalar_select_of_vectors_sext_before  ⊑  scalar_select_of_vectors_sext_combined := by
  unfold scalar_select_of_vectors_sext_before scalar_select_of_vectors_sext_combined
  simp_alive_peephole
  sorry
def scalar_select_of_vectors_zext_combined := [llvmfunc|
  llvm.func @scalar_select_of_vectors_zext(%arg0: vector<2xi1>, %arg1: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.select %arg1, %arg0, %1 : i1, vector<2xi1>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_scalar_select_of_vectors_zext   : scalar_select_of_vectors_zext_before  ⊑  scalar_select_of_vectors_zext_combined := by
  unfold scalar_select_of_vectors_zext_before scalar_select_of_vectors_zext_combined
  simp_alive_peephole
  sorry
def sext_true_val_must_be_all_ones_combined := [llvmfunc|
  llvm.func @sext_true_val_must_be_all_ones(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sext_true_val_must_be_all_ones   : sext_true_val_must_be_all_ones_before  ⊑  sext_true_val_must_be_all_ones_combined := by
  unfold sext_true_val_must_be_all_ones_before sext_true_val_must_be_all_ones_combined
  simp_alive_peephole
  sorry
def sext_true_val_must_be_all_ones_vec_combined := [llvmfunc|
  llvm.func @sext_true_val_must_be_all_ones_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[42, 12]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_sext_true_val_must_be_all_ones_vec   : sext_true_val_must_be_all_ones_vec_before  ⊑  sext_true_val_must_be_all_ones_vec_combined := by
  unfold sext_true_val_must_be_all_ones_vec_before sext_true_val_must_be_all_ones_vec_combined
  simp_alive_peephole
  sorry
def zext_true_val_must_be_one_combined := [llvmfunc|
  llvm.func @zext_true_val_must_be_one(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_zext_true_val_must_be_one   : zext_true_val_must_be_one_before  ⊑  zext_true_val_must_be_one_combined := by
  unfold zext_true_val_must_be_one_before zext_true_val_must_be_one_combined
  simp_alive_peephole
  sorry
def zext_true_val_must_be_one_vec_combined := [llvmfunc|
  llvm.func @zext_true_val_must_be_one_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[42, 12]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_zext_true_val_must_be_one_vec   : zext_true_val_must_be_one_vec_before  ⊑  zext_true_val_must_be_one_vec_combined := by
  unfold zext_true_val_must_be_one_vec_before zext_true_val_must_be_one_vec_combined
  simp_alive_peephole
  sorry
def sext_false_val_must_be_zero_combined := [llvmfunc|
  llvm.func @sext_false_val_must_be_zero(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sext_false_val_must_be_zero   : sext_false_val_must_be_zero_before  ⊑  sext_false_val_must_be_zero_combined := by
  unfold sext_false_val_must_be_zero_before sext_false_val_must_be_zero_combined
  simp_alive_peephole
  sorry
def sext_false_val_must_be_zero_vec_combined := [llvmfunc|
  llvm.func @sext_false_val_must_be_zero_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 12]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_sext_false_val_must_be_zero_vec   : sext_false_val_must_be_zero_vec_before  ⊑  sext_false_val_must_be_zero_vec_combined := by
  unfold sext_false_val_must_be_zero_vec_before sext_false_val_must_be_zero_vec_combined
  simp_alive_peephole
  sorry
def zext_false_val_must_be_zero_combined := [llvmfunc|
  llvm.func @zext_false_val_must_be_zero(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_zext_false_val_must_be_zero   : zext_false_val_must_be_zero_before  ⊑  zext_false_val_must_be_zero_combined := by
  unfold zext_false_val_must_be_zero_before zext_false_val_must_be_zero_combined
  simp_alive_peephole
  sorry
def zext_false_val_must_be_zero_vec_combined := [llvmfunc|
  llvm.func @zext_false_val_must_be_zero_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 12]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_zext_false_val_must_be_zero_vec   : zext_false_val_must_be_zero_vec_before  ⊑  zext_false_val_must_be_zero_vec_combined := by
  unfold zext_false_val_must_be_zero_vec_before zext_false_val_must_be_zero_vec_combined
  simp_alive_peephole
  sorry
