import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-05-23-FCmpToICmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f0_before := [llvmfunc|
  llvm.func @f0(%arg0: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0x41EFFFFFFFE00000 : f64) : f64
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.uitofp %1 : i32 to f64
    %3 = llvm.fcmp "ogt" %2, %0 : f64
    llvm.return %3 : i1
  }]

def f0_combined := [llvmfunc|
  llvm.func @f0(%arg0: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_f0   : f0_before  ⊑  f0_combined := by
  unfold f0_before f0_combined
  simp_alive_peephole
  sorry
