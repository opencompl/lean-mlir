import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  atomic
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.load %arg0 atomic monotonic {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.load %arg0 atomic acquire {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

def test9_before := [llvmfunc|
  llvm.func @test9() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %1 : i32
  }]

def test9_no_null_opt_before := [llvmfunc|
  llvm.func @test9_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %1 : i32
  }]

def test10_before := [llvmfunc|
  llvm.func @test10() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic monotonic {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %1 : i32
  }]

def test10_no_null_opt_before := [llvmfunc|
  llvm.func @test10_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic monotonic {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %1 : i32
  }]

def test11_before := [llvmfunc|
  llvm.func @test11() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %1 : i32
  }]

def test11_no_null_opt_before := [llvmfunc|
  llvm.func @test11_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %1 : i32
  }]

def test12_before := [llvmfunc|
  llvm.func @test12() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %0 : i32
  }]

def test12_no_null_opt_before := [llvmfunc|
  llvm.func @test12_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %0 : i32
  }]

def test13_before := [llvmfunc|
  llvm.func @test13() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic monotonic {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %0 : i32
  }]

def test13_no_null_opt_before := [llvmfunc|
  llvm.func @test13_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic monotonic {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %0 : i32
  }]

def test14_before := [llvmfunc|
  llvm.func @test14() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %0 : i32
  }]

def test14_no_null_opt_before := [llvmfunc|
  llvm.func @test14_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %0 : i32
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: i1) -> i32 {
    %0 = llvm.mlir.addressof @a : !llvm.ptr
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.select %arg0, %0, %1 : i1, !llvm.ptr
    %3 = llvm.load %2 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %3 : i32
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: i1) -> i32 {
    %0 = llvm.mlir.addressof @a : !llvm.ptr
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.select %arg0, %0, %1 : i1, !llvm.ptr
    %3 = llvm.load %2 atomic monotonic {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %3 : i32
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: i1) -> i32 {
    %0 = llvm.mlir.addressof @a : !llvm.ptr
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.select %arg0, %0, %1 : i1, !llvm.ptr
    %3 = llvm.load %2 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %3 : i32
  }]

def test22_before := [llvmfunc|
  llvm.func @test22(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %2, %1 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %0, %1 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : i32
  }]

def test23_before := [llvmfunc|
  llvm.func @test23(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %2, %1 atomic monotonic {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %0, %1 atomic monotonic {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : i32
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.call @clobber() : () -> ()
    llvm.store %1, %arg0 atomic unordered {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.return %0 : i32
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.call @clobber() : () -> ()
    llvm.store %1, %arg0 atomic seq_cst {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.return %0 : i32
  }]

def test20_before := [llvmfunc|
  llvm.func @test20(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %arg1, %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return %0 : i32
  }]

def test21_before := [llvmfunc|
  llvm.func @test21(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %arg1, %arg0 atomic monotonic {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return %0 : i32
  }]

def pr27490a_before := [llvmfunc|
  llvm.func @pr27490a(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.store volatile %0, %arg1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def pr27490b_before := [llvmfunc|
  llvm.func @pr27490b(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.store %0, %arg1 atomic seq_cst {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def no_atomic_vector_load_before := [llvmfunc|
  llvm.func @no_atomic_vector_load(%arg0: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.load %arg0 atomic unordered {alignment = 8 : i64} : !llvm.ptr -> i64]

    %1 = llvm.bitcast %0 : i64 to vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def no_atomic_vector_store_before := [llvmfunc|
  llvm.func @no_atomic_vector_store(%arg0: vector<2xf32>, %arg1: !llvm.ptr) {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to i64
    llvm.store %0, %arg1 atomic unordered {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def atomic_load_from_constant_global_before := [llvmfunc|
  llvm.func @atomic_load_from_constant_global() -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    %2 = llvm.load %1 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def atomic_load_from_constant_global_bitcast_before := [llvmfunc|
  llvm.func @atomic_load_from_constant_global_bitcast() -> i8 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    %2 = llvm.load %1 atomic seq_cst {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %2 : i8
  }]

def atomic_load_from_non_constant_global_before := [llvmfunc|
  llvm.func @atomic_load_from_non_constant_global() {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.load %1 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return
  }]

def volatile_load_from_constant_global_before := [llvmfunc|
  llvm.func @volatile_load_from_constant_global() {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    %2 = llvm.load volatile %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.load %arg0 atomic monotonic {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.load %arg0 atomic acquire {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9() -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : !llvm.ptr
    %2 = llvm.mlir.poison : i32
    llvm.store %0, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i32
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test9_no_null_opt_combined := [llvmfunc|
  llvm.func @test9_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test9_no_null_opt   : test9_no_null_opt_before  ⊑  test9_no_null_opt_combined := by
  unfold test9_no_null_opt_before test9_no_null_opt_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic monotonic {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test10_no_null_opt_combined := [llvmfunc|
  llvm.func @test10_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic monotonic {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test10_no_null_opt   : test10_no_null_opt_before  ⊑  test10_no_null_opt_combined := by
  unfold test10_no_null_opt_before test10_no_null_opt_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test11_no_null_opt_combined := [llvmfunc|
  llvm.func @test11_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test11_no_null_opt   : test11_no_null_opt_before  ⊑  test11_no_null_opt_combined := by
  unfold test11_no_null_opt_before test11_no_null_opt_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12() -> i32 {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %1 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %2 : i32
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test12_no_null_opt_combined := [llvmfunc|
  llvm.func @test12_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %0 : i32
  }]

theorem inst_combine_test12_no_null_opt   : test12_no_null_opt_before  ⊑  test12_no_null_opt_combined := by
  unfold test12_no_null_opt_before test12_no_null_opt_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic monotonic {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %0 : i32
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test13_no_null_opt_combined := [llvmfunc|
  llvm.func @test13_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic monotonic {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %0 : i32
  }]

theorem inst_combine_test13_no_null_opt   : test13_no_null_opt_before  ⊑  test13_no_null_opt_combined := by
  unfold test13_no_null_opt_before test13_no_null_opt_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %0 : i32
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test14_no_null_opt_combined := [llvmfunc|
  llvm.func @test14_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %0 : i32
  }]

theorem inst_combine_test14_no_null_opt   : test14_no_null_opt_before  ⊑  test14_no_null_opt_combined := by
  unfold test14_no_null_opt_before test14_no_null_opt_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: i1) -> i32 {
    %0 = llvm.mlir.addressof @a : !llvm.ptr
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.load %0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    %3 = llvm.load %1 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.select %arg0, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: i1) -> i32 {
    %0 = llvm.mlir.addressof @a : !llvm.ptr
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.select %arg0, %0, %1 : i1, !llvm.ptr
    %3 = llvm.load %2 atomic monotonic {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: i1) -> i32 {
    %0 = llvm.mlir.addressof @a : !llvm.ptr
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.select %arg0, %0, %1 : i1, !llvm.ptr
    %3 = llvm.load %2 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test22_combined := [llvmfunc|
  llvm.func @test22(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %4, %2 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %3 : i32
  }]

theorem inst_combine_test22   : test22_before  ⊑  test22_combined := by
  unfold test22_before test22_combined
  simp_alive_peephole
  sorry
def test23_combined := [llvmfunc|
  llvm.func @test23(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %2, %1 atomic monotonic {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %0, %1 atomic monotonic {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : i32
  }]

theorem inst_combine_test23   : test23_before  ⊑  test23_combined := by
  unfold test23_before test23_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.call @clobber() : () -> ()
    llvm.store %1, %arg0 atomic unordered {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.return %0 : i32
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.call @clobber() : () -> ()
    llvm.store %1, %arg0 atomic seq_cst {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.return %0 : i32
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
def test20_combined := [llvmfunc|
  llvm.func @test20(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %arg1, %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return %0 : i32
  }]

theorem inst_combine_test20   : test20_before  ⊑  test20_combined := by
  unfold test20_before test20_combined
  simp_alive_peephole
  sorry
def test21_combined := [llvmfunc|
  llvm.func @test21(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %arg1, %arg0 atomic monotonic {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return %0 : i32
  }]

theorem inst_combine_test21   : test21_before  ⊑  test21_combined := by
  unfold test21_before test21_combined
  simp_alive_peephole
  sorry
def pr27490a_combined := [llvmfunc|
  llvm.func @pr27490a(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store volatile %0, %arg1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_pr27490a   : pr27490a_before  ⊑  pr27490a_combined := by
  unfold pr27490a_before pr27490a_combined
  simp_alive_peephole
  sorry
def pr27490b_combined := [llvmfunc|
  llvm.func @pr27490b(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %0, %arg1 atomic seq_cst {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_pr27490b   : pr27490b_before  ⊑  pr27490b_combined := by
  unfold pr27490b_before pr27490b_combined
  simp_alive_peephole
  sorry
def no_atomic_vector_load_combined := [llvmfunc|
  llvm.func @no_atomic_vector_load(%arg0: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.load %arg0 atomic unordered {alignment = 8 : i64} : !llvm.ptr -> i64
    %1 = llvm.bitcast %0 : i64 to vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_no_atomic_vector_load   : no_atomic_vector_load_before  ⊑  no_atomic_vector_load_combined := by
  unfold no_atomic_vector_load_before no_atomic_vector_load_combined
  simp_alive_peephole
  sorry
def no_atomic_vector_store_combined := [llvmfunc|
  llvm.func @no_atomic_vector_store(%arg0: vector<2xf32>, %arg1: !llvm.ptr) {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to i64
    llvm.store %0, %arg1 atomic unordered {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_no_atomic_vector_store   : no_atomic_vector_store_before  ⊑  no_atomic_vector_store_combined := by
  unfold no_atomic_vector_store_before no_atomic_vector_store_combined
  simp_alive_peephole
  sorry
def atomic_load_from_constant_global_combined := [llvmfunc|
  llvm.func @atomic_load_from_constant_global() -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_atomic_load_from_constant_global   : atomic_load_from_constant_global_before  ⊑  atomic_load_from_constant_global_combined := by
  unfold atomic_load_from_constant_global_before atomic_load_from_constant_global_combined
  simp_alive_peephole
  sorry
def atomic_load_from_constant_global_bitcast_combined := [llvmfunc|
  llvm.func @atomic_load_from_constant_global_bitcast() -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_atomic_load_from_constant_global_bitcast   : atomic_load_from_constant_global_bitcast_before  ⊑  atomic_load_from_constant_global_bitcast_combined := by
  unfold atomic_load_from_constant_global_bitcast_before atomic_load_from_constant_global_bitcast_combined
  simp_alive_peephole
  sorry
def atomic_load_from_non_constant_global_combined := [llvmfunc|
  llvm.func @atomic_load_from_non_constant_global() {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.load %1 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return
  }]

theorem inst_combine_atomic_load_from_non_constant_global   : atomic_load_from_non_constant_global_before  ⊑  atomic_load_from_non_constant_global_combined := by
  unfold atomic_load_from_non_constant_global_before atomic_load_from_non_constant_global_combined
  simp_alive_peephole
  sorry
def volatile_load_from_constant_global_combined := [llvmfunc|
  llvm.func @volatile_load_from_constant_global() {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    %2 = llvm.load volatile %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return
  }]

theorem inst_combine_volatile_load_from_constant_global   : volatile_load_from_constant_global_before  ⊑  volatile_load_from_constant_global_combined := by
  unfold volatile_load_from_constant_global_before volatile_load_from_constant_global_combined
  simp_alive_peephole
  sorry
