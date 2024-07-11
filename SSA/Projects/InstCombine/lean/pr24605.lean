import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr24605
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-117 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.add %2, %1  : i8
    llvm.store %3, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

    %4 = llvm.icmp "ugt" %2, %3 : i8
    llvm.return %4 : i1
  }]

def f_combined := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-117 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.or %arg1, %0  : i8
    %4 = llvm.add %3, %1 overflow<nsw>  : i8
    llvm.store %4, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
