import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  phi-cse
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test0_before := [llvmfunc|
  llvm.func @test0(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %1, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %1, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def negative_test2_before := [llvmfunc|
  llvm.func @negative_test2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: !llvm.ptr, %arg5: !llvm.ptr) {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg2 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %1, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def negative_test3_before := [llvmfunc|
  llvm.func @negative_test3(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: !llvm.ptr, %arg5: !llvm.ptr) {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg2 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %1, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def negative_test4_before := [llvmfunc|
  llvm.func @negative_test4(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %1, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr) {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg2, %arg0, %arg0 : i16, i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg3, %arg1, %arg1 : i16, i32, i32)
  ^bb3(%0: i16, %1: i32, %2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %2, %arg6 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %arg7 {alignment = 2 : i64} : i16, !llvm.ptr]

    llvm.return
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr) {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg2, %arg0 : i32, i16, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg3, %arg1 : i32, i16, i32)
  ^bb3(%0: i32, %1: i16, %2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %2, %arg6 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %1, %arg7 {alignment = 2 : i64} : i16, !llvm.ptr]

    llvm.return
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr) {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0, %arg2 : i32, i32, i16)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg1, %arg3 : i32, i32, i16)
  ^bb3(%0: i32, %1: i32, %2: i16):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %1, %arg6 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %2, %arg7 {alignment = 2 : i64} : i16, !llvm.ptr]

    llvm.return
  }]

def test0_combined := [llvmfunc|
  llvm.func @test0(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : i32)
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test0   : test0_before  ⊑  test0_combined := by
  unfold test0_before test0_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test0   : test0_before  ⊑  test0_combined := by
  unfold test0_before test0_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test0   : test0_before  ⊑  test0_combined := by
  unfold test0_before test0_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : i32)
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def negative_test2_combined := [llvmfunc|
  llvm.func @negative_test2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: !llvm.ptr, %arg5: !llvm.ptr) {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg2 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_negative_test2   : negative_test2_before  ⊑  negative_test2_combined := by
  unfold negative_test2_before negative_test2_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_negative_test2   : negative_test2_before  ⊑  negative_test2_combined := by
  unfold negative_test2_before negative_test2_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_negative_test2   : negative_test2_before  ⊑  negative_test2_combined := by
  unfold negative_test2_before negative_test2_combined
  simp_alive_peephole
  sorry
def negative_test3_combined := [llvmfunc|
  llvm.func @negative_test3(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: !llvm.ptr, %arg5: !llvm.ptr) {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg0 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg2 : i32, i32)
  ^bb3(%0: i32, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_negative_test3   : negative_test3_before  ⊑  negative_test3_combined := by
  unfold negative_test3_before negative_test3_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_negative_test3   : negative_test3_before  ⊑  negative_test3_combined := by
  unfold negative_test3_before negative_test3_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_negative_test3   : negative_test3_before  ⊑  negative_test3_combined := by
  unfold negative_test3_before negative_test3_combined
  simp_alive_peephole
  sorry
def negative_test4_combined := [llvmfunc|
  llvm.func @negative_test4(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : i32)
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_negative_test4   : negative_test4_before  ⊑  negative_test4_combined := by
  unfold negative_test4_before negative_test4_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_negative_test4   : negative_test4_before  ⊑  negative_test4_combined := by
  unfold negative_test4_before negative_test4_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_negative_test4   : negative_test4_before  ⊑  negative_test4_combined := by
  unfold negative_test4_before negative_test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : i32)
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr, %arg4: !llvm.ptr) {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : i32)
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr) {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg2, %arg0 : i16, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg3, %arg1 : i16, i32)
  ^bb3(%0: i16, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg6 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %arg7 {alignment = 2 : i64} : i16, !llvm.ptr]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr) {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg2, %arg0 : i16, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg3, %arg1 : i16, i32)
  ^bb3(%0: i16, %1: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg6 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %arg7 {alignment = 2 : i64} : i16, !llvm.ptr]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i32, %arg1: i32, %arg2: i16, %arg3: i16, %arg4: i1, %arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: !llvm.ptr) {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg2 : i32, i16)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg3 : i32, i16)
  ^bb3(%0: i32, %1: i16):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %arg6 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg7 {alignment = 2 : i64} : i16, !llvm.ptr]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
