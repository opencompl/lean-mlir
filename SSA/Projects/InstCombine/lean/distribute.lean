import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  distribute
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def factorize_before := [llvmfunc|
  llvm.func @factorize(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.or %arg0, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def factorize2_before := [llvmfunc|
  llvm.func @factorize2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %0, %arg0  : i32
    %3 = llvm.mul %1, %arg0  : i32
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }]

def factorize3_before := [llvmfunc|
  llvm.func @factorize3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.or %arg0, %arg2  : i32
    %3 = llvm.and %1, %2  : i32
    llvm.return %3 : i32
  }]

def factorize4_before := [llvmfunc|
  llvm.func @factorize4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg1, %0  : i32
    %2 = llvm.mul %1, %arg0  : i32
    %3 = llvm.mul %arg0, %arg1  : i32
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }]

def factorize5_before := [llvmfunc|
  llvm.func @factorize5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mul %arg1, %0  : i32
    %2 = llvm.mul %1, %arg0  : i32
    %3 = llvm.mul %arg0, %arg1  : i32
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }]

def expand_before := [llvmfunc|
  llvm.func @expand(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }]

def factorize_combined := [llvmfunc|
  llvm.func @factorize(%arg0: i32, %arg1: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_factorize   : factorize_before  ⊑  factorize_combined := by
  unfold factorize_before factorize_combined
  simp_alive_peephole
  sorry
def factorize2_combined := [llvmfunc|
  llvm.func @factorize2(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_factorize2   : factorize2_before  ⊑  factorize2_combined := by
  unfold factorize2_before factorize2_combined
  simp_alive_peephole
  sorry
def factorize3_combined := [llvmfunc|
  llvm.func @factorize3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg2, %arg0  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_factorize3   : factorize3_before  ⊑  factorize3_combined := by
  unfold factorize3_before factorize3_combined
  simp_alive_peephole
  sorry
def factorize4_combined := [llvmfunc|
  llvm.func @factorize4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg0  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_factorize4   : factorize4_before  ⊑  factorize4_combined := by
  unfold factorize4_before factorize4_combined
  simp_alive_peephole
  sorry
def factorize5_combined := [llvmfunc|
  llvm.func @factorize5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mul %arg1, %arg0  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_factorize5   : factorize5_before  ⊑  factorize5_combined := by
  unfold factorize5_before factorize5_combined
  simp_alive_peephole
  sorry
def expand_combined := [llvmfunc|
  llvm.func @expand(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_expand   : expand_before  ⊑  expand_combined := by
  unfold expand_before expand_combined
  simp_alive_peephole
  sorry
