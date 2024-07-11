import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shufflevector_freezepoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def shuffle_op0_freeze_poison_before := [llvmfunc|
  llvm.func @shuffle_op0_freeze_poison(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

def shuffle_op1_freeze_poison_before := [llvmfunc|
  llvm.func @shuffle_op1_freeze_poison(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

def shuffle_op0_freeze_poison_use_before := [llvmfunc|
  llvm.func @shuffle_op0_freeze_poison_use(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    llvm.call @use(%1) : (vector<2xf64>) -> ()
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

def shuffle_op1_freeze_poison_use_before := [llvmfunc|
  llvm.func @shuffle_op1_freeze_poison_use(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    llvm.call @use(%1) : (vector<2xf64>) -> ()
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

def shuffle_op0_freeze_undef_before := [llvmfunc|
  llvm.func @shuffle_op0_freeze_undef(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    llvm.call @use(%1) : (vector<2xf64>) -> ()
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

def shuffle_op1_freeze_undef_before := [llvmfunc|
  llvm.func @shuffle_op1_freeze_undef(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    llvm.call @use(%1) : (vector<2xf64>) -> ()
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

def shuffle_bc1_before := [llvmfunc|
  llvm.func @shuffle_bc1(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.freeze %0 : vector<4xf32>
    %2 = llvm.bitcast %1 : vector<4xf32> to vector<2xf64>
    %3 = llvm.shufflevector %arg0, %2 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %3 : vector<4xf64>
  }]

def shuffle_bc2_before := [llvmfunc|
  llvm.func @shuffle_bc2(%arg0: vector<4xf32>) -> vector<8xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.freeze %0 : vector<4xf32>
    %2 = llvm.bitcast %1 : vector<4xf32> to vector<2xf64>
    llvm.call @use(%2) : (vector<2xf64>) -> ()
    %3 = llvm.bitcast %2 : vector<2xf64> to vector<4xf32>
    %4 = llvm.shufflevector %arg0, %3 [0, 1, 2, 3, 4, 5, 6, 7] : vector<4xf32> 
    llvm.return %4 : vector<8xf32>
  }]

def shuffle_op0_freeze_poison_combined := [llvmfunc|
  llvm.func @shuffle_op0_freeze_poison(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

theorem inst_combine_shuffle_op0_freeze_poison   : shuffle_op0_freeze_poison_before  ⊑  shuffle_op0_freeze_poison_combined := by
  unfold shuffle_op0_freeze_poison_before shuffle_op0_freeze_poison_combined
  simp_alive_peephole
  sorry
def shuffle_op1_freeze_poison_combined := [llvmfunc|
  llvm.func @shuffle_op1_freeze_poison(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

theorem inst_combine_shuffle_op1_freeze_poison   : shuffle_op1_freeze_poison_before  ⊑  shuffle_op1_freeze_poison_combined := by
  unfold shuffle_op1_freeze_poison_before shuffle_op1_freeze_poison_combined
  simp_alive_peephole
  sorry
def shuffle_op0_freeze_poison_use_combined := [llvmfunc|
  llvm.func @shuffle_op0_freeze_poison_use(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    llvm.call @use(%1) : (vector<2xf64>) -> ()
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

theorem inst_combine_shuffle_op0_freeze_poison_use   : shuffle_op0_freeze_poison_use_before  ⊑  shuffle_op0_freeze_poison_use_combined := by
  unfold shuffle_op0_freeze_poison_use_before shuffle_op0_freeze_poison_use_combined
  simp_alive_peephole
  sorry
def shuffle_op1_freeze_poison_use_combined := [llvmfunc|
  llvm.func @shuffle_op1_freeze_poison_use(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    llvm.call @use(%1) : (vector<2xf64>) -> ()
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

theorem inst_combine_shuffle_op1_freeze_poison_use   : shuffle_op1_freeze_poison_use_before  ⊑  shuffle_op1_freeze_poison_use_combined := by
  unfold shuffle_op1_freeze_poison_use_before shuffle_op1_freeze_poison_use_combined
  simp_alive_peephole
  sorry
def shuffle_op0_freeze_undef_combined := [llvmfunc|
  llvm.func @shuffle_op0_freeze_undef(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    llvm.call @use(%1) : (vector<2xf64>) -> ()
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

theorem inst_combine_shuffle_op0_freeze_undef   : shuffle_op0_freeze_undef_before  ⊑  shuffle_op0_freeze_undef_combined := by
  unfold shuffle_op0_freeze_undef_before shuffle_op0_freeze_undef_combined
  simp_alive_peephole
  sorry
def shuffle_op1_freeze_undef_combined := [llvmfunc|
  llvm.func @shuffle_op1_freeze_undef(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.freeze %0 : vector<2xf64>
    llvm.call @use(%1) : (vector<2xf64>) -> ()
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

theorem inst_combine_shuffle_op1_freeze_undef   : shuffle_op1_freeze_undef_before  ⊑  shuffle_op1_freeze_undef_combined := by
  unfold shuffle_op1_freeze_undef_before shuffle_op1_freeze_undef_combined
  simp_alive_peephole
  sorry
def shuffle_bc1_combined := [llvmfunc|
  llvm.func @shuffle_bc1(%arg0: vector<2xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.freeze %0 : vector<4xf32>
    %2 = llvm.bitcast %1 : vector<4xf32> to vector<2xf64>
    %3 = llvm.shufflevector %arg0, %2 [0, 1, 2, 3] : vector<2xf64> 
    llvm.return %3 : vector<4xf64>
  }]

theorem inst_combine_shuffle_bc1   : shuffle_bc1_before  ⊑  shuffle_bc1_combined := by
  unfold shuffle_bc1_before shuffle_bc1_combined
  simp_alive_peephole
  sorry
def shuffle_bc2_combined := [llvmfunc|
  llvm.func @shuffle_bc2(%arg0: vector<4xf32>) -> vector<8xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.freeze %0 : vector<4xf32>
    %2 = llvm.bitcast %1 : vector<4xf32> to vector<2xf64>
    llvm.call @use(%2) : (vector<2xf64>) -> ()
    %3 = llvm.shufflevector %arg0, %1 [0, 1, 2, 3, 4, 5, 6, 7] : vector<4xf32> 
    llvm.return %3 : vector<8xf32>
  }]

theorem inst_combine_shuffle_bc2   : shuffle_bc2_before  ⊑  shuffle_bc2_combined := by
  unfold shuffle_bc2_before shuffle_bc2_combined
  simp_alive_peephole
  sorry
