import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  high-bit-signmask-with-trunc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def t1_exact_before := [llvmfunc|
  llvm.func @t1_exact(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def t3_exact_before := [llvmfunc|
  llvm.func @t3_exact(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def t4_before := [llvmfunc|
  llvm.func @t4(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<63> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.lshr %arg0, %0  : vector<2xi64>
    %4 = llvm.trunc %3 : vector<2xi64> to vector<2xi32>
    %5 = llvm.sub %2, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def t5_before := [llvmfunc|
  llvm.func @t5(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.undef : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.undef : vector<2xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %7, %11[%12 : i32] : vector<2xi32>
    %14 = llvm.lshr %arg0, %6  : vector<2xi64>
    %15 = llvm.trunc %14 : vector<2xi64> to vector<2xi32>
    %16 = llvm.sub %13, %15  : vector<2xi32>
    llvm.return %16 : vector<2xi32>
  }]

def t6_before := [llvmfunc|
  llvm.func @t6(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def n7_before := [llvmfunc|
  llvm.func @n7(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def n8_before := [llvmfunc|
  llvm.func @n8(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.trunc %2 : i64 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def n9_before := [llvmfunc|
  llvm.func @n9(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(62 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def n10_before := [llvmfunc|
  llvm.func @n10(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.ashr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_exact_combined := [llvmfunc|
  llvm.func @t1_exact(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.ashr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t1_exact   : t1_exact_before  ⊑  t1_exact_combined := by
  unfold t1_exact_before t1_exact_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def t3_exact_combined := [llvmfunc|
  llvm.func @t3_exact(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t3_exact   : t3_exact_before  ⊑  t3_exact_combined := by
  unfold t3_exact_before t3_exact_combined
  simp_alive_peephole
  sorry
def t4_combined := [llvmfunc|
  llvm.func @t4(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<63> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.ashr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_t4   : t4_before  ⊑  t4_combined := by
  unfold t4_before t4_combined
  simp_alive_peephole
  sorry
def t5_combined := [llvmfunc|
  llvm.func @t5(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.undef : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.undef : vector<2xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %7, %11[%12 : i32] : vector<2xi32>
    %14 = llvm.lshr %arg0, %6  : vector<2xi64>
    %15 = llvm.trunc %14 : vector<2xi64> to vector<2xi32>
    %16 = llvm.sub %13, %15  : vector<2xi32>
    llvm.return %16 : vector<2xi32>
  }]

theorem inst_combine_t5   : t5_before  ⊑  t5_combined := by
  unfold t5_before t5_combined
  simp_alive_peephole
  sorry
def t6_combined := [llvmfunc|
  llvm.func @t6(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.ashr %arg0, %0  : i64
    %2 = llvm.lshr %arg0, %0  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.trunc %1 : i64 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t6   : t6_before  ⊑  t6_combined := by
  unfold t6_before t6_combined
  simp_alive_peephole
  sorry
def n7_combined := [llvmfunc|
  llvm.func @n7(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.sub %1, %3 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n7   : n7_before  ⊑  n7_combined := by
  unfold n7_before n7_combined
  simp_alive_peephole
  sorry
def n8_combined := [llvmfunc|
  llvm.func @n8(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.trunc %2 : i64 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.sub %1, %3 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n8   : n8_before  ⊑  n8_combined := by
  unfold n8_before n8_combined
  simp_alive_peephole
  sorry
def n9_combined := [llvmfunc|
  llvm.func @n9(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(62 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n9   : n9_before  ⊑  n9_combined := by
  unfold n9_before n9_combined
  simp_alive_peephole
  sorry
def n10_combined := [llvmfunc|
  llvm.func @n10(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.add %3, %1 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_n10   : n10_before  ⊑  n10_combined := by
  unfold n10_before n10_combined
  simp_alive_peephole
  sorry
