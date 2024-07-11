import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  add-mask-neg
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def dec_mask_neg_i32_before := [llvmfunc|
  llvm.func @dec_mask_neg_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

def dec_mask_commute_neg_i32_before := [llvmfunc|
  llvm.func @dec_mask_commute_neg_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sdiv %0, %arg0  : i32
    %4 = llvm.sub %1, %3  : i32
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.add %5, %2  : i32
    llvm.return %6 : i32
  }]

def dec_commute_mask_neg_i32_before := [llvmfunc|
  llvm.func @dec_commute_mask_neg_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }]

def dec_mask_neg_multiuse_i32_before := [llvmfunc|
  llvm.func @dec_mask_neg_multiuse_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %4 : i32
  }]

def dec_mask_multiuse_neg_i32_before := [llvmfunc|
  llvm.func @dec_mask_multiuse_neg_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

def dec_mask_neg_v2i32_before := [llvmfunc|
  llvm.func @dec_mask_neg_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = llvm.add %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def dec_mask_neg_v2i32_poison_before := [llvmfunc|
  llvm.func @dec_mask_neg_v2i32_poison(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.undef : vector<2xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi32>
    %9 = llvm.sub %1, %arg0  : vector<2xi32>
    %10 = llvm.and %9, %arg0  : vector<2xi32>
    %11 = llvm.add %10, %8  : vector<2xi32>
    llvm.return %11 : vector<2xi32>
  }]

def dec_mask_multiuse_neg_multiuse_v2i32_before := [llvmfunc|
  llvm.func @dec_mask_multiuse_neg_multiuse_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = llvm.add %4, %2  : vector<2xi32>
    llvm.call @usev(%3) : (vector<2xi32>) -> ()
    llvm.call @usev(%4) : (vector<2xi32>) -> ()
    llvm.return %5 : vector<2xi32>
  }]

def dec_mask_neg_i32_combined := [llvmfunc|
  llvm.func @dec_mask_neg_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_dec_mask_neg_i32   : dec_mask_neg_i32_before  ⊑  dec_mask_neg_i32_combined := by
  unfold dec_mask_neg_i32_before dec_mask_neg_i32_combined
  simp_alive_peephole
  sorry
def dec_mask_commute_neg_i32_combined := [llvmfunc|
  llvm.func @dec_mask_commute_neg_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_dec_mask_commute_neg_i32   : dec_mask_commute_neg_i32_before  ⊑  dec_mask_commute_neg_i32_combined := by
  unfold dec_mask_commute_neg_i32_before dec_mask_commute_neg_i32_combined
  simp_alive_peephole
  sorry
def dec_commute_mask_neg_i32_combined := [llvmfunc|
  llvm.func @dec_commute_mask_neg_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_dec_commute_mask_neg_i32   : dec_commute_mask_neg_i32_before  ⊑  dec_commute_mask_neg_i32_combined := by
  unfold dec_commute_mask_neg_i32_before dec_commute_mask_neg_i32_combined
  simp_alive_peephole
  sorry
def dec_mask_neg_multiuse_i32_combined := [llvmfunc|
  llvm.func @dec_mask_neg_multiuse_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_dec_mask_neg_multiuse_i32   : dec_mask_neg_multiuse_i32_before  ⊑  dec_mask_neg_multiuse_i32_combined := by
  unfold dec_mask_neg_multiuse_i32_before dec_mask_neg_multiuse_i32_combined
  simp_alive_peephole
  sorry
def dec_mask_multiuse_neg_i32_combined := [llvmfunc|
  llvm.func @dec_mask_multiuse_neg_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_dec_mask_multiuse_neg_i32   : dec_mask_multiuse_neg_i32_before  ⊑  dec_mask_multiuse_neg_i32_combined := by
  unfold dec_mask_multiuse_neg_i32_before dec_mask_multiuse_neg_i32_combined
  simp_alive_peephole
  sorry
def dec_mask_neg_v2i32_combined := [llvmfunc|
  llvm.func @dec_mask_neg_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %0  : vector<2xi32>
    %2 = llvm.xor %arg0, %0  : vector<2xi32>
    %3 = llvm.and %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_dec_mask_neg_v2i32   : dec_mask_neg_v2i32_before  ⊑  dec_mask_neg_v2i32_combined := by
  unfold dec_mask_neg_v2i32_before dec_mask_neg_v2i32_combined
  simp_alive_peephole
  sorry
def dec_mask_neg_v2i32_poison_combined := [llvmfunc|
  llvm.func @dec_mask_neg_v2i32_poison(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %0  : vector<2xi32>
    %2 = llvm.xor %arg0, %0  : vector<2xi32>
    %3 = llvm.and %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_dec_mask_neg_v2i32_poison   : dec_mask_neg_v2i32_poison_before  ⊑  dec_mask_neg_v2i32_poison_combined := by
  unfold dec_mask_neg_v2i32_poison_before dec_mask_neg_v2i32_poison_combined
  simp_alive_peephole
  sorry
def dec_mask_multiuse_neg_multiuse_v2i32_combined := [llvmfunc|
  llvm.func @dec_mask_multiuse_neg_multiuse_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = llvm.add %4, %2  : vector<2xi32>
    llvm.call @usev(%3) : (vector<2xi32>) -> ()
    llvm.call @usev(%4) : (vector<2xi32>) -> ()
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_dec_mask_multiuse_neg_multiuse_v2i32   : dec_mask_multiuse_neg_multiuse_v2i32_before  ⊑  dec_mask_multiuse_neg_multiuse_v2i32_combined := by
  unfold dec_mask_multiuse_neg_multiuse_v2i32_before dec_mask_multiuse_neg_multiuse_v2i32_combined
  simp_alive_peephole
  sorry
