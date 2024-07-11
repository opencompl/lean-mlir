import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  redundant-left-shift-input-masking-pr49778
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def src_before := [llvmfunc|
  llvm.func @src(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.shl %0, %1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.shl %4, %1  : i32
    llvm.return %5 : i32
  }]

def src_combined := [llvmfunc|
  llvm.func @src(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.shl %0, %1 overflow<nsw>  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.shl %4, %1 overflow<nsw, nuw>  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_src   : src_before  ⊑  src_combined := by
  unfold src_before src_combined
  simp_alive_peephole
  sorry
