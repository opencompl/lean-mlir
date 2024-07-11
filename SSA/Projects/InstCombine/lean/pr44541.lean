import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr44541
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def passthru_before := [llvmfunc|
  llvm.func @passthru(%arg0: i16 {llvm.returned}) -> i16 {
    llvm.return %arg0 : i16
  }]

def test_before := [llvmfunc|
  llvm.func @test(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.call @passthru(%0) : (i16) -> i16
    %2 = llvm.sub %arg0, %1 overflow<nsw, nuw>  : i16
    %3 = llvm.icmp "slt" %2, %0 : i16
    %4 = llvm.select %3, %0, %2 : i1, i16
    llvm.return %4 : i16
  }]

def passthru_combined := [llvmfunc|
  llvm.func @passthru(%arg0: i16 {llvm.returned}) -> i16 {
    llvm.return %arg0 : i16
  }]

theorem inst_combine_passthru   : passthru_before  ⊑  passthru_combined := by
  unfold passthru_before passthru_combined
  simp_alive_peephole
  sorry
def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.call @passthru(%0) : (i16) -> i16
    %2 = llvm.intr.smax(%arg0, %0)  : (i16, i16) -> i16
    llvm.return %2 : i16
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
