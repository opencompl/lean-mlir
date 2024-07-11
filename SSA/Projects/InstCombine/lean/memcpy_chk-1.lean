import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcpy_chk-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %10 = llvm.insertvalue %3, %9[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %11 = llvm.insertvalue %3, %10[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %1, %11[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.mlir.addressof @t2 : !llvm.ptr
    %14 = llvm.mlir.constant(1824 : i64) : i64
    %15 = llvm.call @__memcpy_chk(%8, %13, %14, %14) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %15 : !llvm.ptr
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.constant(dense<0> : tensor<2048xi8>) : !llvm.array<2048 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)>
    %11 = llvm.insertvalue %3, %10[0] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %12 = llvm.insertvalue %3, %11[1] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %13 = llvm.insertvalue %9, %12[2] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %14 = llvm.mlir.addressof @t3 : !llvm.ptr
    %15 = llvm.mlir.constant(1824 : i64) : i64
    %16 = llvm.mlir.constant(2848 : i64) : i64
    %17 = llvm.call @__memcpy_chk(%8, %14, %15, %16) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %17 : !llvm.ptr
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %10 = llvm.insertvalue %3, %9[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %11 = llvm.insertvalue %3, %10[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %1, %11[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.mlir.addressof @t2 : !llvm.ptr
    %14 = llvm.mlir.constant(1824 : i64) : i64
    %15 = llvm.call @__memcpy_chk(%8, %13, %14, %14) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %15 : !llvm.ptr
  }]

def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<2048xi8>) : !llvm.array<2048 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %8 = llvm.mlir.addressof @t3 : !llvm.ptr
    %9 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %11 = llvm.insertvalue %3, %10[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %3, %11[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.insertvalue %9, %12[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %14 = llvm.mlir.addressof @t1 : !llvm.ptr
    %15 = llvm.mlir.constant(2848 : i64) : i64
    %16 = llvm.mlir.constant(1824 : i64) : i64
    %17 = llvm.call @__memcpy_chk(%8, %14, %15, %16) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %17 : !llvm.ptr
  }]

def test_no_simplify2_before := [llvmfunc|
  llvm.func @test_no_simplify2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %10 = llvm.insertvalue %3, %9[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %11 = llvm.insertvalue %3, %10[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %1, %11[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.mlir.addressof @t2 : !llvm.ptr
    %14 = llvm.mlir.constant(1024 : i64) : i64
    %15 = llvm.mlir.constant(0 : i64) : i64
    %16 = llvm.call @__memcpy_chk(%8, %13, %14, %15) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %16 : !llvm.ptr
  }]

def test_no_simplify3_before := [llvmfunc|
  llvm.func @test_no_simplify3(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1824 : i64) : i64
    %1 = llvm.call @__memcpy_chk(%arg0, %arg1, %0, %0) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def test_simplify_return_indcall_before := [llvmfunc|
  llvm.func @test_simplify_return_indcall(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t2 : !llvm.ptr
    %9 = llvm.mlir.constant(1824 : i64) : i64
    %10 = llvm.call %arg0() : !llvm.ptr, () -> !llvm.ptr
    %11 = llvm.call @__memcpy_chk(%10, %8, %9, %9) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %11 : !llvm.ptr
  }]

def test_no_incompatible_attr_before := [llvmfunc|
  llvm.func @test_no_incompatible_attr(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %10 = llvm.insertvalue %3, %9[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %11 = llvm.insertvalue %3, %10[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %1, %11[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.mlir.addressof @t2 : !llvm.ptr
    %14 = llvm.mlir.constant(1824 : i64) : i64
    %15 = llvm.call @__memcpy_chk(%8, %13, %14, %14) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %15 : !llvm.ptr
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %10 = llvm.insertvalue %3, %9[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %11 = llvm.insertvalue %3, %10[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %1, %11[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.mlir.addressof @t2 : !llvm.ptr
    %14 = llvm.mlir.constant(1824 : i64) : i64
    "llvm.intr.memcpy"(%8, %13, %14) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %8 : !llvm.ptr
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.constant(dense<0> : tensor<2048xi8>) : !llvm.array<2048 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)>
    %11 = llvm.insertvalue %3, %10[0] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %12 = llvm.insertvalue %3, %11[1] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %13 = llvm.insertvalue %9, %12[2] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %14 = llvm.mlir.addressof @t3 : !llvm.ptr
    %15 = llvm.mlir.constant(1824 : i64) : i64
    "llvm.intr.memcpy"(%8, %14, %15) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %8 : !llvm.ptr
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %10 = llvm.insertvalue %3, %9[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %11 = llvm.insertvalue %3, %10[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %1, %11[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.mlir.addressof @t2 : !llvm.ptr
    %14 = llvm.mlir.constant(1824 : i64) : i64
    "llvm.intr.memcpy"(%8, %13, %14) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %8 : !llvm.ptr
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<2048xi8>) : !llvm.array<2048 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T3", (array<100 x i32>, array<100 x i32>, array<2048 x i8>)> 
    %8 = llvm.mlir.addressof @t3 : !llvm.ptr
    %9 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %10 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %11 = llvm.insertvalue %3, %10[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %3, %11[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.insertvalue %9, %12[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %14 = llvm.mlir.addressof @t1 : !llvm.ptr
    %15 = llvm.mlir.constant(2848 : i64) : i64
    %16 = llvm.mlir.constant(1824 : i64) : i64
    %17 = llvm.call @__memcpy_chk(%8, %14, %15, %16) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %17 : !llvm.ptr
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
def test_no_simplify2_combined := [llvmfunc|
  llvm.func @test_no_simplify2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %10 = llvm.insertvalue %3, %9[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %11 = llvm.insertvalue %3, %10[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %1, %11[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.mlir.addressof @t2 : !llvm.ptr
    %14 = llvm.mlir.constant(1024 : i64) : i64
    %15 = llvm.mlir.constant(0 : i64) : i64
    %16 = llvm.call @__memcpy_chk(%8, %13, %14, %15) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %16 : !llvm.ptr
  }]

theorem inst_combine_test_no_simplify2   : test_no_simplify2_before  ⊑  test_no_simplify2_combined := by
  unfold test_no_simplify2_before test_no_simplify2_combined
  simp_alive_peephole
  sorry
def test_no_simplify3_combined := [llvmfunc|
  llvm.func @test_no_simplify3(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1824 : i64) : i64
    %1 = llvm.call @__memcpy_chk(%arg0, %arg1, %0, %0) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test_no_simplify3   : test_no_simplify3_before  ⊑  test_no_simplify3_combined := by
  unfold test_no_simplify3_before test_no_simplify3_combined
  simp_alive_peephole
  sorry
def test_simplify_return_indcall_combined := [llvmfunc|
  llvm.func @test_simplify_return_indcall(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t2 : !llvm.ptr
    %9 = llvm.mlir.constant(1824 : i64) : i64
    %10 = llvm.call %arg0() : !llvm.ptr, () -> !llvm.ptr
    "llvm.intr.memcpy"(%10, %8, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %10 : !llvm.ptr
  }]

theorem inst_combine_test_simplify_return_indcall   : test_simplify_return_indcall_before  ⊑  test_simplify_return_indcall_combined := by
  unfold test_simplify_return_indcall_before test_simplify_return_indcall_combined
  simp_alive_peephole
  sorry
def test_no_incompatible_attr_combined := [llvmfunc|
  llvm.func @test_no_incompatible_attr(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : tensor<100xi32>) : !llvm.array<100 x i32>
    %4 = llvm.mlir.undef : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %7 = llvm.insertvalue %1, %6[2] : !llvm.struct<"struct.T1", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %8 = llvm.mlir.addressof @t1 : !llvm.ptr
    %9 = llvm.mlir.undef : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)>
    %10 = llvm.insertvalue %3, %9[0] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %11 = llvm.insertvalue %3, %10[1] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %12 = llvm.insertvalue %1, %11[2] : !llvm.struct<"struct.T2", (array<100 x i32>, array<100 x i32>, array<1024 x i8>)> 
    %13 = llvm.mlir.addressof @t2 : !llvm.ptr
    %14 = llvm.mlir.constant(1824 : i64) : i64
    "llvm.intr.memcpy"(%8, %13, %14) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %8 : !llvm.ptr
  }]

theorem inst_combine_test_no_incompatible_attr   : test_no_incompatible_attr_before  ⊑  test_no_incompatible_attr_combined := by
  unfold test_no_incompatible_attr_before test_no_incompatible_attr_combined
  simp_alive_peephole
  sorry
