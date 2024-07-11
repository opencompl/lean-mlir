import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  narrow-switch
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def positive1_before := [llvmfunc|
  llvm.func @positive1(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(231 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.mlir.constant(213 : i32) : i32
    %4 = llvm.mlir.constant(24 : i32) : i32
    %5 = llvm.and %arg0, %0  : i64
    llvm.switch %5 : i64, ^bb3 [
      10: ^bb4(%1 : i32),
      100: ^bb1,
      1001: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%3 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%2 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%4 : i32)
  ^bb4(%6: i32):  // 4 preds: ^bb0, ^bb1, ^bb2, ^bb3
    llvm.return %6 : i32
  }]

def negative1_before := [llvmfunc|
  llvm.func @negative1(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(-4294967296 : i64) : i64
    %1 = llvm.mlir.constant(231 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.mlir.constant(213 : i32) : i32
    %4 = llvm.mlir.constant(24 : i32) : i32
    %5 = llvm.or %arg0, %0  : i64
    llvm.switch %5 : i64, ^bb3 [
      18446744073709551606: ^bb4(%1 : i32),
      18446744073709551516: ^bb1,
      18446744073709550615: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%3 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%2 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%4 : i32)
  ^bb4(%6: i32):  // 4 preds: ^bb0, ^bb1, ^bb2, ^bb3
    llvm.return %6 : i32
  }]

def trunc72to68_before := [llvmfunc|
  llvm.func @trunc72to68(%arg0: i72) -> i32 {
    %0 = llvm.mlir.constant(295147905179352825855 : i72) : i72
    %1 = llvm.mlir.constant(231 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.mlir.constant(213 : i32) : i32
    %4 = llvm.mlir.constant(24 : i32) : i32
    %5 = llvm.and %arg0, %0  : i72
    llvm.switch %5 : i72, ^bb3 [
      10: ^bb4(%1 : i32),
      100: ^bb1,
      1001: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%3 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%2 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%4 : i32)
  ^bb4(%6: i32):  // 4 preds: ^bb0, ^bb1, ^bb2, ^bb3
    llvm.return %6 : i32
  }]

def trunc64to58_before := [llvmfunc|
  llvm.func @trunc64to58(%arg0: i64) {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.constant(-6425668444178048401 : i64) : i64
    %2 = llvm.mlir.constant(5170979678563097242 : i64) : i64
    %3 = llvm.mlir.constant(1627972535142754813 : i64) : i64
    %4 = llvm.and %arg0, %0  : i64
    %5 = llvm.mul %4, %1  : i64
    %6 = llvm.add %5, %2  : i64
    %7 = llvm.mul %6, %3  : i64
    llvm.switch %7 : i64, ^bb3 [
      847514119312061490: ^bb1,
      866231301959785189: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }]

def PR31260_before := [llvmfunc|
  llvm.func @PR31260(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(-126 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(3 : i8) : i8
    %4 = llvm.mlir.constant(1 : i8) : i8
    %5 = llvm.and %arg0, %0  : i8
    %6 = llvm.add %5, %1 overflow<nsw>  : i8
    llvm.switch %6 : i8, ^bb1 [
      130: ^bb2,
      132: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.return %4 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i8
  ^bb3:  // pred: ^bb0
    llvm.return %2 : i8
  }]

def trunc32to16_before := [llvmfunc|
  llvm.func @trunc32to16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1034460917 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(-917677090 : i32) : i32
    %4 = llvm.mlir.constant(92 : i32) : i32
    %5 = llvm.mlir.constant(91 : i32) : i32
    %6 = llvm.mlir.constant(90 : i32) : i32
    %7 = llvm.mlir.constant(113 : i32) : i32
    %8 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %9 = llvm.xor %arg0, %1  : i32
    %10 = llvm.lshr %9, %2  : i32
    %11 = llvm.add %10, %3  : i32
    llvm.switch %11 : i32, ^bb4 [
      3377290269: ^bb1,
      3377290207: ^bb2,
      3377290306: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.store %6, %8 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb5
  ^bb2:  // pred: ^bb0
    llvm.store %5, %8 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb5
  ^bb3:  // pred: ^bb0
    llvm.store %4, %8 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    llvm.store %7, %8 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb5
  ^bb5:  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    %12 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %12 : i32
  }]

def PR29009_before := [llvmfunc|
  llvm.func @PR29009() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @njob : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.addressof @a : !llvm.ptr
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(6 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb6
    %7 = llvm.load volatile %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %8 = llvm.icmp "ne" %7, %0 : i32
    llvm.cond_br %8, ^bb2, ^bb7
  ^bb2:  // pred: ^bb1
    %9 = llvm.call @goo() : () -> i32
    %10 = llvm.and %9, %2  : i32
    llvm.switch %10 : i32, ^bb3 [
      0: ^bb4,
      3: ^bb5
    ]
  ^bb3:  // pred: ^bb2
    llvm.store %6, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb6
  ^bb4:  // pred: ^bb2
    llvm.store %5, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb6
  ^bb5:  // pred: ^bb2
    llvm.store %3, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb6
  ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
    llvm.br ^bb1
  ^bb7:  // pred: ^bb1
    llvm.return
  }]

def positive1_combined := [llvmfunc|
  llvm.func @positive1(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(231 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.mlir.constant(213 : i32) : i32
    %3 = llvm.mlir.constant(24 : i32) : i32
    %4 = llvm.trunc %arg0 : i64 to i32
    llvm.switch %4 : i32, ^bb3 [
      10: ^bb4(%0 : i32),
      100: ^bb1,
      1001: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%2 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%1 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%3 : i32)
  ^bb4(%5: i32):  // 4 preds: ^bb0, ^bb1, ^bb2, ^bb3
    llvm.return %5 : i32
  }]

theorem inst_combine_positive1   : positive1_before  ⊑  positive1_combined := by
  unfold positive1_before positive1_combined
  simp_alive_peephole
  sorry
def negative1_combined := [llvmfunc|
  llvm.func @negative1(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(231 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.mlir.constant(213 : i32) : i32
    %3 = llvm.mlir.constant(24 : i32) : i32
    %4 = llvm.trunc %arg0 : i64 to i32
    llvm.switch %4 : i32, ^bb3 [
      4294967286: ^bb4(%0 : i32),
      4294967196: ^bb1,
      4294966295: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%2 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%1 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%3 : i32)
  ^bb4(%5: i32):  // 4 preds: ^bb0, ^bb1, ^bb2, ^bb3
    llvm.return %5 : i32
  }]

theorem inst_combine_negative1   : negative1_before  ⊑  negative1_combined := by
  unfold negative1_before negative1_combined
  simp_alive_peephole
  sorry
def trunc72to68_combined := [llvmfunc|
  llvm.func @trunc72to68(%arg0: i72) -> i32 {
    %0 = llvm.mlir.constant(231 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.mlir.constant(213 : i32) : i32
    %3 = llvm.mlir.constant(24 : i32) : i32
    %4 = llvm.trunc %arg0 : i72 to i68
    llvm.switch %4 : i68, ^bb3 [
      10: ^bb4(%0 : i32),
      100: ^bb1,
      1001: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%2 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%1 : i32)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%3 : i32)
  ^bb4(%5: i32):  // 4 preds: ^bb0, ^bb1, ^bb2, ^bb3
    llvm.return %5 : i32
  }]

theorem inst_combine_trunc72to68   : trunc72to68_before  ⊑  trunc72to68_combined := by
  unfold trunc72to68_before trunc72to68_combined
  simp_alive_peephole
  sorry
def trunc64to58_combined := [llvmfunc|
  llvm.func @trunc64to58(%arg0: i64) {
    %0 = llvm.mlir.constant(15 : i58) : i58
    %1 = llvm.mlir.constant(18717182647723699 : i58) : i58
    %2 = llvm.trunc %arg0 : i64 to i58
    %3 = llvm.and %2, %0  : i58
    %4 = llvm.mul %3, %1 overflow<nuw>  : i58
    llvm.switch %4 : i58, ^bb3 [
      0: ^bb1,
      18717182647723699: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }]

theorem inst_combine_trunc64to58   : trunc64to58_before  ⊑  trunc64to58_combined := by
  unfold trunc64to58_before trunc64to58_combined
  simp_alive_peephole
  sorry
def PR31260_combined := [llvmfunc|
  llvm.func @PR31260(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    llvm.switch %4 : i8, ^bb1 [
      0: ^bb2,
      2: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i8
  ^bb3:  // pred: ^bb0
    llvm.return %1 : i8
  }]

theorem inst_combine_PR31260   : PR31260_before  ⊑  PR31260_combined := by
  unfold PR31260_before PR31260_combined
  simp_alive_peephole
  sorry
def trunc32to16_combined := [llvmfunc|
  llvm.func @trunc32to16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(15784 : i16) : i16
    %3 = llvm.mlir.constant(92 : i32) : i32
    %4 = llvm.mlir.constant(91 : i32) : i32
    %5 = llvm.mlir.constant(90 : i32) : i32
    %6 = llvm.mlir.constant(113 : i32) : i32
    %7 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.lshr %arg0, %1  : i32
    %9 = llvm.trunc %8 : i32 to i16
    %10 = llvm.xor %9, %2  : i16
    llvm.switch %10 : i16, ^bb4 [
      63: ^bb1,
      1: ^bb2,
      100: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.store %5, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb5
  ^bb2:  // pred: ^bb0
    llvm.store %4, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb5
  ^bb3:  // pred: ^bb0
    llvm.store %3, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    llvm.store %6, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb5
  ^bb5:  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %11 : i32
  }]

theorem inst_combine_trunc32to16   : trunc32to16_before  ⊑  trunc32to16_combined := by
  unfold trunc32to16_before trunc32to16_combined
  simp_alive_peephole
  sorry
def PR29009_combined := [llvmfunc|
  llvm.func @PR29009() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @njob : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.addressof @a : !llvm.ptr
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(6 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb6
    %7 = llvm.load volatile %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.icmp "eq" %7, %0 : i32
    llvm.cond_br %8, ^bb7, ^bb2
  ^bb2:  // pred: ^bb1
    %9 = llvm.call @goo() : () -> i32
    %10 = llvm.and %9, %2  : i32
    llvm.switch %10 : i32, ^bb3 [
      0: ^bb4,
      3: ^bb5
    ]
  ^bb3:  // pred: ^bb2
    llvm.store %6, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb6
  ^bb4:  // pred: ^bb2
    llvm.store %5, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb6
  ^bb5:  // pred: ^bb2
    llvm.store %3, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb6
  ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
    llvm.br ^bb1
  ^bb7:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_PR29009   : PR29009_before  ⊑  PR29009_combined := by
  unfold PR29009_before PR29009_combined
  simp_alive_peephole
  sorry
