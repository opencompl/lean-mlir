import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-6-7-vselect-bitcast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: vector<16xi8>, %arg1: vector<16xi8>, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.bitcast %arg0 : vector<16xi8> to vector<4xi32>
    %3 = llvm.bitcast %arg1 : vector<16xi8> to vector<4xi32>
    %4 = llvm.select %1, %2, %3 : vector<4xi1>, vector<4xi32>
    llvm.store %4, %arg2 {alignment = 4 : i64} : vector<4xi32>, !llvm.ptr]

    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: vector<16xi8>, %arg1: vector<16xi8>, %arg2: !llvm.ptr) {
    llvm.store %arg1, %arg2 {alignment = 4 : i64} : vector<16xi8>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
