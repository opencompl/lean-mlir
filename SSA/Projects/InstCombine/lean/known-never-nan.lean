import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  known-never-nan
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fabs_sqrt_src_maybe_nan_before := [llvmfunc|
  llvm.func @fabs_sqrt_src_maybe_nan(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%0)  : (f64) -> f64
    %2 = llvm.fcmp "ord" %1, %1 : f64
    llvm.return %2 : i1
  }]

def select_maybe_nan_lhs_before := [llvmfunc|
  llvm.func @select_maybe_nan_lhs(%arg0: i1, %arg1: f64, %arg2: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg2, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %2 = llvm.select %arg0, %arg1, %1 : i1, f64
    %3 = llvm.fcmp "ord" %2, %2 : f64
    llvm.return %3 : i1
  }]

def select_maybe_nan_rhs_before := [llvmfunc|
  llvm.func @select_maybe_nan_rhs(%arg0: i1, %arg1: f64, %arg2: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %2 = llvm.select %arg0, %1, %arg2 : i1, f64
    %3 = llvm.fcmp "ord" %2, %2 : f64
    llvm.return %3 : i1
  }]

def nnan_fadd_before := [llvmfunc|
  llvm.func @nnan_fadd(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %3 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %4 = llvm.fadd %2, %3  : f64
    %5 = llvm.fcmp "ord" %4, %4 : f64
    llvm.return %5 : i1
  }]

def nnan_fadd_maybe_nan_lhs_before := [llvmfunc|
  llvm.func @nnan_fadd_maybe_nan_lhs(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %2 = llvm.fadd %arg0, %1  : f64
    %3 = llvm.fcmp "ord" %2, %2 : f64
    llvm.return %3 : i1
  }]

def nnan_fadd_maybe_nan_rhs_before := [llvmfunc|
  llvm.func @nnan_fadd_maybe_nan_rhs(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %2 = llvm.fadd %1, %arg1  : f64
    %3 = llvm.fcmp "ord" %2, %2 : f64
    llvm.return %3 : i1
  }]

def nnan_fmul_before := [llvmfunc|
  llvm.func @nnan_fmul(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %3 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %4 = llvm.fmul %2, %3  : f64
    %5 = llvm.fcmp "ord" %4, %4 : f64
    llvm.return %5 : i1
  }]

def nnan_fsub_before := [llvmfunc|
  llvm.func @nnan_fsub(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %3 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %4 = llvm.fsub %2, %3  : f64
    %5 = llvm.fcmp "ord" %4, %4 : f64
    llvm.return %5 : i1
  }]

def nnan_fneg_before := [llvmfunc|
  llvm.func @nnan_fneg() -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.call @func() {fastmathFlags = #llvm.fastmath<nnan>} : () -> f64]

    %2 = llvm.fsub %0, %1  : f64
    %3 = llvm.fcmp "ord" %2, %2 : f64
    llvm.return %3 : i1
  }]

def nnan_unary_fneg_before := [llvmfunc|
  llvm.func @nnan_unary_fneg() -> i1 {
    %0 = llvm.call @func() {fastmathFlags = #llvm.fastmath<nnan>} : () -> f64]

    %1 = llvm.fneg %0  : f64
    %2 = llvm.fcmp "ord" %1, %1 : f64
    llvm.return %2 : i1
  }]

def fpext_maybe_nan_before := [llvmfunc|
  llvm.func @fpext_maybe_nan(%arg0: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fcmp "ord" %0, %0 : f64
    llvm.return %1 : i1
  }]

def fptrunc_maybe_nan_before := [llvmfunc|
  llvm.func @fptrunc_maybe_nan(%arg0: f64) -> i1 {
    %0 = llvm.fptrunc %arg0 : f64 to f32
    %1 = llvm.fcmp "ord" %0, %0 : f32
    llvm.return %1 : i1
  }]

def nnan_fdiv_before := [llvmfunc|
  llvm.func @nnan_fdiv(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %3 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %4 = llvm.fdiv %2, %3  : f64
    %5 = llvm.fcmp "ord" %4, %4 : f64
    llvm.return %5 : i1
  }]

def nnan_frem_before := [llvmfunc|
  llvm.func @nnan_frem(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %3 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %4 = llvm.frem %2, %3  : f64
    %5 = llvm.fcmp "ord" %4, %4 : f64
    llvm.return %5 : i1
  }]

def fabs_sqrt_src_maybe_nan_combined := [llvmfunc|
  llvm.func @fabs_sqrt_src_maybe_nan(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.intr.sqrt(%1)  : (f64) -> f64
    %3 = llvm.fcmp "ord" %2, %0 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_fabs_sqrt_src_maybe_nan   : fabs_sqrt_src_maybe_nan_before  ⊑  fabs_sqrt_src_maybe_nan_combined := by
  unfold fabs_sqrt_src_maybe_nan_before fabs_sqrt_src_maybe_nan_combined
  simp_alive_peephole
  sorry
def select_maybe_nan_lhs_combined := [llvmfunc|
  llvm.func @select_maybe_nan_lhs(%arg0: i1, %arg1: f64, %arg2: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg2, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_select_maybe_nan_lhs   : select_maybe_nan_lhs_before  ⊑  select_maybe_nan_lhs_combined := by
  unfold select_maybe_nan_lhs_before select_maybe_nan_lhs_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %arg0, %arg1, %2 : i1, f64
    %4 = llvm.fcmp "ord" %3, %1 : f64
    llvm.return %4 : i1
  }]

theorem inst_combine_select_maybe_nan_lhs   : select_maybe_nan_lhs_before  ⊑  select_maybe_nan_lhs_combined := by
  unfold select_maybe_nan_lhs_before select_maybe_nan_lhs_combined
  simp_alive_peephole
  sorry
def select_maybe_nan_rhs_combined := [llvmfunc|
  llvm.func @select_maybe_nan_rhs(%arg0: i1, %arg1: f64, %arg2: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_select_maybe_nan_rhs   : select_maybe_nan_rhs_before  ⊑  select_maybe_nan_rhs_combined := by
  unfold select_maybe_nan_rhs_before select_maybe_nan_rhs_combined
  simp_alive_peephole
  sorry
    %3 = llvm.select %arg0, %2, %arg2 : i1, f64
    %4 = llvm.fcmp "ord" %3, %1 : f64
    llvm.return %4 : i1
  }]

theorem inst_combine_select_maybe_nan_rhs   : select_maybe_nan_rhs_before  ⊑  select_maybe_nan_rhs_combined := by
  unfold select_maybe_nan_rhs_before select_maybe_nan_rhs_combined
  simp_alive_peephole
  sorry
def nnan_fadd_combined := [llvmfunc|
  llvm.func @nnan_fadd(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_nnan_fadd   : nnan_fadd_before  ⊑  nnan_fadd_combined := by
  unfold nnan_fadd_before nnan_fadd_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_nnan_fadd   : nnan_fadd_before  ⊑  nnan_fadd_combined := by
  unfold nnan_fadd_before nnan_fadd_combined
  simp_alive_peephole
  sorry
    %5 = llvm.fadd %3, %4  : f64
    %6 = llvm.fcmp "ord" %5, %2 : f64
    llvm.return %6 : i1
  }]

theorem inst_combine_nnan_fadd   : nnan_fadd_before  ⊑  nnan_fadd_combined := by
  unfold nnan_fadd_before nnan_fadd_combined
  simp_alive_peephole
  sorry
def nnan_fadd_maybe_nan_lhs_combined := [llvmfunc|
  llvm.func @nnan_fadd_maybe_nan_lhs(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_nnan_fadd_maybe_nan_lhs   : nnan_fadd_maybe_nan_lhs_before  ⊑  nnan_fadd_maybe_nan_lhs_combined := by
  unfold nnan_fadd_maybe_nan_lhs_before nnan_fadd_maybe_nan_lhs_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fadd %2, %arg0  : f64
    %4 = llvm.fcmp "ord" %3, %1 : f64
    llvm.return %4 : i1
  }]

theorem inst_combine_nnan_fadd_maybe_nan_lhs   : nnan_fadd_maybe_nan_lhs_before  ⊑  nnan_fadd_maybe_nan_lhs_combined := by
  unfold nnan_fadd_maybe_nan_lhs_before nnan_fadd_maybe_nan_lhs_combined
  simp_alive_peephole
  sorry
def nnan_fadd_maybe_nan_rhs_combined := [llvmfunc|
  llvm.func @nnan_fadd_maybe_nan_rhs(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_nnan_fadd_maybe_nan_rhs   : nnan_fadd_maybe_nan_rhs_before  ⊑  nnan_fadd_maybe_nan_rhs_combined := by
  unfold nnan_fadd_maybe_nan_rhs_before nnan_fadd_maybe_nan_rhs_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fadd %2, %arg1  : f64
    %4 = llvm.fcmp "ord" %3, %1 : f64
    llvm.return %4 : i1
  }]

theorem inst_combine_nnan_fadd_maybe_nan_rhs   : nnan_fadd_maybe_nan_rhs_before  ⊑  nnan_fadd_maybe_nan_rhs_combined := by
  unfold nnan_fadd_maybe_nan_rhs_before nnan_fadd_maybe_nan_rhs_combined
  simp_alive_peephole
  sorry
def nnan_fmul_combined := [llvmfunc|
  llvm.func @nnan_fmul(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_nnan_fmul   : nnan_fmul_before  ⊑  nnan_fmul_combined := by
  unfold nnan_fmul_before nnan_fmul_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_nnan_fmul   : nnan_fmul_before  ⊑  nnan_fmul_combined := by
  unfold nnan_fmul_before nnan_fmul_combined
  simp_alive_peephole
  sorry
    %5 = llvm.fmul %3, %4  : f64
    %6 = llvm.fcmp "ord" %5, %2 : f64
    llvm.return %6 : i1
  }]

theorem inst_combine_nnan_fmul   : nnan_fmul_before  ⊑  nnan_fmul_combined := by
  unfold nnan_fmul_before nnan_fmul_combined
  simp_alive_peephole
  sorry
def nnan_fsub_combined := [llvmfunc|
  llvm.func @nnan_fsub(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_nnan_fsub   : nnan_fsub_before  ⊑  nnan_fsub_combined := by
  unfold nnan_fsub_before nnan_fsub_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_nnan_fsub   : nnan_fsub_before  ⊑  nnan_fsub_combined := by
  unfold nnan_fsub_before nnan_fsub_combined
  simp_alive_peephole
  sorry
    %5 = llvm.fsub %3, %4  : f64
    %6 = llvm.fcmp "ord" %5, %2 : f64
    llvm.return %6 : i1
  }]

theorem inst_combine_nnan_fsub   : nnan_fsub_before  ⊑  nnan_fsub_combined := by
  unfold nnan_fsub_before nnan_fsub_combined
  simp_alive_peephole
  sorry
def nnan_fneg_combined := [llvmfunc|
  llvm.func @nnan_fneg() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.call @func() {fastmathFlags = #llvm.fastmath<nnan>} : () -> f64]

theorem inst_combine_nnan_fneg   : nnan_fneg_before  ⊑  nnan_fneg_combined := by
  unfold nnan_fneg_before nnan_fneg_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_nnan_fneg   : nnan_fneg_before  ⊑  nnan_fneg_combined := by
  unfold nnan_fneg_before nnan_fneg_combined
  simp_alive_peephole
  sorry
def nnan_unary_fneg_combined := [llvmfunc|
  llvm.func @nnan_unary_fneg() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.call @func() {fastmathFlags = #llvm.fastmath<nnan>} : () -> f64]

theorem inst_combine_nnan_unary_fneg   : nnan_unary_fneg_before  ⊑  nnan_unary_fneg_combined := by
  unfold nnan_unary_fneg_before nnan_unary_fneg_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_nnan_unary_fneg   : nnan_unary_fneg_before  ⊑  nnan_unary_fneg_combined := by
  unfold nnan_unary_fneg_before nnan_unary_fneg_combined
  simp_alive_peephole
  sorry
def fpext_maybe_nan_combined := [llvmfunc|
  llvm.func @fpext_maybe_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_fpext_maybe_nan   : fpext_maybe_nan_before  ⊑  fpext_maybe_nan_combined := by
  unfold fpext_maybe_nan_before fpext_maybe_nan_combined
  simp_alive_peephole
  sorry
def fptrunc_maybe_nan_combined := [llvmfunc|
  llvm.func @fptrunc_maybe_nan(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fptrunc %arg0 : f64 to f32
    %2 = llvm.fcmp "ord" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fptrunc_maybe_nan   : fptrunc_maybe_nan_before  ⊑  fptrunc_maybe_nan_combined := by
  unfold fptrunc_maybe_nan_before fptrunc_maybe_nan_combined
  simp_alive_peephole
  sorry
def nnan_fdiv_combined := [llvmfunc|
  llvm.func @nnan_fdiv(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_nnan_fdiv   : nnan_fdiv_before  ⊑  nnan_fdiv_combined := by
  unfold nnan_fdiv_before nnan_fdiv_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_nnan_fdiv   : nnan_fdiv_before  ⊑  nnan_fdiv_combined := by
  unfold nnan_fdiv_before nnan_fdiv_combined
  simp_alive_peephole
  sorry
    %5 = llvm.fdiv %3, %4  : f64
    %6 = llvm.fcmp "ord" %5, %2 : f64
    llvm.return %6 : i1
  }]

theorem inst_combine_nnan_fdiv   : nnan_fdiv_before  ⊑  nnan_fdiv_combined := by
  unfold nnan_fdiv_before nnan_fdiv_combined
  simp_alive_peephole
  sorry
def nnan_frem_combined := [llvmfunc|
  llvm.func @nnan_frem(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_nnan_frem   : nnan_frem_before  ⊑  nnan_frem_combined := by
  unfold nnan_frem_before nnan_frem_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_nnan_frem   : nnan_frem_before  ⊑  nnan_frem_combined := by
  unfold nnan_frem_before nnan_frem_combined
  simp_alive_peephole
  sorry
    %5 = llvm.frem %3, %4  : f64
    %6 = llvm.fcmp "ord" %5, %2 : f64
    llvm.return %6 : i1
  }]

theorem inst_combine_nnan_frem   : nnan_frem_before  ⊑  nnan_frem_combined := by
  unfold nnan_frem_before nnan_frem_combined
  simp_alive_peephole
  sorry
