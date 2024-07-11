import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bitcast-bitcast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bitcast_bitcast_s_s_s_before := [llvmfunc|
  llvm.func @bitcast_bitcast_s_s_s(%arg0: i128) -> !llvm.ppc_fp128 {
    %0 = llvm.bitcast %arg0 : i128 to f128
    %1 = llvm.bitcast %0 : f128 to !llvm.ppc_fp128
    llvm.return %1 : !llvm.ppc_fp128
  }]

def bitcast_bitcast_s_s_v_before := [llvmfunc|
  llvm.func @bitcast_bitcast_s_s_v(%arg0: i64) -> vector<2xi32> {
    %0 = llvm.bitcast %arg0 : i64 to f64
    %1 = llvm.bitcast %0 : f64 to vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def bitcast_bitcast_s_v_s_before := [llvmfunc|
  llvm.func @bitcast_bitcast_s_v_s(%arg0: i64) -> f64 {
    %0 = llvm.bitcast %arg0 : i64 to vector<2xi32>
    %1 = llvm.bitcast %0 : vector<2xi32> to f64
    llvm.return %1 : f64
  }]

def bitcast_bitcast_s_v_v_before := [llvmfunc|
  llvm.func @bitcast_bitcast_s_v_v(%arg0: i64) -> vector<2xi32> {
    %0 = llvm.bitcast %arg0 : i64 to vector<4xi16>
    %1 = llvm.bitcast %0 : vector<4xi16> to vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def bitcast_bitcast_v_s_s_before := [llvmfunc|
  llvm.func @bitcast_bitcast_v_s_s(%arg0: vector<2xi32>) -> i64 {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to f64
    %1 = llvm.bitcast %0 : f64 to i64
    llvm.return %1 : i64
  }]

def bitcast_bitcast_v_s_v_before := [llvmfunc|
  llvm.func @bitcast_bitcast_v_s_v(%arg0: vector<2xi32>) -> vector<4xi16> {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to f64
    %1 = llvm.bitcast %0 : f64 to vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

def bitcast_bitcast_v_v_s_before := [llvmfunc|
  llvm.func @bitcast_bitcast_v_v_s(%arg0: vector<2xf32>) -> f64 {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to vector<4xi16>
    %1 = llvm.bitcast %0 : vector<4xi16> to f64
    llvm.return %1 : f64
  }]

def bitcast_bitcast_v_v_v_before := [llvmfunc|
  llvm.func @bitcast_bitcast_v_v_v(%arg0: vector<2xf32>) -> vector<2xi32> {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to vector<4xi16>
    %1 = llvm.bitcast %0 : vector<4xi16> to vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def bitcast_bitcast_s_s_s_combined := [llvmfunc|
  llvm.func @bitcast_bitcast_s_s_s(%arg0: i128) -> !llvm.ppc_fp128 {
    %0 = llvm.bitcast %arg0 : i128 to !llvm.ppc_fp128
    llvm.return %0 : !llvm.ppc_fp128
  }]

theorem inst_combine_bitcast_bitcast_s_s_s   : bitcast_bitcast_s_s_s_before  ⊑  bitcast_bitcast_s_s_s_combined := by
  unfold bitcast_bitcast_s_s_s_before bitcast_bitcast_s_s_s_combined
  simp_alive_peephole
  sorry
def bitcast_bitcast_s_s_v_combined := [llvmfunc|
  llvm.func @bitcast_bitcast_s_s_v(%arg0: i64) -> vector<2xi32> {
    %0 = llvm.bitcast %arg0 : i64 to vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_bitcast_bitcast_s_s_v   : bitcast_bitcast_s_s_v_before  ⊑  bitcast_bitcast_s_s_v_combined := by
  unfold bitcast_bitcast_s_s_v_before bitcast_bitcast_s_s_v_combined
  simp_alive_peephole
  sorry
def bitcast_bitcast_s_v_s_combined := [llvmfunc|
  llvm.func @bitcast_bitcast_s_v_s(%arg0: i64) -> f64 {
    %0 = llvm.bitcast %arg0 : i64 to f64
    llvm.return %0 : f64
  }]

theorem inst_combine_bitcast_bitcast_s_v_s   : bitcast_bitcast_s_v_s_before  ⊑  bitcast_bitcast_s_v_s_combined := by
  unfold bitcast_bitcast_s_v_s_before bitcast_bitcast_s_v_s_combined
  simp_alive_peephole
  sorry
def bitcast_bitcast_s_v_v_combined := [llvmfunc|
  llvm.func @bitcast_bitcast_s_v_v(%arg0: i64) -> vector<2xi32> {
    %0 = llvm.bitcast %arg0 : i64 to vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_bitcast_bitcast_s_v_v   : bitcast_bitcast_s_v_v_before  ⊑  bitcast_bitcast_s_v_v_combined := by
  unfold bitcast_bitcast_s_v_v_before bitcast_bitcast_s_v_v_combined
  simp_alive_peephole
  sorry
def bitcast_bitcast_v_s_s_combined := [llvmfunc|
  llvm.func @bitcast_bitcast_v_s_s(%arg0: vector<2xi32>) -> i64 {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to i64
    llvm.return %0 : i64
  }]

theorem inst_combine_bitcast_bitcast_v_s_s   : bitcast_bitcast_v_s_s_before  ⊑  bitcast_bitcast_v_s_s_combined := by
  unfold bitcast_bitcast_v_s_s_before bitcast_bitcast_v_s_s_combined
  simp_alive_peephole
  sorry
def bitcast_bitcast_v_s_v_combined := [llvmfunc|
  llvm.func @bitcast_bitcast_v_s_v(%arg0: vector<2xi32>) -> vector<4xi16> {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to vector<4xi16>
    llvm.return %0 : vector<4xi16>
  }]

theorem inst_combine_bitcast_bitcast_v_s_v   : bitcast_bitcast_v_s_v_before  ⊑  bitcast_bitcast_v_s_v_combined := by
  unfold bitcast_bitcast_v_s_v_before bitcast_bitcast_v_s_v_combined
  simp_alive_peephole
  sorry
def bitcast_bitcast_v_v_s_combined := [llvmfunc|
  llvm.func @bitcast_bitcast_v_v_s(%arg0: vector<2xf32>) -> f64 {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to f64
    llvm.return %0 : f64
  }]

theorem inst_combine_bitcast_bitcast_v_v_s   : bitcast_bitcast_v_v_s_before  ⊑  bitcast_bitcast_v_v_s_combined := by
  unfold bitcast_bitcast_v_v_s_before bitcast_bitcast_v_v_s_combined
  simp_alive_peephole
  sorry
def bitcast_bitcast_v_v_v_combined := [llvmfunc|
  llvm.func @bitcast_bitcast_v_v_v(%arg0: vector<2xf32>) -> vector<2xi32> {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_bitcast_bitcast_v_v_v   : bitcast_bitcast_v_v_v_before  ⊑  bitcast_bitcast_v_v_v_combined := by
  unfold bitcast_bitcast_v_v_v_before bitcast_bitcast_v_v_v_combined
  simp_alive_peephole
  sorry
