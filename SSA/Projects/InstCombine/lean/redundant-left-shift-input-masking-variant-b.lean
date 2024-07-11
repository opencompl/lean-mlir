import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  redundant-left-shift-input-masking-variant-b
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %4, %5  : i32
    llvm.return %6 : i32
  }]

def t1_bigger_shift_before := [llvmfunc|
  llvm.func @t1_bigger_shift(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(33 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %4, %5  : i32
    llvm.return %6 : i32
  }]

def t2_bigger_mask_before := [llvmfunc|
  llvm.func @t2_bigger_mask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.shl %1, %3  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %5, %arg0  : i32
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %6, %7  : i32
    llvm.return %8 : i32
  }]

def t3_vec_splat_before := [llvmfunc|
  llvm.func @t3_vec_splat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %3 = llvm.mlir.constant(dense<32> : vector<3xi32>) : vector<3xi32>
    %4 = llvm.add %arg1, %1  : vector<3xi32>
    %5 = llvm.shl %2, %4  : vector<3xi32>
    %6 = llvm.xor %5, %2  : vector<3xi32>
    %7 = llvm.and %6, %arg0  : vector<3xi32>
    %8 = llvm.sub %3, %arg1  : vector<3xi32>
    llvm.call @use3xi32(%4) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%5) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%6) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%7) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%8) : (vector<3xi32>) -> ()
    %9 = llvm.shl %7, %8  : vector<3xi32>
    llvm.return %9 : vector<3xi32>
  }]

def t4_vec_nonsplat_before := [llvmfunc|
  llvm.func @t4_vec_nonsplat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[-1, 0, 1]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(dense<[33, 32, 32]> : vector<3xi32>) : vector<3xi32>
    %3 = llvm.add %arg1, %0  : vector<3xi32>
    %4 = llvm.shl %1, %3  : vector<3xi32>
    %5 = llvm.xor %4, %1  : vector<3xi32>
    %6 = llvm.and %5, %arg0  : vector<3xi32>
    %7 = llvm.sub %2, %arg1  : vector<3xi32>
    llvm.call @use3xi32(%3) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%4) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%5) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%6) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%7) : (vector<3xi32>) -> ()
    %8 = llvm.shl %6, %7  : vector<3xi32>
    llvm.return %8 : vector<3xi32>
  }]

def t5_vec_poison_before := [llvmfunc|
  llvm.func @t5_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(-1 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.mlir.constant(32 : i32) : i32
    %18 = llvm.mlir.undef : vector<3xi32>
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.insertelement %17, %18[%19 : i32] : vector<3xi32>
    %21 = llvm.mlir.constant(1 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : vector<3xi32>
    %23 = llvm.mlir.constant(2 : i32) : i32
    %24 = llvm.insertelement %17, %22[%23 : i32] : vector<3xi32>
    %25 = llvm.add %arg1, %8  : vector<3xi32>
    %26 = llvm.shl %16, %25  : vector<3xi32>
    %27 = llvm.xor %26, %16  : vector<3xi32>
    %28 = llvm.and %27, %arg0  : vector<3xi32>
    %29 = llvm.sub %24, %arg1  : vector<3xi32>
    llvm.call @use3xi32(%25) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%26) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%27) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%28) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%29) : (vector<3xi32>) -> ()
    %30 = llvm.shl %28, %29  : vector<3xi32>
    llvm.return %30 : vector<3xi32>
  }]

def t6_commutativity0_before := [llvmfunc|
  llvm.func @t6_commutativity0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %2, %4  : i32
    %6 = llvm.sub %1, %arg0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.return %7 : i32
  }]

def t7_commutativity1_before := [llvmfunc|
  llvm.func @t7_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %3  : i32
    %7 = llvm.sub %1, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %6, %7  : i32
    llvm.return %8 : i32
  }]

def t8_commutativity2_before := [llvmfunc|
  llvm.func @t8_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %3  : i32
    %7 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %6, %7  : i32
    llvm.return %8 : i32
  }]

def t9_nuw_before := [llvmfunc|
  llvm.func @t9_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %4, %5 overflow<nuw>  : i32
    llvm.return %6 : i32
  }]

def t10_nsw_before := [llvmfunc|
  llvm.func @t10_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %4, %5 overflow<nsw>  : i32
    llvm.return %6 : i32
  }]

def t11_nuw_nsw_before := [llvmfunc|
  llvm.func @t11_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %4, %5 overflow<nsw, nuw>  : i32
    llvm.return %6 : i32
  }]

def n12_not_minus_one_before := [llvmfunc|
  llvm.func @n12_not_minus_one(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.return %7 : i32
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %arg0, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t1_bigger_shift_combined := [llvmfunc|
  llvm.func @t1_bigger_shift(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(33 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.sub %1, %arg1  : i32
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
def t2_bigger_mask_combined := [llvmfunc|
  llvm.func @t2_bigger_mask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.shl %1, %3 overflow<nsw>  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %5, %arg0  : i32
    %7 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %arg0, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t2_bigger_mask   : t2_bigger_mask_before  ⊑  t2_bigger_mask_combined := by
  unfold t2_bigger_mask_before t2_bigger_mask_combined
  simp_alive_peephole
  sorry
def t3_vec_splat_combined := [llvmfunc|
  llvm.func @t3_vec_splat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<32> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : vector<3xi32>
    %3 = llvm.xor %2, %0  : vector<3xi32>
    %4 = llvm.and %3, %arg0  : vector<3xi32>
    %5 = llvm.sub %1, %arg1  : vector<3xi32>
    llvm.call @use3xi32(%arg1) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%2) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%3) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%4) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%5) : (vector<3xi32>) -> ()
    %6 = llvm.shl %arg0, %5  : vector<3xi32>
    llvm.return %6 : vector<3xi32>
  }]

theorem inst_combine_t3_vec_splat   : t3_vec_splat_before  ⊑  t3_vec_splat_combined := by
  unfold t3_vec_splat_before t3_vec_splat_combined
  simp_alive_peephole
  sorry
def t4_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t4_vec_nonsplat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[-1, 0, 1]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(dense<[33, 32, 32]> : vector<3xi32>) : vector<3xi32>
    %3 = llvm.add %arg1, %0  : vector<3xi32>
    %4 = llvm.shl %1, %3 overflow<nsw>  : vector<3xi32>
    %5 = llvm.xor %4, %1  : vector<3xi32>
    %6 = llvm.and %5, %arg0  : vector<3xi32>
    %7 = llvm.sub %2, %arg1  : vector<3xi32>
    llvm.call @use3xi32(%3) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%4) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%5) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%6) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%7) : (vector<3xi32>) -> ()
    %8 = llvm.shl %arg0, %7  : vector<3xi32>
    llvm.return %8 : vector<3xi32>
  }]

theorem inst_combine_t4_vec_nonsplat   : t4_vec_nonsplat_before  ⊑  t4_vec_nonsplat_combined := by
  unfold t4_vec_nonsplat_before t4_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def t5_vec_poison_combined := [llvmfunc|
  llvm.func @t5_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(32 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.shl %8, %arg1 overflow<nsw>  : vector<3xi32>
    %18 = llvm.xor %17, %8  : vector<3xi32>
    %19 = llvm.and %18, %arg0  : vector<3xi32>
    %20 = llvm.sub %16, %arg1  : vector<3xi32>
    llvm.call @use3xi32(%arg1) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%17) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%18) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%19) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%20) : (vector<3xi32>) -> ()
    %21 = llvm.shl %arg0, %20  : vector<3xi32>
    llvm.return %21 : vector<3xi32>
  }]

theorem inst_combine_t5_vec_poison   : t5_vec_poison_before  ⊑  t5_vec_poison_combined := by
  unfold t5_vec_poison_before t5_vec_poison_combined
  simp_alive_peephole
  sorry
def t6_commutativity0_combined := [llvmfunc|
  llvm.func @t6_commutativity0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.and %2, %4  : i32
    %6 = llvm.sub %1, %arg0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %2, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_t6_commutativity0   : t6_commutativity0_before  ⊑  t6_commutativity0_combined := by
  unfold t6_commutativity0_before t6_commutativity0_combined
  simp_alive_peephole
  sorry
def t7_commutativity1_combined := [llvmfunc|
  llvm.func @t7_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %3  : i32
    %7 = llvm.sub %1, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %6, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t7_commutativity1   : t7_commutativity1_before  ⊑  t7_commutativity1_combined := by
  unfold t7_commutativity1_before t7_commutativity1_combined
  simp_alive_peephole
  sorry
def t8_commutativity2_combined := [llvmfunc|
  llvm.func @t8_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %5, %3  : i32
    %7 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %3, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t8_commutativity2   : t8_commutativity2_before  ⊑  t8_commutativity2_combined := by
  unfold t8_commutativity2_before t8_commutativity2_combined
  simp_alive_peephole
  sorry
def t9_nuw_combined := [llvmfunc|
  llvm.func @t9_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %arg0, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_t9_nuw   : t9_nuw_before  ⊑  t9_nuw_combined := by
  unfold t9_nuw_before t9_nuw_combined
  simp_alive_peephole
  sorry
def t10_nsw_combined := [llvmfunc|
  llvm.func @t10_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %arg0, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_t10_nsw   : t10_nsw_before  ⊑  t10_nsw_combined := by
  unfold t10_nsw_before t10_nsw_combined
  simp_alive_peephole
  sorry
def t11_nuw_nsw_combined := [llvmfunc|
  llvm.func @t11_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %arg0, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_t11_nuw_nsw   : t11_nuw_nsw_before  ⊑  t11_nuw_nsw_combined := by
  unfold t11_nuw_nsw_before t11_nuw_nsw_combined
  simp_alive_peephole
  sorry
def n12_not_minus_one_combined := [llvmfunc|
  llvm.func @n12_not_minus_one(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.sub %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n12_not_minus_one   : n12_not_minus_one_before  ⊑  n12_not_minus_one_combined := by
  unfold n12_not_minus_one_before n12_not_minus_one_combined
  simp_alive_peephole
  sorry
