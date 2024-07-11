import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  insertelt-trunc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def insert_01_poison_v4i16_before := [llvmfunc|
  llvm.func @insert_01_poison_v4i16(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }]

def insert_10_poison_v8i16_before := [llvmfunc|
  llvm.func @insert_10_poison_v8i16(%arg0: i32) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<8xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<8xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<8xi16>
    llvm.return %8 : vector<8xi16>
  }]

def insert_12_poison_v4i32_before := [llvmfunc|
  llvm.func @insert_12_poison_v4i32(%arg0: i64) -> vector<4xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi32>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi32>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }]

def insert_21_poison_v4i16_before := [llvmfunc|
  llvm.func @insert_21_poison_v4i16(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }]

def insert_23_poison_v4i32_before := [llvmfunc|
  llvm.func @insert_23_poison_v4i32(%arg0: i64) -> vector<4xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi32>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi32>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }]

def insert_32_poison_v4i16_before := [llvmfunc|
  llvm.func @insert_32_poison_v4i16(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }]

def insert_01_v2i16_before := [llvmfunc|
  llvm.func @insert_01_v2i16(%arg0: i32, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<2xi16>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }]

def insert_10_v8i16_before := [llvmfunc|
  llvm.func @insert_10_v8i16(%arg0: i32, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<8xi16>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }]

def insert_12_v4i32_before := [llvmfunc|
  llvm.func @insert_12_v4i32(%arg0: i64, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.trunc %arg0 : i64 to i32
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<4xi32>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

def insert_21_v4i16_before := [llvmfunc|
  llvm.func @insert_21_v4i16(%arg0: i32, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<4xi16>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<4xi16>
    llvm.return %7 : vector<4xi16>
  }]

def insert_23_v4i32_before := [llvmfunc|
  llvm.func @insert_23_v4i32(%arg0: i64, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.trunc %arg0 : i64 to i32
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<4xi32>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

def insert_32_v4i16_before := [llvmfunc|
  llvm.func @insert_32_v4i16(%arg0: i32, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<4xi16>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<4xi16>
    llvm.return %7 : vector<4xi16>
  }]

def insert_01_v4i16_wrong_shift1_before := [llvmfunc|
  llvm.func @insert_01_v4i16_wrong_shift1(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }]

def insert_01_v4i16_wrong_op_before := [llvmfunc|
  llvm.func @insert_01_v4i16_wrong_op(%arg0: i32, %arg1: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg1 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }]

def insert_67_v4i16_uses1_before := [llvmfunc|
  llvm.func @insert_67_v4i16_uses1(%arg0: i32, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    llvm.call @use(%4) : (i16) -> ()
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<8xi16>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }]

def insert_76_v4i16_uses2_before := [llvmfunc|
  llvm.func @insert_76_v4i16_uses2(%arg0: i32, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    llvm.call @use(%5) : (i16) -> ()
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<8xi16>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }]

def insert_67_v4i16_uses3_before := [llvmfunc|
  llvm.func @insert_67_v4i16_uses3(%arg0: i32, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<8xi16>
    llvm.call @use_vec(%6) : (vector<8xi16>) -> ()
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }]

def insert_01_poison_v4i16_high_first_before := [llvmfunc|
  llvm.func @insert_01_poison_v4i16_high_first(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %5, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %6, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }]

def insert_01_poison_v4i16_combined := [llvmfunc|
  llvm.func @insert_01_poison_v4i16(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }]

theorem inst_combine_insert_01_poison_v4i16   : insert_01_poison_v4i16_before  ⊑  insert_01_poison_v4i16_combined := by
  unfold insert_01_poison_v4i16_before insert_01_poison_v4i16_combined
  simp_alive_peephole
  sorry
def insert_10_poison_v8i16_combined := [llvmfunc|
  llvm.func @insert_10_poison_v8i16(%arg0: i32) -> vector<8xi16> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xi32>
    %3 = llvm.bitcast %2 : vector<4xi32> to vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }]

theorem inst_combine_insert_10_poison_v8i16   : insert_10_poison_v8i16_before  ⊑  insert_10_poison_v8i16_combined := by
  unfold insert_10_poison_v8i16_before insert_10_poison_v8i16_combined
  simp_alive_peephole
  sorry
def insert_12_poison_v4i32_combined := [llvmfunc|
  llvm.func @insert_12_poison_v4i32(%arg0: i64) -> vector<4xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi32>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi32>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }]

theorem inst_combine_insert_12_poison_v4i32   : insert_12_poison_v4i32_before  ⊑  insert_12_poison_v4i32_combined := by
  unfold insert_12_poison_v4i32_before insert_12_poison_v4i32_combined
  simp_alive_peephole
  sorry
def insert_21_poison_v4i16_combined := [llvmfunc|
  llvm.func @insert_21_poison_v4i16(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %5, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %6, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }]

theorem inst_combine_insert_21_poison_v4i16   : insert_21_poison_v4i16_before  ⊑  insert_21_poison_v4i16_combined := by
  unfold insert_21_poison_v4i16_before insert_21_poison_v4i16_combined
  simp_alive_peephole
  sorry
def insert_23_poison_v4i32_combined := [llvmfunc|
  llvm.func @insert_23_poison_v4i32(%arg0: i64) -> vector<4xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi32>
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.trunc %arg0 : i64 to i32
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi32>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }]

theorem inst_combine_insert_23_poison_v4i32   : insert_23_poison_v4i32_before  ⊑  insert_23_poison_v4i32_combined := by
  unfold insert_23_poison_v4i32_before insert_23_poison_v4i32_combined
  simp_alive_peephole
  sorry
def insert_32_poison_v4i16_combined := [llvmfunc|
  llvm.func @insert_32_poison_v4i16(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi32>
    %3 = llvm.bitcast %2 : vector<2xi32> to vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }]

theorem inst_combine_insert_32_poison_v4i16   : insert_32_poison_v4i16_before  ⊑  insert_32_poison_v4i16_combined := by
  unfold insert_32_poison_v4i16_before insert_32_poison_v4i16_combined
  simp_alive_peephole
  sorry
def insert_01_v2i16_combined := [llvmfunc|
  llvm.func @insert_01_v2i16(%arg0: i32, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<2xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<2xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<2xi16>
    llvm.return %8 : vector<2xi16>
  }]

theorem inst_combine_insert_01_v2i16   : insert_01_v2i16_before  ⊑  insert_01_v2i16_combined := by
  unfold insert_01_v2i16_before insert_01_v2i16_combined
  simp_alive_peephole
  sorry
def insert_10_v8i16_combined := [llvmfunc|
  llvm.func @insert_10_v8i16(%arg0: i32, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %4, %arg1[%1 : i64] : vector<8xi16>
    %7 = llvm.insertelement %5, %6[%2 : i64] : vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }]

theorem inst_combine_insert_10_v8i16   : insert_10_v8i16_before  ⊑  insert_10_v8i16_combined := by
  unfold insert_10_v8i16_before insert_10_v8i16_combined
  simp_alive_peephole
  sorry
def insert_12_v4i32_combined := [llvmfunc|
  llvm.func @insert_12_v4i32(%arg0: i64, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.trunc %arg0 : i64 to i32
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<4xi32>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

theorem inst_combine_insert_12_v4i32   : insert_12_v4i32_before  ⊑  insert_12_v4i32_combined := by
  unfold insert_12_v4i32_before insert_12_v4i32_combined
  simp_alive_peephole
  sorry
def insert_21_v4i16_combined := [llvmfunc|
  llvm.func @insert_21_v4i16(%arg0: i32, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %4, %arg1[%1 : i64] : vector<4xi16>
    %7 = llvm.insertelement %5, %6[%2 : i64] : vector<4xi16>
    llvm.return %7 : vector<4xi16>
  }]

theorem inst_combine_insert_21_v4i16   : insert_21_v4i16_before  ⊑  insert_21_v4i16_combined := by
  unfold insert_21_v4i16_before insert_21_v4i16_combined
  simp_alive_peephole
  sorry
def insert_23_v4i32_combined := [llvmfunc|
  llvm.func @insert_23_v4i32(%arg0: i64, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.trunc %arg0 : i64 to i32
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<4xi32>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

theorem inst_combine_insert_23_v4i32   : insert_23_v4i32_before  ⊑  insert_23_v4i32_combined := by
  unfold insert_23_v4i32_before insert_23_v4i32_combined
  simp_alive_peephole
  sorry
def insert_32_v4i16_combined := [llvmfunc|
  llvm.func @insert_32_v4i16(%arg0: i32, %arg1: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %4, %arg1[%1 : i64] : vector<4xi16>
    %7 = llvm.insertelement %5, %6[%2 : i64] : vector<4xi16>
    llvm.return %7 : vector<4xi16>
  }]

theorem inst_combine_insert_32_v4i16   : insert_32_v4i16_before  ⊑  insert_32_v4i16_combined := by
  unfold insert_32_v4i16_before insert_32_v4i16_combined
  simp_alive_peephole
  sorry
def insert_01_v4i16_wrong_shift1_combined := [llvmfunc|
  llvm.func @insert_01_v4i16_wrong_shift1(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }]

theorem inst_combine_insert_01_v4i16_wrong_shift1   : insert_01_v4i16_wrong_shift1_before  ⊑  insert_01_v4i16_wrong_shift1_combined := by
  unfold insert_01_v4i16_wrong_shift1_before insert_01_v4i16_wrong_shift1_combined
  simp_alive_peephole
  sorry
def insert_01_v4i16_wrong_op_combined := [llvmfunc|
  llvm.func @insert_01_v4i16_wrong_op(%arg0: i32, %arg1: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg1 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }]

theorem inst_combine_insert_01_v4i16_wrong_op   : insert_01_v4i16_wrong_op_before  ⊑  insert_01_v4i16_wrong_op_combined := by
  unfold insert_01_v4i16_wrong_op_before insert_01_v4i16_wrong_op_combined
  simp_alive_peephole
  sorry
def insert_67_v4i16_uses1_combined := [llvmfunc|
  llvm.func @insert_67_v4i16_uses1(%arg0: i32, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    llvm.call @use(%4) : (i16) -> ()
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<8xi16>
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }]

theorem inst_combine_insert_67_v4i16_uses1   : insert_67_v4i16_uses1_before  ⊑  insert_67_v4i16_uses1_combined := by
  unfold insert_67_v4i16_uses1_before insert_67_v4i16_uses1_combined
  simp_alive_peephole
  sorry
def insert_76_v4i16_uses2_combined := [llvmfunc|
  llvm.func @insert_76_v4i16_uses2(%arg0: i32, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    llvm.call @use(%5) : (i16) -> ()
    %6 = llvm.insertelement %4, %arg1[%1 : i64] : vector<8xi16>
    %7 = llvm.insertelement %5, %6[%2 : i64] : vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }]

theorem inst_combine_insert_76_v4i16_uses2   : insert_76_v4i16_uses2_before  ⊑  insert_76_v4i16_uses2_combined := by
  unfold insert_76_v4i16_uses2_before insert_76_v4i16_uses2_combined
  simp_alive_peephole
  sorry
def insert_67_v4i16_uses3_combined := [llvmfunc|
  llvm.func @insert_67_v4i16_uses3(%arg0: i32, %arg1: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.insertelement %5, %arg1[%1 : i64] : vector<8xi16>
    llvm.call @use_vec(%6) : (vector<8xi16>) -> ()
    %7 = llvm.insertelement %4, %6[%2 : i64] : vector<8xi16>
    llvm.return %7 : vector<8xi16>
  }]

theorem inst_combine_insert_67_v4i16_uses3   : insert_67_v4i16_uses3_before  ⊑  insert_67_v4i16_uses3_combined := by
  unfold insert_67_v4i16_uses3_before insert_67_v4i16_uses3_combined
  simp_alive_peephole
  sorry
def insert_01_poison_v4i16_high_first_combined := [llvmfunc|
  llvm.func @insert_01_poison_v4i16_high_first(%arg0: i32) -> vector<4xi16> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.insertelement %6, %1[%2 : i64] : vector<4xi16>
    %8 = llvm.insertelement %5, %7[%3 : i64] : vector<4xi16>
    llvm.return %8 : vector<4xi16>
  }]

theorem inst_combine_insert_01_poison_v4i16_high_first   : insert_01_poison_v4i16_high_first_before  ⊑  insert_01_poison_v4i16_high_first_combined := by
  unfold insert_01_poison_v4i16_high_first_before insert_01_poison_v4i16_high_first_combined
  simp_alive_peephole
  sorry
