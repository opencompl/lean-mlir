import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sink_instruction
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.sdiv %arg1, %arg2  : i32
    %1 = llvm.add %arg2, %arg1  : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(1000000 : i32) : i32
    llvm.br ^bb1(%arg0, %0 : i32, i32)
  ^bb1(%3: i32, %4: i32):  // 2 preds: ^bb0, ^bb3
    %5 = llvm.add %3, %1 overflow<nsw>  : i32
    %6 = llvm.sdiv %5, %3  : i32
    %7 = llvm.icmp "eq" %3, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb3(%3 : i32)
  ^bb2:  // pred: ^bb1
    %8 = llvm.call @bar() : () -> i32
    llvm.br ^bb3(%6 : i32)
  ^bb3(%9: i32):  // 2 preds: ^bb1, ^bb2
    %10 = llvm.add %4, %1 overflow<nsw>  : i32
    %11 = llvm.icmp "eq" %10, %2 : i32
    llvm.cond_br %11, ^bb4, ^bb1(%9, %10 : i32, i32)
  ^bb4:  // pred: ^bb3
    llvm.return %9 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg1 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.switch %arg1 : i32, ^bb2(%0 : i32) [
      5: ^bb1,
      2: ^bb1
    ]
  ^bb1:  // 2 preds: ^bb0, ^bb0
    %4 = llvm.add %3, %arg1 overflow<nsw>  : i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.sdiv %arg0, %arg1  : i32
    %1 = llvm.add %arg1, %arg0  : i32
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.call @foo(%1, %1) : (i32, i32) -> i32
    llvm.return %2 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.sext %arg1 : i32 to i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.cond_br %arg2, ^bb1, ^bb2(%2 : i32)
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg1, %arg1 overflow<nsw>  : i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.sext %arg1 : i32 to i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %3 = llvm.add %arg1, %arg1 overflow<nsw>  : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.switch %arg1 : i32, ^bb2 [
      5: ^bb3(%2 : i32),
      2: ^bb3(%2 : i32)
    ]
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%3 : i32)
  ^bb3(%4: i32):  // 3 preds: ^bb1, ^bb1, ^bb2
    llvm.return %4 : i32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i1, %arg1: f64) {
    %0 = llvm.call @log(%arg1) : (f64) -> f64
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @checkd(%0) : (f64) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.select %3, %1, %0 : i1, i64
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @dummy(%4) : (i64) -> ()
    llvm.return %4 : i64
  ^bb2:  // pred: ^bb0
    llvm.call @abort() : () -> ()
    llvm.unreachable
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.add %arg2, %arg1  : i32
    llvm.return %0 : i32
  ^bb2:  // pred: ^bb0
    %1 = llvm.sdiv %arg1, %arg2  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(1000000 : i32) : i32
    llvm.br ^bb1(%arg0, %0 : i32, i32)
  ^bb1(%3: i32, %4: i32):  // 2 preds: ^bb0, ^bb3
    %5 = llvm.icmp "eq" %3, %0 : i32
    llvm.cond_br %5, ^bb2, ^bb3(%3 : i32)
  ^bb2:  // pred: ^bb1
    %6 = llvm.add %3, %1 overflow<nsw>  : i32
    %7 = llvm.sdiv %6, %3  : i32
    %8 = llvm.call @bar() : () -> i32
    llvm.br ^bb3(%7 : i32)
  ^bb3(%9: i32):  // 2 preds: ^bb1, ^bb2
    %10 = llvm.add %4, %1 overflow<nsw, nuw>  : i32
    %11 = llvm.icmp "eq" %10, %2 : i32
    llvm.cond_br %11, ^bb4, ^bb1(%9, %10 : i32, i32)
  ^bb4:  // pred: ^bb3
    llvm.return %9 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.switch %arg1 : i32, ^bb2(%0 : i32) [
      5: ^bb1,
      2: ^bb1
    ]
  ^bb1:  // 2 preds: ^bb0, ^bb0
    %1 = llvm.sext %arg1 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.add %3, %arg1 overflow<nsw>  : i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.add %arg1, %arg0  : i32
    %1 = llvm.call @foo(%0, %0) : (i32, i32) -> i32
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    %2 = llvm.sdiv %arg0, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg1 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.cond_br %arg2, ^bb1, ^bb2(%3 : i32)
  ^bb1:  // pred: ^bb0
    %4 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.sext %arg1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.switch %arg1 : i32, ^bb2 [
      5: ^bb3(%4 : i32),
      2: ^bb3(%4 : i32)
    ]
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%1 : i32)
  ^bb3(%5: i32):  // 3 preds: ^bb1, ^bb1, ^bb2
    llvm.return %5 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i1, %arg1: f64) {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.call @log(%arg1) : (f64) -> f64
    llvm.call @checkd(%0) : (f64) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(2305843009213693951 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.icmp "ugt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @dummy(%1) : (i64) -> ()
    llvm.return %1 : i64
  ^bb2:  // pred: ^bb0
    llvm.call @abort() : () -> ()
    llvm.unreachable
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
