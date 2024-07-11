import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-01-06-BitCastAttributes
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def a_before := [llvmfunc|
  llvm.func @a() {
    llvm.return
  }]

def b(%arg0: !llvm.ptr {llvm.inreg}) -> _before := [llvmfunc|
  llvm.func @b(%arg0: !llvm.ptr {llvm.inreg}) -> (i32 {llvm.signext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

def c_before := [llvmfunc|
  llvm.func @c(...) {
    llvm.return
  }]

def g_before := [llvmfunc|
  llvm.func @g(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @b : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @c : !llvm.ptr
    %5 = llvm.call %0(%1) : !llvm.ptr, (i32) -> i64
    llvm.call %2(%arg0) : !llvm.ptr, (!llvm.ptr) -> ()
    %6 = llvm.call %0(%3) : !llvm.ptr, (!llvm.ptr) -> vector<2xi32>
    llvm.call %4(%1) : !llvm.ptr, (i32) -> ()
    llvm.call %4(%1) : !llvm.ptr, (i32) -> ()
    llvm.return
  }]

def a_combined := [llvmfunc|
  llvm.func @a() {
    llvm.return
  }]

theorem inst_combine_a   : a_before  ⊑  a_combined := by
  unfold a_before a_combined
  simp_alive_peephole
  sorry
def b(%arg0: !llvm.ptr {llvm.inreg}) -> _combined := [llvmfunc|
  llvm.func @b(%arg0: !llvm.ptr {llvm.inreg}) -> (i32 {llvm.signext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_b(%arg0: !llvm.ptr {llvm.inreg}) ->    : b(%arg0: !llvm.ptr {llvm.inreg}) -> _before  ⊑  b(%arg0: !llvm.ptr {llvm.inreg}) -> _combined := by
  unfold b(%arg0: !llvm.ptr {llvm.inreg}) -> _before b(%arg0: !llvm.ptr {llvm.inreg}) -> _combined
  simp_alive_peephole
  sorry
def c_combined := [llvmfunc|
  llvm.func @c(...) {
    llvm.return
  }]

theorem inst_combine_c   : c_before  ⊑  c_combined := by
  unfold c_before c_combined
  simp_alive_peephole
  sorry
def g_combined := [llvmfunc|
  llvm.func @g(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @b : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call %0(%1) : !llvm.ptr, (i32) -> i64
    llvm.call @a() : () -> ()
    %4 = llvm.call @b(%2) : (!llvm.ptr) -> i32
    llvm.call @c(%1) vararg(!llvm.func<void (...)>) : (i32) -> ()
    llvm.call @c(%1) vararg(!llvm.func<void (...)>) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_g   : g_before  ⊑  g_combined := by
  unfold g_before g_combined
  simp_alive_peephole
  sorry
