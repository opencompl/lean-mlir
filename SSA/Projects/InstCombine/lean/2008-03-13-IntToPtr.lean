import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-03-13-IntToPtr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bork_before := [llvmfunc|
  llvm.func @bork(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> !llvm.ptr]

    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.add %2, %0  : i32
    %4 = llvm.inttoptr %3 : i32 to !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def bork_combined := [llvmfunc|
  llvm.func @bork(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.add %3, %0  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.inttoptr %5 : i64 to !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_bork   : bork_before  ⊑  bork_combined := by
  unfold bork_before bork_combined
  simp_alive_peephole
  sorry
