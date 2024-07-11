import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-cmp-br
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.getelementptr inbounds %arg0[%0, 0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (struct<"struct.S", (ptr, i32, i32)>)>
    %6 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %7 = llvm.getelementptr inbounds %4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %9 = llvm.icmp "eq" %4, %6 : !llvm.ptr
    %10 = llvm.select %9, %arg0, %3 : i1, !llvm.ptr
    %11 = llvm.icmp "eq" %10, %3 : !llvm.ptr
    llvm.cond_br %11, ^bb3, ^bb2
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    %12 = llvm.call %8(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.br ^bb1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.getelementptr inbounds %arg0[%0, 0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (struct<"struct.S", (ptr, i32, i32)>)>
    %6 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %7 = llvm.getelementptr inbounds %4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %9 = llvm.icmp "eq" %4, %6 : !llvm.ptr
    %10 = llvm.select %9, %3, %arg0 : i1, !llvm.ptr
    %11 = llvm.icmp "eq" %10, %3 : !llvm.ptr
    llvm.cond_br %11, ^bb3, ^bb2
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    %12 = llvm.call %8(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.br ^bb1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.getelementptr inbounds %arg0[%0, 0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (struct<"struct.S", (ptr, i32, i32)>)>
    %6 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %7 = llvm.getelementptr inbounds %4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %9 = llvm.icmp "eq" %4, %6 : !llvm.ptr
    %10 = llvm.select %9, %arg0, %3 : i1, !llvm.ptr
    %11 = llvm.icmp "ne" %10, %3 : !llvm.ptr
    llvm.cond_br %11, ^bb2, ^bb3
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    %12 = llvm.call %8(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.br ^bb1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.getelementptr inbounds %arg0[%0, 0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (struct<"struct.S", (ptr, i32, i32)>)>
    %6 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %7 = llvm.getelementptr inbounds %4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %9 = llvm.icmp "eq" %4, %6 : !llvm.ptr
    %10 = llvm.select %9, %3, %arg0 : i1, !llvm.ptr
    %11 = llvm.icmp "ne" %10, %3 : !llvm.ptr
    llvm.cond_br %11, ^bb2, ^bb3
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    %12 = llvm.call %8(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.br ^bb1
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr, %arg1: i1) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg1, %0, %arg0 : i1, !llvm.ptr
    %2 = llvm.icmp "ne" %1, %0 : !llvm.ptr
    llvm.cond_br %2, ^bb2, ^bb3
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    llvm.call @foobar() : () -> ()
    llvm.br ^bb1
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.select %arg1, %arg0, %0 : i1, i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    llvm.return %1 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %4 = llvm.getelementptr inbounds %arg0[%0, 0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (struct<"struct.S", (ptr, i32, i32)>)>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %6 = llvm.icmp "eq" %3, %5 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb3
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%arg0) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    %7 = llvm.getelementptr inbounds %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %9 = llvm.call %8(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.br ^bb1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %4 = llvm.getelementptr inbounds %arg0[%0, 0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (struct<"struct.S", (ptr, i32, i32)>)>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %6 = llvm.icmp "eq" %3, %5 : !llvm.ptr
    llvm.cond_br %6, ^bb3, ^bb2
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%arg0) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    %7 = llvm.getelementptr inbounds %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %9 = llvm.call %8(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.br ^bb1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %4 = llvm.getelementptr inbounds %arg0[%0, 0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (struct<"struct.S", (ptr, i32, i32)>)>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %6 = llvm.icmp "eq" %3, %5 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb3
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%arg0) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    %7 = llvm.getelementptr inbounds %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %9 = llvm.call %8(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.br ^bb1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %4 = llvm.getelementptr inbounds %arg0[%0, 0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"C", packed (struct<"struct.S", (ptr, i32, i32)>)>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %6 = llvm.icmp "eq" %3, %5 : !llvm.ptr
    llvm.cond_br %6, ^bb3, ^bb2
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%arg0) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    %7 = llvm.getelementptr inbounds %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %9 = llvm.call %8(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.br ^bb1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr, %arg1: i1) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.select %arg1, %1, %2 : i1, i1
    llvm.cond_br %3, ^bb3, ^bb2
  ^bb1:  // 2 preds: ^bb2, ^bb3
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @bar(%arg0) : (!llvm.ptr) -> ()
    llvm.br ^bb1
  ^bb3:  // pred: ^bb0
    llvm.call @foobar() : () -> ()
    llvm.br ^bb1
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %0, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    %2 = llvm.select %arg1, %arg0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
