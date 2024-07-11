import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcmp-constant-fold
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def memcmp_4bytes_unaligned_constant_i8_before := [llvmfunc|
  llvm.func @memcmp_4bytes_unaligned_constant_i8(%arg0: !llvm.ptr {llvm.align = 4 : i64}) -> i1 {
    %0 = llvm.mlir.constant("\00\00\00\01") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @charbuf : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    llvm.return %5 : i1
  }]

def memcmp_4bytes_unaligned_constant_i16_before := [llvmfunc|
  llvm.func @memcmp_4bytes_unaligned_constant_i16(%arg0: !llvm.ptr {llvm.align = 4 : i64}) -> i1 {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : tensor<4xi16>) : !llvm.array<4 x i16>
    %1 = llvm.mlir.addressof @intbuf_unaligned : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    llvm.return %5 : i1
  }]

def memcmp_3bytes_aligned_constant_i32_before := [llvmfunc|
  llvm.func @memcmp_3bytes_aligned_constant_i32(%arg0: !llvm.ptr {llvm.align = 4 : i64}) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[0, 1]> : tensor<2xi32>) : !llvm.array<2 x i32>
    %3 = llvm.mlir.addressof @intbuf : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i32>
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.call @memcmp(%4, %3, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %8 = llvm.icmp "eq" %7, %6 : i32
    llvm.return %8 : i1
  }]

def memcmp_4bytes_one_unaligned_i8_before := [llvmfunc|
  llvm.func @memcmp_4bytes_one_unaligned_i8(%arg0: !llvm.ptr {llvm.align = 4 : i64}, %arg1: !llvm.ptr {llvm.align = 1 : i64}) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %3 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def memcmp_4bytes_unaligned_constant_i8_combined := [llvmfunc|
  llvm.func @memcmp_4bytes_unaligned_constant_i8(%arg0: !llvm.ptr {llvm.align = 4 : i64}) -> i1 {
    %0 = llvm.mlir.constant(16777216 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_memcmp_4bytes_unaligned_constant_i8   : memcmp_4bytes_unaligned_constant_i8_before  ⊑  memcmp_4bytes_unaligned_constant_i8_combined := by
  unfold memcmp_4bytes_unaligned_constant_i8_before memcmp_4bytes_unaligned_constant_i8_combined
  simp_alive_peephole
  sorry
def memcmp_4bytes_unaligned_constant_i16_combined := [llvmfunc|
  llvm.func @memcmp_4bytes_unaligned_constant_i16(%arg0: !llvm.ptr {llvm.align = 4 : i64}) -> i1 {
    %0 = llvm.mlir.constant(131073 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_memcmp_4bytes_unaligned_constant_i16   : memcmp_4bytes_unaligned_constant_i16_before  ⊑  memcmp_4bytes_unaligned_constant_i16_combined := by
  unfold memcmp_4bytes_unaligned_constant_i16_before memcmp_4bytes_unaligned_constant_i16_combined
  simp_alive_peephole
  sorry
def memcmp_3bytes_aligned_constant_i32_combined := [llvmfunc|
  llvm.func @memcmp_3bytes_aligned_constant_i32(%arg0: !llvm.ptr {llvm.align = 4 : i64}) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_memcmp_3bytes_aligned_constant_i32   : memcmp_3bytes_aligned_constant_i32_before  ⊑  memcmp_3bytes_aligned_constant_i32_combined := by
  unfold memcmp_3bytes_aligned_constant_i32_before memcmp_3bytes_aligned_constant_i32_combined
  simp_alive_peephole
  sorry
def memcmp_4bytes_one_unaligned_i8_combined := [llvmfunc|
  llvm.func @memcmp_4bytes_one_unaligned_i8(%arg0: !llvm.ptr {llvm.align = 4 : i64}, %arg1: !llvm.ptr {llvm.align = 1 : i64}) -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_memcmp_4bytes_one_unaligned_i8   : memcmp_4bytes_one_unaligned_i8_before  ⊑  memcmp_4bytes_one_unaligned_i8_combined := by
  unfold memcmp_4bytes_one_unaligned_i8_before memcmp_4bytes_one_unaligned_i8_combined
  simp_alive_peephole
  sorry
