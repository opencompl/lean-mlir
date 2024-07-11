import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shufflevector-div-rem-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_srem_orig_before := [llvmfunc|
  llvm.func @test_srem_orig(%arg0: i16, %arg1: i1) -> i16 {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<2> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [0, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %2, %6 : i1, vector<2xi16>
    %8 = llvm.srem %7, %3  : vector<2xi16>
    %9 = llvm.extractelement %8[%4 : i32] : vector<2xi16>
    llvm.return %9 : i16
  }]

def test_srem_before := [llvmfunc|
  llvm.func @test_srem(%arg0: i16, %arg1: i1) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<[77, 99]> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi16>
    %5 = llvm.srem %4, %2  : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [-1, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %3, %6 : i1, vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }]

def test_urem_before := [llvmfunc|
  llvm.func @test_urem(%arg0: i16, %arg1: i1) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<[77, 99]> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi16>
    %5 = llvm.urem %4, %2  : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [-1, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %3, %6 : i1, vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }]

def test_sdiv_before := [llvmfunc|
  llvm.func @test_sdiv(%arg0: i16, %arg1: i1) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<[77, 99]> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi16>
    %5 = llvm.sdiv %4, %2  : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [-1, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %3, %6 : i1, vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }]

def test_udiv_before := [llvmfunc|
  llvm.func @test_udiv(%arg0: i16, %arg1: i1) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<[77, 99]> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi16>
    %5 = llvm.udiv %4, %2  : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [-1, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %3, %6 : i1, vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }]

def test_fdiv_before := [llvmfunc|
  llvm.func @test_fdiv(%arg0: f32, %arg1: f32, %arg2: i1) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.mlir.constant(dense<[7.700000e+01, 9.900000e+01]> : vector<2xf32>) : vector<2xf32>
    %12 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %13 = llvm.insertelement %9, %8[%10 : i32] : vector<2xf32>
    %14 = llvm.fdiv %12, %13  : vector<2xf32>
    %15 = llvm.shufflevector %14, %0 [-1, 0] : vector<2xf32> 
    %16 = llvm.select %arg2, %11, %15 : i1, vector<2xf32>
    llvm.return %16 : vector<2xf32>
  }]

def test_frem_before := [llvmfunc|
  llvm.func @test_frem(%arg0: f32, %arg1: f32, %arg2: i1) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.mlir.constant(dense<[7.700000e+01, 9.900000e+01]> : vector<2xf32>) : vector<2xf32>
    %12 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %13 = llvm.insertelement %9, %8[%10 : i32] : vector<2xf32>
    %14 = llvm.frem %12, %13  : vector<2xf32>
    %15 = llvm.shufflevector %14, %0 [-1, 0] : vector<2xf32> 
    %16 = llvm.select %arg2, %11, %15 : i1, vector<2xf32>
    llvm.return %16 : vector<2xf32>
  }]

def test_srem_orig_combined := [llvmfunc|
  llvm.func @test_srem_orig(%arg0: i16, %arg1: i1) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.srem %arg0, %0  : i16
    %3 = llvm.select %arg1, %1, %2 : i1, i16
    llvm.return %3 : i16
  }]

theorem inst_combine_test_srem_orig   : test_srem_orig_before  ⊑  test_srem_orig_combined := by
  unfold test_srem_orig_before test_srem_orig_combined
  simp_alive_peephole
  sorry
def test_srem_combined := [llvmfunc|
  llvm.func @test_srem(%arg0: i16, %arg1: i1) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<[77, 99]> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi16>
    %5 = llvm.srem %4, %2  : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [-1, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %3, %6 : i1, vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }]

theorem inst_combine_test_srem   : test_srem_before  ⊑  test_srem_combined := by
  unfold test_srem_before test_srem_combined
  simp_alive_peephole
  sorry
def test_urem_combined := [llvmfunc|
  llvm.func @test_urem(%arg0: i16, %arg1: i1) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<[77, 99]> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi16>
    %5 = llvm.urem %4, %2  : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [-1, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %3, %6 : i1, vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }]

theorem inst_combine_test_urem   : test_urem_before  ⊑  test_urem_combined := by
  unfold test_urem_before test_urem_combined
  simp_alive_peephole
  sorry
def test_sdiv_combined := [llvmfunc|
  llvm.func @test_sdiv(%arg0: i16, %arg1: i1) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<[77, 99]> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi16>
    %5 = llvm.sdiv %4, %2  : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [-1, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %3, %6 : i1, vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }]

theorem inst_combine_test_sdiv   : test_sdiv_before  ⊑  test_sdiv_combined := by
  unfold test_sdiv_before test_sdiv_combined
  simp_alive_peephole
  sorry
def test_udiv_combined := [llvmfunc|
  llvm.func @test_udiv(%arg0: i16, %arg1: i1) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.mlir.constant(dense<[77, 99]> : vector<2xi16>) : vector<2xi16>
    %4 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi16>
    %5 = llvm.udiv %4, %2  : vector<2xi16>
    %6 = llvm.shufflevector %5, %0 [-1, 0] : vector<2xi16> 
    %7 = llvm.select %arg1, %3, %6 : i1, vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }]

theorem inst_combine_test_udiv   : test_udiv_before  ⊑  test_udiv_combined := by
  unfold test_udiv_before test_udiv_combined
  simp_alive_peephole
  sorry
def test_fdiv_combined := [llvmfunc|
  llvm.func @test_fdiv(%arg0: f32, %arg1: f32, %arg2: i1) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.mlir.constant(dense<[7.700000e+01, 9.900000e+01]> : vector<2xf32>) : vector<2xf32>
    %10 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %11 = llvm.fdiv %10, %8  : vector<2xf32>
    %12 = llvm.select %arg2, %9, %11 : i1, vector<2xf32>
    llvm.return %12 : vector<2xf32>
  }]

theorem inst_combine_test_fdiv   : test_fdiv_before  ⊑  test_fdiv_combined := by
  unfold test_fdiv_before test_fdiv_combined
  simp_alive_peephole
  sorry
def test_frem_combined := [llvmfunc|
  llvm.func @test_frem(%arg0: f32, %arg1: f32, %arg2: i1) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.mlir.constant(dense<[7.700000e+01, 9.900000e+01]> : vector<2xf32>) : vector<2xf32>
    %10 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %11 = llvm.frem %10, %8  : vector<2xf32>
    %12 = llvm.select %arg2, %9, %11 : i1, vector<2xf32>
    llvm.return %12 : vector<2xf32>
  }]

theorem inst_combine_test_frem   : test_frem_before  ⊑  test_frem_combined := by
  unfold test_frem_before test_frem_combined
  simp_alive_peephole
  sorry
