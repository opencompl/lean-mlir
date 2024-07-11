import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sprintf-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_snprintf_member_pC_before := [llvmfunc|
  llvm.func @fold_snprintf_member_pC(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %3 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %4 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %5 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %6 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %7 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %9 = llvm.insertvalue %5, %8[1] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %10 = llvm.insertvalue %4, %9[2] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %11 = llvm.mlir.constant("123\00\00\00\00") : !llvm.array<7 x i8>
    %12 = llvm.mlir.constant("12\00\00\00\00") : !llvm.array<6 x i8>
    %13 = llvm.mlir.constant("1\00\00\00\00") : !llvm.array<5 x i8>
    %14 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %16 = llvm.insertvalue %12, %15[1] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %17 = llvm.insertvalue %11, %16[2] : !llvm.struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)> 
    %18 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %19 = llvm.insertvalue %17, %18[0] : !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>> 
    %20 = llvm.insertvalue %10, %19[1] : !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>> 
    %21 = llvm.mlir.addressof @a : !llvm.ptr
    %22 = llvm.mlir.constant(0 : i32) : i32
    %23 = llvm.mlir.constant(1 : i64) : i64
    %24 = llvm.mlir.constant(1 : i32) : i32
    %25 = llvm.mlir.constant(2 : i32) : i32
    %26 = llvm.mlir.constant(3 : i32) : i32
    %27 = llvm.mlir.constant(2 : i64) : i64
    %28 = llvm.mlir.constant(4 : i32) : i32
    %29 = llvm.mlir.constant(5 : i32) : i32
    %30 = llvm.mlir.constant(6 : i32) : i32
    %31 = llvm.mlir.constant(7 : i32) : i32
    %32 = llvm.mlir.constant(8 : i32) : i32
    %33 = llvm.call @snprintf(%0, %1, %3, %21) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %33, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %34 = llvm.getelementptr %21[%1, %1, 0, %23] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %35 = llvm.call @snprintf(%0, %1, %3, %34) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %36 = llvm.getelementptr %arg0[%24] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %35, %36 {alignment = 4 : i64} : i32, !llvm.ptr]

    %37 = llvm.getelementptr %21[%1, %1, 1, %1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %38 = llvm.call @snprintf(%0, %1, %3, %37) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %39 = llvm.getelementptr %arg0[%25] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %38, %39 {alignment = 4 : i64} : i32, !llvm.ptr]

    %40 = llvm.getelementptr %21[%1, %1, 1, %23] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %41 = llvm.call @snprintf(%0, %1, %3, %40) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %42 = llvm.getelementptr %arg0[%26] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %41, %42 {alignment = 4 : i64} : i32, !llvm.ptr]

    %43 = llvm.getelementptr %21[%1, %1, 1, %27] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %44 = llvm.call @snprintf(%0, %1, %3, %43) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %45 = llvm.getelementptr %arg0[%28] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %44, %45 {alignment = 4 : i64} : i32, !llvm.ptr]

    %46 = llvm.getelementptr %21[%1, %1, 2, %1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %47 = llvm.call @snprintf(%0, %1, %3, %46) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %48 = llvm.getelementptr %arg0[%29] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %47, %48 {alignment = 4 : i64} : i32, !llvm.ptr]

    %49 = llvm.getelementptr %21[%1, %23, 0, %1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %50 = llvm.call @snprintf(%0, %1, %3, %49) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %51 = llvm.getelementptr %arg0[%30] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %50, %51 {alignment = 4 : i64} : i32, !llvm.ptr]

    %52 = llvm.getelementptr %21[%1, %23, 1, %1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %53 = llvm.call @snprintf(%0, %1, %3, %52) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %54 = llvm.getelementptr %arg0[%31] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %53, %54 {alignment = 4 : i64} : i32, !llvm.ptr]

    %55 = llvm.getelementptr %21[%1, %23, 2, %1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<5 x i8>, array<6 x i8>, array<7 x i8>)>>
    %56 = llvm.call @snprintf(%0, %1, %3, %55) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %57 = llvm.getelementptr %arg0[%32] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %56, %57 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_snprintf_member_pC_combined := [llvmfunc|
  llvm.func @fold_snprintf_member_pC(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.mlir.constant(6 : i64) : i64
    %10 = llvm.mlir.constant(4 : i32) : i32
    %11 = llvm.mlir.constant(7 : i64) : i64
    %12 = llvm.mlir.constant(5 : i32) : i32
    %13 = llvm.mlir.constant(8 : i64) : i64
    %14 = llvm.mlir.constant(6 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_member_pC   : fold_snprintf_member_pC_before  ⊑  fold_snprintf_member_pC_combined := by
  unfold fold_snprintf_member_pC_before fold_snprintf_member_pC_combined
  simp_alive_peephole
  sorry
    %15 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_member_pC   : fold_snprintf_member_pC_before  ⊑  fold_snprintf_member_pC_combined := by
  unfold fold_snprintf_member_pC_before fold_snprintf_member_pC_combined
  simp_alive_peephole
  sorry
    %16 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %4, %16 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_member_pC   : fold_snprintf_member_pC_before  ⊑  fold_snprintf_member_pC_combined := by
  unfold fold_snprintf_member_pC_before fold_snprintf_member_pC_combined
  simp_alive_peephole
  sorry
    %17 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_member_pC   : fold_snprintf_member_pC_before  ⊑  fold_snprintf_member_pC_combined := by
  unfold fold_snprintf_member_pC_before fold_snprintf_member_pC_combined
  simp_alive_peephole
  sorry
    %18 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %18 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_member_pC   : fold_snprintf_member_pC_before  ⊑  fold_snprintf_member_pC_combined := by
  unfold fold_snprintf_member_pC_before fold_snprintf_member_pC_combined
  simp_alive_peephole
  sorry
    %19 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %8, %19 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_member_pC   : fold_snprintf_member_pC_before  ⊑  fold_snprintf_member_pC_combined := by
  unfold fold_snprintf_member_pC_before fold_snprintf_member_pC_combined
  simp_alive_peephole
  sorry
    %20 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %10, %20 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_member_pC   : fold_snprintf_member_pC_before  ⊑  fold_snprintf_member_pC_combined := by
  unfold fold_snprintf_member_pC_before fold_snprintf_member_pC_combined
  simp_alive_peephole
  sorry
    %21 = llvm.getelementptr %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %12, %21 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_member_pC   : fold_snprintf_member_pC_before  ⊑  fold_snprintf_member_pC_combined := by
  unfold fold_snprintf_member_pC_before fold_snprintf_member_pC_combined
  simp_alive_peephole
  sorry
    %22 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %14, %22 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_member_pC   : fold_snprintf_member_pC_before  ⊑  fold_snprintf_member_pC_combined := by
  unfold fold_snprintf_member_pC_before fold_snprintf_member_pC_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_snprintf_member_pC   : fold_snprintf_member_pC_before  ⊑  fold_snprintf_member_pC_combined := by
  unfold fold_snprintf_member_pC_before fold_snprintf_member_pC_combined
  simp_alive_peephole
  sorry
