import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-01-19-fmod-constant-float-specials
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo1_before := [llvmfunc|
  llvm.func @foo1() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo2_before := [llvmfunc|
  llvm.func @foo2() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo3_before := [llvmfunc|
  llvm.func @foo3() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo4_before := [llvmfunc|
  llvm.func @foo4() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %2, %5 {alignment = 4 : i64} : f32, !llvm.ptr]

    %8 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %9 = llvm.fpext %8 : f32 to f64
    %10 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %11 = llvm.fpext %10 : f32 to f64
    %12 = llvm.frem %11, %9  : f64
    %13 = llvm.call @printf(%4, %12) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo5_before := [llvmfunc|
  llvm.func @foo5() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %3 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo6_before := [llvmfunc|
  llvm.func @foo6() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %3 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo7_before := [llvmfunc|
  llvm.func @foo7() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %3 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo8_before := [llvmfunc|
  llvm.func @foo8() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %3 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %2, %5 {alignment = 4 : i64} : f32, !llvm.ptr]

    %8 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %9 = llvm.fpext %8 : f32 to f64
    %10 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %11 = llvm.fpext %10 : f32 to f64
    %12 = llvm.frem %11, %9  : f64
    %13 = llvm.call @printf(%4, %12) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo9_before := [llvmfunc|
  llvm.func @foo9() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo10_before := [llvmfunc|
  llvm.func @foo10() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo11_before := [llvmfunc|
  llvm.func @foo11() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %2, %5 {alignment = 4 : i64} : f32, !llvm.ptr]

    %8 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %9 = llvm.fpext %8 : f32 to f64
    %10 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %11 = llvm.fpext %10 : f32 to f64
    %12 = llvm.frem %11, %9  : f64
    %13 = llvm.call @printf(%4, %12) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo12_before := [llvmfunc|
  llvm.func @foo12() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo13_before := [llvmfunc|
  llvm.func @foo13() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %3 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo14_before := [llvmfunc|
  llvm.func @foo14() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %3 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo15_before := [llvmfunc|
  llvm.func @foo15() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %3 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo16_before := [llvmfunc|
  llvm.func @foo16() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %3 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %6 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.store %2, %5 {alignment = 4 : i64} : f32, !llvm.ptr]

    %8 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %9 = llvm.fpext %8 : f32 to f64
    %10 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %11 = llvm.fpext %10 : f32 to f64
    %12 = llvm.frem %11, %9  : f64
    %13 = llvm.call @printf(%4, %12) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo1_combined := [llvmfunc|
  llvm.func @foo1() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo1   : foo1_before  ⊑  foo1_combined := by
  unfold foo1_before foo1_combined
  simp_alive_peephole
  sorry
def foo2_combined := [llvmfunc|
  llvm.func @foo2() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo2   : foo2_before  ⊑  foo2_combined := by
  unfold foo2_before foo2_combined
  simp_alive_peephole
  sorry
def foo3_combined := [llvmfunc|
  llvm.func @foo3() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo3   : foo3_before  ⊑  foo3_combined := by
  unfold foo3_before foo3_combined
  simp_alive_peephole
  sorry
def foo4_combined := [llvmfunc|
  llvm.func @foo4() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo4   : foo4_before  ⊑  foo4_combined := by
  unfold foo4_before foo4_combined
  simp_alive_peephole
  sorry
def foo5_combined := [llvmfunc|
  llvm.func @foo5() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo5   : foo5_before  ⊑  foo5_combined := by
  unfold foo5_before foo5_combined
  simp_alive_peephole
  sorry
def foo6_combined := [llvmfunc|
  llvm.func @foo6() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo6   : foo6_before  ⊑  foo6_combined := by
  unfold foo6_before foo6_combined
  simp_alive_peephole
  sorry
def foo7_combined := [llvmfunc|
  llvm.func @foo7() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo7   : foo7_before  ⊑  foo7_combined := by
  unfold foo7_before foo7_combined
  simp_alive_peephole
  sorry
def foo8_combined := [llvmfunc|
  llvm.func @foo8() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo8   : foo8_before  ⊑  foo8_combined := by
  unfold foo8_before foo8_combined
  simp_alive_peephole
  sorry
def foo9_combined := [llvmfunc|
  llvm.func @foo9() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo9   : foo9_before  ⊑  foo9_combined := by
  unfold foo9_before foo9_combined
  simp_alive_peephole
  sorry
def foo10_combined := [llvmfunc|
  llvm.func @foo10() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo10   : foo10_before  ⊑  foo10_combined := by
  unfold foo10_before foo10_combined
  simp_alive_peephole
  sorry
def foo11_combined := [llvmfunc|
  llvm.func @foo11() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo11   : foo11_before  ⊑  foo11_combined := by
  unfold foo11_before foo11_combined
  simp_alive_peephole
  sorry
def foo12_combined := [llvmfunc|
  llvm.func @foo12() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo12   : foo12_before  ⊑  foo12_combined := by
  unfold foo12_before foo12_combined
  simp_alive_peephole
  sorry
def foo13_combined := [llvmfunc|
  llvm.func @foo13() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo13   : foo13_before  ⊑  foo13_combined := by
  unfold foo13_before foo13_combined
  simp_alive_peephole
  sorry
def foo14_combined := [llvmfunc|
  llvm.func @foo14() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(3.500000e+00 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo14   : foo14_before  ⊑  foo14_combined := by
  unfold foo14_before foo14_combined
  simp_alive_peephole
  sorry
def foo15_combined := [llvmfunc|
  llvm.func @foo15() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo15   : foo15_before  ⊑  foo15_combined := by
  unfold foo15_before foo15_combined
  simp_alive_peephole
  sorry
def foo16_combined := [llvmfunc|
  llvm.func @foo16() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_foo16   : foo16_before  ⊑  foo16_combined := by
  unfold foo16_before foo16_combined
  simp_alive_peephole
  sorry
