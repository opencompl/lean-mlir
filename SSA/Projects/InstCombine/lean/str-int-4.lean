import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  str-int-4
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strtol_before := [llvmfunc|
  llvm.func @fold_strtol(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("\09\0D\0A\0B\0C -123\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @ws_im123 : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant("\09\0D\0A\0B\0C +234\00") : !llvm.array<11 x i8>
    %5 = llvm.mlir.addressof @ws_ip234 : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(" 0\00") : !llvm.array<3 x i8>
    %8 = llvm.mlir.addressof @i0 : !llvm.ptr
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.mlir.constant(" 9\00") : !llvm.array<3 x i8>
    %12 = llvm.mlir.addressof @i9 : !llvm.ptr
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.constant(" a\00") : !llvm.array<3 x i8>
    %15 = llvm.mlir.addressof @ia : !llvm.ptr
    %16 = llvm.mlir.constant(16 : i32) : i32
    %17 = llvm.mlir.constant(4 : i32) : i32
    %18 = llvm.mlir.constant("19azAZ\00") : !llvm.array<7 x i8>
    %19 = llvm.mlir.addressof @i19azAZ : !llvm.ptr
    %20 = llvm.mlir.constant(36 : i32) : i32
    %21 = llvm.mlir.constant(5 : i32) : i32
    %22 = llvm.mlir.constant(" -2147483648\00") : !llvm.array<13 x i8>
    %23 = llvm.mlir.addressof @i32min : !llvm.ptr
    %24 = llvm.mlir.constant(6 : i32) : i32
    %25 = llvm.mlir.constant(" -020000000000\00") : !llvm.array<15 x i8>
    %26 = llvm.mlir.addressof @mo32min : !llvm.ptr
    %27 = llvm.mlir.constant(7 : i32) : i32
    %28 = llvm.mlir.constant(" -0x80000000\00") : !llvm.array<13 x i8>
    %29 = llvm.mlir.addressof @mx32min : !llvm.ptr
    %30 = llvm.mlir.constant(8 : i32) : i32
    %31 = llvm.mlir.constant(9 : i32) : i32
    %32 = llvm.mlir.constant(" 2147483647\00") : !llvm.array<12 x i8>
    %33 = llvm.mlir.addressof @i32max : !llvm.ptr
    %34 = llvm.mlir.constant(" 0x7fffffff\00") : !llvm.array<12 x i8>
    %35 = llvm.mlir.addressof @x32max : !llvm.ptr
    %36 = llvm.mlir.constant(11 : i32) : i32
    %37 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.store %37, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %38 = llvm.call @strtol(%5, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %39 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %38, %39 {alignment = 4 : i64} : i32, !llvm.ptr]

    %40 = llvm.call @strtol(%8, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %41 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %40, %41 {alignment = 4 : i64} : i32, !llvm.ptr]

    %42 = llvm.call @strtol(%12, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %43 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %42, %43 {alignment = 4 : i64} : i32, !llvm.ptr]

    %44 = llvm.call @strtol(%15, %2, %16) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %45 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %44, %45 {alignment = 4 : i64} : i32, !llvm.ptr]

    %46 = llvm.call @strtol(%19, %2, %20) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %47 = llvm.getelementptr %arg0[%21] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %46, %47 {alignment = 4 : i64} : i32, !llvm.ptr]

    %48 = llvm.call @strtol(%23, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %49 = llvm.getelementptr %arg0[%24] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %48, %49 {alignment = 4 : i64} : i32, !llvm.ptr]

    %50 = llvm.call @strtol(%26, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %51 = llvm.getelementptr %arg0[%27] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %50, %51 {alignment = 4 : i64} : i32, !llvm.ptr]

    %52 = llvm.call @strtol(%29, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %53 = llvm.getelementptr %arg0[%30] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %52, %53 {alignment = 4 : i64} : i32, !llvm.ptr]

    %54 = llvm.call @strtol(%29, %2, %16) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %55 = llvm.getelementptr %arg0[%31] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %54, %55 {alignment = 4 : i64} : i32, !llvm.ptr]

    %56 = llvm.call @strtol(%33, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %57 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %56, %57 {alignment = 4 : i64} : i32, !llvm.ptr]

    %58 = llvm.call @strtol(%35, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %59 = llvm.getelementptr %arg0[%36] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %58, %59 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def call_strtol_before := [llvmfunc|
  llvm.func @call_strtol(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(" -2147483649\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @i32min_m1 : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant(" 2147483648\00") : !llvm.array<12 x i8>
    %5 = llvm.mlir.addressof @i32max_p1 : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(" +\00") : !llvm.array<3 x i8>
    %8 = llvm.mlir.addressof @wsplus : !llvm.ptr
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.mlir.constant(" a\00") : !llvm.array<3 x i8>
    %12 = llvm.mlir.addressof @ia : !llvm.ptr
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.mlir.constant(" 8\00") : !llvm.array<3 x i8>
    %15 = llvm.mlir.addressof @i8 : !llvm.ptr
    %16 = llvm.mlir.constant(8 : i32) : i32
    %17 = llvm.mlir.constant(4 : i32) : i32
    %18 = llvm.mlir.constant("0x\00") : !llvm.array<3 x i8>
    %19 = llvm.mlir.addressof @x0x : !llvm.ptr
    %20 = llvm.mlir.constant(5 : i32) : i32
    %21 = llvm.mlir.constant(" + 0\00") : !llvm.array<5 x i8>
    %22 = llvm.mlir.addressof @wsplusws0 : !llvm.ptr
    %23 = llvm.mlir.constant(6 : i32) : i32
    %24 = llvm.mlir.constant("19azAZ\00") : !llvm.array<7 x i8>
    %25 = llvm.mlir.addressof @i19azAZ : !llvm.ptr
    %26 = llvm.mlir.constant(35 : i32) : i32
    %27 = llvm.mlir.constant(7 : i32) : i32
    %28 = llvm.mlir.constant(" +020000000000\00") : !llvm.array<15 x i8>
    %29 = llvm.mlir.addressof @o32min : !llvm.ptr
    %30 = llvm.mlir.constant(" +0x80000000\00") : !llvm.array<13 x i8>
    %31 = llvm.mlir.addressof @x32min : !llvm.ptr
    %32 = llvm.mlir.constant(9 : i32) : i32
    %33 = llvm.mlir.constant("\09\0D\0A\0B\0C \00") : !llvm.array<7 x i8>
    %34 = llvm.mlir.addressof @ws : !llvm.ptr
    %35 = llvm.mlir.constant(11 : i32) : i32
    %36 = llvm.mlir.constant(12 : i32) : i32
    %37 = llvm.mlir.constant(" 0\00") : !llvm.array<3 x i8>
    %38 = llvm.mlir.addressof @i0 : !llvm.ptr
    %39 = llvm.mlir.constant(13 : i32) : i32
    %40 = llvm.mlir.constant(256 : i32) : i32
    %41 = llvm.mlir.constant(14 : i32) : i32
    %42 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.store %42, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %43 = llvm.call @strtol(%5, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %44 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %43, %44 {alignment = 4 : i64} : i32, !llvm.ptr]

    %45 = llvm.call @strtol(%8, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %46 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %45, %46 {alignment = 4 : i64} : i32, !llvm.ptr]

    %47 = llvm.call @strtol(%12, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %48 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %47, %48 {alignment = 4 : i64} : i32, !llvm.ptr]

    %49 = llvm.call @strtol(%15, %2, %16) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %50 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %49, %50 {alignment = 4 : i64} : i32, !llvm.ptr]

    %51 = llvm.call @strtol(%19, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %52 = llvm.getelementptr %arg0[%20] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %51, %52 {alignment = 4 : i64} : i32, !llvm.ptr]

    %53 = llvm.call @strtol(%22, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %54 = llvm.getelementptr %arg0[%23] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %53, %54 {alignment = 4 : i64} : i32, !llvm.ptr]

    %55 = llvm.call @strtol(%25, %2, %26) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %56 = llvm.getelementptr %arg0[%27] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %55, %56 {alignment = 4 : i64} : i32, !llvm.ptr]

    %57 = llvm.call @strtol(%29, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %58 = llvm.getelementptr %arg0[%16] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %57, %58 {alignment = 4 : i64} : i32, !llvm.ptr]

    %59 = llvm.call @strtol(%31, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %60 = llvm.getelementptr %arg0[%32] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %59, %60 {alignment = 4 : i64} : i32, !llvm.ptr]

    %61 = llvm.call @strtol(%31, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %62 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %61, %62 {alignment = 4 : i64} : i32, !llvm.ptr]

    %63 = llvm.call @strtol(%34, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %64 = llvm.getelementptr %arg0[%35] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %63, %64 {alignment = 4 : i64} : i32, !llvm.ptr]

    %65 = llvm.getelementptr %34[%9, %23] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<7 x i8>
    %66 = llvm.call @strtol(%65, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %67 = llvm.getelementptr %arg0[%36] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %66, %67 {alignment = 4 : i64} : i32, !llvm.ptr]

    %68 = llvm.call @strtol(%38, %2, %6) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %69 = llvm.getelementptr %arg0[%39] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %68, %69 {alignment = 4 : i64} : i32, !llvm.ptr]

    %70 = llvm.call @strtol(%38, %2, %40) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %71 = llvm.getelementptr %arg0[%41] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %70, %71 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_strtoll_before := [llvmfunc|
  llvm.func @fold_strtoll(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("\09\0D\0A\0B\0C -123\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @ws_im123 : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant("\09\0D\0A\0B\0C +234\00") : !llvm.array<11 x i8>
    %5 = llvm.mlir.addressof @ws_ip234 : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(" -9223372036854775808\00") : !llvm.array<22 x i8>
    %8 = llvm.mlir.addressof @i64min : !llvm.ptr
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.mlir.constant(" 9223372036854775807\00") : !llvm.array<21 x i8>
    %11 = llvm.mlir.addressof @i64max : !llvm.ptr
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.call @strtoll(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.store %13, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %14 = llvm.call @strtoll(%5, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %15 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %14, %15 {alignment = 4 : i64} : i64, !llvm.ptr]

    %16 = llvm.call @strtoll(%8, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %17 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %16, %17 {alignment = 4 : i64} : i64, !llvm.ptr]

    %18 = llvm.call @strtoll(%11, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %19 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %18, %19 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def call_strtoll_before := [llvmfunc|
  llvm.func @call_strtoll(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(" -9223372036854775809\00") : !llvm.array<22 x i8>
    %1 = llvm.mlir.addressof @i64min_m1 : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant(" 9223372036854775808\00") : !llvm.array<21 x i8>
    %5 = llvm.mlir.addressof @i64max_p1 : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant("\09\0D\0A\0B\0C \00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.addressof @ws : !llvm.ptr
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.constant(6 : i32) : i32
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.call @strtoll(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.store %13, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %14 = llvm.call @strtoll(%5, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %15 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %14, %15 {alignment = 4 : i64} : i64, !llvm.ptr]

    %16 = llvm.call @strtoll(%8, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %17 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %16, %17 {alignment = 4 : i64} : i64, !llvm.ptr]

    %18 = llvm.getelementptr %8[%10, %11] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<7 x i8>
    %19 = llvm.call @strtoll(%18, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %20 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %19, %20 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def call_strtol_trailing_space_before := [llvmfunc|
  llvm.func @call_strtol_trailing_space(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(" 1 2\09\\3\0A\00") : !llvm.array<9 x i8>
    %1 = llvm.mlir.addressof @i_1_2_3_ : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.constant(4 : i32) : i32
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %10 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %9, %10 {alignment = 4 : i64} : i32, !llvm.ptr]

    %11 = llvm.getelementptr %1[%5, %6] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<9 x i8>
    %12 = llvm.call @strtol(%11, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %13 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %12, %13 {alignment = 4 : i64} : i32, !llvm.ptr]

    %14 = llvm.getelementptr %1[%5, %7] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<9 x i8>
    %15 = llvm.call @strtol(%14, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %16 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %15, %16 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_strtol_combined := [llvmfunc|
  llvm.func @fold_strtol(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\09\0D\0A\0B\0C -123\00") : !llvm.array<11 x i8>
    %3 = llvm.mlir.addressof @ws_im123 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<11 x i8>
    %5 = llvm.mlir.addressof @endptr : !llvm.ptr
    %6 = llvm.mlir.constant(-123 : i32) : i32
    %7 = llvm.mlir.constant("\09\0D\0A\0B\0C +234\00") : !llvm.array<11 x i8>
    %8 = llvm.mlir.addressof @ws_ip234 : !llvm.ptr
    %9 = llvm.getelementptr inbounds %8[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<11 x i8>
    %10 = llvm.mlir.constant(1 : i64) : i64
    %11 = llvm.mlir.constant(234 : i32) : i32
    %12 = llvm.mlir.constant(2 : i64) : i64
    %13 = llvm.mlir.constant(" 0\00") : !llvm.array<3 x i8>
    %14 = llvm.mlir.addressof @i0 : !llvm.ptr
    %15 = llvm.getelementptr inbounds %14[%1, %12] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %16 = llvm.mlir.constant(0 : i32) : i32
    %17 = llvm.mlir.constant(" 9\00") : !llvm.array<3 x i8>
    %18 = llvm.mlir.addressof @i9 : !llvm.ptr
    %19 = llvm.getelementptr inbounds %18[%1, %12] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %20 = llvm.mlir.constant(3 : i64) : i64
    %21 = llvm.mlir.constant(9 : i32) : i32
    %22 = llvm.mlir.constant(" a\00") : !llvm.array<3 x i8>
    %23 = llvm.mlir.addressof @ia : !llvm.ptr
    %24 = llvm.getelementptr inbounds %23[%1, %12] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %25 = llvm.mlir.constant(4 : i64) : i64
    %26 = llvm.mlir.constant(10 : i32) : i32
    %27 = llvm.mlir.constant(6 : i64) : i64
    %28 = llvm.mlir.constant("19azAZ\00") : !llvm.array<7 x i8>
    %29 = llvm.mlir.addressof @i19azAZ : !llvm.ptr
    %30 = llvm.getelementptr inbounds %29[%1, %27] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %31 = llvm.mlir.constant(5 : i64) : i64
    %32 = llvm.mlir.constant(76095035 : i32) : i32
    %33 = llvm.mlir.constant(12 : i64) : i64
    %34 = llvm.mlir.constant(" -2147483648\00") : !llvm.array<13 x i8>
    %35 = llvm.mlir.addressof @i32min : !llvm.ptr
    %36 = llvm.getelementptr inbounds %35[%1, %33] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<13 x i8>
    %37 = llvm.mlir.constant(-2147483648 : i32) : i32
    %38 = llvm.mlir.constant(14 : i64) : i64
    %39 = llvm.mlir.constant(" -020000000000\00") : !llvm.array<15 x i8>
    %40 = llvm.mlir.addressof @mo32min : !llvm.ptr
    %41 = llvm.getelementptr inbounds %40[%1, %38] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<15 x i8>
    %42 = llvm.mlir.constant(7 : i64) : i64
    %43 = llvm.mlir.constant(" -0x80000000\00") : !llvm.array<13 x i8>
    %44 = llvm.mlir.addressof @mx32min : !llvm.ptr
    %45 = llvm.getelementptr inbounds %44[%1, %33] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<13 x i8>
    %46 = llvm.mlir.constant(8 : i64) : i64
    %47 = llvm.mlir.constant(9 : i64) : i64
    %48 = llvm.mlir.constant(11 : i64) : i64
    %49 = llvm.mlir.constant(" 2147483647\00") : !llvm.array<12 x i8>
    %50 = llvm.mlir.addressof @i32max : !llvm.ptr
    %51 = llvm.getelementptr inbounds %50[%1, %48] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<12 x i8>
    %52 = llvm.mlir.constant(2147483647 : i32) : i32
    %53 = llvm.mlir.constant(" 0x7fffffff\00") : !llvm.array<12 x i8>
    %54 = llvm.mlir.addressof @x32max : !llvm.ptr
    %55 = llvm.getelementptr inbounds %54[%1, %48] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<12 x i8>
    llvm.store %4, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    llvm.store %9, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    %56 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %11, %56 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    llvm.store %15, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    %57 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %16, %57 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    llvm.store %19, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    %58 = llvm.getelementptr %arg0[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %21, %58 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    llvm.store %24, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    %59 = llvm.getelementptr %arg0[%25] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %26, %59 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    llvm.store %30, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    %60 = llvm.getelementptr %arg0[%31] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %32, %60 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    llvm.store %36, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    %61 = llvm.getelementptr %arg0[%27] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %37, %61 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    llvm.store %41, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    %62 = llvm.getelementptr %arg0[%42] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %37, %62 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    llvm.store %45, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    %63 = llvm.getelementptr %arg0[%46] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %37, %63 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    llvm.store %45, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    %64 = llvm.getelementptr %arg0[%47] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %37, %64 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    llvm.store %51, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    %65 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %52, %65 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    llvm.store %55, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    %66 = llvm.getelementptr %arg0[%48] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %52, %66 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strtol   : fold_strtol_before  ⊑  fold_strtol_combined := by
  unfold fold_strtol_before fold_strtol_combined
  simp_alive_peephole
  sorry
def call_strtol_combined := [llvmfunc|
  llvm.func @call_strtol(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(" -2147483649\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @i32min_m1 : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant(" 2147483648\00") : !llvm.array<12 x i8>
    %5 = llvm.mlir.addressof @i32max_p1 : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant(" +\00") : !llvm.array<3 x i8>
    %8 = llvm.mlir.addressof @wsplus : !llvm.ptr
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.constant(2 : i64) : i64
    %11 = llvm.mlir.constant(" a\00") : !llvm.array<3 x i8>
    %12 = llvm.mlir.addressof @ia : !llvm.ptr
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.mlir.constant(" 8\00") : !llvm.array<3 x i8>
    %15 = llvm.mlir.addressof @i8 : !llvm.ptr
    %16 = llvm.mlir.constant(8 : i32) : i32
    %17 = llvm.mlir.constant(4 : i64) : i64
    %18 = llvm.mlir.constant("0x\00") : !llvm.array<3 x i8>
    %19 = llvm.mlir.addressof @x0x : !llvm.ptr
    %20 = llvm.mlir.constant(5 : i64) : i64
    %21 = llvm.mlir.constant(" + 0\00") : !llvm.array<5 x i8>
    %22 = llvm.mlir.addressof @wsplusws0 : !llvm.ptr
    %23 = llvm.mlir.constant(6 : i64) : i64
    %24 = llvm.mlir.constant("19azAZ\00") : !llvm.array<7 x i8>
    %25 = llvm.mlir.addressof @i19azAZ : !llvm.ptr
    %26 = llvm.mlir.constant(35 : i32) : i32
    %27 = llvm.mlir.constant(7 : i64) : i64
    %28 = llvm.mlir.constant(" +020000000000\00") : !llvm.array<15 x i8>
    %29 = llvm.mlir.addressof @o32min : !llvm.ptr
    %30 = llvm.mlir.constant(8 : i64) : i64
    %31 = llvm.mlir.constant(" +0x80000000\00") : !llvm.array<13 x i8>
    %32 = llvm.mlir.addressof @x32min : !llvm.ptr
    %33 = llvm.mlir.constant(9 : i64) : i64
    %34 = llvm.mlir.constant(10 : i64) : i64
    %35 = llvm.mlir.constant("\09\0D\0A\0B\0C \00") : !llvm.array<7 x i8>
    %36 = llvm.mlir.addressof @ws : !llvm.ptr
    %37 = llvm.mlir.constant(11 : i64) : i64
    %38 = llvm.mlir.constant(0 : i64) : i64
    %39 = llvm.getelementptr inbounds %36[%38, %23] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %40 = llvm.mlir.constant(12 : i64) : i64
    %41 = llvm.mlir.constant(" 0\00") : !llvm.array<3 x i8>
    %42 = llvm.mlir.addressof @i0 : !llvm.ptr
    %43 = llvm.mlir.constant(1 : i32) : i32
    %44 = llvm.mlir.constant(13 : i64) : i64
    %45 = llvm.mlir.constant(256 : i32) : i32
    %46 = llvm.mlir.constant(14 : i64) : i64
    %47 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.store %47, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %48 = llvm.call @strtol(%5, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %49 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %48, %49 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %50 = llvm.call @strtol(%8, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %51 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %50, %51 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %52 = llvm.call @strtol(%12, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %53 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %52, %53 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %54 = llvm.call @strtol(%15, %2, %16) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %55 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %54, %55 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %56 = llvm.call @strtol(%19, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %57 = llvm.getelementptr %arg0[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %56, %57 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %58 = llvm.call @strtol(%22, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %59 = llvm.getelementptr %arg0[%23] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %58, %59 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %60 = llvm.call @strtol(%25, %2, %26) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %61 = llvm.getelementptr %arg0[%27] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %60, %61 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %62 = llvm.call @strtol(%29, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %63 = llvm.getelementptr %arg0[%30] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %62, %63 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %64 = llvm.call @strtol(%32, %2, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %65 = llvm.getelementptr %arg0[%33] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %64, %65 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %66 = llvm.call @strtol(%32, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %67 = llvm.getelementptr %arg0[%34] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %66, %67 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %68 = llvm.call @strtol(%36, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %69 = llvm.getelementptr %arg0[%37] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %68, %69 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %70 = llvm.call @strtol(%39, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %71 = llvm.getelementptr %arg0[%40] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %70, %71 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %72 = llvm.call @strtol(%42, %2, %43) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %73 = llvm.getelementptr %arg0[%44] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %72, %73 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    %74 = llvm.call @strtol(%42, %2, %45) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %75 = llvm.getelementptr %arg0[%46] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %74, %75 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_call_strtol   : call_strtol_before  ⊑  call_strtol_combined := by
  unfold call_strtol_before call_strtol_combined
  simp_alive_peephole
  sorry
def fold_strtoll_combined := [llvmfunc|
  llvm.func @fold_strtoll(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\09\0D\0A\0B\0C -123\00") : !llvm.array<11 x i8>
    %3 = llvm.mlir.addressof @ws_im123 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<11 x i8>
    %5 = llvm.mlir.addressof @endptr : !llvm.ptr
    %6 = llvm.mlir.constant(-123 : i64) : i64
    %7 = llvm.mlir.constant("\09\0D\0A\0B\0C +234\00") : !llvm.array<11 x i8>
    %8 = llvm.mlir.addressof @ws_ip234 : !llvm.ptr
    %9 = llvm.getelementptr inbounds %8[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<11 x i8>
    %10 = llvm.mlir.constant(1 : i64) : i64
    %11 = llvm.mlir.constant(234 : i64) : i64
    %12 = llvm.mlir.constant(21 : i64) : i64
    %13 = llvm.mlir.constant(" -9223372036854775808\00") : !llvm.array<22 x i8>
    %14 = llvm.mlir.addressof @i64min : !llvm.ptr
    %15 = llvm.getelementptr inbounds %14[%1, %12] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<22 x i8>
    %16 = llvm.mlir.constant(2 : i64) : i64
    %17 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %18 = llvm.mlir.constant(20 : i64) : i64
    %19 = llvm.mlir.constant(" 9223372036854775807\00") : !llvm.array<21 x i8>
    %20 = llvm.mlir.addressof @i64max : !llvm.ptr
    %21 = llvm.getelementptr inbounds %20[%1, %18] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<21 x i8>
    %22 = llvm.mlir.constant(3 : i64) : i64
    %23 = llvm.mlir.constant(9223372036854775807 : i64) : i64
    llvm.store %4, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtoll   : fold_strtoll_before  ⊑  fold_strtoll_combined := by
  unfold fold_strtoll_before fold_strtoll_combined
  simp_alive_peephole
  sorry
    llvm.store %6, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strtoll   : fold_strtoll_before  ⊑  fold_strtoll_combined := by
  unfold fold_strtoll_before fold_strtoll_combined
  simp_alive_peephole
  sorry
    llvm.store %9, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtoll   : fold_strtoll_before  ⊑  fold_strtoll_combined := by
  unfold fold_strtoll_before fold_strtoll_combined
  simp_alive_peephole
  sorry
    %24 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %11, %24 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strtoll   : fold_strtoll_before  ⊑  fold_strtoll_combined := by
  unfold fold_strtoll_before fold_strtoll_combined
  simp_alive_peephole
  sorry
    llvm.store %15, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtoll   : fold_strtoll_before  ⊑  fold_strtoll_combined := by
  unfold fold_strtoll_before fold_strtoll_combined
  simp_alive_peephole
  sorry
    %25 = llvm.getelementptr %arg0[%16] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %17, %25 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strtoll   : fold_strtoll_before  ⊑  fold_strtoll_combined := by
  unfold fold_strtoll_before fold_strtoll_combined
  simp_alive_peephole
  sorry
    llvm.store %21, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strtoll   : fold_strtoll_before  ⊑  fold_strtoll_combined := by
  unfold fold_strtoll_before fold_strtoll_combined
  simp_alive_peephole
  sorry
    %26 = llvm.getelementptr %arg0[%22] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %23, %26 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strtoll   : fold_strtoll_before  ⊑  fold_strtoll_combined := by
  unfold fold_strtoll_before fold_strtoll_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strtoll   : fold_strtoll_before  ⊑  fold_strtoll_combined := by
  unfold fold_strtoll_before fold_strtoll_combined
  simp_alive_peephole
  sorry
def call_strtoll_combined := [llvmfunc|
  llvm.func @call_strtoll(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(" -9223372036854775809\00") : !llvm.array<22 x i8>
    %1 = llvm.mlir.addressof @i64min_m1 : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant(" 9223372036854775808\00") : !llvm.array<21 x i8>
    %5 = llvm.mlir.addressof @i64max_p1 : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant("\09\0D\0A\0B\0C \00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.addressof @ws : !llvm.ptr
    %9 = llvm.mlir.constant(2 : i64) : i64
    %10 = llvm.mlir.constant(6 : i64) : i64
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.getelementptr inbounds %8[%11, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.call @strtoll(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.store %14, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_call_strtoll   : call_strtoll_before  ⊑  call_strtoll_combined := by
  unfold call_strtoll_before call_strtoll_combined
  simp_alive_peephole
  sorry
    %15 = llvm.call @strtoll(%5, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %16 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %15, %16 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_call_strtoll   : call_strtoll_before  ⊑  call_strtoll_combined := by
  unfold call_strtoll_before call_strtoll_combined
  simp_alive_peephole
  sorry
    %17 = llvm.call @strtoll(%8, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %18 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %17, %18 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_call_strtoll   : call_strtoll_before  ⊑  call_strtoll_combined := by
  unfold call_strtoll_before call_strtoll_combined
  simp_alive_peephole
  sorry
    %19 = llvm.call @strtoll(%12, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %20 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %19, %20 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_call_strtoll   : call_strtoll_before  ⊑  call_strtoll_combined := by
  unfold call_strtoll_before call_strtoll_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_call_strtoll   : call_strtoll_before  ⊑  call_strtoll_combined := by
  unfold call_strtoll_before call_strtoll_combined
  simp_alive_peephole
  sorry
def call_strtol_trailing_space_combined := [llvmfunc|
  llvm.func @call_strtol_trailing_space(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(" 1 2\09\\3\0A\00") : !llvm.array<9 x i8>
    %1 = llvm.mlir.addressof @i_1_2_3_ : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.getelementptr inbounds %1[%6, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<9 x i8>
    %8 = llvm.mlir.constant(4 : i64) : i64
    %9 = llvm.getelementptr inbounds %1[%6, %8] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<9 x i8>
    %10 = llvm.mlir.constant(3 : i64) : i64
    %11 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %12 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %11, %12 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol_trailing_space   : call_strtol_trailing_space_before  ⊑  call_strtol_trailing_space_combined := by
  unfold call_strtol_trailing_space_before call_strtol_trailing_space_combined
  simp_alive_peephole
  sorry
    %13 = llvm.call @strtol(%7, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %14 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %13, %14 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol_trailing_space   : call_strtol_trailing_space_before  ⊑  call_strtol_trailing_space_combined := by
  unfold call_strtol_trailing_space_before call_strtol_trailing_space_combined
  simp_alive_peephole
  sorry
    %15 = llvm.call @strtol(%9, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %16 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %15, %16 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strtol_trailing_space   : call_strtol_trailing_space_before  ⊑  call_strtol_trailing_space_combined := by
  unfold call_strtol_trailing_space_before call_strtol_trailing_space_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_call_strtol_trailing_space   : call_strtol_trailing_space_before  ⊑  call_strtol_trailing_space_combined := by
  unfold call_strtol_trailing_space_before call_strtol_trailing_space_combined
  simp_alive_peephole
  sorry
