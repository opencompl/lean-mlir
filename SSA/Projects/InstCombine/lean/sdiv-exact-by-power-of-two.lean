import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sdiv-exact-by-power-of-two
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.sdiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def n1_before := [llvmfunc|
  llvm.func @n1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.sdiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.sdiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def t3_vec_splat_before := [llvmfunc|
  llvm.func @t3_vec_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def t4_vec_before := [llvmfunc|
  llvm.func @t4_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[32, 16]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def n5_vec_undef_before := [llvmfunc|
  llvm.func @n5_vec_undef(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.sdiv %arg0, %6  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

def n6_vec_negative_before := [llvmfunc|
  llvm.func @n6_vec_negative(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[32, -128]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def shl1_nsw_before := [llvmfunc|
  llvm.func @shl1_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %2 = llvm.sdiv %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def shl1_nuw_before := [llvmfunc|
  llvm.func @shl1_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %2 = llvm.sdiv %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def shl1_nsw_not_exact_before := [llvmfunc|
  llvm.func @shl1_nsw_not_exact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %2 = llvm.sdiv %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def prove_exact_with_high_mask_before := [llvmfunc|
  llvm.func @prove_exact_with_high_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sdiv %2, %1  : i8
    llvm.return %3 : i8
  }]

def prove_exact_with_high_mask_limit_before := [llvmfunc|
  llvm.func @prove_exact_with_high_mask_limit(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sdiv %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_prove_exact_with_high_mask_before := [llvmfunc|
  llvm.func @not_prove_exact_with_high_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sdiv %2, %1  : i8
    llvm.return %3 : i8
  }]

def prove_exact_with_high_mask_splat_vec_before := [llvmfunc|
  llvm.func @prove_exact_with_high_mask_splat_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.sdiv %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def prove_exact_with_high_mask_vec_before := [llvmfunc|
  llvm.func @prove_exact_with_high_mask_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[8, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.sdiv %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def n1_combined := [llvmfunc|
  llvm.func @n1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.sdiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_n1   : n1_before  ⊑  n1_combined := by
  unfold n1_before n1_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
def t3_vec_splat_combined := [llvmfunc|
  llvm.func @t3_vec_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_t3_vec_splat   : t3_vec_splat_before  ⊑  t3_vec_splat_combined := by
  unfold t3_vec_splat_before t3_vec_splat_combined
  simp_alive_peephole
  sorry
def t4_vec_combined := [llvmfunc|
  llvm.func @t4_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[5, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_t4_vec   : t4_vec_before  ⊑  t4_vec_combined := by
  unfold t4_vec_before t4_vec_combined
  simp_alive_peephole
  sorry
def n5_vec_undef_combined := [llvmfunc|
  llvm.func @n5_vec_undef(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_n5_vec_undef   : n5_vec_undef_before  ⊑  n5_vec_undef_combined := by
  unfold n5_vec_undef_before n5_vec_undef_combined
  simp_alive_peephole
  sorry
def n6_vec_negative_combined := [llvmfunc|
  llvm.func @n6_vec_negative(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[32, -128]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_n6_vec_negative   : n6_vec_negative_before  ⊑  n6_vec_negative_combined := by
  unfold n6_vec_negative_before n6_vec_negative_combined
  simp_alive_peephole
  sorry
def shl1_nsw_combined := [llvmfunc|
  llvm.func @shl1_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.ashr %arg0, %arg1  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_shl1_nsw   : shl1_nsw_before  ⊑  shl1_nsw_combined := by
  unfold shl1_nsw_before shl1_nsw_combined
  simp_alive_peephole
  sorry
def shl1_nuw_combined := [llvmfunc|
  llvm.func @shl1_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %2 = llvm.sdiv %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_shl1_nuw   : shl1_nuw_before  ⊑  shl1_nuw_combined := by
  unfold shl1_nuw_before shl1_nuw_combined
  simp_alive_peephole
  sorry
def shl1_nsw_not_exact_combined := [llvmfunc|
  llvm.func @shl1_nsw_not_exact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw, nuw>  : i8
    %2 = llvm.sdiv %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_shl1_nsw_not_exact   : shl1_nsw_not_exact_before  ⊑  shl1_nsw_not_exact_combined := by
  unfold shl1_nsw_not_exact_before shl1_nsw_not_exact_combined
  simp_alive_peephole
  sorry
def prove_exact_with_high_mask_combined := [llvmfunc|
  llvm.func @prove_exact_with_high_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_prove_exact_with_high_mask   : prove_exact_with_high_mask_before  ⊑  prove_exact_with_high_mask_combined := by
  unfold prove_exact_with_high_mask_before prove_exact_with_high_mask_combined
  simp_alive_peephole
  sorry
def prove_exact_with_high_mask_limit_combined := [llvmfunc|
  llvm.func @prove_exact_with_high_mask_limit(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_prove_exact_with_high_mask_limit   : prove_exact_with_high_mask_limit_before  ⊑  prove_exact_with_high_mask_limit_combined := by
  unfold prove_exact_with_high_mask_limit_before prove_exact_with_high_mask_limit_combined
  simp_alive_peephole
  sorry
def not_prove_exact_with_high_mask_combined := [llvmfunc|
  llvm.func @not_prove_exact_with_high_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
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
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %0  : vector<2xi8>
    %2 = llvm.ashr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_prove_exact_with_high_mask_splat_vec   : prove_exact_with_high_mask_splat_vec_before  ⊑  prove_exact_with_high_mask_splat_vec_combined := by
  unfold prove_exact_with_high_mask_splat_vec_before prove_exact_with_high_mask_splat_vec_combined
  simp_alive_peephole
  sorry
def prove_exact_with_high_mask_vec_combined := [llvmfunc|
  llvm.func @prove_exact_with_high_mask_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[8, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.sdiv %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_prove_exact_with_high_mask_vec   : prove_exact_with_high_mask_vec_before  ⊑  prove_exact_with_high_mask_vec_combined := by
  unfold prove_exact_with_high_mask_vec_before prove_exact_with_high_mask_vec_combined
  simp_alive_peephole
  sorry
