import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2011-05-13-InBoundsGEP
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1879048192 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(-1 : i32) : i32
    %5 = llvm.add %arg0, %0  : i32
    %6 = llvm.add %arg0, %1  : i32
    %7 = llvm.alloca %2 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.getelementptr %7[%5] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %9 = llvm.getelementptr %7[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %10 = llvm.icmp "ult" %8, %9 : !llvm.ptr
    llvm.cond_br %10, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %4 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

def main_combined := [llvmfunc|
  llvm.func @main(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1879048192 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(-1 : i32) : i32
    %5 = llvm.add %arg0, %0  : i32
    %6 = llvm.add %arg0, %1  : i32
    %7 = llvm.alloca %2 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    %8 = llvm.sext %5 : i32 to i64
    %9 = llvm.getelementptr %7[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %10 = llvm.sext %6 : i32 to i64
    %11 = llvm.getelementptr %7[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %12 = llvm.icmp "ult" %9, %11 : !llvm.ptr
    llvm.cond_br %12, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %4 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
