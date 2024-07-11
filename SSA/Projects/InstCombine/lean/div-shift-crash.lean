import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  div-shift-crash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1, %arg6: i1, %arg7: i1, %arg8: i1, %arg9: i1) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(-701565022 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(-7 : i32) : i32
    %5 = llvm.mlir.constant(-1 : i32) : i32
    %6 = llvm.alloca %0 x !llvm.struct<"struct.S0.0.1.2.3.4.13.22.31.44.48.53.54.55.56.58.59.60.66.68.70.74.77.106.107.108.109.110.113.117.118.128.129", packed (i64)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb2, ^bb4
    llvm.cond_br %arg1, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    llvm.br ^bb3
  ^bb5:  // pred: ^bb3
    llvm.cond_br %arg2, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    llvm.br ^bb7
  ^bb7:  // 2 preds: ^bb5, ^bb6
    llvm.br ^bb8
  ^bb8:  // 2 preds: ^bb7, ^bb9
    llvm.cond_br %arg3, ^bb9, ^bb10
  ^bb9:  // pred: ^bb8
    llvm.br ^bb8
  ^bb10:  // pred: ^bb8
    %7 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr -> i64]

    llvm.br ^bb11
  ^bb11:  // 2 preds: ^bb10, ^bb18
    llvm.cond_br %arg4, ^bb12(%1 : i32), ^bb19
  ^bb12(%8: i32):  // 2 preds: ^bb11, ^bb15
    llvm.cond_br %arg5, ^bb13, ^bb16
  ^bb13:  // 2 preds: ^bb12, ^bb14
    llvm.cond_br %arg6, ^bb14, ^bb15
  ^bb14:  // pred: ^bb13
    llvm.br ^bb13
  ^bb15:  // pred: ^bb13
    %9 = llvm.add %3, %5 overflow<nsw>  : i32
    llvm.br ^bb12(%9 : i32)
  ^bb16:  // pred: ^bb12
    %10 = llvm.trunc %7 : i64 to i32
    %11 = llvm.xor %8, %2  : i32
    %12 = llvm.sub %3, %8 overflow<nsw>  : i32
    %13 = llvm.xor %12, %8  : i32
    %14 = llvm.and %11, %13  : i32
    %15 = llvm.icmp "slt" %14, %3 : i32
    %16 = llvm.sub %2, %8 overflow<nsw>  : i32
    %17 = llvm.select %15, %2, %16 : i1, i32
    llvm.cond_br %arg7, ^bb18(%10 : i32), ^bb17
  ^bb17:  // pred: ^bb16
    %18 = llvm.udiv %10, %17  : i32
    llvm.br ^bb18(%18 : i32)
  ^bb18(%19: i32):  // 2 preds: ^bb16, ^bb17
    %20 = llvm.icmp "ne" %19, %4 : i32
    llvm.br ^bb11
  ^bb19:  // pred: ^bb11
    llvm.cond_br %arg8, ^bb20, ^bb21
  ^bb20:  // pred: ^bb19
    llvm.unreachable
  ^bb21:  // pred: ^bb19
    llvm.br ^bb22
  ^bb22:  // 2 preds: ^bb21, ^bb23
    llvm.cond_br %arg9, ^bb23, ^bb24
  ^bb23:  // pred: ^bb22
    llvm.br ^bb22
  ^bb24:  // pred: ^bb22
    llvm.unreachable
  }]

def main_combined := [llvmfunc|
  llvm.func @main(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1, %arg6: i1, %arg7: i1, %arg8: i1, %arg9: i1) {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb2, ^bb4
    llvm.cond_br %arg1, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    llvm.br ^bb3
  ^bb5:  // pred: ^bb3
    llvm.cond_br %arg2, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    llvm.br ^bb7
  ^bb7:  // 2 preds: ^bb5, ^bb6
    llvm.br ^bb8
  ^bb8:  // 2 preds: ^bb7, ^bb9
    llvm.cond_br %arg3, ^bb9, ^bb10
  ^bb9:  // pred: ^bb8
    llvm.br ^bb8
  ^bb10:  // pred: ^bb8
    llvm.br ^bb11
  ^bb11:  // 2 preds: ^bb10, ^bb18
    llvm.cond_br %arg4, ^bb12, ^bb19
  ^bb12:  // 2 preds: ^bb11, ^bb15
    llvm.cond_br %arg5, ^bb13, ^bb16
  ^bb13:  // 2 preds: ^bb12, ^bb14
    llvm.cond_br %arg6, ^bb14, ^bb15
  ^bb14:  // pred: ^bb13
    llvm.br ^bb13
  ^bb15:  // pred: ^bb13
    llvm.br ^bb12
  ^bb16:  // pred: ^bb12
    llvm.cond_br %arg7, ^bb18, ^bb17
  ^bb17:  // pred: ^bb16
    llvm.br ^bb18
  ^bb18:  // 2 preds: ^bb16, ^bb17
    llvm.br ^bb11
  ^bb19:  // pred: ^bb11
    llvm.cond_br %arg8, ^bb20, ^bb21
  ^bb20:  // pred: ^bb19
    llvm.unreachable
  ^bb21:  // pred: ^bb19
    llvm.br ^bb22
  ^bb22:  // 2 preds: ^bb21, ^bb23
    llvm.cond_br %arg9, ^bb23, ^bb24
  ^bb23:  // pred: ^bb22
    llvm.br ^bb22
  ^bb24:  // pred: ^bb22
    llvm.unreachable
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
