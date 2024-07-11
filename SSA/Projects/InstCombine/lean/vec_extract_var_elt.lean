import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vec_extract_var_elt
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: f32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.undef : vector<8xi32>
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.load %arg1 {alignment = 32 : i64} : !llvm.ptr -> vector<8xf32>]

    %4 = llvm.bitcast %3 : vector<8xf32> to vector<8xi32>
    %5 = llvm.bitcast %4 : vector<8xi32> to vector<8xf32>
    %6 = llvm.fptosi %5 : vector<8xf32> to vector<8xi32>
    %7 = llvm.fptosi %arg0 : f32 to i32
    %8 = llvm.add %7, %0  : i32
    %9 = llvm.extractelement %6[%8 : i32] : vector<8xi32>
    %10 = llvm.insertelement %9, %1[%2 : i32] : vector<8xi32>
    %11 = llvm.sitofp %10 : vector<8xi32> to vector<8xf32>
    llvm.store %11, %arg1 {alignment = 32 : i64} : vector<8xf32>, !llvm.ptr]

    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.bitcast %0 : vector<2xi64> to vector<4xi32>
    %2 = llvm.extractelement %1[%arg0 : i32] : vector<4xi32>
    llvm.return %2 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: f32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<8xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<8xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<8xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<8xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %2, %9[%10 : i32] : vector<8xi32>
    %12 = llvm.mlir.constant(4 : i32) : i32
    %13 = llvm.insertelement %2, %11[%12 : i32] : vector<8xi32>
    %14 = llvm.mlir.constant(5 : i32) : i32
    %15 = llvm.insertelement %2, %13[%14 : i32] : vector<8xi32>
    %16 = llvm.mlir.constant(6 : i32) : i32
    %17 = llvm.insertelement %2, %15[%16 : i32] : vector<8xi32>
    %18 = llvm.mlir.constant(7 : i32) : i32
    %19 = llvm.insertelement %1, %17[%18 : i32] : vector<8xi32>
    %20 = llvm.mlir.constant(7 : i64) : i64
    %21 = llvm.load %arg1 {alignment = 32 : i64} : !llvm.ptr -> vector<8xf32>
    %22 = llvm.fptosi %arg0 : f32 to i32
    %23 = llvm.add %22, %0  : i32
    %24 = llvm.extractelement %21[%23 : i32] : vector<8xf32>
    %25 = llvm.fptosi %24 : f32 to i32
    %26 = llvm.insertelement %25, %19[%20 : i64] : vector<8xi32>
    %27 = llvm.sitofp %26 : vector<8xi32> to vector<8xf32>
    llvm.store %27, %arg1 {alignment = 32 : i64} : vector<8xf32>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 0, 2, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.extractelement %0[%arg0 : i32] : vector<4xi32>
    llvm.return %1 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
