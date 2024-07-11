import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-01-08-AlignAlloca
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bar_before := [llvmfunc|
  llvm.func @bar(%arg0: i64) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x !llvm.struct<"struct.Key", (struct<(i32, i32)>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.bitcast %1 : i32 to i32
    %5 = llvm.getelementptr %2[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.Key", (struct<(i32, i32)>)>
    %6 = llvm.getelementptr %5[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    llvm.store %1, %6 {alignment = 4 : i64} : i32, !llvm.ptr]

    %7 = llvm.getelementptr %5[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    llvm.store %1, %7 {alignment = 4 : i64} : i32, !llvm.ptr]

    %8 = llvm.getelementptr %2[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.Key", (struct<(i32, i32)>)>
    llvm.store %arg0, %8 {alignment = 4 : i64} : i64, !llvm.ptr]

    %9 = llvm.call @foo(%2, %3) vararg(!llvm.func<i32 (...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    %10 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %10 : i32
  }]

def bar_combined := [llvmfunc|
  llvm.func @bar(%arg0: i64) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x !llvm.struct<"struct.Key", (struct<(i32, i32)>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.getelementptr inbounds %2[%1, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32, i32)>
    llvm.store %1, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %arg0, %2 {alignment = 4 : i64} : i64, !llvm.ptr
    %5 = llvm.call @foo(%2, %3) vararg(!llvm.func<i32 (...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    %6 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %6 : i32
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
