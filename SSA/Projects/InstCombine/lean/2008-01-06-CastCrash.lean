import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-01-06-CastCrash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f() -> vector<2xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

def g_before := [llvmfunc|
  llvm.func @g() -> i32 {
    %0 = llvm.mlir.addressof @f : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> i32
    llvm.return %1 : i32
  }]

def f_combined := [llvmfunc|
  llvm.func @f() -> vector<2xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
def g_combined := [llvmfunc|
  llvm.func @g() -> i32 {
    %0 = llvm.mlir.addressof @f : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_g   : g_before  ⊑  g_combined := by
  unfold g_before g_combined
  simp_alive_peephole
  sorry
