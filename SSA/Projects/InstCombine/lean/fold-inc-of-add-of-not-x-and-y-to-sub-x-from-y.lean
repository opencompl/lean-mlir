import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-inc-of-add-of-not-x-and-y-to-sub-x-from-y
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

def t1_vec_splat_before := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.xor %arg0, %0  : vector<4xi32>
    %3 = llvm.add %2, %arg1  : vector<4xi32>
    %4 = llvm.add %3, %1  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def t2_vec_poison0_before := [llvmfunc|
  llvm.func @t2_vec_poison0(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.xor %arg0, %10  : vector<4xi32>
    %13 = llvm.add %12, %arg1  : vector<4xi32>
    %14 = llvm.add %13, %11  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

def t3_vec_poison1_before := [llvmfunc|
  llvm.func @t3_vec_poison1(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.xor %arg0, %0  : vector<4xi32>
    %13 = llvm.add %12, %arg1  : vector<4xi32>
    %14 = llvm.add %13, %11  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

def t4_vec_poison2_before := [llvmfunc|
  llvm.func @t4_vec_poison2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.mlir.undef : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %11, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %11, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %1, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.insertelement %11, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.xor %arg0, %10  : vector<4xi32>
    %22 = llvm.add %21, %arg1  : vector<4xi32>
    %23 = llvm.add %22, %20  : vector<4xi32>
    llvm.return %23 : vector<4xi32>
  }]

def t5_before := [llvmfunc|
  llvm.func @t5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

def t6_before := [llvmfunc|
  llvm.func @t6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

def t7_before := [llvmfunc|
  llvm.func @t7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %2, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

def t8_commutative0_before := [llvmfunc|
  llvm.func @t8_commutative0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.add %2, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %4, %1  : i32
    llvm.return %5 : i32
  }]

def t9_commutative1_before := [llvmfunc|
  llvm.func @t9_commutative1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.add %3, %arg1  : i32
    llvm.return %4 : i32
  }]

def t10_commutative2_before := [llvmfunc|
  llvm.func @t10_commutative2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.add %3, %1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %2, %4  : i32
    llvm.return %5 : i32
  }]

def n11_before := [llvmfunc|
  llvm.func @n11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

def n12_before := [llvmfunc|
  llvm.func @n12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.sub %arg1, %arg0  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_vec_splat_combined := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.sub %arg1, %arg0  : vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_t1_vec_splat   : t1_vec_splat_before  ⊑  t1_vec_splat_combined := by
  unfold t1_vec_splat_before t1_vec_splat_combined
  simp_alive_peephole
  sorry
def t2_vec_poison0_combined := [llvmfunc|
  llvm.func @t2_vec_poison0(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.sub %arg1, %arg0  : vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_t2_vec_poison0   : t2_vec_poison0_before  ⊑  t2_vec_poison0_combined := by
  unfold t2_vec_poison0_before t2_vec_poison0_combined
  simp_alive_peephole
  sorry
def t3_vec_poison1_combined := [llvmfunc|
  llvm.func @t3_vec_poison1(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.sub %arg1, %arg0  : vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_t3_vec_poison1   : t3_vec_poison1_before  ⊑  t3_vec_poison1_combined := by
  unfold t3_vec_poison1_before t3_vec_poison1_combined
  simp_alive_peephole
  sorry
def t4_vec_poison2_combined := [llvmfunc|
  llvm.func @t4_vec_poison2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.sub %arg1, %arg0  : vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_t4_vec_poison2   : t4_vec_poison2_before  ⊑  t4_vec_poison2_combined := by
  unfold t4_vec_poison2_before t4_vec_poison2_combined
  simp_alive_peephole
  sorry
def t5_combined := [llvmfunc|
  llvm.func @t5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.sub %arg1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t5   : t5_before  ⊑  t5_combined := by
  unfold t5_before t5_combined
  simp_alive_peephole
  sorry
def t6_combined := [llvmfunc|
  llvm.func @t6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.sub %arg1, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t6   : t6_before  ⊑  t6_combined := by
  unfold t6_before t6_combined
  simp_alive_peephole
  sorry
def t7_combined := [llvmfunc|
  llvm.func @t7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.add %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.sub %arg1, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t7   : t7_before  ⊑  t7_combined := by
  unfold t7_before t7_combined
  simp_alive_peephole
  sorry
def t8_commutative0_combined := [llvmfunc|
  llvm.func @t8_commutative0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %1, %2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.sub %1, %arg0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_t8_commutative0   : t8_commutative0_before  ⊑  t8_commutative0_combined := by
  unfold t8_commutative0_before t8_commutative0_combined
  simp_alive_peephole
  sorry
def t9_commutative1_combined := [llvmfunc|
  llvm.func @t9_commutative1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.sub %1, %arg0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.sub %arg1, %arg0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_t9_commutative1   : t9_commutative1_before  ⊑  t9_commutative1_combined := by
  unfold t9_commutative1_before t9_commutative1_combined
  simp_alive_peephole
  sorry
def t10_commutative2_combined := [llvmfunc|
  llvm.func @t10_commutative2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.sub %1, %arg0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.sub %2, %arg0  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t10_commutative2   : t10_commutative2_before  ⊑  t10_commutative2_combined := by
  unfold t10_commutative2_before t10_commutative2_combined
  simp_alive_peephole
  sorry
def n11_combined := [llvmfunc|
  llvm.func @n11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n11   : n11_before  ⊑  n11_combined := by
  unfold n11_before n11_combined
  simp_alive_peephole
  sorry
def n12_combined := [llvmfunc|
  llvm.func @n12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n12   : n12_before  ⊑  n12_combined := by
  unfold n12_before n12_combined
  simp_alive_peephole
  sorry
