import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cast-byval
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", _before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", (i64)>}) -> i64 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64]

    llvm.return %0 : i64
  }]

def bar_before := [llvmfunc|
  llvm.func @bar(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @foo : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (i64) -> i64
    llvm.return %1 : i64
  }]

def qux(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", _before := [llvmfunc|
  llvm.func @qux(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", (i64)>}) -> i64 {
    %0 = llvm.mlir.addressof @bar : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.return %1 : i64
  }]

def foo(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", _combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", (i64)>}) -> i64 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_foo(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo",    : foo(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", _before  ⊑  foo(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", _combined := by
  unfold foo(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", _before foo(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", _combined
  simp_alive_peephole
  sorry
def bar_combined := [llvmfunc|
  llvm.func @bar(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @foo : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (i64) -> i64
    llvm.return %1 : i64
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
def qux(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", _combined := [llvmfunc|
  llvm.func @qux(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", (i64)>}) -> i64 {
    %0 = llvm.mlir.addressof @bar : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.return %1 : i64
  }]

theorem inst_combine_qux(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo",    : qux(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", _before  ⊑  qux(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", _combined := by
  unfold qux(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", _before qux(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", _combined
  simp_alive_peephole
  sorry
