import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize-vector-insert
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def trivial_nop_before := [llvmfunc|
  llvm.func @trivial_nop(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[0] : vector<8xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }]

def valid_insertion_a_before := [llvmfunc|
  llvm.func @valid_insertion_a(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[0] : vector<2xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }]

def valid_insertion_b_before := [llvmfunc|
  llvm.func @valid_insertion_b(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[2] : vector<2xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }]

def valid_insertion_c_before := [llvmfunc|
  llvm.func @valid_insertion_c(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[4] : vector<2xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }]

def valid_insertion_d_before := [llvmfunc|
  llvm.func @valid_insertion_d(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[6] : vector<2xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }]

def valid_insertion_e_before := [llvmfunc|
  llvm.func @valid_insertion_e(%arg0: vector<8xi32>, %arg1: vector<4xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[0] : vector<4xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }]

def valid_insertion_f_before := [llvmfunc|
  llvm.func @valid_insertion_f(%arg0: vector<8xi32>, %arg1: vector<4xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[4] : vector<4xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }]

def valid_insertion_g_before := [llvmfunc|
  llvm.func @valid_insertion_g(%arg0: vector<8xi32>, %arg1: vector<3xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[0] : vector<3xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }]

def valid_insertion_h_before := [llvmfunc|
  llvm.func @valid_insertion_h(%arg0: vector<8xi32>, %arg1: vector<3xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[3] : vector<3xi32> into vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }]

def scalable_insert_before := [llvmfunc|
  llvm.func @scalable_insert(%arg0: !llvm.vec<? x 4 x  i32>, %arg1: vector<4xi32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[0] : vector<4xi32> into !llvm.vec<? x 4 x  i32>
    llvm.return %0 : !llvm.vec<? x 4 x  i32>
  }]

def trivial_nop_combined := [llvmfunc|
  llvm.func @trivial_nop(%arg0: vector<8xi32>, %arg1: vector<8xi32>) -> vector<8xi32> {
    llvm.return %arg1 : vector<8xi32>
  }]

theorem inst_combine_trivial_nop   : trivial_nop_before  ⊑  trivial_nop_combined := by
  unfold trivial_nop_before trivial_nop_combined
  simp_alive_peephole
  sorry
def valid_insertion_a_combined := [llvmfunc|
  llvm.func @valid_insertion_a(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg1, %0 [0, 1, -1, -1, -1, -1, -1, -1] : vector<2xi32> 
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 10, 11, 12, 13, 14, 15] : vector<8xi32> 
    llvm.return %2 : vector<8xi32>
  }]

theorem inst_combine_valid_insertion_a   : valid_insertion_a_before  ⊑  valid_insertion_a_combined := by
  unfold valid_insertion_a_before valid_insertion_a_combined
  simp_alive_peephole
  sorry
def valid_insertion_b_combined := [llvmfunc|
  llvm.func @valid_insertion_b(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg1, %0 [0, 1, -1, -1, -1, -1, -1, -1] : vector<2xi32> 
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 8, 9, 4, 5, 6, 7] : vector<8xi32> 
    llvm.return %2 : vector<8xi32>
  }]

theorem inst_combine_valid_insertion_b   : valid_insertion_b_before  ⊑  valid_insertion_b_combined := by
  unfold valid_insertion_b_before valid_insertion_b_combined
  simp_alive_peephole
  sorry
def valid_insertion_c_combined := [llvmfunc|
  llvm.func @valid_insertion_c(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg1, %0 [0, 1, -1, -1, -1, -1, -1, -1] : vector<2xi32> 
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 3, 8, 9, 6, 7] : vector<8xi32> 
    llvm.return %2 : vector<8xi32>
  }]

theorem inst_combine_valid_insertion_c   : valid_insertion_c_before  ⊑  valid_insertion_c_combined := by
  unfold valid_insertion_c_before valid_insertion_c_combined
  simp_alive_peephole
  sorry
def valid_insertion_d_combined := [llvmfunc|
  llvm.func @valid_insertion_d(%arg0: vector<8xi32>, %arg1: vector<2xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg1, %0 [0, 1, -1, -1, -1, -1, -1, -1] : vector<2xi32> 
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 3, 4, 5, 8, 9] : vector<8xi32> 
    llvm.return %2 : vector<8xi32>
  }]

theorem inst_combine_valid_insertion_d   : valid_insertion_d_before  ⊑  valid_insertion_d_combined := by
  unfold valid_insertion_d_before valid_insertion_d_combined
  simp_alive_peephole
  sorry
def valid_insertion_e_combined := [llvmfunc|
  llvm.func @valid_insertion_e(%arg0: vector<8xi32>, %arg1: vector<4xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg1, %0 [0, 1, 2, 3, -1, -1, -1, -1] : vector<4xi32> 
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 3, 12, 13, 14, 15] : vector<8xi32> 
    llvm.return %2 : vector<8xi32>
  }]

theorem inst_combine_valid_insertion_e   : valid_insertion_e_before  ⊑  valid_insertion_e_combined := by
  unfold valid_insertion_e_before valid_insertion_e_combined
  simp_alive_peephole
  sorry
def valid_insertion_f_combined := [llvmfunc|
  llvm.func @valid_insertion_f(%arg0: vector<8xi32>, %arg1: vector<4xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg1, %0 [0, 1, 2, 3, -1, -1, -1, -1] : vector<4xi32> 
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 3, 8, 9, 10, 11] : vector<8xi32> 
    llvm.return %2 : vector<8xi32>
  }]

theorem inst_combine_valid_insertion_f   : valid_insertion_f_before  ⊑  valid_insertion_f_combined := by
  unfold valid_insertion_f_before valid_insertion_f_combined
  simp_alive_peephole
  sorry
def valid_insertion_g_combined := [llvmfunc|
  llvm.func @valid_insertion_g(%arg0: vector<8xi32>, %arg1: vector<3xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.poison : vector<3xi32>
    %1 = llvm.shufflevector %arg1, %0 [0, 1, 2, -1, -1, -1, -1, -1] : vector<3xi32> 
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 11, 12, 13, 14, 15] : vector<8xi32> 
    llvm.return %2 : vector<8xi32>
  }]

theorem inst_combine_valid_insertion_g   : valid_insertion_g_before  ⊑  valid_insertion_g_combined := by
  unfold valid_insertion_g_before valid_insertion_g_combined
  simp_alive_peephole
  sorry
def valid_insertion_h_combined := [llvmfunc|
  llvm.func @valid_insertion_h(%arg0: vector<8xi32>, %arg1: vector<3xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.poison : vector<3xi32>
    %1 = llvm.shufflevector %arg1, %0 [0, 1, 2, -1, -1, -1, -1, -1] : vector<3xi32> 
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 8, 9, 10, 6, 7] : vector<8xi32> 
    llvm.return %2 : vector<8xi32>
  }]

theorem inst_combine_valid_insertion_h   : valid_insertion_h_before  ⊑  valid_insertion_h_combined := by
  unfold valid_insertion_h_before valid_insertion_h_combined
  simp_alive_peephole
  sorry
def scalable_insert_combined := [llvmfunc|
  llvm.func @scalable_insert(%arg0: !llvm.vec<? x 4 x  i32>, %arg1: vector<4xi32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[0] : vector<4xi32> into !llvm.vec<? x 4 x  i32>
    llvm.return %0 : !llvm.vec<? x 4 x  i32>
  }]

theorem inst_combine_scalable_insert   : scalable_insert_before  ⊑  scalable_insert_combined := by
  unfold scalable_insert_before scalable_insert_combined
  simp_alive_peephole
  sorry
