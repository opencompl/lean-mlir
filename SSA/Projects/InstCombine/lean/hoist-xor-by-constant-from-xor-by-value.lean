import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  hoist-xor-by-constant-from-xor-by-value
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_scalar_before := [llvmfunc|
  llvm.func @t0_scalar(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def t1_splatvec_before := [llvmfunc|
  llvm.func @t1_splatvec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.xor %1, %arg1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def t2_vec_before := [llvmfunc|
  llvm.func @t2_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 24]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.xor %1, %arg1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def t3_vec_undef_before := [llvmfunc|
  llvm.func @t3_vec_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.xor %arg0, %6  : vector<2xi8>
    %8 = llvm.xor %7, %arg1  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

def t4_extrause_before := [llvmfunc|
  llvm.func @t4_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def t5_commutativity_before := [llvmfunc|
  llvm.func @t5_commutativity(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def constantexpr2_before := [llvmfunc|
  llvm.func @constantexpr2() -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.mlir.addressof @global_constant3 : !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%0, %1, %0] : (!llvm.ptr, i16, i16, i16) -> !llvm.ptr, !llvm.array<6 x array<1 x i64>>
    %4 = llvm.mlir.addressof @global_constant4 : !llvm.ptr
    %5 = llvm.mlir.addressof @global_constant5 : !llvm.ptr
    %6 = llvm.mlir.constant(-1 : i16) : i16
    %7 = llvm.icmp "ne" %3, %4 : !llvm.ptr
    %8 = llvm.zext %7 : i1 to i16
    %9 = llvm.load %5 {alignment = 1 : i64} : !llvm.ptr -> !llvm.ptr]

    %10 = llvm.load %9 {alignment = 1 : i64} : !llvm.ptr -> i16]

    %11 = llvm.xor %10, %8  : i16
    %12 = llvm.xor %11, %6  : i16
    llvm.return %12 : i16
  }]

def t0_scalar_combined := [llvmfunc|
  llvm.func @t0_scalar(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t0_scalar   : t0_scalar_before  ⊑  t0_scalar_combined := by
  unfold t0_scalar_before t0_scalar_combined
  simp_alive_peephole
  sorry
def t1_splatvec_combined := [llvmfunc|
  llvm.func @t1_splatvec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %arg1  : vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_t1_splatvec   : t1_splatvec_before  ⊑  t1_splatvec_combined := by
  unfold t1_splatvec_before t1_splatvec_combined
  simp_alive_peephole
  sorry
def t2_vec_combined := [llvmfunc|
  llvm.func @t2_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 24]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %arg1  : vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_t2_vec   : t2_vec_before  ⊑  t2_vec_combined := by
  unfold t2_vec_before t2_vec_combined
  simp_alive_peephole
  sorry
def t3_vec_undef_combined := [llvmfunc|
  llvm.func @t3_vec_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.xor %arg0, %arg1  : vector<2xi8>
    %8 = llvm.xor %7, %6  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

theorem inst_combine_t3_vec_undef   : t3_vec_undef_before  ⊑  t3_vec_undef_combined := by
  unfold t3_vec_undef_before t3_vec_undef_combined
  simp_alive_peephole
  sorry
def t4_extrause_combined := [llvmfunc|
  llvm.func @t4_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t4_extrause   : t4_extrause_before  ⊑  t4_extrause_combined := by
  unfold t4_extrause_before t4_extrause_combined
  simp_alive_peephole
  sorry
def t5_commutativity_combined := [llvmfunc|
  llvm.func @t5_commutativity(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.xor %1, %arg0  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t5_commutativity   : t5_commutativity_before  ⊑  t5_commutativity_combined := by
  unfold t5_commutativity_before t5_commutativity_combined
  simp_alive_peephole
  sorry
def constantexpr2_combined := [llvmfunc|
  llvm.func @constantexpr2() -> i16 {
    %0 = llvm.mlir.addressof @global_constant4 : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.addressof @global_constant3 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %2, %1] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.array<6 x array<1 x i64>>
    %5 = llvm.icmp "ne" %4, %0 : !llvm.ptr
    %6 = llvm.mlir.addressof @global_constant5 : !llvm.ptr
    %7 = llvm.mlir.constant(-1 : i16) : i16
    %8 = llvm.zext %5 : i1 to i16
    %9 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_constantexpr2   : constantexpr2_before  ⊑  constantexpr2_combined := by
  unfold constantexpr2_before constantexpr2_combined
  simp_alive_peephole
  sorry
    %10 = llvm.load %9 {alignment = 1 : i64} : !llvm.ptr -> i16]

theorem inst_combine_constantexpr2   : constantexpr2_before  ⊑  constantexpr2_combined := by
  unfold constantexpr2_before constantexpr2_combined
  simp_alive_peephole
  sorry
    %11 = llvm.xor %10, %8  : i16
    %12 = llvm.xor %11, %7  : i16
    llvm.return %12 : i16
  }]

theorem inst_combine_constantexpr2   : constantexpr2_before  ⊑  constantexpr2_combined := by
  unfold constantexpr2_before constantexpr2_combined
  simp_alive_peephole
  sorry
