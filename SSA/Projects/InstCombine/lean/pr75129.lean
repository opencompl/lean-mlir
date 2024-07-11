import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr75129
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def or_and_add_and_before := [llvmfunc|
  llvm.func @or_and_add_and() -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(48 : i16) : i16
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.call @dummy() : () -> i16
    %4 = llvm.add %0, %3  : i16
    %5 = llvm.and %4, %1  : i16
    %6 = llvm.and %3, %2  : i16
    %7 = llvm.or %5, %6  : i16
    llvm.return %7 : i16
  }]

def or_and_add_and_combined := [llvmfunc|
  llvm.func @or_and_add_and() -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.call @dummy() : () -> i16
    %2 = llvm.xor %1, %0  : i16
    llvm.return %2 : i16
  }]

theorem inst_combine_or_and_add_and   : or_and_add_and_before  ⊑  or_and_add_and_combined := by
  unfold or_and_add_and_before or_and_add_and_combined
  simp_alive_peephole
  sorry
