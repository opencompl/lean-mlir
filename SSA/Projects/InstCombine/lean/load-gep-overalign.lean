import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  load-gep-overalign
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_vector_load_i8_before := [llvmfunc|
  llvm.func @test_vector_load_i8() {
    %0 = llvm.mlir.constant(dense<[8961, 26437, -21623, -4147]> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mlir.addressof @foo : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.constant(6 : i64) : i64
    %9 = llvm.mlir.constant(7 : i64) : i64
    %10 = llvm.getelementptr %1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %11 = llvm.load %10 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.call @report(%2, %11) : (i64, i8) -> ()
    %12 = llvm.getelementptr %1[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %13 = llvm.load %12 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.call @report(%3, %13) : (i64, i8) -> ()
    %14 = llvm.getelementptr %1[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %15 = llvm.load %14 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.call @report(%4, %15) : (i64, i8) -> ()
    %16 = llvm.getelementptr %1[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %17 = llvm.load %16 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.call @report(%5, %17) : (i64, i8) -> ()
    %18 = llvm.getelementptr %1[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %19 = llvm.load %18 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.call @report(%6, %19) : (i64, i8) -> ()
    %20 = llvm.getelementptr %1[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %21 = llvm.load %20 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.call @report(%7, %21) : (i64, i8) -> ()
    %22 = llvm.getelementptr %1[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %23 = llvm.load %22 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.call @report(%8, %23) : (i64, i8) -> ()
    %24 = llvm.getelementptr %1[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %25 = llvm.load %24 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.call @report(%9, %25) : (i64, i8) -> ()
    llvm.return
  }]

def test_vector_load_i8_combined := [llvmfunc|
  llvm.func @test_vector_load_i8() {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(35 : i8) : i8
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(69 : i8) : i8
    %6 = llvm.mlir.constant(3 : i64) : i64
    %7 = llvm.mlir.constant(103 : i8) : i8
    %8 = llvm.mlir.constant(4 : i64) : i64
    %9 = llvm.mlir.constant(-119 : i8) : i8
    %10 = llvm.mlir.constant(5 : i64) : i64
    %11 = llvm.mlir.constant(-85 : i8) : i8
    %12 = llvm.mlir.constant(6 : i64) : i64
    %13 = llvm.mlir.constant(-51 : i8) : i8
    %14 = llvm.mlir.constant(7 : i64) : i64
    %15 = llvm.mlir.constant(-17 : i8) : i8
    llvm.call @report(%0, %1) : (i64, i8) -> ()
    llvm.call @report(%2, %3) : (i64, i8) -> ()
    llvm.call @report(%4, %5) : (i64, i8) -> ()
    llvm.call @report(%6, %7) : (i64, i8) -> ()
    llvm.call @report(%8, %9) : (i64, i8) -> ()
    llvm.call @report(%10, %11) : (i64, i8) -> ()
    llvm.call @report(%12, %13) : (i64, i8) -> ()
    llvm.call @report(%14, %15) : (i64, i8) -> ()
    llvm.return
  }]

theorem inst_combine_test_vector_load_i8   : test_vector_load_i8_before  ⊑  test_vector_load_i8_combined := by
  unfold test_vector_load_i8_before test_vector_load_i8_combined
  simp_alive_peephole
  sorry
