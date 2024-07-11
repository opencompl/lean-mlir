import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memchr-7
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def strchr_to_memchr_n_equals_len(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @strchr_to_memchr_n_equals_len(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("abcdefghijklmnopqrstuvwxyz\00") : !llvm.array<27 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    %4 = llvm.icmp "ne" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
  }]

def memchr_n_equals_len(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @memchr_n_equals_len(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("\0D\0A") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "eq" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

def memchr_n_less_than_len(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @memchr_n_less_than_len(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("abcdefghijklmnopqrstuvwxyz\00") : !llvm.array<27 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant(15 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

def memchr_n_more_than_len(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @memchr_n_more_than_len(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("abcdefghijklmnopqrstuvwxyz\00") : !llvm.array<27 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant(30 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

def memchr_no_zero_cmp_before := [llvmfunc|
  llvm.func @memchr_no_zero_cmp(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("abcdefghijklmnopqrstuvwxyz\00") : !llvm.array<27 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def memchr_no_zero_cmp2_before := [llvmfunc|
  llvm.func @memchr_no_zero_cmp2(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\0D\0A") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def memchr_n_equals_len_minsize(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @memchr_n_equals_len_minsize(%arg0: i32) -> (i1 {llvm.zeroext}) attributes {passthrough = ["minsize"]} {
    %0 = llvm.mlir.constant("abcdefghijklmnopqrstuvwxyz\00") : !llvm.array<27 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    %4 = llvm.icmp "ne" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
  }]

def memchr_n_equals_len2_minsize(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @memchr_n_equals_len2_minsize(%arg0: i32) -> (i1 {llvm.zeroext}) attributes {passthrough = ["minsize"]} {
    %0 = llvm.mlir.constant("\0D\0A") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "eq" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

def strchr_to_memchr_2_non_cont_ranges(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @strchr_to_memchr_2_non_cont_ranges(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("abcdefmno\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @".str.2" : !llvm.ptr
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

def strchr_to_memchr_2_non_cont_ranges_char_dup(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @strchr_to_memchr_2_non_cont_ranges_char_dup(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("mnabcc\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @".str.4" : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

def strchr_to_memchr_3_non_cont_ranges(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @strchr_to_memchr_3_non_cont_ranges(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("abcijkmno\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

def strchr_to_memchr_n_equals_len(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @strchr_to_memchr_n_equals_len(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-97 : i32) : i32
    %2 = llvm.mlir.constant(26 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.icmp "ult" %4, %2 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_strchr_to_memchr_n_equals_len(%arg0: i32) ->    : strchr_to_memchr_n_equals_len(%arg0: i32) -> _before  ⊑  strchr_to_memchr_n_equals_len(%arg0: i32) -> _combined := by
  unfold strchr_to_memchr_n_equals_len(%arg0: i32) -> _before strchr_to_memchr_n_equals_len(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def memchr_n_equals_len(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @memchr_n_equals_len(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(13 : i8) : i8
    %2 = llvm.trunc %arg0 : i32 to i8
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ne" %2, %1 : i8
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_memchr_n_equals_len(%arg0: i32) ->    : memchr_n_equals_len(%arg0: i32) -> _before  ⊑  memchr_n_equals_len(%arg0: i32) -> _combined := by
  unfold memchr_n_equals_len(%arg0: i32) -> _before memchr_n_equals_len(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def memchr_n_less_than_len(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @memchr_n_less_than_len(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(-97 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_memchr_n_less_than_len(%arg0: i32) ->    : memchr_n_less_than_len(%arg0: i32) -> _before  ⊑  memchr_n_less_than_len(%arg0: i32) -> _combined := by
  unfold memchr_n_less_than_len(%arg0: i32) -> _before memchr_n_less_than_len(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def memchr_n_more_than_len(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @memchr_n_more_than_len(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-97 : i32) : i32
    %2 = llvm.mlir.constant(26 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.icmp "ult" %4, %2 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_memchr_n_more_than_len(%arg0: i32) ->    : memchr_n_more_than_len(%arg0: i32) -> _before  ⊑  memchr_n_more_than_len(%arg0: i32) -> _combined := by
  unfold memchr_n_more_than_len(%arg0: i32) -> _before memchr_n_more_than_len(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def memchr_no_zero_cmp_combined := [llvmfunc|
  llvm.func @memchr_no_zero_cmp(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("abcdefghijklmnopqrstuvwxyz\00") : !llvm.array<27 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant(27 : i64) : i64
    %3 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_memchr_no_zero_cmp   : memchr_no_zero_cmp_before  ⊑  memchr_no_zero_cmp_combined := by
  unfold memchr_no_zero_cmp_before memchr_no_zero_cmp_combined
  simp_alive_peephole
  sorry
def memchr_no_zero_cmp2_combined := [llvmfunc|
  llvm.func @memchr_no_zero_cmp2(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("\0D\0A") : !llvm.array<2 x i8>
    %4 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.constant(13 : i8) : i8
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "eq" %8, %0 : i8
    %10 = llvm.select %9, %5, %6 : i1, !llvm.ptr
    %11 = llvm.icmp "eq" %8, %7 : i8
    %12 = llvm.select %11, %4, %10 : i1, !llvm.ptr
    llvm.return %12 : !llvm.ptr
  }]

theorem inst_combine_memchr_no_zero_cmp2   : memchr_no_zero_cmp2_before  ⊑  memchr_no_zero_cmp2_combined := by
  unfold memchr_no_zero_cmp2_before memchr_no_zero_cmp2_combined
  simp_alive_peephole
  sorry
def memchr_n_equals_len_minsize(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @memchr_n_equals_len_minsize(%arg0: i32) -> (i1 {llvm.zeroext}) attributes {passthrough = ["minsize"]} {
    %0 = llvm.mlir.constant("abcdefghijklmnopqrstuvwxyz\00") : !llvm.array<27 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant(27 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

theorem inst_combine_memchr_n_equals_len_minsize(%arg0: i32) ->    : memchr_n_equals_len_minsize(%arg0: i32) -> _before  ⊑  memchr_n_equals_len_minsize(%arg0: i32) -> _combined := by
  unfold memchr_n_equals_len_minsize(%arg0: i32) -> _before memchr_n_equals_len_minsize(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def memchr_n_equals_len2_minsize(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @memchr_n_equals_len2_minsize(%arg0: i32) -> (i1 {llvm.zeroext}) attributes {passthrough = ["minsize"]} {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(13 : i8) : i8
    %2 = llvm.trunc %arg0 : i32 to i8
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ne" %2, %1 : i8
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_memchr_n_equals_len2_minsize(%arg0: i32) ->    : memchr_n_equals_len2_minsize(%arg0: i32) -> _before  ⊑  memchr_n_equals_len2_minsize(%arg0: i32) -> _combined := by
  unfold memchr_n_equals_len2_minsize(%arg0: i32) -> _before memchr_n_equals_len2_minsize(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def strchr_to_memchr_2_non_cont_ranges(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @strchr_to_memchr_2_non_cont_ranges(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(-97 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(-109 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_strchr_to_memchr_2_non_cont_ranges(%arg0: i32) ->    : strchr_to_memchr_2_non_cont_ranges(%arg0: i32) -> _before  ⊑  strchr_to_memchr_2_non_cont_ranges(%arg0: i32) -> _combined := by
  unfold strchr_to_memchr_2_non_cont_ranges(%arg0: i32) -> _before strchr_to_memchr_2_non_cont_ranges(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def strchr_to_memchr_2_non_cont_ranges_char_dup(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @strchr_to_memchr_2_non_cont_ranges_char_dup(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(-97 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(-109 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_strchr_to_memchr_2_non_cont_ranges_char_dup(%arg0: i32) ->    : strchr_to_memchr_2_non_cont_ranges_char_dup(%arg0: i32) -> _before  ⊑  strchr_to_memchr_2_non_cont_ranges_char_dup(%arg0: i32) -> _combined := by
  unfold strchr_to_memchr_2_non_cont_ranges_char_dup(%arg0: i32) -> _before strchr_to_memchr_2_non_cont_ranges_char_dup(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def strchr_to_memchr_3_non_cont_ranges(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @strchr_to_memchr_3_non_cont_ranges(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant("abcijkmno\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

theorem inst_combine_strchr_to_memchr_3_non_cont_ranges(%arg0: i32) ->    : strchr_to_memchr_3_non_cont_ranges(%arg0: i32) -> _before  ⊑  strchr_to_memchr_3_non_cont_ranges(%arg0: i32) -> _combined := by
  unfold strchr_to_memchr_3_non_cont_ranges(%arg0: i32) -> _before strchr_to_memchr_3_non_cont_ranges(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
