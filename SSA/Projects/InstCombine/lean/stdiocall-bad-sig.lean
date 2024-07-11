import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  stdiocall-bad-sig
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def call_fwrite_before := [llvmfunc|
  llvm.func @call_fwrite(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1") : !llvm.array<1 x i8>
    %1 = llvm.mlir.addressof @ca1 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.call @fwrite(%1, %2, %2, %arg0) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i32
    llvm.return
  }]

def call_printf_before := [llvmfunc|
  llvm.func @call_printf(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @printf : !llvm.ptr
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %3 = llvm.call %0(%2) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return
  }]

def call_fprintf_before := [llvmfunc|
  llvm.func @call_fprintf(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.addressof @fprintf : !llvm.ptr
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %3 = llvm.call %0(%arg0, %2, %arg1) vararg(!llvm.func<i8 (ptr, ptr, ...)>) : !llvm.ptr, (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i8
    llvm.return %3 : i8
  }]

def call_sprintf_before := [llvmfunc|
  llvm.func @call_sprintf(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.addressof @sprintf : !llvm.ptr
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %3 = llvm.call %0(%arg0, %2, %arg1) vararg(!llvm.func<i8 (ptr, ptr, ...)>) : !llvm.ptr, (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i8
    llvm.return %3 : i8
  }]

def call_fwrite_combined := [llvmfunc|
  llvm.func @call_fwrite(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1") : !llvm.array<1 x i8>
    %1 = llvm.mlir.addressof @ca1 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.call @fwrite(%1, %2, %2, %arg0) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_call_fwrite   : call_fwrite_before  ⊑  call_fwrite_combined := by
  unfold call_fwrite_before call_fwrite_combined
  simp_alive_peephole
  sorry
def call_printf_combined := [llvmfunc|
  llvm.func @call_printf(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @printf : !llvm.ptr
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %3 = llvm.call %0(%2) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_call_printf   : call_printf_before  ⊑  call_printf_combined := by
  unfold call_printf_before call_printf_combined
  simp_alive_peephole
  sorry
def call_fprintf_combined := [llvmfunc|
  llvm.func @call_fprintf(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.addressof @fprintf : !llvm.ptr
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %3 = llvm.call %0(%arg0, %2, %arg1) vararg(!llvm.func<i8 (ptr, ptr, ...)>) : !llvm.ptr, (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_call_fprintf   : call_fprintf_before  ⊑  call_fprintf_combined := by
  unfold call_fprintf_before call_fprintf_combined
  simp_alive_peephole
  sorry
def call_sprintf_combined := [llvmfunc|
  llvm.func @call_sprintf(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.addressof @sprintf : !llvm.ptr
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %3 = llvm.call %0(%arg0, %2, %arg1) vararg(!llvm.func<i8 (ptr, ptr, ...)>) : !llvm.ptr, (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_call_sprintf   : call_sprintf_before  ⊑  call_sprintf_combined := by
  unfold call_sprintf_before call_sprintf_combined
  simp_alive_peephole
  sorry
