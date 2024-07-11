import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sdiv-exact-by-negative-power-of-two
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.sdiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def n1_before := [llvmfunc|
  llvm.func @n1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.sdiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def t2_vec_splat_before := [llvmfunc|
  llvm.func @t2_vec_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-32> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def t3_vec_before := [llvmfunc|
  llvm.func @t3_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-32, -16]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def n4_vec_mixed_before := [llvmfunc|
  llvm.func @n4_vec_mixed(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-32, 16]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def n4_vec_undef_before := [llvmfunc|
  llvm.func @n4_vec_undef(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.sdiv %arg0, %6  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

def prove_exact_with_high_mask_before := [llvmfunc|
  llvm.func @prove_exact_with_high_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sdiv %2, %1  : i8
    llvm.return %3 : i8
  }]

def prove_exact_with_high_mask_limit_before := [llvmfunc|
  llvm.func @prove_exact_with_high_mask_limit(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.sdiv %1, %0  : i8
    llvm.return %2 : i8
  }]

def not_prove_exact_with_high_mask_before := [llvmfunc|
  llvm.func @not_prove_exact_with_high_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sdiv %2, %1  : i8
    llvm.return %3 : i8
  }]

def prove_exact_with_high_mask_splat_vec_before := [llvmfunc|
  llvm.func @prove_exact_with_high_mask_splat_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.sdiv %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def prove_exact_with_high_mask_vec_before := [llvmfunc|
  llvm.func @prove_exact_with_high_mask_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-8, -4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.sdiv %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sub %1, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def n1_combined := [llvmfunc|
  llvm.func @n1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.sdiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_n1   : n1_before  ⊑  n1_combined := by
  unfold n1_before n1_combined
  simp_alive_peephole
  sorry
def t2_vec_splat_combined := [llvmfunc|
  llvm.func @t2_vec_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.ashr %arg0, %0  : vector<2xi8>
    %4 = llvm.sub %2, %3 overflow<nsw>  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_t2_vec_splat   : t2_vec_splat_before  ⊑  t2_vec_splat_combined := by
  unfold t2_vec_splat_before t2_vec_splat_combined
  simp_alive_peephole
  sorry
def t3_vec_combined := [llvmfunc|
  llvm.func @t3_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[5, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.ashr %arg0, %0  : vector<2xi8>
    %4 = llvm.sub %2, %3 overflow<nsw>  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_t3_vec   : t3_vec_before  ⊑  t3_vec_combined := by
  unfold t3_vec_before t3_vec_combined
  simp_alive_peephole
  sorry
def n4_vec_mixed_combined := [llvmfunc|
  llvm.func @n4_vec_mixed(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-32, 16]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_n4_vec_mixed   : n4_vec_mixed_before  ⊑  n4_vec_mixed_combined := by
  unfold n4_vec_mixed_before n4_vec_mixed_combined
  simp_alive_peephole
  sorry
def n4_vec_undef_combined := [llvmfunc|
  llvm.func @n4_vec_undef(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_n4_vec_undef   : n4_vec_undef_before  ⊑  n4_vec_undef_combined := by
  unfold n4_vec_undef_before n4_vec_undef_combined
  simp_alive_peephole
  sorry
def prove_exact_with_high_mask_combined := [llvmfunc|
  llvm.func @prove_exact_with_high_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.ashr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.sub %2, %4 overflow<nsw>  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_prove_exact_with_high_mask   : prove_exact_with_high_mask_before  ⊑  prove_exact_with_high_mask_combined := by
  unfold prove_exact_with_high_mask_before prove_exact_with_high_mask_combined
  simp_alive_peephole
  sorry
def prove_exact_with_high_mask_limit_combined := [llvmfunc|
  llvm.func @prove_exact_with_high_mask_limit(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sub %1, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_prove_exact_with_high_mask_limit   : prove_exact_with_high_mask_limit_before  ⊑  prove_exact_with_high_mask_limit_combined := by
  unfold prove_exact_with_high_mask_limit_before prove_exact_with_high_mask_limit_combined
  simp_alive_peephole
  sorry
def not_prove_exact_with_high_mask_combined := [llvmfunc|
  llvm.func @not_prove_exact_with_high_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sdiv %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_prove_exact_with_high_mask   : not_prove_exact_with_high_mask_before  ⊑  not_prove_exact_with_high_mask_combined := by
  unfold not_prove_exact_with_high_mask_before not_prove_exact_with_high_mask_combined
  simp_alive_peephole
  sorry
def prove_exact_with_high_mask_splat_vec_combined := [llvmfunc|
  llvm.func @prove_exact_with_high_mask_splat_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.shl %arg0, %0  : vector<2xi8>
    %5 = llvm.ashr %4, %1  : vector<2xi8>
    %6 = llvm.sub %3, %5 overflow<nsw>  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_prove_exact_with_high_mask_splat_vec   : prove_exact_with_high_mask_splat_vec_before  ⊑  prove_exact_with_high_mask_splat_vec_combined := by
  unfold prove_exact_with_high_mask_splat_vec_before prove_exact_with_high_mask_splat_vec_combined
  simp_alive_peephole
  sorry
def prove_exact_with_high_mask_vec_combined := [llvmfunc|
  llvm.func @prove_exact_with_high_mask_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-8, -4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.sdiv %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_prove_exact_with_high_mask_vec   : prove_exact_with_high_mask_vec_before  ⊑  prove_exact_with_high_mask_vec_combined := by
  unfold prove_exact_with_high_mask_vec_before prove_exact_with_high_mask_vec_combined
  simp_alive_peephole
  sorry
