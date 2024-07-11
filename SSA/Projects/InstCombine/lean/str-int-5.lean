import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  str-int-5
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strtoul_before := [llvmfunc|
  llvm.func @fold_strtoul(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("\09\0D\0A\0B\0C -123\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @ws_im123 : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant("\09\0D\0A\0B\0C +234\00") : !llvm.array<11 x i8>
    %5 = llvm.mlir.addressof @ws_ip234 : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(" -2147483649\00") : !llvm.array<13 x i8>
    %8 = llvm.mlir.addressof @i32min_m1 : !llvm.ptr
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.mlir.constant(" -2147483648\00") : !llvm.array<13 x i8>
    %11 = llvm.mlir.addressof @i32min : !llvm.ptr
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.mlir.constant(" +020000000000\00") : !llvm.array<15 x i8>
    %14 = llvm.mlir.addressof @o32min : !llvm.ptr
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.mlir.constant(4 : i32) : i32
    %17 = llvm.mlir.constant(" -020000000000\00") : !llvm.array<15 x i8>
    %18 = llvm.mlir.addressof @mo32min : !llvm.ptr
    %19 = llvm.mlir.constant(5 : i32) : i32
    %20 = llvm.mlir.constant(" +0x80000000\00") : !llvm.array<13 x i8>
    %21 = llvm.mlir.addressof @x32min : !llvm.ptr
    %22 = llvm.mlir.constant(6 : i32) : i32
    %23 = llvm.mlir.addressof @mx32min : !llvm.ptr
    %24 = llvm.mlir.constant(7 : i32) : i32
    %25 = llvm.mlir.constant(" 2147483647\00") : !llvm.array<12 x i8>
    %26 = llvm.mlir.addressof @i32max : !llvm.ptr
    %27 = llvm.mlir.constant(8 : i32) : i32
    %28 = llvm.mlir.constant(" -0X1\00") : !llvm.array<6 x i8>
    %29 = llvm.mlir.addressof @mX01 : !llvm.ptr
    %30 = llvm.mlir.constant(9 : i32) : i32
    %31 = llvm.mlir.constant(" 2147483648\00") : !llvm.array<12 x i8>
    %32 = llvm.mlir.addressof @i32max_p1 : !llvm.ptr
    %33 = llvm.mlir.constant(" 4294967295\00") : !llvm.array<12 x i8>
    %34 = llvm.mlir.addressof @ui32max : !llvm.ptr
    %35 = llvm.mlir.constant(11 : i32) : i32
    %36 = llvm.call @strtoul(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.store %36, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %37 = llvm.call @strtoul(%5, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %38 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %37, %38 {alignment = 4 : i64} : i32, !llvm.ptr]

    %39 = llvm.call @strtoul(%8, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %40 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %39, %40 {alignment = 4 : i64} : i32, !llvm.ptr]

    %41 = llvm.call @strtoul(%11, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %42 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %41, %42 {alignment = 4 : i64} : i32, !llvm.ptr]

    %43 = llvm.call @strtoul(%14, %2, %15) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %44 = llvm.getelementptr %arg0[%16] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %43, %44 {alignment = 4 : i64} : i32, !llvm.ptr]

    %45 = llvm.call @strtoul(%18, %2, %15) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %46 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %45, %46 {alignment = 4 : i64} : i32, !llvm.ptr]

    %47 = llvm.call @strtoul(%21, %2, %15) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %48 = llvm.getelementptr %arg0[%22] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %47, %48 {alignment = 4 : i64} : i32, !llvm.ptr]

    %49 = llvm.call @strtoul(%23, %2, %15) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %50 = llvm.getelementptr %arg0[%24] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %47, %50 {alignment = 4 : i64} : i32, !llvm.ptr]

    %51 = llvm.call @strtoul(%26, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %52 = llvm.getelementptr %arg0[%27] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %51, %52 {alignment = 4 : i64} : i32, !llvm.ptr]

    %53 = llvm.call @strtoul(%29, %2, %15) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %54 = llvm.getelementptr %arg0[%30] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %53, %54 {alignment = 4 : i64} : i32, !llvm.ptr]

    %55 = llvm.call @strtoul(%32, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %56 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %55, %56 {alignment = 4 : i64} : i32, !llvm.ptr]

    %57 = llvm.call @strtoul(%34, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %58 = llvm.getelementptr %arg0[%35] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %57, %58 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def call_strtoul_before := [llvmfunc|
  llvm.func @call_strtoul(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(" -9223372036854775809\00") : !llvm.array<22 x i8>
    %1 = llvm.mlir.addressof @i64min_m1 : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant(" 4294967296\00") : !llvm.array<12 x i8>
    %5 = llvm.mlir.addressof @ui32max_p1 : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant("\09\0D\0A\0B\0C \00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.addressof @ws : !llvm.ptr
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.constant(6 : i32) : i32
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.call @strtoul(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.store %13, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %14 = llvm.call @strtoul(%5, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %15 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %14, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

    %16 = llvm.call @strtoul(%8, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %17 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %16, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

    %18 = llvm.getelementptr %8[%10, %11] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<7 x i8>
    %19 = llvm.call @strtoul(%18, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %20 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %19, %20 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_strtoull_before := [llvmfunc|
  llvm.func @fold_strtoull(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("\09\0D\0A\0B\0C -123\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @ws_im123 : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant("\09\0D\0A\0B\0C +234\00") : !llvm.array<11 x i8>
    %5 = llvm.mlir.addressof @ws_ip234 : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(" -9223372036854775809\00") : !llvm.array<22 x i8>
    %8 = llvm.mlir.addressof @i64min_m1 : !llvm.ptr
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.mlir.constant(" -2147483648\00") : !llvm.array<13 x i8>
    %11 = llvm.mlir.addressof @i32min : !llvm.ptr
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.mlir.constant(" +020000000000\00") : !llvm.array<15 x i8>
    %14 = llvm.mlir.addressof @o32min : !llvm.ptr
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.mlir.constant(4 : i32) : i32
    %17 = llvm.mlir.constant(" +0x80000000\00") : !llvm.array<13 x i8>
    %18 = llvm.mlir.addressof @x32min : !llvm.ptr
    %19 = llvm.mlir.constant(5 : i32) : i32
    %20 = llvm.mlir.constant(" -9223372036854775808\00") : !llvm.array<22 x i8>
    %21 = llvm.mlir.addressof @i64min : !llvm.ptr
    %22 = llvm.mlir.constant(6 : i32) : i32
    %23 = llvm.mlir.constant(" 9223372036854775807\00") : !llvm.array<21 x i8>
    %24 = llvm.mlir.addressof @i64max : !llvm.ptr
    %25 = llvm.mlir.constant(7 : i32) : i32
    %26 = llvm.mlir.constant(" 9223372036854775808\00") : !llvm.array<21 x i8>
    %27 = llvm.mlir.addressof @i64max_p1 : !llvm.ptr
    %28 = llvm.mlir.constant(8 : i32) : i32
    %29 = llvm.mlir.constant(" 18446744073709551615\00") : !llvm.array<22 x i8>
    %30 = llvm.mlir.addressof @ui64max : !llvm.ptr
    %31 = llvm.mlir.constant(9 : i32) : i32
    %32 = llvm.mlir.constant(" 0xffffffffffffffff\00") : !llvm.array<20 x i8>
    %33 = llvm.mlir.addressof @x64max : !llvm.ptr
    %34 = llvm.call @strtoull(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.store %34, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %35 = llvm.call @strtoull(%5, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %36 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %35, %36 {alignment = 4 : i64} : i64, !llvm.ptr]

    %37 = llvm.call @strtoull(%8, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %38 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %37, %38 {alignment = 4 : i64} : i64, !llvm.ptr]

    %39 = llvm.call @strtoull(%11, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %40 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %39, %40 {alignment = 4 : i64} : i64, !llvm.ptr]

    %41 = llvm.call @strtoull(%14, %2, %15) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %42 = llvm.getelementptr %arg0[%16] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %41, %42 {alignment = 4 : i64} : i64, !llvm.ptr]

    %43 = llvm.call @strtoull(%18, %2, %15) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %44 = llvm.getelementptr %arg0[%19] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %43, %44 {alignment = 4 : i64} : i64, !llvm.ptr]

    %45 = llvm.call @strtoull(%21, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %46 = llvm.getelementptr %arg0[%22] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %45, %46 {alignment = 4 : i64} : i64, !llvm.ptr]

    %47 = llvm.call @strtoull(%24, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %48 = llvm.getelementptr %arg0[%25] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %47, %48 {alignment = 4 : i64} : i64, !llvm.ptr]

    %49 = llvm.call @strtoull(%27, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %50 = llvm.getelementptr %arg0[%28] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %49, %50 {alignment = 4 : i64} : i64, !llvm.ptr]

    %51 = llvm.call @strtoull(%30, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %52 = llvm.getelementptr %arg0[%31] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %51, %52 {alignment = 4 : i64} : i64, !llvm.ptr]

    %53 = llvm.call @strtoull(%33, %2, %15) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %54 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %53, %54 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def call_strtoull_before := [llvmfunc|
  llvm.func @call_strtoull(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(" 18446744073709551616\00") : !llvm.array<22 x i8>
    %1 = llvm.mlir.addressof @ui64max_p1 : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant("\09\0D\0A\0B\0C \00") : !llvm.array<7 x i8>
    %6 = llvm.mlir.addressof @ws : !llvm.ptr
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.constant(6 : i32) : i32
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.call @strtoull(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %12 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %11, %12 {alignment = 4 : i64} : i64, !llvm.ptr]

    %13 = llvm.call @strtoull(%6, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %14 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %13, %14 {alignment = 4 : i64} : i64, !llvm.ptr]

    %15 = llvm.getelementptr %6[%8, %9] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<7 x i8>
    %16 = llvm.call @strtoull(%15, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %17 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %16, %17 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def fold_strtoul_combined := [llvmfunc|
  llvm.func @fold_strtoul(%arg0: !llvm.ptr) {
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
    %12 = llvm.mlir.constant(12 : i64) : i64
    %13 = llvm.mlir.constant(" -2147483649\00") : !llvm.array<13 x i8>
    %14 = llvm.mlir.addressof @i32min_m1 : !llvm.ptr
    %15 = llvm.getelementptr inbounds %14[%1, %12] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<13 x i8>
    %16 = llvm.mlir.constant(2 : i64) : i64
    %17 = llvm.mlir.constant(2147483647 : i32) : i32
    %18 = llvm.mlir.constant(" -2147483648\00") : !llvm.array<13 x i8>
    %19 = llvm.mlir.addressof @i32min : !llvm.ptr
    %20 = llvm.getelementptr inbounds %19[%1, %12] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<13 x i8>
    %21 = llvm.mlir.constant(3 : i64) : i64
    %22 = llvm.mlir.constant(-2147483648 : i32) : i32
    %23 = llvm.mlir.constant(14 : i64) : i64
    %24 = llvm.mlir.constant(" +020000000000\00") : !llvm.array<15 x i8>
    %25 = llvm.mlir.addressof @o32min : !llvm.ptr
    %26 = llvm.getelementptr inbounds %25[%1, %23] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<15 x i8>
    %27 = llvm.mlir.constant(4 : i64) : i64
    %28 = llvm.mlir.constant(" -020000000000\00") : !llvm.array<15 x i8>
    %29 = llvm.mlir.addressof @mo32min : !llvm.ptr
    %30 = llvm.getelementptr inbounds %29[%1, %23] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<15 x i8>
    %31 = llvm.mlir.constant(5 : i64) : i64
    %32 = llvm.mlir.constant(" +0x80000000\00") : !llvm.array<13 x i8>
    %33 = llvm.mlir.addressof @x32min : !llvm.ptr
    %34 = llvm.getelementptr inbounds %33[%1, %12] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<13 x i8>
    %35 = llvm.mlir.constant(6 : i64) : i64
    %36 = llvm.mlir.addressof @mx32min : !llvm.ptr
    %37 = llvm.getelementptr inbounds %36[%1, %12] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<13 x i8>
    %38 = llvm.mlir.constant(7 : i64) : i64
    %39 = llvm.mlir.constant(11 : i64) : i64
    %40 = llvm.mlir.constant(" 2147483647\00") : !llvm.array<12 x i8>
    %41 = llvm.mlir.addressof @i32max : !llvm.ptr
    %42 = llvm.getelementptr inbounds %41[%1, %39] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<12 x i8>
    %43 = llvm.mlir.constant(8 : i64) : i64
    %44 = llvm.mlir.constant(" -0X1\00") : !llvm.array<6 x i8>
    %45 = llvm.mlir.addressof @mX01 : !llvm.ptr
    %46 = llvm.getelementptr inbounds %45[%1, %31] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %47 = llvm.mlir.constant(9 : i64) : i64
    %48 = llvm.mlir.constant(-1 : i32) : i32
    %49 = llvm.mlir.constant(" 2147483648\00") : !llvm.array<12 x i8>
    %50 = llvm.mlir.addressof @i32max_p1 : !llvm.ptr
    %51 = llvm.getelementptr inbounds %50[%1, %39] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<12 x i8>
    %52 = llvm.mlir.constant(" 4294967295\00") : !llvm.array<12 x i8>
    %53 = llvm.mlir.addressof @ui32max : !llvm.ptr
    %54 = llvm.getelementptr inbounds %53[%1, %39] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<12 x i8>
    llvm.store %4, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %9, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %55 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %11, %55 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %15, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %56 = llvm.getelementptr %arg0[%16] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %17, %56 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %20, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %57 = llvm.getelementptr %arg0[%21] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %57 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %26, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %58 = llvm.getelementptr %arg0[%27] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %58 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %30, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %59 = llvm.getelementptr %arg0[%31] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %59 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %34, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %60 = llvm.getelementptr %arg0[%35] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %60 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %37, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %61 = llvm.getelementptr %arg0[%38] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %61 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %42, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %62 = llvm.getelementptr %arg0[%43] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %17, %62 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %46, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %63 = llvm.getelementptr %arg0[%47] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %48, %63 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %51, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %64 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %64 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %54, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %65 = llvm.getelementptr %arg0[%39] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %48, %65 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_strtoul   : fold_strtoul_before  ⊑  fold_strtoul_combined := by
  unfold fold_strtoul_before fold_strtoul_combined
  simp_alive_peephole
  sorry
def call_strtoul_combined := [llvmfunc|
  llvm.func @call_strtoul(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(" -9223372036854775809\00") : !llvm.array<22 x i8>
    %1 = llvm.mlir.addressof @i64min_m1 : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant(" 4294967296\00") : !llvm.array<12 x i8>
    %5 = llvm.mlir.addressof @ui32max_p1 : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant("\09\0D\0A\0B\0C \00") : !llvm.array<7 x i8>
    %8 = llvm.mlir.addressof @ws : !llvm.ptr
    %9 = llvm.mlir.constant(2 : i64) : i64
    %10 = llvm.mlir.constant(6 : i64) : i64
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.getelementptr inbounds %8[%11, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.call @strtoul(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.store %14, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %15 = llvm.call @strtoul(%5, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %16 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %15, %16 {alignment = 4 : i64} : i32, !llvm.ptr
    %17 = llvm.call @strtoul(%8, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %18 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %17, %18 {alignment = 4 : i64} : i32, !llvm.ptr
    %19 = llvm.call @strtoul(%12, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %20 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %19, %20 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_call_strtoul   : call_strtoul_before  ⊑  call_strtoul_combined := by
  unfold call_strtoul_before call_strtoul_combined
  simp_alive_peephole
  sorry
def fold_strtoull_combined := [llvmfunc|
  llvm.func @fold_strtoull(%arg0: !llvm.ptr) {
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
    %13 = llvm.mlir.constant(" -9223372036854775809\00") : !llvm.array<22 x i8>
    %14 = llvm.mlir.addressof @i64min_m1 : !llvm.ptr
    %15 = llvm.getelementptr inbounds %14[%1, %12] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<22 x i8>
    %16 = llvm.mlir.constant(2 : i64) : i64
    %17 = llvm.mlir.constant(9223372036854775807 : i64) : i64
    %18 = llvm.mlir.constant(12 : i64) : i64
    %19 = llvm.mlir.constant(" -2147483648\00") : !llvm.array<13 x i8>
    %20 = llvm.mlir.addressof @i32min : !llvm.ptr
    %21 = llvm.getelementptr inbounds %20[%1, %18] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<13 x i8>
    %22 = llvm.mlir.constant(3 : i64) : i64
    %23 = llvm.mlir.constant(-2147483648 : i64) : i64
    %24 = llvm.mlir.constant(14 : i64) : i64
    %25 = llvm.mlir.constant(" +020000000000\00") : !llvm.array<15 x i8>
    %26 = llvm.mlir.addressof @o32min : !llvm.ptr
    %27 = llvm.getelementptr inbounds %26[%1, %24] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<15 x i8>
    %28 = llvm.mlir.constant(4 : i64) : i64
    %29 = llvm.mlir.constant(2147483648 : i64) : i64
    %30 = llvm.mlir.constant(" +0x80000000\00") : !llvm.array<13 x i8>
    %31 = llvm.mlir.addressof @x32min : !llvm.ptr
    %32 = llvm.getelementptr inbounds %31[%1, %18] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<13 x i8>
    %33 = llvm.mlir.constant(5 : i64) : i64
    %34 = llvm.mlir.constant(" -9223372036854775808\00") : !llvm.array<22 x i8>
    %35 = llvm.mlir.addressof @i64min : !llvm.ptr
    %36 = llvm.getelementptr inbounds %35[%1, %12] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<22 x i8>
    %37 = llvm.mlir.constant(6 : i64) : i64
    %38 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %39 = llvm.mlir.constant(20 : i64) : i64
    %40 = llvm.mlir.constant(" 9223372036854775807\00") : !llvm.array<21 x i8>
    %41 = llvm.mlir.addressof @i64max : !llvm.ptr
    %42 = llvm.getelementptr inbounds %41[%1, %39] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<21 x i8>
    %43 = llvm.mlir.constant(7 : i64) : i64
    %44 = llvm.mlir.constant(" 9223372036854775808\00") : !llvm.array<21 x i8>
    %45 = llvm.mlir.addressof @i64max_p1 : !llvm.ptr
    %46 = llvm.getelementptr inbounds %45[%1, %39] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<21 x i8>
    %47 = llvm.mlir.constant(8 : i64) : i64
    %48 = llvm.mlir.constant(" 18446744073709551615\00") : !llvm.array<22 x i8>
    %49 = llvm.mlir.addressof @ui64max : !llvm.ptr
    %50 = llvm.getelementptr inbounds %49[%1, %12] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<22 x i8>
    %51 = llvm.mlir.constant(9 : i64) : i64
    %52 = llvm.mlir.constant(-1 : i64) : i64
    %53 = llvm.mlir.constant(19 : i64) : i64
    %54 = llvm.mlir.constant(" 0xffffffffffffffff\00") : !llvm.array<20 x i8>
    %55 = llvm.mlir.addressof @x64max : !llvm.ptr
    %56 = llvm.getelementptr inbounds %55[%1, %53] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<20 x i8>
    llvm.store %4, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %6, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.store %9, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %57 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %11, %57 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.store %15, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %58 = llvm.getelementptr %arg0[%16] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %17, %58 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.store %21, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %59 = llvm.getelementptr %arg0[%22] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %23, %59 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.store %27, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %60 = llvm.getelementptr %arg0[%28] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %29, %60 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.store %32, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %61 = llvm.getelementptr %arg0[%33] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %29, %61 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.store %36, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %62 = llvm.getelementptr %arg0[%37] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %38, %62 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.store %42, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %63 = llvm.getelementptr %arg0[%43] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %17, %63 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.store %46, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %64 = llvm.getelementptr %arg0[%47] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %38, %64 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.store %50, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %65 = llvm.getelementptr %arg0[%51] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %52, %65 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.store %56, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %66 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %52, %66 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_strtoull   : fold_strtoull_before  ⊑  fold_strtoull_combined := by
  unfold fold_strtoull_before fold_strtoull_combined
  simp_alive_peephole
  sorry
def call_strtoull_combined := [llvmfunc|
  llvm.func @call_strtoull(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(" 18446744073709551616\00") : !llvm.array<22 x i8>
    %1 = llvm.mlir.addressof @ui64max_p1 : !llvm.ptr
    %2 = llvm.mlir.addressof @endptr : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant("\09\0D\0A\0B\0C \00") : !llvm.array<7 x i8>
    %6 = llvm.mlir.addressof @ws : !llvm.ptr
    %7 = llvm.mlir.constant(2 : i64) : i64
    %8 = llvm.mlir.constant(6 : i64) : i64
    %9 = llvm.mlir.constant(0 : i64) : i64
    %10 = llvm.getelementptr inbounds %6[%9, %8] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %11 = llvm.mlir.constant(3 : i64) : i64
    %12 = llvm.call @strtoull(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %13 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %12, %13 {alignment = 4 : i64} : i64, !llvm.ptr
    %14 = llvm.call @strtoull(%6, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %15 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %14, %15 {alignment = 4 : i64} : i64, !llvm.ptr
    %16 = llvm.call @strtoull(%10, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %17 = llvm.getelementptr %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %16, %17 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_call_strtoull   : call_strtoull_before  ⊑  call_strtoull_combined := by
  unfold call_strtoull_before call_strtoull_combined
  simp_alive_peephole
  sorry
