import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr14365
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test0_before := [llvmfunc|
  llvm.func @test0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1431655765 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %4, %2 overflow<nsw>  : i32
    %6 = llvm.add %arg0, %5 overflow<nsw>  : i32
    llvm.return %6 : i32
  }]

def test0_vec_before := [llvmfunc|
  llvm.func @test0_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1431655765> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.xor %3, %1  : vector<4xi32>
    %5 = llvm.add %4, %2 overflow<nsw>  : vector<4xi32>
    %6 = llvm.add %arg0, %5 overflow<nsw>  : vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1431655765 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.ashr %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.xor %4, %2  : i32
    %6 = llvm.add %5, %0 overflow<nsw>  : i32
    %7 = llvm.add %arg0, %6 overflow<nsw>  : i32
    llvm.return %7 : i32
  }]

def test1_vec_before := [llvmfunc|
  llvm.func @test1_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1431655765> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.ashr %arg0, %0  : vector<4xi32>
    %4 = llvm.and %3, %1  : vector<4xi32>
    %5 = llvm.xor %4, %2  : vector<4xi32>
    %6 = llvm.add %5, %0 overflow<nsw>  : vector<4xi32>
    %7 = llvm.add %arg0, %6 overflow<nsw>  : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

def test0_combined := [llvmfunc|
  llvm.func @test0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1431655766 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test0   : test0_before  ⊑  test0_combined := by
  unfold test0_before test0_combined
  simp_alive_peephole
  sorry
def test0_vec_combined := [llvmfunc|
  llvm.func @test0_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1431655766> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.and %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_test0_vec   : test0_vec_before  ⊑  test0_vec_combined := by
  unfold test0_vec_before test0_vec_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1431655765 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.sub %arg0, %3 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1_vec_combined := [llvmfunc|
  llvm.func @test1_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1431655765> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %arg0, %0  : vector<4xi32>
    %3 = llvm.and %2, %1  : vector<4xi32>
    %4 = llvm.sub %arg0, %3 overflow<nsw>  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_test1_vec   : test1_vec_before  ⊑  test1_vec_combined := by
  unfold test1_vec_before test1_vec_combined
  simp_alive_peephole
  sorry
