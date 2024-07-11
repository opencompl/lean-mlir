import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  call-cast-target-inalloca
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @takes_i32 : !llvm.ptr
    %2 = llvm.alloca inalloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call %1(%2) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

def g_before := [llvmfunc|
  llvm.func @g() {
    %0 = llvm.mlir.addressof @takes_i32_inalloca : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.call %0(%1) : !llvm.ptr, (i32) -> ()
    llvm.return
  }]

def f_combined := [llvmfunc|
  llvm.func @f() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @takes_i32 : !llvm.ptr
    %2 = llvm.alloca inalloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call %1(%2) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
def g_combined := [llvmfunc|
  llvm.func @g() {
    %0 = llvm.mlir.addressof @takes_i32_inalloca : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.call %0(%1) : !llvm.ptr, (i32) -> ()
    llvm.return
  }]

theorem inst_combine_g   : g_before  ⊑  g_combined := by
  unfold g_before g_combined
  simp_alive_peephole
  sorry
