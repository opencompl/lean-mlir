import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  trunc-shift-trunc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def trunc_lshr_trunc_before := [llvmfunc|
  llvm.func @trunc_lshr_trunc(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_shl_trunc_before := [llvmfunc|
  llvm.func @trunc_shl_trunc(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[9, 7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_trunc_uniform_before := [llvmfunc|
  llvm.func @trunc_lshr_trunc_uniform(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_trunc_nonuniform_before := [llvmfunc|
  llvm.func @trunc_lshr_trunc_nonuniform(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_lshr_trunc_uniform_poison_before := [llvmfunc|
  llvm.func @trunc_lshr_trunc_uniform_poison(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %8 = llvm.lshr %7, %6  : vector<2xi32>
    %9 = llvm.trunc %8 : vector<2xi32> to vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }]

def trunc_lshr_trunc_outofrange_before := [llvmfunc|
  llvm.func @trunc_lshr_trunc_outofrange(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_lshr_trunc_nonuniform_outofrange_before := [llvmfunc|
  llvm.func @trunc_lshr_trunc_nonuniform_outofrange(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 25]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_ashr_trunc_before := [llvmfunc|
  llvm.func @trunc_ashr_trunc(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_ashr_trunc_exact_before := [llvmfunc|
  llvm.func @trunc_ashr_trunc_exact(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_ashr_trunc_uniform_before := [llvmfunc|
  llvm.func @trunc_ashr_trunc_uniform(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_ashr_trunc_nonuniform_before := [llvmfunc|
  llvm.func @trunc_ashr_trunc_nonuniform(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, 23]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_ashr_trunc_uniform_poison_before := [llvmfunc|
  llvm.func @trunc_ashr_trunc_uniform_poison(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %8 = llvm.ashr %7, %6  : vector<2xi32>
    %9 = llvm.trunc %8 : vector<2xi32> to vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }]

def trunc_ashr_trunc_outofrange_before := [llvmfunc|
  llvm.func @trunc_ashr_trunc_outofrange(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

def trunc_ashr_trunc_nonuniform_outofrange_before := [llvmfunc|
  llvm.func @trunc_ashr_trunc_nonuniform_outofrange(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 25]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def trunc_ashr_trunc_multiuse_before := [llvmfunc|
  llvm.func @trunc_ashr_trunc_multiuse(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i8
  }]

def trunc_lshr_trunc_combined := [llvmfunc|
  llvm.func @trunc_lshr_trunc(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_trunc_lshr_trunc   : trunc_lshr_trunc_before  ⊑  trunc_lshr_trunc_combined := by
  unfold trunc_lshr_trunc_before trunc_lshr_trunc_combined
  simp_alive_peephole
  sorry
def trunc_shl_trunc_combined := [llvmfunc|
  llvm.func @trunc_shl_trunc(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[9, 7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_trunc_shl_trunc   : trunc_shl_trunc_before  ⊑  trunc_shl_trunc_combined := by
  unfold trunc_shl_trunc_before trunc_shl_trunc_combined
  simp_alive_peephole
  sorry
def trunc_lshr_trunc_uniform_combined := [llvmfunc|
  llvm.func @trunc_lshr_trunc_uniform(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_trunc_uniform   : trunc_lshr_trunc_uniform_before  ⊑  trunc_lshr_trunc_uniform_combined := by
  unfold trunc_lshr_trunc_uniform_before trunc_lshr_trunc_uniform_combined
  simp_alive_peephole
  sorry
def trunc_lshr_trunc_nonuniform_combined := [llvmfunc|
  llvm.func @trunc_lshr_trunc_nonuniform(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 2]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_trunc_nonuniform   : trunc_lshr_trunc_nonuniform_before  ⊑  trunc_lshr_trunc_nonuniform_combined := by
  unfold trunc_lshr_trunc_nonuniform_before trunc_lshr_trunc_nonuniform_combined
  simp_alive_peephole
  sorry
def trunc_lshr_trunc_uniform_poison_combined := [llvmfunc|
  llvm.func @trunc_lshr_trunc_uniform_poison(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(24 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.lshr %arg0, %6  : vector<2xi64>
    %8 = llvm.trunc %7 : vector<2xi64> to vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_trunc_uniform_poison   : trunc_lshr_trunc_uniform_poison_before  ⊑  trunc_lshr_trunc_uniform_poison_combined := by
  unfold trunc_lshr_trunc_uniform_poison_before trunc_lshr_trunc_uniform_poison_combined
  simp_alive_peephole
  sorry
def trunc_lshr_trunc_outofrange_combined := [llvmfunc|
  llvm.func @trunc_lshr_trunc_outofrange(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

theorem inst_combine_trunc_lshr_trunc_outofrange   : trunc_lshr_trunc_outofrange_before  ⊑  trunc_lshr_trunc_outofrange_combined := by
  unfold trunc_lshr_trunc_outofrange_before trunc_lshr_trunc_outofrange_combined
  simp_alive_peephole
  sorry
def trunc_lshr_trunc_nonuniform_outofrange_combined := [llvmfunc|
  llvm.func @trunc_lshr_trunc_nonuniform_outofrange(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 25]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_trunc_lshr_trunc_nonuniform_outofrange   : trunc_lshr_trunc_nonuniform_outofrange_before  ⊑  trunc_lshr_trunc_nonuniform_outofrange_combined := by
  unfold trunc_lshr_trunc_nonuniform_outofrange_before trunc_lshr_trunc_nonuniform_outofrange_combined
  simp_alive_peephole
  sorry
def trunc_ashr_trunc_combined := [llvmfunc|
  llvm.func @trunc_ashr_trunc(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_trunc_ashr_trunc   : trunc_ashr_trunc_before  ⊑  trunc_ashr_trunc_combined := by
  unfold trunc_ashr_trunc_before trunc_ashr_trunc_combined
  simp_alive_peephole
  sorry
def trunc_ashr_trunc_exact_combined := [llvmfunc|
  llvm.func @trunc_ashr_trunc_exact(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_trunc_ashr_trunc_exact   : trunc_ashr_trunc_exact_before  ⊑  trunc_ashr_trunc_exact_combined := by
  unfold trunc_ashr_trunc_exact_before trunc_ashr_trunc_exact_combined
  simp_alive_peephole
  sorry
def trunc_ashr_trunc_uniform_combined := [llvmfunc|
  llvm.func @trunc_ashr_trunc_uniform(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_trunc_ashr_trunc_uniform   : trunc_ashr_trunc_uniform_before  ⊑  trunc_ashr_trunc_uniform_combined := by
  unfold trunc_ashr_trunc_uniform_before trunc_ashr_trunc_uniform_combined
  simp_alive_peephole
  sorry
def trunc_ashr_trunc_nonuniform_combined := [llvmfunc|
  llvm.func @trunc_ashr_trunc_nonuniform(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, 23]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.ashr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_trunc_ashr_trunc_nonuniform   : trunc_ashr_trunc_nonuniform_before  ⊑  trunc_ashr_trunc_nonuniform_combined := by
  unfold trunc_ashr_trunc_nonuniform_before trunc_ashr_trunc_nonuniform_combined
  simp_alive_peephole
  sorry
def trunc_ashr_trunc_uniform_poison_combined := [llvmfunc|
  llvm.func @trunc_ashr_trunc_uniform_poison(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.ashr %arg0, %6  : vector<2xi64>
    %8 = llvm.trunc %7 : vector<2xi64> to vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

theorem inst_combine_trunc_ashr_trunc_uniform_poison   : trunc_ashr_trunc_uniform_poison_before  ⊑  trunc_ashr_trunc_uniform_poison_combined := by
  unfold trunc_ashr_trunc_uniform_poison_before trunc_ashr_trunc_uniform_poison_combined
  simp_alive_peephole
  sorry
def trunc_ashr_trunc_outofrange_combined := [llvmfunc|
  llvm.func @trunc_ashr_trunc_outofrange(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }]

theorem inst_combine_trunc_ashr_trunc_outofrange   : trunc_ashr_trunc_outofrange_before  ⊑  trunc_ashr_trunc_outofrange_combined := by
  unfold trunc_ashr_trunc_outofrange_before trunc_ashr_trunc_outofrange_combined
  simp_alive_peephole
  sorry
def trunc_ashr_trunc_nonuniform_outofrange_combined := [llvmfunc|
  llvm.func @trunc_ashr_trunc_nonuniform_outofrange(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 25]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_trunc_ashr_trunc_nonuniform_outofrange   : trunc_ashr_trunc_nonuniform_outofrange_before  ⊑  trunc_ashr_trunc_nonuniform_outofrange_combined := by
  unfold trunc_ashr_trunc_nonuniform_outofrange_before trunc_ashr_trunc_nonuniform_outofrange_combined
  simp_alive_peephole
  sorry
def trunc_ashr_trunc_multiuse_combined := [llvmfunc|
  llvm.func @trunc_ashr_trunc_multiuse(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i8
  }]

theorem inst_combine_trunc_ashr_trunc_multiuse   : trunc_ashr_trunc_multiuse_before  ⊑  trunc_ashr_trunc_multiuse_combined := by
  unfold trunc_ashr_trunc_multiuse_before trunc_ashr_trunc_multiuse_combined
  simp_alive_peephole
  sorry
