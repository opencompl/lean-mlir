import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcmp-4
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memcmp_mismatch_too_big_before := [llvmfunc|
  llvm.func @fold_memcmp_mismatch_too_big(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[24930, 25444, 25958, 26472, 26992]> : tensor<5xi16>) : !llvm.array<5 x i16>
    %1 = llvm.mlir.addressof @ia16b : !llvm.ptr
    %2 = llvm.mlir.constant(dense<[24930, 25444, 25958, 26472, 26993, 29042]> : tensor<6xi16>) : !llvm.array<6 x i16>
    %3 = llvm.mlir.addressof @ia16c : !llvm.ptr
    %4 = llvm.mlir.constant(12 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.call @memcmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %7 = llvm.call @memcmp(%3, %1, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %8 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %7, %8 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_memcmp_match_too_big_before := [llvmfunc|
  llvm.func @fold_memcmp_match_too_big(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[24930, 25444, 25958, 26472]> : tensor<4xi16>) : !llvm.array<4 x i16>
    %1 = llvm.mlir.addressof @ia16a : !llvm.ptr
    %2 = llvm.mlir.constant(dense<[24930, 25444, 25958, 26472, 26992]> : tensor<5xi16>) : !llvm.array<5 x i16>
    %3 = llvm.mlir.addressof @ia16b : !llvm.ptr
    %4 = llvm.mlir.constant(9 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.call @memcmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %7, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %8 = llvm.call @memcmp(%1, %3, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %9 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %8, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_memcmp_mismatch_too_big_combined := [llvmfunc|
  llvm.func @fold_memcmp_mismatch_too_big(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_memcmp_mismatch_too_big   : fold_memcmp_mismatch_too_big_before  ⊑  fold_memcmp_mismatch_too_big_combined := by
  unfold fold_memcmp_mismatch_too_big_before fold_memcmp_mismatch_too_big_combined
  simp_alive_peephole
  sorry
def fold_memcmp_match_too_big_combined := [llvmfunc|
  llvm.func @fold_memcmp_match_too_big(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_memcmp_match_too_big   : fold_memcmp_match_too_big_before  ⊑  fold_memcmp_match_too_big_combined := by
  unfold fold_memcmp_match_too_big_before fold_memcmp_match_too_big_combined
  simp_alive_peephole
  sorry
