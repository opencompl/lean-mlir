import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strnlen-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strnlen_sx_pi_0_before := [llvmfunc|
  llvm.func @fold_strnlen_sx_pi_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @sx : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i8>
    %3 = llvm.call @strnlen(%2, %1) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }]

def call_strnlen_sx_pi_n_before := [llvmfunc|
  llvm.func @call_strnlen_sx_pi_n(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.addressof @sx : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.getelementptr inbounds %0[%1, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i8>
    %3 = llvm.call @strnlen(%2, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }]

def call_strnlen_a3_pi_2_before := [llvmfunc|
  llvm.func @call_strnlen_a3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @a3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

def call_strnlen_a3_pi_3_before := [llvmfunc|
  llvm.func @call_strnlen_a3_pi_3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @a3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

def fold_strnlen_s3_pi_0_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_pi_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %4 = llvm.call @strnlen(%3, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %4 : i64
  }]

def call_strnlen_s5_pi_0_before := [llvmfunc|
  llvm.func @call_strnlen_s5_pi_0(%arg0: i64 {llvm.zeroext}) -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @strnlen(%1, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }]

def fold_strnlen_s5_3_pi_0_before := [llvmfunc|
  llvm.func @fold_strnlen_s5_3_pi_0(%arg0: i64 {llvm.zeroext}) -> i64 {
    %0 = llvm.mlir.constant("12345\00abc\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr, i32, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

def call_strnlen_s5_3_pi_n_before := [llvmfunc|
  llvm.func @call_strnlen_s5_3_pi_n(%arg0: i64 {llvm.zeroext}, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00abc\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %4 = llvm.call @strnlen(%3, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %4 : i64
  }]

def fold_strnlen_a3_n_before := [llvmfunc|
  llvm.func @fold_strnlen_a3_n(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @a3 : !llvm.ptr
    %2 = llvm.call @strnlen(%1, %arg0) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }]

def fold_strnlen_s3_n_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_n(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.call @strnlen(%1, %arg0) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }]

def fold_strnlen_a3_pi_2_before := [llvmfunc|
  llvm.func @fold_strnlen_a3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @a3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

def fold_strnlen_s3_pi_2_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

def fold_strnlen_s3_pi_3_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_pi_3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

def fold_strnlen_s3_pi_n_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_pi_n(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %4 = llvm.call @strnlen(%3, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %4 : i64
  }]

def call_strnlen_s5_3_pi_2_before := [llvmfunc|
  llvm.func @call_strnlen_s5_3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00abc\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

def fold_strnlen_sx_pi_0_combined := [llvmfunc|
  llvm.func @fold_strnlen_sx_pi_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strnlen_sx_pi_0   : fold_strnlen_sx_pi_0_before  ⊑  fold_strnlen_sx_pi_0_combined := by
  unfold fold_strnlen_sx_pi_0_before fold_strnlen_sx_pi_0_combined
  simp_alive_peephole
  sorry
def call_strnlen_sx_pi_n_combined := [llvmfunc|
  llvm.func @call_strnlen_sx_pi_n(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.addressof @sx : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.getelementptr inbounds %0[%1, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i8>
    %3 = llvm.call @strnlen(%2, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }]

theorem inst_combine_call_strnlen_sx_pi_n   : call_strnlen_sx_pi_n_before  ⊑  call_strnlen_sx_pi_n_combined := by
  unfold call_strnlen_sx_pi_n_before call_strnlen_sx_pi_n_combined
  simp_alive_peephole
  sorry
def call_strnlen_a3_pi_2_combined := [llvmfunc|
  llvm.func @call_strnlen_a3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @a3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_call_strnlen_a3_pi_2   : call_strnlen_a3_pi_2_before  ⊑  call_strnlen_a3_pi_2_combined := by
  unfold call_strnlen_a3_pi_2_before call_strnlen_a3_pi_2_combined
  simp_alive_peephole
  sorry
def call_strnlen_a3_pi_3_combined := [llvmfunc|
  llvm.func @call_strnlen_a3_pi_3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @a3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_call_strnlen_a3_pi_3   : call_strnlen_a3_pi_3_before  ⊑  call_strnlen_a3_pi_3_combined := by
  unfold call_strnlen_a3_pi_3_before call_strnlen_a3_pi_3_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s3_pi_0_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_pi_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strnlen_s3_pi_0   : fold_strnlen_s3_pi_0_before  ⊑  fold_strnlen_s3_pi_0_combined := by
  unfold fold_strnlen_s3_pi_0_before fold_strnlen_s3_pi_0_combined
  simp_alive_peephole
  sorry
def call_strnlen_s5_pi_0_combined := [llvmfunc|
  llvm.func @call_strnlen_s5_pi_0(%arg0: i64 {llvm.zeroext}) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_call_strnlen_s5_pi_0   : call_strnlen_s5_pi_0_before  ⊑  call_strnlen_s5_pi_0_combined := by
  unfold call_strnlen_s5_pi_0_before call_strnlen_s5_pi_0_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s5_3_pi_0_combined := [llvmfunc|
  llvm.func @fold_strnlen_s5_3_pi_0(%arg0: i64 {llvm.zeroext}) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strnlen_s5_3_pi_0   : fold_strnlen_s5_3_pi_0_before  ⊑  fold_strnlen_s5_3_pi_0_combined := by
  unfold fold_strnlen_s5_3_pi_0_before fold_strnlen_s5_3_pi_0_combined
  simp_alive_peephole
  sorry
def call_strnlen_s5_3_pi_n_combined := [llvmfunc|
  llvm.func @call_strnlen_s5_3_pi_n(%arg0: i64 {llvm.zeroext}, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00abc\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %4 = llvm.call @strnlen(%3, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %4 : i64
  }]

theorem inst_combine_call_strnlen_s5_3_pi_n   : call_strnlen_s5_3_pi_n_before  ⊑  call_strnlen_s5_3_pi_n_combined := by
  unfold call_strnlen_s5_3_pi_n_before call_strnlen_s5_3_pi_n_combined
  simp_alive_peephole
  sorry
def fold_strnlen_a3_n_combined := [llvmfunc|
  llvm.func @fold_strnlen_a3_n(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.intr.umin(%arg0, %0)  : (i64, i64) -> i64
    llvm.return %1 : i64
  }]

theorem inst_combine_fold_strnlen_a3_n   : fold_strnlen_a3_n_before  ⊑  fold_strnlen_a3_n_combined := by
  unfold fold_strnlen_a3_n_before fold_strnlen_a3_n_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s3_n_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_n(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.intr.umin(%arg0, %0)  : (i64, i64) -> i64
    llvm.return %1 : i64
  }]

theorem inst_combine_fold_strnlen_s3_n   : fold_strnlen_s3_n_before  ⊑  fold_strnlen_s3_n_combined := by
  unfold fold_strnlen_s3_n_before fold_strnlen_s3_n_combined
  simp_alive_peephole
  sorry
def fold_strnlen_a3_pi_2_combined := [llvmfunc|
  llvm.func @fold_strnlen_a3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @a3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_fold_strnlen_a3_pi_2   : fold_strnlen_a3_pi_2_before  ⊑  fold_strnlen_a3_pi_2_combined := by
  unfold fold_strnlen_a3_pi_2_before fold_strnlen_a3_pi_2_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s3_pi_2_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_fold_strnlen_s3_pi_2   : fold_strnlen_s3_pi_2_before  ⊑  fold_strnlen_s3_pi_2_combined := by
  unfold fold_strnlen_s3_pi_2_before fold_strnlen_s3_pi_2_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s3_pi_3_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_pi_3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_fold_strnlen_s3_pi_3   : fold_strnlen_s3_pi_3_before  ⊑  fold_strnlen_s3_pi_3_combined := by
  unfold fold_strnlen_s3_pi_3_before fold_strnlen_s3_pi_3_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s3_pi_n_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_pi_n(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %4 = llvm.call @strnlen(%3, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %4 : i64
  }]

theorem inst_combine_fold_strnlen_s3_pi_n   : fold_strnlen_s3_pi_n_before  ⊑  fold_strnlen_s3_pi_n_combined := by
  unfold fold_strnlen_s3_pi_n_before fold_strnlen_s3_pi_n_combined
  simp_alive_peephole
  sorry
def call_strnlen_s5_3_pi_2_combined := [llvmfunc|
  llvm.func @call_strnlen_s5_3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00abc\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_call_strnlen_s5_3_pi_2   : call_strnlen_s5_3_pi_2_before  ⊑  call_strnlen_s5_3_pi_2_combined := by
  unfold call_strnlen_s5_3_pi_2_before call_strnlen_s5_3_pi_2_combined
  simp_alive_peephole
  sorry
