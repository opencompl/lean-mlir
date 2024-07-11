import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  overflow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2 overflow<nsw>  : i64
    %5 = llvm.add %4, %0  : i64
    %6 = llvm.icmp "ugt" %5, %1 : i64
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %7 = llvm.trunc %4 : i64 to i32
    llvm.return %7 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2 overflow<nsw>  : i64
    %5 = llvm.add %4, %0  : i64
    llvm.store %5, %arg2 {alignment = 4 : i64} : i64, !llvm.ptr]

    %6 = llvm.icmp "ugt" %5, %1 : i64
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %7 = llvm.trunc %4 : i64 to i32
    llvm.return %7 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i64 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2 overflow<nsw>  : i64
    %5 = llvm.add %4, %0  : i64
    %6 = llvm.icmp "ugt" %5, %1 : i64
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i64
  }]

def test4(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before := [llvmfunc|
  llvm.func @test4(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.zeroext}) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.add %3, %2 overflow<nsw>  : i32
    %5 = llvm.add %4, %0 overflow<nsw>  : i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    %7 = llvm.trunc %4 : i32 to i8
    llvm.return %7 : i8
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i64, %arg1: i64) -> i32 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.add %arg0, %arg1  : i64
    %3 = llvm.add %2, %0  : i64
    %4 = llvm.icmp "ugt" %3, %1 : i64
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %5 = llvm.trunc %2 : i64 to i32
    llvm.return %5 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = "llvm.intr.sadd.with.overflow"(%arg1, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i1)> 
    llvm.return %2 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2 overflow<nsw>  : i64
    %5 = llvm.add %4, %0 overflow<nsw>  : i64
    llvm.store %5, %arg2 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
    %6 = llvm.icmp "ugt" %5, %1 : i64
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %7 = llvm.trunc %4 : i64 to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i64 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(-2147483648 : i64) : i64
    %1 = llvm.mlir.constant(-4294967296 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2 overflow<nsw>  : i64
    %5 = llvm.add %4, %0 overflow<nsw>  : i64
    %6 = llvm.icmp "ult" %5, %1 : i64
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i64
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined := [llvmfunc|
  llvm.func @test4(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.zeroext}) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = "llvm.intr.sadd.with.overflow"(%arg1, %arg0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i8, i1)> 
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i8
  }]

theorem inst_combine_test4(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) ->    : test4(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before  ⊑  test4(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined := by
  unfold test4(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _before test4(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> _combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i64, %arg1: i64) -> i32 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(-2147483648 : i64) : i64
    %1 = llvm.mlir.constant(-4294967296 : i64) : i64
    %2 = llvm.add %arg0, %arg1  : i64
    %3 = llvm.add %2, %0  : i64
    %4 = llvm.icmp "ult" %3, %1 : i64
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %5 = llvm.trunc %2 : i64 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
