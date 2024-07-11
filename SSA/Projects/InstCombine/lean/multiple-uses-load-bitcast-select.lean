import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  multiple-uses-load-bitcast-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR35618_before := [llvmfunc|
  llvm.func @PR35618(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %5 = llvm.fcmp "olt" %3, %4 : f64
    %6 = llvm.select %5, %1, %2 : i1, !llvm.ptr
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i64]

    llvm.store %7, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.store %7, %arg1 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def PR35618_combined := [llvmfunc|
  llvm.func @PR35618(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> f64
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> f64
    %5 = llvm.fcmp "olt" %3, %4 : f64
    %6 = llvm.select %5, %3, %4 : i1, f64
    llvm.store %6, %arg0 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.store %6, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_PR35618   : PR35618_before  ⊑  PR35618_combined := by
  unfold PR35618_before PR35618_combined
  simp_alive_peephole
  sorry
