import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcpy-from-global
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: f32, %arg2: f32, %arg3: f32, %arg4: f32) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(dense<"0x000080BF000080BF000080BF00000000000080BF000080BF00000000000080BF000080BF000080BF000000000000803F000080BF000080BF0000803F00000000000080BF00000000000080BF000080BF000080BF00000000000080BF0000803F000080BF000000000000803F000080BF000080BF000000000000803F0000803F000080BF0000803F000080BF00000000000080BF0000803F00000000000080BF000080BF0000803F000000000000803F000080BF0000803F0000803F0000000000000000000080BF000080BF000080BF00000000000080BF000080BF0000803F00000000000080BF0000803F000080BF00000000000080BF0000803F0000803F0000803F000080BF000080BF000000000000803F000080BF00000000000080BF0000803F000080BF000000000000803F0000803F000080BF0000803F000000000000803F00000000000080BF000080BF0000803F00000000000080BF0000803F0000803F000000000000803F000080BF0000803F000000000000803F0000803F0000803F0000803F000080BF000000000000803F0000803F00000000000080BF0000803F0000803F000000000000803F0000803F0000803F0000803F00000000000000000000803F000080BF000080BF000000000000803F000080BF0000803F000000000000803F0000803F000080BF000000000000803F0000803F0000803F"> : tensor<128xf32>) : !llvm.array<128 x f32>
    %2 = llvm.mlir.addressof @C.0.1248 : !llvm.ptr
    %3 = llvm.mlir.constant(512 : i64) : i64
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(124 : i32) : i32
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.alloca %0 x !llvm.array<128 x f32> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%9, %2, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    %10 = llvm.shl %arg0, %4  : i32
    %11 = llvm.and %10, %5  : i32
    %12 = llvm.getelementptr %9[%6, %11] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<128 x f32>
    %13 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %14 = llvm.fmul %13, %arg1  : f32
    %15 = llvm.fadd %14, %7  : f32
    %16 = llvm.or %11, %0  : i32
    %17 = llvm.getelementptr %9[%6, %16] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<128 x f32>
    %18 = llvm.load %17 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %19 = llvm.fmul %18, %arg2  : f32
    %20 = llvm.fadd %19, %15  : f32
    %21 = llvm.or %11, %4  : i32
    %22 = llvm.getelementptr %9[%6, %21] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<128 x f32>
    %23 = llvm.load %22 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %24 = llvm.fmul %23, %arg3  : f32
    %25 = llvm.fadd %24, %20  : f32
    %26 = llvm.or %11, %8  : i32
    %27 = llvm.getelementptr %9[%6, %26] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<128 x f32>
    %28 = llvm.load %27 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %29 = llvm.fmul %28, %arg4  : f32
    %30 = llvm.fadd %29, %25  : f32
    llvm.return %30 : f32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %10 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%9, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    "llvm.intr.memcpy"(%10, %9, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test2_no_null_opt_before := [llvmfunc|
  llvm.func @test2_no_null_opt() attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %10 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%9, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    "llvm.intr.memcpy"(%10, %9, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test2_addrspacecast_before := [llvmfunc|
  llvm.func @test2_addrspacecast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %10 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %11 = llvm.addrspacecast %9 : !llvm.ptr to !llvm.ptr<1>
    %12 = llvm.addrspacecast %10 : !llvm.ptr to !llvm.ptr<1>
    "llvm.intr.memcpy"(%11, %7, %8) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()]

    "llvm.intr.memcpy"(%12, %11, %8) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr<1>, i64) -> ()]

    llvm.call @bar_as1(%12) : (!llvm.ptr<1>) -> ()
    llvm.return
  }]

def test3_before := [llvmfunc|
  llvm.func @test3() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%9, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @bar(%9) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test3_addrspacecast_before := [llvmfunc|
  llvm.func @test3_addrspacecast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.addrspacecast %7 : !llvm.ptr to !llvm.ptr<1>
    %9 = llvm.mlir.constant(124 : i64) : i64
    %10 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%10, %8, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()]

    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test4_before := [llvmfunc|
  llvm.func @test4() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%9, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @baz(%9) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test5_before := [llvmfunc|
  llvm.func @test5() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start -1, %9 : !llvm.ptr
    "llvm.intr.memcpy"(%9, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @baz(%9) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test6_before := [llvmfunc|
  llvm.func @test6() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test7_before := [llvmfunc|
  llvm.func @test7() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test8_before := [llvmfunc|
  llvm.func @test8() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %2, %6[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %2, %7[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %9 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %12 = llvm.mlir.addressof @H : !llvm.ptr
    %13 = llvm.getelementptr inbounds %12[%1, %0] : (!llvm.ptr, i64, i32) -> !llvm.ptr, !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %14 = llvm.mlir.constant(20 : i64) : i64
    %15 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%15, %13, %14) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @bar(%15) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test8_addrspacecast_before := [llvmfunc|
  llvm.func @test8_addrspacecast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %2, %6[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %2, %7[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %9 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %12 = llvm.mlir.addressof @H : !llvm.ptr
    %13 = llvm.getelementptr inbounds %12[%1, %0] : (!llvm.ptr, i64, i32) -> !llvm.ptr, !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %14 = llvm.addrspacecast %13 : !llvm.ptr to !llvm.ptr<1>
    %15 = llvm.mlir.constant(20 : i64) : i64
    %16 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%16, %14, %15) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()]

    llvm.call @bar(%16) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test9_before := [llvmfunc|
  llvm.func @test9() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %2, %6[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %2, %7[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %9 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %12 = llvm.mlir.addressof @H : !llvm.ptr
    %13 = llvm.getelementptr inbounds %12[%1, %0] : (!llvm.ptr, i64, i32) -> !llvm.ptr, !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %14 = llvm.mlir.constant(20 : i64) : i64
    %15 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%15, %13, %14) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @bar(%15) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test9_addrspacecast_before := [llvmfunc|
  llvm.func @test9_addrspacecast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %2, %6[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %2, %7[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %9 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %12 = llvm.mlir.addressof @H : !llvm.ptr
    %13 = llvm.getelementptr inbounds %12[%1, %0] : (!llvm.ptr, i64, i32) -> !llvm.ptr, !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %14 = llvm.addrspacecast %13 : !llvm.ptr to !llvm.ptr<1>
    %15 = llvm.mlir.constant(20 : i64) : i64
    %16 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%16, %14, %15) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()]

    llvm.call @bar(%16) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test9_small_global_before := [llvmfunc|
  llvm.func @test9_small_global() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant("\01\01\02") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @_ZL3KKK : !llvm.ptr
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(0 : i8) : i8
    %5 = llvm.mlir.constant(dense<0> : tensor<1000000xi8>) : !llvm.array<1000000 x i8>
    %6 = llvm.mlir.addressof @bbb : !llvm.ptr
    %7 = llvm.mlir.constant(1000000 : i64) : i64
    %8 = llvm.alloca %0 x !llvm.array<1000000 x i8> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%8, %2, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    "llvm.intr.memcpy"(%6, %8, %7) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test10_same_global_before := [llvmfunc|
  llvm.func @test10_same_global() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant("\01\01\02") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @_ZL3KKK : !llvm.ptr
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(0 : i8) : i8
    %5 = llvm.mlir.constant(dense<0> : tensor<1000000xi8>) : !llvm.array<1000000 x i8>
    %6 = llvm.mlir.addressof @bbb : !llvm.ptr
    %7 = llvm.alloca %0 x !llvm.array<3 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%7, %2, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    "llvm.intr.memcpy"(%6, %7, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(dense<0.000000e+00> : tensor<4xf32>) : !llvm.array<4 x f32>
    %3 = llvm.mlir.addressof @I : !llvm.ptr<1>
    %4 = llvm.mlir.constant(16 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.array<4 x f32> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 16, %6 : !llvm.ptr
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()]

    %7 = llvm.getelementptr inbounds %6[%5, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x f32>
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.return %8 : f32
  }]

def test11_volatile_before := [llvmfunc|
  llvm.func @test11_volatile(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(dense<0.000000e+00> : tensor<4xf32>) : !llvm.array<4 x f32>
    %3 = llvm.mlir.addressof @I : !llvm.ptr<1>
    %4 = llvm.mlir.constant(16 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.array<4 x f32> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 16, %6 : !llvm.ptr
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()]

    %7 = llvm.getelementptr inbounds %6[%5, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x f32>
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.return %8 : f32
  }]

def memcpy_from_readonly_noalias_before := [llvmfunc|
  llvm.func @memcpy_from_readonly_noalias(%arg0: !llvm.ptr {llvm.align = 8 : i64, llvm.dereferenceable = 124 : i64, llvm.noalias, llvm.readonly}) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(124 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%2, %arg0, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @bar(%2) : (!llvm.ptr) -> ()
    llvm.return
  }]

def memcpy_from_just_readonly_before := [llvmfunc|
  llvm.func @memcpy_from_just_readonly(%arg0: !llvm.ptr {llvm.align = 8 : i64, llvm.dereferenceable = 124 : i64, llvm.readonly}) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(124 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%2, %arg0, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @bar(%2) : (!llvm.ptr) -> ()
    llvm.return
  }]

def volatile_memcpy_before := [llvmfunc|
  llvm.func @volatile_memcpy() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }]

def memcpy_to_nocapture_readonly_before := [llvmfunc|
  llvm.func @memcpy_to_nocapture_readonly() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }]

def memcpy_to_capturing_readonly_before := [llvmfunc|
  llvm.func @memcpy_to_capturing_readonly() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }]

def memcpy_to_aliased_nocapture_readonly_before := [llvmfunc|
  llvm.func @memcpy_to_aliased_nocapture_readonly() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.call @two_params(%13, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: f32, %arg2: f32, %arg3: f32, %arg4: f32) -> f32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(124 : i32) : i32
    %2 = llvm.mlir.constant(dense<"0x000080BF000080BF000080BF00000000000080BF000080BF00000000000080BF000080BF000080BF000000000000803F000080BF000080BF0000803F00000000000080BF00000000000080BF000080BF000080BF00000000000080BF0000803F000080BF000000000000803F000080BF000080BF000000000000803F0000803F000080BF0000803F000080BF00000000000080BF0000803F00000000000080BF000080BF0000803F000000000000803F000080BF0000803F0000803F0000000000000000000080BF000080BF000080BF00000000000080BF000080BF0000803F00000000000080BF0000803F000080BF00000000000080BF0000803F0000803F0000803F000080BF000080BF000000000000803F000080BF00000000000080BF0000803F000080BF000000000000803F0000803F000080BF0000803F000000000000803F00000000000080BF000080BF0000803F00000000000080BF0000803F0000803F000000000000803F000080BF0000803F000000000000803F0000803F0000803F0000803F000080BF000000000000803F0000803F00000000000080BF0000803F0000803F000000000000803F0000803F0000803F0000803F00000000000000000000803F000080BF000080BF000000000000803F000080BF0000803F000000000000803F0000803F000080BF000000000000803F0000803F0000803F"> : tensor<128xf32>) : !llvm.array<128 x f32>
    %3 = llvm.mlir.addressof @C.0.1248 : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(3 : i32) : i32
    %8 = llvm.shl %arg0, %0  : i32
    %9 = llvm.and %8, %1  : i32
    %10 = llvm.zext %9 : i32 to i64
    %11 = llvm.getelementptr %3[%4, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<128 x f32>
    %12 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    %13 = llvm.fmul %12, %arg1  : f32
    %14 = llvm.fadd %13, %5  : f32
    %15 = llvm.or %9, %6  : i32
    %16 = llvm.zext %15 : i32 to i64
    %17 = llvm.getelementptr %3[%4, %16] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<128 x f32>
    %18 = llvm.load %17 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    %19 = llvm.fmul %18, %arg2  : f32
    %20 = llvm.fadd %19, %14  : f32
    %21 = llvm.or %9, %0  : i32
    %22 = llvm.zext %21 : i32 to i64
    %23 = llvm.getelementptr %3[%4, %22] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<128 x f32>
    %24 = llvm.load %23 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    %25 = llvm.fmul %24, %arg3  : f32
    %26 = llvm.fadd %25, %20  : f32
    %27 = llvm.or %9, %7  : i32
    %28 = llvm.zext %27 : i32 to i64
    %29 = llvm.getelementptr %3[%4, %28] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<128 x f32>
    %30 = llvm.load %29 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    %31 = llvm.fmul %30, %arg4  : f32
    %32 = llvm.fadd %31, %26  : f32
    llvm.return %32 : f32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
    "llvm.intr.memcpy"(%9, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
    llvm.call @bar(%9) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2_no_null_opt_combined := [llvmfunc|
  llvm.func @test2_no_null_opt() attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test2_no_null_opt   : test2_no_null_opt_before  ⊑  test2_no_null_opt_combined := by
  unfold test2_no_null_opt_before test2_no_null_opt_combined
  simp_alive_peephole
  sorry
    "llvm.intr.memcpy"(%9, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_test2_no_null_opt   : test2_no_null_opt_before  ⊑  test2_no_null_opt_combined := by
  unfold test2_no_null_opt_before test2_no_null_opt_combined
  simp_alive_peephole
  sorry
    llvm.call @bar(%9) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test2_no_null_opt   : test2_no_null_opt_before  ⊑  test2_no_null_opt_combined := by
  unfold test2_no_null_opt_before test2_no_null_opt_combined
  simp_alive_peephole
  sorry
def test2_addrspacecast_combined := [llvmfunc|
  llvm.func @test2_addrspacecast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.addrspacecast %7 : !llvm.ptr to !llvm.ptr<1>
    %9 = llvm.mlir.constant(124 : i64) : i64
    %10 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test2_addrspacecast   : test2_addrspacecast_before  ⊑  test2_addrspacecast_combined := by
  unfold test2_addrspacecast_before test2_addrspacecast_combined
  simp_alive_peephole
  sorry
    %11 = llvm.addrspacecast %10 : !llvm.ptr to !llvm.ptr<1>
    "llvm.intr.memcpy"(%11, %8, %9) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr<1>, i64) -> ()]

theorem inst_combine_test2_addrspacecast   : test2_addrspacecast_before  ⊑  test2_addrspacecast_combined := by
  unfold test2_addrspacecast_before test2_addrspacecast_combined
  simp_alive_peephole
  sorry
    llvm.call @bar_as1(%11) : (!llvm.ptr<1>) -> ()
    llvm.return
  }]

theorem inst_combine_test2_addrspacecast   : test2_addrspacecast_before  ⊑  test2_addrspacecast_combined := by
  unfold test2_addrspacecast_before test2_addrspacecast_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.mlir.addressof @G : !llvm.ptr
    llvm.call @bar(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test3_addrspacecast_combined := [llvmfunc|
  llvm.func @test3_addrspacecast() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.mlir.addressof @G : !llvm.ptr
    llvm.call @bar(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test3_addrspacecast   : test3_addrspacecast_before  ⊑  test3_addrspacecast_combined := by
  unfold test3_addrspacecast_before test3_addrspacecast_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.mlir.addressof @G : !llvm.ptr
    llvm.call @baz(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.mlir.addressof @G : !llvm.ptr
    llvm.call @baz(%6) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %3 = llvm.insertvalue %0, %2[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %0, %3[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %0, %4[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %0, %5[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %9 = llvm.insertvalue %6, %8[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.mlir.addressof @H : !llvm.ptr
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %3 = llvm.insertvalue %0, %2[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %0, %3[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %0, %4[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %0, %5[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %9 = llvm.insertvalue %6, %8[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.mlir.addressof @H : !llvm.ptr
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %3, %6[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %3, %7[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %9 = llvm.insertvalue %3, %8[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %10 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %12 = llvm.insertvalue %9, %11[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %13 = llvm.mlir.addressof @H : !llvm.ptr
    %14 = llvm.getelementptr inbounds %13[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %15 = llvm.mlir.constant(20 : i64) : i64
    %16 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
    "llvm.intr.memcpy"(%16, %14, %15) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
    llvm.call @bar(%16) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test8_addrspacecast_combined := [llvmfunc|
  llvm.func @test8_addrspacecast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %3, %6[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %3, %7[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %9 = llvm.insertvalue %3, %8[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %10 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %12 = llvm.insertvalue %9, %11[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %13 = llvm.mlir.addressof @H : !llvm.ptr
    %14 = llvm.getelementptr inbounds %13[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %15 = llvm.addrspacecast %14 : !llvm.ptr to !llvm.ptr<1>
    %16 = llvm.mlir.constant(20 : i64) : i64
    %17 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test8_addrspacecast   : test8_addrspacecast_before  ⊑  test8_addrspacecast_combined := by
  unfold test8_addrspacecast_before test8_addrspacecast_combined
  simp_alive_peephole
  sorry
    "llvm.intr.memcpy"(%17, %15, %16) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()]

theorem inst_combine_test8_addrspacecast   : test8_addrspacecast_before  ⊑  test8_addrspacecast_combined := by
  unfold test8_addrspacecast_before test8_addrspacecast_combined
  simp_alive_peephole
  sorry
    llvm.call @bar(%17) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test8_addrspacecast   : test8_addrspacecast_before  ⊑  test8_addrspacecast_combined := by
  unfold test8_addrspacecast_before test8_addrspacecast_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9() {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %2, %6[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %2, %7[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %9 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %12 = llvm.mlir.addressof @H : !llvm.ptr
    %13 = llvm.getelementptr inbounds %12[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test9_addrspacecast_combined := [llvmfunc|
  llvm.func @test9_addrspacecast() {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %2, %6[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %2, %7[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %9 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %12 = llvm.mlir.addressof @H : !llvm.ptr
    %13 = llvm.getelementptr inbounds %12[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test9_addrspacecast   : test9_addrspacecast_before  ⊑  test9_addrspacecast_combined := by
  unfold test9_addrspacecast_before test9_addrspacecast_combined
  simp_alive_peephole
  sorry
def test9_small_global_combined := [llvmfunc|
  llvm.func @test9_small_global() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant("\01\01\02") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @_ZL3KKK : !llvm.ptr
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(0 : i8) : i8
    %5 = llvm.mlir.constant(dense<0> : tensor<1000000xi8>) : !llvm.array<1000000 x i8>
    %6 = llvm.mlir.addressof @bbb : !llvm.ptr
    %7 = llvm.mlir.constant(1000000 : i64) : i64
    %8 = llvm.alloca %0 x !llvm.array<1000000 x i8> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test9_small_global   : test9_small_global_before  ⊑  test9_small_global_combined := by
  unfold test9_small_global_before test9_small_global_combined
  simp_alive_peephole
  sorry
    "llvm.intr.memcpy"(%8, %2, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_test9_small_global   : test9_small_global_before  ⊑  test9_small_global_combined := by
  unfold test9_small_global_before test9_small_global_combined
  simp_alive_peephole
  sorry
    "llvm.intr.memcpy"(%6, %8, %7) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_test9_small_global   : test9_small_global_before  ⊑  test9_small_global_combined := by
  unfold test9_small_global_before test9_small_global_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test9_small_global   : test9_small_global_before  ⊑  test9_small_global_combined := by
  unfold test9_small_global_before test9_small_global_combined
  simp_alive_peephole
  sorry
def test10_same_global_combined := [llvmfunc|
  llvm.func @test10_same_global() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1000000xi8>) : !llvm.array<1000000 x i8>
    %2 = llvm.mlir.addressof @bbb : !llvm.ptr
    %3 = llvm.mlir.constant("\01\01\02") : !llvm.array<3 x i8>
    %4 = llvm.mlir.addressof @_ZL3KKK : !llvm.ptr
    %5 = llvm.mlir.constant(3 : i64) : i64
    "llvm.intr.memcpy"(%2, %4, %5) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_test10_same_global   : test10_same_global_before  ⊑  test10_same_global_combined := by
  unfold test10_same_global_before test10_same_global_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test10_same_global   : test10_same_global_before  ⊑  test10_same_global_combined := by
  unfold test10_same_global_before test10_same_global_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test11_volatile_combined := [llvmfunc|
  llvm.func @test11_volatile(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(dense<0.000000e+00> : tensor<4xf32>) : !llvm.array<4 x f32>
    %3 = llvm.mlir.addressof @I : !llvm.ptr<1>
    %4 = llvm.mlir.constant(16 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.array<4 x f32> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test11_volatile   : test11_volatile_before  ⊑  test11_volatile_combined := by
  unfold test11_volatile_before test11_volatile_combined
  simp_alive_peephole
  sorry
    llvm.intr.lifetime.start 16, %6 : !llvm.ptr
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()]

theorem inst_combine_test11_volatile   : test11_volatile_before  ⊑  test11_volatile_combined := by
  unfold test11_volatile_before test11_volatile_combined
  simp_alive_peephole
  sorry
    %7 = llvm.getelementptr inbounds %6[%5, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x f32>
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine_test11_volatile   : test11_volatile_before  ⊑  test11_volatile_combined := by
  unfold test11_volatile_before test11_volatile_combined
  simp_alive_peephole
  sorry
    llvm.return %8 : f32
  }]

theorem inst_combine_test11_volatile   : test11_volatile_before  ⊑  test11_volatile_combined := by
  unfold test11_volatile_before test11_volatile_combined
  simp_alive_peephole
  sorry
def memcpy_from_readonly_noalias_combined := [llvmfunc|
  llvm.func @memcpy_from_readonly_noalias(%arg0: !llvm.ptr {llvm.align = 8 : i64, llvm.dereferenceable = 124 : i64, llvm.noalias, llvm.readonly}) {
    llvm.call @bar(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_memcpy_from_readonly_noalias   : memcpy_from_readonly_noalias_before  ⊑  memcpy_from_readonly_noalias_combined := by
  unfold memcpy_from_readonly_noalias_before memcpy_from_readonly_noalias_combined
  simp_alive_peephole
  sorry
def memcpy_from_just_readonly_combined := [llvmfunc|
  llvm.func @memcpy_from_just_readonly(%arg0: !llvm.ptr {llvm.align = 8 : i64, llvm.dereferenceable = 124 : i64, llvm.readonly}) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(124 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_memcpy_from_just_readonly   : memcpy_from_just_readonly_before  ⊑  memcpy_from_just_readonly_combined := by
  unfold memcpy_from_just_readonly_before memcpy_from_just_readonly_combined
  simp_alive_peephole
  sorry
    "llvm.intr.memcpy"(%2, %arg0, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_memcpy_from_just_readonly   : memcpy_from_just_readonly_before  ⊑  memcpy_from_just_readonly_combined := by
  unfold memcpy_from_just_readonly_before memcpy_from_just_readonly_combined
  simp_alive_peephole
  sorry
    llvm.call @bar(%2) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_memcpy_from_just_readonly   : memcpy_from_just_readonly_before  ⊑  memcpy_from_just_readonly_combined := by
  unfold memcpy_from_just_readonly_before memcpy_from_just_readonly_combined
  simp_alive_peephole
  sorry
def volatile_memcpy_combined := [llvmfunc|
  llvm.func @volatile_memcpy() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_volatile_memcpy   : volatile_memcpy_before  ⊑  volatile_memcpy_combined := by
  unfold volatile_memcpy_before volatile_memcpy_combined
  simp_alive_peephole
  sorry
    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_volatile_memcpy   : volatile_memcpy_before  ⊑  volatile_memcpy_combined := by
  unfold volatile_memcpy_before volatile_memcpy_combined
  simp_alive_peephole
  sorry
    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_volatile_memcpy   : volatile_memcpy_before  ⊑  volatile_memcpy_combined := by
  unfold volatile_memcpy_before volatile_memcpy_combined
  simp_alive_peephole
  sorry
def memcpy_to_nocapture_readonly_combined := [llvmfunc|
  llvm.func @memcpy_to_nocapture_readonly() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %3 = llvm.insertvalue %0, %2[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %0, %3[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %0, %4[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %0, %5[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %9 = llvm.insertvalue %6, %8[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.mlir.addressof @H : !llvm.ptr
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_memcpy_to_nocapture_readonly   : memcpy_to_nocapture_readonly_before  ⊑  memcpy_to_nocapture_readonly_combined := by
  unfold memcpy_to_nocapture_readonly_before memcpy_to_nocapture_readonly_combined
  simp_alive_peephole
  sorry
def memcpy_to_capturing_readonly_combined := [llvmfunc|
  llvm.func @memcpy_to_capturing_readonly() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_memcpy_to_capturing_readonly   : memcpy_to_capturing_readonly_before  ⊑  memcpy_to_capturing_readonly_combined := by
  unfold memcpy_to_capturing_readonly_before memcpy_to_capturing_readonly_combined
  simp_alive_peephole
  sorry
    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_memcpy_to_capturing_readonly   : memcpy_to_capturing_readonly_before  ⊑  memcpy_to_capturing_readonly_combined := by
  unfold memcpy_to_capturing_readonly_before memcpy_to_capturing_readonly_combined
  simp_alive_peephole
  sorry
    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_memcpy_to_capturing_readonly   : memcpy_to_capturing_readonly_before  ⊑  memcpy_to_capturing_readonly_combined := by
  unfold memcpy_to_capturing_readonly_before memcpy_to_capturing_readonly_combined
  simp_alive_peephole
  sorry
def memcpy_to_aliased_nocapture_readonly_combined := [llvmfunc|
  llvm.func @memcpy_to_aliased_nocapture_readonly() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_memcpy_to_aliased_nocapture_readonly   : memcpy_to_aliased_nocapture_readonly_before  ⊑  memcpy_to_aliased_nocapture_readonly_combined := by
  unfold memcpy_to_aliased_nocapture_readonly_before memcpy_to_aliased_nocapture_readonly_combined
  simp_alive_peephole
  sorry
    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_memcpy_to_aliased_nocapture_readonly   : memcpy_to_aliased_nocapture_readonly_before  ⊑  memcpy_to_aliased_nocapture_readonly_combined := by
  unfold memcpy_to_aliased_nocapture_readonly_before memcpy_to_aliased_nocapture_readonly_combined
  simp_alive_peephole
  sorry
    llvm.call @two_params(%13, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_memcpy_to_aliased_nocapture_readonly   : memcpy_to_aliased_nocapture_readonly_before  ⊑  memcpy_to_aliased_nocapture_readonly_combined := by
  unfold memcpy_to_aliased_nocapture_readonly_before memcpy_to_aliased_nocapture_readonly_combined
  simp_alive_peephole
  sorry
