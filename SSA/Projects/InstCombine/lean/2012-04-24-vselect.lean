import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-04-24-vselect
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo() -> vector<8xi32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, false, false, false, false, false, false, false]> : vector<8xi1>) : vector<8xi1>
    %3 = llvm.mlir.constant(dense<1> : vector<8xi32>) : vector<8xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(dense<0> : vector<8xi32>) : vector<8xi32>
    %6 = llvm.select %2, %3, %5 : vector<8xi1>, vector<8xi32>
    llvm.return %6 : vector<8xi32>
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo() -> vector<8xi32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1, 0, 0, 0, 0, 0, 0, 0]> : vector<8xi32>) : vector<8xi32>
    llvm.return %0 : vector<8xi32>
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
