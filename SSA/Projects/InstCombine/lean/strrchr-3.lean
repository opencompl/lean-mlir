import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strrchr-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strrchr_sp10_x_before := [llvmfunc|
  llvm.func @fold_strrchr_sp10_x(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("0123456789\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @s10 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<11 x i8>
    %5 = llvm.call @strrchr(%4, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def call_strrchr_sp9_x_before := [llvmfunc|
  llvm.func @call_strrchr_sp9_x(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("0123456789\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @s10 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(9 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<11 x i8>
    %5 = llvm.call @strrchr(%4, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def call_strrchr_sp2_x_before := [llvmfunc|
  llvm.func @call_strrchr_sp2_x(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("0123456789\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @s10 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<11 x i8>
    %5 = llvm.call @strrchr(%4, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def call_strrchr_sp1_x_before := [llvmfunc|
  llvm.func @call_strrchr_sp1_x(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("0123456789\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @s10 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<11 x i8>
    %5 = llvm.call @strrchr(%4, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def fold_strrchr_sp10_x_combined := [llvmfunc|
  llvm.func @fold_strrchr_sp10_x(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("0123456789\00") : !llvm.array<11 x i8>
    %4 = llvm.mlir.addressof @s10 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<11 x i8>
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "eq" %7, %0 : i8
    %9 = llvm.select %8, %5, %6 : i1, !llvm.ptr
    llvm.return %9 : !llvm.ptr
  }]

theorem inst_combine_fold_strrchr_sp10_x   : fold_strrchr_sp10_x_before  ⊑  fold_strrchr_sp10_x_combined := by
  unfold fold_strrchr_sp10_x_before fold_strrchr_sp10_x_combined
  simp_alive_peephole
  sorry
def call_strrchr_sp9_x_combined := [llvmfunc|
  llvm.func @call_strrchr_sp9_x(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(9 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("0123456789\00") : !llvm.array<11 x i8>
    %3 = llvm.mlir.addressof @s10 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<11 x i8>
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.call @memrchr(%4, %arg0, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_call_strrchr_sp9_x   : call_strrchr_sp9_x_before  ⊑  call_strrchr_sp9_x_combined := by
  unfold call_strrchr_sp9_x_before call_strrchr_sp9_x_combined
  simp_alive_peephole
  sorry
def call_strrchr_sp2_x_combined := [llvmfunc|
  llvm.func @call_strrchr_sp2_x(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("0123456789\00") : !llvm.array<11 x i8>
    %3 = llvm.mlir.addressof @s10 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<11 x i8>
    %5 = llvm.mlir.constant(9 : i64) : i64
    %6 = llvm.call @memrchr(%4, %arg0, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_call_strrchr_sp2_x   : call_strrchr_sp2_x_before  ⊑  call_strrchr_sp2_x_combined := by
  unfold call_strrchr_sp2_x_before call_strrchr_sp2_x_combined
  simp_alive_peephole
  sorry
def call_strrchr_sp1_x_combined := [llvmfunc|
  llvm.func @call_strrchr_sp1_x(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("0123456789\00") : !llvm.array<11 x i8>
    %3 = llvm.mlir.addressof @s10 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<11 x i8>
    %5 = llvm.mlir.constant(10 : i64) : i64
    %6 = llvm.call @memrchr(%4, %arg0, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_call_strrchr_sp1_x   : call_strrchr_sp1_x_before  ⊑  call_strrchr_sp1_x_combined := by
  unfold call_strrchr_sp1_x_before call_strrchr_sp1_x_combined
  simp_alive_peephole
  sorry
