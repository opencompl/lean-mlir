import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-sqrt-sqrtf
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: f32) -> f32 attributes {passthrough = ["ssp", ["uwtable", "2"]]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: f32) -> f32 attributes {passthrough = ["ssp", ["uwtable", "2"]]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
