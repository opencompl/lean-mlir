import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  load-bitcast64
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    llvm.return %1 : i64
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    llvm.return %1 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    llvm.return %1 : i64
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.zext %0 : i32 to i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
