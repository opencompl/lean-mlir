import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-01-19-fmod-constant-float
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1() -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %3 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %4 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.bitcast %1 : i32 to i32
    %7 = llvm.frem %2, %3  : f64
    %8 = llvm.fptrunc %7 : f64 to f32
    llvm.store %8, %5 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.store %9, %4 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %10 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.return %10 : f32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1.000000e-01 : f64) : f64
    %3 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %4 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.bitcast %1 : i32 to i32
    %7 = llvm.frem %2, %3  : f64
    %8 = llvm.fptrunc %7 : f64 to f32
    llvm.store %8, %5 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.store %9, %4 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %10 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.return %10 : f32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3() -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %3 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %4 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.bitcast %1 : i32 to i32
    %7 = llvm.frem %2, %3  : f64
    %8 = llvm.fptrunc %7 : f64 to f32
    llvm.store %8, %5 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.store %9, %4 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %10 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.return %10 : f32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4() -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1.000000e-01 : f64) : f64
    %3 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %4 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.bitcast %1 : i32 to i32
    %7 = llvm.frem %2, %3  : f64
    %8 = llvm.fptrunc %7 : f64 to f32
    llvm.store %8, %5 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.store %9, %4 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %10 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.return %10 : f32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1() -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e-01 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1.000000e-01 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3() -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e-01 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4() -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1.000000e-01 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
