import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  add-mask
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def add_mask_sign_i32_before := [llvmfunc|
  llvm.func @add_mask_sign_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }]

def add_mask_sign_commute_i32_before := [llvmfunc|
  llvm.func @add_mask_sign_commute_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

def add_mask_sign_v2i32_before := [llvmfunc|
  llvm.func @add_mask_sign_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def add_mask_sign_v2i32_nonuniform_before := [llvmfunc|
  llvm.func @add_mask_sign_v2i32_nonuniform(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[30, 31]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[8, 16]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def add_mask_ashr28_i32_before := [llvmfunc|
  llvm.func @add_mask_ashr28_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }]

def add_mask_ashr28_non_pow2_i32_before := [llvmfunc|
  llvm.func @add_mask_ashr28_non_pow2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }]

def add_mask_ashr27_i32_before := [llvmfunc|
  llvm.func @add_mask_ashr27_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(27 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }]

def add_mask_sign_i32_combined := [llvmfunc|
  llvm.func @add_mask_sign_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_mask_sign_i32   : add_mask_sign_i32_before  ⊑  add_mask_sign_i32_combined := by
  unfold add_mask_sign_i32_before add_mask_sign_i32_combined
  simp_alive_peephole
  sorry
def add_mask_sign_commute_i32_combined := [llvmfunc|
  llvm.func @add_mask_sign_commute_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_mask_sign_commute_i32   : add_mask_sign_commute_i32_before  ⊑  add_mask_sign_commute_i32_combined := by
  unfold add_mask_sign_commute_i32_before add_mask_sign_commute_i32_combined
  simp_alive_peephole
  sorry
def add_mask_sign_v2i32_combined := [llvmfunc|
  llvm.func @add_mask_sign_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_add_mask_sign_v2i32   : add_mask_sign_v2i32_before  ⊑  add_mask_sign_v2i32_combined := by
  unfold add_mask_sign_v2i32_before add_mask_sign_v2i32_combined
  simp_alive_peephole
  sorry
def add_mask_sign_v2i32_nonuniform_combined := [llvmfunc|
  llvm.func @add_mask_sign_v2i32_nonuniform(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[30, 31]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[8, 16]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.add %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_add_mask_sign_v2i32_nonuniform   : add_mask_sign_v2i32_nonuniform_before  ⊑  add_mask_sign_v2i32_nonuniform_combined := by
  unfold add_mask_sign_v2i32_nonuniform_before add_mask_sign_v2i32_nonuniform_combined
  simp_alive_peephole
  sorry
def add_mask_ashr28_i32_combined := [llvmfunc|
  llvm.func @add_mask_ashr28_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_add_mask_ashr28_i32   : add_mask_ashr28_i32_before  ⊑  add_mask_ashr28_i32_combined := by
  unfold add_mask_ashr28_i32_before add_mask_ashr28_i32_combined
  simp_alive_peephole
  sorry
def add_mask_ashr28_non_pow2_i32_combined := [llvmfunc|
  llvm.func @add_mask_ashr28_non_pow2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %2 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_add_mask_ashr28_non_pow2_i32   : add_mask_ashr28_non_pow2_i32_before  ⊑  add_mask_ashr28_non_pow2_i32_combined := by
  unfold add_mask_ashr28_non_pow2_i32_before add_mask_ashr28_non_pow2_i32_combined
  simp_alive_peephole
  sorry
def add_mask_ashr27_i32_combined := [llvmfunc|
  llvm.func @add_mask_ashr27_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(27 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %2 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_add_mask_ashr27_i32   : add_mask_ashr27_i32_before  ⊑  add_mask_ashr27_i32_combined := by
  unfold add_mask_ashr27_i32_before add_mask_ashr27_i32_combined
  simp_alive_peephole
  sorry
