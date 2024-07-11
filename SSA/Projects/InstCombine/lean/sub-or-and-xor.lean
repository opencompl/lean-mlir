import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sub-or-and-xor
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sub_to_xor_before := [llvmfunc|
  llvm.func @sub_to_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

def sub_to_xor_extra_use_sub_before := [llvmfunc|
  llvm.func @sub_to_xor_extra_use_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.sub %0, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %2 : i32
  }]

def sub_to_xor_extra_use_and_before := [llvmfunc|
  llvm.func @sub_to_xor_extra_use_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

def sub_to_xor_extra_use_or_before := [llvmfunc|
  llvm.func @sub_to_xor_extra_use_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

def sub_to_xor_or_commuted_before := [llvmfunc|
  llvm.func @sub_to_xor_or_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg1, %arg0  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

def sub_to_xor_and_commuted_before := [llvmfunc|
  llvm.func @sub_to_xor_and_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

def sub_to_xor_vec_before := [llvmfunc|
  llvm.func @sub_to_xor_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi32>
    %1 = llvm.and %arg1, %arg0  : vector<2xi32>
    %2 = llvm.sub %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def sub_to_xor_wrong_arg_before := [llvmfunc|
  llvm.func @sub_to_xor_wrong_arg(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.sub %1, %0  : i32
    llvm.return %2 : i32
  }]

def sub_to_xor_combined := [llvmfunc|
  llvm.func @sub_to_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_sub_to_xor   : sub_to_xor_before  ⊑  sub_to_xor_combined := by
  unfold sub_to_xor_before sub_to_xor_combined
  simp_alive_peephole
  sorry
def sub_to_xor_extra_use_sub_combined := [llvmfunc|
  llvm.func @sub_to_xor_extra_use_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.call @use(%0) : (i32) -> ()
    llvm.return %0 : i32
  }]

theorem inst_combine_sub_to_xor_extra_use_sub   : sub_to_xor_extra_use_sub_before  ⊑  sub_to_xor_extra_use_sub_combined := by
  unfold sub_to_xor_extra_use_sub_before sub_to_xor_extra_use_sub_combined
  simp_alive_peephole
  sorry
def sub_to_xor_extra_use_and_combined := [llvmfunc|
  llvm.func @sub_to_xor_extra_use_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.xor %arg0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sub_to_xor_extra_use_and   : sub_to_xor_extra_use_and_before  ⊑  sub_to_xor_extra_use_and_combined := by
  unfold sub_to_xor_extra_use_and_before sub_to_xor_extra_use_and_combined
  simp_alive_peephole
  sorry
def sub_to_xor_extra_use_or_combined := [llvmfunc|
  llvm.func @sub_to_xor_extra_use_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.xor %arg0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sub_to_xor_extra_use_or   : sub_to_xor_extra_use_or_before  ⊑  sub_to_xor_extra_use_or_combined := by
  unfold sub_to_xor_extra_use_or_before sub_to_xor_extra_use_or_combined
  simp_alive_peephole
  sorry
def sub_to_xor_or_commuted_combined := [llvmfunc|
  llvm.func @sub_to_xor_or_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_sub_to_xor_or_commuted   : sub_to_xor_or_commuted_before  ⊑  sub_to_xor_or_commuted_combined := by
  unfold sub_to_xor_or_commuted_before sub_to_xor_or_commuted_combined
  simp_alive_peephole
  sorry
def sub_to_xor_and_commuted_combined := [llvmfunc|
  llvm.func @sub_to_xor_and_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg1, %arg0  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_sub_to_xor_and_commuted   : sub_to_xor_and_commuted_before  ⊑  sub_to_xor_and_commuted_combined := by
  unfold sub_to_xor_and_commuted_before sub_to_xor_and_commuted_combined
  simp_alive_peephole
  sorry
def sub_to_xor_vec_combined := [llvmfunc|
  llvm.func @sub_to_xor_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.xor %arg1, %arg0  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_sub_to_xor_vec   : sub_to_xor_vec_before  ⊑  sub_to_xor_vec_combined := by
  unfold sub_to_xor_vec_before sub_to_xor_vec_combined
  simp_alive_peephole
  sorry
def sub_to_xor_wrong_arg_combined := [llvmfunc|
  llvm.func @sub_to_xor_wrong_arg(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg2  : i32
    %2 = llvm.sub %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sub_to_xor_wrong_arg   : sub_to_xor_wrong_arg_before  ⊑  sub_to_xor_wrong_arg_combined := by
  unfold sub_to_xor_wrong_arg_before sub_to_xor_wrong_arg_combined
  simp_alive_peephole
  sorry
