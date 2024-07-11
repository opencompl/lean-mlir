import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strlen-7
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strlen_A_before := [llvmfunc|
  llvm.func @fold_strlen_A(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)> 
    %5 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %6 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)> 
    %9 = llvm.insertvalue %5, %8[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)> 
    %10 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>> 
    %12 = llvm.insertvalue %4, %11[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>> 
    %13 = llvm.mlir.addressof @a : !llvm.ptr
    %14 = llvm.mlir.constant(0 : i64) : i64
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.mlir.constant(1 : i64) : i64
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.mlir.constant(2 : i64) : i64
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.mlir.constant(3 : i64) : i64
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.mlir.constant(4 : i32) : i32
    %23 = llvm.mlir.constant(5 : i32) : i32
    %24 = llvm.mlir.constant(6 : i32) : i32
    %25 = llvm.mlir.constant(7 : i32) : i32
    %26 = llvm.mlir.constant(4 : i64) : i64
    %27 = llvm.mlir.constant(8 : i32) : i32
    %28 = llvm.mlir.constant(9 : i32) : i32
    %29 = llvm.mlir.constant(10 : i32) : i32
    %30 = llvm.mlir.constant(11 : i32) : i32
    %31 = llvm.mlir.constant(12 : i32) : i32
    %32 = llvm.mlir.constant(14 : i32) : i32
    %33 = llvm.mlir.constant(15 : i32) : i32
    %34 = llvm.mlir.constant(16 : i32) : i32
    %35 = llvm.mlir.constant(17 : i32) : i32
    %36 = llvm.mlir.constant(18 : i32) : i32
    %37 = llvm.call @strlen(%13) : (!llvm.ptr) -> i64
    llvm.store %37, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %38 = llvm.getelementptr %13[%14, %14, 0, %16] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %39 = llvm.call @strlen(%38) : (!llvm.ptr) -> i64
    %40 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %39, %40 {alignment = 4 : i64} : i64, !llvm.ptr]

    %41 = llvm.getelementptr %13[%14, %14, 0, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %42 = llvm.call @strlen(%41) : (!llvm.ptr) -> i64
    %43 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %42, %43 {alignment = 4 : i64} : i64, !llvm.ptr]

    %44 = llvm.getelementptr %13[%14, %14, 0, %20] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %45 = llvm.call @strlen(%44) : (!llvm.ptr) -> i64
    %46 = llvm.getelementptr %arg0[%21] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %45, %46 {alignment = 4 : i64} : i64, !llvm.ptr]

    %47 = llvm.getelementptr %13[%14, %14, 1, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %48 = llvm.call @strlen(%47) : (!llvm.ptr) -> i64
    %49 = llvm.getelementptr %arg0[%22] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %48, %49 {alignment = 4 : i64} : i64, !llvm.ptr]

    %50 = llvm.getelementptr %13[%14, %14, 1, %16] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %51 = llvm.call @strlen(%50) : (!llvm.ptr) -> i64
    %52 = llvm.getelementptr %arg0[%23] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %51, %52 {alignment = 4 : i64} : i64, !llvm.ptr]

    %53 = llvm.getelementptr %13[%14, %14, 1, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %54 = llvm.call @strlen(%53) : (!llvm.ptr) -> i64
    %55 = llvm.getelementptr %arg0[%24] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %54, %55 {alignment = 4 : i64} : i64, !llvm.ptr]

    %56 = llvm.getelementptr %13[%14, %14, 1, %20] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %57 = llvm.call @strlen(%56) : (!llvm.ptr) -> i64
    %58 = llvm.getelementptr %arg0[%25] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %57, %58 {alignment = 4 : i64} : i64, !llvm.ptr]

    %59 = llvm.getelementptr %13[%14, %14, 1, %26] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %60 = llvm.call @strlen(%59) : (!llvm.ptr) -> i64
    %61 = llvm.getelementptr %arg0[%27] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %60, %61 {alignment = 4 : i64} : i64, !llvm.ptr]

    %62 = llvm.getelementptr %13[%14, %16, 0, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %63 = llvm.call @strlen(%62) : (!llvm.ptr) -> i64
    %64 = llvm.getelementptr %arg0[%28] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %63, %64 {alignment = 4 : i64} : i64, !llvm.ptr]

    %65 = llvm.getelementptr %13[%14, %16, 0, %16] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %66 = llvm.call @strlen(%65) : (!llvm.ptr) -> i64
    %67 = llvm.getelementptr %arg0[%29] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %66, %67 {alignment = 4 : i64} : i64, !llvm.ptr]

    %68 = llvm.getelementptr %13[%14, %16, 0, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %69 = llvm.call @strlen(%68) : (!llvm.ptr) -> i64
    %70 = llvm.getelementptr %arg0[%30] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %69, %70 {alignment = 4 : i64} : i64, !llvm.ptr]

    %71 = llvm.getelementptr %13[%14, %16, 0, %20] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %72 = llvm.call @strlen(%71) : (!llvm.ptr) -> i64
    %73 = llvm.getelementptr %arg0[%31] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %72, %73 {alignment = 4 : i64} : i64, !llvm.ptr]

    %74 = llvm.getelementptr %13[%14, %16, 1, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %75 = llvm.call @strlen(%74) : (!llvm.ptr) -> i64
    %76 = llvm.getelementptr %arg0[%32] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %75, %76 {alignment = 4 : i64} : i64, !llvm.ptr]

    %77 = llvm.getelementptr %13[%14, %16, 1, %16] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %78 = llvm.call @strlen(%77) : (!llvm.ptr) -> i64
    %79 = llvm.getelementptr %arg0[%33] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %78, %79 {alignment = 4 : i64} : i64, !llvm.ptr]

    %80 = llvm.getelementptr %13[%14, %16, 1, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %81 = llvm.call @strlen(%80) : (!llvm.ptr) -> i64
    %82 = llvm.getelementptr %arg0[%34] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %81, %82 {alignment = 4 : i64} : i64, !llvm.ptr]

    %83 = llvm.getelementptr %13[%14, %16, 1, %20] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %84 = llvm.call @strlen(%83) : (!llvm.ptr) -> i64
    %85 = llvm.getelementptr %arg0[%35] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %84, %85 {alignment = 4 : i64} : i64, !llvm.ptr]

    %86 = llvm.getelementptr %13[%14, %16, 1, %26] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %87 = llvm.call @strlen(%86) : (!llvm.ptr) -> i64
    %88 = llvm.getelementptr %arg0[%36] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %87, %88 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def fold_strlen_A_pI_before := [llvmfunc|
  llvm.func @fold_strlen_A_pI(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)> 
    %5 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %6 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)> 
    %9 = llvm.insertvalue %5, %8[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)> 
    %10 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>> 
    %12 = llvm.insertvalue %4, %11[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>> 
    %13 = llvm.mlir.addressof @a : !llvm.ptr
    %14 = llvm.mlir.constant(0 : i64) : i64
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.mlir.constant(1 : i64) : i64
    %18 = llvm.mlir.constant(2 : i32) : i32
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.getelementptr %13[%14, %14, 0, %arg1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %21 = llvm.call @strlen(%20) : (!llvm.ptr) -> i64
    llvm.store %21, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %22 = llvm.getelementptr %13[%14, %14, 1, %arg1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %23 = llvm.call @strlen(%22) : (!llvm.ptr) -> i64
    %24 = llvm.getelementptr %arg0[%16] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %23, %24 {alignment = 4 : i64} : i64, !llvm.ptr]

    %25 = llvm.getelementptr %13[%14, %17, 0, %arg1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %26 = llvm.call @strlen(%25) : (!llvm.ptr) -> i64
    %27 = llvm.getelementptr %arg0[%18] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %26, %27 {alignment = 4 : i64} : i64, !llvm.ptr]

    %28 = llvm.getelementptr %13[%14, %17, 1, %arg1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %29 = llvm.call @strlen(%28) : (!llvm.ptr) -> i64
    %30 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %29, %30 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def fold_strlen_A_combined := [llvmfunc|
  llvm.func @fold_strlen_A(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.mlir.constant(6 : i64) : i64
    %7 = llvm.mlir.constant(7 : i64) : i64
    %8 = llvm.mlir.constant(8 : i64) : i64
    %9 = llvm.mlir.constant(9 : i64) : i64
    %10 = llvm.mlir.constant(10 : i64) : i64
    %11 = llvm.mlir.constant(11 : i64) : i64
    %12 = llvm.mlir.constant(12 : i64) : i64
    %13 = llvm.mlir.constant(14 : i64) : i64
    %14 = llvm.mlir.constant(15 : i64) : i64
    %15 = llvm.mlir.constant(16 : i64) : i64
    %16 = llvm.mlir.constant(17 : i64) : i64
    %17 = llvm.mlir.constant(18 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %18 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %18 {alignment = 4 : i64} : i64, !llvm.ptr
    %19 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %19 {alignment = 4 : i64} : i64, !llvm.ptr
    %20 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %20 {alignment = 4 : i64} : i64, !llvm.ptr
    %21 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %2, %21 {alignment = 4 : i64} : i64, !llvm.ptr
    %22 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %0, %22 {alignment = 4 : i64} : i64, !llvm.ptr
    %23 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %23 {alignment = 4 : i64} : i64, !llvm.ptr
    %24 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %24 {alignment = 4 : i64} : i64, !llvm.ptr
    %25 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %25 {alignment = 4 : i64} : i64, !llvm.ptr
    %26 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %3, %26 {alignment = 4 : i64} : i64, !llvm.ptr
    %27 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %2, %27 {alignment = 4 : i64} : i64, !llvm.ptr
    %28 = llvm.getelementptr %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %0, %28 {alignment = 4 : i64} : i64, !llvm.ptr
    %29 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %29 {alignment = 4 : i64} : i64, !llvm.ptr
    %30 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %4, %30 {alignment = 4 : i64} : i64, !llvm.ptr
    %31 = llvm.getelementptr %arg0[%14] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %3, %31 {alignment = 4 : i64} : i64, !llvm.ptr
    %32 = llvm.getelementptr %arg0[%15] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %2, %32 {alignment = 4 : i64} : i64, !llvm.ptr
    %33 = llvm.getelementptr %arg0[%16] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %0, %33 {alignment = 4 : i64} : i64, !llvm.ptr
    %34 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %34 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_strlen_A   : fold_strlen_A_before  ⊑  fold_strlen_A_combined := by
  unfold fold_strlen_A_before fold_strlen_A_combined
  simp_alive_peephole
  sorry
def fold_strlen_A_pI_combined := [llvmfunc|
  llvm.func @fold_strlen_A_pI(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)> 
    %5 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %6 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)> 
    %9 = llvm.insertvalue %5, %8[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>)> 
    %10 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>> 
    %12 = llvm.insertvalue %4, %11[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>> 
    %13 = llvm.mlir.addressof @a : !llvm.ptr
    %14 = llvm.mlir.constant(0 : i64) : i64
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.mlir.constant(1 : i64) : i64
    %18 = llvm.mlir.constant(2 : i64) : i64
    %19 = llvm.mlir.constant(3 : i64) : i64
    %20 = llvm.getelementptr %13[%14, %14, 0, %arg1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %21 = llvm.call @strlen(%20) : (!llvm.ptr) -> i64
    llvm.store %21, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %22 = llvm.getelementptr %13[%14, %14, 1, %arg1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %23 = llvm.call @strlen(%22) : (!llvm.ptr) -> i64
    %24 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %23, %24 {alignment = 4 : i64} : i64, !llvm.ptr
    %25 = llvm.getelementptr %13[%14, %17, 0, %arg1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %26 = llvm.call @strlen(%25) : (!llvm.ptr) -> i64
    %27 = llvm.getelementptr %arg0[%18] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %26, %27 {alignment = 4 : i64} : i64, !llvm.ptr
    %28 = llvm.getelementptr %13[%14, %17, 1, %arg1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>)>>
    %29 = llvm.call @strlen(%28) : (!llvm.ptr) -> i64
    %30 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %29, %30 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_strlen_A_pI   : fold_strlen_A_pI_before  ⊑  fold_strlen_A_pI_combined := by
  unfold fold_strlen_A_pI_before fold_strlen_A_pI_combined
  simp_alive_peephole
  sorry
