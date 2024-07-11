import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-07-11-RemAnd
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def a_before := [llvmfunc|
  llvm.func @a(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def a_vec_before := [llvmfunc|
  llvm.func @a_vec(%arg0: vector<2xi32>) -> vector<2xi32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.srem %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def a_combined := [llvmfunc|
  llvm.func @a(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_a   : a_before  ⊑  a_combined := by
  unfold a_before a_combined
  simp_alive_peephole
  sorry
def a_vec_combined := [llvmfunc|
  llvm.func @a_vec(%arg0: vector<2xi32>) -> vector<2xi32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_a_vec   : a_vec_before  ⊑  a_vec_combined := by
  unfold a_vec_before a_vec_combined
  simp_alive_peephole
  sorry
