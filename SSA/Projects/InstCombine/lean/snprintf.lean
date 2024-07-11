import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  snprintf
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_not_const_fmt_before := [llvmfunc|
  llvm.func @test_not_const_fmt(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @snprintf(%arg0, %0, %arg1) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }]

def test_not_const_fmt_zero_size_return_value_before := [llvmfunc|
  llvm.func @test_not_const_fmt_zero_size_return_value(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @snprintf(%arg0, %0, %arg1) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }]

def test_not_const_size_before := [llvmfunc|
  llvm.func @test_not_const_size(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call @snprintf(%arg0, %arg1, %1) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }]

def test_return_value_before := [llvmfunc|
  llvm.func @test_return_value(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @snprintf(%arg0, %0, %2) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

def test_percentage_before := [llvmfunc|
  llvm.func @test_percentage(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant("%%\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %3 = llvm.call @snprintf(%arg0, %0, %2) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }]

def test_null_buf_return_value_before := [llvmfunc|
  llvm.func @test_null_buf_return_value() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @".str" : !llvm.ptr
    %4 = llvm.call @snprintf(%0, %1, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

def test_percentage_return_value_before := [llvmfunc|
  llvm.func @test_percentage_return_value() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("%%\00") : !llvm.array<3 x i8>
    %3 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %4 = llvm.call @snprintf(%0, %1, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

def test_correct_copy_before := [llvmfunc|
  llvm.func @test_correct_copy(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @snprintf(%arg0, %0, %2) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }]

def test_char_zero_size_before := [llvmfunc|
  llvm.func @test_char_zero_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.2" : !llvm.ptr
    %3 = llvm.mlir.constant(65 : i32) : i32
    %4 = llvm.call @snprintf(%arg0, %0, %2, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }]

def test_char_small_size_before := [llvmfunc|
  llvm.func @test_char_small_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.2" : !llvm.ptr
    %3 = llvm.mlir.constant(65 : i32) : i32
    %4 = llvm.call @snprintf(%arg0, %0, %2, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }]

def test_char_ok_size_before := [llvmfunc|
  llvm.func @test_char_ok_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.2" : !llvm.ptr
    %3 = llvm.mlir.constant(65 : i32) : i32
    %4 = llvm.call @snprintf(%arg0, %0, %2, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }]

def test_str_zero_size_before := [llvmfunc|
  llvm.func @test_str_zero_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %3 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.call @snprintf(%arg0, %0, %2, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

def test_str_small_size_before := [llvmfunc|
  llvm.func @test_str_small_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %3 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.call @snprintf(%arg0, %0, %2, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

def test_str_ok_size_before := [llvmfunc|
  llvm.func @test_str_ok_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %3 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.call @snprintf(%arg0, %0, %2, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

def test_str_ok_size_tail_before := [llvmfunc|
  llvm.func @test_str_ok_size_tail(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %3 = llvm.mlir.addressof @".str.4" : !llvm.ptr
    %4 = llvm.call @snprintf(%arg0, %0, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

def test_str_ok_size_musttail_before := [llvmfunc|
  llvm.func @test_str_ok_size_musttail(%arg0: !llvm.ptr, %arg1: i64, %arg2: !llvm.ptr, ...) -> i32 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %3 = llvm.mlir.addressof @".str.4" : !llvm.ptr
    %4 = llvm.call @snprintf(%arg0, %0, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

def test_str_ok_size_tail2_before := [llvmfunc|
  llvm.func @test_str_ok_size_tail2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %3 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.call @snprintf(%arg0, %0, %2, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

def test_str_ok_size_musttail2_before := [llvmfunc|
  llvm.func @test_str_ok_size_musttail2(%arg0: !llvm.ptr, %arg1: i64, %arg2: !llvm.ptr, ...) -> i32 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %3 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.call @snprintf(%arg0, %0, %2, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

def test_not_const_fmt_combined := [llvmfunc|
  llvm.func @test_not_const_fmt(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @snprintf(%arg0, %0, %arg1) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_not_const_fmt   : test_not_const_fmt_before  ⊑  test_not_const_fmt_combined := by
  unfold test_not_const_fmt_before test_not_const_fmt_combined
  simp_alive_peephole
  sorry
def test_not_const_fmt_zero_size_return_value_combined := [llvmfunc|
  llvm.func @test_not_const_fmt_zero_size_return_value(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @snprintf(%arg0, %0, %arg1) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_not_const_fmt_zero_size_return_value   : test_not_const_fmt_zero_size_return_value_before  ⊑  test_not_const_fmt_zero_size_return_value_combined := by
  unfold test_not_const_fmt_zero_size_return_value_before test_not_const_fmt_zero_size_return_value_combined
  simp_alive_peephole
  sorry
def test_not_const_size_combined := [llvmfunc|
  llvm.func @test_not_const_size(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call @snprintf(%arg0, %arg1, %1) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_not_const_size   : test_not_const_size_before  ⊑  test_not_const_size_combined := by
  unfold test_not_const_size_before test_not_const_size_combined
  simp_alive_peephole
  sorry
def test_return_value_combined := [llvmfunc|
  llvm.func @test_return_value(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_return_value   : test_return_value_before  ⊑  test_return_value_combined := by
  unfold test_return_value_before test_return_value_combined
  simp_alive_peephole
  sorry
def test_percentage_combined := [llvmfunc|
  llvm.func @test_percentage(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant("%%\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %3 = llvm.call @snprintf(%arg0, %0, %2) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_percentage   : test_percentage_before  ⊑  test_percentage_combined := by
  unfold test_percentage_before test_percentage_combined
  simp_alive_peephole
  sorry
def test_null_buf_return_value_combined := [llvmfunc|
  llvm.func @test_null_buf_return_value() -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_null_buf_return_value   : test_null_buf_return_value_before  ⊑  test_null_buf_return_value_combined := by
  unfold test_null_buf_return_value_before test_null_buf_return_value_combined
  simp_alive_peephole
  sorry
def test_percentage_return_value_combined := [llvmfunc|
  llvm.func @test_percentage_return_value() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("%%\00") : !llvm.array<3 x i8>
    %3 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %4 = llvm.call @snprintf(%0, %1, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_percentage_return_value   : test_percentage_return_value_before  ⊑  test_percentage_return_value_combined := by
  unfold test_percentage_return_value_before test_percentage_return_value_combined
  simp_alive_peephole
  sorry
def test_correct_copy_combined := [llvmfunc|
  llvm.func @test_correct_copy(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(7500915 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i32, !llvm.ptr]

theorem inst_combine_test_correct_copy   : test_correct_copy_before  ⊑  test_correct_copy_combined := by
  unfold test_correct_copy_before test_correct_copy_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_correct_copy   : test_correct_copy_before  ⊑  test_correct_copy_combined := by
  unfold test_correct_copy_before test_correct_copy_combined
  simp_alive_peephole
  sorry
def test_char_zero_size_combined := [llvmfunc|
  llvm.func @test_char_zero_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_char_zero_size   : test_char_zero_size_before  ⊑  test_char_zero_size_combined := by
  unfold test_char_zero_size_before test_char_zero_size_combined
  simp_alive_peephole
  sorry
def test_char_small_size_combined := [llvmfunc|
  llvm.func @test_char_small_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_char_small_size   : test_char_small_size_before  ⊑  test_char_small_size_combined := by
  unfold test_char_small_size_before test_char_small_size_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_test_char_small_size   : test_char_small_size_before  ⊑  test_char_small_size_combined := by
  unfold test_char_small_size_before test_char_small_size_combined
  simp_alive_peephole
  sorry
def test_char_ok_size_combined := [llvmfunc|
  llvm.func @test_char_ok_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(65 : i8) : i8
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(1 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_char_ok_size   : test_char_ok_size_before  ⊑  test_char_ok_size_combined := by
  unfold test_char_ok_size_before test_char_ok_size_combined
  simp_alive_peephole
  sorry
    %4 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %2, %4 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_char_ok_size   : test_char_ok_size_before  ⊑  test_char_ok_size_combined := by
  unfold test_char_ok_size_before test_char_ok_size_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i32
  }]

theorem inst_combine_test_char_ok_size   : test_char_ok_size_before  ⊑  test_char_ok_size_combined := by
  unfold test_char_ok_size_before test_char_ok_size_combined
  simp_alive_peephole
  sorry
def test_str_zero_size_combined := [llvmfunc|
  llvm.func @test_str_zero_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_str_zero_size   : test_str_zero_size_before  ⊑  test_str_zero_size_combined := by
  unfold test_str_zero_size_before test_str_zero_size_combined
  simp_alive_peephole
  sorry
def test_str_small_size_combined := [llvmfunc|
  llvm.func @test_str_small_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(3 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_str_small_size   : test_str_small_size_before  ⊑  test_str_small_size_combined := by
  unfold test_str_small_size_before test_str_small_size_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_test_str_small_size   : test_str_small_size_before  ⊑  test_str_small_size_combined := by
  unfold test_str_small_size_before test_str_small_size_combined
  simp_alive_peephole
  sorry
def test_str_ok_size_combined := [llvmfunc|
  llvm.func @test_str_ok_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(7500915 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i32, !llvm.ptr]

theorem inst_combine_test_str_ok_size   : test_str_ok_size_before  ⊑  test_str_ok_size_combined := by
  unfold test_str_ok_size_before test_str_ok_size_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_test_str_ok_size   : test_str_ok_size_before  ⊑  test_str_ok_size_combined := by
  unfold test_str_ok_size_before test_str_ok_size_combined
  simp_alive_peephole
  sorry
def test_str_ok_size_tail_combined := [llvmfunc|
  llvm.func @test_str_ok_size_tail(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_test_str_ok_size_tail   : test_str_ok_size_tail_before  ⊑  test_str_ok_size_tail_combined := by
  unfold test_str_ok_size_tail_before test_str_ok_size_tail_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_test_str_ok_size_tail   : test_str_ok_size_tail_before  ⊑  test_str_ok_size_tail_combined := by
  unfold test_str_ok_size_tail_before test_str_ok_size_tail_combined
  simp_alive_peephole
  sorry
def test_str_ok_size_musttail_combined := [llvmfunc|
  llvm.func @test_str_ok_size_musttail(%arg0: !llvm.ptr, %arg1: i64, %arg2: !llvm.ptr, ...) -> i32 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %3 = llvm.mlir.addressof @".str.4" : !llvm.ptr
    %4 = llvm.call @snprintf(%arg0, %0, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_str_ok_size_musttail   : test_str_ok_size_musttail_before  ⊑  test_str_ok_size_musttail_combined := by
  unfold test_str_ok_size_musttail_before test_str_ok_size_musttail_combined
  simp_alive_peephole
  sorry
def test_str_ok_size_tail2_combined := [llvmfunc|
  llvm.func @test_str_ok_size_tail2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(7500915 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i32, !llvm.ptr]

theorem inst_combine_test_str_ok_size_tail2   : test_str_ok_size_tail2_before  ⊑  test_str_ok_size_tail2_combined := by
  unfold test_str_ok_size_tail2_before test_str_ok_size_tail2_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_test_str_ok_size_tail2   : test_str_ok_size_tail2_before  ⊑  test_str_ok_size_tail2_combined := by
  unfold test_str_ok_size_tail2_before test_str_ok_size_tail2_combined
  simp_alive_peephole
  sorry
def test_str_ok_size_musttail2_combined := [llvmfunc|
  llvm.func @test_str_ok_size_musttail2(%arg0: !llvm.ptr, %arg1: i64, %arg2: !llvm.ptr, ...) -> i32 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %3 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.call @snprintf(%arg0, %0, %2, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test_str_ok_size_musttail2   : test_str_ok_size_musttail2_before  ⊑  test_str_ok_size_musttail2_combined := by
  unfold test_str_ok_size_musttail2_before test_str_ok_size_musttail2_combined
  simp_alive_peephole
  sorry
