import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2006-10-19-SignedToUnsignedCastAndConst-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def eq_signed_to_small_unsigned_before := [llvmfunc|
  llvm.func @eq_signed_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def eq_signed_to_small_unsigned_combined := [llvmfunc|
  llvm.func @eq_signed_to_small_unsigned(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_eq_signed_to_small_unsigned   : eq_signed_to_small_unsigned_before  ⊑  eq_signed_to_small_unsigned_combined := by
  unfold eq_signed_to_small_unsigned_before eq_signed_to_small_unsigned_combined
  simp_alive_peephole
  sorry
