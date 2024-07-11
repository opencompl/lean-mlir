import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fmul-sqrt
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sqrt_a_sqrt_b_before := [llvmfunc|
  llvm.func @sqrt_a_sqrt_b(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.return %2 : f64
  }]

def sqrt_a_sqrt_b_multiple_uses_before := [llvmfunc|
  llvm.func @sqrt_a_sqrt_b_multiple_uses(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %1 = llvm.intr.sqrt(%arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

def sqrt_a_sqrt_b_reassoc_nnan_before := [llvmfunc|
  llvm.func @sqrt_a_sqrt_b_reassoc_nnan(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_a_sqrt_b_reassoc_before := [llvmfunc|
  llvm.func @sqrt_a_sqrt_b_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_before := [llvmfunc|
  llvm.func @sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  : (f64) -> f64
    %2 = llvm.intr.sqrt(%arg2)  : (f64) -> f64
    %3 = llvm.intr.sqrt(%arg3)  : (f64) -> f64
    %4 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<nnan, arcp, reassoc>} : f64]

    %5 = llvm.fmul %4, %2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

    %6 = llvm.fmul %5, %3  {fastmathFlags = #llvm.fastmath<nnan, ninf, reassoc>} : f64]

    llvm.return %6 : f64
  }]

def rsqrt_squared_before := [llvmfunc|
  llvm.func @rsqrt_squared(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.fmul %2, %2  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %3 : f64
  }]

def rsqrt_x_reassociate_extra_use_before := [llvmfunc|
  llvm.func @rsqrt_x_reassociate_extra_use(%arg0: f64, %arg1: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    %3 = llvm.fmul %2, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64]

    llvm.store %2, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr]

    llvm.return %3 : f64
  }]

def x_add_y_rsqrt_reassociate_extra_use_before := [llvmfunc|
  llvm.func @x_add_y_rsqrt_reassociate_extra_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf32>) -> vector<2xf32>]

    %3 = llvm.fdiv %0, %2  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    %4 = llvm.fmul %1, %3  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    llvm.store %3, %arg2 {alignment = 8 : i64} : vector<2xf32>, !llvm.ptr]

    llvm.return %4 : vector<2xf32>
  }]

def sqrt_divisor_squared_before := [llvmfunc|
  llvm.func @sqrt_divisor_squared(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg1, %0  : f64
    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_dividend_squared_before := [llvmfunc|
  llvm.func @sqrt_dividend_squared(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.sqrt(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.fdiv %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    llvm.return %2 : vector<2xf32>
  }]

def sqrt_divisor_squared_extra_use_before := [llvmfunc|
  llvm.func @sqrt_divisor_squared_extra_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg1, %0  : f64
    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_dividend_squared_extra_use_before := [llvmfunc|
  llvm.func @sqrt_dividend_squared_extra_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.fdiv %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_divisor_not_enough_FMF_before := [llvmfunc|
  llvm.func @sqrt_divisor_not_enough_FMF(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg1, %0  : f64
    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def rsqrt_squared_extra_use_before := [llvmfunc|
  llvm.func @rsqrt_squared_extra_use(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.call @use(%2) : (f64) -> ()
    %3 = llvm.fmul %2, %2  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %3 : f64
  }]

def sqrt_a_sqrt_b_combined := [llvmfunc|
  llvm.func @sqrt_a_sqrt_b(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_a_sqrt_b   : sqrt_a_sqrt_b_before  ⊑  sqrt_a_sqrt_b_combined := by
  unfold sqrt_a_sqrt_b_before sqrt_a_sqrt_b_combined
  simp_alive_peephole
  sorry
def sqrt_a_sqrt_b_multiple_uses_combined := [llvmfunc|
  llvm.func @sqrt_a_sqrt_b_multiple_uses(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

theorem inst_combine_sqrt_a_sqrt_b_multiple_uses   : sqrt_a_sqrt_b_multiple_uses_before  ⊑  sqrt_a_sqrt_b_multiple_uses_combined := by
  unfold sqrt_a_sqrt_b_multiple_uses_before sqrt_a_sqrt_b_multiple_uses_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.sqrt(%arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

theorem inst_combine_sqrt_a_sqrt_b_multiple_uses   : sqrt_a_sqrt_b_multiple_uses_before  ⊑  sqrt_a_sqrt_b_multiple_uses_combined := by
  unfold sqrt_a_sqrt_b_multiple_uses_before sqrt_a_sqrt_b_multiple_uses_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_sqrt_a_sqrt_b_multiple_uses   : sqrt_a_sqrt_b_multiple_uses_before  ⊑  sqrt_a_sqrt_b_multiple_uses_combined := by
  unfold sqrt_a_sqrt_b_multiple_uses_before sqrt_a_sqrt_b_multiple_uses_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_a_sqrt_b_multiple_uses   : sqrt_a_sqrt_b_multiple_uses_before  ⊑  sqrt_a_sqrt_b_multiple_uses_combined := by
  unfold sqrt_a_sqrt_b_multiple_uses_before sqrt_a_sqrt_b_multiple_uses_combined
  simp_alive_peephole
  sorry
def sqrt_a_sqrt_b_reassoc_nnan_combined := [llvmfunc|
  llvm.func @sqrt_a_sqrt_b_reassoc_nnan(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

theorem inst_combine_sqrt_a_sqrt_b_reassoc_nnan   : sqrt_a_sqrt_b_reassoc_nnan_before  ⊑  sqrt_a_sqrt_b_reassoc_nnan_combined := by
  unfold sqrt_a_sqrt_b_reassoc_nnan_before sqrt_a_sqrt_b_reassoc_nnan_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_a_sqrt_b_reassoc_nnan   : sqrt_a_sqrt_b_reassoc_nnan_before  ⊑  sqrt_a_sqrt_b_reassoc_nnan_combined := by
  unfold sqrt_a_sqrt_b_reassoc_nnan_before sqrt_a_sqrt_b_reassoc_nnan_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sqrt_a_sqrt_b_reassoc_nnan   : sqrt_a_sqrt_b_reassoc_nnan_before  ⊑  sqrt_a_sqrt_b_reassoc_nnan_combined := by
  unfold sqrt_a_sqrt_b_reassoc_nnan_before sqrt_a_sqrt_b_reassoc_nnan_combined
  simp_alive_peephole
  sorry
def sqrt_a_sqrt_b_reassoc_combined := [llvmfunc|
  llvm.func @sqrt_a_sqrt_b_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_sqrt_a_sqrt_b_reassoc   : sqrt_a_sqrt_b_reassoc_before  ⊑  sqrt_a_sqrt_b_reassoc_combined := by
  unfold sqrt_a_sqrt_b_reassoc_before sqrt_a_sqrt_b_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_a_sqrt_b_reassoc   : sqrt_a_sqrt_b_reassoc_before  ⊑  sqrt_a_sqrt_b_reassoc_combined := by
  unfold sqrt_a_sqrt_b_reassoc_before sqrt_a_sqrt_b_reassoc_combined
  simp_alive_peephole
  sorry
def sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_combined := [llvmfunc|
  llvm.func @sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan, arcp, reassoc>} : f64]

theorem inst_combine_sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc   : sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_before  ⊑  sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_combined := by
  unfold sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_before sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

theorem inst_combine_sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc   : sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_before  ⊑  sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_combined := by
  unfold sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_before sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg3  {fastmathFlags = #llvm.fastmath<nnan, ninf, reassoc>} : f64]

theorem inst_combine_sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc   : sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_before  ⊑  sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_combined := by
  unfold sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_before sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_combined
  simp_alive_peephole
  sorry
    %3 = llvm.intr.sqrt(%2)  {fastmathFlags = #llvm.fastmath<nnan, ninf, reassoc>} : (f64) -> f64]

theorem inst_combine_sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc   : sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_before  ⊑  sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_combined := by
  unfold sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_before sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f64
  }]

theorem inst_combine_sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc   : sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_before  ⊑  sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_combined := by
  unfold sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_before sqrt_a_sqrt_b_sqrt_c_sqrt_d_reassoc_combined
  simp_alive_peephole
  sorry
def rsqrt_squared_combined := [llvmfunc|
  llvm.func @rsqrt_squared(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_rsqrt_squared   : rsqrt_squared_before  ⊑  rsqrt_squared_combined := by
  unfold rsqrt_squared_before rsqrt_squared_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_rsqrt_squared   : rsqrt_squared_before  ⊑  rsqrt_squared_combined := by
  unfold rsqrt_squared_before rsqrt_squared_combined
  simp_alive_peephole
  sorry
def rsqrt_x_reassociate_extra_use_combined := [llvmfunc|
  llvm.func @rsqrt_x_reassociate_extra_use(%arg0: f64, %arg1: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    %3 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64]

theorem inst_combine_rsqrt_x_reassociate_extra_use   : rsqrt_x_reassociate_extra_use_before  ⊑  rsqrt_x_reassociate_extra_use_combined := by
  unfold rsqrt_x_reassociate_extra_use_before rsqrt_x_reassociate_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.store %2, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr]

theorem inst_combine_rsqrt_x_reassociate_extra_use   : rsqrt_x_reassociate_extra_use_before  ⊑  rsqrt_x_reassociate_extra_use_combined := by
  unfold rsqrt_x_reassociate_extra_use_before rsqrt_x_reassociate_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f64
  }]

theorem inst_combine_rsqrt_x_reassociate_extra_use   : rsqrt_x_reassociate_extra_use_before  ⊑  rsqrt_x_reassociate_extra_use_combined := by
  unfold rsqrt_x_reassociate_extra_use_before rsqrt_x_reassociate_extra_use_combined
  simp_alive_peephole
  sorry
def x_add_y_rsqrt_reassociate_extra_use_combined := [llvmfunc|
  llvm.func @x_add_y_rsqrt_reassociate_extra_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

theorem inst_combine_x_add_y_rsqrt_reassociate_extra_use   : x_add_y_rsqrt_reassociate_extra_use_before  ⊑  x_add_y_rsqrt_reassociate_extra_use_combined := by
  unfold x_add_y_rsqrt_reassociate_extra_use_before x_add_y_rsqrt_reassociate_extra_use_combined
  simp_alive_peephole
  sorry
    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf32>) -> vector<2xf32>]

theorem inst_combine_x_add_y_rsqrt_reassociate_extra_use   : x_add_y_rsqrt_reassociate_extra_use_before  ⊑  x_add_y_rsqrt_reassociate_extra_use_combined := by
  unfold x_add_y_rsqrt_reassociate_extra_use_before x_add_y_rsqrt_reassociate_extra_use_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fdiv %0, %2  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

theorem inst_combine_x_add_y_rsqrt_reassociate_extra_use   : x_add_y_rsqrt_reassociate_extra_use_before  ⊑  x_add_y_rsqrt_reassociate_extra_use_combined := by
  unfold x_add_y_rsqrt_reassociate_extra_use_before x_add_y_rsqrt_reassociate_extra_use_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fdiv %1, %2  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

theorem inst_combine_x_add_y_rsqrt_reassociate_extra_use   : x_add_y_rsqrt_reassociate_extra_use_before  ⊑  x_add_y_rsqrt_reassociate_extra_use_combined := by
  unfold x_add_y_rsqrt_reassociate_extra_use_before x_add_y_rsqrt_reassociate_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.store %3, %arg2 {alignment = 8 : i64} : vector<2xf32>, !llvm.ptr]

theorem inst_combine_x_add_y_rsqrt_reassociate_extra_use   : x_add_y_rsqrt_reassociate_extra_use_before  ⊑  x_add_y_rsqrt_reassociate_extra_use_combined := by
  unfold x_add_y_rsqrt_reassociate_extra_use_before x_add_y_rsqrt_reassociate_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_x_add_y_rsqrt_reassociate_extra_use   : x_add_y_rsqrt_reassociate_extra_use_before  ⊑  x_add_y_rsqrt_reassociate_extra_use_combined := by
  unfold x_add_y_rsqrt_reassociate_extra_use_before x_add_y_rsqrt_reassociate_extra_use_combined
  simp_alive_peephole
  sorry
def sqrt_divisor_squared_combined := [llvmfunc|
  llvm.func @sqrt_divisor_squared(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg1, %arg1  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : f64]

theorem inst_combine_sqrt_divisor_squared   : sqrt_divisor_squared_before  ⊑  sqrt_divisor_squared_combined := by
  unfold sqrt_divisor_squared_before sqrt_divisor_squared_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : f64]

theorem inst_combine_sqrt_divisor_squared   : sqrt_divisor_squared_before  ⊑  sqrt_divisor_squared_combined := by
  unfold sqrt_divisor_squared_before sqrt_divisor_squared_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_sqrt_divisor_squared   : sqrt_divisor_squared_before  ⊑  sqrt_divisor_squared_combined := by
  unfold sqrt_divisor_squared_before sqrt_divisor_squared_combined
  simp_alive_peephole
  sorry
def sqrt_dividend_squared_combined := [llvmfunc|
  llvm.func @sqrt_dividend_squared(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fmul %arg1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

theorem inst_combine_sqrt_dividend_squared   : sqrt_dividend_squared_before  ⊑  sqrt_dividend_squared_combined := by
  unfold sqrt_dividend_squared_before sqrt_dividend_squared_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

theorem inst_combine_sqrt_dividend_squared   : sqrt_dividend_squared_before  ⊑  sqrt_dividend_squared_combined := by
  unfold sqrt_dividend_squared_before sqrt_dividend_squared_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_sqrt_dividend_squared   : sqrt_dividend_squared_before  ⊑  sqrt_dividend_squared_combined := by
  unfold sqrt_dividend_squared_before sqrt_dividend_squared_combined
  simp_alive_peephole
  sorry
def sqrt_divisor_squared_extra_use_combined := [llvmfunc|
  llvm.func @sqrt_divisor_squared_extra_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg1, %0  : f64
    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : f64]

theorem inst_combine_sqrt_divisor_squared_extra_use   : sqrt_divisor_squared_extra_use_before  ⊑  sqrt_divisor_squared_extra_use_combined := by
  unfold sqrt_divisor_squared_extra_use_before sqrt_divisor_squared_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_divisor_squared_extra_use   : sqrt_divisor_squared_extra_use_before  ⊑  sqrt_divisor_squared_extra_use_combined := by
  unfold sqrt_divisor_squared_extra_use_before sqrt_divisor_squared_extra_use_combined
  simp_alive_peephole
  sorry
def sqrt_dividend_squared_extra_use_combined := [llvmfunc|
  llvm.func @sqrt_dividend_squared_extra_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.fmul %arg1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_sqrt_dividend_squared_extra_use   : sqrt_dividend_squared_extra_use_before  ⊑  sqrt_dividend_squared_extra_use_combined := by
  unfold sqrt_dividend_squared_extra_use_before sqrt_dividend_squared_extra_use_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_sqrt_dividend_squared_extra_use   : sqrt_dividend_squared_extra_use_before  ⊑  sqrt_dividend_squared_extra_use_combined := by
  unfold sqrt_dividend_squared_extra_use_before sqrt_dividend_squared_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_dividend_squared_extra_use   : sqrt_dividend_squared_extra_use_before  ⊑  sqrt_dividend_squared_extra_use_combined := by
  unfold sqrt_dividend_squared_extra_use_before sqrt_dividend_squared_extra_use_combined
  simp_alive_peephole
  sorry
def sqrt_divisor_not_enough_FMF_combined := [llvmfunc|
  llvm.func @sqrt_divisor_not_enough_FMF(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg1, %0  : f64
    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

theorem inst_combine_sqrt_divisor_not_enough_FMF   : sqrt_divisor_not_enough_FMF_before  ⊑  sqrt_divisor_not_enough_FMF_combined := by
  unfold sqrt_divisor_not_enough_FMF_before sqrt_divisor_not_enough_FMF_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_divisor_not_enough_FMF   : sqrt_divisor_not_enough_FMF_before  ⊑  sqrt_divisor_not_enough_FMF_combined := by
  unfold sqrt_divisor_not_enough_FMF_before sqrt_divisor_not_enough_FMF_combined
  simp_alive_peephole
  sorry
def rsqrt_squared_extra_use_combined := [llvmfunc|
  llvm.func @rsqrt_squared_extra_use(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

theorem inst_combine_rsqrt_squared_extra_use   : rsqrt_squared_extra_use_before  ⊑  rsqrt_squared_extra_use_combined := by
  unfold rsqrt_squared_extra_use_before rsqrt_squared_extra_use_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_rsqrt_squared_extra_use   : rsqrt_squared_extra_use_before  ⊑  rsqrt_squared_extra_use_combined := by
  unfold rsqrt_squared_extra_use_before rsqrt_squared_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%2) : (f64) -> ()
    %3 = llvm.fmul %2, %2  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_rsqrt_squared_extra_use   : rsqrt_squared_extra_use_before  ⊑  rsqrt_squared_extra_use_combined := by
  unfold rsqrt_squared_extra_use_before rsqrt_squared_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f64
  }]

theorem inst_combine_rsqrt_squared_extra_use   : rsqrt_squared_extra_use_before  ⊑  rsqrt_squared_extra_use_combined := by
  unfold rsqrt_squared_extra_use_before rsqrt_squared_extra_use_combined
  simp_alive_peephole
  sorry
