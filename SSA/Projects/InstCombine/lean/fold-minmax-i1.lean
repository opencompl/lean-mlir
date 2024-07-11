import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-minmax-i1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def umin_scalar_before := [llvmfunc|
  llvm.func @umin_scalar(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i1, i1) -> i1
    llvm.return %0 : i1
  }]

def smin_scalar_before := [llvmfunc|
  llvm.func @smin_scalar(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i1, i1) -> i1
    llvm.return %0 : i1
  }]

def umax_scalar_before := [llvmfunc|
  llvm.func @umax_scalar(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i1, i1) -> i1
    llvm.return %0 : i1
  }]

def smax_scalar_before := [llvmfunc|
  llvm.func @smax_scalar(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i1, i1) -> i1
    llvm.return %0 : i1
  }]

def umin_vector_before := [llvmfunc|
  llvm.func @umin_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    llvm.return %0 : vector<4xi1>
  }]

def smin_vector_before := [llvmfunc|
  llvm.func @smin_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    llvm.return %0 : vector<4xi1>
  }]

def umax_vector_before := [llvmfunc|
  llvm.func @umax_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    llvm.return %0 : vector<4xi1>
  }]

def smax_vector_before := [llvmfunc|
  llvm.func @smax_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    llvm.return %0 : vector<4xi1>
  }]

def umin_scalar_combined := [llvmfunc|
  llvm.func @umin_scalar(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_umin_scalar   : umin_scalar_before  ⊑  umin_scalar_combined := by
  unfold umin_scalar_before umin_scalar_combined
  simp_alive_peephole
  sorry
def smin_scalar_combined := [llvmfunc|
  llvm.func @smin_scalar(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_smin_scalar   : smin_scalar_before  ⊑  smin_scalar_combined := by
  unfold smin_scalar_before smin_scalar_combined
  simp_alive_peephole
  sorry
def umax_scalar_combined := [llvmfunc|
  llvm.func @umax_scalar(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_umax_scalar   : umax_scalar_before  ⊑  umax_scalar_combined := by
  unfold umax_scalar_before umax_scalar_combined
  simp_alive_peephole
  sorry
def smax_scalar_combined := [llvmfunc|
  llvm.func @smax_scalar(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_smax_scalar   : smax_scalar_before  ⊑  smax_scalar_combined := by
  unfold smax_scalar_before smax_scalar_combined
  simp_alive_peephole
  sorry
def umin_vector_combined := [llvmfunc|
  llvm.func @umin_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.and %arg0, %arg1  : vector<4xi1>
    llvm.return %0 : vector<4xi1>
  }]

theorem inst_combine_umin_vector   : umin_vector_before  ⊑  umin_vector_combined := by
  unfold umin_vector_before umin_vector_combined
  simp_alive_peephole
  sorry
def smin_vector_combined := [llvmfunc|
  llvm.func @smin_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.or %arg0, %arg1  : vector<4xi1>
    llvm.return %0 : vector<4xi1>
  }]

theorem inst_combine_smin_vector   : smin_vector_before  ⊑  smin_vector_combined := by
  unfold smin_vector_before smin_vector_combined
  simp_alive_peephole
  sorry
def umax_vector_combined := [llvmfunc|
  llvm.func @umax_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.or %arg0, %arg1  : vector<4xi1>
    llvm.return %0 : vector<4xi1>
  }]

theorem inst_combine_umax_vector   : umax_vector_before  ⊑  umax_vector_combined := by
  unfold umax_vector_before umax_vector_combined
  simp_alive_peephole
  sorry
def smax_vector_combined := [llvmfunc|
  llvm.func @smax_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.and %arg0, %arg1  : vector<4xi1>
    llvm.return %0 : vector<4xi1>
  }]

theorem inst_combine_smax_vector   : smax_vector_before  ⊑  smax_vector_combined := by
  unfold smax_vector_before smax_vector_combined
  simp_alive_peephole
  sorry
