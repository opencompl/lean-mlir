import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  avg-lsb
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def avg_lsb_before := [llvmfunc|
  llvm.func @avg_lsb(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i8
    %4 = llvm.lshr %3, %0  : i8
    llvm.return %4 : i8
  }]

def avg_lsb_mismatch_before := [llvmfunc|
  llvm.func @avg_lsb_mismatch(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.add %3, %2 overflow<nsw, nuw>  : i8
    %5 = llvm.lshr %4, %0  : i8
    llvm.return %5 : i8
  }]

def avg_lsb_vector_before := [llvmfunc|
  llvm.func @avg_lsb_vector(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : vector<2xi8>
    %4 = llvm.lshr %3, %0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def avg_lsb_combined := [llvmfunc|
  llvm.func @avg_lsb(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i8
    %4 = llvm.lshr %3, %0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_avg_lsb   : avg_lsb_before  ⊑  avg_lsb_combined := by
  unfold avg_lsb_before avg_lsb_combined
  simp_alive_peephole
  sorry
def avg_lsb_mismatch_combined := [llvmfunc|
  llvm.func @avg_lsb_mismatch(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.add %3, %2 overflow<nsw, nuw>  : i8
    %5 = llvm.lshr %4, %0  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_avg_lsb_mismatch   : avg_lsb_mismatch_before  ⊑  avg_lsb_mismatch_combined := by
  unfold avg_lsb_mismatch_before avg_lsb_mismatch_combined
  simp_alive_peephole
  sorry
def avg_lsb_vector_combined := [llvmfunc|
  llvm.func @avg_lsb_vector(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : vector<2xi8>
    %4 = llvm.lshr %3, %0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_avg_lsb_vector   : avg_lsb_vector_before  ⊑  avg_lsb_vector_combined := by
  unfold avg_lsb_vector_before avg_lsb_vector_combined
  simp_alive_peephole
  sorry
