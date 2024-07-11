import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  gc.relocate-verify
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def check_verify_undef_token_before := [llvmfunc|
  llvm.func @check_verify_undef_token() -> i32 attributes {garbageCollector = "statepoint-example"} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

def check_verify_undef_token_combined := [llvmfunc|
  llvm.func @check_verify_undef_token() -> i32 attributes {garbageCollector = "statepoint-example"} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_check_verify_undef_token   : check_verify_undef_token_before  ⊑  check_verify_undef_token_combined := by
  unfold check_verify_undef_token_before check_verify_undef_token_combined
  simp_alive_peephole
  sorry
