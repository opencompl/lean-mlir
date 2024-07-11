import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr82877
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def func_before := [llvmfunc|
  llvm.func @func(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1231558963 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.xor %arg0, %0  : i32
    llvm.br ^bb1(%5 : i32)
  ^bb1(%6: i32):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.select %arg1, %1, %2 : i1, i32
    %8 = llvm.xor %7, %6  : i32
    %9 = llvm.icmp "ne" %8, %3 : i32
    %10 = llvm.zext %9 : i1 to i32
    llvm.cond_br %9, ^bb1(%10 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i64
  }]

def func_combined := [llvmfunc|
  llvm.func @func(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1231558963 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.xor %arg0, %0  : i32
    llvm.br ^bb1(%5 : i32)
  ^bb1(%6: i32):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.select %arg1, %1, %2 : i1, i32
    %8 = llvm.xor %7, %6  : i32
    %9 = llvm.icmp "ne" %8, %3 : i32
    %10 = llvm.zext %9 : i1 to i32
    llvm.cond_br %9, ^bb1(%10 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i64
  }]

theorem inst_combine_func   : func_before  ⊑  func_combined := by
  unfold func_before func_combined
  simp_alive_peephole
  sorry
