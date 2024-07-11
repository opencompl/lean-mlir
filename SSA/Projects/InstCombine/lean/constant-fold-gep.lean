import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  constant-fold-gep
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def frob_before := [llvmfunc|
  llvm.func @frob() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : tensor<3xi32>) : !llvm.array<3 x i32>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.X", (array<3 x i32>, array<3 x i32>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.X", (array<3 x i32>, array<3 x i32>)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<"struct.X", (array<3 x i32>, array<3 x i32>)> 
    %6 = llvm.mlir.undef : !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>> 
    %8 = llvm.insertvalue %5, %7[1] : !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>> 
    %9 = llvm.insertvalue %5, %8[2] : !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>> 
    %10 = llvm.mlir.addressof @Y : !llvm.ptr
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.getelementptr inbounds %10[%12, %12, 0, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %14 = llvm.mlir.constant(2 : i64) : i64
    %15 = llvm.getelementptr inbounds %10[%12, %12, 0, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %16 = llvm.mlir.constant(3 : i64) : i64
    %17 = llvm.getelementptr %10[%12, %12, 0, %16] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %18 = llvm.mlir.constant(4 : i64) : i64
    %19 = llvm.getelementptr %10[%12, %12, 0, %18] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %20 = llvm.mlir.constant(5 : i64) : i64
    %21 = llvm.getelementptr %10[%12, %12, 0, %20] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %22 = llvm.mlir.constant(6 : i64) : i64
    %23 = llvm.getelementptr %10[%12, %12, 0, %22] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %24 = llvm.mlir.constant(7 : i64) : i64
    %25 = llvm.getelementptr %10[%12, %12, 0, %24] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %26 = llvm.mlir.constant(8 : i64) : i64
    %27 = llvm.getelementptr %10[%12, %12, 0, %26] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %28 = llvm.mlir.constant(9 : i64) : i64
    %29 = llvm.getelementptr %10[%12, %12, 0, %28] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %30 = llvm.mlir.constant(10 : i64) : i64
    %31 = llvm.getelementptr %10[%12, %12, 0, %30] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %32 = llvm.mlir.constant(11 : i64) : i64
    %33 = llvm.getelementptr %10[%12, %12, 0, %32] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %34 = llvm.mlir.constant(12 : i64) : i64
    %35 = llvm.getelementptr %10[%12, %12, 0, %34] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %36 = llvm.mlir.constant(13 : i64) : i64
    %37 = llvm.getelementptr %10[%12, %12, 0, %36] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %38 = llvm.mlir.constant(14 : i64) : i64
    %39 = llvm.getelementptr %10[%12, %12, 0, %38] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %40 = llvm.mlir.constant(15 : i64) : i64
    %41 = llvm.getelementptr %10[%12, %12, 0, %40] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %42 = llvm.mlir.constant(16 : i64) : i64
    %43 = llvm.getelementptr %10[%12, %12, 0, %42] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %44 = llvm.mlir.constant(17 : i64) : i64
    %45 = llvm.getelementptr %10[%12, %12, 0, %44] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %46 = llvm.mlir.constant(18 : i64) : i64
    %47 = llvm.getelementptr %10[%12, %12, 0, %46] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %48 = llvm.mlir.constant(36 : i64) : i64
    %49 = llvm.getelementptr %10[%12, %12, 0, %48] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %50 = llvm.mlir.constant(19 : i64) : i64
    %51 = llvm.getelementptr %10[%12, %12, 0, %50] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    llvm.store %0, %10 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %13 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %19 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %21 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %23 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %25 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %27 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %29 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %31 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %33 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %35 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %37 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %39 {alignment = 8 : i64} : i32, !llvm.ptr]

    llvm.store %0, %41 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %43 {alignment = 8 : i64} : i32, !llvm.ptr]

    llvm.store %0, %45 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %47 {alignment = 8 : i64} : i32, !llvm.ptr]

    llvm.store %0, %49 {alignment = 8 : i64} : i32, !llvm.ptr]

    llvm.store %0, %51 {alignment = 8 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<1000xi8>) : !llvm.array<1000 x i8>
    %4 = llvm.mlir.addressof @X : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x i8>
    %6 = llvm.bitcast %5 : !llvm.ptr to !llvm.ptr
    %7 = llvm.ptrtoint %4 : !llvm.ptr to i64
    %8 = llvm.sub %0, %7  : i64
    %9 = llvm.getelementptr %6[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %10 = llvm.ptrtoint %9 : !llvm.ptr to i64
    llvm.return %10 : i64
  }]

def test2_as1_before := [llvmfunc|
  llvm.func @test2_as1() -> i16 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<1000xi8>) : !llvm.array<1000 x i8>
    %4 = llvm.mlir.addressof @X_as1 : !llvm.ptr<1>
    %5 = llvm.getelementptr inbounds %4[%1, %0] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<1000 x i8>
    %6 = llvm.mlir.constant(0 : i16) : i16
    %7 = llvm.bitcast %5 : !llvm.ptr<1> to !llvm.ptr<1>
    %8 = llvm.ptrtoint %4 : !llvm.ptr<1> to i16
    %9 = llvm.sub %6, %8  : i16
    %10 = llvm.getelementptr %7[%9] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %11 = llvm.ptrtoint %10 : !llvm.ptr<1> to i16
    llvm.return %11 : i16
  }]

def gep_sub_self_before := [llvmfunc|
  llvm.func @gep_sub_self() -> !llvm.ptr {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.sub %1, %2  : i64
    %4 = llvm.getelementptr %0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %4 : !llvm.ptr
  }]

def gep_sub_self_plus_addr_before := [llvmfunc|
  llvm.func @gep_sub_self_plus_addr(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.sub %1, %2  : i64
    %4 = llvm.getelementptr %0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %5 = llvm.getelementptr %4[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %5 : !llvm.ptr
  }]

def gep_plus_addr_sub_self_before := [llvmfunc|
  llvm.func @gep_plus_addr_sub_self(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.sub %1, %2  : i64
    %4 = llvm.getelementptr %0[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %5 : !llvm.ptr
  }]

def gep_plus_addr_sub_self_in_loop_before := [llvmfunc|
  llvm.func @gep_plus_addr_sub_self_in_loop() -> !llvm.ptr {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.sub %1, %2  : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %4 = llvm.call @get.i64() : () -> i64
    %5 = llvm.getelementptr %0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.getelementptr %5[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use.ptr(%6) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  }]

def gep_sub_other_before := [llvmfunc|
  llvm.func @gep_sub_other() -> !llvm.ptr {
    %0 = llvm.mlir.addressof @g2 : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @g : !llvm.ptr
    %3 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %4 = llvm.sub %1, %3  : i64
    %5 = llvm.getelementptr %2[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %5 : !llvm.ptr
  }]

def gep_sub_other_to_int_before := [llvmfunc|
  llvm.func @gep_sub_other_to_int() -> i64 {
    %0 = llvm.mlir.addressof @g2 : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @g : !llvm.ptr
    %3 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %4 = llvm.sub %1, %3  : i64
    %5 = llvm.getelementptr %2[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    llvm.return %6 : i64
  }]

def frob_combined := [llvmfunc|
  llvm.func @frob() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : tensor<3xi32>) : !llvm.array<3 x i32>
    %3 = llvm.mlir.undef : !llvm.struct<"struct.X", (array<3 x i32>, array<3 x i32>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"struct.X", (array<3 x i32>, array<3 x i32>)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<"struct.X", (array<3 x i32>, array<3 x i32>)> 
    %6 = llvm.mlir.undef : !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>> 
    %8 = llvm.insertvalue %5, %7[1] : !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>> 
    %9 = llvm.insertvalue %5, %8[2] : !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>> 
    %10 = llvm.mlir.addressof @Y : !llvm.ptr
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.getelementptr inbounds %10[%12, %12, 0, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %14 = llvm.mlir.constant(2 : i64) : i64
    %15 = llvm.getelementptr inbounds %10[%12, %12, 0, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %16 = llvm.getelementptr inbounds %10[%12, %12, 1, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %17 = llvm.getelementptr inbounds %10[%12, %12, 1, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %18 = llvm.getelementptr inbounds %10[%12, %12, 1, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %19 = llvm.getelementptr inbounds %10[%12, %11, 0, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %20 = llvm.getelementptr inbounds %10[%12, %11, 0, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %21 = llvm.getelementptr inbounds %10[%12, %11, 0, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %22 = llvm.getelementptr inbounds %10[%12, %11, 1, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %23 = llvm.getelementptr inbounds %10[%12, %11, 1, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %24 = llvm.getelementptr inbounds %10[%12, %11, 1, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %25 = llvm.getelementptr inbounds %10[%12, %14, 0, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %26 = llvm.getelementptr inbounds %10[%12, %14, 0, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %27 = llvm.getelementptr inbounds %10[%12, %14, 0, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %28 = llvm.getelementptr inbounds %10[%12, %14, 1, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %29 = llvm.getelementptr inbounds %10[%12, %14, 1, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %30 = llvm.getelementptr inbounds %10[%12, %14, 1, %14] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %31 = llvm.getelementptr inbounds %10[%11, %12, 0, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %32 = llvm.getelementptr %10[%14, %12, 0, %12] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    %33 = llvm.getelementptr %10[%11, %12, 0, %11] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<3 x struct<"struct.X", (array<3 x i32>, array<3 x i32>)>>
    llvm.store %0, %10 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %13 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %15 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %16 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %17 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %18 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %19 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %20 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %21 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %22 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %23 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %24 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %25 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %26 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %27 {alignment = 8 : i64} : i32, !llvm.ptr
    llvm.store %0, %28 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %29 {alignment = 8 : i64} : i32, !llvm.ptr
    llvm.store %0, %30 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %31 {alignment = 8 : i64} : i32, !llvm.ptr
    llvm.store %0, %32 {alignment = 8 : i64} : i32, !llvm.ptr
    llvm.store %0, %33 {alignment = 8 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_frob   : frob_before  ⊑  frob_combined := by
  unfold frob_before frob_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() -> i64 {
    %0 = llvm.mlir.constant(1000 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2_as1_combined := [llvmfunc|
  llvm.func @test2_as1() -> i16 {
    %0 = llvm.mlir.constant(1000 : i16) : i16
    llvm.return %0 : i16
  }]

theorem inst_combine_test2_as1   : test2_as1_before  ⊑  test2_as1_combined := by
  unfold test2_as1_before test2_as1_combined
  simp_alive_peephole
  sorry
def gep_sub_self_combined := [llvmfunc|
  llvm.func @gep_sub_self() -> !llvm.ptr {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.sub %2, %1  : i64
    %4 = llvm.getelementptr %0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_gep_sub_self   : gep_sub_self_before  ⊑  gep_sub_self_combined := by
  unfold gep_sub_self_before gep_sub_self_combined
  simp_alive_peephole
  sorry
def gep_sub_self_plus_addr_combined := [llvmfunc|
  llvm.func @gep_sub_self_plus_addr(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.sub %2, %1  : i64
    %4 = llvm.getelementptr %0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %5 = llvm.getelementptr %4[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_gep_sub_self_plus_addr   : gep_sub_self_plus_addr_before  ⊑  gep_sub_self_plus_addr_combined := by
  unfold gep_sub_self_plus_addr_before gep_sub_self_plus_addr_combined
  simp_alive_peephole
  sorry
def gep_plus_addr_sub_self_combined := [llvmfunc|
  llvm.func @gep_plus_addr_sub_self(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.sub %2, %1  : i64
    %4 = llvm.getelementptr %0[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_gep_plus_addr_sub_self   : gep_plus_addr_sub_self_before  ⊑  gep_plus_addr_sub_self_combined := by
  unfold gep_plus_addr_sub_self_before gep_plus_addr_sub_self_combined
  simp_alive_peephole
  sorry
def gep_plus_addr_sub_self_in_loop_combined := [llvmfunc|
  llvm.func @gep_plus_addr_sub_self_in_loop() -> !llvm.ptr {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.sub %2, %1  : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %4 = llvm.call @get.i64() : () -> i64
    %5 = llvm.getelementptr %0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.getelementptr %5[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use.ptr(%6) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  }]

theorem inst_combine_gep_plus_addr_sub_self_in_loop   : gep_plus_addr_sub_self_in_loop_before  ⊑  gep_plus_addr_sub_self_in_loop_combined := by
  unfold gep_plus_addr_sub_self_in_loop_before gep_plus_addr_sub_self_in_loop_combined
  simp_alive_peephole
  sorry
def gep_sub_other_combined := [llvmfunc|
  llvm.func @gep_sub_other() -> !llvm.ptr {
    %0 = llvm.mlir.addressof @g2 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.sub %2, %1  : i64
    %4 = llvm.mlir.addressof @g : !llvm.ptr
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_gep_sub_other   : gep_sub_other_before  ⊑  gep_sub_other_combined := by
  unfold gep_sub_other_before gep_sub_other_combined
  simp_alive_peephole
  sorry
def gep_sub_other_to_int_combined := [llvmfunc|
  llvm.func @gep_sub_other_to_int() -> i64 {
    %0 = llvm.mlir.addressof @g2 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.addressof @g : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.sub %3, %1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_gep_sub_other_to_int   : gep_sub_other_to_int_before  ⊑  gep_sub_other_to_int_combined := by
  unfold gep_sub_other_to_int_before gep_sub_other_to_int_combined
  simp_alive_peephole
  sorry
