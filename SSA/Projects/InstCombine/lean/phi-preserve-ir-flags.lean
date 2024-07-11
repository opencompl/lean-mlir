import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  phi-preserve-ir-flags
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def func1_before := [llvmfunc|
  llvm.func @func1(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1) -> f32 {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.br ^bb3(%0 : f32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.fsub %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.br ^bb3(%1 : f32)
  ^bb3(%2: f32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : f32
  }]

def func2_before := [llvmfunc|
  llvm.func @func2(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1) -> f32 {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.br ^bb3(%0 : f32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.fsub %arg0, %arg2  : f32
    llvm.br ^bb3(%1 : f32)
  ^bb3(%2: f32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : f32
  }]

def func3_before := [llvmfunc|
  llvm.func @func3(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.fsub %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.br ^bb3(%1 : f32)
  ^bb2:  // pred: ^bb0
    %2 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.br ^bb3(%2 : f32)
  ^bb3(%3: f32):  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : f32
  }]

def func4_before := [llvmfunc|
  llvm.func @func4(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.fsub %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.br ^bb3(%1 : f32)
  ^bb2:  // pred: ^bb0
    %2 = llvm.fsub %arg1, %0  : f32
    llvm.br ^bb3(%2 : f32)
  ^bb3(%3: f32):  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : f32
  }]

def func1_combined := [llvmfunc|
  llvm.func @func1(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1) -> f32 {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : f32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : f32)
  ^bb3(%0: f32):  // 2 preds: ^bb1, ^bb2
    %1 = llvm.fsub %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_func1   : func1_before  ⊑  func1_combined := by
  unfold func1_before func1_combined
  simp_alive_peephole
  sorry
def func2_combined := [llvmfunc|
  llvm.func @func2(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1) -> f32 {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : f32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : f32)
  ^bb3(%0: f32):  // 2 preds: ^bb1, ^bb2
    %1 = llvm.fsub %arg0, %0  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_func2   : func2_before  ⊑  func2_combined := by
  unfold func2_before func2_combined
  simp_alive_peephole
  sorry
def func3_combined := [llvmfunc|
  llvm.func @func3(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1) -> f32 {
    %0 = llvm.mlir.constant(-2.000000e+00 : f32) : f32
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0 : f32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : f32)
  ^bb3(%1: f32):  // 2 preds: ^bb1, ^bb2
    %2 = llvm.fadd %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_func3   : func3_before  ⊑  func3_combined := by
  unfold func3_before func3_combined
  simp_alive_peephole
  sorry
def func4_combined := [llvmfunc|
  llvm.func @func4(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1) -> f32 {
    %0 = llvm.mlir.constant(-2.000000e+00 : f32) : f32
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0 : f32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : f32)
  ^bb3(%1: f32):  // 2 preds: ^bb1, ^bb2
    %2 = llvm.fadd %1, %0  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_func4   : func4_before  ⊑  func4_combined := by
  unfold func4_before func4_combined
  simp_alive_peephole
  sorry
