import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sink_sideeffecting_instruction
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr {llvm.nocapture, llvm.writeonly}) -> i32 {
    %0 = llvm.call @baz() : () -> i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %1 = llvm.call @baz() : () -> i32
    llvm.return %1 : i32
  }]

def test_before := [llvmfunc|
  llvm.func @test() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %4 = llvm.call @foo(%2) : (!llvm.ptr) -> i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb5(%1 : i32)
  ^bb1:  // pred: ^bb0
    llvm.intr.lifetime.start 4, %3 : !llvm.ptr
    %6 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.call @foo(%3) : (!llvm.ptr) -> i32
    llvm.cond_br %7, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %9 = llvm.call @bar() : () -> i32
    llvm.br ^bb4(%9 : i32)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%8 : i32)
  ^bb4(%10: i32):  // 2 preds: ^bb2, ^bb3
    llvm.intr.lifetime.end 4, %3 : !llvm.ptr
    llvm.br ^bb5(%10 : i32)
  ^bb5(%11: i32):  // 2 preds: ^bb0, ^bb4
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.return %11 : i32
  }]

def sink_write_to_use_before := [llvmfunc|
  llvm.func @sink_write_to_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

def sink_readwrite_to_use_before := [llvmfunc|
  llvm.func @sink_readwrite_to_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

def sink_bitcast_before := [llvmfunc|
  llvm.func @sink_bitcast(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i8 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

def sink_gep1_before := [llvmfunc|
  llvm.func @sink_gep1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %4 = llvm.call @unknown(%3) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %4 : i32
  }]

def sink_gep2_before := [llvmfunc|
  llvm.func @sink_gep2(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

def sink_addrspacecast_before := [llvmfunc|
  llvm.func @sink_addrspacecast(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.addrspacecast %2 : !llvm.ptr to !llvm.ptr<2>
    %4 = llvm.call @unknown.as2(%3) : (!llvm.ptr<2>) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %4 : i32
  }]

def neg_infinite_loop_before := [llvmfunc|
  llvm.func @neg_infinite_loop(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

def neg_throw_before := [llvmfunc|
  llvm.func @neg_throw(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

def neg_unknown_write_before := [llvmfunc|
  llvm.func @neg_unknown_write(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

def sink_lifetime1_before := [llvmfunc|
  llvm.func @sink_lifetime1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.return %3 : i32
  }]

def sink_lifetime2_before := [llvmfunc|
  llvm.func @sink_lifetime2(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1(%1 : i32), ^bb2
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.return %4 : i32
  ^bb2:  // pred: ^bb0
    llvm.br ^bb1(%3 : i32)
  }]

def sink_lifetime3_before := [llvmfunc|
  llvm.func @sink_lifetime3(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

def sink_lifetime4a_before := [llvmfunc|
  llvm.func @sink_lifetime4a(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

def sink_lifetime4b_before := [llvmfunc|
  llvm.func @sink_lifetime4b(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

def sink_atomicrmw_to_use_before := [llvmfunc|
  llvm.func @sink_atomicrmw_to_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.atomicrmw add %2, %0 seq_cst {alignment = 4 : i64} : !llvm.ptr, i32]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr {llvm.nocapture, llvm.writeonly}) -> i32 {
    %0 = llvm.call @baz() : () -> i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @baz() : () -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def test_combined := [llvmfunc|
  llvm.func @test() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %4 = llvm.call @foo(%2) : (!llvm.ptr) -> i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb5(%1 : i32)
  ^bb1:  // pred: ^bb0
    llvm.intr.lifetime.start 4, %3 : !llvm.ptr
    %6 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.call @foo(%3) : (!llvm.ptr) -> i32
    llvm.cond_br %7, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %9 = llvm.call @bar() : () -> i32
    llvm.br ^bb4(%9 : i32)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%8 : i32)
  ^bb4(%10: i32):  // 2 preds: ^bb2, ^bb3
    llvm.intr.lifetime.end 4, %3 : !llvm.ptr
    llvm.br ^bb5(%10 : i32)
  ^bb5(%11: i32):  // 2 preds: ^bb0, ^bb4
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.return %11 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def sink_write_to_use_combined := [llvmfunc|
  llvm.func @sink_write_to_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_sink_write_to_use   : sink_write_to_use_before  ⊑  sink_write_to_use_combined := by
  unfold sink_write_to_use_before sink_write_to_use_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sink_write_to_use   : sink_write_to_use_before  ⊑  sink_write_to_use_combined := by
  unfold sink_write_to_use_before sink_write_to_use_combined
  simp_alive_peephole
  sorry
def sink_readwrite_to_use_combined := [llvmfunc|
  llvm.func @sink_readwrite_to_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_sink_readwrite_to_use   : sink_readwrite_to_use_before  ⊑  sink_readwrite_to_use_combined := by
  unfold sink_readwrite_to_use_before sink_readwrite_to_use_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sink_readwrite_to_use   : sink_readwrite_to_use_before  ⊑  sink_readwrite_to_use_combined := by
  unfold sink_readwrite_to_use_before sink_readwrite_to_use_combined
  simp_alive_peephole
  sorry
def sink_bitcast_combined := [llvmfunc|
  llvm.func @sink_bitcast(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i8 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_sink_bitcast   : sink_bitcast_before  ⊑  sink_bitcast_combined := by
  unfold sink_bitcast_before sink_bitcast_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sink_bitcast   : sink_bitcast_before  ⊑  sink_bitcast_combined := by
  unfold sink_bitcast_before sink_bitcast_combined
  simp_alive_peephole
  sorry
def sink_gep1_combined := [llvmfunc|
  llvm.func @sink_gep1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_sink_gep1   : sink_gep1_before  ⊑  sink_gep1_combined := by
  unfold sink_gep1_before sink_gep1_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i32
  ^bb2:  // pred: ^bb0
    %4 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %5 = llvm.call @unknown(%4) : (!llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_sink_gep1   : sink_gep1_before  ⊑  sink_gep1_combined := by
  unfold sink_gep1_before sink_gep1_combined
  simp_alive_peephole
  sorry
def sink_gep2_combined := [llvmfunc|
  llvm.func @sink_gep2(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_sink_gep2   : sink_gep2_before  ⊑  sink_gep2_combined := by
  unfold sink_gep2_before sink_gep2_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sink_gep2   : sink_gep2_before  ⊑  sink_gep2_combined := by
  unfold sink_gep2_before sink_gep2_combined
  simp_alive_peephole
  sorry
def sink_addrspacecast_combined := [llvmfunc|
  llvm.func @sink_addrspacecast(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_sink_addrspacecast   : sink_addrspacecast_before  ⊑  sink_addrspacecast_combined := by
  unfold sink_addrspacecast_before sink_addrspacecast_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    %3 = llvm.addrspacecast %2 : !llvm.ptr to !llvm.ptr<2>
    %4 = llvm.call @unknown.as2(%3) : (!llvm.ptr<2>) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_sink_addrspacecast   : sink_addrspacecast_before  ⊑  sink_addrspacecast_combined := by
  unfold sink_addrspacecast_before sink_addrspacecast_combined
  simp_alive_peephole
  sorry
def neg_infinite_loop_combined := [llvmfunc|
  llvm.func @neg_infinite_loop(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_neg_infinite_loop   : neg_infinite_loop_before  ⊑  neg_infinite_loop_combined := by
  unfold neg_infinite_loop_before neg_infinite_loop_combined
  simp_alive_peephole
  sorry
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

theorem inst_combine_neg_infinite_loop   : neg_infinite_loop_before  ⊑  neg_infinite_loop_combined := by
  unfold neg_infinite_loop_before neg_infinite_loop_combined
  simp_alive_peephole
  sorry
def neg_throw_combined := [llvmfunc|
  llvm.func @neg_throw(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_neg_throw   : neg_throw_before  ⊑  neg_throw_combined := by
  unfold neg_throw_before neg_throw_combined
  simp_alive_peephole
  sorry
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

theorem inst_combine_neg_throw   : neg_throw_before  ⊑  neg_throw_combined := by
  unfold neg_throw_before neg_throw_combined
  simp_alive_peephole
  sorry
def neg_unknown_write_combined := [llvmfunc|
  llvm.func @neg_unknown_write(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_neg_unknown_write   : neg_unknown_write_before  ⊑  neg_unknown_write_combined := by
  unfold neg_unknown_write_before neg_unknown_write_combined
  simp_alive_peephole
  sorry
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

theorem inst_combine_neg_unknown_write   : neg_unknown_write_before  ⊑  neg_unknown_write_combined := by
  unfold neg_unknown_write_before neg_unknown_write_combined
  simp_alive_peephole
  sorry
def sink_lifetime1_combined := [llvmfunc|
  llvm.func @sink_lifetime1(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_sink_lifetime1   : sink_lifetime1_before  ⊑  sink_lifetime1_combined := by
  unfold sink_lifetime1_before sink_lifetime1_combined
  simp_alive_peephole
  sorry
    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.return %3 : i32
  }]

theorem inst_combine_sink_lifetime1   : sink_lifetime1_before  ⊑  sink_lifetime1_combined := by
  unfold sink_lifetime1_before sink_lifetime1_combined
  simp_alive_peephole
  sorry
def sink_lifetime2_combined := [llvmfunc|
  llvm.func @sink_lifetime2(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_sink_lifetime2   : sink_lifetime2_before  ⊑  sink_lifetime2_combined := by
  unfold sink_lifetime2_before sink_lifetime2_combined
  simp_alive_peephole
  sorry
    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg0, ^bb1(%1 : i32), ^bb2
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.return %4 : i32
  ^bb2:  // pred: ^bb0
    llvm.br ^bb1(%3 : i32)
  }]

theorem inst_combine_sink_lifetime2   : sink_lifetime2_before  ⊑  sink_lifetime2_combined := by
  unfold sink_lifetime2_before sink_lifetime2_combined
  simp_alive_peephole
  sorry
def sink_lifetime3_combined := [llvmfunc|
  llvm.func @sink_lifetime3(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_sink_lifetime3   : sink_lifetime3_before  ⊑  sink_lifetime3_combined := by
  unfold sink_lifetime3_before sink_lifetime3_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sink_lifetime3   : sink_lifetime3_before  ⊑  sink_lifetime3_combined := by
  unfold sink_lifetime3_before sink_lifetime3_combined
  simp_alive_peephole
  sorry
def sink_lifetime4a_combined := [llvmfunc|
  llvm.func @sink_lifetime4a(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_sink_lifetime4a   : sink_lifetime4a_before  ⊑  sink_lifetime4a_combined := by
  unfold sink_lifetime4a_before sink_lifetime4a_combined
  simp_alive_peephole
  sorry
    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

theorem inst_combine_sink_lifetime4a   : sink_lifetime4a_before  ⊑  sink_lifetime4a_combined := by
  unfold sink_lifetime4a_before sink_lifetime4a_combined
  simp_alive_peephole
  sorry
def sink_lifetime4b_combined := [llvmfunc|
  llvm.func @sink_lifetime4b(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_sink_lifetime4b   : sink_lifetime4b_before  ⊑  sink_lifetime4b_combined := by
  unfold sink_lifetime4b_before sink_lifetime4b_combined
  simp_alive_peephole
  sorry
    llvm.intr.lifetime.start 4, %2 : !llvm.ptr
    %3 = llvm.call @unknown(%2) : (!llvm.ptr) -> i32
    llvm.intr.lifetime.end 4, %2 : !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

theorem inst_combine_sink_lifetime4b   : sink_lifetime4b_before  ⊑  sink_lifetime4b_combined := by
  unfold sink_lifetime4b_before sink_lifetime4b_combined
  simp_alive_peephole
  sorry
def sink_atomicrmw_to_use_combined := [llvmfunc|
  llvm.func @sink_atomicrmw_to_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_sink_atomicrmw_to_use   : sink_atomicrmw_to_use_before  ⊑  sink_atomicrmw_to_use_combined := by
  unfold sink_atomicrmw_to_use_before sink_atomicrmw_to_use_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_sink_atomicrmw_to_use   : sink_atomicrmw_to_use_before  ⊑  sink_atomicrmw_to_use_combined := by
  unfold sink_atomicrmw_to_use_before sink_atomicrmw_to_use_combined
  simp_alive_peephole
  sorry
    %3 = llvm.atomicrmw add %2, %0 seq_cst {alignment = 4 : i64} : !llvm.ptr, i32]

theorem inst_combine_sink_atomicrmw_to_use   : sink_atomicrmw_to_use_before  ⊑  sink_atomicrmw_to_use_combined := by
  unfold sink_atomicrmw_to_use_before sink_atomicrmw_to_use_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %3 : i32
  }]

theorem inst_combine_sink_atomicrmw_to_use   : sink_atomicrmw_to_use_before  ⊑  sink_atomicrmw_to_use_combined := by
  unfold sink_atomicrmw_to_use_before sink_atomicrmw_to_use_combined
  simp_alive_peephole
  sorry
