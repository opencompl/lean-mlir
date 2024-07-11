import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  nothrow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t2_before := [llvmfunc|
  llvm.func @t2() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.call @t1(%0) : (i32) -> f64
    llvm.return
  }]

def t2_combined := [llvmfunc|
  llvm.func @t2() attributes {passthrough = ["nounwind"]} {
    llvm.return
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
