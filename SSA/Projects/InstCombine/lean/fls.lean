import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fls
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def myfls_before := [llvmfunc|
  llvm.func @myfls() -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.call @fls(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def myflsl_before := [llvmfunc|
  llvm.func @myflsl() -> i32 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.call @flsl(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

def myflsll_before := [llvmfunc|
  llvm.func @myflsll() -> i32 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.call @flsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

def flsnotconst_before := [llvmfunc|
  llvm.func @flsnotconst(%arg0: i64) -> i32 {
    %0 = llvm.call @flsl(%arg0) : (i64) -> i32
    llvm.return %0 : i32
  }]

def flszero_before := [llvmfunc|
  llvm.func @flszero() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @fls(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def myfls_combined := [llvmfunc|
  llvm.func @myfls() -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_myfls   : myfls_before  ⊑  myfls_combined := by
  unfold myfls_before myfls_combined
  simp_alive_peephole
  sorry
def myflsl_combined := [llvmfunc|
  llvm.func @myflsl() -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_myflsl   : myflsl_before  ⊑  myflsl_combined := by
  unfold myflsl_before myflsl_combined
  simp_alive_peephole
  sorry
def myflsll_combined := [llvmfunc|
  llvm.func @myflsll() -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_myflsll   : myflsll_before  ⊑  myflsll_combined := by
  unfold myflsll_before myflsll_combined
  simp_alive_peephole
  sorry
def flsnotconst_combined := [llvmfunc|
  llvm.func @flsnotconst(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.sub %0, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_flsnotconst   : flsnotconst_before  ⊑  flsnotconst_combined := by
  unfold flsnotconst_before flsnotconst_combined
  simp_alive_peephole
  sorry
def flszero_combined := [llvmfunc|
  llvm.func @flszero() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_flszero   : flszero_before  ⊑  flszero_combined := by
  unfold flszero_before flszero_combined
  simp_alive_peephole
  sorry
