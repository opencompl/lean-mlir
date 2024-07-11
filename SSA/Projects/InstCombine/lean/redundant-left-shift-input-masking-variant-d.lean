import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  redundant-left-shift-input-masking-variant-d
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %3, %arg1  : i32
    llvm.return %4 : i32
  }]

def t1_bigger_shift_before := [llvmfunc|
  llvm.func @t1_bigger_shift(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.add %arg1, %1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %4, %5  : i32
    llvm.return %6 : i32
  }]

def t2_vec_splat_before := [llvmfunc|
  llvm.func @t2_vec_splat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.shl %0, %arg1  : vector<3xi32>
    %3 = llvm.lshr %2, %arg1  : vector<3xi32>
    %4 = llvm.and %3, %arg0  : vector<3xi32>
    %5 = llvm.add %arg1, %1  : vector<3xi32>
    llvm.call @use3xi32(%2) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%3) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%4) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%5) : (vector<3xi32>) -> ()
    %6 = llvm.shl %4, %5  : vector<3xi32>
    llvm.return %6 : vector<3xi32>
  }]

def t3_vec_nonsplat_before := [llvmfunc|
  llvm.func @t3_vec_nonsplat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[1, 0, 2]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.shl %0, %arg1  : vector<3xi32>
    %3 = llvm.lshr %2, %arg1  : vector<3xi32>
    %4 = llvm.and %3, %arg0  : vector<3xi32>
    %5 = llvm.add %arg1, %1  : vector<3xi32>
    llvm.call @use3xi32(%2) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%3) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%4) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%5) : (vector<3xi32>) -> ()
    %6 = llvm.shl %4, %5  : vector<3xi32>
    llvm.return %6 : vector<3xi32>
  }]

def t4_vec_poison_before := [llvmfunc|
  llvm.func @t4_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.shl %8, %arg1  : vector<3xi32>
    %18 = llvm.lshr %17, %arg1  : vector<3xi32>
    %19 = llvm.and %18, %arg0  : vector<3xi32>
    %20 = llvm.add %arg1, %16  : vector<3xi32>
    llvm.call @use3xi32(%17) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%18) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%19) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%20) : (vector<3xi32>) -> ()
    %21 = llvm.shl %19, %20  : vector<3xi32>
    llvm.return %21 : vector<3xi32>
  }]

def t5_commutativity0_before := [llvmfunc|
  llvm.func @t5_commutativity0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.lshr %2, %arg0  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.shl %4, %arg0  : i32
    llvm.return %5 : i32
  }]

def t6_commutativity1_before := [llvmfunc|
  llvm.func @t6_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.lshr %1, %arg0  : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.lshr %1, %arg1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %5, %arg0  : i32
    llvm.return %6 : i32
  }]

def t7_commutativity2_before := [llvmfunc|
  llvm.func @t7_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.lshr %1, %arg0  : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.lshr %1, %arg1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %5, %arg1  : i32
    llvm.return %6 : i32
  }]

def t8_nuw_before := [llvmfunc|
  llvm.func @t8_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %3, %arg1 overflow<nuw>  : i32
    llvm.return %4 : i32
  }]

def t9_nsw_before := [llvmfunc|
  llvm.func @t9_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %3, %arg1 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

def t10_nuw_nsw_before := [llvmfunc|
  llvm.func @t10_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %3, %arg1 overflow<nsw, nuw>  : i32
    llvm.return %4 : i32
  }]

def t11_assume_uge_before := [llvmfunc|
  llvm.func @t11_assume_uge(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "uge" %arg2, %arg1 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.shl %4, %arg2  : i32
    llvm.return %5 : i32
  }]

def n12_different_shamts0_before := [llvmfunc|
  llvm.func @n12_different_shamts0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def n13_different_shamts1_before := [llvmfunc|
  llvm.func @n13_different_shamts1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %arg2  : i32
    llvm.return %3 : i32
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %arg0, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t1_bigger_shift_combined := [llvmfunc|
  llvm.func @t1_bigger_shift(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.add %arg1, %1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %arg0, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_t1_bigger_shift   : t1_bigger_shift_before  ⊑  t1_bigger_shift_combined := by
  unfold t1_bigger_shift_before t1_bigger_shift_combined
  simp_alive_peephole
  sorry
def t2_vec_splat_combined := [llvmfunc|
  llvm.func @t2_vec_splat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : vector<3xi32>
    %3 = llvm.lshr %2, %arg1  : vector<3xi32>
    %4 = llvm.and %3, %arg0  : vector<3xi32>
    %5 = llvm.add %arg1, %1  : vector<3xi32>
    llvm.call @use3xi32(%2) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%3) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%4) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%5) : (vector<3xi32>) -> ()
    %6 = llvm.shl %arg0, %5  : vector<3xi32>
    llvm.return %6 : vector<3xi32>
  }]

theorem inst_combine_t2_vec_splat   : t2_vec_splat_before  ⊑  t2_vec_splat_combined := by
  unfold t2_vec_splat_before t2_vec_splat_combined
  simp_alive_peephole
  sorry
def t3_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t3_vec_nonsplat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[1, 0, 2]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : vector<3xi32>
    %3 = llvm.lshr %2, %arg1  : vector<3xi32>
    %4 = llvm.and %3, %arg0  : vector<3xi32>
    %5 = llvm.add %arg1, %1  : vector<3xi32>
    llvm.call @use3xi32(%2) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%3) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%4) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%5) : (vector<3xi32>) -> ()
    %6 = llvm.shl %arg0, %5  : vector<3xi32>
    llvm.return %6 : vector<3xi32>
  }]

theorem inst_combine_t3_vec_nonsplat   : t3_vec_nonsplat_before  ⊑  t3_vec_nonsplat_combined := by
  unfold t3_vec_nonsplat_before t3_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def t4_vec_poison_combined := [llvmfunc|
  llvm.func @t4_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.shl %8, %arg1 overflow<nsw>  : vector<3xi32>
    %10 = llvm.lshr %9, %arg1  : vector<3xi32>
    %11 = llvm.and %10, %arg0  : vector<3xi32>
    llvm.call @use3xi32(%9) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%10) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%11) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%arg1) : (vector<3xi32>) -> ()
    %12 = llvm.shl %arg0, %arg1  : vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }]

theorem inst_combine_t4_vec_poison   : t4_vec_poison_before  ⊑  t4_vec_poison_combined := by
  unfold t4_vec_poison_before t4_vec_poison_combined
  simp_alive_peephole
  sorry
def t5_commutativity0_combined := [llvmfunc|
  llvm.func @t5_commutativity0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %arg0  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.shl %1, %arg0  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t5_commutativity0   : t5_commutativity0_before  ⊑  t5_commutativity0_combined := by
  unfold t5_commutativity0_before t5_commutativity0_combined
  simp_alive_peephole
  sorry
def t6_commutativity1_combined := [llvmfunc|
  llvm.func @t6_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %arg0  : i32
    %3 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %4 = llvm.lshr %1, %arg1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %4, %arg0  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_t6_commutativity1   : t6_commutativity1_before  ⊑  t6_commutativity1_combined := by
  unfold t6_commutativity1_before t6_commutativity1_combined
  simp_alive_peephole
  sorry
def t7_commutativity2_combined := [llvmfunc|
  llvm.func @t7_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %arg0  : i32
    %3 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %4 = llvm.lshr %1, %arg1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %5, %arg1  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_t7_commutativity2   : t7_commutativity2_before  ⊑  t7_commutativity2_combined := by
  unfold t7_commutativity2_before t7_commutativity2_combined
  simp_alive_peephole
  sorry
def t8_nuw_combined := [llvmfunc|
  llvm.func @t8_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %arg0, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_t8_nuw   : t8_nuw_before  ⊑  t8_nuw_combined := by
  unfold t8_nuw_before t8_nuw_combined
  simp_alive_peephole
  sorry
def t9_nsw_combined := [llvmfunc|
  llvm.func @t9_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %arg0, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_t9_nsw   : t9_nsw_before  ⊑  t9_nsw_combined := by
  unfold t9_nsw_before t9_nsw_combined
  simp_alive_peephole
  sorry
def t10_nuw_nsw_combined := [llvmfunc|
  llvm.func @t10_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %arg0, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_t10_nuw_nsw   : t10_nuw_nsw_before  ⊑  t10_nuw_nsw_combined := by
  unfold t10_nuw_nsw_before t10_nuw_nsw_combined
  simp_alive_peephole
  sorry
def t11_assume_uge_combined := [llvmfunc|
  llvm.func @t11_assume_uge(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "uge" %arg2, %arg1 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.shl %4, %arg2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t11_assume_uge   : t11_assume_uge_before  ⊑  t11_assume_uge_combined := by
  unfold t11_assume_uge_before t11_assume_uge_combined
  simp_alive_peephole
  sorry
def n12_different_shamts0_combined := [llvmfunc|
  llvm.func @n12_different_shamts0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_n12_different_shamts0   : n12_different_shamts0_before  ⊑  n12_different_shamts0_combined := by
  unfold n12_different_shamts0_before n12_different_shamts0_combined
  simp_alive_peephole
  sorry
def n13_different_shamts1_combined := [llvmfunc|
  llvm.func @n13_different_shamts1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %arg2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_n13_different_shamts1   : n13_different_shamts1_before  ⊑  n13_different_shamts1_combined := by
  unfold n13_different_shamts1_before n13_different_shamts1_combined
  simp_alive_peephole
  sorry
