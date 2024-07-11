import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  udiv_select_to_select_shift
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.select %arg1, %0, %1 : i1, i64
    %4 = llvm.udiv %arg0, %3  : i64
    %5 = llvm.select %arg1, %1, %2 : i1, i64
    %6 = llvm.udiv %arg0, %5  : i64
    %7 = llvm.add %4, %6  : i64
    llvm.return %7 : i64
  }]

def PR34856_before := [llvmfunc|
  llvm.func @PR34856(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<-7> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    %6 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi32>
    %7 = llvm.udiv %arg1, %6  : vector<2xi32>
    %8 = llvm.add %7, %5  : vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.add %2, %3 overflow<nsw, nuw>  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def PR34856_combined := [llvmfunc|
  llvm.func @PR34856(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg1, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_PR34856   : PR34856_before  ⊑  PR34856_combined := by
  unfold PR34856_before PR34856_combined
  simp_alive_peephole
  sorry
