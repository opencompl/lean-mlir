import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  or-concat
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def concat_bswap32_unary_split_before := [llvmfunc|
  llvm.func @concat_bswap32_unary_split(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.intr.bswap(%2)  : (i32) -> i32
    %5 = llvm.intr.bswap(%3)  : (i32) -> i32
    %6 = llvm.zext %4 : i32 to i64
    %7 = llvm.zext %5 : i32 to i64
    %8 = llvm.shl %7, %0 overflow<nuw>  : i64
    %9 = llvm.or %6, %8  : i64
    llvm.return %9 : i64
  }]

def concat_bswap32_unary_split_vector_before := [llvmfunc|
  llvm.func @concat_bswap32_unary_split_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %4 = llvm.intr.bswap(%2)  : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.intr.bswap(%3)  : (vector<2xi32>) -> vector<2xi32>
    %6 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    %7 = llvm.zext %5 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %7, %0 overflow<nuw>  : vector<2xi64>
    %9 = llvm.or %6, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }]

def concat_bswap32_unary_flip_before := [llvmfunc|
  llvm.func @concat_bswap32_unary_flip(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.intr.bswap(%2)  : (i32) -> i32
    %5 = llvm.intr.bswap(%3)  : (i32) -> i32
    %6 = llvm.zext %4 : i32 to i64
    %7 = llvm.zext %5 : i32 to i64
    %8 = llvm.shl %6, %0 overflow<nuw>  : i64
    %9 = llvm.or %7, %8  : i64
    llvm.return %9 : i64
  }]

def concat_bswap32_unary_flip_vector_before := [llvmfunc|
  llvm.func @concat_bswap32_unary_flip_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %4 = llvm.intr.bswap(%2)  : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.intr.bswap(%3)  : (vector<2xi32>) -> vector<2xi32>
    %6 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    %7 = llvm.zext %5 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %6, %0 overflow<nuw>  : vector<2xi64>
    %9 = llvm.or %7, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }]

def concat_bswap32_binary_before := [llvmfunc|
  llvm.func @concat_bswap32_binary(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %2 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %3 = llvm.zext %1 : i32 to i64
    %4 = llvm.zext %2 : i32 to i64
    %5 = llvm.shl %4, %0 overflow<nuw>  : i64
    %6 = llvm.or %3, %5  : i64
    llvm.return %6 : i64
  }]

def concat_bswap32_binary_vector_before := [llvmfunc|
  llvm.func @concat_bswap32_binary_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.zext %1 : vector<2xi32> to vector<2xi64>
    %4 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %5 = llvm.shl %4, %0 overflow<nuw>  : vector<2xi64>
    %6 = llvm.or %3, %5  : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

def concat_bitreverse32_unary_split_before := [llvmfunc|
  llvm.func @concat_bitreverse32_unary_split(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.intr.bitreverse(%2)  : (i32) -> i32
    %5 = llvm.intr.bitreverse(%3)  : (i32) -> i32
    %6 = llvm.zext %4 : i32 to i64
    %7 = llvm.zext %5 : i32 to i64
    %8 = llvm.shl %7, %0 overflow<nuw>  : i64
    %9 = llvm.or %6, %8  : i64
    llvm.return %9 : i64
  }]

def concat_bitreverse32_unary_split_vector_before := [llvmfunc|
  llvm.func @concat_bitreverse32_unary_split_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %4 = llvm.intr.bitreverse(%2)  : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.intr.bitreverse(%3)  : (vector<2xi32>) -> vector<2xi32>
    %6 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    %7 = llvm.zext %5 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %7, %0 overflow<nuw>  : vector<2xi64>
    %9 = llvm.or %6, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }]

def concat_bitreverse32_unary_flip_before := [llvmfunc|
  llvm.func @concat_bitreverse32_unary_flip(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.intr.bitreverse(%2)  : (i32) -> i32
    %5 = llvm.intr.bitreverse(%3)  : (i32) -> i32
    %6 = llvm.zext %4 : i32 to i64
    %7 = llvm.zext %5 : i32 to i64
    %8 = llvm.shl %6, %0 overflow<nuw>  : i64
    %9 = llvm.or %7, %8  : i64
    llvm.return %9 : i64
  }]

def concat_bitreverse32_unary_flip_vector_before := [llvmfunc|
  llvm.func @concat_bitreverse32_unary_flip_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    %3 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %4 = llvm.intr.bitreverse(%2)  : (vector<2xi32>) -> vector<2xi32>
    %5 = llvm.intr.bitreverse(%3)  : (vector<2xi32>) -> vector<2xi32>
    %6 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    %7 = llvm.zext %5 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %6, %0 overflow<nuw>  : vector<2xi64>
    %9 = llvm.or %7, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }]

def concat_bitreverse32_binary_before := [llvmfunc|
  llvm.func @concat_bitreverse32_binary(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %2 = llvm.intr.bitreverse(%arg1)  : (i32) -> i32
    %3 = llvm.zext %1 : i32 to i64
    %4 = llvm.zext %2 : i32 to i64
    %5 = llvm.shl %4, %0 overflow<nuw>  : i64
    %6 = llvm.or %3, %5  : i64
    llvm.return %6 : i64
  }]

def concat_bitreverse32_binary_vector_before := [llvmfunc|
  llvm.func @concat_bitreverse32_binary_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.intr.bitreverse(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.intr.bitreverse(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.zext %1 : vector<2xi32> to vector<2xi64>
    %4 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %5 = llvm.shl %4, %0 overflow<nuw>  : vector<2xi64>
    %6 = llvm.or %3, %5  : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

def concat_bswap32_unary_split_combined := [llvmfunc|
  llvm.func @concat_bswap32_unary_split(%arg0: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_concat_bswap32_unary_split   : concat_bswap32_unary_split_before  ⊑  concat_bswap32_unary_split_combined := by
  unfold concat_bswap32_unary_split_before concat_bswap32_unary_split_combined
  simp_alive_peephole
  sorry
def concat_bswap32_unary_split_vector_combined := [llvmfunc|
  llvm.func @concat_bswap32_unary_split_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_concat_bswap32_unary_split_vector   : concat_bswap32_unary_split_vector_before  ⊑  concat_bswap32_unary_split_vector_combined := by
  unfold concat_bswap32_unary_split_vector_before concat_bswap32_unary_split_vector_combined
  simp_alive_peephole
  sorry
def concat_bswap32_unary_flip_combined := [llvmfunc|
  llvm.func @concat_bswap32_unary_flip(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i64, i64, i64) -> i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_concat_bswap32_unary_flip   : concat_bswap32_unary_flip_before  ⊑  concat_bswap32_unary_flip_combined := by
  unfold concat_bswap32_unary_flip_before concat_bswap32_unary_flip_combined
  simp_alive_peephole
  sorry
def concat_bswap32_unary_flip_vector_combined := [llvmfunc|
  llvm.func @concat_bswap32_unary_flip_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (vector<2xi64>, vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_concat_bswap32_unary_flip_vector   : concat_bswap32_unary_flip_vector_before  ⊑  concat_bswap32_unary_flip_vector_combined := by
  unfold concat_bswap32_unary_flip_vector_before concat_bswap32_unary_flip_vector_combined
  simp_alive_peephole
  sorry
def concat_bswap32_binary_combined := [llvmfunc|
  llvm.func @concat_bswap32_binary(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.shl %2, %0 overflow<nuw>  : i64
    %4 = llvm.or %3, %1  : i64
    %5 = llvm.intr.bswap(%4)  : (i64) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_concat_bswap32_binary   : concat_bswap32_binary_before  ⊑  concat_bswap32_binary_combined := by
  unfold concat_bswap32_binary_before concat_bswap32_binary_combined
  simp_alive_peephole
  sorry
def concat_bswap32_binary_vector_combined := [llvmfunc|
  llvm.func @concat_bswap32_binary_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.zext %arg1 : vector<2xi32> to vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.shl %2, %0 overflow<nuw>  : vector<2xi64>
    %4 = llvm.or %3, %1  : vector<2xi64>
    %5 = llvm.intr.bswap(%4)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }]

theorem inst_combine_concat_bswap32_binary_vector   : concat_bswap32_binary_vector_before  ⊑  concat_bswap32_binary_vector_combined := by
  unfold concat_bswap32_binary_vector_before concat_bswap32_binary_vector_combined
  simp_alive_peephole
  sorry
def concat_bitreverse32_unary_split_combined := [llvmfunc|
  llvm.func @concat_bitreverse32_unary_split(%arg0: i64) -> i64 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_concat_bitreverse32_unary_split   : concat_bitreverse32_unary_split_before  ⊑  concat_bitreverse32_unary_split_combined := by
  unfold concat_bitreverse32_unary_split_before concat_bitreverse32_unary_split_combined
  simp_alive_peephole
  sorry
def concat_bitreverse32_unary_split_vector_combined := [llvmfunc|
  llvm.func @concat_bitreverse32_unary_split_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.bitreverse(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_concat_bitreverse32_unary_split_vector   : concat_bitreverse32_unary_split_vector_before  ⊑  concat_bitreverse32_unary_split_vector_combined := by
  unfold concat_bitreverse32_unary_split_vector_before concat_bitreverse32_unary_split_vector_combined
  simp_alive_peephole
  sorry
def concat_bitreverse32_unary_flip_combined := [llvmfunc|
  llvm.func @concat_bitreverse32_unary_flip(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i64, i64, i64) -> i64
    %2 = llvm.intr.bitreverse(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_concat_bitreverse32_unary_flip   : concat_bitreverse32_unary_flip_before  ⊑  concat_bitreverse32_unary_flip_combined := by
  unfold concat_bitreverse32_unary_flip_before concat_bitreverse32_unary_flip_combined
  simp_alive_peephole
  sorry
def concat_bitreverse32_unary_flip_vector_combined := [llvmfunc|
  llvm.func @concat_bitreverse32_unary_flip_vector(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (vector<2xi64>, vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %2 = llvm.intr.bitreverse(%1)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_concat_bitreverse32_unary_flip_vector   : concat_bitreverse32_unary_flip_vector_before  ⊑  concat_bitreverse32_unary_flip_vector_combined := by
  unfold concat_bitreverse32_unary_flip_vector_before concat_bitreverse32_unary_flip_vector_combined
  simp_alive_peephole
  sorry
def concat_bitreverse32_binary_combined := [llvmfunc|
  llvm.func @concat_bitreverse32_binary(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.shl %2, %0 overflow<nuw>  : i64
    %4 = llvm.or %3, %1  : i64
    %5 = llvm.intr.bitreverse(%4)  : (i64) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_concat_bitreverse32_binary   : concat_bitreverse32_binary_before  ⊑  concat_bitreverse32_binary_combined := by
  unfold concat_bitreverse32_binary_before concat_bitreverse32_binary_combined
  simp_alive_peephole
  sorry
def concat_bitreverse32_binary_vector_combined := [llvmfunc|
  llvm.func @concat_bitreverse32_binary_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.zext %arg1 : vector<2xi32> to vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.shl %2, %0 overflow<nuw>  : vector<2xi64>
    %4 = llvm.or %3, %1  : vector<2xi64>
    %5 = llvm.intr.bitreverse(%4)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }]

theorem inst_combine_concat_bitreverse32_binary_vector   : concat_bitreverse32_binary_vector_before  ⊑  concat_bitreverse32_binary_vector_combined := by
  unfold concat_bitreverse32_binary_vector_before concat_bitreverse32_binary_vector_combined
  simp_alive_peephole
  sorry
