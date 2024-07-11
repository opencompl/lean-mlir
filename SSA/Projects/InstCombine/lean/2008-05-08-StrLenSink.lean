import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-05-08-StrLenSink
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def a_before := [llvmfunc|
  llvm.func @a() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(1 : i8) : i8
    %5 = llvm.bitcast %0 : i32 to i32
    %6 = llvm.call @malloc(%1) : (i32) -> !llvm.ptr
    %7 = llvm.getelementptr %6[%2] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.store %3, %7 {alignment = 1 : i64} : i8, !llvm.ptr]

    %8 = llvm.getelementptr %6[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.store %4, %8 {alignment = 1 : i64} : i8, !llvm.ptr]

    %9 = llvm.call @strlen(%6) : (!llvm.ptr) -> i32
    %10 = llvm.getelementptr %6[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.store %3, %10 {alignment = 1 : i64} : i8, !llvm.ptr]

    %11 = llvm.call @b(%6) vararg(!llvm.func<i32 (...)>) : (!llvm.ptr) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %9 : i32
  }]

def a_combined := [llvmfunc|
  llvm.func @a() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.call @malloc(%0) : (i32) -> !llvm.ptr
    %5 = llvm.getelementptr %4[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.store %2, %5 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.store %3, %4 {alignment = 1 : i64} : i8, !llvm.ptr
    %6 = llvm.call @strlen(%4) : (!llvm.ptr) -> i32
    llvm.store %2, %4 {alignment = 1 : i64} : i8, !llvm.ptr
    %7 = llvm.call @b(%4) vararg(!llvm.func<i32 (...)>) : (!llvm.ptr) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %6 : i32
  }]

theorem inst_combine_a   : a_before  ⊑  a_combined := by
  unfold a_before a_combined
  simp_alive_peephole
  sorry
