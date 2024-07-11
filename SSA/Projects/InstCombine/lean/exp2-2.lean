import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  exp2-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: i32) -> f32 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f32
    llvm.return %1 : f32
  }]

def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: i32) -> f32 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
