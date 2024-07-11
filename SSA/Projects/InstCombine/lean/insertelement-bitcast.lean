import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  insertelement-bitcast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bitcast_inselt_before := [llvmfunc|
  llvm.func @bitcast_inselt(%arg0: i32, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    %3 = llvm.insertelement %1, %2[%0 : i32] : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

def bitcast_inselt_use1_before := [llvmfunc|
  llvm.func @bitcast_inselt_use1(%arg0: i32, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.bitcast %arg0 : i32 to f32
    llvm.call @use_f32(%1) : (f32) -> ()
    %2 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    %3 = llvm.insertelement %1, %2[%0 : i32] : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

def bitcast_inselt_use2_before := [llvmfunc|
  llvm.func @bitcast_inselt_use2(%arg0: i32, %arg1: vector<4xi32>, %arg2: i32) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : i32 to f32
    %1 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    llvm.call @use_v4f32(%1) : (vector<4xf32>) -> ()
    %2 = llvm.insertelement %0, %1[%arg2 : i32] : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }]

def bitcast_inselt_use3_before := [llvmfunc|
  llvm.func @bitcast_inselt_use3(%arg0: i32, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : i32 to f32
    llvm.call @use_f32(%1) : (f32) -> ()
    %2 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    llvm.call @use_v4f32(%2) : (vector<4xf32>) -> ()
    %3 = llvm.insertelement %1, %2[%0 : i32] : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

def bitcast_inselt_wrong_bitcast1_before := [llvmfunc|
  llvm.func @bitcast_inselt_wrong_bitcast1(%arg0: i32, %arg1: i64) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.bitcast %arg1 : i64 to vector<2xf32>
    %3 = llvm.insertelement %1, %2[%0 : i32] : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def bitcast_inselt_wrong_bitcast2_before := [llvmfunc|
  llvm.func @bitcast_inselt_wrong_bitcast2(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : vector<2xi16> to f32
    %2 = llvm.bitcast %arg1 : vector<2xi32> to vector<2xf32>
    %3 = llvm.insertelement %1, %2[%0 : i32] : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def bitcast_inselt_combined := [llvmfunc|
  llvm.func @bitcast_inselt(%arg0: i32, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.insertelement %arg0, %arg1[%0 : i64] : vector<4xi32>
    %2 = llvm.bitcast %1 : vector<4xi32> to vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_bitcast_inselt   : bitcast_inselt_before  ⊑  bitcast_inselt_combined := by
  unfold bitcast_inselt_before bitcast_inselt_combined
  simp_alive_peephole
  sorry
def bitcast_inselt_use1_combined := [llvmfunc|
  llvm.func @bitcast_inselt_use1(%arg0: i32, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.bitcast %arg0 : i32 to f32
    llvm.call @use_f32(%1) : (f32) -> ()
    %2 = llvm.insertelement %arg0, %arg1[%0 : i64] : vector<4xi32>
    %3 = llvm.bitcast %2 : vector<4xi32> to vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_bitcast_inselt_use1   : bitcast_inselt_use1_before  ⊑  bitcast_inselt_use1_combined := by
  unfold bitcast_inselt_use1_before bitcast_inselt_use1_combined
  simp_alive_peephole
  sorry
def bitcast_inselt_use2_combined := [llvmfunc|
  llvm.func @bitcast_inselt_use2(%arg0: i32, %arg1: vector<4xi32>, %arg2: i32) -> vector<4xf32> {
    %0 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    llvm.call @use_v4f32(%0) : (vector<4xf32>) -> ()
    %1 = llvm.insertelement %arg0, %arg1[%arg2 : i32] : vector<4xi32>
    %2 = llvm.bitcast %1 : vector<4xi32> to vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_bitcast_inselt_use2   : bitcast_inselt_use2_before  ⊑  bitcast_inselt_use2_combined := by
  unfold bitcast_inselt_use2_before bitcast_inselt_use2_combined
  simp_alive_peephole
  sorry
def bitcast_inselt_use3_combined := [llvmfunc|
  llvm.func @bitcast_inselt_use3(%arg0: i32, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : i32 to f32
    llvm.call @use_f32(%1) : (f32) -> ()
    %2 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    llvm.call @use_v4f32(%2) : (vector<4xf32>) -> ()
    %3 = llvm.insertelement %1, %2[%0 : i64] : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_bitcast_inselt_use3   : bitcast_inselt_use3_before  ⊑  bitcast_inselt_use3_combined := by
  unfold bitcast_inselt_use3_before bitcast_inselt_use3_combined
  simp_alive_peephole
  sorry
def bitcast_inselt_wrong_bitcast1_combined := [llvmfunc|
  llvm.func @bitcast_inselt_wrong_bitcast1(%arg0: i32, %arg1: i64) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.bitcast %arg1 : i64 to vector<2xf32>
    %3 = llvm.insertelement %1, %2[%0 : i64] : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

theorem inst_combine_bitcast_inselt_wrong_bitcast1   : bitcast_inselt_wrong_bitcast1_before  ⊑  bitcast_inselt_wrong_bitcast1_combined := by
  unfold bitcast_inselt_wrong_bitcast1_before bitcast_inselt_wrong_bitcast1_combined
  simp_alive_peephole
  sorry
def bitcast_inselt_wrong_bitcast2_combined := [llvmfunc|
  llvm.func @bitcast_inselt_wrong_bitcast2(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xi16> to f32
    %2 = llvm.bitcast %arg1 : vector<2xi32> to vector<2xf32>
    %3 = llvm.insertelement %1, %2[%0 : i64] : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

theorem inst_combine_bitcast_inselt_wrong_bitcast2   : bitcast_inselt_wrong_bitcast2_before  ⊑  bitcast_inselt_wrong_bitcast2_combined := by
  unfold bitcast_inselt_wrong_bitcast2_before bitcast_inselt_wrong_bitcast2_combined
  simp_alive_peephole
  sorry
