import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-binop-foldable-floating-point
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def select_maybe_nan_fadd_before := [llvmfunc|
  llvm.func @select_maybe_nan_fadd(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %0, %arg1 : i1, f32
    llvm.return %1 : f32
  }]

def select_fpclass_fadd_before := [llvmfunc|
  llvm.func @select_fpclass_fadd(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %0, %arg1 : i1, f32
    llvm.return %1 : f32
  }]

def select_nnan_fadd_before := [llvmfunc|
  llvm.func @select_nnan_fadd(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fadd_swapped_before := [llvmfunc|
  llvm.func @select_nnan_fadd_swapped(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fadd_fast_math_before := [llvmfunc|
  llvm.func @select_nnan_fadd_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fadd_swapped_fast_math_before := [llvmfunc|
  llvm.func @select_nnan_fadd_swapped_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_nsz_fadd_v4f32_before := [llvmfunc|
  llvm.func @select_nnan_nsz_fadd_v4f32(%arg0: vector<4xi1>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<4xf32>]

    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<4xi1>, vector<4xf32>]

    llvm.return %1 : vector<4xf32>
  }]

def select_nnan_nsz_fadd_nxv4f32_before := [llvmfunc|
  llvm.func @select_nnan_nsz_fadd_nxv4f32(%arg0: !llvm.vec<? x 4 x  i1>, %arg1: !llvm.vec<? x 4 x  f32>, %arg2: !llvm.vec<? x 4 x  f32>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : !llvm.vec<? x 4 x  f32>]

    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : !llvm.vec<? x 4 x  i1>, !llvm.vec<? x 4 x  f32>]

    llvm.return %1 : !llvm.vec<? x 4 x  f32>
  }]

def select_nnan_nsz_fadd_nxv4f32_swapops_before := [llvmfunc|
  llvm.func @select_nnan_nsz_fadd_nxv4f32_swapops(%arg0: !llvm.vec<? x 4 x  i1>, %arg1: !llvm.vec<? x 4 x  f32>, %arg2: !llvm.vec<? x 4 x  f32>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : !llvm.vec<? x 4 x  f32>]

    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<fast>} : !llvm.vec<? x 4 x  i1>, !llvm.vec<? x 4 x  f32>]

    llvm.return %1 : !llvm.vec<? x 4 x  f32>
  }]

def select_nnan_fmul_before := [llvmfunc|
  llvm.func @select_nnan_fmul(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fmul_swapped_before := [llvmfunc|
  llvm.func @select_nnan_fmul_swapped(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fmul_fast_math_before := [llvmfunc|
  llvm.func @select_nnan_fmul_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fmul_swapped_fast_math_before := [llvmfunc|
  llvm.func @select_nnan_fmul_swapped_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fsub_before := [llvmfunc|
  llvm.func @select_nnan_fsub(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fsub_swapped_before := [llvmfunc|
  llvm.func @select_nnan_fsub_swapped(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fsub_fast_math_before := [llvmfunc|
  llvm.func @select_nnan_fsub_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fsub_swapped_fast_math_before := [llvmfunc|
  llvm.func @select_nnan_fsub_swapped_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_nsz_fsub_v4f32_before := [llvmfunc|
  llvm.func @select_nnan_nsz_fsub_v4f32(%arg0: vector<4xi1>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.fsub %arg1, %arg2  : vector<4xf32>
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<4xi1>, vector<4xf32>]

    llvm.return %1 : vector<4xf32>
  }]

def select_nnan_nsz_fsub_nxv4f32_before := [llvmfunc|
  llvm.func @select_nnan_nsz_fsub_nxv4f32(%arg0: !llvm.vec<? x 4 x  i1>, %arg1: !llvm.vec<? x 4 x  f32>, %arg2: !llvm.vec<? x 4 x  f32>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.fsub %arg1, %arg2  : !llvm.vec<? x 4 x  f32>
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : !llvm.vec<? x 4 x  i1>, !llvm.vec<? x 4 x  f32>]

    llvm.return %1 : !llvm.vec<? x 4 x  f32>
  }]

def select_nnan_fsub_invalid_before := [llvmfunc|
  llvm.func @select_nnan_fsub_invalid(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg2, %arg1  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fdiv_before := [llvmfunc|
  llvm.func @select_nnan_fdiv(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fdiv_swapped_before := [llvmfunc|
  llvm.func @select_nnan_fdiv_swapped(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fdiv_fast_math_before := [llvmfunc|
  llvm.func @select_nnan_fdiv_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fdiv_swapped_fast_math_before := [llvmfunc|
  llvm.func @select_nnan_fdiv_swapped_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_nnan_fdiv_invalid_before := [llvmfunc|
  llvm.func @select_nnan_fdiv_invalid(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg2, %arg1  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_maybe_nan_fadd_combined := [llvmfunc|
  llvm.func @select_maybe_nan_fadd(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %arg2, %0 : i1, f32
    %2 = llvm.fadd %1, %arg1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_maybe_nan_fadd   : select_maybe_nan_fadd_before  ⊑  select_maybe_nan_fadd_combined := by
  unfold select_maybe_nan_fadd_before select_maybe_nan_fadd_combined
  simp_alive_peephole
  sorry
def select_fpclass_fadd_combined := [llvmfunc|
  llvm.func @select_fpclass_fadd(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %arg2, %0 : i1, f32
    %2 = llvm.fadd %1, %arg1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_fpclass_fadd   : select_fpclass_fadd_before  ⊑  select_fpclass_fadd_combined := by
  unfold select_fpclass_fadd_before select_fpclass_fadd_combined
  simp_alive_peephole
  sorry
def select_nnan_fadd_combined := [llvmfunc|
  llvm.func @select_nnan_fadd(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %arg2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fadd   : select_nnan_fadd_before  ⊑  select_nnan_fadd_combined := by
  unfold select_nnan_fadd_before select_nnan_fadd_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fadd   : select_nnan_fadd_before  ⊑  select_nnan_fadd_combined := by
  unfold select_nnan_fadd_before select_nnan_fadd_combined
  simp_alive_peephole
  sorry
def select_nnan_fadd_swapped_combined := [llvmfunc|
  llvm.func @select_nnan_fadd_swapped(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %0, %arg2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fadd_swapped   : select_nnan_fadd_swapped_before  ⊑  select_nnan_fadd_swapped_combined := by
  unfold select_nnan_fadd_swapped_before select_nnan_fadd_swapped_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fadd_swapped   : select_nnan_fadd_swapped_before  ⊑  select_nnan_fadd_swapped_combined := by
  unfold select_nnan_fadd_swapped_before select_nnan_fadd_swapped_combined
  simp_alive_peephole
  sorry
def select_nnan_fadd_fast_math_combined := [llvmfunc|
  llvm.func @select_nnan_fadd_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %arg2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fadd_fast_math   : select_nnan_fadd_fast_math_before  ⊑  select_nnan_fadd_fast_math_combined := by
  unfold select_nnan_fadd_fast_math_before select_nnan_fadd_fast_math_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_select_nnan_fadd_fast_math   : select_nnan_fadd_fast_math_before  ⊑  select_nnan_fadd_fast_math_combined := by
  unfold select_nnan_fadd_fast_math_before select_nnan_fadd_fast_math_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fadd_fast_math   : select_nnan_fadd_fast_math_before  ⊑  select_nnan_fadd_fast_math_combined := by
  unfold select_nnan_fadd_fast_math_before select_nnan_fadd_fast_math_combined
  simp_alive_peephole
  sorry
def select_nnan_fadd_swapped_fast_math_combined := [llvmfunc|
  llvm.func @select_nnan_fadd_swapped_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %0, %arg2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fadd_swapped_fast_math   : select_nnan_fadd_swapped_fast_math_before  ⊑  select_nnan_fadd_swapped_fast_math_combined := by
  unfold select_nnan_fadd_swapped_fast_math_before select_nnan_fadd_swapped_fast_math_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_select_nnan_fadd_swapped_fast_math   : select_nnan_fadd_swapped_fast_math_before  ⊑  select_nnan_fadd_swapped_fast_math_combined := by
  unfold select_nnan_fadd_swapped_fast_math_before select_nnan_fadd_swapped_fast_math_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fadd_swapped_fast_math   : select_nnan_fadd_swapped_fast_math_before  ⊑  select_nnan_fadd_swapped_fast_math_combined := by
  unfold select_nnan_fadd_swapped_fast_math_before select_nnan_fadd_swapped_fast_math_combined
  simp_alive_peephole
  sorry
def select_nnan_nsz_fadd_v4f32_combined := [llvmfunc|
  llvm.func @select_nnan_nsz_fadd_v4f32(%arg0: vector<4xi1>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.select %arg0, %arg2, %1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<4xi1>, vector<4xf32>]

theorem inst_combine_select_nnan_nsz_fadd_v4f32   : select_nnan_nsz_fadd_v4f32_before  ⊑  select_nnan_nsz_fadd_v4f32_combined := by
  unfold select_nnan_nsz_fadd_v4f32_before select_nnan_nsz_fadd_v4f32_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fadd %2, %arg1  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<4xf32>]

theorem inst_combine_select_nnan_nsz_fadd_v4f32   : select_nnan_nsz_fadd_v4f32_before  ⊑  select_nnan_nsz_fadd_v4f32_combined := by
  unfold select_nnan_nsz_fadd_v4f32_before select_nnan_nsz_fadd_v4f32_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_select_nnan_nsz_fadd_v4f32   : select_nnan_nsz_fadd_v4f32_before  ⊑  select_nnan_nsz_fadd_v4f32_combined := by
  unfold select_nnan_nsz_fadd_v4f32_before select_nnan_nsz_fadd_v4f32_combined
  simp_alive_peephole
  sorry
def select_nnan_nsz_fadd_nxv4f32_combined := [llvmfunc|
  llvm.func @select_nnan_nsz_fadd_nxv4f32(%arg0: !llvm.vec<? x 4 x  i1>, %arg1: !llvm.vec<? x 4 x  f32>, %arg2: !llvm.vec<? x 4 x  f32>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.undef : !llvm.vec<? x 4 x  f32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 4 x  f32>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 4 x  f32>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 4 x  f32>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 4 x  f32>
    %10 = llvm.select %arg0, %arg2, %9 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : !llvm.vec<? x 4 x  i1>, !llvm.vec<? x 4 x  f32>]

theorem inst_combine_select_nnan_nsz_fadd_nxv4f32   : select_nnan_nsz_fadd_nxv4f32_before  ⊑  select_nnan_nsz_fadd_nxv4f32_combined := by
  unfold select_nnan_nsz_fadd_nxv4f32_before select_nnan_nsz_fadd_nxv4f32_combined
  simp_alive_peephole
  sorry
    %11 = llvm.fadd %10, %arg1  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : !llvm.vec<? x 4 x  f32>]

theorem inst_combine_select_nnan_nsz_fadd_nxv4f32   : select_nnan_nsz_fadd_nxv4f32_before  ⊑  select_nnan_nsz_fadd_nxv4f32_combined := by
  unfold select_nnan_nsz_fadd_nxv4f32_before select_nnan_nsz_fadd_nxv4f32_combined
  simp_alive_peephole
  sorry
    llvm.return %11 : !llvm.vec<? x 4 x  f32>
  }]

theorem inst_combine_select_nnan_nsz_fadd_nxv4f32   : select_nnan_nsz_fadd_nxv4f32_before  ⊑  select_nnan_nsz_fadd_nxv4f32_combined := by
  unfold select_nnan_nsz_fadd_nxv4f32_before select_nnan_nsz_fadd_nxv4f32_combined
  simp_alive_peephole
  sorry
def select_nnan_nsz_fadd_nxv4f32_swapops_combined := [llvmfunc|
  llvm.func @select_nnan_nsz_fadd_nxv4f32_swapops(%arg0: !llvm.vec<? x 4 x  i1>, %arg1: !llvm.vec<? x 4 x  f32>, %arg2: !llvm.vec<? x 4 x  f32>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.undef : !llvm.vec<? x 4 x  f32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 4 x  f32>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 4 x  f32>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 4 x  f32>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 4 x  f32>
    %10 = llvm.select %arg0, %9, %arg2 {fastmathFlags = #llvm.fastmath<fast>} : !llvm.vec<? x 4 x  i1>, !llvm.vec<? x 4 x  f32>]

theorem inst_combine_select_nnan_nsz_fadd_nxv4f32_swapops   : select_nnan_nsz_fadd_nxv4f32_swapops_before  ⊑  select_nnan_nsz_fadd_nxv4f32_swapops_combined := by
  unfold select_nnan_nsz_fadd_nxv4f32_swapops_before select_nnan_nsz_fadd_nxv4f32_swapops_combined
  simp_alive_peephole
  sorry
    %11 = llvm.fadd %10, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : !llvm.vec<? x 4 x  f32>]

theorem inst_combine_select_nnan_nsz_fadd_nxv4f32_swapops   : select_nnan_nsz_fadd_nxv4f32_swapops_before  ⊑  select_nnan_nsz_fadd_nxv4f32_swapops_combined := by
  unfold select_nnan_nsz_fadd_nxv4f32_swapops_before select_nnan_nsz_fadd_nxv4f32_swapops_combined
  simp_alive_peephole
  sorry
    llvm.return %11 : !llvm.vec<? x 4 x  f32>
  }]

theorem inst_combine_select_nnan_nsz_fadd_nxv4f32_swapops   : select_nnan_nsz_fadd_nxv4f32_swapops_before  ⊑  select_nnan_nsz_fadd_nxv4f32_swapops_combined := by
  unfold select_nnan_nsz_fadd_nxv4f32_swapops_before select_nnan_nsz_fadd_nxv4f32_swapops_combined
  simp_alive_peephole
  sorry
def select_nnan_fmul_combined := [llvmfunc|
  llvm.func @select_nnan_fmul(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %arg2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fmul   : select_nnan_fmul_before  ⊑  select_nnan_fmul_combined := by
  unfold select_nnan_fmul_before select_nnan_fmul_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fmul   : select_nnan_fmul_before  ⊑  select_nnan_fmul_combined := by
  unfold select_nnan_fmul_before select_nnan_fmul_combined
  simp_alive_peephole
  sorry
def select_nnan_fmul_swapped_combined := [llvmfunc|
  llvm.func @select_nnan_fmul_swapped(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %0, %arg2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fmul_swapped   : select_nnan_fmul_swapped_before  ⊑  select_nnan_fmul_swapped_combined := by
  unfold select_nnan_fmul_swapped_before select_nnan_fmul_swapped_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fmul_swapped   : select_nnan_fmul_swapped_before  ⊑  select_nnan_fmul_swapped_combined := by
  unfold select_nnan_fmul_swapped_before select_nnan_fmul_swapped_combined
  simp_alive_peephole
  sorry
def select_nnan_fmul_fast_math_combined := [llvmfunc|
  llvm.func @select_nnan_fmul_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %arg2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fmul_fast_math   : select_nnan_fmul_fast_math_before  ⊑  select_nnan_fmul_fast_math_combined := by
  unfold select_nnan_fmul_fast_math_before select_nnan_fmul_fast_math_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_select_nnan_fmul_fast_math   : select_nnan_fmul_fast_math_before  ⊑  select_nnan_fmul_fast_math_combined := by
  unfold select_nnan_fmul_fast_math_before select_nnan_fmul_fast_math_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fmul_fast_math   : select_nnan_fmul_fast_math_before  ⊑  select_nnan_fmul_fast_math_combined := by
  unfold select_nnan_fmul_fast_math_before select_nnan_fmul_fast_math_combined
  simp_alive_peephole
  sorry
def select_nnan_fmul_swapped_fast_math_combined := [llvmfunc|
  llvm.func @select_nnan_fmul_swapped_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %0, %arg2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fmul_swapped_fast_math   : select_nnan_fmul_swapped_fast_math_before  ⊑  select_nnan_fmul_swapped_fast_math_combined := by
  unfold select_nnan_fmul_swapped_fast_math_before select_nnan_fmul_swapped_fast_math_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_select_nnan_fmul_swapped_fast_math   : select_nnan_fmul_swapped_fast_math_before  ⊑  select_nnan_fmul_swapped_fast_math_combined := by
  unfold select_nnan_fmul_swapped_fast_math_before select_nnan_fmul_swapped_fast_math_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fmul_swapped_fast_math   : select_nnan_fmul_swapped_fast_math_before  ⊑  select_nnan_fmul_swapped_fast_math_combined := by
  unfold select_nnan_fmul_swapped_fast_math_before select_nnan_fmul_swapped_fast_math_combined
  simp_alive_peephole
  sorry
def select_nnan_fsub_combined := [llvmfunc|
  llvm.func @select_nnan_fsub(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %arg2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fsub   : select_nnan_fsub_before  ⊑  select_nnan_fsub_combined := by
  unfold select_nnan_fsub_before select_nnan_fsub_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fsub   : select_nnan_fsub_before  ⊑  select_nnan_fsub_combined := by
  unfold select_nnan_fsub_before select_nnan_fsub_combined
  simp_alive_peephole
  sorry
def select_nnan_fsub_swapped_combined := [llvmfunc|
  llvm.func @select_nnan_fsub_swapped(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %0, %arg2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fsub_swapped   : select_nnan_fsub_swapped_before  ⊑  select_nnan_fsub_swapped_combined := by
  unfold select_nnan_fsub_swapped_before select_nnan_fsub_swapped_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fsub_swapped   : select_nnan_fsub_swapped_before  ⊑  select_nnan_fsub_swapped_combined := by
  unfold select_nnan_fsub_swapped_before select_nnan_fsub_swapped_combined
  simp_alive_peephole
  sorry
def select_nnan_fsub_fast_math_combined := [llvmfunc|
  llvm.func @select_nnan_fsub_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %arg2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fsub_fast_math   : select_nnan_fsub_fast_math_before  ⊑  select_nnan_fsub_fast_math_combined := by
  unfold select_nnan_fsub_fast_math_before select_nnan_fsub_fast_math_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_select_nnan_fsub_fast_math   : select_nnan_fsub_fast_math_before  ⊑  select_nnan_fsub_fast_math_combined := by
  unfold select_nnan_fsub_fast_math_before select_nnan_fsub_fast_math_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fsub_fast_math   : select_nnan_fsub_fast_math_before  ⊑  select_nnan_fsub_fast_math_combined := by
  unfold select_nnan_fsub_fast_math_before select_nnan_fsub_fast_math_combined
  simp_alive_peephole
  sorry
def select_nnan_fsub_swapped_fast_math_combined := [llvmfunc|
  llvm.func @select_nnan_fsub_swapped_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %0, %arg2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fsub_swapped_fast_math   : select_nnan_fsub_swapped_fast_math_before  ⊑  select_nnan_fsub_swapped_fast_math_combined := by
  unfold select_nnan_fsub_swapped_fast_math_before select_nnan_fsub_swapped_fast_math_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_select_nnan_fsub_swapped_fast_math   : select_nnan_fsub_swapped_fast_math_before  ⊑  select_nnan_fsub_swapped_fast_math_combined := by
  unfold select_nnan_fsub_swapped_fast_math_before select_nnan_fsub_swapped_fast_math_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fsub_swapped_fast_math   : select_nnan_fsub_swapped_fast_math_before  ⊑  select_nnan_fsub_swapped_fast_math_combined := by
  unfold select_nnan_fsub_swapped_fast_math_before select_nnan_fsub_swapped_fast_math_combined
  simp_alive_peephole
  sorry
def select_nnan_nsz_fsub_v4f32_combined := [llvmfunc|
  llvm.func @select_nnan_nsz_fsub_v4f32(%arg0: vector<4xi1>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.select %arg0, %arg2, %1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<4xi1>, vector<4xf32>]

theorem inst_combine_select_nnan_nsz_fsub_v4f32   : select_nnan_nsz_fsub_v4f32_before  ⊑  select_nnan_nsz_fsub_v4f32_combined := by
  unfold select_nnan_nsz_fsub_v4f32_before select_nnan_nsz_fsub_v4f32_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fsub %arg1, %2  : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_select_nnan_nsz_fsub_v4f32   : select_nnan_nsz_fsub_v4f32_before  ⊑  select_nnan_nsz_fsub_v4f32_combined := by
  unfold select_nnan_nsz_fsub_v4f32_before select_nnan_nsz_fsub_v4f32_combined
  simp_alive_peephole
  sorry
def select_nnan_nsz_fsub_nxv4f32_combined := [llvmfunc|
  llvm.func @select_nnan_nsz_fsub_nxv4f32(%arg0: !llvm.vec<? x 4 x  i1>, %arg1: !llvm.vec<? x 4 x  f32>, %arg2: !llvm.vec<? x 4 x  f32>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.undef : !llvm.vec<? x 4 x  f32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 4 x  f32>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 4 x  f32>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 4 x  f32>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 4 x  f32>
    %10 = llvm.select %arg0, %arg2, %9 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : !llvm.vec<? x 4 x  i1>, !llvm.vec<? x 4 x  f32>]

theorem inst_combine_select_nnan_nsz_fsub_nxv4f32   : select_nnan_nsz_fsub_nxv4f32_before  ⊑  select_nnan_nsz_fsub_nxv4f32_combined := by
  unfold select_nnan_nsz_fsub_nxv4f32_before select_nnan_nsz_fsub_nxv4f32_combined
  simp_alive_peephole
  sorry
    %11 = llvm.fsub %arg1, %10  : !llvm.vec<? x 4 x  f32>
    llvm.return %11 : !llvm.vec<? x 4 x  f32>
  }]

theorem inst_combine_select_nnan_nsz_fsub_nxv4f32   : select_nnan_nsz_fsub_nxv4f32_before  ⊑  select_nnan_nsz_fsub_nxv4f32_combined := by
  unfold select_nnan_nsz_fsub_nxv4f32_before select_nnan_nsz_fsub_nxv4f32_combined
  simp_alive_peephole
  sorry
def select_nnan_fsub_invalid_combined := [llvmfunc|
  llvm.func @select_nnan_fsub_invalid(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg2, %arg1  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fsub_invalid   : select_nnan_fsub_invalid_before  ⊑  select_nnan_fsub_invalid_combined := by
  unfold select_nnan_fsub_invalid_before select_nnan_fsub_invalid_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_select_nnan_fsub_invalid   : select_nnan_fsub_invalid_before  ⊑  select_nnan_fsub_invalid_combined := by
  unfold select_nnan_fsub_invalid_before select_nnan_fsub_invalid_combined
  simp_alive_peephole
  sorry
def select_nnan_fdiv_combined := [llvmfunc|
  llvm.func @select_nnan_fdiv(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %arg2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fdiv   : select_nnan_fdiv_before  ⊑  select_nnan_fdiv_combined := by
  unfold select_nnan_fdiv_before select_nnan_fdiv_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fdiv %arg1, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fdiv   : select_nnan_fdiv_before  ⊑  select_nnan_fdiv_combined := by
  unfold select_nnan_fdiv_before select_nnan_fdiv_combined
  simp_alive_peephole
  sorry
def select_nnan_fdiv_swapped_combined := [llvmfunc|
  llvm.func @select_nnan_fdiv_swapped(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %0, %arg2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fdiv_swapped   : select_nnan_fdiv_swapped_before  ⊑  select_nnan_fdiv_swapped_combined := by
  unfold select_nnan_fdiv_swapped_before select_nnan_fdiv_swapped_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fdiv %arg1, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fdiv_swapped   : select_nnan_fdiv_swapped_before  ⊑  select_nnan_fdiv_swapped_combined := by
  unfold select_nnan_fdiv_swapped_before select_nnan_fdiv_swapped_combined
  simp_alive_peephole
  sorry
def select_nnan_fdiv_fast_math_combined := [llvmfunc|
  llvm.func @select_nnan_fdiv_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %arg2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fdiv_fast_math   : select_nnan_fdiv_fast_math_before  ⊑  select_nnan_fdiv_fast_math_combined := by
  unfold select_nnan_fdiv_fast_math_before select_nnan_fdiv_fast_math_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fdiv %arg1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_select_nnan_fdiv_fast_math   : select_nnan_fdiv_fast_math_before  ⊑  select_nnan_fdiv_fast_math_combined := by
  unfold select_nnan_fdiv_fast_math_before select_nnan_fdiv_fast_math_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fdiv_fast_math   : select_nnan_fdiv_fast_math_before  ⊑  select_nnan_fdiv_fast_math_combined := by
  unfold select_nnan_fdiv_fast_math_before select_nnan_fdiv_fast_math_combined
  simp_alive_peephole
  sorry
def select_nnan_fdiv_swapped_fast_math_combined := [llvmfunc|
  llvm.func @select_nnan_fdiv_swapped_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %0, %arg2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fdiv_swapped_fast_math   : select_nnan_fdiv_swapped_fast_math_before  ⊑  select_nnan_fdiv_swapped_fast_math_combined := by
  unfold select_nnan_fdiv_swapped_fast_math_before select_nnan_fdiv_swapped_fast_math_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fdiv %arg1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_select_nnan_fdiv_swapped_fast_math   : select_nnan_fdiv_swapped_fast_math_before  ⊑  select_nnan_fdiv_swapped_fast_math_combined := by
  unfold select_nnan_fdiv_swapped_fast_math_before select_nnan_fdiv_swapped_fast_math_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_select_nnan_fdiv_swapped_fast_math   : select_nnan_fdiv_swapped_fast_math_before  ⊑  select_nnan_fdiv_swapped_fast_math_combined := by
  unfold select_nnan_fdiv_swapped_fast_math_before select_nnan_fdiv_swapped_fast_math_combined
  simp_alive_peephole
  sorry
def select_nnan_fdiv_invalid_combined := [llvmfunc|
  llvm.func @select_nnan_fdiv_invalid(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg2, %arg1  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_nnan_fdiv_invalid   : select_nnan_fdiv_invalid_before  ⊑  select_nnan_fdiv_invalid_combined := by
  unfold select_nnan_fdiv_invalid_before select_nnan_fdiv_invalid_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_select_nnan_fdiv_invalid   : select_nnan_fdiv_invalid_before  ⊑  select_nnan_fdiv_invalid_combined := by
  unfold select_nnan_fdiv_invalid_before select_nnan_fdiv_invalid_combined
  simp_alive_peephole
  sorry
