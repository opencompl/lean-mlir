import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  lower-dbg-declare
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.dbg.declare #di_local_variable = %5 : !llvm.ptr
    llvm.store %1, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.intr.lifetime.start 4, %5 : !llvm.ptr
    llvm.store %2, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %7 = llvm.call @_ZL5emptyi(%6) : (i32) -> i1
    %8 = llvm.xor %7, %3  : i1
    llvm.cond_br %8, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @_ZL6escapeRi(%5) : (!llvm.ptr) -> ()
    llvm.br ^bb1 {loop_annotation = #loop_annotation}]

  ^bb3:  // pred: ^bb1
    llvm.intr.lifetime.end 4, %5 : !llvm.ptr
    llvm.return %1 : i32
  }]

def main_combined := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    llvm.intr.dbg.value #di_local_variable = %1 : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.dbg.value #di_local_variable #llvm.di_expression<[DW_OP_deref]> = %3 : !llvm.ptr
    llvm.intr.lifetime.start 4, %3 : !llvm.ptr
    llvm.store %1, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.intr.dbg.value #di_local_variable = %4 : i32
    %5 = llvm.call @_ZL5emptyi(%4) : (i32) -> i1
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.call @_ZL6escapeRi(%3) : (!llvm.ptr) -> ()
    llvm.br ^bb1 {loop_annotation = #loop_annotation}
  ^bb3:  // pred: ^bb1
    llvm.intr.lifetime.end 4, %3 : !llvm.ptr
    llvm.return %2 : i32
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
