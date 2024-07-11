import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-09-17-ZeroSizedAlloca
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @x : !llvm.ptr
    %3 = llvm.mlir.addressof @y : !llvm.ptr
    %4 = llvm.alloca %0 x !llvm.array<0 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.alloca %0 x !llvm.array<0 x i8> {alignment = 1024 : i64} : (i32) -> !llvm.ptr]

    llvm.store %4, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.store %5, %3 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def f_combined := [llvmfunc|
  llvm.func @f() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @x : !llvm.ptr
    %3 = llvm.mlir.addressof @y : !llvm.ptr
    %4 = llvm.alloca %0 x !llvm.array<0 x i8> {alignment = 1024 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %3 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
