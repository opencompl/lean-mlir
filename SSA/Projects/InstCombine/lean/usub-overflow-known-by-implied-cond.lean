import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  usub-overflow-known-by-implied-cond
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "uge" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "uge" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.and %1, %arg2  : i1
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

def test9_logical_before := [llvmfunc|
  llvm.func @test9_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg2, %0 : i1, i1
    llvm.cond_br %3, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %4 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %6, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %5 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.and %1, %arg2  : i1
    llvm.cond_br %2, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

def test10_logical_before := [llvmfunc|
  llvm.func @test10_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg2, %0 : i1, i1
    llvm.cond_br %3, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %6, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %5 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.or %1, %arg2  : i1
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

def test11_logical_before := [llvmfunc|
  llvm.func @test11_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %0, %arg2 : i1, i1
    llvm.cond_br %3, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %4 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %6, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %5 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.or %1, %arg2  : i1
    llvm.cond_br %2, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

def test12_logical_before := [llvmfunc|
  llvm.func @test12_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %0, %arg2 : i1, i1
    llvm.cond_br %3, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %6, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %5 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %3, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %0, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.return %1 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %2, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %0, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %3 = llvm.sub %arg0, %arg1 overflow<nuw>  : i32
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %3, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    llvm.cond_br %0, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.return %2 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    llvm.cond_br %0, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %3 = llvm.sub %arg0, %arg1 overflow<nuw>  : i32
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    llvm.cond_br %0, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %1 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %3, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    llvm.cond_br %0, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %1 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %3, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    llvm.return %4 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %3, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    llvm.return %4 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.and %2, %arg2  : i1
    llvm.cond_br %3, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    llvm.cond_br %0, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %4 = llvm.sub %arg0, %arg1 overflow<nuw>  : i32
    llvm.return %4 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test9_logical_combined := [llvmfunc|
  llvm.func @test9_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg2, %0 : i1, i1
    llvm.cond_br %3, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    llvm.cond_br %0, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %4 = llvm.sub %arg0, %arg1 overflow<nuw>  : i32
    llvm.return %4 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_test9_logical   : test9_logical_before  ⊑  test9_logical_combined := by
  unfold test9_logical_before test9_logical_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.and %1, %arg2  : i1
    llvm.cond_br %2, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    llvm.return %5 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test10_logical_combined := [llvmfunc|
  llvm.func @test10_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg2, %0 : i1, i1
    llvm.cond_br %3, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %6 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    llvm.return %6 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_test10_logical   : test10_logical_before  ⊑  test10_logical_combined := by
  unfold test10_logical_before test10_logical_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.or %1, %arg2  : i1
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    llvm.return %5 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test11_logical_combined := [llvmfunc|
  llvm.func @test11_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %0, %arg2 : i1, i1
    llvm.cond_br %3, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %4 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %6 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    llvm.return %6 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_test11_logical   : test11_logical_before  ⊑  test11_logical_combined := by
  unfold test11_logical_before test11_logical_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.or %1, %arg2  : i1
    llvm.cond_br %2, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    llvm.return %5 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test12_logical_combined := [llvmfunc|
  llvm.func @test12_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %0, %arg2 : i1, i1
    llvm.cond_br %3, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %6 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    llvm.return %6 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_test12_logical   : test12_logical_before  ⊑  test12_logical_combined := by
  unfold test12_logical_before test12_logical_combined
  simp_alive_peephole
  sorry
