import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  known-fpclass-reduce-signbit
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def vector_reduce_maximum_signbit_before := [llvmfunc|
  llvm.func @vector_reduce_maximum_signbit(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmaximum(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

def vector_reduce_maximum_signbit_fail_maybe_nan_before := [llvmfunc|
  llvm.func @vector_reduce_maximum_signbit_fail_maybe_nan(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmaximum(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

def vector_reduce_minimum_signbit_before := [llvmfunc|
  llvm.func @vector_reduce_minimum_signbit(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fminimum(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

def vector_reduce_minimum_signbit_fail_maybe_nan_before := [llvmfunc|
  llvm.func @vector_reduce_minimum_signbit_fail_maybe_nan(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fminimum(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

def vector_reduce_max_signbit_before := [llvmfunc|
  llvm.func @vector_reduce_max_signbit(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmax(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

def vector_reduce_max_signbit_fail_maybe_nan_before := [llvmfunc|
  llvm.func @vector_reduce_max_signbit_fail_maybe_nan(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmax(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

def vector_reduce_min_signbit_before := [llvmfunc|
  llvm.func @vector_reduce_min_signbit(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmin(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

def vector_reduce_min_signbit_fail_maybe_nan_before := [llvmfunc|
  llvm.func @vector_reduce_min_signbit_fail_maybe_nan(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmin(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

def vector_reduce_min_signbit_nnan_from_fmf_before := [llvmfunc|
  llvm.func @vector_reduce_min_signbit_nnan_from_fmf(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmin(%1)  {fastmathFlags = #llvm.fastmath<nnan>} : (vector<4xf64>) -> f64]

    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

def vector_reduce_maximum_signbit_combined := [llvmfunc|
  llvm.func @vector_reduce_maximum_signbit(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmaximum(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_vector_reduce_maximum_signbit   : vector_reduce_maximum_signbit_before  ⊑  vector_reduce_maximum_signbit_combined := by
  unfold vector_reduce_maximum_signbit_before vector_reduce_maximum_signbit_combined
  simp_alive_peephole
  sorry
def vector_reduce_maximum_signbit_fail_maybe_nan_combined := [llvmfunc|
  llvm.func @vector_reduce_maximum_signbit_fail_maybe_nan(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmaximum(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_vector_reduce_maximum_signbit_fail_maybe_nan   : vector_reduce_maximum_signbit_fail_maybe_nan_before  ⊑  vector_reduce_maximum_signbit_fail_maybe_nan_combined := by
  unfold vector_reduce_maximum_signbit_fail_maybe_nan_before vector_reduce_maximum_signbit_fail_maybe_nan_combined
  simp_alive_peephole
  sorry
def vector_reduce_minimum_signbit_combined := [llvmfunc|
  llvm.func @vector_reduce_minimum_signbit(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fminimum(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_vector_reduce_minimum_signbit   : vector_reduce_minimum_signbit_before  ⊑  vector_reduce_minimum_signbit_combined := by
  unfold vector_reduce_minimum_signbit_before vector_reduce_minimum_signbit_combined
  simp_alive_peephole
  sorry
def vector_reduce_minimum_signbit_fail_maybe_nan_combined := [llvmfunc|
  llvm.func @vector_reduce_minimum_signbit_fail_maybe_nan(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fminimum(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_vector_reduce_minimum_signbit_fail_maybe_nan   : vector_reduce_minimum_signbit_fail_maybe_nan_before  ⊑  vector_reduce_minimum_signbit_fail_maybe_nan_combined := by
  unfold vector_reduce_minimum_signbit_fail_maybe_nan_before vector_reduce_minimum_signbit_fail_maybe_nan_combined
  simp_alive_peephole
  sorry
def vector_reduce_max_signbit_combined := [llvmfunc|
  llvm.func @vector_reduce_max_signbit(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmax(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_vector_reduce_max_signbit   : vector_reduce_max_signbit_before  ⊑  vector_reduce_max_signbit_combined := by
  unfold vector_reduce_max_signbit_before vector_reduce_max_signbit_combined
  simp_alive_peephole
  sorry
def vector_reduce_max_signbit_fail_maybe_nan_combined := [llvmfunc|
  llvm.func @vector_reduce_max_signbit_fail_maybe_nan(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmax(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_vector_reduce_max_signbit_fail_maybe_nan   : vector_reduce_max_signbit_fail_maybe_nan_before  ⊑  vector_reduce_max_signbit_fail_maybe_nan_combined := by
  unfold vector_reduce_max_signbit_fail_maybe_nan_before vector_reduce_max_signbit_fail_maybe_nan_combined
  simp_alive_peephole
  sorry
def vector_reduce_min_signbit_combined := [llvmfunc|
  llvm.func @vector_reduce_min_signbit(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmin(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_vector_reduce_min_signbit   : vector_reduce_min_signbit_before  ⊑  vector_reduce_min_signbit_combined := by
  unfold vector_reduce_min_signbit_before vector_reduce_min_signbit_combined
  simp_alive_peephole
  sorry
def vector_reduce_min_signbit_fail_maybe_nan_combined := [llvmfunc|
  llvm.func @vector_reduce_min_signbit_fail_maybe_nan(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmin(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_vector_reduce_min_signbit_fail_maybe_nan   : vector_reduce_min_signbit_fail_maybe_nan_before  ⊑  vector_reduce_min_signbit_fail_maybe_nan_combined := by
  unfold vector_reduce_min_signbit_fail_maybe_nan_before vector_reduce_min_signbit_fail_maybe_nan_combined
  simp_alive_peephole
  sorry
def vector_reduce_min_signbit_nnan_from_fmf_combined := [llvmfunc|
  llvm.func @vector_reduce_min_signbit_nnan_from_fmf(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmin(%1)  {fastmathFlags = #llvm.fastmath<nnan>} : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_vector_reduce_min_signbit_nnan_from_fmf   : vector_reduce_min_signbit_nnan_from_fmf_before  ⊑  vector_reduce_min_signbit_nnan_from_fmf_combined := by
  unfold vector_reduce_min_signbit_nnan_from_fmf_before vector_reduce_min_signbit_nnan_from_fmf_combined
  simp_alive_peephole
  sorry
