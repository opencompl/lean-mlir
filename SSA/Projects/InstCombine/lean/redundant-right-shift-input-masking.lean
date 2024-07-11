import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  redundant-right-shift-input-masking
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_lshr_before := [llvmfunc|
  llvm.func @t0_lshr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def t1_sshr_before := [llvmfunc|
  llvm.func @t1_sshr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.ashr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def t2_vec_before := [llvmfunc|
  llvm.func @t2_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %0, %arg1  : vector<4xi32>
    %2 = llvm.and %1, %arg0  : vector<4xi32>
    %3 = llvm.lshr %2, %arg1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def t3_vec_undef_before := [llvmfunc|
  llvm.func @t3_vec_undef(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.shl %10, %arg1  : vector<4xi32>
    %12 = llvm.and %11, %arg0  : vector<4xi32>
    %13 = llvm.lshr %12, %arg1  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }]

def t4_extrause0_before := [llvmfunc|
  llvm.func @t4_extrause0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def t5_extrause1_before := [llvmfunc|
  llvm.func @t5_extrause1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def t6_extrause2_before := [llvmfunc|
  llvm.func @t6_extrause2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.and %1, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def t7_noncanonical_lshr_lshr_extrauses_before := [llvmfunc|
  llvm.func @t7_noncanonical_lshr_lshr_extrauses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def t8_noncanonical_lshr_ashr_extrauses_before := [llvmfunc|
  llvm.func @t8_noncanonical_lshr_ashr_extrauses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.ashr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def t9_noncanonical_ashr_lshr_extrauses_before := [llvmfunc|
  llvm.func @t9_noncanonical_ashr_lshr_extrauses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def t10_noncanonical_ashr_ashr_extrauses_before := [llvmfunc|
  llvm.func @t10_noncanonical_ashr_ashr_extrauses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.ashr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def t11_commutative_before := [llvmfunc|
  llvm.func @t11_commutative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.lshr %3, %arg0  : i32
    llvm.return %4 : i32
  }]

def n12_before := [llvmfunc|
  llvm.func @n12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def n13_before := [llvmfunc|
  llvm.func @n13(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.lshr %2, %arg2  : i32
    llvm.return %3 : i32
  }]

def n14_before := [llvmfunc|
  llvm.func @n14(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg3  : i32
    llvm.return %2 : i32
  }]

def t0_lshr_combined := [llvmfunc|
  llvm.func @t0_lshr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t0_lshr   : t0_lshr_before  ⊑  t0_lshr_combined := by
  unfold t0_lshr_before t0_lshr_combined
  simp_alive_peephole
  sorry
def t1_sshr_combined := [llvmfunc|
  llvm.func @t1_sshr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.ashr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t1_sshr   : t1_sshr_before  ⊑  t1_sshr_combined := by
  unfold t1_sshr_before t1_sshr_combined
  simp_alive_peephole
  sorry
def t2_vec_combined := [llvmfunc|
  llvm.func @t2_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : vector<4xi32>
    %2 = llvm.and %1, %arg0  : vector<4xi32>
    %3 = llvm.lshr %2, %arg1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_t2_vec   : t2_vec_before  ⊑  t2_vec_combined := by
  unfold t2_vec_before t2_vec_combined
  simp_alive_peephole
  sorry
def t3_vec_undef_combined := [llvmfunc|
  llvm.func @t3_vec_undef(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.shl %10, %arg1  : vector<4xi32>
    %12 = llvm.and %11, %arg0  : vector<4xi32>
    %13 = llvm.lshr %12, %arg1  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }]

theorem inst_combine_t3_vec_undef   : t3_vec_undef_before  ⊑  t3_vec_undef_combined := by
  unfold t3_vec_undef_before t3_vec_undef_combined
  simp_alive_peephole
  sorry
def t4_extrause0_combined := [llvmfunc|
  llvm.func @t4_extrause0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t4_extrause0   : t4_extrause0_before  ⊑  t4_extrause0_combined := by
  unfold t4_extrause0_before t4_extrause0_combined
  simp_alive_peephole
  sorry
def t5_extrause1_combined := [llvmfunc|
  llvm.func @t5_extrause1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %2 = llvm.and %1, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t5_extrause1   : t5_extrause1_before  ⊑  t5_extrause1_combined := by
  unfold t5_extrause1_before t5_extrause1_combined
  simp_alive_peephole
  sorry
def t6_extrause2_combined := [llvmfunc|
  llvm.func @t6_extrause2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.and %1, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t6_extrause2   : t6_extrause2_before  ⊑  t6_extrause2_combined := by
  unfold t6_extrause2_before t6_extrause2_combined
  simp_alive_peephole
  sorry
def t7_noncanonical_lshr_lshr_extrauses_combined := [llvmfunc|
  llvm.func @t7_noncanonical_lshr_lshr_extrauses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t7_noncanonical_lshr_lshr_extrauses   : t7_noncanonical_lshr_lshr_extrauses_before  ⊑  t7_noncanonical_lshr_lshr_extrauses_combined := by
  unfold t7_noncanonical_lshr_lshr_extrauses_before t7_noncanonical_lshr_lshr_extrauses_combined
  simp_alive_peephole
  sorry
def t8_noncanonical_lshr_ashr_extrauses_combined := [llvmfunc|
  llvm.func @t8_noncanonical_lshr_ashr_extrauses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.ashr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t8_noncanonical_lshr_ashr_extrauses   : t8_noncanonical_lshr_ashr_extrauses_before  ⊑  t8_noncanonical_lshr_ashr_extrauses_combined := by
  unfold t8_noncanonical_lshr_ashr_extrauses_before t8_noncanonical_lshr_ashr_extrauses_combined
  simp_alive_peephole
  sorry
def t9_noncanonical_ashr_lshr_extrauses_combined := [llvmfunc|
  llvm.func @t9_noncanonical_ashr_lshr_extrauses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t9_noncanonical_ashr_lshr_extrauses   : t9_noncanonical_ashr_lshr_extrauses_before  ⊑  t9_noncanonical_ashr_lshr_extrauses_combined := by
  unfold t9_noncanonical_ashr_lshr_extrauses_before t9_noncanonical_ashr_lshr_extrauses_combined
  simp_alive_peephole
  sorry
def t10_noncanonical_ashr_ashr_extrauses_combined := [llvmfunc|
  llvm.func @t10_noncanonical_ashr_ashr_extrauses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.ashr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t10_noncanonical_ashr_ashr_extrauses   : t10_noncanonical_ashr_ashr_extrauses_before  ⊑  t10_noncanonical_ashr_ashr_extrauses_combined := by
  unfold t10_noncanonical_ashr_ashr_extrauses_before t10_noncanonical_ashr_ashr_extrauses_combined
  simp_alive_peephole
  sorry
def t11_commutative_combined := [llvmfunc|
  llvm.func @t11_commutative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.lshr %3, %arg0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_t11_commutative   : t11_commutative_before  ⊑  t11_commutative_combined := by
  unfold t11_commutative_before t11_commutative_combined
  simp_alive_peephole
  sorry
def n12_combined := [llvmfunc|
  llvm.func @n12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_n12   : n12_before  ⊑  n12_combined := by
  unfold n12_before n12_combined
  simp_alive_peephole
  sorry
def n13_combined := [llvmfunc|
  llvm.func @n13(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.lshr %2, %arg2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_n13   : n13_before  ⊑  n13_combined := by
  unfold n13_before n13_combined
  simp_alive_peephole
  sorry
def n14_combined := [llvmfunc|
  llvm.func @n14(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.shl %0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg3  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_n14   : n14_before  ⊑  n14_combined := by
  unfold n14_before n14_combined
  simp_alive_peephole
  sorry
