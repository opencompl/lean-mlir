import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shuffle-select-narrow-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def narrow_shuffle_of_select_before := [llvmfunc|
  llvm.func @narrow_shuffle_of_select(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xi8>
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi8> 
    llvm.return %4 : vector<2xi8>
  }]

def narrow_shuffle_of_select_overspecified_extend_before := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_overspecified_extend(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, 0, 1] : vector<2xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xi8>
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi8> 
    llvm.return %4 : vector<2xi8>
  }]

def narrow_shuffle_of_select_undefs_before := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_undefs(%arg0: vector<3xi1>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.poison : vector<3xi1>
    %1 = llvm.mlir.poison : vector<4xf32>
    %2 = llvm.shufflevector %arg0, %0 [-1, 1, 2, -1] : vector<3xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xf32>
    %4 = llvm.shufflevector %3, %1 [0, 1, -1] : vector<4xf32> 
    llvm.return %4 : vector<3xf32>
  }]

def narrow_shuffle_of_select_use1_before := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_use1(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xi8>
    llvm.call @use(%3) : (vector<4xi8>) -> ()
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi8> 
    llvm.return %4 : vector<2xi8>
  }]

def narrow_shuffle_of_select_use2_before := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_use2(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi1> 
    llvm.call @use_cmp(%2) : (vector<4xi1>) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xi8>
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi8> 
    llvm.return %4 : vector<2xi8>
  }]

def narrow_shuffle_of_select_mismatch_types1_before := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_mismatch_types1(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xi8>
    %4 = llvm.shufflevector %3, %1 [0, 1, 2] : vector<4xi8> 
    llvm.return %4 : vector<3xi8>
  }]

def narrow_shuffle_of_select_mismatch_types2_before := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_mismatch_types2(%arg0: vector<4xi1>, %arg1: vector<6xi8>, %arg2: vector<6xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<4xi1>
    %1 = llvm.mlir.poison : vector<6xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, 2, 3, -1, -1] : vector<4xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<6xi1>, vector<6xi8>
    %4 = llvm.shufflevector %3, %1 [0, 1, 2] : vector<6xi8> 
    llvm.return %4 : vector<3xi8>
  }]

def narrow_shuffle_of_select_consts_before := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_consts(%arg0: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.constant(dense<[-1, -2, -3, -4]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.poison : vector<4xi8>
    %4 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi1> 
    %5 = llvm.select %4, %1, %2 : vector<4xi1>, vector<4xi8>
    %6 = llvm.shufflevector %5, %3 [0, 1] : vector<4xi8> 
    llvm.return %6 : vector<2xi8>
  }]

def narrow_shuffle_of_select_with_widened_ops_before := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_with_widened_ops(%arg0: vector<2xi1>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.poison : vector<2xi1>
    %2 = llvm.mlir.poison : vector<4xi8>
    %3 = llvm.shufflevector %arg1, %0 [0, 1, -1, -1] : vector<2xi8> 
    %4 = llvm.shufflevector %arg2, %0 [0, 1, -1, -1] : vector<2xi8> 
    %5 = llvm.shufflevector %arg0, %1 [0, 1, -1, -1] : vector<2xi1> 
    %6 = llvm.select %5, %3, %4 : vector<4xi1>, vector<4xi8>
    %7 = llvm.shufflevector %6, %2 [0, 1] : vector<4xi8> 
    llvm.return %7 : vector<2xi8>
  }]

def narrow_shuffle_of_select_combined := [llvmfunc|
  llvm.func @narrow_shuffle_of_select(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg1, %0 [0, 1] : vector<4xi8> 
    %2 = llvm.shufflevector %arg2, %0 [0, 1] : vector<4xi8> 
    %3 = llvm.select %arg0, %1, %2 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_narrow_shuffle_of_select   : narrow_shuffle_of_select_before  ⊑  narrow_shuffle_of_select_combined := by
  unfold narrow_shuffle_of_select_before narrow_shuffle_of_select_combined
  simp_alive_peephole
  sorry
def narrow_shuffle_of_select_overspecified_extend_combined := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_overspecified_extend(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg1, %0 [0, 1] : vector<4xi8> 
    %2 = llvm.shufflevector %arg2, %0 [0, 1] : vector<4xi8> 
    %3 = llvm.select %arg0, %1, %2 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_narrow_shuffle_of_select_overspecified_extend   : narrow_shuffle_of_select_overspecified_extend_before  ⊑  narrow_shuffle_of_select_overspecified_extend_combined := by
  unfold narrow_shuffle_of_select_overspecified_extend_before narrow_shuffle_of_select_overspecified_extend_combined
  simp_alive_peephole
  sorry
def narrow_shuffle_of_select_undefs_combined := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_undefs(%arg0: vector<3xi1>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg1, %0 [0, 1, -1] : vector<4xf32> 
    %2 = llvm.shufflevector %arg2, %0 [0, 1, -1] : vector<4xf32> 
    %3 = llvm.select %arg0, %1, %2 : vector<3xi1>, vector<3xf32>
    llvm.return %3 : vector<3xf32>
  }]

theorem inst_combine_narrow_shuffle_of_select_undefs   : narrow_shuffle_of_select_undefs_before  ⊑  narrow_shuffle_of_select_undefs_combined := by
  unfold narrow_shuffle_of_select_undefs_before narrow_shuffle_of_select_undefs_combined
  simp_alive_peephole
  sorry
def narrow_shuffle_of_select_use1_combined := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_use1(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xi8>
    llvm.call @use(%3) : (vector<4xi8>) -> ()
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi8> 
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_narrow_shuffle_of_select_use1   : narrow_shuffle_of_select_use1_before  ⊑  narrow_shuffle_of_select_use1_combined := by
  unfold narrow_shuffle_of_select_use1_before narrow_shuffle_of_select_use1_combined
  simp_alive_peephole
  sorry
def narrow_shuffle_of_select_use2_combined := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_use2(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi1> 
    llvm.call @use_cmp(%2) : (vector<4xi1>) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xi8>
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi8> 
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_narrow_shuffle_of_select_use2   : narrow_shuffle_of_select_use2_before  ⊑  narrow_shuffle_of_select_use2_combined := by
  unfold narrow_shuffle_of_select_use2_before narrow_shuffle_of_select_use2_combined
  simp_alive_peephole
  sorry
def narrow_shuffle_of_select_mismatch_types1_combined := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_mismatch_types1(%arg0: vector<2xi1>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<2xi1>
    %1 = llvm.mlir.poison : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<4xi1>, vector<4xi8>
    %4 = llvm.shufflevector %3, %1 [0, 1, 2] : vector<4xi8> 
    llvm.return %4 : vector<3xi8>
  }]

theorem inst_combine_narrow_shuffle_of_select_mismatch_types1   : narrow_shuffle_of_select_mismatch_types1_before  ⊑  narrow_shuffle_of_select_mismatch_types1_combined := by
  unfold narrow_shuffle_of_select_mismatch_types1_before narrow_shuffle_of_select_mismatch_types1_combined
  simp_alive_peephole
  sorry
def narrow_shuffle_of_select_mismatch_types2_combined := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_mismatch_types2(%arg0: vector<4xi1>, %arg1: vector<6xi8>, %arg2: vector<6xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<4xi1>
    %1 = llvm.mlir.poison : vector<6xi8>
    %2 = llvm.shufflevector %arg0, %0 [0, 1, 2, -1, -1, -1] : vector<4xi1> 
    %3 = llvm.select %2, %arg1, %arg2 : vector<6xi1>, vector<6xi8>
    %4 = llvm.shufflevector %3, %1 [0, 1, 2] : vector<6xi8> 
    llvm.return %4 : vector<3xi8>
  }]

theorem inst_combine_narrow_shuffle_of_select_mismatch_types2   : narrow_shuffle_of_select_mismatch_types2_before  ⊑  narrow_shuffle_of_select_mismatch_types2_combined := by
  unfold narrow_shuffle_of_select_mismatch_types2_before narrow_shuffle_of_select_mismatch_types2_combined
  simp_alive_peephole
  sorry
def narrow_shuffle_of_select_consts_combined := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_consts(%arg0: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-1, -2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_narrow_shuffle_of_select_consts   : narrow_shuffle_of_select_consts_before  ⊑  narrow_shuffle_of_select_consts_combined := by
  unfold narrow_shuffle_of_select_consts_before narrow_shuffle_of_select_consts_combined
  simp_alive_peephole
  sorry
def narrow_shuffle_of_select_with_widened_ops_combined := [llvmfunc|
  llvm.func @narrow_shuffle_of_select_with_widened_ops(%arg0: vector<2xi1>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.select %arg0, %arg1, %arg2 : vector<2xi1>, vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_narrow_shuffle_of_select_with_widened_ops   : narrow_shuffle_of_select_with_widened_ops_before  ⊑  narrow_shuffle_of_select_with_widened_ops_combined := by
  unfold narrow_shuffle_of_select_with_widened_ops_before narrow_shuffle_of_select_with_widened_ops_combined
  simp_alive_peephole
  sorry
