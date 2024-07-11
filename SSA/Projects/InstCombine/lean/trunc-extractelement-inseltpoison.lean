import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  trunc-extractelement-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def shrinkExtractElt_i64_to_i32_0_before := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i32_0(%arg0: vector<3xi64>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : vector<3xi64>
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

def vscale_shrinkExtractElt_i64_to_i32_0_before := [llvmfunc|
  llvm.func @vscale_shrinkExtractElt_i64_to_i32_0(%arg0: !llvm.vec<? x 3 x  i64>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 3 x  i64>
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

def shrinkExtractElt_i64_to_i32_1_before := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i32_1(%arg0: vector<3xi64>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : vector<3xi64>
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

def shrinkExtractElt_i64_to_i32_2_before := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i32_2(%arg0: vector<3xi64>) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : vector<3xi64>
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

def shrinkExtractElt_i64_to_i16_0_before := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i16_0(%arg0: vector<3xi64>) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.extractelement %arg0[%0 : i16] : vector<3xi64>
    %2 = llvm.trunc %1 : i64 to i16
    llvm.return %2 : i16
  }]

def shrinkExtractElt_i64_to_i16_1_before := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i16_1(%arg0: vector<3xi64>) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.extractelement %arg0[%0 : i16] : vector<3xi64>
    %2 = llvm.trunc %1 : i64 to i16
    llvm.return %2 : i16
  }]

def shrinkExtractElt_i64_to_i16_2_before := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i16_2(%arg0: vector<3xi64>) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.extractelement %arg0[%0 : i16] : vector<3xi64>
    %2 = llvm.trunc %1 : i64 to i16
    llvm.return %2 : i16
  }]

def shrinkExtractElt_i33_to_11_2_before := [llvmfunc|
  llvm.func @shrinkExtractElt_i33_to_11_2(%arg0: vector<3xi33>) -> i11 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.extractelement %arg0[%0 : i16] : vector<3xi33>
    %2 = llvm.trunc %1 : i33 to i11
    llvm.return %2 : i11
  }]

def shrinkExtractElt_i67_to_i13_2_before := [llvmfunc|
  llvm.func @shrinkExtractElt_i67_to_i13_2(%arg0: vector<3xi67>) -> i13 {
    %0 = llvm.mlir.constant(2 : i459) : i459
    %1 = llvm.extractelement %arg0[%0 : i459] : vector<3xi67>
    %2 = llvm.trunc %1 : i67 to i13
    llvm.return %2 : i13
  }]

def shrinkExtractElt_i40_to_i30_1_before := [llvmfunc|
  llvm.func @shrinkExtractElt_i40_to_i30_1(%arg0: vector<3xi40>) -> i30 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : vector<3xi40>
    %2 = llvm.trunc %1 : i40 to i30
    llvm.return %2 : i30
  }]

def shrinkExtractElt_i64_to_i16_2_extra_use_before := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i16_2_extra_use(%arg0: vector<3xi64>) -> i16 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<3xi64>
    llvm.call @use(%1) : (i64) -> ()
    %2 = llvm.trunc %1 : i64 to i16
    llvm.return %2 : i16
  }]

def PR45314_before := [llvmfunc|
  llvm.func @PR45314(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : vector<8xi32>
    %2 = llvm.extractelement %arg0[%0 : i32] : vector<4xi64>
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.insertelement %3, %1[%0 : i32] : vector<8xi32>
    %5 = llvm.shufflevector %4, %1 [0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi32> 
    %6 = llvm.bitcast %5 : vector<8xi32> to vector<4xi64>
    llvm.return %6 : vector<4xi64>
  }]

def shrinkExtractElt_i64_to_i32_0_combined := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i32_0(%arg0: vector<3xi64>) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<3xi64> to vector<6xi32>
    %2 = llvm.extractelement %1[%0 : i64] : vector<6xi32>
    llvm.return %2 : i32
  }]

theorem inst_combine_shrinkExtractElt_i64_to_i32_0   : shrinkExtractElt_i64_to_i32_0_before  ⊑  shrinkExtractElt_i64_to_i32_0_combined := by
  unfold shrinkExtractElt_i64_to_i32_0_before shrinkExtractElt_i64_to_i32_0_combined
  simp_alive_peephole
  sorry
def vscale_shrinkExtractElt_i64_to_i32_0_combined := [llvmfunc|
  llvm.func @vscale_shrinkExtractElt_i64_to_i32_0(%arg0: !llvm.vec<? x 3 x  i64>) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : !llvm.vec<? x 3 x  i64> to !llvm.vec<? x 6 x  i32>
    %2 = llvm.extractelement %1[%0 : i64] : !llvm.vec<? x 6 x  i32>
    llvm.return %2 : i32
  }]

theorem inst_combine_vscale_shrinkExtractElt_i64_to_i32_0   : vscale_shrinkExtractElt_i64_to_i32_0_before  ⊑  vscale_shrinkExtractElt_i64_to_i32_0_combined := by
  unfold vscale_shrinkExtractElt_i64_to_i32_0_before vscale_shrinkExtractElt_i64_to_i32_0_combined
  simp_alive_peephole
  sorry
def shrinkExtractElt_i64_to_i32_1_combined := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i32_1(%arg0: vector<3xi64>) -> i32 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<3xi64> to vector<6xi32>
    %2 = llvm.extractelement %1[%0 : i64] : vector<6xi32>
    llvm.return %2 : i32
  }]

theorem inst_combine_shrinkExtractElt_i64_to_i32_1   : shrinkExtractElt_i64_to_i32_1_before  ⊑  shrinkExtractElt_i64_to_i32_1_combined := by
  unfold shrinkExtractElt_i64_to_i32_1_before shrinkExtractElt_i64_to_i32_1_combined
  simp_alive_peephole
  sorry
def shrinkExtractElt_i64_to_i32_2_combined := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i32_2(%arg0: vector<3xi64>) -> i32 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<3xi64> to vector<6xi32>
    %2 = llvm.extractelement %1[%0 : i64] : vector<6xi32>
    llvm.return %2 : i32
  }]

theorem inst_combine_shrinkExtractElt_i64_to_i32_2   : shrinkExtractElt_i64_to_i32_2_before  ⊑  shrinkExtractElt_i64_to_i32_2_combined := by
  unfold shrinkExtractElt_i64_to_i32_2_before shrinkExtractElt_i64_to_i32_2_combined
  simp_alive_peephole
  sorry
def shrinkExtractElt_i64_to_i16_0_combined := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i16_0(%arg0: vector<3xi64>) -> i16 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<3xi64> to vector<12xi16>
    %2 = llvm.extractelement %1[%0 : i64] : vector<12xi16>
    llvm.return %2 : i16
  }]

theorem inst_combine_shrinkExtractElt_i64_to_i16_0   : shrinkExtractElt_i64_to_i16_0_before  ⊑  shrinkExtractElt_i64_to_i16_0_combined := by
  unfold shrinkExtractElt_i64_to_i16_0_before shrinkExtractElt_i64_to_i16_0_combined
  simp_alive_peephole
  sorry
def shrinkExtractElt_i64_to_i16_1_combined := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i16_1(%arg0: vector<3xi64>) -> i16 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<3xi64> to vector<12xi16>
    %2 = llvm.extractelement %1[%0 : i64] : vector<12xi16>
    llvm.return %2 : i16
  }]

theorem inst_combine_shrinkExtractElt_i64_to_i16_1   : shrinkExtractElt_i64_to_i16_1_before  ⊑  shrinkExtractElt_i64_to_i16_1_combined := by
  unfold shrinkExtractElt_i64_to_i16_1_before shrinkExtractElt_i64_to_i16_1_combined
  simp_alive_peephole
  sorry
def shrinkExtractElt_i64_to_i16_2_combined := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i16_2(%arg0: vector<3xi64>) -> i16 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<3xi64> to vector<12xi16>
    %2 = llvm.extractelement %1[%0 : i64] : vector<12xi16>
    llvm.return %2 : i16
  }]

theorem inst_combine_shrinkExtractElt_i64_to_i16_2   : shrinkExtractElt_i64_to_i16_2_before  ⊑  shrinkExtractElt_i64_to_i16_2_combined := by
  unfold shrinkExtractElt_i64_to_i16_2_before shrinkExtractElt_i64_to_i16_2_combined
  simp_alive_peephole
  sorry
def shrinkExtractElt_i33_to_11_2_combined := [llvmfunc|
  llvm.func @shrinkExtractElt_i33_to_11_2(%arg0: vector<3xi33>) -> i11 {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<3xi33> to vector<9xi11>
    %2 = llvm.extractelement %1[%0 : i64] : vector<9xi11>
    llvm.return %2 : i11
  }]

theorem inst_combine_shrinkExtractElt_i33_to_11_2   : shrinkExtractElt_i33_to_11_2_before  ⊑  shrinkExtractElt_i33_to_11_2_combined := by
  unfold shrinkExtractElt_i33_to_11_2_before shrinkExtractElt_i33_to_11_2_combined
  simp_alive_peephole
  sorry
def shrinkExtractElt_i67_to_i13_2_combined := [llvmfunc|
  llvm.func @shrinkExtractElt_i67_to_i13_2(%arg0: vector<3xi67>) -> i13 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<3xi67>
    %2 = llvm.trunc %1 : i67 to i13
    llvm.return %2 : i13
  }]

theorem inst_combine_shrinkExtractElt_i67_to_i13_2   : shrinkExtractElt_i67_to_i13_2_before  ⊑  shrinkExtractElt_i67_to_i13_2_combined := by
  unfold shrinkExtractElt_i67_to_i13_2_before shrinkExtractElt_i67_to_i13_2_combined
  simp_alive_peephole
  sorry
def shrinkExtractElt_i40_to_i30_1_combined := [llvmfunc|
  llvm.func @shrinkExtractElt_i40_to_i30_1(%arg0: vector<3xi40>) -> i30 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<3xi40>
    %2 = llvm.trunc %1 : i40 to i30
    llvm.return %2 : i30
  }]

theorem inst_combine_shrinkExtractElt_i40_to_i30_1   : shrinkExtractElt_i40_to_i30_1_before  ⊑  shrinkExtractElt_i40_to_i30_1_combined := by
  unfold shrinkExtractElt_i40_to_i30_1_before shrinkExtractElt_i40_to_i30_1_combined
  simp_alive_peephole
  sorry
def shrinkExtractElt_i64_to_i16_2_extra_use_combined := [llvmfunc|
  llvm.func @shrinkExtractElt_i64_to_i16_2_extra_use(%arg0: vector<3xi64>) -> i16 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<3xi64>
    llvm.call @use(%1) : (i64) -> ()
    %2 = llvm.trunc %1 : i64 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_shrinkExtractElt_i64_to_i16_2_extra_use   : shrinkExtractElt_i64_to_i16_2_extra_use_before  ⊑  shrinkExtractElt_i64_to_i16_2_extra_use_combined := by
  unfold shrinkExtractElt_i64_to_i16_2_extra_use_before shrinkExtractElt_i64_to_i16_2_extra_use_combined
  simp_alive_peephole
  sorry
def PR45314_combined := [llvmfunc|
  llvm.func @PR45314(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.poison : vector<8xi32>
    %1 = llvm.bitcast %arg0 : vector<4xi64> to vector<8xi32>
    %2 = llvm.shufflevector %1, %0 [0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi32> 
    %3 = llvm.bitcast %2 : vector<8xi32> to vector<4xi64>
    llvm.return %3 : vector<4xi64>
  }]

theorem inst_combine_PR45314   : PR45314_before  ⊑  PR45314_combined := by
  unfold PR45314_before PR45314_combined
  simp_alive_peephole
  sorry
