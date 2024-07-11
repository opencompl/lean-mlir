import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  constant-fold-math
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def constant_fold_fma_f32_before := [llvmfunc|
  llvm.func @constant_fold_fma_f32() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %3 = llvm.intr.fma(%0, %1, %2)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }]

def constant_fold_fma_v4f32_before := [llvmfunc|
  llvm.func @constant_fold_fma_v4f32() -> vector<4xf32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<2.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.mlir.constant(dense<1.000000e+01> : vector<4xf32>) : vector<4xf32>
    %3 = llvm.intr.fma(%0, %1, %2)  : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

def constant_fold_fmuladd_f32_before := [llvmfunc|
  llvm.func @constant_fold_fmuladd_f32() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %3 = llvm.intr.fmuladd(%0, %1, %2)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }]

def constant_fold_fma_f64_before := [llvmfunc|
  llvm.func @constant_fold_fma_f64() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %3 = llvm.intr.fma(%0, %1, %2)  : (f64, f64, f64) -> f64
    llvm.return %3 : f64
  }]

def constant_fold_fmuladd_f64_before := [llvmfunc|
  llvm.func @constant_fold_fmuladd_f64() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %3 = llvm.intr.fmuladd(%0, %1, %2)  : (f64, f64, f64) -> f64
    llvm.return %3 : f64
  }]

def constant_fold_frem_f32_before := [llvmfunc|
  llvm.func @constant_fold_frem_f32() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4.03345148E+18 : f32) : f32
    %1 = llvm.mlir.constant(-2.50991821E+9 : f32) : f32
    %2 = llvm.frem %0, %1  : f32
    llvm.return %2 : f32
  }]

def constant_fold_frem_f64_before := [llvmfunc|
  llvm.func @constant_fold_frem_f64() -> f64 {
    %0 = llvm.mlir.constant(9.2233720368547758E+18 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.frem %0, %1  : f64
    llvm.return %2 : f64
  }]

def constant_fold_fma_f32_combined := [llvmfunc|
  llvm.func @constant_fold_fma_f32() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_fma_f32   : constant_fold_fma_f32_before  ⊑  constant_fold_fma_f32_combined := by
  unfold constant_fold_fma_f32_before constant_fold_fma_f32_combined
  simp_alive_peephole
  sorry
def constant_fold_fma_v4f32_combined := [llvmfunc|
  llvm.func @constant_fold_fma_v4f32() -> vector<4xf32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1.200000e+01, 1.400000e+01, 1.600000e+01, 1.800000e+01]> : vector<4xf32>) : vector<4xf32>
    llvm.return %0 : vector<4xf32>
  }]

theorem inst_combine_constant_fold_fma_v4f32   : constant_fold_fma_v4f32_before  ⊑  constant_fold_fma_v4f32_combined := by
  unfold constant_fold_fma_v4f32_before constant_fold_fma_v4f32_combined
  simp_alive_peephole
  sorry
def constant_fold_fmuladd_f32_combined := [llvmfunc|
  llvm.func @constant_fold_fmuladd_f32() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_fmuladd_f32   : constant_fold_fmuladd_f32_before  ⊑  constant_fold_fmuladd_f32_combined := by
  unfold constant_fold_fmuladd_f32_before constant_fold_fmuladd_f32_combined
  simp_alive_peephole
  sorry
def constant_fold_fma_f64_combined := [llvmfunc|
  llvm.func @constant_fold_fma_f64() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(6.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_constant_fold_fma_f64   : constant_fold_fma_f64_before  ⊑  constant_fold_fma_f64_combined := by
  unfold constant_fold_fma_f64_before constant_fold_fma_f64_combined
  simp_alive_peephole
  sorry
def constant_fold_fmuladd_f64_combined := [llvmfunc|
  llvm.func @constant_fold_fmuladd_f64() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(6.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_constant_fold_fmuladd_f64   : constant_fold_fmuladd_f64_before  ⊑  constant_fold_fmuladd_f64_combined := by
  unfold constant_fold_fmuladd_f64_before constant_fold_fmuladd_f64_combined
  simp_alive_peephole
  sorry
def constant_fold_frem_f32_combined := [llvmfunc|
  llvm.func @constant_fold_frem_f32() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0x4D30D900 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_frem_f32   : constant_fold_frem_f32_before  ⊑  constant_fold_frem_f32_combined := by
  unfold constant_fold_frem_f32_before constant_fold_frem_f32_combined
  simp_alive_peephole
  sorry
def constant_fold_frem_f64_combined := [llvmfunc|
  llvm.func @constant_fold_frem_f64() -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_constant_fold_frem_f64   : constant_fold_frem_f64_before  ⊑  constant_fold_frem_f64_combined := by
  unfold constant_fold_frem_f64_before constant_fold_frem_f64_combined
  simp_alive_peephole
  sorry
