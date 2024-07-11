import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  default-alignment
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t_before := [llvmfunc|
  llvm.func @t(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %0 : i8
  }]

def t_combined := [llvmfunc|
  llvm.func @t(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_t   : t_before  ⊑  t_combined := by
  unfold t_before t_combined
  simp_alive_peephole
  sorry
