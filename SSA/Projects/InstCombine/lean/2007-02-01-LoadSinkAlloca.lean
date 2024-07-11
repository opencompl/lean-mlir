import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-02-01-LoadSinkAlloca
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.call @bar(%3) vararg(!llvm.func<i32 (...)>) : (!llvm.ptr) -> i32
    %6 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %7 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.cond_br %7, ^bb2(%6 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.store %2, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

    %8 = llvm.call @test2(%2) : (i32) -> i32
    %9 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.br ^bb2(%9 : i32)
  ^bb2(%10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %12 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %13 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %14 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %15 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %16 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %17 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %18 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %19 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %20 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %21 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %22 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %23 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %24 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    llvm.return %10 : i32
  }]

def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.call @bar(%3) vararg(!llvm.func<i32 (...)>) : (!llvm.ptr) -> i32
    %5 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %6 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.cond_br %6, ^bb2(%5 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %7 = llvm.call @test2(%2) : (i32) -> i32
    llvm.br ^bb2(%2 : i32)
  ^bb2(%8: i32):  // 2 preds: ^bb0, ^bb1
    %9 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %10 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %11 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %12 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %13 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %14 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %15 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %16 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %17 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %18 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %19 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %20 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %21 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    %22 = llvm.call @baq() vararg(!llvm.func<i32 (...)>) : () -> i32
    llvm.return %8 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
