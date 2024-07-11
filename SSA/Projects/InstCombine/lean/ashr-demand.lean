import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ashr-demand
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def srem2_ashr_mask_before := [llvmfunc|
  llvm.func @srem2_ashr_mask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }]

def srem8_ashr_mask_before := [llvmfunc|
  llvm.func @srem8_ashr_mask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.ashr %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }]

def srem2_ashr_mask_vector_before := [llvmfunc|
  llvm.func @srem2_ashr_mask_vector(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.srem %arg0, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %1  : vector<2xi32>
    %4 = llvm.and %3, %0  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def srem2_ashr_mask_vector_nonconstant_before := [llvmfunc|
  llvm.func @srem2_ashr_mask_vector_nonconstant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.srem %arg0, %0  : vector<2xi32>
    %2 = llvm.ashr %1, %arg1  : vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def srem2_ashr_mask_combined := [llvmfunc|
  llvm.func @srem2_ashr_mask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_srem2_ashr_mask   : srem2_ashr_mask_before  ⊑  srem2_ashr_mask_combined := by
  unfold srem2_ashr_mask_before srem2_ashr_mask_combined
  simp_alive_peephole
  sorry
def srem8_ashr_mask_combined := [llvmfunc|
  llvm.func @srem8_ashr_mask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483641 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_srem8_ashr_mask   : srem8_ashr_mask_before  ⊑  srem8_ashr_mask_combined := by
  unfold srem8_ashr_mask_before srem8_ashr_mask_combined
  simp_alive_peephole
  sorry
def srem2_ashr_mask_vector_combined := [llvmfunc|
  llvm.func @srem2_ashr_mask_vector(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.srem %arg0, %0  : vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_srem2_ashr_mask_vector   : srem2_ashr_mask_vector_before  ⊑  srem2_ashr_mask_vector_combined := by
  unfold srem2_ashr_mask_vector_before srem2_ashr_mask_vector_combined
  simp_alive_peephole
  sorry
def srem2_ashr_mask_vector_nonconstant_combined := [llvmfunc|
  llvm.func @srem2_ashr_mask_vector_nonconstant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.srem %arg0, %0  : vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_srem2_ashr_mask_vector_nonconstant   : srem2_ashr_mask_vector_nonconstant_before  ⊑  srem2_ashr_mask_vector_nonconstant_combined := by
  unfold srem2_ashr_mask_vector_nonconstant_before srem2_ashr_mask_vector_nonconstant_combined
  simp_alive_peephole
  sorry
