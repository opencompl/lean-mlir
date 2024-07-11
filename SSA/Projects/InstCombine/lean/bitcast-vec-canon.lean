import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bitcast-vec-canon
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def a_before := [llvmfunc|
  llvm.func @a(%arg0: vector<1xi64>) -> f64 {
    %0 = llvm.bitcast %arg0 : vector<1xi64> to f64
    llvm.return %0 : f64
  }]

def b_before := [llvmfunc|
  llvm.func @b(%arg0: vector<1xi64>) -> i64 {
    %0 = llvm.bitcast %arg0 : vector<1xi64> to i64
    llvm.return %0 : i64
  }]

def c_before := [llvmfunc|
  llvm.func @c(%arg0: f64) -> vector<1xi64> {
    %0 = llvm.bitcast %arg0 : f64 to vector<1xi64>
    llvm.return %0 : vector<1xi64>
  }]

def d_before := [llvmfunc|
  llvm.func @d(%arg0: i64) -> vector<1xi64> {
    %0 = llvm.bitcast %arg0 : i64 to vector<1xi64>
    llvm.return %0 : vector<1xi64>
  }]

def e_before := [llvmfunc|
  llvm.func @e(%arg0: vector<1xi64>) -> !llvm.x86_mmx {
    %0 = llvm.bitcast %arg0 : vector<1xi64> to !llvm.x86_mmx
    llvm.return %0 : !llvm.x86_mmx
  }]

def f_before := [llvmfunc|
  llvm.func @f(%arg0: !llvm.x86_mmx) -> vector<1xi64> {
    %0 = llvm.bitcast %arg0 : !llvm.x86_mmx to vector<1xi64>
    llvm.return %0 : vector<1xi64>
  }]

def g_before := [llvmfunc|
  llvm.func @g(%arg0: !llvm.x86_mmx) -> f64 {
    %0 = llvm.bitcast %arg0 : !llvm.x86_mmx to vector<1xi64>
    %1 = llvm.bitcast %0 : vector<1xi64> to f64
    llvm.return %1 : f64
  }]

def bitcast_inselt_undef_before := [llvmfunc|
  llvm.func @bitcast_inselt_undef(%arg0: f64, %arg1: i32) -> vector<3xi64> {
    %0 = llvm.mlir.undef : vector<3xi64>
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.insertelement %1, %0[%arg1 : i32] : vector<3xi64>
    llvm.return %2 : vector<3xi64>
  }]

def bitcast_inselt_undef_fp_before := [llvmfunc|
  llvm.func @bitcast_inselt_undef_fp(%arg0: i32, %arg1: i567) -> vector<3xf32> {
    %0 = llvm.mlir.undef : vector<3xf32>
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.insertelement %1, %0[%arg1 : i567] : vector<3xf32>
    llvm.return %2 : vector<3xf32>
  }]

def bitcast_inselt_undef_vscale_before := [llvmfunc|
  llvm.func @bitcast_inselt_undef_vscale(%arg0: i32, %arg1: i567) -> !llvm.vec<? x 3 x  f32> {
    %0 = llvm.mlir.undef : !llvm.vec<? x 3 x  f32>
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.insertelement %1, %0[%arg1 : i567] : !llvm.vec<? x 3 x  f32>
    llvm.return %2 : !llvm.vec<? x 3 x  f32>
  }]

def bitcast_inselt_undef_extra_use_before := [llvmfunc|
  llvm.func @bitcast_inselt_undef_extra_use(%arg0: f64, %arg1: i32) -> vector<3xi64> {
    %0 = llvm.mlir.undef : vector<3xi64>
    %1 = llvm.bitcast %arg0 : f64 to i64
    llvm.call @use(%1) : (i64) -> ()
    %2 = llvm.insertelement %1, %0[%arg1 : i32] : vector<3xi64>
    llvm.return %2 : vector<3xi64>
  }]

def bitcast_inselt_undef_vec_src_before := [llvmfunc|
  llvm.func @bitcast_inselt_undef_vec_src(%arg0: vector<2xi32>, %arg1: i32) -> vector<3xi64> {
    %0 = llvm.mlir.undef : vector<3xi64>
    %1 = llvm.bitcast %arg0 : vector<2xi32> to i64
    %2 = llvm.insertelement %1, %0[%arg1 : i32] : vector<3xi64>
    llvm.return %2 : vector<3xi64>
  }]

def bitcast_inselt_undef_from_mmx_before := [llvmfunc|
  llvm.func @bitcast_inselt_undef_from_mmx(%arg0: !llvm.x86_mmx, %arg1: i32) -> vector<3xi64> {
    %0 = llvm.mlir.undef : vector<3xi64>
    %1 = llvm.bitcast %arg0 : !llvm.x86_mmx to i64
    %2 = llvm.insertelement %1, %0[%arg1 : i32] : vector<3xi64>
    llvm.return %2 : vector<3xi64>
  }]

def PR45748_before := [llvmfunc|
  llvm.func @PR45748(%arg0: f64, %arg1: f64) -> vector<2xi64> {
    %0 = llvm.mlir.undef : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.bitcast %arg0 : f64 to i64
    %4 = llvm.insertelement %3, %0[%1 : i32] : vector<2xi64>
    %5 = llvm.bitcast %arg1 : f64 to i64
    %6 = llvm.insertelement %5, %4[%2 : i32] : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

def a_combined := [llvmfunc|
  llvm.func @a(%arg0: vector<1xi64>) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<1xi64> to vector<1xf64>
    %2 = llvm.extractelement %1[%0 : i64] : vector<1xf64>
    llvm.return %2 : f64
  }]

theorem inst_combine_a   : a_before  ⊑  a_combined := by
  unfold a_before a_combined
  simp_alive_peephole
  sorry
def b_combined := [llvmfunc|
  llvm.func @b(%arg0: vector<1xi64>) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<1xi64>
    llvm.return %1 : i64
  }]

theorem inst_combine_b   : b_before  ⊑  b_combined := by
  unfold b_before b_combined
  simp_alive_peephole
  sorry
def c_combined := [llvmfunc|
  llvm.func @c(%arg0: f64) -> vector<1xi64> {
    %0 = llvm.bitcast %arg0 : f64 to vector<1xi64>
    llvm.return %0 : vector<1xi64>
  }]

theorem inst_combine_c   : c_before  ⊑  c_combined := by
  unfold c_before c_combined
  simp_alive_peephole
  sorry
def d_combined := [llvmfunc|
  llvm.func @d(%arg0: i64) -> vector<1xi64> {
    %0 = llvm.mlir.poison : vector<1xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<1xi64>
    llvm.return %2 : vector<1xi64>
  }]

theorem inst_combine_d   : d_before  ⊑  d_combined := by
  unfold d_before d_combined
  simp_alive_peephole
  sorry
def e_combined := [llvmfunc|
  llvm.func @e(%arg0: vector<1xi64>) -> !llvm.x86_mmx {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<1xi64>
    %2 = llvm.bitcast %1 : i64 to !llvm.x86_mmx
    llvm.return %2 : !llvm.x86_mmx
  }]

theorem inst_combine_e   : e_before  ⊑  e_combined := by
  unfold e_before e_combined
  simp_alive_peephole
  sorry
def f_combined := [llvmfunc|
  llvm.func @f(%arg0: !llvm.x86_mmx) -> vector<1xi64> {
    %0 = llvm.mlir.poison : vector<1xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.bitcast %arg0 : !llvm.x86_mmx to i64
    %3 = llvm.insertelement %2, %0[%1 : i64] : vector<1xi64>
    llvm.return %3 : vector<1xi64>
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
def g_combined := [llvmfunc|
  llvm.func @g(%arg0: !llvm.x86_mmx) -> f64 {
    %0 = llvm.bitcast %arg0 : !llvm.x86_mmx to f64
    llvm.return %0 : f64
  }]

theorem inst_combine_g   : g_before  ⊑  g_combined := by
  unfold g_before g_combined
  simp_alive_peephole
  sorry
def bitcast_inselt_undef_combined := [llvmfunc|
  llvm.func @bitcast_inselt_undef(%arg0: f64, %arg1: i32) -> vector<3xi64> {
    %0 = llvm.mlir.undef : vector<3xf64>
    %1 = llvm.insertelement %arg0, %0[%arg1 : i32] : vector<3xf64>
    %2 = llvm.bitcast %1 : vector<3xf64> to vector<3xi64>
    llvm.return %2 : vector<3xi64>
  }]

theorem inst_combine_bitcast_inselt_undef   : bitcast_inselt_undef_before  ⊑  bitcast_inselt_undef_combined := by
  unfold bitcast_inselt_undef_before bitcast_inselt_undef_combined
  simp_alive_peephole
  sorry
def bitcast_inselt_undef_fp_combined := [llvmfunc|
  llvm.func @bitcast_inselt_undef_fp(%arg0: i32, %arg1: i567) -> vector<3xf32> {
    %0 = llvm.mlir.undef : vector<3xi32>
    %1 = llvm.insertelement %arg0, %0[%arg1 : i567] : vector<3xi32>
    %2 = llvm.bitcast %1 : vector<3xi32> to vector<3xf32>
    llvm.return %2 : vector<3xf32>
  }]

theorem inst_combine_bitcast_inselt_undef_fp   : bitcast_inselt_undef_fp_before  ⊑  bitcast_inselt_undef_fp_combined := by
  unfold bitcast_inselt_undef_fp_before bitcast_inselt_undef_fp_combined
  simp_alive_peephole
  sorry
def bitcast_inselt_undef_vscale_combined := [llvmfunc|
  llvm.func @bitcast_inselt_undef_vscale(%arg0: i32, %arg1: i567) -> !llvm.vec<? x 3 x  f32> {
    %0 = llvm.mlir.undef : !llvm.vec<? x 3 x  i32>
    %1 = llvm.insertelement %arg0, %0[%arg1 : i567] : !llvm.vec<? x 3 x  i32>
    %2 = llvm.bitcast %1 : !llvm.vec<? x 3 x  i32> to !llvm.vec<? x 3 x  f32>
    llvm.return %2 : !llvm.vec<? x 3 x  f32>
  }]

theorem inst_combine_bitcast_inselt_undef_vscale   : bitcast_inselt_undef_vscale_before  ⊑  bitcast_inselt_undef_vscale_combined := by
  unfold bitcast_inselt_undef_vscale_before bitcast_inselt_undef_vscale_combined
  simp_alive_peephole
  sorry
def bitcast_inselt_undef_extra_use_combined := [llvmfunc|
  llvm.func @bitcast_inselt_undef_extra_use(%arg0: f64, %arg1: i32) -> vector<3xi64> {
    %0 = llvm.mlir.undef : vector<3xi64>
    %1 = llvm.bitcast %arg0 : f64 to i64
    llvm.call @use(%1) : (i64) -> ()
    %2 = llvm.insertelement %1, %0[%arg1 : i32] : vector<3xi64>
    llvm.return %2 : vector<3xi64>
  }]

theorem inst_combine_bitcast_inselt_undef_extra_use   : bitcast_inselt_undef_extra_use_before  ⊑  bitcast_inselt_undef_extra_use_combined := by
  unfold bitcast_inselt_undef_extra_use_before bitcast_inselt_undef_extra_use_combined
  simp_alive_peephole
  sorry
def bitcast_inselt_undef_vec_src_combined := [llvmfunc|
  llvm.func @bitcast_inselt_undef_vec_src(%arg0: vector<2xi32>, %arg1: i32) -> vector<3xi64> {
    %0 = llvm.mlir.undef : vector<3xi64>
    %1 = llvm.bitcast %arg0 : vector<2xi32> to i64
    %2 = llvm.insertelement %1, %0[%arg1 : i32] : vector<3xi64>
    llvm.return %2 : vector<3xi64>
  }]

theorem inst_combine_bitcast_inselt_undef_vec_src   : bitcast_inselt_undef_vec_src_before  ⊑  bitcast_inselt_undef_vec_src_combined := by
  unfold bitcast_inselt_undef_vec_src_before bitcast_inselt_undef_vec_src_combined
  simp_alive_peephole
  sorry
def bitcast_inselt_undef_from_mmx_combined := [llvmfunc|
  llvm.func @bitcast_inselt_undef_from_mmx(%arg0: !llvm.x86_mmx, %arg1: i32) -> vector<3xi64> {
    %0 = llvm.mlir.undef : vector<3xi64>
    %1 = llvm.bitcast %arg0 : !llvm.x86_mmx to i64
    %2 = llvm.insertelement %1, %0[%arg1 : i32] : vector<3xi64>
    llvm.return %2 : vector<3xi64>
  }]

theorem inst_combine_bitcast_inselt_undef_from_mmx   : bitcast_inselt_undef_from_mmx_before  ⊑  bitcast_inselt_undef_from_mmx_combined := by
  unfold bitcast_inselt_undef_from_mmx_before bitcast_inselt_undef_from_mmx_combined
  simp_alive_peephole
  sorry
def PR45748_combined := [llvmfunc|
  llvm.func @PR45748(%arg0: f64, %arg1: f64) -> vector<2xi64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf64>
    %4 = llvm.insertelement %arg1, %3[%2 : i64] : vector<2xf64>
    %5 = llvm.bitcast %4 : vector<2xf64> to vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }]

theorem inst_combine_PR45748   : PR45748_before  ⊑  PR45748_combined := by
  unfold PR45748_before PR45748_combined
  simp_alive_peephole
  sorry
