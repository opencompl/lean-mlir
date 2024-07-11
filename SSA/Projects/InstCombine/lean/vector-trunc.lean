import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vector-trunc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def trunc_add_nsw_before := [llvmfunc|
  llvm.func @trunc_add_nsw(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<17> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.ashr %arg0, %0  : vector<4xi32>
    %3 = llvm.trunc %2 : vector<4xi32> to vector<4xi16>
    %4 = llvm.add %3, %1  : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

def trunc_add_no_nsw_before := [llvmfunc|
  llvm.func @trunc_add_no_nsw(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<16> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.ashr %arg0, %0  : vector<4xi32>
    %3 = llvm.trunc %2 : vector<4xi32> to vector<4xi16>
    %4 = llvm.add %3, %1  : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

def trunc_add_mixed_before := [llvmfunc|
  llvm.func @trunc_add_mixed(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<[17, 16, 17, 16]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.ashr %arg0, %0  : vector<4xi32>
    %3 = llvm.trunc %2 : vector<4xi32> to vector<4xi16>
    %4 = llvm.add %3, %1  : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

def trunc_add_nsw_combined := [llvmfunc|
  llvm.func @trunc_add_nsw(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<17> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.ashr %arg0, %0  : vector<4xi32>
    %3 = llvm.trunc %2 : vector<4xi32> to vector<4xi16>
    %4 = llvm.add %3, %1 overflow<nsw>  : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

theorem inst_combine_trunc_add_nsw   : trunc_add_nsw_before  ⊑  trunc_add_nsw_combined := by
  unfold trunc_add_nsw_before trunc_add_nsw_combined
  simp_alive_peephole
  sorry
def trunc_add_no_nsw_combined := [llvmfunc|
  llvm.func @trunc_add_no_nsw(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<16> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.lshr %arg0, %0  : vector<4xi32>
    %3 = llvm.trunc %2 : vector<4xi32> to vector<4xi16>
    %4 = llvm.add %3, %1  : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

theorem inst_combine_trunc_add_no_nsw   : trunc_add_no_nsw_before  ⊑  trunc_add_no_nsw_combined := by
  unfold trunc_add_no_nsw_before trunc_add_no_nsw_combined
  simp_alive_peephole
  sorry
def trunc_add_mixed_combined := [llvmfunc|
  llvm.func @trunc_add_mixed(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<[17, 16, 17, 16]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.ashr %arg0, %0  : vector<4xi32>
    %3 = llvm.trunc %2 : vector<4xi32> to vector<4xi16>
    %4 = llvm.add %3, %1  : vector<4xi16>
    llvm.return %4 : vector<4xi16>
  }]

theorem inst_combine_trunc_add_mixed   : trunc_add_mixed_before  ⊑  trunc_add_mixed_combined := by
  unfold trunc_add_mixed_before trunc_add_mixed_combined
  simp_alive_peephole
  sorry
