import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  gepgep
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f() {
    %0 = llvm.mlir.constant(127 : i64) : i64
    %1 = llvm.mlir.addressof @buffer : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.sub %3, %2  : i64
    %5 = llvm.add %4, %0  : i64
    %6 = llvm.getelementptr %1[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

def f_combined := [llvmfunc|
  llvm.func @f() {
    %0 = llvm.mlir.constant(127 : i64) : i64
    %1 = llvm.mlir.addressof @buffer : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.sub %3, %2  : i64
    %5 = llvm.add %4, %0  : i64
    %6 = llvm.getelementptr %1[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
