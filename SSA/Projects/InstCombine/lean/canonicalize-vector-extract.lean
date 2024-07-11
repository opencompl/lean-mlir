import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize-vector-extract
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def trivial_nop_before := [llvmfunc|
  llvm.func @trivial_nop(%arg0: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.intr.vector.extract %arg0[0] : vector<8xi32> from vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }]

def trivial_nop_scalable_before := [llvmfunc|
  llvm.func @trivial_nop_scalable(%arg0: !llvm.vec<? x 8 x  i32>) -> !llvm.vec<? x 8 x  i32> {
    %0 = llvm.intr.vector.extract %arg0[0] : !llvm.vec<? x 8 x  i32> from !llvm.vec<? x 8 x  i32>
    llvm.return %0 : !llvm.vec<? x 8 x  i32>
  }]

def valid_extraction_a_before := [llvmfunc|
  llvm.func @valid_extraction_a(%arg0: vector<8xi32>) -> vector<2xi32> {
    %0 = llvm.intr.vector.extract %arg0[0] : vector<2xi32> from vector<8xi32>
    llvm.return %0 : vector<2xi32>
  }]

def valid_extraction_b_before := [llvmfunc|
  llvm.func @valid_extraction_b(%arg0: vector<8xi32>) -> vector<2xi32> {
    %0 = llvm.intr.vector.extract %arg0[2] : vector<2xi32> from vector<8xi32>
    llvm.return %0 : vector<2xi32>
  }]

def valid_extraction_c_before := [llvmfunc|
  llvm.func @valid_extraction_c(%arg0: vector<8xi32>) -> vector<2xi32> {
    %0 = llvm.intr.vector.extract %arg0[4] : vector<2xi32> from vector<8xi32>
    llvm.return %0 : vector<2xi32>
  }]

def valid_extraction_d_before := [llvmfunc|
  llvm.func @valid_extraction_d(%arg0: vector<8xi32>) -> vector<2xi32> {
    %0 = llvm.intr.vector.extract %arg0[6] : vector<2xi32> from vector<8xi32>
    llvm.return %0 : vector<2xi32>
  }]

def valid_extraction_e_before := [llvmfunc|
  llvm.func @valid_extraction_e(%arg0: vector<8xi32>) -> vector<4xi32> {
    %0 = llvm.intr.vector.extract %arg0[0] : vector<4xi32> from vector<8xi32>
    llvm.return %0 : vector<4xi32>
  }]

def valid_extraction_f_before := [llvmfunc|
  llvm.func @valid_extraction_f(%arg0: vector<8xi32>) -> vector<4xi32> {
    %0 = llvm.intr.vector.extract %arg0[4] : vector<4xi32> from vector<8xi32>
    llvm.return %0 : vector<4xi32>
  }]

def valid_extraction_g_before := [llvmfunc|
  llvm.func @valid_extraction_g(%arg0: vector<8xi32>) -> vector<3xi32> {
    %0 = llvm.intr.vector.extract %arg0[0] : vector<3xi32> from vector<8xi32>
    llvm.return %0 : vector<3xi32>
  }]

def valid_extraction_h_before := [llvmfunc|
  llvm.func @valid_extraction_h(%arg0: vector<8xi32>) -> vector<3xi32> {
    %0 = llvm.intr.vector.extract %arg0[3] : vector<3xi32> from vector<8xi32>
    llvm.return %0 : vector<3xi32>
  }]

def scalable_extract_before := [llvmfunc|
  llvm.func @scalable_extract(%arg0: !llvm.vec<? x 4 x  i32>) -> vector<4xi32> {
    %0 = llvm.intr.vector.extract %arg0[0] : vector<4xi32> from !llvm.vec<? x 4 x  i32>
    llvm.return %0 : vector<4xi32>
  }]

def trivial_nop_combined := [llvmfunc|
  llvm.func @trivial_nop(%arg0: vector<8xi32>) -> vector<8xi32> {
    llvm.return %arg0 : vector<8xi32>
  }]

theorem inst_combine_trivial_nop   : trivial_nop_before  ⊑  trivial_nop_combined := by
  unfold trivial_nop_before trivial_nop_combined
  simp_alive_peephole
  sorry
def trivial_nop_scalable_combined := [llvmfunc|
  llvm.func @trivial_nop_scalable(%arg0: !llvm.vec<? x 8 x  i32>) -> !llvm.vec<? x 8 x  i32> {
    llvm.return %arg0 : !llvm.vec<? x 8 x  i32>
  }]

theorem inst_combine_trivial_nop_scalable   : trivial_nop_scalable_before  ⊑  trivial_nop_scalable_combined := by
  unfold trivial_nop_scalable_before trivial_nop_scalable_combined
  simp_alive_peephole
  sorry
def valid_extraction_a_combined := [llvmfunc|
  llvm.func @valid_extraction_a(%arg0: vector<8xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 1] : vector<8xi32> 
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_valid_extraction_a   : valid_extraction_a_before  ⊑  valid_extraction_a_combined := by
  unfold valid_extraction_a_before valid_extraction_a_combined
  simp_alive_peephole
  sorry
def valid_extraction_b_combined := [llvmfunc|
  llvm.func @valid_extraction_b(%arg0: vector<8xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %0 [2, 3] : vector<8xi32> 
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_valid_extraction_b   : valid_extraction_b_before  ⊑  valid_extraction_b_combined := by
  unfold valid_extraction_b_before valid_extraction_b_combined
  simp_alive_peephole
  sorry
def valid_extraction_c_combined := [llvmfunc|
  llvm.func @valid_extraction_c(%arg0: vector<8xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %0 [4, 5] : vector<8xi32> 
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_valid_extraction_c   : valid_extraction_c_before  ⊑  valid_extraction_c_combined := by
  unfold valid_extraction_c_before valid_extraction_c_combined
  simp_alive_peephole
  sorry
def valid_extraction_d_combined := [llvmfunc|
  llvm.func @valid_extraction_d(%arg0: vector<8xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %0 [6, 7] : vector<8xi32> 
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_valid_extraction_d   : valid_extraction_d_before  ⊑  valid_extraction_d_combined := by
  unfold valid_extraction_d_before valid_extraction_d_combined
  simp_alive_peephole
  sorry
def valid_extraction_e_combined := [llvmfunc|
  llvm.func @valid_extraction_e(%arg0: vector<8xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3] : vector<8xi32> 
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_valid_extraction_e   : valid_extraction_e_before  ⊑  valid_extraction_e_combined := by
  unfold valid_extraction_e_before valid_extraction_e_combined
  simp_alive_peephole
  sorry
def valid_extraction_f_combined := [llvmfunc|
  llvm.func @valid_extraction_f(%arg0: vector<8xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %0 [4, 5, 6, 7] : vector<8xi32> 
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_valid_extraction_f   : valid_extraction_f_before  ⊑  valid_extraction_f_combined := by
  unfold valid_extraction_f_before valid_extraction_f_combined
  simp_alive_peephole
  sorry
def valid_extraction_g_combined := [llvmfunc|
  llvm.func @valid_extraction_g(%arg0: vector<8xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 2] : vector<8xi32> 
    llvm.return %1 : vector<3xi32>
  }]

theorem inst_combine_valid_extraction_g   : valid_extraction_g_before  ⊑  valid_extraction_g_combined := by
  unfold valid_extraction_g_before valid_extraction_g_combined
  simp_alive_peephole
  sorry
def valid_extraction_h_combined := [llvmfunc|
  llvm.func @valid_extraction_h(%arg0: vector<8xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.shufflevector %arg0, %0 [3, 4, 5] : vector<8xi32> 
    llvm.return %1 : vector<3xi32>
  }]

theorem inst_combine_valid_extraction_h   : valid_extraction_h_before  ⊑  valid_extraction_h_combined := by
  unfold valid_extraction_h_before valid_extraction_h_combined
  simp_alive_peephole
  sorry
def scalable_extract_combined := [llvmfunc|
  llvm.func @scalable_extract(%arg0: !llvm.vec<? x 4 x  i32>) -> vector<4xi32> {
    %0 = llvm.intr.vector.extract %arg0[0] : vector<4xi32> from !llvm.vec<? x 4 x  i32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_scalable_extract   : scalable_extract_before  ⊑  scalable_extract_combined := by
  unfold scalable_extract_before scalable_extract_combined
  simp_alive_peephole
  sorry
