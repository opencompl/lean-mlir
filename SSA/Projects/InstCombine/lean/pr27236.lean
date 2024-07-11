import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr27236
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.icmp "sgt" %0, %arg0 : i32
    %4 = llvm.select %3, %0, %arg0 : i1, i32
    %5 = llvm.sitofp %4 : i32 to f32
    %6 = llvm.icmp "sgt" %4, %1 : i32
    %7 = llvm.select %6, %5, %2 : i1, f32
    llvm.return %7 : f32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.sitofp %1 : i32 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
