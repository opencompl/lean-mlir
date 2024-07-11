import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  debuginfo-sink
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.intr.dbg.value #di_local_variable = %1 : !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def bar_before := [llvmfunc|
  llvm.func @bar(%arg0: !llvm.ptr, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    llvm.intr.dbg.value #di_local_variable1 = %1 : !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %1 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>]

    %3 = llvm.extractelement %2[%0 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %3 : i32
  }]

def baz_before := [llvmfunc|
  llvm.func @baz(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.intr.dbg.value #di_local_variable2 #llvm.di_expression<[DW_OP_plus_uconst(5)]> = %1 : !llvm.ptr
    llvm.intr.dbg.value #di_local_variable2 = %1 : !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr) -> i32 {
    llvm.intr.dbg.value #di_local_variable #llvm.di_expression<[DW_OP_plus_uconst(4), DW_OP_stack_value]> = %arg0 : !llvm.ptr
    %0 = llvm.mlir.constant(1 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.intr.dbg.value #di_local_variable = %1 : !llvm.ptr
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def bar_combined := [llvmfunc|
  llvm.func @bar(%arg0: !llvm.ptr, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.poison : !llvm.ptr
    llvm.intr.dbg.value #di_local_variable1 = %1 : !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.sext %arg1 : i32 to i64
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    llvm.intr.dbg.value #di_local_variable1 = %3 : !llvm.ptr
    %4 = llvm.load %3 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>
    %5 = llvm.extractelement %4[%0 : i64] : !llvm.vec<? x 4 x  i32>
    llvm.return %5 : i32
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
def baz_combined := [llvmfunc|
  llvm.func @baz(%arg0: !llvm.ptr) -> i32 {
    llvm.intr.dbg.value #di_local_variable2 #llvm.di_expression<[DW_OP_plus_uconst(4), DW_OP_plus_uconst(5), DW_OP_stack_value]> = %arg0 : !llvm.ptr
    llvm.intr.dbg.value #di_local_variable2 #llvm.di_expression<[DW_OP_plus_uconst(4), DW_OP_stack_value]> = %arg0 : !llvm.ptr
    %0 = llvm.mlir.constant(1 : i64) : i64
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.intr.dbg.value #di_local_variable2 #llvm.di_expression<[DW_OP_plus_uconst(5)]> = %1 : !llvm.ptr
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_baz   : baz_before  ⊑  baz_combined := by
  unfold baz_before baz_combined
  simp_alive_peephole
  sorry
