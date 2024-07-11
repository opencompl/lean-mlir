import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shuffle-cast-dist
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def vtrn1_before := [llvmfunc|
  llvm.func @vtrn1(%arg0: vector<2xi32>) -> vector<2xf32> {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to vector<2xf32>
    %1 = llvm.bitcast %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.shufflevector %0, %1 [0, 2] : vector<2xf32> 
    llvm.return %2 : vector<2xf32>
  }]

def vtrn2_before := [llvmfunc|
  llvm.func @vtrn2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xf32> {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to vector<2xf32>
    %1 = llvm.bitcast %arg1 : vector<2xi32> to vector<2xf32>
    %2 = llvm.shufflevector %0, %1 [1, 3] : vector<2xf32> 
    llvm.return %2 : vector<2xf32>
  }]

def bc_shuf_lenchange_before := [llvmfunc|
  llvm.func @bc_shuf_lenchange(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to vector<2xf32>
    %1 = llvm.bitcast %arg1 : vector<2xi32> to vector<2xf32>
    %2 = llvm.shufflevector %0, %1 [3, 2, 1, 0] : vector<2xf32> 
    llvm.return %2 : vector<4xf32>
  }]

def bc_shuf_nonvec_before := [llvmfunc|
  llvm.func @bc_shuf_nonvec(%arg0: i64, %arg1: i64) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : i64 to vector<2xf32>
    %1 = llvm.bitcast %arg1 : i64 to vector<2xf32>
    %2 = llvm.shufflevector %0, %1 [3, 2, 1, 0] : vector<2xf32> 
    llvm.return %2 : vector<4xf32>
  }]

def bc_shuf_size_before := [llvmfunc|
  llvm.func @bc_shuf_size(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf64> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<2xf64>
    %1 = llvm.bitcast %arg1 : vector<4xi32> to vector<2xf64>
    %2 = llvm.shufflevector %0, %1 [1, 3, 0, 2] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

def bc_shuf_mismatch_before := [llvmfunc|
  llvm.func @bc_shuf_mismatch(%arg0: vector<4xi32>, %arg1: vector<2xi64>) -> vector<2xf64> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<2xf64>
    %1 = llvm.bitcast %arg1 : vector<2xi64> to vector<2xf64>
    %2 = llvm.shufflevector %0, %1 [1, 3] : vector<2xf64> 
    llvm.return %2 : vector<2xf64>
  }]

def bc_shuf_i8_float_before := [llvmfunc|
  llvm.func @bc_shuf_i8_float(%arg0: vector<8xi8>, %arg1: vector<8xi8>) -> vector<8xf16> {
    %0 = llvm.bitcast %arg0 : vector<8xi8> to vector<4xf16>
    %1 = llvm.bitcast %arg1 : vector<8xi8> to vector<4xf16>
    %2 = llvm.shufflevector %0, %1 [3, 2, 1, 0, 7, 6, 5, 4] : vector<4xf16> 
    llvm.return %2 : vector<8xf16>
  }]

def bc_shuf_elemtype_mismatch_before := [llvmfunc|
  llvm.func @bc_shuf_elemtype_mismatch(%arg0: vector<2xf16>, %arg1: vector<2xbf16>) -> vector<4xi16> {
    %0 = llvm.bitcast %arg0 : vector<2xf16> to vector<2xi16>
    %1 = llvm.bitcast %arg1 : vector<2xbf16> to vector<2xi16>
    %2 = llvm.shufflevector %0, %1 [3, 2, 1, 0] : vector<2xi16> 
    llvm.return %2 : vector<4xi16>
  }]

def bc_shuf_reuse_before := [llvmfunc|
  llvm.func @bc_shuf_reuse(%arg0: vector<4xi32>) -> vector<2xf32> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<4xf32>
    %1 = llvm.shufflevector %0, %0 [0, 4] : vector<4xf32> 
    llvm.return %1 : vector<2xf32>
  }]

def bc_shuf_y_hasoneuse_before := [llvmfunc|
  llvm.func @bc_shuf_y_hasoneuse(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<4xf32>
    %1 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    %2 = llvm.shufflevector %0, %1 [0, 1, 4, 5] : vector<4xf32> 
    %3 = llvm.fadd %0, %2  : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

def bc_shuf_neither_hasoneuse_before := [llvmfunc|
  llvm.func @bc_shuf_neither_hasoneuse(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<4xf32>
    %1 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    %2 = llvm.shufflevector %0, %0 [0, 1, 4, 5] : vector<4xf32> 
    %3 = llvm.fadd %0, %1  : vector<4xf32>
    %4 = llvm.fadd %3, %2  : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

def vtrn1_combined := [llvmfunc|
  llvm.func @vtrn1(%arg0: vector<2xi32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.bitcast %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.shufflevector %1, %0 [0, 0] : vector<2xf32> 
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_vtrn1   : vtrn1_before  ⊑  vtrn1_combined := by
  unfold vtrn1_before vtrn1_combined
  simp_alive_peephole
  sorry
def vtrn2_combined := [llvmfunc|
  llvm.func @vtrn2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [1, 3] : vector<2xi32> 
    %1 = llvm.bitcast %0 : vector<2xi32> to vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_vtrn2   : vtrn2_before  ⊑  vtrn2_combined := by
  unfold vtrn2_before vtrn2_combined
  simp_alive_peephole
  sorry
def bc_shuf_lenchange_combined := [llvmfunc|
  llvm.func @bc_shuf_lenchange(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<4xf32> {
    %0 = llvm.shufflevector %arg0, %arg1 [3, 2, 1, 0] : vector<2xi32> 
    %1 = llvm.bitcast %0 : vector<4xi32> to vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_bc_shuf_lenchange   : bc_shuf_lenchange_before  ⊑  bc_shuf_lenchange_combined := by
  unfold bc_shuf_lenchange_before bc_shuf_lenchange_combined
  simp_alive_peephole
  sorry
def bc_shuf_nonvec_combined := [llvmfunc|
  llvm.func @bc_shuf_nonvec(%arg0: i64, %arg1: i64) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : i64 to vector<2xf32>
    %1 = llvm.bitcast %arg1 : i64 to vector<2xf32>
    %2 = llvm.shufflevector %0, %1 [3, 2, 1, 0] : vector<2xf32> 
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_bc_shuf_nonvec   : bc_shuf_nonvec_before  ⊑  bc_shuf_nonvec_combined := by
  unfold bc_shuf_nonvec_before bc_shuf_nonvec_combined
  simp_alive_peephole
  sorry
def bc_shuf_size_combined := [llvmfunc|
  llvm.func @bc_shuf_size(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf64> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<2xf64>
    %1 = llvm.bitcast %arg1 : vector<4xi32> to vector<2xf64>
    %2 = llvm.shufflevector %0, %1 [1, 3, 0, 2] : vector<2xf64> 
    llvm.return %2 : vector<4xf64>
  }]

theorem inst_combine_bc_shuf_size   : bc_shuf_size_before  ⊑  bc_shuf_size_combined := by
  unfold bc_shuf_size_before bc_shuf_size_combined
  simp_alive_peephole
  sorry
def bc_shuf_mismatch_combined := [llvmfunc|
  llvm.func @bc_shuf_mismatch(%arg0: vector<4xi32>, %arg1: vector<2xi64>) -> vector<2xf64> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<2xf64>
    %1 = llvm.bitcast %arg1 : vector<2xi64> to vector<2xf64>
    %2 = llvm.shufflevector %0, %1 [1, 3] : vector<2xf64> 
    llvm.return %2 : vector<2xf64>
  }]

theorem inst_combine_bc_shuf_mismatch   : bc_shuf_mismatch_before  ⊑  bc_shuf_mismatch_combined := by
  unfold bc_shuf_mismatch_before bc_shuf_mismatch_combined
  simp_alive_peephole
  sorry
def bc_shuf_i8_float_combined := [llvmfunc|
  llvm.func @bc_shuf_i8_float(%arg0: vector<8xi8>, %arg1: vector<8xi8>) -> vector<8xf16> {
    %0 = llvm.bitcast %arg0 : vector<8xi8> to vector<4xf16>
    %1 = llvm.bitcast %arg1 : vector<8xi8> to vector<4xf16>
    %2 = llvm.shufflevector %0, %1 [3, 2, 1, 0, 7, 6, 5, 4] : vector<4xf16> 
    llvm.return %2 : vector<8xf16>
  }]

theorem inst_combine_bc_shuf_i8_float   : bc_shuf_i8_float_before  ⊑  bc_shuf_i8_float_combined := by
  unfold bc_shuf_i8_float_before bc_shuf_i8_float_combined
  simp_alive_peephole
  sorry
def bc_shuf_elemtype_mismatch_combined := [llvmfunc|
  llvm.func @bc_shuf_elemtype_mismatch(%arg0: vector<2xf16>, %arg1: vector<2xbf16>) -> vector<4xi16> {
    %0 = llvm.bitcast %arg0 : vector<2xf16> to vector<2xi16>
    %1 = llvm.bitcast %arg1 : vector<2xbf16> to vector<2xi16>
    %2 = llvm.shufflevector %0, %1 [3, 2, 1, 0] : vector<2xi16> 
    llvm.return %2 : vector<4xi16>
  }]

theorem inst_combine_bc_shuf_elemtype_mismatch   : bc_shuf_elemtype_mismatch_before  ⊑  bc_shuf_elemtype_mismatch_combined := by
  unfold bc_shuf_elemtype_mismatch_before bc_shuf_elemtype_mismatch_combined
  simp_alive_peephole
  sorry
def bc_shuf_reuse_combined := [llvmfunc|
  llvm.func @bc_shuf_reuse(%arg0: vector<4xi32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.bitcast %arg0 : vector<4xi32> to vector<4xf32>
    %2 = llvm.shufflevector %1, %0 [0, 0] : vector<4xf32> 
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_bc_shuf_reuse   : bc_shuf_reuse_before  ⊑  bc_shuf_reuse_combined := by
  unfold bc_shuf_reuse_before bc_shuf_reuse_combined
  simp_alive_peephole
  sorry
def bc_shuf_y_hasoneuse_combined := [llvmfunc|
  llvm.func @bc_shuf_y_hasoneuse(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<4xf32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 1, 4, 5] : vector<4xi32> 
    %2 = llvm.bitcast %1 : vector<4xi32> to vector<4xf32>
    %3 = llvm.fadd %0, %2  : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_bc_shuf_y_hasoneuse   : bc_shuf_y_hasoneuse_before  ⊑  bc_shuf_y_hasoneuse_combined := by
  unfold bc_shuf_y_hasoneuse_before bc_shuf_y_hasoneuse_combined
  simp_alive_peephole
  sorry
def bc_shuf_neither_hasoneuse_combined := [llvmfunc|
  llvm.func @bc_shuf_neither_hasoneuse(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.bitcast %arg0 : vector<4xi32> to vector<4xf32>
    %2 = llvm.bitcast %arg1 : vector<4xi32> to vector<4xf32>
    %3 = llvm.shufflevector %1, %0 [0, 1, 0, 1] : vector<4xf32> 
    %4 = llvm.fadd %1, %2  : vector<4xf32>
    %5 = llvm.fadd %4, %3  : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

theorem inst_combine_bc_shuf_neither_hasoneuse   : bc_shuf_neither_hasoneuse_before  ⊑  bc_shuf_neither_hasoneuse_combined := by
  unfold bc_shuf_neither_hasoneuse_before bc_shuf_neither_hasoneuse_combined
  simp_alive_peephole
  sorry
