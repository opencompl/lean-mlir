import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  out-of-bounds-indexes
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_out_of_bounds_before := [llvmfunc|
  llvm.func @test_out_of_bounds(%arg0: i32, %arg1: i1, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    "llvm.intr.assume"(%5) : (i1) -> ()
    llvm.return %3 : i32
  }]

def test_non64bit_before := [llvmfunc|
  llvm.func @test_non64bit(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(3 : i128) : i128
    %1 = llvm.mlir.constant(-1 : i128) : i128
    %2 = llvm.mlir.constant(1 : i128) : i128
    %3 = llvm.and %arg0, %0  : i128
    %4 = llvm.lshr %3, %1  : i128
    %5 = llvm.icmp "eq" %4, %2 : i128
    "llvm.intr.assume"(%5) : (i1) -> ()
    llvm.return %3 : i128
  }]

def inselt_bad_index_before := [llvmfunc|
  llvm.func @inselt_bad_index(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(4294967296 : i64) : i64
    %2 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf64>
    llvm.return %2 : vector<4xf64>
  }]

def test_out_of_bounds_combined := [llvmfunc|
  llvm.func @test_out_of_bounds(%arg0: i32, %arg1: i1, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : !llvm.ptr
    %2 = llvm.mlir.poison : i32
    llvm.store %0, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i32
  }]

theorem inst_combine_test_out_of_bounds   : test_out_of_bounds_before  ⊑  test_out_of_bounds_combined := by
  unfold test_out_of_bounds_before test_out_of_bounds_combined
  simp_alive_peephole
  sorry
def test_non64bit_combined := [llvmfunc|
  llvm.func @test_non64bit(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : !llvm.ptr
    %2 = llvm.mlir.poison : i128
    llvm.store %0, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i128
  }]

theorem inst_combine_test_non64bit   : test_non64bit_before  ⊑  test_non64bit_combined := by
  unfold test_non64bit_before test_non64bit_combined
  simp_alive_peephole
  sorry
def inselt_bad_index_combined := [llvmfunc|
  llvm.func @inselt_bad_index(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<4xf64>
    llvm.return %0 : vector<4xf64>
  }]

theorem inst_combine_inselt_bad_index   : inselt_bad_index_before  ⊑  inselt_bad_index_combined := by
  unfold inselt_bad_index_before inselt_bad_index_combined
  simp_alive_peephole
  sorry
