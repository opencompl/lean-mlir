import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strcall-bad-sig
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def call_bad_ato_before := [llvmfunc|
  llvm.func @call_bad_ato(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.call @atoi(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.store %4, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %5 = llvm.call @atol(%1) : (!llvm.ptr) -> !llvm.ptr
    %6 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    llvm.store %5, %6 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %7 = llvm.call @atol(%1) : (!llvm.ptr) -> !llvm.ptr
    %8 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    llvm.store %7, %8 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def call_bad_strncasecmp_before := [llvmfunc|
  llvm.func @call_bad_strncasecmp() -> !llvm.ptr {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i8>
    %5 = llvm.call @strncasecmp(%1, %4) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def call_bad_strcoll_before := [llvmfunc|
  llvm.func @call_bad_strcoll() -> i1 {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i8>
    %5 = llvm.call @strcoll(%1, %4, %1) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i1
    llvm.return %5 : i1
  }]

def call_bad_strndup_before := [llvmfunc|
  llvm.func @call_bad_strndup() -> !llvm.ptr {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.call @strndup(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def call_bad_strtok_before := [llvmfunc|
  llvm.func @call_bad_strtok() -> i1 {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i8>
    %6 = llvm.call @strtok(%1, %5, %4) : (!llvm.ptr, !llvm.ptr, i1) -> i1
    llvm.return %6 : i1
  }]

def call_bad_strtok_r_before := [llvmfunc|
  llvm.func @call_bad_strtok_r() -> i1 {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i8>
    %5 = llvm.call @strtok_r(%1, %4) : (!llvm.ptr, !llvm.ptr) -> i1
    llvm.return %5 : i1
  }]

def call_bad_strto_before := [llvmfunc|
  llvm.func @call_bad_strto(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.call @strtol(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.store %5, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %6 = llvm.call @strtoul(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    %7 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %6, %7 {alignment = 4 : i64} : i32, !llvm.ptr]

    %8 = llvm.call @strtoll(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.store %8, %arg1 {alignment = 4 : i64} : i64, !llvm.ptr]

    %9 = llvm.call @strtoull(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i64
    %10 = llvm.getelementptr %arg1[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %9, %10 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def call_bad_strxfrm_before := [llvmfunc|
  llvm.func @call_bad_strxfrm() -> !llvm.ptr {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i8>
    %5 = llvm.call @strxfrm(%1, %4) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def call_bad_ato_combined := [llvmfunc|
  llvm.func @call_bad_ato(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.call @atoi(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.store %4, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %5 = llvm.call @atol(%1) : (!llvm.ptr) -> !llvm.ptr
    %6 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %5, %6 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %7 = llvm.call @atol(%1) : (!llvm.ptr) -> !llvm.ptr
    %8 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %7, %8 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_call_bad_ato   : call_bad_ato_before  ⊑  call_bad_ato_combined := by
  unfold call_bad_ato_before call_bad_ato_combined
  simp_alive_peephole
  sorry
def call_bad_strncasecmp_combined := [llvmfunc|
  llvm.func @call_bad_strncasecmp() -> !llvm.ptr {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %5 = llvm.call @strncasecmp(%1, %4) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_call_bad_strncasecmp   : call_bad_strncasecmp_before  ⊑  call_bad_strncasecmp_combined := by
  unfold call_bad_strncasecmp_before call_bad_strncasecmp_combined
  simp_alive_peephole
  sorry
def call_bad_strcoll_combined := [llvmfunc|
  llvm.func @call_bad_strcoll() -> i1 {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %5 = llvm.call @strcoll(%1, %4, %1) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i1
    llvm.return %5 : i1
  }]

theorem inst_combine_call_bad_strcoll   : call_bad_strcoll_before  ⊑  call_bad_strcoll_combined := by
  unfold call_bad_strcoll_before call_bad_strcoll_combined
  simp_alive_peephole
  sorry
def call_bad_strndup_combined := [llvmfunc|
  llvm.func @call_bad_strndup() -> !llvm.ptr {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.call @strndup(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_call_bad_strndup   : call_bad_strndup_before  ⊑  call_bad_strndup_combined := by
  unfold call_bad_strndup_before call_bad_strndup_combined
  simp_alive_peephole
  sorry
def call_bad_strtok_combined := [llvmfunc|
  llvm.func @call_bad_strtok() -> i1 {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %5 = llvm.mlir.constant(false) : i1
    %6 = llvm.call @strtok(%1, %4, %5) : (!llvm.ptr, !llvm.ptr, i1) -> i1
    llvm.return %6 : i1
  }]

theorem inst_combine_call_bad_strtok   : call_bad_strtok_before  ⊑  call_bad_strtok_combined := by
  unfold call_bad_strtok_before call_bad_strtok_combined
  simp_alive_peephole
  sorry
def call_bad_strtok_r_combined := [llvmfunc|
  llvm.func @call_bad_strtok_r() -> i1 {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %5 = llvm.call @strtok_r(%1, %4) : (!llvm.ptr, !llvm.ptr) -> i1
    llvm.return %5 : i1
  }]

theorem inst_combine_call_bad_strtok_r   : call_bad_strtok_r_before  ⊑  call_bad_strtok_r_combined := by
  unfold call_bad_strtok_r_before call_bad_strtok_r_combined
  simp_alive_peephole
  sorry
def call_bad_strto_combined := [llvmfunc|
  llvm.func @call_bad_strto(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.call @strtol(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.store %5, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.call @strtoul(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    %7 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %6, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    %8 = llvm.call @strtoll(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.store %8, %arg1 {alignment = 4 : i64} : i64, !llvm.ptr
    %9 = llvm.call @strtoull(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i64
    %10 = llvm.getelementptr %arg1[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %9, %10 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_call_bad_strto   : call_bad_strto_before  ⊑  call_bad_strto_combined := by
  unfold call_bad_strto_before call_bad_strto_combined
  simp_alive_peephole
  sorry
def call_bad_strxfrm_combined := [llvmfunc|
  llvm.func @call_bad_strxfrm() -> !llvm.ptr {
    %0 = llvm.mlir.constant("1\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %5 = llvm.call @strxfrm(%1, %4) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_call_bad_strxfrm   : call_bad_strxfrm_before  ⊑  call_bad_strxfrm_combined := by
  unfold call_bad_strxfrm_before call_bad_strxfrm_combined
  simp_alive_peephole
  sorry
