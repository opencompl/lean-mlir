import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2003-07-21-ExternalConstant
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def function_before := [llvmfunc|
  llvm.func @function(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @silly : !llvm.ptr
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %4 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %5 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %6 = llvm.add %4, %5  : i32
    llvm.store %6, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %7 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %7 : i32
  }]

def function_combined := [llvmfunc|
  llvm.func @function(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @silly : !llvm.ptr
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_function   : function_before  ⊑  function_combined := by
  unfold function_before function_combined
  simp_alive_peephole
  sorry
    %3 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_function   : function_before  ⊑  function_combined := by
  unfold function_before function_combined
  simp_alive_peephole
  sorry
    %4 = llvm.add %3, %arg0  : i32
    llvm.store %4, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_function   : function_before  ⊑  function_combined := by
  unfold function_before function_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_function   : function_before  ⊑  function_combined := by
  unfold function_before function_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i32
  }]

theorem inst_combine_function   : function_before  ⊑  function_combined := by
  unfold function_before function_combined
  simp_alive_peephole
  sorry
