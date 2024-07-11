import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  lshr-phi
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def hash_string_before := [llvmfunc|
  llvm.func @hash_string(%arg0: !llvm.ptr {llvm.nocapture}) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(14 : i32) : i32
    %5 = llvm.mlir.constant(16383 : i32) : i32
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %8 = llvm.icmp "eq" %7, %0 : i8
    llvm.cond_br %8, ^bb2(%1 : i32), ^bb1(%2, %1 : i64, i32)
  ^bb1(%9: i64, %10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %12 = llvm.shl %10, %3  : i32
    %13 = llvm.lshr %10, %4  : i32
    %14 = llvm.add %12, %13  : i32
    %15 = llvm.load %11 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %16 = llvm.sext %15 : i8 to i32
    %17 = llvm.xor %16, %14  : i32
    %18 = llvm.and %17, %5  : i32
    %19 = llvm.add %9, %6  : i64
    %20 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %21 = llvm.load %20 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %22 = llvm.icmp "eq" %21, %0 : i8
    llvm.cond_br %22, ^bb2(%18 : i32), ^bb1(%19, %18 : i64, i32)
  ^bb2(%23: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %23 : i32
  }]

def hash_string_combined := [llvmfunc|
  llvm.func @hash_string(%arg0: !llvm.ptr {llvm.nocapture}) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(16383 : i32) : i32
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_hash_string   : hash_string_before  ⊑  hash_string_combined := by
  unfold hash_string_before hash_string_combined
  simp_alive_peephole
  sorry
    %7 = llvm.icmp "eq" %6, %0 : i8
    llvm.cond_br %7, ^bb2(%1 : i32), ^bb1(%2, %1 : i64, i32)
  ^bb1(%8: i64, %9: i32):  // 2 preds: ^bb0, ^bb1
    %10 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %11 = llvm.shl %9, %3 overflow<nsw, nuw>  : i32
    %12 = llvm.load %10 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_hash_string   : hash_string_before  ⊑  hash_string_combined := by
  unfold hash_string_before hash_string_combined
  simp_alive_peephole
  sorry
    %13 = llvm.sext %12 : i8 to i32
    %14 = llvm.xor %11, %13  : i32
    %15 = llvm.and %14, %4  : i32
    %16 = llvm.add %8, %5  : i64
    %17 = llvm.getelementptr %arg0[%16] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %18 = llvm.load %17 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_hash_string   : hash_string_before  ⊑  hash_string_combined := by
  unfold hash_string_before hash_string_combined
  simp_alive_peephole
  sorry
    %19 = llvm.icmp "eq" %18, %0 : i8
    llvm.cond_br %19, ^bb2(%15 : i32), ^bb1(%16, %15 : i64, i32)
  ^bb2(%20: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %20 : i32
  }]

theorem inst_combine_hash_string   : hash_string_before  ⊑  hash_string_combined := by
  unfold hash_string_before hash_string_combined
  simp_alive_peephole
  sorry
