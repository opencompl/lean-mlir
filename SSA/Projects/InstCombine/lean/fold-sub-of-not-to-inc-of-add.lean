import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-sub-of-not-to-inc-of-add
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def p0_scalar_before := [llvmfunc|
  llvm.func @p0_scalar(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.sub %arg1, %1  : i32
    llvm.return %2 : i32
  }]

def p0_scalar_not_truly_negatable_before := [llvmfunc|
  llvm.func @p0_scalar_not_truly_negatable(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.sub %2, %3  : i8
    llvm.return %4 : i8
  }]

def p1_vector_splat_before := [llvmfunc|
  llvm.func @p1_vector_splat(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.xor %arg0, %0  : vector<4xi32>
    %2 = llvm.sub %arg1, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

def p2_vector_poison_before := [llvmfunc|
  llvm.func @p2_vector_poison(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
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
    %11 = llvm.xor %arg0, %10  : vector<4xi32>
    %12 = llvm.sub %arg1, %11  : vector<4xi32>
    llvm.return %12 : vector<4xi32>
  }]

def p3_oneuse_before := [llvmfunc|
  llvm.func @p3_oneuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.sub %arg1, %1  : i32
    llvm.return %2 : i32
  }]

def n4_before := [llvmfunc|
  llvm.func @n4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.sub %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def n5_is_not_not_before := [llvmfunc|
  llvm.func @n5_is_not_not(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.sub %arg1, %1  : i32
    llvm.return %2 : i32
  }]

def n5_is_not_not_vec_splat_before := [llvmfunc|
  llvm.func @n5_is_not_not_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.sub %arg1, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def p0_scalar_combined := [llvmfunc|
  llvm.func @p0_scalar(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_p0_scalar   : p0_scalar_before  ⊑  p0_scalar_combined := by
  unfold p0_scalar_before p0_scalar_combined
  simp_alive_peephole
  sorry
def p0_scalar_not_truly_negatable_combined := [llvmfunc|
  llvm.func @p0_scalar_not_truly_negatable(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.sub %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_p0_scalar_not_truly_negatable   : p0_scalar_not_truly_negatable_before  ⊑  p0_scalar_not_truly_negatable_combined := by
  unfold p0_scalar_not_truly_negatable_before p0_scalar_not_truly_negatable_combined
  simp_alive_peephole
  sorry
def p1_vector_splat_combined := [llvmfunc|
  llvm.func @p1_vector_splat(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0  : vector<4xi32>
    %2 = llvm.add %1, %arg1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_p1_vector_splat   : p1_vector_splat_before  ⊑  p1_vector_splat_combined := by
  unfold p1_vector_splat_before p1_vector_splat_combined
  simp_alive_peephole
  sorry
def p2_vector_poison_combined := [llvmfunc|
  llvm.func @p2_vector_poison(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0  : vector<4xi32>
    %2 = llvm.add %1, %arg1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_p2_vector_poison   : p2_vector_poison_before  ⊑  p2_vector_poison_combined := by
  unfold p2_vector_poison_before p2_vector_poison_combined
  simp_alive_peephole
  sorry
def p3_oneuse_combined := [llvmfunc|
  llvm.func @p3_oneuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.sub %arg1, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_p3_oneuse   : p3_oneuse_before  ⊑  p3_oneuse_combined := by
  unfold p3_oneuse_before p3_oneuse_combined
  simp_alive_peephole
  sorry
def n4_combined := [llvmfunc|
  llvm.func @n4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.sub %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_n4   : n4_before  ⊑  n4_combined := by
  unfold n4_before n4_combined
  simp_alive_peephole
  sorry
def n5_is_not_not_combined := [llvmfunc|
  llvm.func @n5_is_not_not(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.sub %arg1, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_n5_is_not_not   : n5_is_not_not_before  ⊑  n5_is_not_not_combined := by
  unfold n5_is_not_not_before n5_is_not_not_combined
  simp_alive_peephole
  sorry
def n5_is_not_not_vec_splat_combined := [llvmfunc|
  llvm.func @n5_is_not_not_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.sub %arg1, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_n5_is_not_not_vec_splat   : n5_is_not_not_vec_splat_before  ⊑  n5_is_not_not_vec_splat_combined := by
  unfold n5_is_not_not_vec_splat_before n5_is_not_not_vec_splat_combined
  simp_alive_peephole
  sorry
