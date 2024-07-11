import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pow-0
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def zero_before := [llvmfunc|
  llvm.func @zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def minus_zero_before := [llvmfunc|
  llvm.func @minus_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def fast_zero_before := [llvmfunc|
  llvm.func @fast_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def fast_minus_zero_before := [llvmfunc|
  llvm.func @fast_minus_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def vec_zero_before := [llvmfunc|
  llvm.func @vec_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.pow(%arg0, %1)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }]

def vec_minus_zero_before := [llvmfunc|
  llvm.func @vec_minus_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def vec_fast_zero_before := [llvmfunc|
  llvm.func @vec_fast_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.pow(%arg0, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def vec_fast_minus_zero_before := [llvmfunc|
  llvm.func @vec_fast_minus_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def zero_combined := [llvmfunc|
  llvm.func @zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_zero   : zero_before  ⊑  zero_combined := by
  unfold zero_before zero_combined
  simp_alive_peephole
  sorry
def minus_zero_combined := [llvmfunc|
  llvm.func @minus_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_minus_zero   : minus_zero_before  ⊑  minus_zero_combined := by
  unfold minus_zero_before minus_zero_combined
  simp_alive_peephole
  sorry
def fast_zero_combined := [llvmfunc|
  llvm.func @fast_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_fast_zero   : fast_zero_before  ⊑  fast_zero_combined := by
  unfold fast_zero_before fast_zero_combined
  simp_alive_peephole
  sorry
def fast_minus_zero_combined := [llvmfunc|
  llvm.func @fast_minus_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_fast_minus_zero   : fast_minus_zero_before  ⊑  fast_minus_zero_combined := by
  unfold fast_minus_zero_before fast_minus_zero_combined
  simp_alive_peephole
  sorry
def vec_zero_combined := [llvmfunc|
  llvm.func @vec_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_vec_zero   : vec_zero_before  ⊑  vec_zero_combined := by
  unfold vec_zero_before vec_zero_combined
  simp_alive_peephole
  sorry
def vec_minus_zero_combined := [llvmfunc|
  llvm.func @vec_minus_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_vec_minus_zero   : vec_minus_zero_before  ⊑  vec_minus_zero_combined := by
  unfold vec_minus_zero_before vec_minus_zero_combined
  simp_alive_peephole
  sorry
def vec_fast_zero_combined := [llvmfunc|
  llvm.func @vec_fast_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_vec_fast_zero   : vec_fast_zero_before  ⊑  vec_fast_zero_combined := by
  unfold vec_fast_zero_before vec_fast_zero_combined
  simp_alive_peephole
  sorry
def vec_fast_minus_zero_combined := [llvmfunc|
  llvm.func @vec_fast_minus_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_vec_fast_minus_zero   : vec_fast_minus_zero_before  ⊑  vec_fast_minus_zero_combined := by
  unfold vec_fast_minus_zero_before vec_fast_minus_zero_combined
  simp_alive_peephole
  sorry
