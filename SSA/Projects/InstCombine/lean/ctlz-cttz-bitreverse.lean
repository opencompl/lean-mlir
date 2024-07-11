import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ctlz-cttz-bitreverse
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def ctlz_true_bitreverse_before := [llvmfunc|
  llvm.func @ctlz_true_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def ctlz_true_bitreverse_vec_before := [llvmfunc|
  llvm.func @ctlz_true_bitreverse_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.bitreverse(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = true}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %1 : vector<2xi64>
  }]

def ctlz_false_bitreverse_before := [llvmfunc|
  llvm.func @ctlz_false_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def cttz_true_bitreverse_before := [llvmfunc|
  llvm.func @cttz_true_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def cttz_true_bitreverse_vec_before := [llvmfunc|
  llvm.func @cttz_true_bitreverse_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.bitreverse(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (vector<2xi64>) -> vector<2xi64>]

    llvm.return %1 : vector<2xi64>
  }]

def cttz_false_bitreverse_before := [llvmfunc|
  llvm.func @cttz_false_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def ctlz_true_bitreverse_combined := [llvmfunc|
  llvm.func @ctlz_true_bitreverse(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ctlz_true_bitreverse   : ctlz_true_bitreverse_before  ⊑  ctlz_true_bitreverse_combined := by
  unfold ctlz_true_bitreverse_before ctlz_true_bitreverse_combined
  simp_alive_peephole
  sorry
def ctlz_true_bitreverse_vec_combined := [llvmfunc|
  llvm.func @ctlz_true_bitreverse_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_ctlz_true_bitreverse_vec   : ctlz_true_bitreverse_vec_before  ⊑  ctlz_true_bitreverse_vec_combined := by
  unfold ctlz_true_bitreverse_vec_before ctlz_true_bitreverse_vec_combined
  simp_alive_peephole
  sorry
def ctlz_false_bitreverse_combined := [llvmfunc|
  llvm.func @ctlz_false_bitreverse(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ctlz_false_bitreverse   : ctlz_false_bitreverse_before  ⊑  ctlz_false_bitreverse_combined := by
  unfold ctlz_false_bitreverse_before ctlz_false_bitreverse_combined
  simp_alive_peephole
  sorry
def cttz_true_bitreverse_combined := [llvmfunc|
  llvm.func @cttz_true_bitreverse(%arg0: i32) -> i32 {
    %0 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_cttz_true_bitreverse   : cttz_true_bitreverse_before  ⊑  cttz_true_bitreverse_combined := by
  unfold cttz_true_bitreverse_before cttz_true_bitreverse_combined
  simp_alive_peephole
  sorry
def cttz_true_bitreverse_vec_combined := [llvmfunc|
  llvm.func @cttz_true_bitreverse_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_cttz_true_bitreverse_vec   : cttz_true_bitreverse_vec_before  ⊑  cttz_true_bitreverse_vec_combined := by
  unfold cttz_true_bitreverse_vec_before cttz_true_bitreverse_vec_combined
  simp_alive_peephole
  sorry
def cttz_false_bitreverse_combined := [llvmfunc|
  llvm.func @cttz_false_bitreverse(%arg0: i32) -> i32 {
    %0 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_cttz_false_bitreverse   : cttz_false_bitreverse_before  ⊑  cttz_false_bitreverse_combined := by
  unfold cttz_false_bitreverse_before cttz_false_bitreverse_combined
  simp_alive_peephole
  sorry
