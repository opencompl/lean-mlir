import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bitcast-inselt-bitcast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def insert0_v2i8_before := [llvmfunc|
  llvm.func @insert0_v2i8(%arg0: i16, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i16 to vector<2xi8>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to i16
    llvm.return %3 : i16
  }]

def insert1_v2i8_before := [llvmfunc|
  llvm.func @insert1_v2i8(%arg0: i16, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i16 to vector<2xi8>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to i16
    llvm.return %3 : i16
  }]

def insert0_v4i8_before := [llvmfunc|
  llvm.func @insert0_v4i8(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<4xi8>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<4xi8>
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    llvm.return %3 : i32
  }]

def insert0_v2half_before := [llvmfunc|
  llvm.func @insert0_v2half(%arg0: i32, %arg1: f16) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<2xf16>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<2xf16>
    %3 = llvm.bitcast %2 : vector<2xf16> to i32
    llvm.return %3 : i32
  }]

def insert0_v4i16_before := [llvmfunc|
  llvm.func @insert0_v4i16(%arg0: i64, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i64 to vector<4xi16>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<4xi16>
    %3 = llvm.bitcast %2 : vector<4xi16> to i64
    llvm.return %3 : i64
  }]

def insert1_v4i16_before := [llvmfunc|
  llvm.func @insert1_v4i16(%arg0: i64, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i64 to vector<4xi16>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<4xi16>
    %3 = llvm.bitcast %2 : vector<4xi16> to i64
    llvm.return %3 : i64
  }]

def insert3_v4i16_before := [llvmfunc|
  llvm.func @insert3_v4i16(%arg0: i64, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.bitcast %arg0 : i64 to vector<4xi16>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<4xi16>
    %3 = llvm.bitcast %2 : vector<4xi16> to i64
    llvm.return %3 : i64
  }]

def insert0_v4i32_before := [llvmfunc|
  llvm.func @insert0_v4i32(%arg0: i128, %arg1: i32) -> i128 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i128 to vector<4xi32>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<4xi32>
    %3 = llvm.bitcast %2 : vector<4xi32> to i128
    llvm.return %3 : i128
  }]

def insert0_v2i8_use1_before := [llvmfunc|
  llvm.func @insert0_v2i8_use1(%arg0: i16, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i16 to vector<2xi8>
    llvm.call @use(%1) : (vector<2xi8>) -> ()
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to i16
    llvm.return %3 : i16
  }]

def insert0_v2i8_use2_before := [llvmfunc|
  llvm.func @insert0_v2i8_use2(%arg0: i16, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i16 to vector<2xi8>
    %2 = llvm.insertelement %arg1, %1[%0 : i8] : vector<2xi8>
    llvm.call @use(%2) : (vector<2xi8>) -> ()
    %3 = llvm.bitcast %2 : vector<2xi8> to i16
    llvm.return %3 : i16
  }]

def insert0_v2i8_combined := [llvmfunc|
  llvm.func @insert0_v2i8(%arg0: i16, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : i16 to vector<2xi8>
    %2 = llvm.insertelement %arg1, %1[%0 : i64] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_insert0_v2i8   : insert0_v2i8_before  ⊑  insert0_v2i8_combined := by
  unfold insert0_v2i8_before insert0_v2i8_combined
  simp_alive_peephole
  sorry
def insert1_v2i8_combined := [llvmfunc|
  llvm.func @insert1_v2i8(%arg0: i16, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(-256 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.zext %arg1 : i8 to i16
    %3 = llvm.or %1, %2  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_insert1_v2i8   : insert1_v2i8_before  ⊑  insert1_v2i8_combined := by
  unfold insert1_v2i8_before insert1_v2i8_combined
  simp_alive_peephole
  sorry
def insert0_v4i8_combined := [llvmfunc|
  llvm.func @insert0_v4i8(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : i32 to vector<4xi8>
    %2 = llvm.insertelement %arg1, %1[%0 : i64] : vector<4xi8>
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_insert0_v4i8   : insert0_v4i8_before  ⊑  insert0_v4i8_combined := by
  unfold insert0_v4i8_before insert0_v4i8_combined
  simp_alive_peephole
  sorry
def insert0_v2half_combined := [llvmfunc|
  llvm.func @insert0_v2half(%arg0: i32, %arg1: f16) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : i32 to vector<2xf16>
    %2 = llvm.insertelement %arg1, %1[%0 : i64] : vector<2xf16>
    %3 = llvm.bitcast %2 : vector<2xf16> to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_insert0_v2half   : insert0_v2half_before  ⊑  insert0_v2half_combined := by
  unfold insert0_v2half_before insert0_v2half_combined
  simp_alive_peephole
  sorry
def insert0_v4i16_combined := [llvmfunc|
  llvm.func @insert0_v4i16(%arg0: i64, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : i64 to vector<4xi16>
    %2 = llvm.insertelement %arg1, %1[%0 : i64] : vector<4xi16>
    %3 = llvm.bitcast %2 : vector<4xi16> to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_insert0_v4i16   : insert0_v4i16_before  ⊑  insert0_v4i16_combined := by
  unfold insert0_v4i16_before insert0_v4i16_combined
  simp_alive_peephole
  sorry
def insert1_v4i16_combined := [llvmfunc|
  llvm.func @insert1_v4i16(%arg0: i64, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.bitcast %arg0 : i64 to vector<4xi16>
    %2 = llvm.insertelement %arg1, %1[%0 : i64] : vector<4xi16>
    %3 = llvm.bitcast %2 : vector<4xi16> to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_insert1_v4i16   : insert1_v4i16_before  ⊑  insert1_v4i16_combined := by
  unfold insert1_v4i16_before insert1_v4i16_combined
  simp_alive_peephole
  sorry
def insert3_v4i16_combined := [llvmfunc|
  llvm.func @insert3_v4i16(%arg0: i64, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(-65536 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.zext %arg1 : i16 to i64
    %3 = llvm.or %1, %2  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_insert3_v4i16   : insert3_v4i16_before  ⊑  insert3_v4i16_combined := by
  unfold insert3_v4i16_before insert3_v4i16_combined
  simp_alive_peephole
  sorry
def insert0_v4i32_combined := [llvmfunc|
  llvm.func @insert0_v4i32(%arg0: i128, %arg1: i32) -> i128 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : i128 to vector<4xi32>
    %2 = llvm.insertelement %arg1, %1[%0 : i64] : vector<4xi32>
    %3 = llvm.bitcast %2 : vector<4xi32> to i128
    llvm.return %3 : i128
  }]

theorem inst_combine_insert0_v4i32   : insert0_v4i32_before  ⊑  insert0_v4i32_combined := by
  unfold insert0_v4i32_before insert0_v4i32_combined
  simp_alive_peephole
  sorry
def insert0_v2i8_use1_combined := [llvmfunc|
  llvm.func @insert0_v2i8_use1(%arg0: i16, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : i16 to vector<2xi8>
    llvm.call @use(%1) : (vector<2xi8>) -> ()
    %2 = llvm.insertelement %arg1, %1[%0 : i64] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_insert0_v2i8_use1   : insert0_v2i8_use1_before  ⊑  insert0_v2i8_use1_combined := by
  unfold insert0_v2i8_use1_before insert0_v2i8_use1_combined
  simp_alive_peephole
  sorry
def insert0_v2i8_use2_combined := [llvmfunc|
  llvm.func @insert0_v2i8_use2(%arg0: i16, %arg1: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : i16 to vector<2xi8>
    %2 = llvm.insertelement %arg1, %1[%0 : i64] : vector<2xi8>
    llvm.call @use(%2) : (vector<2xi8>) -> ()
    %3 = llvm.bitcast %2 : vector<2xi8> to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_insert0_v2i8_use2   : insert0_v2i8_use2_before  ⊑  insert0_v2i8_use2_combined := by
  unfold insert0_v2i8_use2_before insert0_v2i8_use2_combined
  simp_alive_peephole
  sorry
