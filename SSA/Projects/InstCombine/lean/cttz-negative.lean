import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cttz-negative
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def cttz_neg_value_before := [llvmfunc|
  llvm.func @cttz_neg_value(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def cttz_neg_value_multiuse_before := [llvmfunc|
  llvm.func @cttz_neg_value_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def cttz_neg_value_64_before := [llvmfunc|
  llvm.func @cttz_neg_value_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %0, %arg0  : i64
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = true}> : (i64) -> i64]

    llvm.return %2 : i64
  }]

def cttz_neg_value2_64_before := [llvmfunc|
  llvm.func @cttz_neg_value2_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %0, %arg0  : i64
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i64) -> i64]

    llvm.return %2 : i64
  }]

def cttz_neg_value_vec_before := [llvmfunc|
  llvm.func @cttz_neg_value_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sub %1, %arg0  : vector<2xi64>
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %3 : vector<2xi64>
  }]

def cttz_nonneg_value_before := [llvmfunc|
  llvm.func @cttz_nonneg_value(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def cttz_nonneg_value_vec_before := [llvmfunc|
  llvm.func @cttz_nonneg_value_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.sub %0, %arg0  : vector<2xi64>
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %2 : vector<2xi64>
  }]

def cttz_neg_value_combined := [llvmfunc|
  llvm.func @cttz_neg_value(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_cttz_neg_value   : cttz_neg_value_before  ⊑  cttz_neg_value_combined := by
  unfold cttz_neg_value_before cttz_neg_value_combined
  simp_alive_peephole
  sorry
def cttz_neg_value_multiuse_combined := [llvmfunc|
  llvm.func @cttz_neg_value_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_cttz_neg_value_multiuse   : cttz_neg_value_multiuse_before  ⊑  cttz_neg_value_multiuse_combined := by
  unfold cttz_neg_value_multiuse_before cttz_neg_value_multiuse_combined
  simp_alive_peephole
  sorry
def cttz_neg_value_64_combined := [llvmfunc|
  llvm.func @cttz_neg_value_64(%arg0: i64) -> i64 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_cttz_neg_value_64   : cttz_neg_value_64_before  ⊑  cttz_neg_value_64_combined := by
  unfold cttz_neg_value_64_before cttz_neg_value_64_combined
  simp_alive_peephole
  sorry
def cttz_neg_value2_64_combined := [llvmfunc|
  llvm.func @cttz_neg_value2_64(%arg0: i64) -> i64 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_cttz_neg_value2_64   : cttz_neg_value2_64_before  ⊑  cttz_neg_value2_64_combined := by
  unfold cttz_neg_value2_64_before cttz_neg_value2_64_combined
  simp_alive_peephole
  sorry
def cttz_neg_value_vec_combined := [llvmfunc|
  llvm.func @cttz_neg_value_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_cttz_neg_value_vec   : cttz_neg_value_vec_before  ⊑  cttz_neg_value_vec_combined := by
  unfold cttz_neg_value_vec_before cttz_neg_value_vec_combined
  simp_alive_peephole
  sorry
def cttz_nonneg_value_combined := [llvmfunc|
  llvm.func @cttz_nonneg_value(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_cttz_nonneg_value   : cttz_nonneg_value_before  ⊑  cttz_nonneg_value_combined := by
  unfold cttz_nonneg_value_before cttz_nonneg_value_combined
  simp_alive_peephole
  sorry
def cttz_nonneg_value_vec_combined := [llvmfunc|
  llvm.func @cttz_nonneg_value_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.sub %0, %arg0  : vector<2xi64>
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_cttz_nonneg_value_vec   : cttz_nonneg_value_vec_before  ⊑  cttz_nonneg_value_vec_combined := by
  unfold cttz_nonneg_value_vec_before cttz_nonneg_value_vec_combined
  simp_alive_peephole
  sorry
