import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-02-04-FPBitcast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def cast_before := [llvmfunc|
  llvm.func @cast() -> f80 {
    %0 = llvm.mlir.constant(0 : i80) : i80
    %1 = llvm.bitcast %0 : i80 to f80
    llvm.return %1 : f80
  }]

def invcast_before := [llvmfunc|
  llvm.func @invcast() -> i80 {
    %0 = llvm.mlir.constant(0.000000e+00 : f80) : f80
    %1 = llvm.bitcast %0 : f80 to i80
    llvm.return %1 : i80
  }]

def cast_combined := [llvmfunc|
  llvm.func @cast() -> f80 {
    %0 = llvm.mlir.constant(0.000000e+00 : f80) : f80
    llvm.return %0 : f80
  }]

theorem inst_combine_cast   : cast_before  ⊑  cast_combined := by
  unfold cast_before cast_combined
  simp_alive_peephole
  sorry
def invcast_combined := [llvmfunc|
  llvm.func @invcast() -> i80 {
    %0 = llvm.mlir.constant(0 : i80) : i80
    llvm.return %0 : i80
  }]

theorem inst_combine_invcast   : invcast_before  ⊑  invcast_combined := by
  unfold invcast_before invcast_combined
  simp_alive_peephole
  sorry
