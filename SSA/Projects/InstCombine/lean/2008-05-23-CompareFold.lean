import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-05-23-CompareFold
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(3.40282347E+38 : f32) : f32
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %2 = llvm.sitofp %1 : i8 to f32
    %3 = llvm.fcmp "ugt" %2, %0 : f32
    llvm.return %3 : i1
  }]

def f_combined := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
