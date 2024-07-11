import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr12338
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def entry_before := [llvmfunc|
  llvm.func @entry() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<1xi32>) : vector<1xi32>
    %2 = llvm.mlir.constant(dense<92> : vector<1xi32>) : vector<1xi32>
    llvm.br ^bb1(%1 : vector<1xi32>)
  ^bb1(%3: vector<1xi32>):  // 2 preds: ^bb0, ^bb3
    %4 = llvm.sub %1, %3  : vector<1xi32>
    llvm.br ^bb2(%4 : vector<1xi32>)
  ^bb2(%5: vector<1xi32>):  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    %6 = llvm.add %5, %2  : vector<1xi32>
    %7 = llvm.sub %1, %6  : vector<1xi32>
    llvm.br ^bb1(%7 : vector<1xi32>)
  }]

def entry_combined := [llvmfunc|
  llvm.func @entry() attributes {passthrough = ["nounwind"]} {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb3
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb1
  }]

theorem inst_combine_entry   : entry_before  ⊑  entry_combined := by
  unfold entry_before entry_combined
  simp_alive_peephole
  sorry
