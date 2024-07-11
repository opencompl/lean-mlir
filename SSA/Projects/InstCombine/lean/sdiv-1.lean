import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sdiv-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def a_before := [llvmfunc|
  llvm.func @a(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.sdiv %2, %1  : i32
    llvm.return %3 : i32
  }]

def b_before := [llvmfunc|
  llvm.func @b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.call @a(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def c_before := [llvmfunc|
  llvm.func @c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.sub %0, %1  : i32
    %4 = llvm.sdiv %3, %2  : i32
    llvm.return %4 : i32
  }]

def a_combined := [llvmfunc|
  llvm.func @a(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.sdiv %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_a   : a_before  ⊑  a_combined := by
  unfold a_before a_combined
  simp_alive_peephole
  sorry
def b_combined := [llvmfunc|
  llvm.func @b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(715827882 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_b   : b_before  ⊑  b_combined := by
  unfold b_before b_combined
  simp_alive_peephole
  sorry
def c_combined := [llvmfunc|
  llvm.func @c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(715827882 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_c   : c_before  ⊑  c_combined := by
  unfold c_before c_combined
  simp_alive_peephole
  sorry
