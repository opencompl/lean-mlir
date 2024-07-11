import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  str-int-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_atoi_member_before := [llvmfunc|
  llvm.func @fold_atoi_member(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %7 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %9 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %12 = llvm.insertvalue %8, %11[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %13 = llvm.insertvalue %7, %12[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %14 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %16 = llvm.insertvalue %6, %15[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %17 = llvm.mlir.addressof @a : !llvm.ptr
    %18 = llvm.mlir.constant(0 : i64) : i64
    %19 = llvm.mlir.constant(1 : i32) : i32
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.mlir.constant(0 : i32) : i32
    %22 = llvm.mlir.constant(2 : i32) : i32
    %23 = llvm.mlir.constant(3 : i32) : i32
    %24 = llvm.call @atoi(%17) : (!llvm.ptr) -> i32
    llvm.store %24, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %25 = llvm.getelementptr %17[%18, %18, 1, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %26 = llvm.call @atoi(%25) : (!llvm.ptr) -> i32
    %27 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %26, %27 {alignment = 4 : i64} : i32, !llvm.ptr]

    %28 = llvm.getelementptr %17[%18, %20, 0, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %29 = llvm.call @atoi(%28) : (!llvm.ptr) -> i32
    %30 = llvm.getelementptr %arg0[%22] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %29, %30 {alignment = 4 : i64} : i32, !llvm.ptr]

    %31 = llvm.getelementptr %17[%18, %20, 1, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %32 = llvm.call @atoi(%31) : (!llvm.ptr) -> i32
    %33 = llvm.getelementptr %arg0[%23] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %32, %33 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_atoi_offset_out_of_bounds_before := [llvmfunc|
  llvm.func @fold_atoi_offset_out_of_bounds(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %4 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %5 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %6 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %8 = llvm.insertvalue %4, %7[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %9 = llvm.insertvalue %3, %8[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %10 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %11 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %12 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %13 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %14 = llvm.insertvalue %12, %13[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %15 = llvm.insertvalue %11, %14[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %16 = llvm.insertvalue %10, %15[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %17 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %18 = llvm.insertvalue %16, %17[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %19 = llvm.insertvalue %9, %18[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %20 = llvm.mlir.addressof @a : !llvm.ptr
    %21 = llvm.getelementptr inbounds %20[%2, %0, 0, %0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %22 = llvm.mlir.constant(33 : i64) : i64
    %23 = llvm.call @atoi(%21) : (!llvm.ptr) -> i32
    llvm.store %23, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %24 = llvm.getelementptr %20[%0, %0, 0, %22] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %25 = llvm.call @atoi(%24) : (!llvm.ptr) -> i32
    llvm.store %25, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_atol_member_before := [llvmfunc|
  llvm.func @fold_atol_member(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %7 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %9 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %12 = llvm.insertvalue %8, %11[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %13 = llvm.insertvalue %7, %12[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %14 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %16 = llvm.insertvalue %6, %15[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %17 = llvm.mlir.addressof @a : !llvm.ptr
    %18 = llvm.mlir.constant(0 : i64) : i64
    %19 = llvm.mlir.constant(1 : i32) : i32
    %20 = llvm.mlir.constant(2 : i32) : i32
    %21 = llvm.mlir.constant(1 : i64) : i64
    %22 = llvm.mlir.constant(0 : i32) : i32
    %23 = llvm.mlir.constant(3 : i32) : i32
    %24 = llvm.mlir.constant(4 : i32) : i32
    %25 = llvm.mlir.constant(5 : i32) : i32
    %26 = llvm.call @atol(%17) : (!llvm.ptr) -> i64
    llvm.store %26, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %27 = llvm.getelementptr %17[%18, %18, 1, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %28 = llvm.call @atol(%27) : (!llvm.ptr) -> i64
    %29 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %28, %29 {alignment = 4 : i64} : i64, !llvm.ptr]

    %30 = llvm.getelementptr %17[%18, %18, 2, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %31 = llvm.call @atol(%30) : (!llvm.ptr) -> i64
    %32 = llvm.getelementptr %arg0[%20] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %31, %32 {alignment = 4 : i64} : i64, !llvm.ptr]

    %33 = llvm.getelementptr %17[%18, %21, 0, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %34 = llvm.call @atol(%33) : (!llvm.ptr) -> i64
    %35 = llvm.getelementptr %arg0[%23] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %34, %35 {alignment = 4 : i64} : i64, !llvm.ptr]

    %36 = llvm.getelementptr %17[%18, %21, 1, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %37 = llvm.call @atol(%36) : (!llvm.ptr) -> i64
    %38 = llvm.getelementptr %arg0[%24] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %37, %38 {alignment = 4 : i64} : i64, !llvm.ptr]

    %39 = llvm.getelementptr %17[%18, %21, 2, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %40 = llvm.call @atol(%39) : (!llvm.ptr) -> i64
    %41 = llvm.getelementptr %arg0[%25] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %40, %41 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def fold_atoll_member_pC_before := [llvmfunc|
  llvm.func @fold_atoll_member_pC(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %7 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %9 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %12 = llvm.insertvalue %8, %11[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %13 = llvm.insertvalue %7, %12[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %14 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %16 = llvm.insertvalue %6, %15[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %17 = llvm.mlir.addressof @a : !llvm.ptr
    %18 = llvm.mlir.constant(0 : i64) : i64
    %19 = llvm.mlir.constant(1 : i32) : i32
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.mlir.constant(2 : i32) : i32
    %22 = llvm.mlir.constant(3 : i64) : i64
    %23 = llvm.mlir.constant(0 : i32) : i32
    %24 = llvm.mlir.constant(2 : i64) : i64
    %25 = llvm.mlir.constant(3 : i32) : i32
    %26 = llvm.mlir.constant(4 : i32) : i32
    %27 = llvm.mlir.constant(4 : i64) : i64
    %28 = llvm.mlir.constant(5 : i32) : i32
    %29 = llvm.call @atol(%17) : (!llvm.ptr) -> i64
    llvm.store %29, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %30 = llvm.getelementptr %17[%18, %18, 1, %20] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %31 = llvm.call @atol(%30) : (!llvm.ptr) -> i64
    %32 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %31, %32 {alignment = 4 : i64} : i64, !llvm.ptr]

    %33 = llvm.getelementptr %17[%18, %18, 2, %22] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %34 = llvm.call @atol(%33) : (!llvm.ptr) -> i64
    %35 = llvm.getelementptr %arg0[%21] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %34, %35 {alignment = 4 : i64} : i64, !llvm.ptr]

    %36 = llvm.getelementptr %17[%18, %20, 0, %24] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %37 = llvm.call @atol(%36) : (!llvm.ptr) -> i64
    %38 = llvm.getelementptr %arg0[%25] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %37, %38 {alignment = 4 : i64} : i64, !llvm.ptr]

    %39 = llvm.getelementptr %17[%18, %20, 1, %22] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %40 = llvm.call @atol(%39) : (!llvm.ptr) -> i64
    %41 = llvm.getelementptr %arg0[%26] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %40, %41 {alignment = 4 : i64} : i64, !llvm.ptr]

    %42 = llvm.getelementptr %17[%18, %20, 2, %27] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %43 = llvm.call @atol(%42) : (!llvm.ptr) -> i64
    %44 = llvm.getelementptr %arg0[%28] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %43, %44 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def fold_strtol_member_pC_before := [llvmfunc|
  llvm.func @fold_strtol_member_pC(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %7 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %9 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %12 = llvm.insertvalue %8, %11[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %13 = llvm.insertvalue %7, %12[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %14 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %16 = llvm.insertvalue %6, %15[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %17 = llvm.mlir.addressof @a : !llvm.ptr
    %18 = llvm.mlir.zero : !llvm.ptr
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.mlir.constant(1 : i32) : i32
    %22 = llvm.mlir.constant(1 : i64) : i64
    %23 = llvm.mlir.constant(2 : i32) : i32
    %24 = llvm.mlir.constant(3 : i64) : i64
    %25 = llvm.mlir.constant(2 : i64) : i64
    %26 = llvm.mlir.constant(3 : i32) : i32
    %27 = llvm.mlir.constant(4 : i32) : i32
    %28 = llvm.mlir.constant(4 : i64) : i64
    %29 = llvm.mlir.constant(5 : i32) : i32
    %30 = llvm.call @strtol(%17, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.store %30, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %31 = llvm.getelementptr %17[%20, %20, 1, %22] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %32 = llvm.call @strtol(%31, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %33 = llvm.getelementptr %arg0[%21] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %32, %33 {alignment = 4 : i64} : i64, !llvm.ptr]

    %34 = llvm.getelementptr %17[%20, %20, 2, %24] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %35 = llvm.call @strtol(%34, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %36 = llvm.getelementptr %arg0[%23] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %35, %36 {alignment = 4 : i64} : i64, !llvm.ptr]

    %37 = llvm.getelementptr %17[%20, %22, 0, %25] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %38 = llvm.call @strtol(%37, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %39 = llvm.getelementptr %arg0[%26] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %38, %39 {alignment = 4 : i64} : i64, !llvm.ptr]

    %40 = llvm.getelementptr %17[%20, %22, 1, %24] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %41 = llvm.call @strtol(%40, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %42 = llvm.getelementptr %arg0[%27] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %41, %42 {alignment = 4 : i64} : i64, !llvm.ptr]

    %43 = llvm.getelementptr %17[%20, %22, 2, %28] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %44 = llvm.call @strtol(%43, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %45 = llvm.getelementptr %arg0[%29] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %44, %45 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def fold_strtoll_member_pC_before := [llvmfunc|
  llvm.func @fold_strtoll_member_pC(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %6 = llvm.insertvalue %0, %5[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %7 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %9 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %12 = llvm.insertvalue %8, %11[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %13 = llvm.insertvalue %7, %12[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %14 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %15 = llvm.insertvalue %13, %14[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %16 = llvm.insertvalue %6, %15[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %17 = llvm.mlir.addressof @a : !llvm.ptr
    %18 = llvm.mlir.zero : !llvm.ptr
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.mlir.constant(0 : i64) : i64
    %21 = llvm.mlir.constant(1 : i32) : i32
    %22 = llvm.mlir.constant(1 : i64) : i64
    %23 = llvm.mlir.constant(2 : i32) : i32
    %24 = llvm.mlir.constant(3 : i64) : i64
    %25 = llvm.mlir.constant(2 : i64) : i64
    %26 = llvm.mlir.constant(3 : i32) : i32
    %27 = llvm.mlir.constant(4 : i32) : i32
    %28 = llvm.mlir.constant(4 : i64) : i64
    %29 = llvm.mlir.constant(5 : i32) : i32
    %30 = llvm.call @strtoll(%17, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.store %30, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %31 = llvm.getelementptr %17[%20, %20, 1, %22] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %32 = llvm.call @strtoll(%31, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %33 = llvm.getelementptr %arg0[%21] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %32, %33 {alignment = 4 : i64} : i64, !llvm.ptr]

    %34 = llvm.getelementptr %17[%20, %20, 2, %24] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %35 = llvm.call @strtoll(%34, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %36 = llvm.getelementptr %arg0[%23] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %35, %36 {alignment = 4 : i64} : i64, !llvm.ptr]

    %37 = llvm.getelementptr %17[%20, %22, 0, %25] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %38 = llvm.call @strtoll(%37, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %39 = llvm.getelementptr %arg0[%26] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %38, %39 {alignment = 4 : i64} : i64, !llvm.ptr]

    %40 = llvm.getelementptr %17[%20, %22, 1, %24] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %41 = llvm.call @strtoll(%40, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %42 = llvm.getelementptr %arg0[%27] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %41, %42 {alignment = 4 : i64} : i64, !llvm.ptr]

    %43 = llvm.getelementptr %17[%20, %22, 2, %28] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %44 = llvm.call @strtoll(%43, %18, %19) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %45 = llvm.getelementptr %arg0[%29] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %44, %45 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def fold_atoi_member_combined := [llvmfunc|
  llvm.func @fold_atoi_member(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(12 : i32) : i32
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(123 : i32) : i32
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(1234 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    %8 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %4, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %6, %9 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_atoi_member   : fold_atoi_member_before  ⊑  fold_atoi_member_combined := by
  unfold fold_atoi_member_before fold_atoi_member_combined
  simp_alive_peephole
  sorry
def fold_atoi_offset_out_of_bounds_combined := [llvmfunc|
  llvm.func @fold_atoi_offset_out_of_bounds(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant("67890\00\00") : !llvm.array<7 x i8>
    %4 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %5 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %6 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %8 = llvm.insertvalue %4, %7[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %9 = llvm.insertvalue %3, %8[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %10 = llvm.mlir.constant("56789\00\00") : !llvm.array<7 x i8>
    %11 = llvm.mlir.constant("12\00\00\00") : !llvm.array<5 x i8>
    %12 = llvm.mlir.constant("1\00\00\00") : !llvm.array<4 x i8>
    %13 = llvm.mlir.undef : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>
    %14 = llvm.insertvalue %12, %13[0] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %15 = llvm.insertvalue %11, %14[1] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %16 = llvm.insertvalue %10, %15[2] : !llvm.struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)> 
    %17 = llvm.mlir.undef : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %18 = llvm.insertvalue %16, %17[0] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %19 = llvm.insertvalue %9, %18[1] : !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>> 
    %20 = llvm.mlir.addressof @a : !llvm.ptr
    %21 = llvm.getelementptr inbounds %20[%2, %0, 0, %0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %22 = llvm.getelementptr %20[%2, %0, 0, %2] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"struct.A", (array<4 x i8>, array<5 x i8>, array<7 x i8>)>>
    %23 = llvm.call @atoi(%21) : (!llvm.ptr) -> i32
    llvm.store %23, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %24 = llvm.call @atoi(%22) : (!llvm.ptr) -> i32
    llvm.store %24, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_atoi_offset_out_of_bounds   : fold_atoi_offset_out_of_bounds_before  ⊑  fold_atoi_offset_out_of_bounds_combined := by
  unfold fold_atoi_offset_out_of_bounds_before fold_atoi_offset_out_of_bounds_combined
  simp_alive_peephole
  sorry
def fold_atol_member_combined := [llvmfunc|
  llvm.func @fold_atol_member(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(12 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(56789 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.mlir.constant(123 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(1234 : i64) : i64
    %8 = llvm.mlir.constant(5 : i64) : i64
    %9 = llvm.mlir.constant(67890 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %10 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %10 {alignment = 4 : i64} : i64, !llvm.ptr
    %11 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %3, %11 {alignment = 4 : i64} : i64, !llvm.ptr
    %12 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %5, %12 {alignment = 4 : i64} : i64, !llvm.ptr
    %13 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %7, %13 {alignment = 4 : i64} : i64, !llvm.ptr
    %14 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %9, %14 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_atol_member   : fold_atol_member_before  ⊑  fold_atol_member_combined := by
  unfold fold_atol_member_before fold_atol_member_combined
  simp_alive_peephole
  sorry
def fold_atoll_member_pC_combined := [llvmfunc|
  llvm.func @fold_atoll_member_pC(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(89 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %7 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %7 {alignment = 4 : i64} : i64, !llvm.ptr
    %8 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %2, %8 {alignment = 4 : i64} : i64, !llvm.ptr
    %9 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %3, %9 {alignment = 4 : i64} : i64, !llvm.ptr
    %10 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %4, %10 {alignment = 4 : i64} : i64, !llvm.ptr
    %11 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %6, %11 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_atoll_member_pC   : fold_atoll_member_pC_before  ⊑  fold_atoll_member_pC_combined := by
  unfold fold_atoll_member_pC_before fold_atoll_member_pC_combined
  simp_alive_peephole
  sorry
def fold_strtol_member_pC_combined := [llvmfunc|
  llvm.func @fold_strtol_member_pC(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(89 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %7 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %7 {alignment = 4 : i64} : i64, !llvm.ptr
    %8 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %2, %8 {alignment = 4 : i64} : i64, !llvm.ptr
    %9 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %3, %9 {alignment = 4 : i64} : i64, !llvm.ptr
    %10 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %4, %10 {alignment = 4 : i64} : i64, !llvm.ptr
    %11 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %6, %11 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_strtol_member_pC   : fold_strtol_member_pC_before  ⊑  fold_strtol_member_pC_combined := by
  unfold fold_strtol_member_pC_before fold_strtol_member_pC_combined
  simp_alive_peephole
  sorry
def fold_strtoll_member_pC_combined := [llvmfunc|
  llvm.func @fold_strtoll_member_pC(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(89 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %7 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %7 {alignment = 4 : i64} : i64, !llvm.ptr
    %8 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %2, %8 {alignment = 4 : i64} : i64, !llvm.ptr
    %9 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %3, %9 {alignment = 4 : i64} : i64, !llvm.ptr
    %10 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %4, %10 {alignment = 4 : i64} : i64, !llvm.ptr
    %11 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %6, %11 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_strtoll_member_pC   : fold_strtoll_member_pC_before  ⊑  fold_strtoll_member_pC_combined := by
  unfold fold_strtoll_member_pC_before fold_strtoll_member_pC_combined
  simp_alive_peephole
  sorry
