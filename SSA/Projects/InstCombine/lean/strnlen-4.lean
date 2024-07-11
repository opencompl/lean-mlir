import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strnlen-4
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strnlen_s3_pi_s5_n_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_pi_s5_n(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s5 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %6 = llvm.select %arg0, %5, %4 : i1, !llvm.ptr
    %7 = llvm.call @strnlen(%6, %arg2) : (!llvm.ptr, i64) -> i64
    llvm.return %7 : i64
  }]

def call_strnlen_s3_pi_xbounds_s5_n_before := [llvmfunc|
  llvm.func @call_strnlen_s3_pi_xbounds_s5_n(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s5 : !llvm.ptr
    %5 = llvm.getelementptr %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %6 = llvm.select %arg0, %5, %4 : i1, !llvm.ptr
    %7 = llvm.call @strnlen(%6, %arg2) : (!llvm.ptr, i64) -> i64
    llvm.return %7 : i64
  }]

def call_strnlen_s3_pi_sx_n_before := [llvmfunc|
  llvm.func @call_strnlen_s3_pi_sx_n(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @sx : !llvm.ptr
    %4 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %5 = llvm.select %arg0, %4, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %arg2) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

def fold_strnlen_s3_s5_pi_n_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_pi_n(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @s3 : !llvm.ptr
    %4 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %5 = llvm.call @strnlen(%4, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

def fold_strnlen_s3_pi_s5_n_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_pi_s5_n(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s5 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %6 = llvm.select %arg0, %5, %4 : i1, !llvm.ptr
    %7 = llvm.call @strnlen(%6, %arg2) : (!llvm.ptr, i64) -> i64
    llvm.return %7 : i64
  }]

theorem inst_combine_fold_strnlen_s3_pi_s5_n   : fold_strnlen_s3_pi_s5_n_before  ⊑  fold_strnlen_s3_pi_s5_n_combined := by
  unfold fold_strnlen_s3_pi_s5_n_before fold_strnlen_s3_pi_s5_n_combined
  simp_alive_peephole
  sorry
def call_strnlen_s3_pi_xbounds_s5_n_combined := [llvmfunc|
  llvm.func @call_strnlen_s3_pi_xbounds_s5_n(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s5 : !llvm.ptr
    %5 = llvm.getelementptr %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %6 = llvm.select %arg0, %5, %4 : i1, !llvm.ptr
    %7 = llvm.call @strnlen(%6, %arg2) : (!llvm.ptr, i64) -> i64
    llvm.return %7 : i64
  }]

theorem inst_combine_call_strnlen_s3_pi_xbounds_s5_n   : call_strnlen_s3_pi_xbounds_s5_n_before  ⊑  call_strnlen_s3_pi_xbounds_s5_n_combined := by
  unfold call_strnlen_s3_pi_xbounds_s5_n_before call_strnlen_s3_pi_xbounds_s5_n_combined
  simp_alive_peephole
  sorry
def call_strnlen_s3_pi_sx_n_combined := [llvmfunc|
  llvm.func @call_strnlen_s3_pi_sx_n(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @sx : !llvm.ptr
    %4 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %5 = llvm.select %arg0, %4, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %arg2) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

theorem inst_combine_call_strnlen_s3_pi_sx_n   : call_strnlen_s3_pi_sx_n_before  ⊑  call_strnlen_s3_pi_sx_n_combined := by
  unfold call_strnlen_s3_pi_sx_n_before call_strnlen_s3_pi_sx_n_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s3_s5_pi_n_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_pi_n(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @s3 : !llvm.ptr
    %4 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %5 = llvm.call @strnlen(%4, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_fold_strnlen_s3_s5_pi_n   : fold_strnlen_s3_s5_pi_n_before  ⊑  fold_strnlen_s3_s5_pi_n_combined := by
  unfold fold_strnlen_s3_s5_pi_n_before fold_strnlen_s3_s5_pi_n_combined
  simp_alive_peephole
  sorry
