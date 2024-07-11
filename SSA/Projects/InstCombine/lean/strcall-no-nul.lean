import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strcall-no-nul
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strchr_past_end_before := [llvmfunc|
  llvm.func @fold_strchr_past_end() -> !llvm.ptr {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @strchr(%4, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def fold_strcmp_past_end_before := [llvmfunc|
  llvm.func @fold_strcmp_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strcmp(%1, %5) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %7 = llvm.call @strcmp(%5, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %7, %8 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_strncmp_past_end_before := [llvmfunc|
  llvm.func @fold_strncmp_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.call @strncmp(%1, %6, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %7, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %8 = llvm.call @strncmp(%6, %1, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %9 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %8, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_strrchr_past_end_before := [llvmfunc|
  llvm.func @fold_strrchr_past_end(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @strrchr(%4, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def fold_strstr_past_end_before := [llvmfunc|
  llvm.func @fold_strstr_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strstr(%1, %5) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.store %6, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %7 = llvm.call @strstr(%5, %1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    llvm.store %7, %8 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def fold_strlen_past_end_before := [llvmfunc|
  llvm.func @fold_strlen_past_end() -> i64 {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @strlen(%4) : (!llvm.ptr) -> i64
    llvm.return %5 : i64
  }]

def fold_stpcpy_past_end_before := [llvmfunc|
  llvm.func @fold_stpcpy_past_end(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @strcpy(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def fold_strcpy_past_end_before := [llvmfunc|
  llvm.func @fold_strcpy_past_end(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @strcpy(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def fold_stpncpy_past_end_before := [llvmfunc|
  llvm.func @fold_stpncpy_past_end(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strncpy(%arg0, %5, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

def fold_strncpy_past_end_before := [llvmfunc|
  llvm.func @fold_strncpy_past_end(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strncpy(%arg0, %5, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

def fold_strpbrk_past_end_before := [llvmfunc|
  llvm.func @fold_strpbrk_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strpbrk(%1, %5) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.store %6, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %7 = llvm.call @strpbrk(%5, %1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    llvm.store %7, %8 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def fold_strspn_past_end_before := [llvmfunc|
  llvm.func @fold_strspn_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strspn(%1, %5) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.store %6, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %7 = llvm.call @strspn(%5, %1) : (!llvm.ptr, !llvm.ptr) -> i64
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %7, %8 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def fold_strcspn_past_end_before := [llvmfunc|
  llvm.func @fold_strcspn_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @strcspn(%1, %5) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.store %6, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %7 = llvm.call @strcspn(%5, %1) : (!llvm.ptr, !llvm.ptr) -> i64
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %7, %8 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def fold_atoi_past_end_before := [llvmfunc|
  llvm.func @fold_atoi_past_end() -> i32 {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @atoi(%4) : (!llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

def fold_atol_strtol_past_end_before := [llvmfunc|
  llvm.func @fold_atol_strtol_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.constant(8 : i32) : i32
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.mlir.constant(10 : i32) : i32
    %10 = llvm.mlir.constant(4 : i32) : i32
    %11 = llvm.mlir.constant(16 : i32) : i32
    %12 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %13 = llvm.call @atol(%12) : (!llvm.ptr) -> i64
    llvm.store %13, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %14 = llvm.call @atoll(%12) : (!llvm.ptr) -> i64
    %15 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %14, %15 {alignment = 4 : i64} : i64, !llvm.ptr]

    %16 = llvm.call @strtol(%12, %5, %2) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %17 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %16, %17 {alignment = 4 : i64} : i64, !llvm.ptr]

    %18 = llvm.call @strtoul(%12, %5, %7) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %19 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %18, %19 {alignment = 4 : i64} : i64, !llvm.ptr]

    %20 = llvm.call @strtoll(%12, %5, %9) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %21 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %20, %21 {alignment = 4 : i64} : i64, !llvm.ptr]

    %22 = llvm.call @strtoul(%12, %5, %11) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %23 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %22, %23 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def fold_sprintf_past_end_before := [llvmfunc|
  llvm.func @fold_sprintf_past_end(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @sprintf(%arg1, %5) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %7 = llvm.call @sprintf(%arg1, %1, %5) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %7, %8 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_snprintf_past_end_before := [llvmfunc|
  llvm.func @fold_snprintf_past_end(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @snprintf(%arg1, %arg2, %5) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %7 = llvm.call @snprintf(%arg1, %arg2, %1, %5) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %8 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %7, %8 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_strchr_past_end_combined := [llvmfunc|
  llvm.func @fold_strchr_past_end() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a5 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_strchr_past_end   : fold_strchr_past_end_before  ⊑  fold_strchr_past_end_combined := by
  unfold fold_strchr_past_end_before fold_strchr_past_end_combined
  simp_alive_peephole
  sorry
def fold_strcmp_past_end_combined := [llvmfunc|
  llvm.func @fold_strcmp_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strcmp_past_end   : fold_strcmp_past_end_before  ⊑  fold_strcmp_past_end_combined := by
  unfold fold_strcmp_past_end_before fold_strcmp_past_end_combined
  simp_alive_peephole
  sorry
    %3 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strcmp_past_end   : fold_strcmp_past_end_before  ⊑  fold_strcmp_past_end_combined := by
  unfold fold_strcmp_past_end_before fold_strcmp_past_end_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strcmp_past_end   : fold_strcmp_past_end_before  ⊑  fold_strcmp_past_end_combined := by
  unfold fold_strcmp_past_end_before fold_strcmp_past_end_combined
  simp_alive_peephole
  sorry
def fold_strncmp_past_end_combined := [llvmfunc|
  llvm.func @fold_strncmp_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_past_end   : fold_strncmp_past_end_before  ⊑  fold_strncmp_past_end_combined := by
  unfold fold_strncmp_past_end_before fold_strncmp_past_end_combined
  simp_alive_peephole
  sorry
    %3 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_past_end   : fold_strncmp_past_end_before  ⊑  fold_strncmp_past_end_combined := by
  unfold fold_strncmp_past_end_before fold_strncmp_past_end_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strncmp_past_end   : fold_strncmp_past_end_before  ⊑  fold_strncmp_past_end_combined := by
  unfold fold_strncmp_past_end_before fold_strncmp_past_end_combined
  simp_alive_peephole
  sorry
def fold_strrchr_past_end_combined := [llvmfunc|
  llvm.func @fold_strrchr_past_end(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.poison : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_strrchr_past_end   : fold_strrchr_past_end_before  ⊑  fold_strrchr_past_end_combined := by
  unfold fold_strrchr_past_end_before fold_strrchr_past_end_combined
  simp_alive_peephole
  sorry
def fold_strstr_past_end_combined := [llvmfunc|
  llvm.func @fold_strstr_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    llvm.store %1, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strstr_past_end   : fold_strstr_past_end_before  ⊑  fold_strstr_past_end_combined := by
  unfold fold_strstr_past_end_before fold_strstr_past_end_combined
  simp_alive_peephole
  sorry
    %4 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %3, %4 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strstr_past_end   : fold_strstr_past_end_before  ⊑  fold_strstr_past_end_combined := by
  unfold fold_strstr_past_end_before fold_strstr_past_end_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strstr_past_end   : fold_strstr_past_end_before  ⊑  fold_strstr_past_end_combined := by
  unfold fold_strstr_past_end_before fold_strstr_past_end_combined
  simp_alive_peephole
  sorry
def fold_strlen_past_end_combined := [llvmfunc|
  llvm.func @fold_strlen_past_end() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strlen_past_end   : fold_strlen_past_end_before  ⊑  fold_strlen_past_end_combined := by
  unfold fold_strlen_past_end_before fold_strlen_past_end_combined
  simp_alive_peephole
  sorry
def fold_stpcpy_past_end_combined := [llvmfunc|
  llvm.func @fold_stpcpy_past_end(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_fold_stpcpy_past_end   : fold_stpcpy_past_end_before  ⊑  fold_stpcpy_past_end_combined := by
  unfold fold_stpcpy_past_end_before fold_stpcpy_past_end_combined
  simp_alive_peephole
  sorry
def fold_strcpy_past_end_combined := [llvmfunc|
  llvm.func @fold_strcpy_past_end(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_fold_strcpy_past_end   : fold_strcpy_past_end_before  ⊑  fold_strcpy_past_end_combined := by
  unfold fold_strcpy_past_end_before fold_strcpy_past_end_combined
  simp_alive_peephole
  sorry
def fold_stpncpy_past_end_combined := [llvmfunc|
  llvm.func @fold_stpncpy_past_end(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(5 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_fold_stpncpy_past_end   : fold_stpncpy_past_end_before  ⊑  fold_stpncpy_past_end_combined := by
  unfold fold_stpncpy_past_end_before fold_stpncpy_past_end_combined
  simp_alive_peephole
  sorry
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_fold_stpncpy_past_end   : fold_stpncpy_past_end_before  ⊑  fold_stpncpy_past_end_combined := by
  unfold fold_stpncpy_past_end_before fold_stpncpy_past_end_combined
  simp_alive_peephole
  sorry
def fold_strncpy_past_end_combined := [llvmfunc|
  llvm.func @fold_strncpy_past_end(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(5 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

theorem inst_combine_fold_strncpy_past_end   : fold_strncpy_past_end_before  ⊑  fold_strncpy_past_end_combined := by
  unfold fold_strncpy_past_end_before fold_strncpy_past_end_combined
  simp_alive_peephole
  sorry
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_fold_strncpy_past_end   : fold_strncpy_past_end_before  ⊑  fold_strncpy_past_end_combined := by
  unfold fold_strncpy_past_end_before fold_strncpy_past_end_combined
  simp_alive_peephole
  sorry
def fold_strpbrk_past_end_combined := [llvmfunc|
  llvm.func @fold_strpbrk_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    llvm.store %0, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strpbrk_past_end   : fold_strpbrk_past_end_before  ⊑  fold_strpbrk_past_end_combined := by
  unfold fold_strpbrk_past_end_before fold_strpbrk_past_end_combined
  simp_alive_peephole
  sorry
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %0, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fold_strpbrk_past_end   : fold_strpbrk_past_end_before  ⊑  fold_strpbrk_past_end_combined := by
  unfold fold_strpbrk_past_end_before fold_strpbrk_past_end_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strpbrk_past_end   : fold_strpbrk_past_end_before  ⊑  fold_strpbrk_past_end_combined := by
  unfold fold_strpbrk_past_end_before fold_strpbrk_past_end_combined
  simp_alive_peephole
  sorry
def fold_strspn_past_end_combined := [llvmfunc|
  llvm.func @fold_strspn_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strspn_past_end   : fold_strspn_past_end_before  ⊑  fold_strspn_past_end_combined := by
  unfold fold_strspn_past_end_before fold_strspn_past_end_combined
  simp_alive_peephole
  sorry
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %0, %2 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strspn_past_end   : fold_strspn_past_end_before  ⊑  fold_strspn_past_end_combined := by
  unfold fold_strspn_past_end_before fold_strspn_past_end_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strspn_past_end   : fold_strspn_past_end_before  ⊑  fold_strspn_past_end_combined := by
  unfold fold_strspn_past_end_before fold_strspn_past_end_combined
  simp_alive_peephole
  sorry
def fold_strcspn_past_end_combined := [llvmfunc|
  llvm.func @fold_strcspn_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strcspn_past_end   : fold_strcspn_past_end_before  ⊑  fold_strcspn_past_end_combined := by
  unfold fold_strcspn_past_end_before fold_strcspn_past_end_combined
  simp_alive_peephole
  sorry
    %3 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %2, %3 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strcspn_past_end   : fold_strcspn_past_end_before  ⊑  fold_strcspn_past_end_combined := by
  unfold fold_strcspn_past_end_before fold_strcspn_past_end_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strcspn_past_end   : fold_strcspn_past_end_before  ⊑  fold_strcspn_past_end_combined := by
  unfold fold_strcspn_past_end_before fold_strcspn_past_end_combined
  simp_alive_peephole
  sorry
def fold_atoi_past_end_combined := [llvmfunc|
  llvm.func @fold_atoi_past_end() -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a5 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @atoi(%4) : (!llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_fold_atoi_past_end   : fold_atoi_past_end_before  ⊑  fold_atoi_past_end_combined := by
  unfold fold_atoi_past_end_before fold_atoi_past_end_combined
  simp_alive_peephole
  sorry
def fold_atol_strtol_past_end_combined := [llvmfunc|
  llvm.func @fold_atol_strtol_past_end(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a5 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.constant(2 : i64) : i64
    %8 = llvm.mlir.constant(8 : i32) : i32
    %9 = llvm.mlir.constant(3 : i64) : i64
    %10 = llvm.mlir.constant(10 : i32) : i32
    %11 = llvm.mlir.constant(4 : i64) : i64
    %12 = llvm.mlir.constant(16 : i32) : i32
    %13 = llvm.mlir.constant(5 : i64) : i64
    %14 = llvm.call @atol(%4) : (!llvm.ptr) -> i64
    llvm.store %14, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_atol_strtol_past_end   : fold_atol_strtol_past_end_before  ⊑  fold_atol_strtol_past_end_combined := by
  unfold fold_atol_strtol_past_end_before fold_atol_strtol_past_end_combined
  simp_alive_peephole
  sorry
    %15 = llvm.call @atoll(%4) : (!llvm.ptr) -> i64
    %16 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %15, %16 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_atol_strtol_past_end   : fold_atol_strtol_past_end_before  ⊑  fold_atol_strtol_past_end_combined := by
  unfold fold_atol_strtol_past_end_before fold_atol_strtol_past_end_combined
  simp_alive_peephole
  sorry
    %17 = llvm.call @strtol(%4, %5, %6) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %18 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %17, %18 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_atol_strtol_past_end   : fold_atol_strtol_past_end_before  ⊑  fold_atol_strtol_past_end_combined := by
  unfold fold_atol_strtol_past_end_before fold_atol_strtol_past_end_combined
  simp_alive_peephole
  sorry
    %19 = llvm.call @strtoul(%4, %5, %8) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %20 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %19, %20 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_atol_strtol_past_end   : fold_atol_strtol_past_end_before  ⊑  fold_atol_strtol_past_end_combined := by
  unfold fold_atol_strtol_past_end_before fold_atol_strtol_past_end_combined
  simp_alive_peephole
  sorry
    %21 = llvm.call @strtoll(%4, %5, %10) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %22 = llvm.getelementptr %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %21, %22 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_atol_strtol_past_end   : fold_atol_strtol_past_end_before  ⊑  fold_atol_strtol_past_end_combined := by
  unfold fold_atol_strtol_past_end_before fold_atol_strtol_past_end_combined
  simp_alive_peephole
  sorry
    %23 = llvm.call @strtoul(%4, %5, %12) : (!llvm.ptr, !llvm.ptr, i32) -> i64
    %24 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %23, %24 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_atol_strtol_past_end   : fold_atol_strtol_past_end_before  ⊑  fold_atol_strtol_past_end_combined := by
  unfold fold_atol_strtol_past_end_before fold_atol_strtol_past_end_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_atol_strtol_past_end   : fold_atol_strtol_past_end_before  ⊑  fold_atol_strtol_past_end_combined := by
  unfold fold_atol_strtol_past_end_before fold_atol_strtol_past_end_combined
  simp_alive_peephole
  sorry
def fold_sprintf_past_end_combined := [llvmfunc|
  llvm.func @fold_sprintf_past_end(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_sprintf_past_end   : fold_sprintf_past_end_before  ⊑  fold_sprintf_past_end_combined := by
  unfold fold_sprintf_past_end_before fold_sprintf_past_end_combined
  simp_alive_peephole
  sorry
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_sprintf_past_end   : fold_sprintf_past_end_before  ⊑  fold_sprintf_past_end_combined := by
  unfold fold_sprintf_past_end_before fold_sprintf_past_end_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_sprintf_past_end   : fold_sprintf_past_end_before  ⊑  fold_sprintf_past_end_combined := by
  unfold fold_sprintf_past_end_before fold_sprintf_past_end_combined
  simp_alive_peephole
  sorry
def fold_snprintf_past_end_combined := [llvmfunc|
  llvm.func @fold_snprintf_past_end(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant("%s\0045") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a5 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @snprintf(%arg1, %arg2, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.store %5, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_past_end   : fold_snprintf_past_end_before  ⊑  fold_snprintf_past_end_combined := by
  unfold fold_snprintf_past_end_before fold_snprintf_past_end_combined
  simp_alive_peephole
  sorry
    %6 = llvm.call @snprintf(%arg1, %arg2, %3, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    %7 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %6, %7 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_past_end   : fold_snprintf_past_end_before  ⊑  fold_snprintf_past_end_combined := by
  unfold fold_snprintf_past_end_before fold_snprintf_past_end_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_snprintf_past_end   : fold_snprintf_past_end_before  ⊑  fold_snprintf_past_end_combined := by
  unfold fold_snprintf_past_end_before fold_snprintf_past_end_combined
  simp_alive_peephole
  sorry
