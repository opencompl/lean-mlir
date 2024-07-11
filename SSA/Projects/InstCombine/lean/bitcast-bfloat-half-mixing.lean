import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bitcast-bfloat-half-mixing
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def F0_before := [llvmfunc|
  llvm.func @F0(%arg0: bf16) -> f64 {
    %0 = llvm.bitcast %arg0 : bf16 to f16
    %1 = llvm.fpext %0 : f16 to f64
    llvm.return %1 : f64
  }]

def F1_before := [llvmfunc|
  llvm.func @F1(%arg0: f16) -> f64 {
    %0 = llvm.bitcast %arg0 : f16 to bf16
    %1 = llvm.fpext %0 : bf16 to f64
    llvm.return %1 : f64
  }]

def F2_before := [llvmfunc|
  llvm.func @F2(%arg0: bf16) -> i32 {
    %0 = llvm.bitcast %arg0 : bf16 to f16
    %1 = llvm.fptoui %0 : f16 to i32
    llvm.return %1 : i32
  }]

def F3_before := [llvmfunc|
  llvm.func @F3(%arg0: f16) -> i32 {
    %0 = llvm.bitcast %arg0 : f16 to bf16
    %1 = llvm.fptoui %0 : bf16 to i32
    llvm.return %1 : i32
  }]

def F4_before := [llvmfunc|
  llvm.func @F4(%arg0: bf16) -> i32 {
    %0 = llvm.bitcast %arg0 : bf16 to f16
    %1 = llvm.fptosi %0 : f16 to i32
    llvm.return %1 : i32
  }]

def F5_before := [llvmfunc|
  llvm.func @F5(%arg0: f16) -> i32 {
    %0 = llvm.bitcast %arg0 : f16 to bf16
    %1 = llvm.fptosi %0 : bf16 to i32
    llvm.return %1 : i32
  }]

def F0_combined := [llvmfunc|
  llvm.func @F0(%arg0: bf16) -> f64 {
    %0 = llvm.fpext %arg0 : bf16 to f64
    llvm.return %0 : f64
  }]

theorem inst_combine_F0   : F0_before  ⊑  F0_combined := by
  unfold F0_before F0_combined
  simp_alive_peephole
  sorry
def F1_combined := [llvmfunc|
  llvm.func @F1(%arg0: f16) -> f64 {
    %0 = llvm.fpext %arg0 : f16 to f64
    llvm.return %0 : f64
  }]

theorem inst_combine_F1   : F1_before  ⊑  F1_combined := by
  unfold F1_before F1_combined
  simp_alive_peephole
  sorry
def F2_combined := [llvmfunc|
  llvm.func @F2(%arg0: bf16) -> i32 {
    %0 = llvm.fptoui %arg0 : bf16 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_F2   : F2_before  ⊑  F2_combined := by
  unfold F2_before F2_combined
  simp_alive_peephole
  sorry
def F3_combined := [llvmfunc|
  llvm.func @F3(%arg0: f16) -> i32 {
    %0 = llvm.fptoui %arg0 : f16 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_F3   : F3_before  ⊑  F3_combined := by
  unfold F3_before F3_combined
  simp_alive_peephole
  sorry
def F4_combined := [llvmfunc|
  llvm.func @F4(%arg0: bf16) -> i32 {
    %0 = llvm.fptosi %arg0 : bf16 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_F4   : F4_before  ⊑  F4_combined := by
  unfold F4_before F4_combined
  simp_alive_peephole
  sorry
def F5_combined := [llvmfunc|
  llvm.func @F5(%arg0: f16) -> i32 {
    %0 = llvm.fptosi %arg0 : f16 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_F5   : F5_before  ⊑  F5_combined := by
  unfold F5_before F5_combined
  simp_alive_peephole
  sorry
