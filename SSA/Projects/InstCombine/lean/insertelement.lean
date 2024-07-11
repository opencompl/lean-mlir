import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  insertelement
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def insert_known_idx_before := [llvmfunc|
  llvm.func @insert_known_idx(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.insertelement %1, %3[%2 : i32] : vector<4xi32>
    %5 = llvm.and %4, %0  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def insert_unknown_idx_before := [llvmfunc|
  llvm.func @insert_unknown_idx(%arg0: vector<4xi32>, %arg1: i32) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.and %arg0, %0  : vector<4xi32>
    %3 = llvm.insertelement %1, %2[%arg1 : i32] : vector<4xi32>
    %4 = llvm.and %3, %0  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def insert_known_any_idx_before := [llvmfunc|
  llvm.func @insert_known_any_idx(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.insertelement %3, %2[%arg2 : i32] : vector<2xi8>
    %5 = llvm.and %4, %0  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def insert_known_any_idx_fail1_before := [llvmfunc|
  llvm.func @insert_known_any_idx_fail1(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[17, 33]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.or %arg0, %0  : vector<2xi8>
    %4 = llvm.or %arg1, %1  : i8
    %5 = llvm.insertelement %4, %3[%arg2 : i32] : vector<2xi8>
    %6 = llvm.and %5, %2  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

def insert_known_any_idx_fail2_before := [llvmfunc|
  llvm.func @insert_known_any_idx_fail2(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[17, 31]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.or %arg0, %0  : vector<2xi8>
    %4 = llvm.or %arg1, %1  : i8
    %5 = llvm.insertelement %4, %3[%arg2 : i32] : vector<2xi8>
    %6 = llvm.and %5, %2  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

def insert_known_idx_combined := [llvmfunc|
  llvm.func @insert_known_idx(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(6 : i32) : i32
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.and %arg0, %10  : vector<4xi32>
    %14 = llvm.insertelement %11, %13[%12 : i64] : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

theorem inst_combine_insert_known_idx   : insert_known_idx_before  ⊑  insert_known_idx_combined := by
  unfold insert_known_idx_before insert_known_idx_combined
  simp_alive_peephole
  sorry
def insert_unknown_idx_combined := [llvmfunc|
  llvm.func @insert_unknown_idx(%arg0: vector<4xi32>, %arg1: i32) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.and %arg0, %0  : vector<4xi32>
    %3 = llvm.insertelement %1, %2[%arg1 : i32] : vector<4xi32>
    %4 = llvm.and %3, %0  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_insert_unknown_idx   : insert_unknown_idx_before  ⊑  insert_unknown_idx_combined := by
  unfold insert_unknown_idx_before insert_unknown_idx_combined
  simp_alive_peephole
  sorry
def insert_known_any_idx_combined := [llvmfunc|
  llvm.func @insert_known_any_idx(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.insertelement %3, %2[%arg2 : i32] : vector<2xi8>
    %5 = llvm.and %4, %0  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

theorem inst_combine_insert_known_any_idx   : insert_known_any_idx_before  ⊑  insert_known_any_idx_combined := by
  unfold insert_known_any_idx_before insert_known_any_idx_combined
  simp_alive_peephole
  sorry
def insert_known_any_idx_fail1_combined := [llvmfunc|
  llvm.func @insert_known_any_idx_fail1(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[17, 33]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.or %arg0, %0  : vector<2xi8>
    %4 = llvm.or %arg1, %1  : i8
    %5 = llvm.insertelement %4, %3[%arg2 : i32] : vector<2xi8>
    %6 = llvm.and %5, %2  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_insert_known_any_idx_fail1   : insert_known_any_idx_fail1_before  ⊑  insert_known_any_idx_fail1_combined := by
  unfold insert_known_any_idx_fail1_before insert_known_any_idx_fail1_combined
  simp_alive_peephole
  sorry
def insert_known_any_idx_fail2_combined := [llvmfunc|
  llvm.func @insert_known_any_idx_fail2(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[17, 31]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.or %arg0, %0  : vector<2xi8>
    %4 = llvm.or %arg1, %1  : i8
    %5 = llvm.insertelement %4, %3[%arg2 : i32] : vector<2xi8>
    %6 = llvm.and %5, %2  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_insert_known_any_idx_fail2   : insert_known_any_idx_fail2_before  ⊑  insert_known_any_idx_fail2_combined := by
  unfold insert_known_any_idx_fail2_before insert_known_any_idx_fail2_combined
  simp_alive_peephole
  sorry
