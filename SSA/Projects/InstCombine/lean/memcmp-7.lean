import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcmp-7
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memcmp_i32a_i32b_pIb_before := [llvmfunc|
  llvm.func @fold_memcmp_i32a_i32b_pIb(%arg0: i32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[4386, 13124]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %1 = llvm.mlir.addressof @i32a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.addressof @i32b : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.constant(3 : i64) : i64
    %8 = llvm.getelementptr %1[%2] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %9 = llvm.getelementptr %3[%2] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %10 = llvm.call @memcmp(%8, %8, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %10, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %11 = llvm.getelementptr %arg1[%2] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %12 = llvm.call @memcmp(%8, %8, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %12, %11 {alignment = 4 : i64} : i32, !llvm.ptr]

    %13 = llvm.getelementptr %arg1[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %14 = llvm.call @memcmp(%8, %8, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %14, %13 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_memcmp_A_B_pIb_before := [llvmfunc|
  llvm.func @fold_memcmp_A_B_pIb(%arg0: i32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant("\01\02\03\04") : !llvm.array<4 x i8>
    %1 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"struct.A", (array<4 x i8>)> 
    %3 = llvm.mlir.undef : !llvm.array<1 x struct<"struct.A", (array<4 x i8>)>>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.array<1 x struct<"struct.A", (array<4 x i8>)>> 
    %5 = llvm.mlir.addressof @a : !llvm.ptr
    %6 = llvm.mlir.constant("\03\04") : !llvm.array<2 x i8>
    %7 = llvm.mlir.constant("\01\02") : !llvm.array<2 x i8>
    %8 = llvm.mlir.undef : !llvm.struct<"struct.B", (array<2 x i8>, array<2 x i8>)>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.struct<"struct.B", (array<2 x i8>, array<2 x i8>)> 
    %10 = llvm.insertvalue %6, %9[1] : !llvm.struct<"struct.B", (array<2 x i8>, array<2 x i8>)> 
    %11 = llvm.mlir.undef : !llvm.array<1 x struct<"struct.B", (array<2 x i8>, array<2 x i8>)>>
    %12 = llvm.insertvalue %10, %11[0] : !llvm.array<1 x struct<"struct.B", (array<2 x i8>, array<2 x i8>)>> 
    %13 = llvm.mlir.addressof @b : !llvm.ptr
    %14 = llvm.mlir.constant(1 : i64) : i64
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.mlir.constant(2 : i64) : i64
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.mlir.constant(3 : i64) : i64
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.mlir.constant(4 : i64) : i64
    %21 = llvm.mlir.constant(4 : i32) : i32
    %22 = llvm.mlir.constant(5 : i32) : i32
    %23 = llvm.mlir.constant(6 : i32) : i32
    %24 = llvm.call @memcmp(%5, %13, %14) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %24, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %25 = llvm.getelementptr %arg1[%15] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %26 = llvm.call @memcmp(%5, %13, %16) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %26, %25 {alignment = 4 : i64} : i32, !llvm.ptr]

    %27 = llvm.getelementptr %arg1[%17] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %28 = llvm.call @memcmp(%5, %13, %18) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %28, %27 {alignment = 4 : i64} : i32, !llvm.ptr]

    %29 = llvm.getelementptr %arg1[%19] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %30 = llvm.call @memcmp(%5, %13, %20) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %30, %29 {alignment = 4 : i64} : i32, !llvm.ptr]

    %31 = llvm.getelementptr %13[%15] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %32 = llvm.getelementptr %arg1[%21] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %33 = llvm.call @memcmp(%5, %31, %14) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %33, %32 {alignment = 4 : i64} : i32, !llvm.ptr]

    %34 = llvm.getelementptr %arg1[%22] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %35 = llvm.call @memcmp(%5, %31, %16) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %35, %34 {alignment = 4 : i64} : i32, !llvm.ptr]

    %36 = llvm.getelementptr %arg1[%23] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %37 = llvm.call @memcmp(%5, %31, %18) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %37, %36 {alignment = 4 : i64} : i32, !llvm.ptr]

    %38 = llvm.getelementptr %5[%15] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %39 = llvm.getelementptr %arg1[%21] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %40 = llvm.call @memcmp(%38, %13, %14) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %40, %39 {alignment = 4 : i64} : i32, !llvm.ptr]

    %41 = llvm.getelementptr %arg1[%22] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %42 = llvm.call @memcmp(%38, %13, %16) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %42, %41 {alignment = 4 : i64} : i32, !llvm.ptr]

    %43 = llvm.getelementptr %arg1[%23] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %44 = llvm.call @memcmp(%38, %13, %18) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %44, %43 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_memcmp_i32a_i32b_pIb_combined := [llvmfunc|
  llvm.func @fold_memcmp_i32a_i32b_pIb(%arg0: i32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.getelementptr %arg1[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.getelementptr %arg1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_memcmp_i32a_i32b_pIb   : fold_memcmp_i32a_i32b_pIb_before  ⊑  fold_memcmp_i32a_i32b_pIb_combined := by
  unfold fold_memcmp_i32a_i32b_pIb_before fold_memcmp_i32a_i32b_pIb_combined
  simp_alive_peephole
  sorry
def fold_memcmp_A_B_pIb_combined := [llvmfunc|
  llvm.func @fold_memcmp_A_B_pIb(%arg0: i32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i32) : i32
    %6 = llvm.mlir.constant(5 : i64) : i64
    %7 = llvm.mlir.constant(6 : i64) : i64
    %8 = llvm.mlir.constant(1 : i32) : i32
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.getelementptr %arg1[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %9 {alignment = 4 : i64} : i32, !llvm.ptr
    %10 = llvm.getelementptr %arg1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %10 {alignment = 4 : i64} : i32, !llvm.ptr
    %11 = llvm.getelementptr %arg1[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %11 {alignment = 4 : i64} : i32, !llvm.ptr
    %12 = llvm.getelementptr %arg1[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %5, %12 {alignment = 4 : i64} : i32, !llvm.ptr
    %13 = llvm.getelementptr %arg1[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %5, %13 {alignment = 4 : i64} : i32, !llvm.ptr
    %14 = llvm.getelementptr %arg1[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %5, %14 {alignment = 4 : i64} : i32, !llvm.ptr
    %15 = llvm.getelementptr %arg1[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %8, %15 {alignment = 4 : i64} : i32, !llvm.ptr
    %16 = llvm.getelementptr %arg1[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %8, %16 {alignment = 4 : i64} : i32, !llvm.ptr
    %17 = llvm.getelementptr %arg1[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %8, %17 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_memcmp_A_B_pIb   : fold_memcmp_A_B_pIb_before  ⊑  fold_memcmp_A_B_pIb_combined := by
  unfold fold_memcmp_A_B_pIb_before fold_memcmp_A_B_pIb_combined
  simp_alive_peephole
  sorry
