import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  noalias-scope-decl
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test01_before := [llvmfunc|
  llvm.func @test01(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.store %1, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test02_keep_before := [llvmfunc|
  llvm.func @test02_keep(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope], alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope, #alias_scope1]} : i8, !llvm.ptr]

    llvm.return
  }]

def test03_before := [llvmfunc|
  llvm.func @test03(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope, #alias_scope1]} : i8, !llvm.ptr]

    llvm.return
  }]

def test04_keep_before := [llvmfunc|
  llvm.func @test04_keep(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope, #alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope, #alias_scope1]} : i8, !llvm.ptr]

    llvm.return
  }]

def test05_keep_before := [llvmfunc|
  llvm.func @test05_keep(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope, #alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope]} : i8, !llvm.ptr]

    llvm.return
  }]

def test06_before := [llvmfunc|
  llvm.func @test06(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope, #alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope1]} : i8, !llvm.ptr]

    llvm.return
  }]

def test07_before := [llvmfunc|
  llvm.func @test07(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope], alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope1]} : i8, !llvm.ptr]

    llvm.return
  }]

def test08_before := [llvmfunc|
  llvm.func @test08(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope]} : i8, !llvm.ptr]

    llvm.return
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope], alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope, #alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alignment = 1 : i64, noalias_scopes = [#alias_scope]} : i8, !llvm.ptr]

    llvm.return
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alignment = 1 : i64, noalias_scopes = [#alias_scope1]} : i8, !llvm.ptr]

    llvm.return
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alignment = 1 : i64, noalias_scopes = [#alias_scope, #alias_scope1]} : i8, !llvm.ptr]

    llvm.return
  }]

def test01_combined := [llvmfunc|
  llvm.func @test01(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test01   : test01_before  ⊑  test01_combined := by
  unfold test01_before test01_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test01   : test01_before  ⊑  test01_combined := by
  unfold test01_before test01_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test01   : test01_before  ⊑  test01_combined := by
  unfold test01_before test01_combined
  simp_alive_peephole
  sorry
def test02_keep_combined := [llvmfunc|
  llvm.func @test02_keep(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope], alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test02_keep   : test02_keep_before  ⊑  test02_keep_combined := by
  unfold test02_keep_before test02_keep_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope, #alias_scope1]} : i8, !llvm.ptr]

theorem inst_combine_test02_keep   : test02_keep_before  ⊑  test02_keep_combined := by
  unfold test02_keep_before test02_keep_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test02_keep   : test02_keep_before  ⊑  test02_keep_combined := by
  unfold test02_keep_before test02_keep_combined
  simp_alive_peephole
  sorry
def test03_combined := [llvmfunc|
  llvm.func @test03(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test03   : test03_before  ⊑  test03_combined := by
  unfold test03_before test03_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope, #alias_scope1]} : i8, !llvm.ptr]

theorem inst_combine_test03   : test03_before  ⊑  test03_combined := by
  unfold test03_before test03_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test03   : test03_before  ⊑  test03_combined := by
  unfold test03_before test03_combined
  simp_alive_peephole
  sorry
def test04_keep_combined := [llvmfunc|
  llvm.func @test04_keep(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope, #alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test04_keep   : test04_keep_before  ⊑  test04_keep_combined := by
  unfold test04_keep_before test04_keep_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope, #alias_scope1]} : i8, !llvm.ptr]

theorem inst_combine_test04_keep   : test04_keep_before  ⊑  test04_keep_combined := by
  unfold test04_keep_before test04_keep_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test04_keep   : test04_keep_before  ⊑  test04_keep_combined := by
  unfold test04_keep_before test04_keep_combined
  simp_alive_peephole
  sorry
def test05_keep_combined := [llvmfunc|
  llvm.func @test05_keep(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.intr.experimental.noalias.scope.decl #alias_scope
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope, #alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test05_keep   : test05_keep_before  ⊑  test05_keep_combined := by
  unfold test05_keep_before test05_keep_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope]} : i8, !llvm.ptr]

theorem inst_combine_test05_keep   : test05_keep_before  ⊑  test05_keep_combined := by
  unfold test05_keep_before test05_keep_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test05_keep   : test05_keep_before  ⊑  test05_keep_combined := by
  unfold test05_keep_before test05_keep_combined
  simp_alive_peephole
  sorry
def test06_combined := [llvmfunc|
  llvm.func @test06(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope, #alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test06   : test06_before  ⊑  test06_combined := by
  unfold test06_before test06_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope1]} : i8, !llvm.ptr]

theorem inst_combine_test06   : test06_before  ⊑  test06_combined := by
  unfold test06_before test06_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test06   : test06_before  ⊑  test06_combined := by
  unfold test06_before test06_combined
  simp_alive_peephole
  sorry
def test07_combined := [llvmfunc|
  llvm.func @test07(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope], alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test07   : test07_before  ⊑  test07_combined := by
  unfold test07_before test07_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope1]} : i8, !llvm.ptr]

theorem inst_combine_test07   : test07_before  ⊑  test07_combined := by
  unfold test07_before test07_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test07   : test07_before  ⊑  test07_combined := by
  unfold test07_before test07_combined
  simp_alive_peephole
  sorry
def test08_combined := [llvmfunc|
  llvm.func @test08(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test08   : test08_before  ⊑  test08_combined := by
  unfold test08_before test08_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 1 : i64, noalias_scopes = [#alias_scope]} : i8, !llvm.ptr]

theorem inst_combine_test08   : test08_before  ⊑  test08_combined := by
  unfold test08_before test08_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test08   : test08_before  ⊑  test08_combined := by
  unfold test08_before test08_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope], alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope, #alias_scope1], alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64, noalias_scopes = [#alias_scope]} : i8, !llvm.ptr]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64, noalias_scopes = [#alias_scope1]} : i8, !llvm.ptr]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64, noalias_scopes = [#alias_scope, #alias_scope1]} : i8, !llvm.ptr]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
