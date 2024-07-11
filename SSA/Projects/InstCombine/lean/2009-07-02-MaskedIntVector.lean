import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-07-02-MaskedIntVector
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i64) -> i32 {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<16xi8>) : vector<16xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.bitcast %0 : vector<4xi32> to vector<16xi8>
    %5 = llvm.shufflevector %4, %2 [0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi8> 
    %6 = llvm.bitcast %5 : vector<16xi8> to vector<2xi64>
    %7 = llvm.extractelement %6[%3 : i32] : vector<2xi64>
    %8 = llvm.bitcast %7 : i64 to vector<2xi32>
    %9 = llvm.bitcast %arg0 : i64 to vector<2xi32>
    %10 = llvm.xor %8, %9  : vector<2xi32>
    %11 = llvm.extractelement %10[%3 : i32] : vector<2xi32>
    llvm.return %11 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
