import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  mul_full_64
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def mul_full_64_variant0(%arg0: i64, %arg1: i64) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @mul_full_64_variant0(%arg0: i64, %arg1: i64) -> !llvm.struct<(i64, i64)> {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %arg1, %0  : i64
    %6 = llvm.lshr %arg1, %1  : i64
    %7 = llvm.mul %5, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %4 overflow<nuw>  : i64
    %9 = llvm.mul %6, %3 overflow<nuw>  : i64
    %10 = llvm.mul %6, %4 overflow<nuw>  : i64
    %11 = llvm.and %7, %0  : i64
    %12 = llvm.lshr %7, %1  : i64
    %13 = llvm.add %12, %8  : i64
    %14 = llvm.and %13, %0  : i64
    %15 = llvm.lshr %13, %1  : i64
    %16 = llvm.add %14, %9  : i64
    %17 = llvm.shl %16, %1  : i64
    %18 = llvm.lshr %16, %1  : i64
    %19 = llvm.add %15, %10  : i64
    %20 = llvm.or %17, %11  : i64
    %21 = llvm.add %19, %18  : i64
    %22 = llvm.insertvalue %20, %2[0] : !llvm.struct<(i64, i64)> 
    %23 = llvm.insertvalue %21, %22[1] : !llvm.struct<(i64, i64)> 
    llvm.return %23 : !llvm.struct<(i64, i64)>
  }]

def mul_full_64_variant1_before := [llvmfunc|
  llvm.func @mul_full_64_variant1(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr {llvm.nocapture}) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.and %arg1, %0  : i64
    %5 = llvm.lshr %arg1, %1  : i64
    %6 = llvm.mul %5, %3 overflow<nuw>  : i64
    %7 = llvm.mul %4, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %2 overflow<nuw>  : i64
    %9 = llvm.mul %4, %2 overflow<nuw>  : i64
    %10 = llvm.lshr %9, %1  : i64
    %11 = llvm.add %10, %7  : i64
    %12 = llvm.lshr %11, %1  : i64
    %13 = llvm.add %12, %6  : i64
    %14 = llvm.and %11, %0  : i64
    %15 = llvm.add %14, %8  : i64
    %16 = llvm.lshr %15, %1  : i64
    %17 = llvm.add %13, %16  : i64
    llvm.store %17, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    %18 = llvm.mul %arg1, %arg0  : i64
    llvm.return %18 : i64
  }]

def mul_full_64_variant2_before := [llvmfunc|
  llvm.func @mul_full_64_variant2(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr {llvm.nocapture}) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.and %arg1, %0  : i64
    %5 = llvm.lshr %arg1, %1  : i64
    %6 = llvm.mul %5, %3 overflow<nuw>  : i64
    %7 = llvm.mul %4, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %2 overflow<nuw>  : i64
    %9 = llvm.mul %4, %2 overflow<nuw>  : i64
    %10 = llvm.lshr %9, %1  : i64
    %11 = llvm.add %10, %7  : i64
    %12 = llvm.lshr %11, %1  : i64
    %13 = llvm.add %12, %6  : i64
    %14 = llvm.and %11, %0  : i64
    %15 = llvm.add %14, %8  : i64
    %16 = llvm.lshr %15, %1  : i64
    %17 = llvm.add %13, %16  : i64
    llvm.store %17, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    %18 = llvm.shl %15, %1  : i64
    %19 = llvm.and %9, %0  : i64
    %20 = llvm.or %18, %19  : i64
    llvm.return %20 : i64
  }]

def mul_full_64_variant3_before := [llvmfunc|
  llvm.func @mul_full_64_variant3(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr {llvm.nocapture}) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.and %arg1, %0  : i64
    %5 = llvm.lshr %arg1, %1  : i64
    %6 = llvm.mul %5, %3 overflow<nuw>  : i64
    %7 = llvm.mul %4, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %2 overflow<nuw>  : i64
    %9 = llvm.mul %4, %2 overflow<nuw>  : i64
    %10 = llvm.lshr %9, %1  : i64
    %11 = llvm.add %10, %7  : i64
    %12 = llvm.lshr %11, %1  : i64
    %13 = llvm.add %12, %6  : i64
    %14 = llvm.and %11, %0  : i64
    %15 = llvm.add %14, %8  : i64
    %16 = llvm.lshr %15, %1  : i64
    %17 = llvm.add %13, %16  : i64
    llvm.store %17, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr]

    %18 = llvm.add %8, %7  : i64
    %19 = llvm.shl %18, %1  : i64
    %20 = llvm.add %19, %9  : i64
    llvm.return %20 : i64
  }]

def mul_full_32(%arg0: i32, %arg1: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @mul_full_32(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %arg1, %0  : i32
    %6 = llvm.lshr %arg1, %1  : i32
    %7 = llvm.mul %5, %3 overflow<nuw>  : i32
    %8 = llvm.mul %5, %4 overflow<nuw>  : i32
    %9 = llvm.mul %6, %3 overflow<nuw>  : i32
    %10 = llvm.mul %6, %4 overflow<nuw>  : i32
    %11 = llvm.and %7, %0  : i32
    %12 = llvm.lshr %7, %1  : i32
    %13 = llvm.add %12, %8  : i32
    %14 = llvm.and %13, %0  : i32
    %15 = llvm.lshr %13, %1  : i32
    %16 = llvm.add %14, %9  : i32
    %17 = llvm.shl %16, %1  : i32
    %18 = llvm.lshr %16, %1  : i32
    %19 = llvm.add %15, %10  : i32
    %20 = llvm.or %17, %11  : i32
    %21 = llvm.add %19, %18  : i32
    %22 = llvm.insertvalue %20, %2[0] : !llvm.struct<(i32, i32)> 
    %23 = llvm.insertvalue %21, %22[1] : !llvm.struct<(i32, i32)> 
    llvm.return %23 : !llvm.struct<(i32, i32)>
  }]

def mul_full_64_variant0_1() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @mul_full_64_variant0_1() -> !llvm.struct<(i64, i64)> {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.call @get_number() : () -> i64
    %4 = llvm.and %3, %0  : i64
    %5 = llvm.lshr %3, %1  : i64
    %6 = llvm.call @get_number() : () -> i64
    %7 = llvm.lshr %6, %1  : i64
    %8 = llvm.and %6, %0  : i64
    %9 = llvm.mul %4, %7 overflow<nuw>  : i64
    %10 = llvm.mul %5, %7 overflow<nuw>  : i64
    %11 = llvm.mul %5, %8 overflow<nuw>  : i64
    %12 = llvm.mul %4, %8 overflow<nuw>  : i64
    %13 = llvm.lshr %12, %1  : i64
    %14 = llvm.add %13, %9  : i64
    %15 = llvm.and %14, %0  : i64
    %16 = llvm.add %15, %11  : i64
    %17 = llvm.lshr %14, %1  : i64
    %18 = llvm.add %17, %10  : i64
    %19 = llvm.lshr %16, %1  : i64
    %20 = llvm.add %18, %19  : i64
    %21 = llvm.shl %16, %1  : i64
    %22 = llvm.and %12, %0  : i64
    %23 = llvm.or %21, %22  : i64
    %24 = llvm.insertvalue %23, %2[0] : !llvm.struct<(i64, i64)> 
    %25 = llvm.insertvalue %20, %24[1] : !llvm.struct<(i64, i64)> 
    llvm.return %25 : !llvm.struct<(i64, i64)>
  }]

def mul_full_64_variant0_2() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @mul_full_64_variant0_2() -> !llvm.struct<(i64, i64)> {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.call @get_number() : () -> i64
    %4 = llvm.call @get_number() : () -> i64
    %5 = llvm.and %4, %0  : i64
    %6 = llvm.lshr %4, %1  : i64
    %7 = llvm.lshr %3, %1  : i64
    %8 = llvm.and %3, %0  : i64
    %9 = llvm.mul %7, %6 overflow<nuw>  : i64
    %10 = llvm.mul %8, %6 overflow<nuw>  : i64
    %11 = llvm.mul %7, %5 overflow<nuw>  : i64
    %12 = llvm.mul %8, %5 overflow<nuw>  : i64
    %13 = llvm.lshr %12, %1  : i64
    %14 = llvm.add %11, %13  : i64
    %15 = llvm.and %14, %0  : i64
    %16 = llvm.add %10, %15  : i64
    %17 = llvm.lshr %14, %1  : i64
    %18 = llvm.add %17, %9  : i64
    %19 = llvm.lshr %16, %1  : i64
    %20 = llvm.add %19, %18  : i64
    %21 = llvm.shl %16, %1  : i64
    %22 = llvm.and %12, %0  : i64
    %23 = llvm.or %22, %21  : i64
    %24 = llvm.insertvalue %23, %2[0] : !llvm.struct<(i64, i64)> 
    %25 = llvm.insertvalue %20, %24[1] : !llvm.struct<(i64, i64)> 
    llvm.return %25 : !llvm.struct<(i64, i64)>
  }]

def umulh_64_before := [llvmfunc|
  llvm.func @umulh_64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.and %arg1, %0  : i64
    %5 = llvm.lshr %arg1, %1  : i64
    %6 = llvm.mul %4, %2 overflow<nuw>  : i64
    %7 = llvm.mul %4, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %2 overflow<nuw>  : i64
    %9 = llvm.mul %5, %3 overflow<nuw>  : i64
    %10 = llvm.lshr %6, %1  : i64
    %11 = llvm.add %10, %7  : i64
    %12 = llvm.and %11, %0  : i64
    %13 = llvm.lshr %11, %1  : i64
    %14 = llvm.add %12, %8  : i64
    %15 = llvm.lshr %14, %1  : i64
    %16 = llvm.add %13, %9  : i64
    %17 = llvm.add %16, %15  : i64
    llvm.return %17 : i64
  }]

def mullo_before := [llvmfunc|
  llvm.func @mullo(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.and %arg1, %0  : i64
    %5 = llvm.lshr %arg1, %1  : i64
    %6 = llvm.mul %4, %2 overflow<nuw>  : i64
    %7 = llvm.mul %4, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %2 overflow<nuw>  : i64
    %9 = llvm.and %6, %0  : i64
    %10 = llvm.lshr %6, %1  : i64
    %11 = llvm.add %10, %7  : i64
    %12 = llvm.and %11, %0  : i64
    %13 = llvm.add %12, %8  : i64
    %14 = llvm.shl %13, %1  : i64
    %15 = llvm.or %14, %9  : i64
    llvm.return %15 : i64
  }]

def mullo_variant3_before := [llvmfunc|
  llvm.func @mullo_variant3(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.and %arg1, %0  : i64
    %5 = llvm.lshr %arg1, %1  : i64
    %6 = llvm.mul %4, %2 overflow<nuw>  : i64
    %7 = llvm.mul %4, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %2 overflow<nuw>  : i64
    %9 = llvm.add %8, %7  : i64
    %10 = llvm.shl %9, %1  : i64
    %11 = llvm.add %10, %6  : i64
    llvm.return %11 : i64
  }]

def mullo_duplicate_before := [llvmfunc|
  llvm.func @mullo_duplicate(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mul %arg0, %arg1  : i64
    llvm.call @eat_i64(%2) : (i64) -> ()
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %arg1, %0  : i64
    %6 = llvm.lshr %arg1, %1  : i64
    %7 = llvm.mul %5, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %4 overflow<nuw>  : i64
    %9 = llvm.mul %6, %3 overflow<nuw>  : i64
    %10 = llvm.and %7, %0  : i64
    %11 = llvm.lshr %7, %1  : i64
    %12 = llvm.add %11, %8  : i64
    %13 = llvm.and %12, %0  : i64
    %14 = llvm.add %13, %9  : i64
    %15 = llvm.shl %14, %1  : i64
    %16 = llvm.or %15, %10  : i64
    llvm.return %16 : i64
  }]

def mul_full_64_duplicate(%arg0: i64, %arg1: i64) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @mul_full_64_duplicate(%arg0: i64, %arg1: i64) -> !llvm.struct<(i64, i64)> {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.zext %arg0 : i64 to i128
    %4 = llvm.zext %arg1 : i64 to i128
    %5 = llvm.mul %3, %4  : i128
    llvm.call @eat_i128(%5) : (i128) -> ()
    %6 = llvm.and %arg0, %0  : i64
    %7 = llvm.lshr %arg0, %1  : i64
    %8 = llvm.and %arg1, %0  : i64
    %9 = llvm.lshr %arg1, %1  : i64
    %10 = llvm.mul %8, %6 overflow<nuw>  : i64
    %11 = llvm.mul %8, %7 overflow<nuw>  : i64
    %12 = llvm.mul %9, %6 overflow<nuw>  : i64
    %13 = llvm.mul %9, %7 overflow<nuw>  : i64
    %14 = llvm.and %10, %0  : i64
    %15 = llvm.lshr %10, %1  : i64
    %16 = llvm.add %15, %11  : i64
    %17 = llvm.and %16, %0  : i64
    %18 = llvm.lshr %16, %1  : i64
    %19 = llvm.add %17, %12  : i64
    %20 = llvm.shl %19, %1  : i64
    %21 = llvm.lshr %19, %1  : i64
    %22 = llvm.add %18, %13  : i64
    %23 = llvm.or %20, %14  : i64
    %24 = llvm.add %22, %21  : i64
    %25 = llvm.insertvalue %23, %2[0] : !llvm.struct<(i64, i64)> 
    %26 = llvm.insertvalue %24, %25[1] : !llvm.struct<(i64, i64)> 
    llvm.return %26 : !llvm.struct<(i64, i64)>
  }]

def umulhi_64_v2_before := [llvmfunc|
  llvm.func @umulhi_64_v2() -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.call @get_number() : () -> i64
    %3 = llvm.call @get_number() : () -> i64
    %4 = llvm.and %3, %0  : i64
    %5 = llvm.lshr %3, %1  : i64
    %6 = llvm.lshr %2, %1  : i64
    %7 = llvm.and %2, %0  : i64
    %8 = llvm.mul %6, %5 overflow<nuw>  : i64
    %9 = llvm.mul %7, %5 overflow<nuw>  : i64
    %10 = llvm.mul %6, %4 overflow<nuw>  : i64
    %11 = llvm.mul %7, %4 overflow<nuw>  : i64
    %12 = llvm.lshr %11, %1  : i64
    %13 = llvm.add %10, %12  : i64
    %14 = llvm.and %13, %0  : i64
    %15 = llvm.add %9, %14  : i64
    %16 = llvm.lshr %13, %1  : i64
    %17 = llvm.add %16, %8  : i64
    %18 = llvm.lshr %15, %1  : i64
    %19 = llvm.add %18, %17  : i64
    llvm.return %19 : i64
  }]

def umulhi_64_v3_before := [llvmfunc|
  llvm.func @umulhi_64_v3() -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.call @get_number() : () -> i64
    %3 = llvm.lshr %2, %0  : i64
    %4 = llvm.and %2, %1  : i64
    %5 = llvm.call @get_number() : () -> i64
    %6 = llvm.and %5, %1  : i64
    %7 = llvm.lshr %5, %0  : i64
    %8 = llvm.mul %3, %7 overflow<nuw>  : i64
    %9 = llvm.mul %4, %7 overflow<nuw>  : i64
    %10 = llvm.mul %3, %6 overflow<nuw>  : i64
    %11 = llvm.mul %4, %6 overflow<nuw>  : i64
    %12 = llvm.lshr %11, %0  : i64
    %13 = llvm.add %10, %12  : i64
    %14 = llvm.and %13, %1  : i64
    %15 = llvm.add %9, %14  : i64
    %16 = llvm.lshr %13, %0  : i64
    %17 = llvm.add %16, %8  : i64
    %18 = llvm.lshr %15, %0  : i64
    %19 = llvm.add %18, %17  : i64
    llvm.return %19 : i64
  }]

def mul_full_64_variant0(%arg0: i64, %arg1: i64) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @mul_full_64_variant0(%arg0: i64, %arg1: i64) -> !llvm.struct<(i64, i64)> {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %arg1, %0  : i64
    %6 = llvm.lshr %arg1, %1  : i64
    %7 = llvm.mul %5, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %4 overflow<nuw>  : i64
    %9 = llvm.mul %6, %3 overflow<nuw>  : i64
    %10 = llvm.mul %6, %4 overflow<nuw>  : i64
    %11 = llvm.and %7, %0  : i64
    %12 = llvm.lshr %7, %1  : i64
    %13 = llvm.add %12, %8  : i64
    %14 = llvm.and %13, %0  : i64
    %15 = llvm.lshr %13, %1  : i64
    %16 = llvm.add %14, %9  : i64
    %17 = llvm.shl %16, %1  : i64
    %18 = llvm.lshr %16, %1  : i64
    %19 = llvm.add %15, %10  : i64
    %20 = llvm.or %17, %11  : i64
    %21 = llvm.add %19, %18  : i64
    %22 = llvm.insertvalue %20, %2[0] : !llvm.struct<(i64, i64)> 
    %23 = llvm.insertvalue %21, %22[1] : !llvm.struct<(i64, i64)> 
    llvm.return %23 : !llvm.struct<(i64, i64)>
  }]

theorem inst_combine_mul_full_64_variant0(%arg0: i64, %arg1: i64) -> !llvm.struct<   : mul_full_64_variant0(%arg0: i64, %arg1: i64) -> !llvm.struct<_before  ⊑  mul_full_64_variant0(%arg0: i64, %arg1: i64) -> !llvm.struct<_combined := by
  unfold mul_full_64_variant0(%arg0: i64, %arg1: i64) -> !llvm.struct<_before mul_full_64_variant0(%arg0: i64, %arg1: i64) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def mul_full_64_variant1_combined := [llvmfunc|
  llvm.func @mul_full_64_variant1(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr {llvm.nocapture}) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.and %arg1, %0  : i64
    %5 = llvm.lshr %arg1, %1  : i64
    %6 = llvm.mul %5, %3 overflow<nuw>  : i64
    %7 = llvm.mul %4, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %2 overflow<nuw>  : i64
    %9 = llvm.mul %4, %2 overflow<nuw>  : i64
    %10 = llvm.lshr %9, %1  : i64
    %11 = llvm.add %10, %7  : i64
    %12 = llvm.lshr %11, %1  : i64
    %13 = llvm.add %12, %6  : i64
    %14 = llvm.and %11, %0  : i64
    %15 = llvm.add %14, %8  : i64
    %16 = llvm.lshr %15, %1  : i64
    %17 = llvm.add %13, %16  : i64
    llvm.store %17, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    %18 = llvm.mul %arg1, %arg0  : i64
    llvm.return %18 : i64
  }]

theorem inst_combine_mul_full_64_variant1   : mul_full_64_variant1_before  ⊑  mul_full_64_variant1_combined := by
  unfold mul_full_64_variant1_before mul_full_64_variant1_combined
  simp_alive_peephole
  sorry
def mul_full_64_variant2_combined := [llvmfunc|
  llvm.func @mul_full_64_variant2(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr {llvm.nocapture}) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.and %arg1, %0  : i64
    %5 = llvm.lshr %arg1, %1  : i64
    %6 = llvm.mul %5, %3 overflow<nuw>  : i64
    %7 = llvm.mul %4, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %2 overflow<nuw>  : i64
    %9 = llvm.mul %4, %2 overflow<nuw>  : i64
    %10 = llvm.lshr %9, %1  : i64
    %11 = llvm.add %10, %7  : i64
    %12 = llvm.lshr %11, %1  : i64
    %13 = llvm.add %12, %6  : i64
    %14 = llvm.and %11, %0  : i64
    %15 = llvm.add %14, %8  : i64
    %16 = llvm.lshr %15, %1  : i64
    %17 = llvm.add %13, %16  : i64
    llvm.store %17, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    %18 = llvm.shl %15, %1  : i64
    %19 = llvm.and %9, %0  : i64
    %20 = llvm.or %18, %19  : i64
    llvm.return %20 : i64
  }]

theorem inst_combine_mul_full_64_variant2   : mul_full_64_variant2_before  ⊑  mul_full_64_variant2_combined := by
  unfold mul_full_64_variant2_before mul_full_64_variant2_combined
  simp_alive_peephole
  sorry
def mul_full_64_variant3_combined := [llvmfunc|
  llvm.func @mul_full_64_variant3(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr {llvm.nocapture}) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.and %arg1, %0  : i64
    %5 = llvm.lshr %arg1, %1  : i64
    %6 = llvm.mul %5, %3 overflow<nuw>  : i64
    %7 = llvm.mul %4, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %2 overflow<nuw>  : i64
    %9 = llvm.mul %4, %2 overflow<nuw>  : i64
    %10 = llvm.lshr %9, %1  : i64
    %11 = llvm.add %10, %7  : i64
    %12 = llvm.lshr %11, %1  : i64
    %13 = llvm.add %12, %6  : i64
    %14 = llvm.and %11, %0  : i64
    %15 = llvm.add %14, %8  : i64
    %16 = llvm.lshr %15, %1  : i64
    %17 = llvm.add %13, %16  : i64
    llvm.store %17, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    %18 = llvm.add %8, %7  : i64
    %19 = llvm.shl %18, %1  : i64
    %20 = llvm.add %19, %9  : i64
    llvm.return %20 : i64
  }]

theorem inst_combine_mul_full_64_variant3   : mul_full_64_variant3_before  ⊑  mul_full_64_variant3_combined := by
  unfold mul_full_64_variant3_before mul_full_64_variant3_combined
  simp_alive_peephole
  sorry
def mul_full_32(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @mul_full_32(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %arg1, %0  : i32
    %6 = llvm.lshr %arg1, %1  : i32
    %7 = llvm.mul %5, %3 overflow<nuw>  : i32
    %8 = llvm.mul %5, %4 overflow<nuw>  : i32
    %9 = llvm.mul %6, %3 overflow<nuw>  : i32
    %10 = llvm.mul %6, %4 overflow<nuw>  : i32
    %11 = llvm.and %7, %0  : i32
    %12 = llvm.lshr %7, %1  : i32
    %13 = llvm.add %12, %8  : i32
    %14 = llvm.and %13, %0  : i32
    %15 = llvm.lshr %13, %1  : i32
    %16 = llvm.add %14, %9  : i32
    %17 = llvm.shl %16, %1  : i32
    %18 = llvm.lshr %16, %1  : i32
    %19 = llvm.add %15, %10  : i32
    %20 = llvm.or %17, %11  : i32
    %21 = llvm.add %19, %18  : i32
    %22 = llvm.insertvalue %20, %2[0] : !llvm.struct<(i32, i32)> 
    %23 = llvm.insertvalue %21, %22[1] : !llvm.struct<(i32, i32)> 
    llvm.return %23 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_mul_full_32(%arg0: i32, %arg1: i32) -> !llvm.struct<   : mul_full_32(%arg0: i32, %arg1: i32) -> !llvm.struct<_before  ⊑  mul_full_32(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := by
  unfold mul_full_32(%arg0: i32, %arg1: i32) -> !llvm.struct<_before mul_full_32(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def mul_full_64_variant0_1() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @mul_full_64_variant0_1() -> !llvm.struct<(i64, i64)> {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.call @get_number() : () -> i64
    %4 = llvm.and %3, %0  : i64
    %5 = llvm.lshr %3, %1  : i64
    %6 = llvm.call @get_number() : () -> i64
    %7 = llvm.lshr %6, %1  : i64
    %8 = llvm.and %6, %0  : i64
    %9 = llvm.mul %4, %7 overflow<nuw>  : i64
    %10 = llvm.mul %5, %7 overflow<nuw>  : i64
    %11 = llvm.mul %5, %8 overflow<nuw>  : i64
    %12 = llvm.mul %4, %8 overflow<nuw>  : i64
    %13 = llvm.lshr %12, %1  : i64
    %14 = llvm.add %13, %9  : i64
    %15 = llvm.and %14, %0  : i64
    %16 = llvm.add %15, %11  : i64
    %17 = llvm.lshr %14, %1  : i64
    %18 = llvm.add %17, %10  : i64
    %19 = llvm.lshr %16, %1  : i64
    %20 = llvm.add %18, %19  : i64
    %21 = llvm.shl %16, %1  : i64
    %22 = llvm.and %12, %0  : i64
    %23 = llvm.or %21, %22  : i64
    %24 = llvm.insertvalue %23, %2[0] : !llvm.struct<(i64, i64)> 
    %25 = llvm.insertvalue %20, %24[1] : !llvm.struct<(i64, i64)> 
    llvm.return %25 : !llvm.struct<(i64, i64)>
  }]

theorem inst_combine_mul_full_64_variant0_1() -> !llvm.struct<   : mul_full_64_variant0_1() -> !llvm.struct<_before  ⊑  mul_full_64_variant0_1() -> !llvm.struct<_combined := by
  unfold mul_full_64_variant0_1() -> !llvm.struct<_before mul_full_64_variant0_1() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def mul_full_64_variant0_2() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @mul_full_64_variant0_2() -> !llvm.struct<(i64, i64)> {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.call @get_number() : () -> i64
    %4 = llvm.call @get_number() : () -> i64
    %5 = llvm.and %4, %0  : i64
    %6 = llvm.lshr %4, %1  : i64
    %7 = llvm.lshr %3, %1  : i64
    %8 = llvm.and %3, %0  : i64
    %9 = llvm.mul %7, %6 overflow<nuw>  : i64
    %10 = llvm.mul %8, %6 overflow<nuw>  : i64
    %11 = llvm.mul %7, %5 overflow<nuw>  : i64
    %12 = llvm.mul %8, %5 overflow<nuw>  : i64
    %13 = llvm.lshr %12, %1  : i64
    %14 = llvm.add %11, %13  : i64
    %15 = llvm.and %14, %0  : i64
    %16 = llvm.add %10, %15  : i64
    %17 = llvm.lshr %14, %1  : i64
    %18 = llvm.add %17, %9  : i64
    %19 = llvm.lshr %16, %1  : i64
    %20 = llvm.add %19, %18  : i64
    %21 = llvm.shl %16, %1  : i64
    %22 = llvm.and %12, %0  : i64
    %23 = llvm.or %22, %21  : i64
    %24 = llvm.insertvalue %23, %2[0] : !llvm.struct<(i64, i64)> 
    %25 = llvm.insertvalue %20, %24[1] : !llvm.struct<(i64, i64)> 
    llvm.return %25 : !llvm.struct<(i64, i64)>
  }]

theorem inst_combine_mul_full_64_variant0_2() -> !llvm.struct<   : mul_full_64_variant0_2() -> !llvm.struct<_before  ⊑  mul_full_64_variant0_2() -> !llvm.struct<_combined := by
  unfold mul_full_64_variant0_2() -> !llvm.struct<_before mul_full_64_variant0_2() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def umulh_64_combined := [llvmfunc|
  llvm.func @umulh_64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.and %arg1, %0  : i64
    %5 = llvm.lshr %arg1, %1  : i64
    %6 = llvm.mul %4, %2 overflow<nuw>  : i64
    %7 = llvm.mul %4, %3 overflow<nuw>  : i64
    %8 = llvm.mul %5, %2 overflow<nuw>  : i64
    %9 = llvm.mul %5, %3 overflow<nuw>  : i64
    %10 = llvm.lshr %6, %1  : i64
    %11 = llvm.add %10, %7  : i64
    %12 = llvm.and %11, %0  : i64
    %13 = llvm.lshr %11, %1  : i64
    %14 = llvm.add %12, %8  : i64
    %15 = llvm.lshr %14, %1  : i64
    %16 = llvm.add %13, %9  : i64
    %17 = llvm.add %16, %15  : i64
    llvm.return %17 : i64
  }]

theorem inst_combine_umulh_64   : umulh_64_before  ⊑  umulh_64_combined := by
  unfold umulh_64_before umulh_64_combined
  simp_alive_peephole
  sorry
def mullo_combined := [llvmfunc|
  llvm.func @mullo(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.and %arg1, %0  : i64
    %5 = llvm.lshr %arg1, %1  : i64
    %6 = llvm.mul %4, %2 overflow<nuw>  : i64
    %7 = llvm.mul %3, %arg1  : i64
    %8 = llvm.mul %5, %arg0  : i64
    %9 = llvm.and %6, %0  : i64
    %10 = llvm.lshr %6, %1  : i64
    %11 = llvm.add %10, %7  : i64
    %12 = llvm.add %11, %8  : i64
    %13 = llvm.shl %12, %1  : i64
    %14 = llvm.or %13, %9  : i64
    llvm.return %14 : i64
  }]

theorem inst_combine_mullo   : mullo_before  ⊑  mullo_combined := by
  unfold mullo_before mullo_combined
  simp_alive_peephole
  sorry
def mullo_variant3_combined := [llvmfunc|
  llvm.func @mullo_variant3(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mul %arg0, %arg1  : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_mullo_variant3   : mullo_variant3_before  ⊑  mullo_variant3_combined := by
  unfold mullo_variant3_before mullo_variant3_combined
  simp_alive_peephole
  sorry
def mullo_duplicate_combined := [llvmfunc|
  llvm.func @mullo_duplicate(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mul %arg0, %arg1  : i64
    llvm.call @eat_i64(%2) : (i64) -> ()
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %arg1, %0  : i64
    %6 = llvm.lshr %arg1, %1  : i64
    %7 = llvm.mul %5, %3 overflow<nuw>  : i64
    %8 = llvm.mul %4, %arg1  : i64
    %9 = llvm.mul %6, %arg0  : i64
    %10 = llvm.and %7, %0  : i64
    %11 = llvm.lshr %7, %1  : i64
    %12 = llvm.add %11, %8  : i64
    %13 = llvm.add %12, %9  : i64
    %14 = llvm.shl %13, %1  : i64
    %15 = llvm.or %14, %10  : i64
    llvm.return %15 : i64
  }]

theorem inst_combine_mullo_duplicate   : mullo_duplicate_before  ⊑  mullo_duplicate_combined := by
  unfold mullo_duplicate_before mullo_duplicate_combined
  simp_alive_peephole
  sorry
def mul_full_64_duplicate(%arg0: i64, %arg1: i64) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @mul_full_64_duplicate(%arg0: i64, %arg1: i64) -> !llvm.struct<(i64, i64)> {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.undef : !llvm.struct<(i64, i64)>
    %3 = llvm.zext %arg0 : i64 to i128
    %4 = llvm.zext %arg1 : i64 to i128
    %5 = llvm.mul %3, %4 overflow<nuw>  : i128
    llvm.call @eat_i128(%5) : (i128) -> ()
    %6 = llvm.and %arg0, %0  : i64
    %7 = llvm.lshr %arg0, %1  : i64
    %8 = llvm.and %arg1, %0  : i64
    %9 = llvm.lshr %arg1, %1  : i64
    %10 = llvm.mul %8, %6 overflow<nuw>  : i64
    %11 = llvm.mul %8, %7 overflow<nuw>  : i64
    %12 = llvm.mul %9, %6 overflow<nuw>  : i64
    %13 = llvm.mul %9, %7 overflow<nuw>  : i64
    %14 = llvm.and %10, %0  : i64
    %15 = llvm.lshr %10, %1  : i64
    %16 = llvm.add %15, %11  : i64
    %17 = llvm.and %16, %0  : i64
    %18 = llvm.lshr %16, %1  : i64
    %19 = llvm.add %17, %12  : i64
    %20 = llvm.shl %19, %1  : i64
    %21 = llvm.lshr %19, %1  : i64
    %22 = llvm.add %18, %13  : i64
    %23 = llvm.or %20, %14  : i64
    %24 = llvm.add %22, %21  : i64
    %25 = llvm.insertvalue %23, %2[0] : !llvm.struct<(i64, i64)> 
    %26 = llvm.insertvalue %24, %25[1] : !llvm.struct<(i64, i64)> 
    llvm.return %26 : !llvm.struct<(i64, i64)>
  }]

theorem inst_combine_mul_full_64_duplicate(%arg0: i64, %arg1: i64) -> !llvm.struct<   : mul_full_64_duplicate(%arg0: i64, %arg1: i64) -> !llvm.struct<_before  ⊑  mul_full_64_duplicate(%arg0: i64, %arg1: i64) -> !llvm.struct<_combined := by
  unfold mul_full_64_duplicate(%arg0: i64, %arg1: i64) -> !llvm.struct<_before mul_full_64_duplicate(%arg0: i64, %arg1: i64) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def umulhi_64_v2_combined := [llvmfunc|
  llvm.func @umulhi_64_v2() -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.call @get_number() : () -> i64
    %3 = llvm.call @get_number() : () -> i64
    %4 = llvm.and %3, %0  : i64
    %5 = llvm.lshr %3, %1  : i64
    %6 = llvm.lshr %2, %1  : i64
    %7 = llvm.and %2, %0  : i64
    %8 = llvm.mul %6, %5 overflow<nuw>  : i64
    %9 = llvm.mul %7, %5 overflow<nuw>  : i64
    %10 = llvm.mul %6, %4 overflow<nuw>  : i64
    %11 = llvm.mul %7, %4 overflow<nuw>  : i64
    %12 = llvm.lshr %11, %1  : i64
    %13 = llvm.add %10, %12  : i64
    %14 = llvm.and %13, %0  : i64
    %15 = llvm.add %9, %14  : i64
    %16 = llvm.lshr %13, %1  : i64
    %17 = llvm.add %16, %8  : i64
    %18 = llvm.lshr %15, %1  : i64
    %19 = llvm.add %18, %17  : i64
    llvm.return %19 : i64
  }]

theorem inst_combine_umulhi_64_v2   : umulhi_64_v2_before  ⊑  umulhi_64_v2_combined := by
  unfold umulhi_64_v2_before umulhi_64_v2_combined
  simp_alive_peephole
  sorry
def umulhi_64_v3_combined := [llvmfunc|
  llvm.func @umulhi_64_v3() -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.call @get_number() : () -> i64
    %3 = llvm.lshr %2, %0  : i64
    %4 = llvm.and %2, %1  : i64
    %5 = llvm.call @get_number() : () -> i64
    %6 = llvm.and %5, %1  : i64
    %7 = llvm.lshr %5, %0  : i64
    %8 = llvm.mul %3, %7 overflow<nuw>  : i64
    %9 = llvm.mul %4, %7 overflow<nuw>  : i64
    %10 = llvm.mul %3, %6 overflow<nuw>  : i64
    %11 = llvm.mul %4, %6 overflow<nuw>  : i64
    %12 = llvm.lshr %11, %0  : i64
    %13 = llvm.add %10, %12  : i64
    %14 = llvm.and %13, %1  : i64
    %15 = llvm.add %9, %14  : i64
    %16 = llvm.lshr %13, %0  : i64
    %17 = llvm.add %16, %8  : i64
    %18 = llvm.lshr %15, %0  : i64
    %19 = llvm.add %18, %17  : i64
    llvm.return %19 : i64
  }]

theorem inst_combine_umulhi_64_v3   : umulhi_64_v3_before  ⊑  umulhi_64_v3_combined := by
  unfold umulhi_64_v3_before umulhi_64_v3_combined
  simp_alive_peephole
  sorry
