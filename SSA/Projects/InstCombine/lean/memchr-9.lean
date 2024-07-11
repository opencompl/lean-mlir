import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memchr-9
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memchr_A_pIb_cst_cst_before := [llvmfunc|
  llvm.func @fold_memchr_A_pIb_cst_cst(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[514, 771]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %1 = llvm.mlir.constant(dense<[0, 257]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %5 = llvm.mlir.undef : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>> 
    %7 = llvm.mlir.addressof @a : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(1 : i64) : i64
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.mlir.constant(4 : i32) : i32
    %13 = llvm.mlir.constant(4 : i64) : i64
    %14 = llvm.mlir.constant(3 : i32) : i32
    %15 = llvm.mlir.constant(3 : i64) : i64
    %16 = llvm.mlir.constant(5 : i32) : i32
    %17 = llvm.mlir.constant(6 : i32) : i32
    %18 = llvm.mlir.constant(2 : i64) : i64
    %19 = llvm.mlir.constant(7 : i32) : i32
    %20 = llvm.mlir.constant(8 : i32) : i32
    %21 = llvm.mlir.constant(9 : i32) : i32
    %22 = llvm.mlir.constant(5 : i64) : i64
    %23 = llvm.mlir.constant(10 : i32) : i32
    %24 = llvm.mlir.constant(6 : i64) : i64
    %25 = llvm.call @memchr(%7, %8, %9) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %25, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %26 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %27 = llvm.call @memchr(%7, %10, %9) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %27, %26 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %28 = llvm.getelementptr %arg0[%11] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %29 = llvm.call @memchr(%7, %12, %13) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %29, %28 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %30 = llvm.getelementptr %7[%10] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %31 = llvm.getelementptr %arg0[%14] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %32 = llvm.call @memchr(%30, %8, %9) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %32, %31 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %33 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %34 = llvm.call @memchr(%30, %8, %15) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %34, %33 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %35 = llvm.getelementptr %arg0[%16] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %36 = llvm.call @memchr(%30, %10, %9) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %36, %35 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %37 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %38 = llvm.call @memchr(%30, %10, %18) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %38, %37 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %39 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %40 = llvm.call @memchr(%30, %14, %15) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %40, %39 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %41 = llvm.getelementptr %arg0[%20] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %42 = llvm.call @memchr(%30, %14, %13) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %42, %41 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %43 = llvm.getelementptr %arg0[%21] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %44 = llvm.call @memchr(%30, %14, %22) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %42, %41 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %45 = llvm.getelementptr %arg0[%23] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %46 = llvm.call @memchr(%30, %14, %24) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %46, %45 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def fold_memchr_A_pIb_cst_N_before := [llvmfunc|
  llvm.func @fold_memchr_A_pIb_cst_N(%arg0: i64, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[514, 771]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %1 = llvm.mlir.constant(dense<[0, 257]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %5 = llvm.mlir.undef : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>> 
    %7 = llvm.mlir.addressof @a : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.mlir.constant(6 : i32) : i32
    %15 = llvm.mlir.constant(7 : i32) : i32
    %16 = llvm.mlir.constant(8 : i32) : i32
    %17 = llvm.mlir.constant(9 : i32) : i32
    %18 = llvm.mlir.constant(10 : i32) : i32
    %19 = llvm.mlir.constant(11 : i32) : i32
    %20 = llvm.mlir.constant(12 : i32) : i32
    %21 = llvm.call @memchr(%7, %8, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %21, %arg1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %22 = llvm.getelementptr %arg1[%9] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %23 = llvm.call @memchr(%7, %9, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %23, %22 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %24 = llvm.getelementptr %arg1[%10] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %25 = llvm.call @memchr(%7, %11, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %25, %24 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %26 = llvm.getelementptr %7[%9] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %27 = llvm.getelementptr %arg1[%12] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %28 = llvm.call @memchr(%26, %8, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %28, %27 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %29 = llvm.getelementptr %arg1[%11] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %30 = llvm.call @memchr(%26, %9, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %30, %29 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %31 = llvm.getelementptr %arg1[%13] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %32 = llvm.call @memchr(%26, %10, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %32, %31 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %33 = llvm.getelementptr %arg1[%14] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %34 = llvm.call @memchr(%26, %12, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %34, %33 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %35 = llvm.getelementptr %arg1[%15] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %36 = llvm.call @memchr(%26, %11, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %36, %35 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %37 = llvm.getelementptr %7[%10] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %38 = llvm.getelementptr %arg1[%16] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %39 = llvm.call @memchr(%37, %8, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %39, %38 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %40 = llvm.getelementptr %arg1[%17] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %41 = llvm.call @memchr(%37, %9, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %41, %40 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %42 = llvm.getelementptr %arg1[%18] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %43 = llvm.call @memchr(%37, %10, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %43, %42 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %44 = llvm.getelementptr %arg1[%19] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %45 = llvm.call @memchr(%37, %12, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %45, %44 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %46 = llvm.getelementptr %arg1[%20] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %47 = llvm.call @memchr(%37, %11, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %47, %46 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def call_memchr_A_pIb_xs_cst_before := [llvmfunc|
  llvm.func @call_memchr_A_pIb_xs_cst(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[514, 771]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %1 = llvm.mlir.constant(dense<[0, 257]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %5 = llvm.mlir.undef : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>> 
    %7 = llvm.mlir.addressof @a : !llvm.ptr
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.mlir.constant(0 : i64) : i64
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.constant(2 : i64) : i64
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.mlir.constant(8 : i32) : i32
    %14 = llvm.mlir.constant(2 : i32) : i32
    %15 = llvm.getelementptr %7[%8, %9] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %16 = llvm.call @memchr(%15, %10, %11) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %16, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %17 = llvm.getelementptr %15[%12] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %18 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %19 = llvm.call @memchr(%15, %10, %11) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %19, %18 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %20 = llvm.getelementptr %7[%13] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %21 = llvm.getelementptr %arg0[%14] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    %22 = llvm.call @memchr(%20, %10, %11) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %22, %21 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def fold_memchr_gep_gep_gep_before := [llvmfunc|
  llvm.func @fold_memchr_gep_gep_gep() -> !llvm.ptr {
    %0 = llvm.mlir.constant(dense<[0, -1]> : tensor<2xi64>) : !llvm.array<2 x i64>
    %1 = llvm.mlir.addressof @ai64 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(-1 : i32) : i32
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i64>
    %7 = llvm.getelementptr %6[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.getelementptr %7[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %9 = llvm.call @memchr(%8, %4, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %9 : !llvm.ptr
  }]

def fold_memchr_union_member_before := [llvmfunc|
  llvm.func @fold_memchr_union_member() -> !llvm.ptr {
    %0 = llvm.mlir.constant(dense<[286331153, 35791394]> : tensor<2xi32>) : !llvm.array<2 x i32>
    %1 = llvm.mlir.undef : !llvm.struct<"union.U", (array<2 x i32>)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"union.U", (array<2 x i32>)> 
    %3 = llvm.mlir.addressof @u : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(34 : i32) : i32
    %6 = llvm.mlir.constant(8 : i64) : i64
    %7 = llvm.getelementptr %3[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %8 = llvm.call @memchr(%7, %5, %6) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %8 : !llvm.ptr
  }]

def fold_memchr_A_pIb_cst_cst_combined := [llvmfunc|
  llvm.func @fold_memchr_A_pIb_cst_cst(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[514, 771]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %1 = llvm.mlir.constant(dense<[0, 257]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %5 = llvm.mlir.undef : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>> 
    %7 = llvm.mlir.addressof @a : !llvm.ptr
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.mlir.zero : !llvm.ptr
    %10 = llvm.mlir.constant(2 : i64) : i64
    %11 = llvm.mlir.constant(3 : i64) : i64
    %12 = llvm.getelementptr %7[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %13 = llvm.mlir.constant(4 : i64) : i64
    %14 = llvm.mlir.constant(5 : i64) : i64
    %15 = llvm.mlir.constant(6 : i64) : i64
    %16 = llvm.mlir.constant(0 : i32) : i32
    %17 = llvm.mlir.constant(0 : i64) : i64
    %18 = llvm.getelementptr inbounds %7[%17, %17, 0, %8] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %19 = llvm.mlir.constant(7 : i64) : i64
    %20 = llvm.mlir.constant(8 : i64) : i64
    %21 = llvm.mlir.constant(10 : i64) : i64
    %22 = llvm.mlir.constant(1 : i32) : i32
    %23 = llvm.getelementptr inbounds %7[%17, %17, 1, %8] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    llvm.store %7, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_cst   : fold_memchr_A_pIb_cst_cst_before  ⊑  fold_memchr_A_pIb_cst_cst_combined := by
  unfold fold_memchr_A_pIb_cst_cst_before fold_memchr_A_pIb_cst_cst_combined
  simp_alive_peephole
  sorry
    %24 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %9, %24 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_cst   : fold_memchr_A_pIb_cst_cst_before  ⊑  fold_memchr_A_pIb_cst_cst_combined := by
  unfold fold_memchr_A_pIb_cst_cst_before fold_memchr_A_pIb_cst_cst_combined
  simp_alive_peephole
  sorry
    %25 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %9, %25 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_cst   : fold_memchr_A_pIb_cst_cst_before  ⊑  fold_memchr_A_pIb_cst_cst_combined := by
  unfold fold_memchr_A_pIb_cst_cst_before fold_memchr_A_pIb_cst_cst_combined
  simp_alive_peephole
  sorry
    %26 = llvm.getelementptr %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %12, %26 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_cst   : fold_memchr_A_pIb_cst_cst_before  ⊑  fold_memchr_A_pIb_cst_cst_combined := by
  unfold fold_memchr_A_pIb_cst_cst_before fold_memchr_A_pIb_cst_cst_combined
  simp_alive_peephole
  sorry
    %27 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %12, %27 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_cst   : fold_memchr_A_pIb_cst_cst_before  ⊑  fold_memchr_A_pIb_cst_cst_combined := by
  unfold fold_memchr_A_pIb_cst_cst_before fold_memchr_A_pIb_cst_cst_combined
  simp_alive_peephole
  sorry
    %28 = llvm.getelementptr %arg0[%14] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %9, %28 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_cst   : fold_memchr_A_pIb_cst_cst_before  ⊑  fold_memchr_A_pIb_cst_cst_combined := by
  unfold fold_memchr_A_pIb_cst_cst_before fold_memchr_A_pIb_cst_cst_combined
  simp_alive_peephole
  sorry
    %29 = llvm.getelementptr %arg0[%15] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %18, %29 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_cst   : fold_memchr_A_pIb_cst_cst_before  ⊑  fold_memchr_A_pIb_cst_cst_combined := by
  unfold fold_memchr_A_pIb_cst_cst_before fold_memchr_A_pIb_cst_cst_combined
  simp_alive_peephole
  sorry
    %30 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %9, %30 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_cst   : fold_memchr_A_pIb_cst_cst_before  ⊑  fold_memchr_A_pIb_cst_cst_combined := by
  unfold fold_memchr_A_pIb_cst_cst_before fold_memchr_A_pIb_cst_cst_combined
  simp_alive_peephole
  sorry
    %31 = llvm.getelementptr %arg0[%20] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %9, %31 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_cst   : fold_memchr_A_pIb_cst_cst_before  ⊑  fold_memchr_A_pIb_cst_cst_combined := by
  unfold fold_memchr_A_pIb_cst_cst_before fold_memchr_A_pIb_cst_cst_combined
  simp_alive_peephole
  sorry
    %32 = llvm.getelementptr %arg0[%21] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %23, %32 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_cst   : fold_memchr_A_pIb_cst_cst_before  ⊑  fold_memchr_A_pIb_cst_cst_combined := by
  unfold fold_memchr_A_pIb_cst_cst_before fold_memchr_A_pIb_cst_cst_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_memchr_A_pIb_cst_cst   : fold_memchr_A_pIb_cst_cst_before  ⊑  fold_memchr_A_pIb_cst_cst_combined := by
  unfold fold_memchr_A_pIb_cst_cst_before fold_memchr_A_pIb_cst_cst_combined
  simp_alive_peephole
  sorry
def fold_memchr_A_pIb_cst_N_combined := [llvmfunc|
  llvm.func @fold_memchr_A_pIb_cst_N(%arg0: i64, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(dense<[514, 771]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %3 = llvm.mlir.constant(dense<[0, 257]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %7 = llvm.mlir.undef : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>> 
    %9 = llvm.mlir.addressof @a : !llvm.ptr
    %10 = llvm.mlir.constant(1 : i64) : i64
    %11 = llvm.mlir.constant(3 : i64) : i64
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.getelementptr inbounds %9[%0, %0, 0, %10] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %14 = llvm.mlir.constant(2 : i64) : i64
    %15 = llvm.getelementptr %9[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %16 = llvm.mlir.constant(4 : i64) : i64
    %17 = llvm.mlir.constant(5 : i64) : i64
    %18 = llvm.mlir.constant(1 : i32) : i32
    %19 = llvm.getelementptr inbounds %9[%0, %0, 1, %0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %20 = llvm.mlir.constant(6 : i64) : i64
    %21 = llvm.getelementptr inbounds %9[%0, %0, 1, %10] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %22 = llvm.mlir.constant(7 : i64) : i64
    %23 = llvm.mlir.constant(8 : i64) : i64
    %24 = llvm.mlir.constant(9 : i64) : i64
    %25 = llvm.mlir.constant(10 : i64) : i64
    %26 = llvm.mlir.constant(11 : i64) : i64
    %27 = llvm.mlir.constant(12 : i64) : i64
    %28 = llvm.icmp "eq" %arg0, %0 : i64
    %29 = llvm.select %28, %1, %9 : i1, !llvm.ptr
    llvm.store %29, %arg1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
    %30 = llvm.getelementptr %arg1[%10] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %31 = llvm.icmp "ult" %arg0, %11 : i64
    %32 = llvm.select %31, %1, %13 : i1, !llvm.ptr
    llvm.store %32, %30 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
    %33 = llvm.getelementptr %arg1[%14] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %1, %33 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
    %34 = llvm.getelementptr %arg1[%11] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %35 = llvm.icmp "eq" %arg0, %0 : i64
    %36 = llvm.select %35, %1, %15 : i1, !llvm.ptr
    llvm.store %36, %34 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
    %37 = llvm.getelementptr %arg1[%16] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %38 = llvm.icmp "ult" %arg0, %14 : i64
    %39 = llvm.select %38, %1, %13 : i1, !llvm.ptr
    llvm.store %39, %37 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
    %40 = llvm.getelementptr %arg1[%17] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %41 = llvm.icmp "ult" %arg0, %16 : i64
    %42 = llvm.select %41, %1, %19 : i1, !llvm.ptr
    llvm.store %42, %40 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
    %43 = llvm.getelementptr %arg1[%20] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %44 = llvm.icmp "ult" %arg0, %20 : i64
    %45 = llvm.select %44, %1, %21 : i1, !llvm.ptr
    llvm.store %45, %43 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
    %46 = llvm.getelementptr %arg1[%22] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %1, %46 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
    %47 = llvm.getelementptr %arg1[%23] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %1, %47 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
    %48 = llvm.getelementptr %arg1[%24] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %49 = llvm.icmp "eq" %arg0, %0 : i64
    %50 = llvm.select %49, %1, %13 : i1, !llvm.ptr
    llvm.store %50, %48 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
    %51 = llvm.getelementptr %arg1[%25] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %52 = llvm.icmp "ult" %arg0, %11 : i64
    %53 = llvm.select %52, %1, %19 : i1, !llvm.ptr
    llvm.store %53, %51 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
    %54 = llvm.getelementptr %arg1[%26] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %55 = llvm.icmp "ult" %arg0, %17 : i64
    %56 = llvm.select %55, %1, %21 : i1, !llvm.ptr
    llvm.store %56, %54 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
    %57 = llvm.getelementptr %arg1[%27] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %1, %57 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_memchr_A_pIb_cst_N   : fold_memchr_A_pIb_cst_N_before  ⊑  fold_memchr_A_pIb_cst_N_combined := by
  unfold fold_memchr_A_pIb_cst_N_before fold_memchr_A_pIb_cst_N_combined
  simp_alive_peephole
  sorry
def call_memchr_A_pIb_xs_cst_combined := [llvmfunc|
  llvm.func @call_memchr_A_pIb_xs_cst(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[514, 771]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %3 = llvm.mlir.constant(dense<[0, 257]> : tensor<2xi16>) : !llvm.array<2 x i16>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"struct.A", (array<2 x i16>, array<2 x i16>)> 
    %7 = llvm.mlir.undef : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>> 
    %9 = llvm.mlir.addressof @a : !llvm.ptr
    %10 = llvm.getelementptr inbounds %9[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.mlir.constant(2 : i64) : i64
    %13 = llvm.getelementptr inbounds %9[%1, %0, 0, %0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<1 x struct<"struct.A", (array<2 x i16>, array<2 x i16>)>>
    %14 = llvm.call @memchr(%10, %11, %12) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %14, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_call_memchr_A_pIb_xs_cst   : call_memchr_A_pIb_xs_cst_before  ⊑  call_memchr_A_pIb_xs_cst_combined := by
  unfold call_memchr_A_pIb_xs_cst_before call_memchr_A_pIb_xs_cst_combined
  simp_alive_peephole
  sorry
    %15 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %16 = llvm.call @memchr(%10, %11, %12) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %16, %15 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_call_memchr_A_pIb_xs_cst   : call_memchr_A_pIb_xs_cst_before  ⊑  call_memchr_A_pIb_xs_cst_combined := by
  unfold call_memchr_A_pIb_xs_cst_before call_memchr_A_pIb_xs_cst_combined
  simp_alive_peephole
  sorry
    %17 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    %18 = llvm.call @memchr(%13, %11, %12) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.store %18, %17 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_call_memchr_A_pIb_xs_cst   : call_memchr_A_pIb_xs_cst_before  ⊑  call_memchr_A_pIb_xs_cst_combined := by
  unfold call_memchr_A_pIb_xs_cst_before call_memchr_A_pIb_xs_cst_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_call_memchr_A_pIb_xs_cst   : call_memchr_A_pIb_xs_cst_before  ⊑  call_memchr_A_pIb_xs_cst_combined := by
  unfold call_memchr_A_pIb_xs_cst_before call_memchr_A_pIb_xs_cst_combined
  simp_alive_peephole
  sorry
def fold_memchr_gep_gep_gep_combined := [llvmfunc|
  llvm.func @fold_memchr_gep_gep_gep() -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[0, -1]> : tensor<2xi64>) : !llvm.array<2 x i64>
    %3 = llvm.mlir.addressof @ai64 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i64>
    %5 = llvm.getelementptr %4[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %6 = llvm.getelementptr %5[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_gep_gep_gep   : fold_memchr_gep_gep_gep_before  ⊑  fold_memchr_gep_gep_gep_combined := by
  unfold fold_memchr_gep_gep_gep_before fold_memchr_gep_gep_gep_combined
  simp_alive_peephole
  sorry
def fold_memchr_union_member_combined := [llvmfunc|
  llvm.func @fold_memchr_union_member() -> !llvm.ptr {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(dense<[286331153, 35791394]> : tensor<2xi32>) : !llvm.array<2 x i32>
    %2 = llvm.mlir.undef : !llvm.struct<"union.U", (array<2 x i32>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"union.U", (array<2 x i32>)> 
    %4 = llvm.mlir.addressof @u : !llvm.ptr
    %5 = llvm.getelementptr %4[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_union_member   : fold_memchr_union_member_before  ⊑  fold_memchr_union_member_combined := by
  unfold fold_memchr_union_member_before fold_memchr_union_member_combined
  simp_alive_peephole
  sorry
