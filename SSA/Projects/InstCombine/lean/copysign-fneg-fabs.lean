import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  copysign-fneg-fabs
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def copysign_fneg_x_before := [llvmfunc|
  llvm.func @copysign_fneg_x(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.fneg %arg0  : f16
    %1 = llvm.intr.copysign(%0, %arg1)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

def copysign_fabs_x_before := [llvmfunc|
  llvm.func @copysign_fabs_x(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %1 = llvm.intr.copysign(%0, %arg1)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

def copysign_fneg_fabs_x_before := [llvmfunc|
  llvm.func @copysign_fneg_fabs_x(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %1 = llvm.fneg %0  : f16
    %2 = llvm.intr.copysign(%1, %arg1)  : (f16, f16) -> f16
    llvm.return %2 : f16
  }]

def copysign_fneg_y_before := [llvmfunc|
  llvm.func @copysign_fneg_y(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.fneg %arg1  : f16
    %1 = llvm.intr.copysign(%arg0, %0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

def copysign_fabs_y_before := [llvmfunc|
  llvm.func @copysign_fabs_y(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg1)  : (f16) -> f16
    %1 = llvm.intr.copysign(%arg0, %0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

def copysign_fneg_fabs_y_before := [llvmfunc|
  llvm.func @copysign_fneg_fabs_y(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg1)  : (f16) -> f16
    %1 = llvm.fneg %0  : f16
    %2 = llvm.intr.copysign(%arg0, %1)  : (f16, f16) -> f16
    llvm.return %2 : f16
  }]

def fneg_copysign_before := [llvmfunc|
  llvm.func @fneg_copysign(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    %1 = llvm.fneg %0  : f16
    llvm.return %1 : f16
  }]

def fneg_fabs_copysign_before := [llvmfunc|
  llvm.func @fneg_fabs_copysign(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    %2 = llvm.fneg %1  : f16
    llvm.return %2 : f16
  }]

def fabs_copysign_before := [llvmfunc|
  llvm.func @fabs_copysign(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    llvm.return %1 : f16
  }]

def fneg_copysign_vector_before := [llvmfunc|
  llvm.func @fneg_copysign_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    %1 = llvm.fneg %0  : vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }]

def fneg_fabs_copysign_vector_before := [llvmfunc|
  llvm.func @fneg_fabs_copysign_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    %1 = llvm.intr.fabs(%0)  : (vector<2xf16>) -> vector<2xf16>
    %2 = llvm.fneg %1  : vector<2xf16>
    llvm.return %2 : vector<2xf16>
  }]

def fabs_copysign_vector_before := [llvmfunc|
  llvm.func @fabs_copysign_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    %1 = llvm.intr.fabs(%0)  : (vector<2xf16>) -> vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }]

def fneg_copysign_flags_before := [llvmfunc|
  llvm.func @fneg_copysign_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f16, f16) -> f16]

    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f16]

    llvm.return %1 : f16
  }]

def fneg_fabs_copysign_flags_before := [llvmfunc|
  llvm.func @fneg_fabs_copysign_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (f16, f16) -> f16]

    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f16) -> f16]

    %2 = llvm.fneg %1  {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : f16]

    llvm.return %2 : f16
  }]

def fneg_nsz_copysign_before := [llvmfunc|
  llvm.func @fneg_nsz_copysign(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nsz>} : f16]

    llvm.return %1 : f16
  }]

def fneg_fabs_copysign_flags_none_fabs_before := [llvmfunc|
  llvm.func @fneg_fabs_copysign_flags_none_fabs(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (f16, f16) -> f16]

    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    %2 = llvm.fneg %1  {fastmathFlags = #llvm.fastmath<fast>} : f16]

    llvm.return %2 : f16
  }]

def fabs_copysign_flags_before := [llvmfunc|
  llvm.func @fabs_copysign_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan>} : (f16, f16) -> f16]

    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f16) -> f16]

    llvm.return %1 : f16
  }]

def fabs_copysign_all_flags_before := [llvmfunc|
  llvm.func @fabs_copysign_all_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f16, f16) -> f16]

    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f16) -> f16]

    llvm.return %1 : f16
  }]

def fabs_copysign_no_flags_copysign_user_before := [llvmfunc|
  llvm.func @fabs_copysign_no_flags_copysign_user(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.store %0, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr]

    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f16) -> f16]

    llvm.return %1 : f16
  }]

def fneg_fabs_copysign_drop_flags_before := [llvmfunc|
  llvm.func @fneg_fabs_copysign_drop_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan>} : (f16, f16) -> f16]

    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f16) -> f16]

    %2 = llvm.fneg %1  {fastmathFlags = #llvm.fastmath<nsz>} : f16]

    llvm.return %2 : f16
  }]

def fneg_copysign_multi_use_before := [llvmfunc|
  llvm.func @fneg_copysign_multi_use(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.store %0, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr]

    %1 = llvm.fneg %0  : f16
    llvm.return %1 : f16
  }]

def fabs_copysign_multi_use_before := [llvmfunc|
  llvm.func @fabs_copysign_multi_use(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.store %0, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr]

    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    llvm.return %1 : f16
  }]

def fabs_flags_copysign_multi_use_before := [llvmfunc|
  llvm.func @fabs_flags_copysign_multi_use(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.store %0, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr]

    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f16) -> f16]

    llvm.return %1 : f16
  }]

def fneg_fabs_copysign_multi_use_fabs_before := [llvmfunc|
  llvm.func @fneg_fabs_copysign_multi_use_fabs(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    llvm.store %1, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr]

    llvm.return %1 : f16
  }]

def copysign_pos_before := [llvmfunc|
  llvm.func @copysign_pos(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

def copysign_neg_before := [llvmfunc|
  llvm.func @copysign_neg(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

def copysign_negzero_before := [llvmfunc|
  llvm.func @copysign_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

def copysign_negnan_before := [llvmfunc|
  llvm.func @copysign_negnan(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(0xFE00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

def copysign_neginf_before := [llvmfunc|
  llvm.func @copysign_neginf(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

def copysign_splat_before := [llvmfunc|
  llvm.func @copysign_splat(%arg0: vector<4xf16>) -> vector<4xf16> {
    %0 = llvm.mlir.constant(dense<-1.000000e+00> : vector<4xf16>) : vector<4xf16>
    %1 = llvm.intr.copysign(%0, %arg0)  : (vector<4xf16>, vector<4xf16>) -> vector<4xf16>
    llvm.return %1 : vector<4xf16>
  }]

def copysign_vec4_before := [llvmfunc|
  llvm.func @copysign_vec4(%arg0: vector<4xf16>) -> vector<4xf16> {
    %0 = llvm.mlir.poison : f16
    %1 = llvm.mlir.undef : f16
    %2 = llvm.mlir.constant(-1.000000e+00 : f16) : f16
    %3 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %4 = llvm.mlir.undef : vector<4xf16>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf16>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf16>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xf16>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xf16>
    %13 = llvm.intr.copysign(%12, %arg0)  : (vector<4xf16>, vector<4xf16>) -> vector<4xf16>
    llvm.return %13 : vector<4xf16>
  }]

def copysign_fneg_x_combined := [llvmfunc|
  llvm.func @copysign_fneg_x(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.return %0 : f16
  }]

theorem inst_combine_copysign_fneg_x   : copysign_fneg_x_before  ⊑  copysign_fneg_x_combined := by
  unfold copysign_fneg_x_before copysign_fneg_x_combined
  simp_alive_peephole
  sorry
def copysign_fabs_x_combined := [llvmfunc|
  llvm.func @copysign_fabs_x(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.return %0 : f16
  }]

theorem inst_combine_copysign_fabs_x   : copysign_fabs_x_before  ⊑  copysign_fabs_x_combined := by
  unfold copysign_fabs_x_before copysign_fabs_x_combined
  simp_alive_peephole
  sorry
def copysign_fneg_fabs_x_combined := [llvmfunc|
  llvm.func @copysign_fneg_fabs_x(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.return %0 : f16
  }]

theorem inst_combine_copysign_fneg_fabs_x   : copysign_fneg_fabs_x_before  ⊑  copysign_fneg_fabs_x_combined := by
  unfold copysign_fneg_fabs_x_before copysign_fneg_fabs_x_combined
  simp_alive_peephole
  sorry
def copysign_fneg_y_combined := [llvmfunc|
  llvm.func @copysign_fneg_y(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.fneg %arg1  : f16
    %1 = llvm.intr.copysign(%arg0, %0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_copysign_fneg_y   : copysign_fneg_y_before  ⊑  copysign_fneg_y_combined := by
  unfold copysign_fneg_y_before copysign_fneg_y_combined
  simp_alive_peephole
  sorry
def copysign_fabs_y_combined := [llvmfunc|
  llvm.func @copysign_fabs_y(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    llvm.return %0 : f16
  }]

theorem inst_combine_copysign_fabs_y   : copysign_fabs_y_before  ⊑  copysign_fabs_y_combined := by
  unfold copysign_fabs_y_before copysign_fabs_y_combined
  simp_alive_peephole
  sorry
def copysign_fneg_fabs_y_combined := [llvmfunc|
  llvm.func @copysign_fneg_fabs_y(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg1)  : (f16) -> f16
    %1 = llvm.fneg %0  : f16
    %2 = llvm.intr.copysign(%arg0, %1)  : (f16, f16) -> f16
    llvm.return %2 : f16
  }]

theorem inst_combine_copysign_fneg_fabs_y   : copysign_fneg_fabs_y_before  ⊑  copysign_fneg_fabs_y_combined := by
  unfold copysign_fneg_fabs_y_before copysign_fneg_fabs_y_combined
  simp_alive_peephole
  sorry
def fneg_copysign_combined := [llvmfunc|
  llvm.func @fneg_copysign(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.fneg %arg1  : f16
    %1 = llvm.intr.copysign(%arg0, %0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_fneg_copysign   : fneg_copysign_before  ⊑  fneg_copysign_combined := by
  unfold fneg_copysign_before fneg_copysign_combined
  simp_alive_peephole
  sorry
def fneg_fabs_copysign_combined := [llvmfunc|
  llvm.func @fneg_fabs_copysign(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %1 = llvm.fneg %0  : f16
    llvm.return %1 : f16
  }]

theorem inst_combine_fneg_fabs_copysign   : fneg_fabs_copysign_before  ⊑  fneg_fabs_copysign_combined := by
  unfold fneg_fabs_copysign_before fneg_fabs_copysign_combined
  simp_alive_peephole
  sorry
def fabs_copysign_combined := [llvmfunc|
  llvm.func @fabs_copysign(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    llvm.return %0 : f16
  }]

theorem inst_combine_fabs_copysign   : fabs_copysign_before  ⊑  fabs_copysign_combined := by
  unfold fabs_copysign_before fabs_copysign_combined
  simp_alive_peephole
  sorry
def fneg_copysign_vector_combined := [llvmfunc|
  llvm.func @fneg_copysign_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.fneg %arg1  : vector<2xf16>
    %1 = llvm.intr.copysign(%arg0, %0)  : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }]

theorem inst_combine_fneg_copysign_vector   : fneg_copysign_vector_before  ⊑  fneg_copysign_vector_combined := by
  unfold fneg_copysign_vector_before fneg_copysign_vector_combined
  simp_alive_peephole
  sorry
def fneg_fabs_copysign_vector_combined := [llvmfunc|
  llvm.func @fneg_fabs_copysign_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    %1 = llvm.fneg %0  : vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }]

theorem inst_combine_fneg_fabs_copysign_vector   : fneg_fabs_copysign_vector_before  ⊑  fneg_fabs_copysign_vector_combined := by
  unfold fneg_fabs_copysign_vector_before fneg_fabs_copysign_vector_combined
  simp_alive_peephole
  sorry
def fabs_copysign_vector_combined := [llvmfunc|
  llvm.func @fabs_copysign_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    llvm.return %0 : vector<2xf16>
  }]

theorem inst_combine_fabs_copysign_vector   : fabs_copysign_vector_before  ⊑  fabs_copysign_vector_combined := by
  unfold fabs_copysign_vector_before fabs_copysign_vector_combined
  simp_alive_peephole
  sorry
def fneg_copysign_flags_combined := [llvmfunc|
  llvm.func @fneg_copysign_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.fneg %arg1  {fastmathFlags = #llvm.fastmath<nsz>} : f16]

theorem inst_combine_fneg_copysign_flags   : fneg_copysign_flags_before  ⊑  fneg_copysign_flags_combined := by
  unfold fneg_copysign_flags_before fneg_copysign_flags_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f16, f16) -> f16]

theorem inst_combine_fneg_copysign_flags   : fneg_copysign_flags_before  ⊑  fneg_copysign_flags_combined := by
  unfold fneg_copysign_flags_before fneg_copysign_flags_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f16
  }]

theorem inst_combine_fneg_copysign_flags   : fneg_copysign_flags_before  ⊑  fneg_copysign_flags_combined := by
  unfold fneg_copysign_flags_before fneg_copysign_flags_combined
  simp_alive_peephole
  sorry
def fneg_fabs_copysign_flags_combined := [llvmfunc|
  llvm.func @fneg_fabs_copysign_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f16) -> f16]

theorem inst_combine_fneg_fabs_copysign_flags   : fneg_fabs_copysign_flags_before  ⊑  fneg_fabs_copysign_flags_combined := by
  unfold fneg_fabs_copysign_flags_before fneg_fabs_copysign_flags_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : f16]

theorem inst_combine_fneg_fabs_copysign_flags   : fneg_fabs_copysign_flags_before  ⊑  fneg_fabs_copysign_flags_combined := by
  unfold fneg_fabs_copysign_flags_before fneg_fabs_copysign_flags_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f16
  }]

theorem inst_combine_fneg_fabs_copysign_flags   : fneg_fabs_copysign_flags_before  ⊑  fneg_fabs_copysign_flags_combined := by
  unfold fneg_fabs_copysign_flags_before fneg_fabs_copysign_flags_combined
  simp_alive_peephole
  sorry
def fneg_nsz_copysign_combined := [llvmfunc|
  llvm.func @fneg_nsz_copysign(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.fneg %arg1  : f16
    %1 = llvm.intr.copysign(%arg0, %0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_fneg_nsz_copysign   : fneg_nsz_copysign_before  ⊑  fneg_nsz_copysign_combined := by
  unfold fneg_nsz_copysign_before fneg_nsz_copysign_combined
  simp_alive_peephole
  sorry
def fneg_fabs_copysign_flags_none_fabs_combined := [llvmfunc|
  llvm.func @fneg_fabs_copysign_flags_none_fabs(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_fneg_fabs_copysign_flags_none_fabs   : fneg_fabs_copysign_flags_none_fabs_before  ⊑  fneg_fabs_copysign_flags_none_fabs_combined := by
  unfold fneg_fabs_copysign_flags_none_fabs_before fneg_fabs_copysign_flags_none_fabs_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f16
  }]

theorem inst_combine_fneg_fabs_copysign_flags_none_fabs   : fneg_fabs_copysign_flags_none_fabs_before  ⊑  fneg_fabs_copysign_flags_none_fabs_combined := by
  unfold fneg_fabs_copysign_flags_none_fabs_before fneg_fabs_copysign_flags_none_fabs_combined
  simp_alive_peephole
  sorry
def fabs_copysign_flags_combined := [llvmfunc|
  llvm.func @fabs_copysign_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f16) -> f16]

theorem inst_combine_fabs_copysign_flags   : fabs_copysign_flags_before  ⊑  fabs_copysign_flags_combined := by
  unfold fabs_copysign_flags_before fabs_copysign_flags_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f16
  }]

theorem inst_combine_fabs_copysign_flags   : fabs_copysign_flags_before  ⊑  fabs_copysign_flags_combined := by
  unfold fabs_copysign_flags_before fabs_copysign_flags_combined
  simp_alive_peephole
  sorry
def fabs_copysign_all_flags_combined := [llvmfunc|
  llvm.func @fabs_copysign_all_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f16) -> f16]

theorem inst_combine_fabs_copysign_all_flags   : fabs_copysign_all_flags_before  ⊑  fabs_copysign_all_flags_combined := by
  unfold fabs_copysign_all_flags_before fabs_copysign_all_flags_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f16
  }]

theorem inst_combine_fabs_copysign_all_flags   : fabs_copysign_all_flags_before  ⊑  fabs_copysign_all_flags_combined := by
  unfold fabs_copysign_all_flags_before fabs_copysign_all_flags_combined
  simp_alive_peephole
  sorry
def fabs_copysign_no_flags_copysign_user_combined := [llvmfunc|
  llvm.func @fabs_copysign_no_flags_copysign_user(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.store %0, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr]

theorem inst_combine_fabs_copysign_no_flags_copysign_user   : fabs_copysign_no_flags_copysign_user_before  ⊑  fabs_copysign_no_flags_copysign_user_combined := by
  unfold fabs_copysign_no_flags_copysign_user_before fabs_copysign_no_flags_copysign_user_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f16) -> f16]

theorem inst_combine_fabs_copysign_no_flags_copysign_user   : fabs_copysign_no_flags_copysign_user_before  ⊑  fabs_copysign_no_flags_copysign_user_combined := by
  unfold fabs_copysign_no_flags_copysign_user_before fabs_copysign_no_flags_copysign_user_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f16
  }]

theorem inst_combine_fabs_copysign_no_flags_copysign_user   : fabs_copysign_no_flags_copysign_user_before  ⊑  fabs_copysign_no_flags_copysign_user_combined := by
  unfold fabs_copysign_no_flags_copysign_user_before fabs_copysign_no_flags_copysign_user_combined
  simp_alive_peephole
  sorry
def fneg_fabs_copysign_drop_flags_combined := [llvmfunc|
  llvm.func @fneg_fabs_copysign_drop_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f16) -> f16]

theorem inst_combine_fneg_fabs_copysign_drop_flags   : fneg_fabs_copysign_drop_flags_before  ⊑  fneg_fabs_copysign_drop_flags_combined := by
  unfold fneg_fabs_copysign_drop_flags_before fneg_fabs_copysign_drop_flags_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nsz>} : f16]

theorem inst_combine_fneg_fabs_copysign_drop_flags   : fneg_fabs_copysign_drop_flags_before  ⊑  fneg_fabs_copysign_drop_flags_combined := by
  unfold fneg_fabs_copysign_drop_flags_before fneg_fabs_copysign_drop_flags_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f16
  }]

theorem inst_combine_fneg_fabs_copysign_drop_flags   : fneg_fabs_copysign_drop_flags_before  ⊑  fneg_fabs_copysign_drop_flags_combined := by
  unfold fneg_fabs_copysign_drop_flags_before fneg_fabs_copysign_drop_flags_combined
  simp_alive_peephole
  sorry
def fneg_copysign_multi_use_combined := [llvmfunc|
  llvm.func @fneg_copysign_multi_use(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.store %0, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr]

theorem inst_combine_fneg_copysign_multi_use   : fneg_copysign_multi_use_before  ⊑  fneg_copysign_multi_use_combined := by
  unfold fneg_copysign_multi_use_before fneg_copysign_multi_use_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fneg %0  : f16
    llvm.return %1 : f16
  }]

theorem inst_combine_fneg_copysign_multi_use   : fneg_copysign_multi_use_before  ⊑  fneg_copysign_multi_use_combined := by
  unfold fneg_copysign_multi_use_before fneg_copysign_multi_use_combined
  simp_alive_peephole
  sorry
def fabs_copysign_multi_use_combined := [llvmfunc|
  llvm.func @fabs_copysign_multi_use(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.store %0, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr]

theorem inst_combine_fabs_copysign_multi_use   : fabs_copysign_multi_use_before  ⊑  fabs_copysign_multi_use_combined := by
  unfold fabs_copysign_multi_use_before fabs_copysign_multi_use_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_fabs_copysign_multi_use   : fabs_copysign_multi_use_before  ⊑  fabs_copysign_multi_use_combined := by
  unfold fabs_copysign_multi_use_before fabs_copysign_multi_use_combined
  simp_alive_peephole
  sorry
def fabs_flags_copysign_multi_use_combined := [llvmfunc|
  llvm.func @fabs_flags_copysign_multi_use(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.store %0, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr]

theorem inst_combine_fabs_flags_copysign_multi_use   : fabs_flags_copysign_multi_use_before  ⊑  fabs_flags_copysign_multi_use_combined := by
  unfold fabs_flags_copysign_multi_use_before fabs_flags_copysign_multi_use_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f16) -> f16]

theorem inst_combine_fabs_flags_copysign_multi_use   : fabs_flags_copysign_multi_use_before  ⊑  fabs_flags_copysign_multi_use_combined := by
  unfold fabs_flags_copysign_multi_use_before fabs_flags_copysign_multi_use_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f16
  }]

theorem inst_combine_fabs_flags_copysign_multi_use   : fabs_flags_copysign_multi_use_before  ⊑  fabs_flags_copysign_multi_use_combined := by
  unfold fabs_flags_copysign_multi_use_before fabs_flags_copysign_multi_use_combined
  simp_alive_peephole
  sorry
def fneg_fabs_copysign_multi_use_fabs_combined := [llvmfunc|
  llvm.func @fneg_fabs_copysign_multi_use_fabs(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    llvm.store %0, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr]

theorem inst_combine_fneg_fabs_copysign_multi_use_fabs   : fneg_fabs_copysign_multi_use_fabs_before  ⊑  fneg_fabs_copysign_multi_use_fabs_combined := by
  unfold fneg_fabs_copysign_multi_use_fabs_before fneg_fabs_copysign_multi_use_fabs_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f16
  }]

theorem inst_combine_fneg_fabs_copysign_multi_use_fabs   : fneg_fabs_copysign_multi_use_fabs_before  ⊑  fneg_fabs_copysign_multi_use_fabs_combined := by
  unfold fneg_fabs_copysign_multi_use_fabs_before fneg_fabs_copysign_multi_use_fabs_combined
  simp_alive_peephole
  sorry
def copysign_pos_combined := [llvmfunc|
  llvm.func @copysign_pos(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_copysign_pos   : copysign_pos_before  ⊑  copysign_pos_combined := by
  unfold copysign_pos_before copysign_pos_combined
  simp_alive_peephole
  sorry
def copysign_neg_combined := [llvmfunc|
  llvm.func @copysign_neg(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_copysign_neg   : copysign_neg_before  ⊑  copysign_neg_combined := by
  unfold copysign_neg_before copysign_neg_combined
  simp_alive_peephole
  sorry
def copysign_negzero_combined := [llvmfunc|
  llvm.func @copysign_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_copysign_negzero   : copysign_negzero_before  ⊑  copysign_negzero_combined := by
  unfold copysign_negzero_before copysign_negzero_combined
  simp_alive_peephole
  sorry
def copysign_negnan_combined := [llvmfunc|
  llvm.func @copysign_negnan(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(0xFE00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_copysign_negnan   : copysign_negnan_before  ⊑  copysign_negnan_combined := by
  unfold copysign_negnan_before copysign_negnan_combined
  simp_alive_peephole
  sorry
def copysign_neginf_combined := [llvmfunc|
  llvm.func @copysign_neginf(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_copysign_neginf   : copysign_neginf_before  ⊑  copysign_neginf_combined := by
  unfold copysign_neginf_before copysign_neginf_combined
  simp_alive_peephole
  sorry
def copysign_splat_combined := [llvmfunc|
  llvm.func @copysign_splat(%arg0: vector<4xf16>) -> vector<4xf16> {
    %0 = llvm.mlir.constant(dense<-1.000000e+00> : vector<4xf16>) : vector<4xf16>
    %1 = llvm.intr.copysign(%0, %arg0)  : (vector<4xf16>, vector<4xf16>) -> vector<4xf16>
    llvm.return %1 : vector<4xf16>
  }]

theorem inst_combine_copysign_splat   : copysign_splat_before  ⊑  copysign_splat_combined := by
  unfold copysign_splat_before copysign_splat_combined
  simp_alive_peephole
  sorry
def copysign_vec4_combined := [llvmfunc|
  llvm.func @copysign_vec4(%arg0: vector<4xf16>) -> vector<4xf16> {
    %0 = llvm.mlir.poison : f16
    %1 = llvm.mlir.undef : f16
    %2 = llvm.mlir.constant(-1.000000e+00 : f16) : f16
    %3 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %4 = llvm.mlir.undef : vector<4xf16>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf16>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf16>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xf16>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xf16>
    %13 = llvm.intr.copysign(%12, %arg0)  : (vector<4xf16>, vector<4xf16>) -> vector<4xf16>
    llvm.return %13 : vector<4xf16>
  }]

theorem inst_combine_copysign_vec4   : copysign_vec4_before  ⊑  copysign_vec4_combined := by
  unfold copysign_vec4_before copysign_vec4_combined
  simp_alive_peephole
  sorry
