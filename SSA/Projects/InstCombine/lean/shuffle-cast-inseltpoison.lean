import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shuffle-cast-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def trunc_little_endian_before := [llvmfunc|
  llvm.func @trunc_little_endian(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : vector<4xi32> to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [0, 2, 4, 6] : vector<8xi16> 
    llvm.return %2 : vector<4xi16>
  }]

def trunc_big_endian_before := [llvmfunc|
  llvm.func @trunc_big_endian(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : vector<4xi32> to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [1, 3, 5, 7] : vector<8xi16> 
    llvm.return %2 : vector<4xi16>
  }]

def trunc_little_endian_extra_use_before := [llvmfunc|
  llvm.func @trunc_little_endian_extra_use(%arg0: vector<2xi64>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : vector<2xi64> to vector<8xi16>
    llvm.call @use_v8i16(%1) : (vector<8xi16>) -> ()
    %2 = llvm.shufflevector %1, %0 [0, 4] : vector<8xi16> 
    llvm.return %2 : vector<2xi16>
  }]

def trunc_big_endian_extra_use_before := [llvmfunc|
  llvm.func @trunc_big_endian_extra_use(%arg0: vector<4xi33>) -> vector<4xi11> {
    %0 = llvm.mlir.poison : vector<12xi11>
    %1 = llvm.bitcast %arg0 : vector<4xi33> to vector<12xi11>
    llvm.call @use_v12i11(%1) : (vector<12xi11>) -> ()
    %2 = llvm.shufflevector %1, %0 [2, 5, 8, 11] : vector<12xi11> 
    llvm.return %2 : vector<4xi11>
  }]

def wrong_cast1_before := [llvmfunc|
  llvm.func @wrong_cast1(%arg0: i128) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : i128 to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [0, 2, 4, 6] : vector<8xi16> 
    llvm.return %2 : vector<4xi16>
  }]

def wrong_cast2_before := [llvmfunc|
  llvm.func @wrong_cast2(%arg0: vector<4xf32>) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : vector<4xf32> to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [0, 2, 4, 6] : vector<8xi16> 
    llvm.return %2 : vector<4xi16>
  }]

def wrong_cast3_before := [llvmfunc|
  llvm.func @wrong_cast3(%arg0: vector<4xi32>) -> vector<4xf16> {
    %0 = llvm.mlir.poison : vector<8xf16>
    %1 = llvm.bitcast %arg0 : vector<4xi32> to vector<8xf16>
    %2 = llvm.shufflevector %1, %0 [0, 2, 4, 6] : vector<8xf16> 
    llvm.return %2 : vector<4xf16>
  }]

def wrong_shuffle_before := [llvmfunc|
  llvm.func @wrong_shuffle(%arg0: vector<4xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : vector<4xi32> to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [0, 2] : vector<8xi16> 
    llvm.return %2 : vector<2xi16>
  }]

def trunc_little_endian_combined := [llvmfunc|
  llvm.func @trunc_little_endian(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.trunc %arg0 : vector<4xi32> to vector<4xi16>
    llvm.return %0 : vector<4xi16>
  }]

theorem inst_combine_trunc_little_endian   : trunc_little_endian_before  ⊑  trunc_little_endian_combined := by
  unfold trunc_little_endian_before trunc_little_endian_combined
  simp_alive_peephole
  sorry
def trunc_big_endian_combined := [llvmfunc|
  llvm.func @trunc_big_endian(%arg0: vector<4xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : vector<4xi32> to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [1, 3, 5, 7] : vector<8xi16> 
    llvm.return %2 : vector<4xi16>
  }]

theorem inst_combine_trunc_big_endian   : trunc_big_endian_before  ⊑  trunc_big_endian_combined := by
  unfold trunc_big_endian_before trunc_big_endian_combined
  simp_alive_peephole
  sorry
def trunc_little_endian_extra_use_combined := [llvmfunc|
  llvm.func @trunc_little_endian_extra_use(%arg0: vector<2xi64>) -> vector<2xi16> {
    %0 = llvm.bitcast %arg0 : vector<2xi64> to vector<8xi16>
    llvm.call @use_v8i16(%0) : (vector<8xi16>) -> ()
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_trunc_little_endian_extra_use   : trunc_little_endian_extra_use_before  ⊑  trunc_little_endian_extra_use_combined := by
  unfold trunc_little_endian_extra_use_before trunc_little_endian_extra_use_combined
  simp_alive_peephole
  sorry
def trunc_big_endian_extra_use_combined := [llvmfunc|
  llvm.func @trunc_big_endian_extra_use(%arg0: vector<4xi33>) -> vector<4xi11> {
    %0 = llvm.mlir.poison : vector<12xi11>
    %1 = llvm.bitcast %arg0 : vector<4xi33> to vector<12xi11>
    llvm.call @use_v12i11(%1) : (vector<12xi11>) -> ()
    %2 = llvm.shufflevector %1, %0 [2, 5, 8, 11] : vector<12xi11> 
    llvm.return %2 : vector<4xi11>
  }]

theorem inst_combine_trunc_big_endian_extra_use   : trunc_big_endian_extra_use_before  ⊑  trunc_big_endian_extra_use_combined := by
  unfold trunc_big_endian_extra_use_before trunc_big_endian_extra_use_combined
  simp_alive_peephole
  sorry
def wrong_cast1_combined := [llvmfunc|
  llvm.func @wrong_cast1(%arg0: i128) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : i128 to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [0, 2, 4, 6] : vector<8xi16> 
    llvm.return %2 : vector<4xi16>
  }]

theorem inst_combine_wrong_cast1   : wrong_cast1_before  ⊑  wrong_cast1_combined := by
  unfold wrong_cast1_before wrong_cast1_combined
  simp_alive_peephole
  sorry
def wrong_cast2_combined := [llvmfunc|
  llvm.func @wrong_cast2(%arg0: vector<4xf32>) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : vector<4xf32> to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [0, 2, 4, 6] : vector<8xi16> 
    llvm.return %2 : vector<4xi16>
  }]

theorem inst_combine_wrong_cast2   : wrong_cast2_before  ⊑  wrong_cast2_combined := by
  unfold wrong_cast2_before wrong_cast2_combined
  simp_alive_peephole
  sorry
def wrong_cast3_combined := [llvmfunc|
  llvm.func @wrong_cast3(%arg0: vector<4xi32>) -> vector<4xf16> {
    %0 = llvm.mlir.poison : vector<8xf16>
    %1 = llvm.bitcast %arg0 : vector<4xi32> to vector<8xf16>
    %2 = llvm.shufflevector %1, %0 [0, 2, 4, 6] : vector<8xf16> 
    llvm.return %2 : vector<4xf16>
  }]

theorem inst_combine_wrong_cast3   : wrong_cast3_before  ⊑  wrong_cast3_combined := by
  unfold wrong_cast3_before wrong_cast3_combined
  simp_alive_peephole
  sorry
def wrong_shuffle_combined := [llvmfunc|
  llvm.func @wrong_shuffle(%arg0: vector<4xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : vector<8xi16>
    %1 = llvm.bitcast %arg0 : vector<4xi32> to vector<8xi16>
    %2 = llvm.shufflevector %1, %0 [0, 2] : vector<8xi16> 
    llvm.return %2 : vector<2xi16>
  }]

theorem inst_combine_wrong_shuffle   : wrong_shuffle_before  ⊑  wrong_shuffle_combined := by
  unfold wrong_shuffle_before wrong_shuffle_combined
  simp_alive_peephole
  sorry
