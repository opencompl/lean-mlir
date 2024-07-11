import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr43081
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pr43081_before := [llvmfunc|
  llvm.func @pr43081(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %4 = llvm.call @strchr(%3, %1) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def pr43081_combined := [llvmfunc|
  llvm.func @pr43081(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strchr(%arg0, %0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_pr43081   : pr43081_before  ⊑  pr43081_combined := by
  unfold pr43081_before pr43081_combined
  simp_alive_peephole
  sorry
