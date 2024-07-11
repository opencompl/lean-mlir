import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  str-int-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def strtol_dec_before := [llvmfunc|
  llvm.func @strtol_dec() -> i64 {
    %0 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %4 : i64
  }]

def strtol_base_zero_before := [llvmfunc|
  llvm.func @strtol_base_zero() -> i64 {
    %0 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %4 : i64
  }]

def strtol_hex_before := [llvmfunc|
  llvm.func @strtol_hex() -> i64 {
    %0 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %4 : i64
  }]

def strtol_endptr_not_null_before := [llvmfunc|
  llvm.func @strtol_endptr_not_null(%arg0: !llvm.ptr {llvm.nonnull}) -> i64 {
    %0 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtol(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }]

def strtol_endptr_maybe_null_before := [llvmfunc|
  llvm.func @strtol_endptr_maybe_null(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("0\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtol(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }]

def atoi_test_before := [llvmfunc|
  llvm.func @atoi_test() -> i32 {
    %0 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call @atoi(%1) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def strtol_not_const_str_before := [llvmfunc|
  llvm.func @strtol_not_const_str(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.call @strtol(%arg0, %0, %1) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %2 : i64
  }]

def atoi_not_const_str_before := [llvmfunc|
  llvm.func @atoi_not_const_str(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.call @atoi(%arg0) : (!llvm.ptr) -> i32
    llvm.return %0 : i32
  }]

def strtol_not_const_base_before := [llvmfunc|
  llvm.func @strtol_not_const_base(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @strtol(%1, %2, %arg0) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }]

def strtol_long_int_before := [llvmfunc|
  llvm.func @strtol_long_int() -> i64 {
    %0 = llvm.mlir.constant("4294967296\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @".str.2" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %4 : i64
  }]

def strtol_big_overflow_before := [llvmfunc|
  llvm.func @strtol_big_overflow() -> i64 {
    %0 = llvm.mlir.constant("10000000000000000000000\00") : !llvm.array<24 x i8>
    %1 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %4 : i64
  }]

def atol_test_before := [llvmfunc|
  llvm.func @atol_test() -> i64 {
    %0 = llvm.mlir.constant("499496729\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @".str.6" : !llvm.ptr
    %2 = llvm.call @atol(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }]

def atoll_test_before := [llvmfunc|
  llvm.func @atoll_test() -> i64 {
    %0 = llvm.mlir.constant("4994967295\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @".str.5" : !llvm.ptr
    %2 = llvm.call @atoll(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }]

def strtoll_test_before := [llvmfunc|
  llvm.func @strtoll_test() -> i64 {
    %0 = llvm.mlir.constant("4994967295\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @".str.7" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.call @strtoll(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %4 : i64
  }]

def strtol_dec_combined := [llvmfunc|
  llvm.func @strtol_dec() -> i64 {
    %0 = llvm.mlir.constant(12 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_strtol_dec   : strtol_dec_before  ⊑  strtol_dec_combined := by
  unfold strtol_dec_before strtol_dec_combined
  simp_alive_peephole
  sorry
def strtol_base_zero_combined := [llvmfunc|
  llvm.func @strtol_base_zero() -> i64 {
    %0 = llvm.mlir.constant(12 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_strtol_base_zero   : strtol_base_zero_before  ⊑  strtol_base_zero_combined := by
  unfold strtol_base_zero_before strtol_base_zero_combined
  simp_alive_peephole
  sorry
def strtol_hex_combined := [llvmfunc|
  llvm.func @strtol_hex() -> i64 {
    %0 = llvm.mlir.constant(18 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_strtol_hex   : strtol_hex_before  ⊑  strtol_hex_combined := by
  unfold strtol_hex_before strtol_hex_combined
  simp_alive_peephole
  sorry
def strtol_endptr_not_null_combined := [llvmfunc|
  llvm.func @strtol_endptr_not_null(%arg0: !llvm.ptr {llvm.nonnull}) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %3 = llvm.mlir.addressof @".str" : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %5 = llvm.mlir.constant(12 : i64) : i64
    llvm.store %4, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return %5 : i64
  }]

theorem inst_combine_strtol_endptr_not_null   : strtol_endptr_not_null_before  ⊑  strtol_endptr_not_null_combined := by
  unfold strtol_endptr_not_null_before strtol_endptr_not_null_combined
  simp_alive_peephole
  sorry
def strtol_endptr_maybe_null_combined := [llvmfunc|
  llvm.func @strtol_endptr_maybe_null(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant("0\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strtol(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }]

theorem inst_combine_strtol_endptr_maybe_null   : strtol_endptr_maybe_null_before  ⊑  strtol_endptr_maybe_null_combined := by
  unfold strtol_endptr_maybe_null_before strtol_endptr_maybe_null_combined
  simp_alive_peephole
  sorry
def atoi_test_combined := [llvmfunc|
  llvm.func @atoi_test() -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_atoi_test   : atoi_test_before  ⊑  atoi_test_combined := by
  unfold atoi_test_before atoi_test_combined
  simp_alive_peephole
  sorry
def strtol_not_const_str_combined := [llvmfunc|
  llvm.func @strtol_not_const_str(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.call @strtol(%arg0, %0, %1) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_strtol_not_const_str   : strtol_not_const_str_before  ⊑  strtol_not_const_str_combined := by
  unfold strtol_not_const_str_before strtol_not_const_str_combined
  simp_alive_peephole
  sorry
def atoi_not_const_str_combined := [llvmfunc|
  llvm.func @atoi_not_const_str(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.call @atoi(%arg0) : (!llvm.ptr) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_atoi_not_const_str   : atoi_not_const_str_before  ⊑  atoi_not_const_str_combined := by
  unfold atoi_not_const_str_before atoi_not_const_str_combined
  simp_alive_peephole
  sorry
def strtol_not_const_base_combined := [llvmfunc|
  llvm.func @strtol_not_const_base(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant("12\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @strtol(%1, %2, %arg0) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %3 : i64
  }]

theorem inst_combine_strtol_not_const_base   : strtol_not_const_base_before  ⊑  strtol_not_const_base_combined := by
  unfold strtol_not_const_base_before strtol_not_const_base_combined
  simp_alive_peephole
  sorry
def strtol_long_int_combined := [llvmfunc|
  llvm.func @strtol_long_int() -> i64 {
    %0 = llvm.mlir.constant(4294967296 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_strtol_long_int   : strtol_long_int_before  ⊑  strtol_long_int_combined := by
  unfold strtol_long_int_before strtol_long_int_combined
  simp_alive_peephole
  sorry
def strtol_big_overflow_combined := [llvmfunc|
  llvm.func @strtol_big_overflow() -> i64 {
    %0 = llvm.mlir.constant("10000000000000000000000\00") : !llvm.array<24 x i8>
    %1 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.call @strtol(%1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    llvm.return %4 : i64
  }]

theorem inst_combine_strtol_big_overflow   : strtol_big_overflow_before  ⊑  strtol_big_overflow_combined := by
  unfold strtol_big_overflow_before strtol_big_overflow_combined
  simp_alive_peephole
  sorry
def atol_test_combined := [llvmfunc|
  llvm.func @atol_test() -> i64 {
    %0 = llvm.mlir.constant(499496729 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_atol_test   : atol_test_before  ⊑  atol_test_combined := by
  unfold atol_test_before atol_test_combined
  simp_alive_peephole
  sorry
def atoll_test_combined := [llvmfunc|
  llvm.func @atoll_test() -> i64 {
    %0 = llvm.mlir.constant(4994967295 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_atoll_test   : atoll_test_before  ⊑  atoll_test_combined := by
  unfold atoll_test_before atoll_test_combined
  simp_alive_peephole
  sorry
def strtoll_test_combined := [llvmfunc|
  llvm.func @strtoll_test() -> i64 {
    %0 = llvm.mlir.constant(4994967295 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_strtoll_test   : strtoll_test_before  ⊑  strtoll_test_combined := by
  unfold strtoll_test_before strtoll_test_combined
  simp_alive_peephole
  sorry
