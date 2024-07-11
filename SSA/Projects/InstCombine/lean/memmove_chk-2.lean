import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memmove_chk-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_no_simplify_before := [llvmfunc|
  llvm.func @test_no_simplify() {
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
    %15 = llvm.call @__memmove_chk(%8, %13, %14) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }]

def test_no_simplify_combined := [llvmfunc|
  llvm.func @test_no_simplify() {
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
    %15 = llvm.call @__memmove_chk(%8, %13, %14) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_no_simplify   : test_no_simplify_before  ⊑  test_no_simplify_combined := by
  unfold test_no_simplify_before test_no_simplify_combined
  simp_alive_peephole
  sorry
