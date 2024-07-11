import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ceil
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def constant_fold_ceil_f32_01_before := [llvmfunc|
  llvm.func @constant_fold_ceil_f32_01() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.ceil(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

def constant_fold_ceil_f32_02_before := [llvmfunc|
  llvm.func @constant_fold_ceil_f32_02() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.250000e+00 : f32) : f32
    %1 = llvm.intr.ceil(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

def constant_fold_ceil_f32_03_before := [llvmfunc|
  llvm.func @constant_fold_ceil_f32_03() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1.250000e+00 : f32) : f32
    %1 = llvm.intr.ceil(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

def constant_fold_ceil_v4f32_01_before := [llvmfunc|
  llvm.func @constant_fold_ceil_v4f32_01() -> vector<4xf32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 1.250000e+00, -1.250000e+00, -1.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.intr.ceil(%0)  : (vector<4xf32>) -> vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

def constant_fold_ceil_f64_01_before := [llvmfunc|
  llvm.func @constant_fold_ceil_f64_01() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.ceil(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

def constant_fold_ceil_f64_02_before := [llvmfunc|
  llvm.func @constant_fold_ceil_f64_02() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.300000e+00 : f64) : f64
    %1 = llvm.intr.ceil(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

def constant_fold_ceil_f64_03_before := [llvmfunc|
  llvm.func @constant_fold_ceil_f64_03() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1.750000e+00 : f64) : f64
    %1 = llvm.intr.ceil(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

def constant_fold_ceil_f32_01_combined := [llvmfunc|
  llvm.func @constant_fold_ceil_f32_01() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_ceil_f32_01   : constant_fold_ceil_f32_01_before  ⊑  constant_fold_ceil_f32_01_combined := by
  unfold constant_fold_ceil_f32_01_before constant_fold_ceil_f32_01_combined
  simp_alive_peephole
  sorry
def constant_fold_ceil_f32_02_combined := [llvmfunc|
  llvm.func @constant_fold_ceil_f32_02() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_ceil_f32_02   : constant_fold_ceil_f32_02_before  ⊑  constant_fold_ceil_f32_02_combined := by
  unfold constant_fold_ceil_f32_02_before constant_fold_ceil_f32_02_combined
  simp_alive_peephole
  sorry
def constant_fold_ceil_f32_03_combined := [llvmfunc|
  llvm.func @constant_fold_ceil_f32_03() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_ceil_f32_03   : constant_fold_ceil_f32_03_before  ⊑  constant_fold_ceil_f32_03_combined := by
  unfold constant_fold_ceil_f32_03_before constant_fold_ceil_f32_03_combined
  simp_alive_peephole
  sorry
def constant_fold_ceil_v4f32_01_combined := [llvmfunc|
  llvm.func @constant_fold_ceil_v4f32_01() -> vector<4xf32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, -1.000000e+00, -1.000000e+00]> : vector<4xf32>) : vector<4xf32>
    llvm.return %0 : vector<4xf32>
  }]

theorem inst_combine_constant_fold_ceil_v4f32_01   : constant_fold_ceil_v4f32_01_before  ⊑  constant_fold_ceil_v4f32_01_combined := by
  unfold constant_fold_ceil_v4f32_01_before constant_fold_ceil_v4f32_01_combined
  simp_alive_peephole
  sorry
def constant_fold_ceil_f64_01_combined := [llvmfunc|
  llvm.func @constant_fold_ceil_f64_01() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_constant_fold_ceil_f64_01   : constant_fold_ceil_f64_01_before  ⊑  constant_fold_ceil_f64_01_combined := by
  unfold constant_fold_ceil_f64_01_before constant_fold_ceil_f64_01_combined
  simp_alive_peephole
  sorry
def constant_fold_ceil_f64_02_combined := [llvmfunc|
  llvm.func @constant_fold_ceil_f64_02() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_constant_fold_ceil_f64_02   : constant_fold_ceil_f64_02_before  ⊑  constant_fold_ceil_f64_02_combined := by
  unfold constant_fold_ceil_f64_02_before constant_fold_ceil_f64_02_combined
  simp_alive_peephole
  sorry
def constant_fold_ceil_f64_03_combined := [llvmfunc|
  llvm.func @constant_fold_ceil_f64_03() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_constant_fold_ceil_f64_03   : constant_fold_ceil_f64_03_before  ⊑  constant_fold_ceil_f64_03_combined := by
  unfold constant_fold_ceil_f64_03_before constant_fold_ceil_f64_03_combined
  simp_alive_peephole
  sorry
