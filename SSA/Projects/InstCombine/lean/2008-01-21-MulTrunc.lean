import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-01-21-MulTrunc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.mul %2, %1  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.trunc %5 : i32 to i16
    llvm.return %6 : i16
  }]

def test1_vec_before := [llvmfunc|
  llvm.func @test1_vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.lshr %2, %0  : vector<2xi32>
    %4 = llvm.mul %2, %1  : vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    %6 = llvm.trunc %5 : vector<2xi32> to vector<2xi16>
    llvm.return %6 : vector<2xi16>
  }]

def test1_vec_nonuniform_before := [llvmfunc|
  llvm.func @test1_vec_nonuniform(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[8, 9]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.lshr %2, %0  : vector<2xi32>
    %4 = llvm.mul %2, %1  : vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    %6 = llvm.trunc %5 : vector<2xi32> to vector<2xi16>
    llvm.return %6 : vector<2xi16>
  }]

def test1_vec_undef_before := [llvmfunc|
  llvm.func @test1_vec_undef(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(5 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %14 = llvm.lshr %13, %6  : vector<2xi32>
    %15 = llvm.mul %13, %12  : vector<2xi32>
    %16 = llvm.or %14, %15  : vector<2xi32>
    %17 = llvm.trunc %16 : vector<2xi32> to vector<2xi16>
    llvm.return %17 : vector<2xi16>
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.mul %arg0, %1  : i16
    %4 = llvm.or %2, %3  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1_vec_combined := [llvmfunc|
  llvm.func @test1_vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.lshr %arg0, %0  : vector<2xi16>
    %3 = llvm.mul %arg0, %1  : vector<2xi16>
    %4 = llvm.or %2, %3  : vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

theorem inst_combine_test1_vec   : test1_vec_before  ⊑  test1_vec_combined := by
  unfold test1_vec_before test1_vec_combined
  simp_alive_peephole
  sorry
def test1_vec_nonuniform_combined := [llvmfunc|
  llvm.func @test1_vec_nonuniform(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[8, 9]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.lshr %arg0, %0  : vector<2xi16>
    %3 = llvm.mul %arg0, %1  : vector<2xi16>
    %4 = llvm.or %2, %3  : vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

theorem inst_combine_test1_vec_nonuniform   : test1_vec_nonuniform_before  ⊑  test1_vec_nonuniform_combined := by
  unfold test1_vec_nonuniform_before test1_vec_nonuniform_combined
  simp_alive_peephole
  sorry
def test1_vec_undef_combined := [llvmfunc|
  llvm.func @test1_vec_undef(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(5 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %14 = llvm.lshr %13, %6  : vector<2xi32>
    %15 = llvm.mul %13, %12  : vector<2xi32>
    %16 = llvm.or %14, %15  : vector<2xi32>
    %17 = llvm.trunc %16 : vector<2xi32> to vector<2xi16>
    llvm.return %17 : vector<2xi16>
  }]

theorem inst_combine_test1_vec_undef   : test1_vec_undef_before  ⊑  test1_vec_undef_combined := by
  unfold test1_vec_undef_before test1_vec_undef_combined
  simp_alive_peephole
  sorry
