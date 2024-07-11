import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memccpy
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def memccpy_to_memcpy_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(12 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy2_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(8 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy3_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(111 : i32) : i32
    %3 = llvm.mlir.constant(10 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return
  }]

def memccpy_to_memcpy3_tail_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy3_tail(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(111 : i32) : i32
    %3 = llvm.mlir.constant(10 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return
  }]

def memccpy_to_memcpy3_musttail_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy3_musttail(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(111 : i32) : i32
    %3 = llvm.mlir.constant(10 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy4_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(12 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return
  }]

def memccpy_to_memcpy5_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy5(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy5_tail_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy5_tail(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy5_musttail_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy5_musttail(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy6_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy6(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy7_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy7(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(115 : i32) : i32
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy8_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy8(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(115 : i32) : i32
    %3 = llvm.mlir.constant(11 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy9_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy9(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00x") : !llvm.array<12 x i8>
    %1 = llvm.mlir.addressof @StopCharAfterNulTerminator : !llvm.ptr
    %2 = llvm.mlir.constant(120 : i32) : i32
    %3 = llvm.mlir.constant(15 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy10_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy10(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\FFab\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @StringWithEOF : !llvm.ptr
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(15 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy11_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy11(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\FFab\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @StringWithEOF : !llvm.ptr
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(15 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy12_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy12(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\FFab\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @StringWithEOF : !llvm.ptr
    %2 = llvm.mlir.constant(1023 : i32) : i32
    %3 = llvm.mlir.constant(15 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_null_before := [llvmfunc|
  llvm.func @memccpy_to_null(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @memccpy(%arg0, %arg1, %arg2, %0) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def memccpy_dst_src_same_retval_unused_before := [llvmfunc|
  llvm.func @memccpy_dst_src_same_retval_unused(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) {
    %0 = llvm.call @memccpy(%arg0, %arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return
  }]

def unknown_src_before := [llvmfunc|
  llvm.func @unknown_src(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(114 : i32) : i32
    %1 = llvm.mlir.constant(12 : i64) : i64
    %2 = llvm.call @memccpy(%arg0, %arg1, %0, %1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def unknown_stop_char_before := [llvmfunc|
  llvm.func @unknown_stop_char(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i64) : i64
    %3 = llvm.call @memccpy(%arg0, %1, %arg1, %2) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def unknown_size_n_before := [llvmfunc|
  llvm.func @unknown_size_n(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.call @memccpy(%arg0, %1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def no_nul_terminator_before := [llvmfunc|
  llvm.func @no_nul_terminator(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00x") : !llvm.array<12 x i8>
    %1 = llvm.mlir.addressof @StopCharAfterNulTerminator : !llvm.ptr
    %2 = llvm.mlir.constant(120 : i32) : i32
    %3 = llvm.call @memccpy(%arg0, %1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def possibly_valid_data_after_array_before := [llvmfunc|
  llvm.func @possibly_valid_data_after_array(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @NoNulTerminator : !llvm.ptr
    %2 = llvm.mlir.constant(115 : i32) : i32
    %3 = llvm.call @memccpy(%arg0, %1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def possibly_valid_data_after_array2_before := [llvmfunc|
  llvm.func @possibly_valid_data_after_array2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(115 : i32) : i32
    %3 = llvm.call @memccpy(%arg0, %1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def possibly_valid_data_after_array3_before := [llvmfunc|
  llvm.func @possibly_valid_data_after_array3(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(115 : i32) : i32
    %3 = llvm.mlir.constant(12 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_dst_src_same_retval_used_before := [llvmfunc|
  llvm.func @memccpy_dst_src_same_retval_used(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.call @memccpy(%arg0, %arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def memccpy_to_memcpy_musttail_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy_musttail(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(12 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy2_musttail_before := [llvmfunc|
  llvm.func @memccpy_to_memcpy2_musttail(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(8 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memccpy_to_memcpy_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(8245940763182785896 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    llvm.store %0, %arg0 {alignment = 1 : i64} : i64, !llvm.ptr
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy   : memccpy_to_memcpy_before  ⊑  memccpy_to_memcpy_combined := by
  unfold memccpy_to_memcpy_before memccpy_to_memcpy_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy2_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(8245940763182785896 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    llvm.store %0, %arg0 {alignment = 1 : i64} : i64, !llvm.ptr
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy2   : memccpy_to_memcpy2_before  ⊑  memccpy_to_memcpy2_combined := by
  unfold memccpy_to_memcpy2_before memccpy_to_memcpy2_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy3_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_memccpy_to_memcpy3   : memccpy_to_memcpy3_before  ⊑  memccpy_to_memcpy3_combined := by
  unfold memccpy_to_memcpy3_before memccpy_to_memcpy3_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy3_tail_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy3_tail(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_memccpy_to_memcpy3_tail   : memccpy_to_memcpy3_tail_before  ⊑  memccpy_to_memcpy3_tail_combined := by
  unfold memccpy_to_memcpy3_tail_before memccpy_to_memcpy3_tail_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy3_musttail_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy3_musttail(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(111 : i32) : i32
    %3 = llvm.mlir.constant(10 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy3_musttail   : memccpy_to_memcpy3_musttail_before  ⊑  memccpy_to_memcpy3_musttail_combined := by
  unfold memccpy_to_memcpy3_musttail_before memccpy_to_memcpy3_musttail_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy4_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(11 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_memccpy_to_memcpy4   : memccpy_to_memcpy4_before  ⊑  memccpy_to_memcpy4_combined := by
  unfold memccpy_to_memcpy4_before memccpy_to_memcpy4_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy5_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy5(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy5   : memccpy_to_memcpy5_before  ⊑  memccpy_to_memcpy5_combined := by
  unfold memccpy_to_memcpy5_before memccpy_to_memcpy5_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy5_tail_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy5_tail(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy5_tail   : memccpy_to_memcpy5_tail_before  ⊑  memccpy_to_memcpy5_tail_combined := by
  unfold memccpy_to_memcpy5_tail_before memccpy_to_memcpy5_tail_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy5_musttail_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy5_musttail(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy5_musttail   : memccpy_to_memcpy5_musttail_before  ⊑  memccpy_to_memcpy5_musttail_combined := by
  unfold memccpy_to_memcpy5_musttail_before memccpy_to_memcpy5_musttail_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy6_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy6(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy6   : memccpy_to_memcpy6_before  ⊑  memccpy_to_memcpy6_combined := by
  unfold memccpy_to_memcpy6_before memccpy_to_memcpy6_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy7_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy7(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy7   : memccpy_to_memcpy7_before  ⊑  memccpy_to_memcpy7_combined := by
  unfold memccpy_to_memcpy7_before memccpy_to_memcpy7_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy8_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy8(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(11 : i64) : i64
    %3 = llvm.mlir.zero : !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy8   : memccpy_to_memcpy8_before  ⊑  memccpy_to_memcpy8_combined := by
  unfold memccpy_to_memcpy8_before memccpy_to_memcpy8_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy9_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy9(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00x") : !llvm.array<12 x i8>
    %1 = llvm.mlir.addressof @StopCharAfterNulTerminator : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy9   : memccpy_to_memcpy9_before  ⊑  memccpy_to_memcpy9_combined := by
  unfold memccpy_to_memcpy9_before memccpy_to_memcpy9_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy10_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy10(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\FFab\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @StringWithEOF : !llvm.ptr
    %2 = llvm.mlir.constant(11 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy10   : memccpy_to_memcpy10_before  ⊑  memccpy_to_memcpy10_combined := by
  unfold memccpy_to_memcpy10_before memccpy_to_memcpy10_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy11_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy11(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\FFab\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @StringWithEOF : !llvm.ptr
    %2 = llvm.mlir.constant(11 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy11   : memccpy_to_memcpy11_before  ⊑  memccpy_to_memcpy11_combined := by
  unfold memccpy_to_memcpy11_before memccpy_to_memcpy11_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy12_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy12(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\FFab\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @StringWithEOF : !llvm.ptr
    %2 = llvm.mlir.constant(11 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy12   : memccpy_to_memcpy12_before  ⊑  memccpy_to_memcpy12_combined := by
  unfold memccpy_to_memcpy12_before memccpy_to_memcpy12_combined
  simp_alive_peephole
  sorry
def memccpy_to_null_combined := [llvmfunc|
  llvm.func @memccpy_to_null(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_null   : memccpy_to_null_before  ⊑  memccpy_to_null_combined := by
  unfold memccpy_to_null_before memccpy_to_null_combined
  simp_alive_peephole
  sorry
def memccpy_dst_src_same_retval_unused_combined := [llvmfunc|
  llvm.func @memccpy_dst_src_same_retval_unused(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) {
    llvm.return
  }]

theorem inst_combine_memccpy_dst_src_same_retval_unused   : memccpy_dst_src_same_retval_unused_before  ⊑  memccpy_dst_src_same_retval_unused_combined := by
  unfold memccpy_dst_src_same_retval_unused_before memccpy_dst_src_same_retval_unused_combined
  simp_alive_peephole
  sorry
def unknown_src_combined := [llvmfunc|
  llvm.func @unknown_src(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(114 : i32) : i32
    %1 = llvm.mlir.constant(12 : i64) : i64
    %2 = llvm.call @memccpy(%arg0, %arg1, %0, %1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_unknown_src   : unknown_src_before  ⊑  unknown_src_combined := by
  unfold unknown_src_before unknown_src_combined
  simp_alive_peephole
  sorry
def unknown_stop_char_combined := [llvmfunc|
  llvm.func @unknown_stop_char(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i64) : i64
    %3 = llvm.call @memccpy(%arg0, %1, %arg1, %2) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_unknown_stop_char   : unknown_stop_char_before  ⊑  unknown_stop_char_combined := by
  unfold unknown_stop_char_before unknown_stop_char_combined
  simp_alive_peephole
  sorry
def unknown_size_n_combined := [llvmfunc|
  llvm.func @unknown_size_n(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.call @memccpy(%arg0, %1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_unknown_size_n   : unknown_size_n_before  ⊑  unknown_size_n_combined := by
  unfold unknown_size_n_before unknown_size_n_combined
  simp_alive_peephole
  sorry
def no_nul_terminator_combined := [llvmfunc|
  llvm.func @no_nul_terminator(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00x") : !llvm.array<12 x i8>
    %1 = llvm.mlir.addressof @StopCharAfterNulTerminator : !llvm.ptr
    %2 = llvm.mlir.constant(120 : i32) : i32
    %3 = llvm.call @memccpy(%arg0, %1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_no_nul_terminator   : no_nul_terminator_before  ⊑  no_nul_terminator_combined := by
  unfold no_nul_terminator_before no_nul_terminator_combined
  simp_alive_peephole
  sorry
def possibly_valid_data_after_array_combined := [llvmfunc|
  llvm.func @possibly_valid_data_after_array(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @NoNulTerminator : !llvm.ptr
    %2 = llvm.mlir.constant(115 : i32) : i32
    %3 = llvm.call @memccpy(%arg0, %1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_possibly_valid_data_after_array   : possibly_valid_data_after_array_before  ⊑  possibly_valid_data_after_array_combined := by
  unfold possibly_valid_data_after_array_before possibly_valid_data_after_array_combined
  simp_alive_peephole
  sorry
def possibly_valid_data_after_array2_combined := [llvmfunc|
  llvm.func @possibly_valid_data_after_array2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(115 : i32) : i32
    %3 = llvm.call @memccpy(%arg0, %1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_possibly_valid_data_after_array2   : possibly_valid_data_after_array2_before  ⊑  possibly_valid_data_after_array2_combined := by
  unfold possibly_valid_data_after_array2_before possibly_valid_data_after_array2_combined
  simp_alive_peephole
  sorry
def possibly_valid_data_after_array3_combined := [llvmfunc|
  llvm.func @possibly_valid_data_after_array3(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(115 : i32) : i32
    %3 = llvm.mlir.constant(12 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_possibly_valid_data_after_array3   : possibly_valid_data_after_array3_before  ⊑  possibly_valid_data_after_array3_combined := by
  unfold possibly_valid_data_after_array3_before possibly_valid_data_after_array3_combined
  simp_alive_peephole
  sorry
def memccpy_dst_src_same_retval_used_combined := [llvmfunc|
  llvm.func @memccpy_dst_src_same_retval_used(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.call @memccpy(%arg0, %arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_memccpy_dst_src_same_retval_used   : memccpy_dst_src_same_retval_used_before  ⊑  memccpy_dst_src_same_retval_used_combined := by
  unfold memccpy_dst_src_same_retval_used_before memccpy_dst_src_same_retval_used_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy_musttail_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy_musttail(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(12 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy_musttail   : memccpy_to_memcpy_musttail_before  ⊑  memccpy_to_memcpy_musttail_combined := by
  unfold memccpy_to_memcpy_musttail_before memccpy_to_memcpy_musttail_combined
  simp_alive_peephole
  sorry
def memccpy_to_memcpy2_musttail_combined := [llvmfunc|
  llvm.func @memccpy_to_memcpy2_musttail(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("helloworld\00") : !llvm.array<11 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(114 : i32) : i32
    %3 = llvm.mlir.constant(8 : i64) : i64
    %4 = llvm.call @memccpy(%arg0, %1, %2, %3) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_memccpy_to_memcpy2_musttail   : memccpy_to_memcpy2_musttail_before  ⊑  memccpy_to_memcpy2_musttail_combined := by
  unfold memccpy_to_memcpy2_musttail_before memccpy_to_memcpy2_musttail_combined
  simp_alive_peephole
  sorry
