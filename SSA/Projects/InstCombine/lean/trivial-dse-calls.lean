import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  trivial-dse-calls
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_dead_before := [llvmfunc|
  llvm.func @test_dead() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test_lifetime_before := [llvmfunc|
  llvm.func @test_lifetime() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 4, %1 : !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.intr.lifetime.end 4, %1 : !llvm.ptr
    llvm.return
  }]

def test_lifetime2_before := [llvmfunc|
  llvm.func @test_lifetime2() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 4, %1 : !llvm.ptr
    llvm.call @unknown() : () -> ()
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.call @unknown() : () -> ()
    llvm.intr.lifetime.end 4, %1 : !llvm.ptr
    llvm.return
  }]

def test_dead_readwrite_before := [llvmfunc|
  llvm.func @test_dead_readwrite() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test_neg_read_after_before := [llvmfunc|
  llvm.func @test_neg_read_after() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @f(%1) : (!llvm.ptr) -> ()
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def test_neg_infinite_loop_before := [llvmfunc|
  llvm.func @test_neg_infinite_loop() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test_neg_throw_before := [llvmfunc|
  llvm.func @test_neg_throw() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test_neg_extra_write_before := [llvmfunc|
  llvm.func @test_neg_extra_write() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test_neg_unmodeled_write_before := [llvmfunc|
  llvm.func @test_neg_unmodeled_write() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @f2(%1, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def test_neg_captured_by_call_before := [llvmfunc|
  llvm.func @test_neg_captured_by_call() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @f2(%1, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %4 : i32
  }]

def test_neg_captured_before_before := [llvmfunc|
  llvm.func @test_neg_captured_before() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.call @f(%1) : (!llvm.ptr) -> ()
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %4 : i32
  }]

def test_unreleated_read_before := [llvmfunc|
  llvm.func @test_unreleated_read() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @f2(%1, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def test_unrelated_capture_before := [llvmfunc|
  llvm.func @test_unrelated_capture() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.call @f3(%1, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return
  }]

def test_neg_unrelated_capture_used_via_return_before := [llvmfunc|
  llvm.func @test_neg_unrelated_capture_used_via_return() -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.call @f3(%1, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %4 = llvm.load %3 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %4 : i8
  }]

def test_self_read_before := [llvmfunc|
  llvm.func @test_self_read() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.call @f2(%1, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def test_readnone_before := [llvmfunc|
  llvm.func @test_readnone() {
    llvm.call @removable_readnone() : () -> ()
    llvm.return
  }]

def test_readnone_with_deopt_before := [llvmfunc|
  llvm.func @test_readnone_with_deopt() {
    llvm.call @removable_readnone() : () -> ()
    llvm.return
  }]

def test_readonly_before := [llvmfunc|
  llvm.func @test_readonly() {
    llvm.call @removable_ro() : () -> ()
    llvm.return
  }]

def test_readonly_with_deopt_before := [llvmfunc|
  llvm.func @test_readonly_with_deopt() {
    llvm.call @removable_ro() : () -> ()
    llvm.return
  }]

def test_dead_combined := [llvmfunc|
  llvm.func @test_dead() {
    llvm.return
  }]

theorem inst_combine_test_dead   : test_dead_before  ⊑  test_dead_combined := by
  unfold test_dead_before test_dead_combined
  simp_alive_peephole
  sorry
def test_lifetime_combined := [llvmfunc|
  llvm.func @test_lifetime() {
    llvm.return
  }]

theorem inst_combine_test_lifetime   : test_lifetime_before  ⊑  test_lifetime_combined := by
  unfold test_lifetime_before test_lifetime_combined
  simp_alive_peephole
  sorry
def test_lifetime2_combined := [llvmfunc|
  llvm.func @test_lifetime2() {
    llvm.call @unknown() : () -> ()
    llvm.call @unknown() : () -> ()
    llvm.return
  }]

theorem inst_combine_test_lifetime2   : test_lifetime2_before  ⊑  test_lifetime2_combined := by
  unfold test_lifetime2_before test_lifetime2_combined
  simp_alive_peephole
  sorry
def test_dead_readwrite_combined := [llvmfunc|
  llvm.func @test_dead_readwrite() {
    llvm.return
  }]

theorem inst_combine_test_dead_readwrite   : test_dead_readwrite_before  ⊑  test_dead_readwrite_combined := by
  unfold test_dead_readwrite_before test_dead_readwrite_combined
  simp_alive_peephole
  sorry
def test_neg_read_after_combined := [llvmfunc|
  llvm.func @test_neg_read_after() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test_neg_read_after   : test_neg_read_after_before  ⊑  test_neg_read_after_combined := by
  unfold test_neg_read_after_before test_neg_read_after_combined
  simp_alive_peephole
  sorry
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test_neg_read_after   : test_neg_read_after_before  ⊑  test_neg_read_after_combined := by
  unfold test_neg_read_after_before test_neg_read_after_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_test_neg_read_after   : test_neg_read_after_before  ⊑  test_neg_read_after_combined := by
  unfold test_neg_read_after_before test_neg_read_after_combined
  simp_alive_peephole
  sorry
def test_neg_infinite_loop_combined := [llvmfunc|
  llvm.func @test_neg_infinite_loop() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test_neg_infinite_loop   : test_neg_infinite_loop_before  ⊑  test_neg_infinite_loop_combined := by
  unfold test_neg_infinite_loop_before test_neg_infinite_loop_combined
  simp_alive_peephole
  sorry
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test_neg_infinite_loop   : test_neg_infinite_loop_before  ⊑  test_neg_infinite_loop_combined := by
  unfold test_neg_infinite_loop_before test_neg_infinite_loop_combined
  simp_alive_peephole
  sorry
def test_neg_throw_combined := [llvmfunc|
  llvm.func @test_neg_throw() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test_neg_throw   : test_neg_throw_before  ⊑  test_neg_throw_combined := by
  unfold test_neg_throw_before test_neg_throw_combined
  simp_alive_peephole
  sorry
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test_neg_throw   : test_neg_throw_before  ⊑  test_neg_throw_combined := by
  unfold test_neg_throw_before test_neg_throw_combined
  simp_alive_peephole
  sorry
def test_neg_extra_write_combined := [llvmfunc|
  llvm.func @test_neg_extra_write() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test_neg_extra_write   : test_neg_extra_write_before  ⊑  test_neg_extra_write_combined := by
  unfold test_neg_extra_write_before test_neg_extra_write_combined
  simp_alive_peephole
  sorry
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test_neg_extra_write   : test_neg_extra_write_before  ⊑  test_neg_extra_write_combined := by
  unfold test_neg_extra_write_before test_neg_extra_write_combined
  simp_alive_peephole
  sorry
def test_neg_unmodeled_write_combined := [llvmfunc|
  llvm.func @test_neg_unmodeled_write() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test_neg_unmodeled_write   : test_neg_unmodeled_write_before  ⊑  test_neg_unmodeled_write_combined := by
  unfold test_neg_unmodeled_write_before test_neg_unmodeled_write_combined
  simp_alive_peephole
  sorry
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test_neg_unmodeled_write   : test_neg_unmodeled_write_before  ⊑  test_neg_unmodeled_write_combined := by
  unfold test_neg_unmodeled_write_before test_neg_unmodeled_write_combined
  simp_alive_peephole
  sorry
    llvm.call @f2(%1, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test_neg_unmodeled_write   : test_neg_unmodeled_write_before  ⊑  test_neg_unmodeled_write_combined := by
  unfold test_neg_unmodeled_write_before test_neg_unmodeled_write_combined
  simp_alive_peephole
  sorry
def test_neg_captured_by_call_combined := [llvmfunc|
  llvm.func @test_neg_captured_by_call() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test_neg_captured_by_call   : test_neg_captured_by_call_before  ⊑  test_neg_captured_by_call_combined := by
  unfold test_neg_captured_by_call_before test_neg_captured_by_call_combined
  simp_alive_peephole
  sorry
    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test_neg_captured_by_call   : test_neg_captured_by_call_before  ⊑  test_neg_captured_by_call_combined := by
  unfold test_neg_captured_by_call_before test_neg_captured_by_call_combined
  simp_alive_peephole
  sorry
    llvm.call @f2(%1, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_test_neg_captured_by_call   : test_neg_captured_by_call_before  ⊑  test_neg_captured_by_call_combined := by
  unfold test_neg_captured_by_call_before test_neg_captured_by_call_combined
  simp_alive_peephole
  sorry
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test_neg_captured_by_call   : test_neg_captured_by_call_before  ⊑  test_neg_captured_by_call_combined := by
  unfold test_neg_captured_by_call_before test_neg_captured_by_call_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i32
  }]

theorem inst_combine_test_neg_captured_by_call   : test_neg_captured_by_call_before  ⊑  test_neg_captured_by_call_combined := by
  unfold test_neg_captured_by_call_before test_neg_captured_by_call_combined
  simp_alive_peephole
  sorry
def test_neg_captured_before_combined := [llvmfunc|
  llvm.func @test_neg_captured_before() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test_neg_captured_before   : test_neg_captured_before_before  ⊑  test_neg_captured_before_combined := by
  unfold test_neg_captured_before_before test_neg_captured_before_combined
  simp_alive_peephole
  sorry
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test_neg_captured_before   : test_neg_captured_before_before  ⊑  test_neg_captured_before_combined := by
  unfold test_neg_captured_before_before test_neg_captured_before_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_test_neg_captured_before   : test_neg_captured_before_before  ⊑  test_neg_captured_before_combined := by
  unfold test_neg_captured_before_before test_neg_captured_before_combined
  simp_alive_peephole
  sorry
def test_unreleated_read_combined := [llvmfunc|
  llvm.func @test_unreleated_read() {
    llvm.return
  }]

theorem inst_combine_test_unreleated_read   : test_unreleated_read_before  ⊑  test_unreleated_read_combined := by
  unfold test_unreleated_read_before test_unreleated_read_combined
  simp_alive_peephole
  sorry
def test_unrelated_capture_combined := [llvmfunc|
  llvm.func @test_unrelated_capture() {
    llvm.return
  }]

theorem inst_combine_test_unrelated_capture   : test_unrelated_capture_before  ⊑  test_unrelated_capture_combined := by
  unfold test_unrelated_capture_before test_unrelated_capture_combined
  simp_alive_peephole
  sorry
def test_neg_unrelated_capture_used_via_return_combined := [llvmfunc|
  llvm.func @test_neg_unrelated_capture_used_via_return() -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test_neg_unrelated_capture_used_via_return   : test_neg_unrelated_capture_used_via_return_before  ⊑  test_neg_unrelated_capture_used_via_return_combined := by
  unfold test_neg_unrelated_capture_used_via_return_before test_neg_unrelated_capture_used_via_return_combined
  simp_alive_peephole
  sorry
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test_neg_unrelated_capture_used_via_return   : test_neg_unrelated_capture_used_via_return_before  ⊑  test_neg_unrelated_capture_used_via_return_combined := by
  unfold test_neg_unrelated_capture_used_via_return_before test_neg_unrelated_capture_used_via_return_combined
  simp_alive_peephole
  sorry
    %3 = llvm.call @f3(%1, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %4 = llvm.load %3 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_test_neg_unrelated_capture_used_via_return   : test_neg_unrelated_capture_used_via_return_before  ⊑  test_neg_unrelated_capture_used_via_return_combined := by
  unfold test_neg_unrelated_capture_used_via_return_before test_neg_unrelated_capture_used_via_return_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i8
  }]

theorem inst_combine_test_neg_unrelated_capture_used_via_return   : test_neg_unrelated_capture_used_via_return_before  ⊑  test_neg_unrelated_capture_used_via_return_combined := by
  unfold test_neg_unrelated_capture_used_via_return_before test_neg_unrelated_capture_used_via_return_combined
  simp_alive_peephole
  sorry
def test_self_read_combined := [llvmfunc|
  llvm.func @test_self_read() {
    llvm.return
  }]

theorem inst_combine_test_self_read   : test_self_read_before  ⊑  test_self_read_combined := by
  unfold test_self_read_before test_self_read_combined
  simp_alive_peephole
  sorry
def test_readnone_combined := [llvmfunc|
  llvm.func @test_readnone() {
    llvm.return
  }]

theorem inst_combine_test_readnone   : test_readnone_before  ⊑  test_readnone_combined := by
  unfold test_readnone_before test_readnone_combined
  simp_alive_peephole
  sorry
def test_readnone_with_deopt_combined := [llvmfunc|
  llvm.func @test_readnone_with_deopt() {
    llvm.return
  }]

theorem inst_combine_test_readnone_with_deopt   : test_readnone_with_deopt_before  ⊑  test_readnone_with_deopt_combined := by
  unfold test_readnone_with_deopt_before test_readnone_with_deopt_combined
  simp_alive_peephole
  sorry
def test_readonly_combined := [llvmfunc|
  llvm.func @test_readonly() {
    llvm.return
  }]

theorem inst_combine_test_readonly   : test_readonly_before  ⊑  test_readonly_combined := by
  unfold test_readonly_before test_readonly_combined
  simp_alive_peephole
  sorry
def test_readonly_with_deopt_combined := [llvmfunc|
  llvm.func @test_readonly_with_deopt() {
    llvm.return
  }]

theorem inst_combine_test_readonly_with_deopt   : test_readonly_with_deopt_before  ⊑  test_readonly_with_deopt_combined := by
  unfold test_readonly_with_deopt_before test_readonly_with_deopt_combined
  simp_alive_peephole
  sorry
