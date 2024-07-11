import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and-or-icmps
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR1817_1_before := [llvmfunc|
  llvm.func @PR1817_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def PR1817_1_logical_before := [llvmfunc|
  llvm.func @PR1817_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def PR1817_2_before := [llvmfunc|
  llvm.func @PR1817_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def PR1817_2_logical_before := [llvmfunc|
  llvm.func @PR1817_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def PR2330_before := [llvmfunc|
  llvm.func @PR2330(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.icmp "ult" %arg1, %0 : i32
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def PR2330_logical_before := [llvmfunc|
  llvm.func @PR2330_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.icmp "ult" %arg1, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def or_eq_with_one_bit_diff_constants1_before := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(50 : i32) : i32
    %1 = llvm.mlir.constant(51 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def or_eq_with_one_bit_diff_constants1_logical_before := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(50 : i32) : i32
    %1 = llvm.mlir.constant(51 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def and_ne_with_one_bit_diff_constants1_before := [llvmfunc|
  llvm.func @and_ne_with_one_bit_diff_constants1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(51 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def and_ne_with_one_bit_diff_constants1_logical_before := [llvmfunc|
  llvm.func @and_ne_with_one_bit_diff_constants1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(51 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def or_eq_with_one_bit_diff_constants2_before := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(97 : i32) : i32
    %1 = llvm.mlir.constant(65 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def or_eq_with_one_bit_diff_constants2_logical_before := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(97 : i32) : i32
    %1 = llvm.mlir.constant(65 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def and_ne_with_one_bit_diff_constants2_before := [llvmfunc|
  llvm.func @and_ne_with_one_bit_diff_constants2(%arg0: i19) -> i1 {
    %0 = llvm.mlir.constant(65 : i19) : i19
    %1 = llvm.mlir.constant(193 : i19) : i19
    %2 = llvm.icmp "ne" %arg0, %0 : i19
    %3 = llvm.icmp "ne" %arg0, %1 : i19
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def and_ne_with_one_bit_diff_constants2_logical_before := [llvmfunc|
  llvm.func @and_ne_with_one_bit_diff_constants2_logical(%arg0: i19) -> i1 {
    %0 = llvm.mlir.constant(65 : i19) : i19
    %1 = llvm.mlir.constant(193 : i19) : i19
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i19
    %4 = llvm.icmp "ne" %arg0, %1 : i19
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def or_eq_with_one_bit_diff_constants3_before := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def or_eq_with_one_bit_diff_constants3_logical_before := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants3_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.icmp "eq" %arg0, %1 : i8
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def and_ne_with_one_bit_diff_constants3_before := [llvmfunc|
  llvm.func @and_ne_with_one_bit_diff_constants3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(65 : i8) : i8
    %1 = llvm.mlir.constant(-63 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def and_ne_with_one_bit_diff_constants3_logical_before := [llvmfunc|
  llvm.func @and_ne_with_one_bit_diff_constants3_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(65 : i8) : i8
    %1 = llvm.mlir.constant(-63 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.icmp "ne" %arg0, %1 : i8
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def or_eq_with_diff_one_before := [llvmfunc|
  llvm.func @or_eq_with_diff_one(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mlir.constant(14 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def or_eq_with_diff_one_logical_before := [llvmfunc|
  llvm.func @or_eq_with_diff_one_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mlir.constant(14 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.icmp "eq" %arg0, %1 : i8
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def and_ne_with_diff_one_before := [llvmfunc|
  llvm.func @and_ne_with_diff_one(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(40 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def and_ne_with_diff_one_logical_before := [llvmfunc|
  llvm.func @and_ne_with_diff_one_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(40 : i32) : i32
    %1 = llvm.mlir.constant(39 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def or_eq_with_diff_one_signed_before := [llvmfunc|
  llvm.func @or_eq_with_diff_one_signed(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def or_eq_with_diff_one_signed_logical_before := [llvmfunc|
  llvm.func @or_eq_with_diff_one_signed_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def and_ne_with_diff_one_signed_before := [llvmfunc|
  llvm.func @and_ne_with_diff_one_signed(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.icmp "ne" %arg0, %0 : i64
    %3 = llvm.icmp "ne" %arg0, %1 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def and_ne_with_diff_one_signed_logical_before := [llvmfunc|
  llvm.func @and_ne_with_diff_one_signed_logical(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i64
    %4 = llvm.icmp "ne" %arg0, %1 : i64
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def or_eq_with_one_bit_diff_constants2_splatvec_before := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants2_splatvec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<97> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def and_ne_with_diff_one_splatvec_before := [llvmfunc|
  llvm.func @and_ne_with_diff_one_splatvec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<40> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<39> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ne" %arg0, %0 : vector<2xi32>
    %3 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def simplify_before_foldAndOfICmps_before := [llvmfunc|
  llvm.func @simplify_before_foldAndOfICmps(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.undef : i16
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.alloca %0 x i16 {alignment = 2 : i64} : (i32) -> !llvm.ptr]

    %8 = llvm.load %7 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %9 = llvm.getelementptr %7[%1] : (!llvm.ptr, i8) -> !llvm.ptr, i16
    %10 = llvm.udiv %8, %2  : i16
    %11 = llvm.getelementptr %7[%10] : (!llvm.ptr, i16) -> !llvm.ptr, i16
    %12 = llvm.load %11 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %13 = llvm.load %11 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %14 = llvm.mul %10, %10  : i16
    %15 = llvm.load %7 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %16 = llvm.sdiv %8, %15  : i16
    %17 = llvm.sub %3, %16  : i16
    %18 = llvm.mul %14, %17  : i16
    %19 = llvm.icmp "ugt" %13, %10 : i16
    %20 = llvm.and %8, %12  : i16
    %21 = llvm.mul %19, %4  : i1
    %22 = llvm.icmp "sle" %16, %13 : i16
    %23 = llvm.icmp "ule" %16, %13 : i16
    %24 = llvm.icmp "slt" %20, %3 : i16
    %25 = llvm.srem %15, %18  : i16
    %26 = llvm.add %24, %19  : i1
    %27 = llvm.add %23, %26  : i1
    %28 = llvm.icmp "sge" %23, %27 : i1
    %29 = llvm.or %25, %15  : i16
    %30 = llvm.icmp "uge" %22, %21 : i1
    %31 = llvm.icmp "ult" %30, %28 : i1
    llvm.store %5, %9 {alignment = 2 : i64} : i16, !llvm.ptr]

    %32 = llvm.icmp "ule" %19, %24 : i1
    %33 = llvm.getelementptr %6[%31] : (!llvm.ptr, i1) -> !llvm.ptr, i1
    llvm.store %29, %arg0 {alignment = 2 : i64} : i16, !llvm.ptr]

    llvm.store %32, %arg0 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.store %33, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def PR42691_1_before := [llvmfunc|
  llvm.func @PR42691_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def PR42691_1_logical_before := [llvmfunc|
  llvm.func @PR42691_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def PR42691_2_before := [llvmfunc|
  llvm.func @PR42691_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def PR42691_2_logical_before := [llvmfunc|
  llvm.func @PR42691_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def PR42691_3_before := [llvmfunc|
  llvm.func @PR42691_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def PR42691_3_logical_before := [llvmfunc|
  llvm.func @PR42691_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sge" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def PR42691_4_before := [llvmfunc|
  llvm.func @PR42691_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "uge" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def PR42691_4_logical_before := [llvmfunc|
  llvm.func @PR42691_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "uge" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def PR42691_5_before := [llvmfunc|
  llvm.func @PR42691_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def PR42691_5_logical_before := [llvmfunc|
  llvm.func @PR42691_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def PR42691_6_before := [llvmfunc|
  llvm.func @PR42691_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def PR42691_6_logical_before := [llvmfunc|
  llvm.func @PR42691_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def PR42691_7_before := [llvmfunc|
  llvm.func @PR42691_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "uge" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def PR42691_7_logical_before := [llvmfunc|
  llvm.func @PR42691_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "uge" %arg0, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

def PR42691_8_before := [llvmfunc|
  llvm.func @PR42691_8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def PR42691_8_logical_before := [llvmfunc|
  llvm.func @PR42691_8_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def PR42691_9_before := [llvmfunc|
  llvm.func @PR42691_9(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def PR42691_9_logical_before := [llvmfunc|
  llvm.func @PR42691_9_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def PR42691_10_before := [llvmfunc|
  llvm.func @PR42691_10(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def PR42691_10_logical_before := [llvmfunc|
  llvm.func @PR42691_10_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def substitute_constant_and_eq_eq_before := [llvmfunc|
  llvm.func @substitute_constant_and_eq_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def substitute_constant_and_eq_eq_logical_before := [llvmfunc|
  llvm.func @substitute_constant_and_eq_eq_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg0, %arg1 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def substitute_constant_and_eq_eq_commute_before := [llvmfunc|
  llvm.func @substitute_constant_and_eq_eq_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def substitute_constant_and_eq_eq_commute_logical_before := [llvmfunc|
  llvm.func @substitute_constant_and_eq_eq_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg0, %arg1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def substitute_constant_and_eq_ugt_swap_before := [llvmfunc|
  llvm.func @substitute_constant_and_eq_ugt_swap(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def substitute_constant_and_eq_ugt_swap_logical_before := [llvmfunc|
  llvm.func @substitute_constant_and_eq_ugt_swap_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def substitute_constant_and_eq_ne_vec_before := [llvmfunc|
  llvm.func @substitute_constant_and_eq_ne_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, 97]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %2 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi8>
    %3 = llvm.and %1, %2  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def substitute_constant_and_eq_ne_vec_logical_before := [llvmfunc|
  llvm.func @substitute_constant_and_eq_ne_vec_logical(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, 97]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %4 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi8>
    %5 = llvm.select %3, %4, %2 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def substitute_constant_and_eq_sgt_use_before := [llvmfunc|
  llvm.func @substitute_constant_and_eq_sgt_use(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def substitute_constant_and_eq_sgt_use_logical_before := [llvmfunc|
  llvm.func @substitute_constant_and_eq_sgt_use_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def substitute_constant_and_eq_sgt_use2_before := [llvmfunc|
  llvm.func @substitute_constant_and_eq_sgt_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def substitute_constant_and_eq_sgt_use2_logical_before := [llvmfunc|
  llvm.func @substitute_constant_and_eq_sgt_use2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def slt_and_max_before := [llvmfunc|
  llvm.func @slt_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "slt" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def slt_and_max_logical_before := [llvmfunc|
  llvm.func @slt_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "slt" %arg0, %arg1 : i8
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sge_and_max_before := [llvmfunc|
  llvm.func @sge_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def sge_and_max_logical_before := [llvmfunc|
  llvm.func @sge_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "sge" %arg0, %arg1 : i8
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def substitute_constant_and_ne_ugt_swap_before := [llvmfunc|
  llvm.func @substitute_constant_and_ne_ugt_swap(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def substitute_constant_and_ne_ugt_swap_logical_before := [llvmfunc|
  llvm.func @substitute_constant_and_ne_ugt_swap_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def substitute_constant_or_ne_swap_sle_before := [llvmfunc|
  llvm.func @substitute_constant_or_ne_swap_sle(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def substitute_constant_or_ne_swap_sle_logical_before := [llvmfunc|
  llvm.func @substitute_constant_or_ne_swap_sle_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "sle" %arg1, %arg0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def substitute_constant_or_ne_uge_commute_before := [llvmfunc|
  llvm.func @substitute_constant_or_ne_uge_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def substitute_constant_or_ne_uge_commute_logical_before := [llvmfunc|
  llvm.func @substitute_constant_or_ne_uge_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "uge" %arg0, %arg1 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def substitute_constant_or_ne_slt_swap_vec_undef_before := [llvmfunc|
  llvm.func @substitute_constant_or_ne_slt_swap_vec_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "slt" %arg1, %arg0 : vector<2xi8>
    %9 = llvm.or %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

def substitute_constant_or_ne_slt_swap_vec_poison_before := [llvmfunc|
  llvm.func @substitute_constant_or_ne_slt_swap_vec_poison(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "slt" %arg1, %arg0 : vector<2xi8>
    %9 = llvm.or %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

def substitute_constant_or_ne_slt_swap_vec_logical_before := [llvmfunc|
  llvm.func @substitute_constant_or_ne_slt_swap_vec_logical(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(true) : i1
    %8 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %9 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %10 = llvm.icmp "slt" %arg1, %arg0 : vector<2xi8>
    %11 = llvm.select %9, %8, %10 : vector<2xi1>, vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

def substitute_constant_or_eq_swap_ne_before := [llvmfunc|
  llvm.func @substitute_constant_or_eq_swap_ne(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "ne" %arg1, %arg0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def substitute_constant_or_eq_swap_ne_logical_before := [llvmfunc|
  llvm.func @substitute_constant_or_eq_swap_ne_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "ne" %arg1, %arg0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def substitute_constant_or_ne_sge_use_before := [llvmfunc|
  llvm.func @substitute_constant_or_ne_sge_use(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def substitute_constant_or_ne_sge_use_logical_before := [llvmfunc|
  llvm.func @substitute_constant_or_ne_sge_use_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "sge" %arg0, %arg1 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def substitute_constant_or_ne_ule_use2_before := [llvmfunc|
  llvm.func @substitute_constant_or_ne_ule_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def substitute_constant_or_ne_ule_use2_logical_before := [llvmfunc|
  llvm.func @substitute_constant_or_ne_ule_use2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def or_ranges_overlap_before := [llvmfunc|
  llvm.func @or_ranges_overlap(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(20 : i8) : i8
    %3 = llvm.icmp "uge" %arg0, %0 : i8
    %4 = llvm.icmp "ule" %arg0, %1 : i8
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.icmp "uge" %arg0, %1 : i8
    %7 = llvm.icmp "ule" %arg0, %2 : i8
    %8 = llvm.and %6, %7  : i1
    %9 = llvm.or %5, %8  : i1
    llvm.return %9 : i1
  }]

def or_ranges_adjacent_before := [llvmfunc|
  llvm.func @or_ranges_adjacent(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(11 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "uge" %arg0, %0 : i8
    %5 = llvm.icmp "ule" %arg0, %1 : i8
    %6 = llvm.and %4, %5  : i1
    %7 = llvm.icmp "uge" %arg0, %2 : i8
    %8 = llvm.icmp "ule" %arg0, %3 : i8
    %9 = llvm.and %7, %8  : i1
    %10 = llvm.or %6, %9  : i1
    llvm.return %10 : i1
  }]

def or_ranges_separated_before := [llvmfunc|
  llvm.func @or_ranges_separated(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "uge" %arg0, %0 : i8
    %5 = llvm.icmp "ule" %arg0, %1 : i8
    %6 = llvm.and %4, %5  : i1
    %7 = llvm.icmp "uge" %arg0, %2 : i8
    %8 = llvm.icmp "ule" %arg0, %3 : i8
    %9 = llvm.and %7, %8  : i1
    %10 = llvm.or %6, %9  : i1
    llvm.return %10 : i1
  }]

def or_ranges_single_elem_right_before := [llvmfunc|
  llvm.func @or_ranges_single_elem_right(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(11 : i8) : i8
    %3 = llvm.icmp "uge" %arg0, %0 : i8
    %4 = llvm.icmp "ule" %arg0, %1 : i8
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.icmp "eq" %arg0, %2 : i8
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }]

def or_ranges_single_elem_left_before := [llvmfunc|
  llvm.func @or_ranges_single_elem_left(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(4 : i8) : i8
    %3 = llvm.icmp "uge" %arg0, %0 : i8
    %4 = llvm.icmp "ule" %arg0, %1 : i8
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.icmp "eq" %arg0, %2 : i8
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }]

def and_ranges_overlap_before := [llvmfunc|
  llvm.func @and_ranges_overlap(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "uge" %arg0, %0 : i8
    %5 = llvm.icmp "ule" %arg0, %1 : i8
    %6 = llvm.and %4, %5  : i1
    %7 = llvm.icmp "uge" %arg0, %2 : i8
    %8 = llvm.icmp "ule" %arg0, %3 : i8
    %9 = llvm.and %7, %8  : i1
    %10 = llvm.and %6, %9  : i1
    llvm.return %10 : i1
  }]

def and_ranges_overlap_single_before := [llvmfunc|
  llvm.func @and_ranges_overlap_single(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(20 : i8) : i8
    %3 = llvm.icmp "uge" %arg0, %0 : i8
    %4 = llvm.icmp "ule" %arg0, %1 : i8
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.icmp "uge" %arg0, %1 : i8
    %7 = llvm.icmp "ule" %arg0, %2 : i8
    %8 = llvm.and %6, %7  : i1
    %9 = llvm.and %5, %8  : i1
    llvm.return %9 : i1
  }]

def and_ranges_no_overlap_before := [llvmfunc|
  llvm.func @and_ranges_no_overlap(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(11 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "uge" %arg0, %0 : i8
    %5 = llvm.icmp "ule" %arg0, %1 : i8
    %6 = llvm.and %4, %5  : i1
    %7 = llvm.icmp "uge" %arg0, %2 : i8
    %8 = llvm.icmp "ule" %arg0, %3 : i8
    %9 = llvm.and %7, %8  : i1
    %10 = llvm.and %6, %9  : i1
    llvm.return %10 : i1
  }]

def and_ranges_signed_pred_before := [llvmfunc|
  llvm.func @and_ranges_signed_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(127 : i64) : i64
    %1 = llvm.mlir.constant(1024 : i64) : i64
    %2 = llvm.mlir.constant(128 : i64) : i64
    %3 = llvm.mlir.constant(256 : i64) : i64
    %4 = llvm.add %arg0, %0  : i64
    %5 = llvm.icmp "slt" %4, %1 : i64
    %6 = llvm.add %arg0, %2  : i64
    %7 = llvm.icmp "slt" %6, %3 : i64
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def and_two_ranges_to_mask_and_range_before := [llvmfunc|
  llvm.func @and_two_ranges_to_mask_and_range(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-97 : i8) : i8
    %1 = llvm.mlir.constant(25 : i8) : i8
    %2 = llvm.mlir.constant(-65 : i8) : i8
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ugt" %3, %1 : i8
    %5 = llvm.add %arg0, %2  : i8
    %6 = llvm.icmp "ugt" %5, %1 : i8
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def and_two_ranges_to_mask_and_range_not_pow2_diff_before := [llvmfunc|
  llvm.func @and_two_ranges_to_mask_and_range_not_pow2_diff(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-97 : i8) : i8
    %1 = llvm.mlir.constant(25 : i8) : i8
    %2 = llvm.mlir.constant(-64 : i8) : i8
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ugt" %3, %1 : i8
    %5 = llvm.add %arg0, %2  : i8
    %6 = llvm.icmp "ugt" %5, %1 : i8
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def and_two_ranges_to_mask_and_range_different_sizes_before := [llvmfunc|
  llvm.func @and_two_ranges_to_mask_and_range_different_sizes(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-97 : i8) : i8
    %1 = llvm.mlir.constant(25 : i8) : i8
    %2 = llvm.mlir.constant(-65 : i8) : i8
    %3 = llvm.mlir.constant(24 : i8) : i8
    %4 = llvm.add %arg0, %0  : i8
    %5 = llvm.icmp "ugt" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.icmp "ugt" %6, %3 : i8
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def and_two_ranges_to_mask_and_range_no_add_on_one_range_before := [llvmfunc|
  llvm.func @and_two_ranges_to_mask_and_range_no_add_on_one_range(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.mlir.constant(16 : i16) : i16
    %2 = llvm.mlir.constant(28 : i16) : i16
    %3 = llvm.icmp "uge" %arg0, %0 : i16
    %4 = llvm.icmp "ult" %arg0, %1 : i16
    %5 = llvm.icmp "uge" %arg0, %2 : i16
    %6 = llvm.or %4, %5  : i1
    %7 = llvm.and %3, %6  : i1
    llvm.return %7 : i1
  }]

def is_ascii_alphabetic_before := [llvmfunc|
  llvm.func @is_ascii_alphabetic(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-65 : i32) : i32
    %1 = llvm.mlir.constant(26 : i32) : i32
    %2 = llvm.mlir.constant(-97 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.add %arg0, %2 overflow<nsw>  : i32
    %7 = llvm.icmp "ult" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }]

def is_ascii_alphabetic_inverted_before := [llvmfunc|
  llvm.func @is_ascii_alphabetic_inverted(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-91 : i32) : i32
    %1 = llvm.mlir.constant(-26 : i32) : i32
    %2 = llvm.mlir.constant(-123 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.add %arg0, %2 overflow<nsw>  : i32
    %7 = llvm.icmp "ult" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

def bitwise_and_bitwise_and_icmps_before := [llvmfunc|
  llvm.func @bitwise_and_bitwise_and_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "ne" %4, %2 : i8
    %8 = llvm.icmp "ne" %6, %2 : i8
    %9 = llvm.and %3, %7  : i1
    %10 = llvm.and %9, %8  : i1
    llvm.return %10 : i1
  }]

def bitwise_and_bitwise_and_icmps_comm1_before := [llvmfunc|
  llvm.func @bitwise_and_bitwise_and_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "ne" %4, %2 : i8
    %8 = llvm.icmp "ne" %6, %2 : i8
    %9 = llvm.and %3, %7  : i1
    %10 = llvm.and %8, %9  : i1
    llvm.return %10 : i1
  }]

def bitwise_and_bitwise_and_icmps_comm2_before := [llvmfunc|
  llvm.func @bitwise_and_bitwise_and_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "ne" %4, %2 : i8
    %8 = llvm.icmp "ne" %6, %2 : i8
    %9 = llvm.and %7, %3  : i1
    %10 = llvm.and %9, %8  : i1
    llvm.return %10 : i1
  }]

def bitwise_and_bitwise_and_icmps_comm3_before := [llvmfunc|
  llvm.func @bitwise_and_bitwise_and_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "ne" %4, %2 : i8
    %8 = llvm.icmp "ne" %6, %2 : i8
    %9 = llvm.and %7, %3  : i1
    %10 = llvm.and %8, %9  : i1
    llvm.return %10 : i1
  }]

def bitwise_and_logical_and_icmps_before := [llvmfunc|
  llvm.func @bitwise_and_logical_and_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %4, %8, %3 : i1, i1
    %11 = llvm.and %10, %9  : i1
    llvm.return %11 : i1
  }]

def bitwise_and_logical_and_icmps_comm1_before := [llvmfunc|
  llvm.func @bitwise_and_logical_and_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %4, %8, %3 : i1, i1
    %11 = llvm.and %9, %10  : i1
    llvm.return %11 : i1
  }]

def bitwise_and_logical_and_icmps_comm2_before := [llvmfunc|
  llvm.func @bitwise_and_logical_and_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %8, %4, %3 : i1, i1
    %11 = llvm.and %10, %9  : i1
    llvm.return %11 : i1
  }]

def bitwise_and_logical_and_icmps_comm3_before := [llvmfunc|
  llvm.func @bitwise_and_logical_and_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %8, %4, %3 : i1, i1
    %11 = llvm.and %9, %10  : i1
    llvm.return %11 : i1
  }]

def logical_and_bitwise_and_icmps_before := [llvmfunc|
  llvm.func @logical_and_bitwise_and_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.and %4, %8  : i1
    %11 = llvm.select %10, %9, %3 : i1, i1
    llvm.return %11 : i1
  }]

def logical_and_bitwise_and_icmps_comm1_before := [llvmfunc|
  llvm.func @logical_and_bitwise_and_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.and %4, %8  : i1
    %11 = llvm.select %9, %10, %3 : i1, i1
    llvm.return %11 : i1
  }]

def logical_and_bitwise_and_icmps_comm2_before := [llvmfunc|
  llvm.func @logical_and_bitwise_and_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.and %8, %4  : i1
    %11 = llvm.select %10, %9, %3 : i1, i1
    llvm.return %11 : i1
  }]

def logical_and_bitwise_and_icmps_comm3_before := [llvmfunc|
  llvm.func @logical_and_bitwise_and_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.and %8, %4  : i1
    %11 = llvm.select %9, %10, %3 : i1, i1
    llvm.return %11 : i1
  }]

def logical_and_logical_and_icmps_before := [llvmfunc|
  llvm.func @logical_and_logical_and_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %4, %8, %3 : i1, i1
    %11 = llvm.select %10, %9, %3 : i1, i1
    llvm.return %11 : i1
  }]

def logical_and_logical_and_icmps_comm1_before := [llvmfunc|
  llvm.func @logical_and_logical_and_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %4, %8, %3 : i1, i1
    %11 = llvm.select %9, %10, %3 : i1, i1
    llvm.return %11 : i1
  }]

def logical_and_logical_and_icmps_comm2_before := [llvmfunc|
  llvm.func @logical_and_logical_and_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %8, %4, %3 : i1, i1
    %11 = llvm.select %10, %9, %3 : i1, i1
    llvm.return %11 : i1
  }]

def logical_and_logical_and_icmps_comm3_before := [llvmfunc|
  llvm.func @logical_and_logical_and_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %8, %4, %3 : i1, i1
    %11 = llvm.select %9, %10, %3 : i1, i1
    llvm.return %11 : i1
  }]

def bitwise_or_bitwise_or_icmps_before := [llvmfunc|
  llvm.func @bitwise_or_bitwise_or_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "eq" %4, %2 : i8
    %8 = llvm.icmp "eq" %6, %2 : i8
    %9 = llvm.or %3, %7  : i1
    %10 = llvm.or %9, %8  : i1
    llvm.return %10 : i1
  }]

def bitwise_or_bitwise_or_icmps_comm1_before := [llvmfunc|
  llvm.func @bitwise_or_bitwise_or_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "eq" %4, %2 : i8
    %8 = llvm.icmp "eq" %6, %2 : i8
    %9 = llvm.or %3, %7  : i1
    %10 = llvm.or %8, %9  : i1
    llvm.return %10 : i1
  }]

def bitwise_or_bitwise_or_icmps_comm2_before := [llvmfunc|
  llvm.func @bitwise_or_bitwise_or_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "eq" %4, %2 : i8
    %8 = llvm.icmp "eq" %6, %2 : i8
    %9 = llvm.or %7, %3  : i1
    %10 = llvm.or %9, %8  : i1
    llvm.return %10 : i1
  }]

def bitwise_or_bitwise_or_icmps_comm3_before := [llvmfunc|
  llvm.func @bitwise_or_bitwise_or_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.shl %1, %arg2  : i8
    %6 = llvm.and %arg0, %5  : i8
    %7 = llvm.icmp "eq" %4, %2 : i8
    %8 = llvm.icmp "eq" %6, %2 : i8
    %9 = llvm.or %7, %3  : i1
    %10 = llvm.or %8, %9  : i1
    llvm.return %10 : i1
  }]

def bitwise_or_logical_or_icmps_before := [llvmfunc|
  llvm.func @bitwise_or_logical_or_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %4, %3, %8 : i1, i1
    %11 = llvm.or %10, %9  : i1
    llvm.return %11 : i1
  }]

def bitwise_or_logical_or_icmps_comm1_before := [llvmfunc|
  llvm.func @bitwise_or_logical_or_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %4, %3, %8 : i1, i1
    %11 = llvm.or %9, %10  : i1
    llvm.return %11 : i1
  }]

def bitwise_or_logical_or_icmps_comm2_before := [llvmfunc|
  llvm.func @bitwise_or_logical_or_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %8, %3, %4 : i1, i1
    %11 = llvm.or %10, %9  : i1
    llvm.return %11 : i1
  }]

def bitwise_or_logical_or_icmps_comm3_before := [llvmfunc|
  llvm.func @bitwise_or_logical_or_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %8, %3, %4 : i1, i1
    %11 = llvm.or %9, %10  : i1
    llvm.return %11 : i1
  }]

def logical_or_bitwise_or_icmps_before := [llvmfunc|
  llvm.func @logical_or_bitwise_or_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.or %4, %8  : i1
    %11 = llvm.select %10, %3, %9 : i1, i1
    llvm.return %11 : i1
  }]

def logical_or_bitwise_or_icmps_comm1_before := [llvmfunc|
  llvm.func @logical_or_bitwise_or_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.or %4, %8  : i1
    %11 = llvm.select %9, %3, %10 : i1, i1
    llvm.return %11 : i1
  }]

def logical_or_bitwise_or_icmps_comm2_before := [llvmfunc|
  llvm.func @logical_or_bitwise_or_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.or %8, %4  : i1
    %11 = llvm.select %10, %3, %9 : i1, i1
    llvm.return %11 : i1
  }]

def logical_or_bitwise_or_icmps_comm3_before := [llvmfunc|
  llvm.func @logical_or_bitwise_or_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.or %8, %4  : i1
    %11 = llvm.select %9, %3, %10 : i1, i1
    llvm.return %11 : i1
  }]

def logical_or_logical_or_icmps_before := [llvmfunc|
  llvm.func @logical_or_logical_or_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %4, %3, %8 : i1, i1
    %11 = llvm.select %10, %3, %9 : i1, i1
    llvm.return %11 : i1
  }]

def logical_or_logical_or_icmps_comm1_before := [llvmfunc|
  llvm.func @logical_or_logical_or_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %4, %3, %8 : i1, i1
    %11 = llvm.select %9, %3, %10 : i1, i1
    llvm.return %11 : i1
  }]

def logical_or_logical_or_icmps_comm2_before := [llvmfunc|
  llvm.func @logical_or_logical_or_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %8, %3, %4 : i1, i1
    %11 = llvm.select %10, %3, %9 : i1, i1
    llvm.return %11 : i1
  }]

def logical_or_logical_or_icmps_comm3_before := [llvmfunc|
  llvm.func @logical_or_logical_or_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2  : i8
    %7 = llvm.and %arg0, %6  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %8, %3, %4 : i1, i1
    %11 = llvm.select %9, %3, %10 : i1, i1
    llvm.return %11 : i1
  }]

def bitwise_and_logical_and_masked_icmp_asymmetric_before := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_asymmetric(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(11 : i32) : i32
    %4 = llvm.and %arg1, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.select %5, %arg0, %2 : i1, i1
    %7 = llvm.and %arg1, %3  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.and %6, %8  : i1
    llvm.return %9 : i1
  }]

def bitwise_and_logical_and_masked_icmp_allzeros_before := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_allzeros(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.and %arg1, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %arg0, %2 : i1, i1
    %7 = llvm.and %arg1, %3  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.and %6, %8  : i1
    llvm.return %9 : i1
  }]

def bitwise_and_logical_and_masked_icmp_allzeros_poison1_before := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_allzeros_poison1(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg1, %arg2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %arg0, %1 : i1, i1
    %6 = llvm.and %arg1, %2  : i32
    %7 = llvm.icmp "eq" %6, %0 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def bitwise_and_logical_and_masked_icmp_allzeros_poison2_before := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_allzeros_poison2(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.select %4, %arg0, %2 : i1, i1
    %6 = llvm.and %arg1, %arg2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def bitwise_and_logical_and_masked_icmp_allones_before := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_allones(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %arg0, %1 : i1, i1
    %6 = llvm.and %arg1, %2  : i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def bitwise_and_logical_and_masked_icmp_allones_poison1_before := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_allones_poison1(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.and %arg1, %arg2  : i32
    %3 = llvm.icmp "eq" %2, %arg2 : i32
    %4 = llvm.select %3, %arg0, %0 : i1, i1
    %5 = llvm.and %arg1, %1  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def bitwise_and_logical_and_masked_icmp_allones_poison2_before := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_allones_poison2(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.select %3, %arg0, %1 : i1, i1
    %5 = llvm.and %arg1, %arg2  : i32
    %6 = llvm.icmp "eq" %5, %arg2 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def samesign_before := [llvmfunc|
  llvm.func @samesign(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_different_sign_bittest1_before := [llvmfunc|
  llvm.func @samesign_different_sign_bittest1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %arg1  : vector<2xi32>
    %2 = llvm.icmp "sle" %1, %0 : vector<2xi32>
    %3 = llvm.or %arg0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "sgt" %3, %0 : vector<2xi32>
    %5 = llvm.or %2, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def samesign_different_sign_bittest2_before := [llvmfunc|
  llvm.func @samesign_different_sign_bittest2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.icmp "sge" %3, %0 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }]

def samesign_commute1_before := [llvmfunc|
  llvm.func @samesign_commute1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.or %5, %3  : i1
    llvm.return %6 : i1
  }]

def samesign_commute2_before := [llvmfunc|
  llvm.func @samesign_commute2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg1, %arg0  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_commute3_before := [llvmfunc|
  llvm.func @samesign_commute3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg1, %arg0  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.or %5, %3  : i1
    llvm.return %6 : i1
  }]

def samesign_violate_constraint1_before := [llvmfunc|
  llvm.func @samesign_violate_constraint1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_violate_constraint2_before := [llvmfunc|
  llvm.func @samesign_violate_constraint2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_mult_use_before := [llvmfunc|
  llvm.func @samesign_mult_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_mult_use2_before := [llvmfunc|
  llvm.func @samesign_mult_use2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_mult_use3_before := [llvmfunc|
  llvm.func @samesign_mult_use3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_wrong_cmp_before := [llvmfunc|
  llvm.func @samesign_wrong_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_inverted_before := [llvmfunc|
  llvm.func @samesign_inverted(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_inverted_different_sign_bittest1_before := [llvmfunc|
  llvm.func @samesign_inverted_different_sign_bittest1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "sge" %1, %0 : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }]

def samesign_inverted_different_sign_bittest2_before := [llvmfunc|
  llvm.func @samesign_inverted_different_sign_bittest2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.icmp "sle" %3, %0 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }]

def samesign_inverted_commute1_before := [llvmfunc|
  llvm.func @samesign_inverted_commute1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.and %5, %3  : i1
    llvm.return %6 : i1
  }]

def samesign_inverted_commute2_before := [llvmfunc|
  llvm.func @samesign_inverted_commute2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.or %arg1, %arg0  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_inverted_commute3_before := [llvmfunc|
  llvm.func @samesign_inverted_commute3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.or %arg1, %arg0  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.and %5, %3  : i1
    llvm.return %6 : i1
  }]

def samesign_inverted_violate_constraint1_before := [llvmfunc|
  llvm.func @samesign_inverted_violate_constraint1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.and %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_inverted_violate_constraint2_before := [llvmfunc|
  llvm.func @samesign_inverted_violate_constraint2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_inverted_mult_use_before := [llvmfunc|
  llvm.func @samesign_inverted_mult_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_inverted_mult_use2_before := [llvmfunc|
  llvm.func @samesign_inverted_mult_use2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def samesign_inverted_wrong_cmp_before := [llvmfunc|
  llvm.func @samesign_inverted_wrong_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }]

def icmp_eq_m1_and_eq_m1_before := [llvmfunc|
  llvm.func @icmp_eq_m1_and_eq_m1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "eq" %arg1, %6 : vector<2xi8>
    %9 = llvm.and %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

def icmp_eq_m1_and_eq_poison_m1_before := [llvmfunc|
  llvm.func @icmp_eq_m1_and_eq_poison_m1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.undef : vector<2xi8>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xi8>
    %12 = llvm.icmp "eq" %arg0, %6 : vector<2xi8>
    %13 = llvm.icmp "eq" %arg1, %11 : vector<2xi8>
    %14 = llvm.and %12, %13  : vector<2xi1>
    llvm.return %14 : vector<2xi1>
  }]

def icmp_eq_poison_and_eq_m1_m2_before := [llvmfunc|
  llvm.func @icmp_eq_poison_and_eq_m1_m2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-1, -2]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %3 = llvm.icmp "eq" %arg1, %1 : vector<2xi8>
    %4 = llvm.and %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def icmp_ne_m1_and_ne_m1_fail_before := [llvmfunc|
  llvm.func @icmp_ne_m1_and_ne_m1_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "ne" %arg1, %6 : vector<2xi8>
    %9 = llvm.and %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

def icmp_eq_m1_or_eq_m1_fail_before := [llvmfunc|
  llvm.func @icmp_eq_m1_or_eq_m1_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "eq" %arg1, %6 : vector<2xi8>
    %9 = llvm.or %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

def icmp_ne_m1_or_ne_m1_before := [llvmfunc|
  llvm.func @icmp_ne_m1_or_ne_m1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.icmp "ne" %arg0, %0 : vector<2xi8>
    %9 = llvm.icmp "ne" %arg1, %7 : vector<2xi8>
    %10 = llvm.or %8, %9  : vector<2xi1>
    llvm.return %10 : vector<2xi1>
  }]

def icmp_slt_0_or_icmp_sgt_0_i32_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.zext %1 : i1 to i32
    %4 = llvm.zext %2 : i1 to i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }]

def icmp_slt_0_or_icmp_sgt_0_i64_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.zext %1 : i1 to i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %3, %4  : i64
    llvm.return %5 : i64
  }]

def icmp_slt_0_or_icmp_sgt_0_i64_fail0_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64_fail0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %3, %4  : i64
    llvm.return %5 : i64
  }]

def icmp_slt_0_or_icmp_sgt_0_i64_fail1_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64_fail1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.ashr %arg0, %1  : i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %3, %4  : i64
    llvm.return %5 : i64
  }]

def icmp_slt_0_or_icmp_sgt_0_i64_fail2_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64_fail2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(62 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %3, %4  : i64
    llvm.return %5 : i64
  }]

def icmp_slt_0_or_icmp_sgt_0_i64_fail3_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64_fail3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(62 : i64) : i64
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    %3 = llvm.ashr %arg0, %1  : i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %3, %4  : i64
    llvm.return %5 : i64
  }]

def icmp_slt_0_or_icmp_sgt_0_i64x2_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64x2(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "slt" %arg0, %1 : vector<2xi64>
    %3 = llvm.icmp "sgt" %arg0, %1 : vector<2xi64>
    %4 = llvm.zext %2 : vector<2xi1> to vector<2xi64>
    %5 = llvm.zext %3 : vector<2xi1> to vector<2xi64>
    %6 = llvm.or %4, %5  : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

def icmp_slt_0_or_icmp_sgt_0_i64x2_fail_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64x2_fail(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<63> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi64>
    %3 = llvm.lshr %arg0, %1  : vector<2xi64>
    %4 = llvm.zext %2 : vector<2xi1> to vector<2xi64>
    %5 = llvm.or %3, %4  : vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }]

def icmp_slt_0_and_icmp_sge_neg1_i32_before := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }]

def icmp_slt_0_or_icmp_sge_neg1_i32_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sge_neg1_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }]

def icmp_slt_0_or_icmp_sge_100_i32_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sge_100_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }]

def icmp_slt_0_and_icmp_sge_neg1_i64_before := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.icmp "sge" %arg0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %4, %3  : i64
    llvm.return %5 : i64
  }]

def icmp_slt_0_and_icmp_sge_neg2_i64_before := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-2 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.icmp "sge" %arg0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %4, %3  : i64
    llvm.return %5 : i64
  }]

def ashr_and_icmp_sge_neg1_i64_before := [llvmfunc|
  llvm.func @ashr_and_icmp_sge_neg1_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.icmp "sge" %arg0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.ashr %arg0, %1  : i64
    %5 = llvm.and %4, %3  : i64
    llvm.return %5 : i64
  }]

def icmp_slt_0_and_icmp_sgt_neg1_i64_before := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sgt_neg1_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %4, %3  : i64
    llvm.return %5 : i64
  }]

def icmp_slt_0_and_icmp_sge_neg1_i64_fail_before := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i64_fail(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(62 : i64) : i64
    %2 = llvm.icmp "sge" %arg0, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.lshr %arg0, %1  : i64
    %5 = llvm.and %4, %3  : i64
    llvm.return %5 : i64
  }]

def icmp_slt_0_and_icmp_sge_neg1_i32x2_before := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i32x2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sge" %arg0, %0 : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi32>
    %4 = llvm.lshr %arg0, %1  : vector<2xi32>
    %5 = llvm.and %4, %3  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def icmp_slt_0_and_icmp_sge_neg2_i32x2_before := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i32x2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sge" %arg0, %0 : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi32>
    %4 = llvm.lshr %arg0, %1  : vector<2xi32>
    %5 = llvm.and %4, %3  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_before := [llvmfunc|
  llvm.func @icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg1, %1  : i32
    %5 = llvm.xor %4, %3  : i32
    llvm.return %5 : i32
  }]

def icmp_slt_0_xor_icmp_sgt_neg2_i32_before := [llvmfunc|
  llvm.func @icmp_slt_0_xor_icmp_sgt_neg2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.xor %4, %3  : i32
    llvm.return %5 : i32
  }]

def icmp_slt_0_and_icmp_sge_neg1_i32_multiuse0_before := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i32_multiuse0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %5 : i32
  }]

def icmp_slt_0_and_icmp_sge_neg2_i32_multiuse1_before := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i32_multiuse1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %5 : i32
  }]

def icmp_slt_0_and_icmp_sge_neg2_i32_multiuse2_before := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i32_multiuse2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

def icmp_slt_0_and_icmp_sge_neg2_i32_multiuse_fail0_before := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i32_multiuse_fail0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

def icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail1_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

def icmp_x_slt_0_and_icmp_y_ne_neg2_i32_multiuse_fail2_before := [llvmfunc|
  llvm.func @icmp_x_slt_0_and_icmp_y_ne_neg2_i32_multiuse_fail2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg1, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

def icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail3_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %5 : i32
  }]

def icmp_slt_0_or_icmp_eq_100_i32_fail_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_eq_100_i32_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }]

def icmp_slt_0_and_icmp_ne_neg2_i32_fail_before := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_ne_neg2_i32_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }]

def icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_before := [llvmfunc|
  llvm.func @icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg1, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }]

def icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_before := [llvmfunc|
  llvm.func @icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg1, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }]

def icmp_slt_0_xor_icmp_sge_neg2_i32_fail_before := [llvmfunc|
  llvm.func @icmp_slt_0_xor_icmp_sge_neg2_i32_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.xor %4, %3  : i32
    llvm.return %5 : i32
  }]

def icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_before := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_add_1_sge_100_i32_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "sge" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    %6 = llvm.lshr %arg0, %2  : i32
    %7 = llvm.or %6, %5  : i32
    llvm.return %7 : i32
  }]

def logical_and_icmps1_before := [llvmfunc|
  llvm.func @logical_and_icmps1(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(10086 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %arg1, %3, %1 : i1, i1
    %5 = llvm.icmp "slt" %arg0, %2 : i32
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

def logical_and_icmps2_before := [llvmfunc|
  llvm.func @logical_and_icmps2(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(10086 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %arg1, %3, %1 : i1, i1
    %5 = llvm.icmp "eq" %arg0, %2 : i32
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

def logical_and_icmps_vec1_before := [llvmfunc|
  llvm.func @logical_and_icmps_vec1(%arg0: vector<4xi32>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %3 = llvm.mlir.constant(dense<10086> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.icmp "sgt" %arg0, %0 : vector<4xi32>
    %5 = llvm.select %arg1, %4, %2 : vector<4xi1>, vector<4xi1>
    %6 = llvm.icmp "slt" %arg0, %3 : vector<4xi32>
    %7 = llvm.select %5, %6, %2 : vector<4xi1>, vector<4xi1>
    llvm.return %7 : vector<4xi1>
  }]

def logical_and_icmps_fail1_before := [llvmfunc|
  llvm.func @logical_and_icmps_fail1(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %arg2, %2, %1 : i1, i1
    %4 = llvm.icmp "slt" %arg0, %arg1 : i32
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }]

def PR1817_1_combined := [llvmfunc|
  llvm.func @PR1817_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR1817_1   : PR1817_1_before  ⊑  PR1817_1_combined := by
  unfold PR1817_1_before PR1817_1_combined
  simp_alive_peephole
  sorry
def PR1817_1_logical_combined := [llvmfunc|
  llvm.func @PR1817_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR1817_1_logical   : PR1817_1_logical_before  ⊑  PR1817_1_logical_combined := by
  unfold PR1817_1_logical_before PR1817_1_logical_combined
  simp_alive_peephole
  sorry
def PR1817_2_combined := [llvmfunc|
  llvm.func @PR1817_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR1817_2   : PR1817_2_before  ⊑  PR1817_2_combined := by
  unfold PR1817_2_before PR1817_2_combined
  simp_alive_peephole
  sorry
def PR1817_2_logical_combined := [llvmfunc|
  llvm.func @PR1817_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR1817_2_logical   : PR1817_2_logical_before  ⊑  PR1817_2_logical_combined := by
  unfold PR1817_2_logical_before PR1817_2_logical_combined
  simp_alive_peephole
  sorry
def PR2330_combined := [llvmfunc|
  llvm.func @PR2330(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_PR2330   : PR2330_before  ⊑  PR2330_combined := by
  unfold PR2330_before PR2330_combined
  simp_alive_peephole
  sorry
def PR2330_logical_combined := [llvmfunc|
  llvm.func @PR2330_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.icmp "ult" %arg1, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_PR2330_logical   : PR2330_logical_before  ⊑  PR2330_logical_combined := by
  unfold PR2330_logical_before PR2330_logical_combined
  simp_alive_peephole
  sorry
def or_eq_with_one_bit_diff_constants1_combined := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_or_eq_with_one_bit_diff_constants1   : or_eq_with_one_bit_diff_constants1_before  ⊑  or_eq_with_one_bit_diff_constants1_combined := by
  unfold or_eq_with_one_bit_diff_constants1_before or_eq_with_one_bit_diff_constants1_combined
  simp_alive_peephole
  sorry
def or_eq_with_one_bit_diff_constants1_logical_combined := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_or_eq_with_one_bit_diff_constants1_logical   : or_eq_with_one_bit_diff_constants1_logical_before  ⊑  or_eq_with_one_bit_diff_constants1_logical_combined := by
  unfold or_eq_with_one_bit_diff_constants1_logical_before or_eq_with_one_bit_diff_constants1_logical_combined
  simp_alive_peephole
  sorry
def and_ne_with_one_bit_diff_constants1_combined := [llvmfunc|
  llvm.func @and_ne_with_one_bit_diff_constants1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-52 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_and_ne_with_one_bit_diff_constants1   : and_ne_with_one_bit_diff_constants1_before  ⊑  and_ne_with_one_bit_diff_constants1_combined := by
  unfold and_ne_with_one_bit_diff_constants1_before and_ne_with_one_bit_diff_constants1_combined
  simp_alive_peephole
  sorry
def and_ne_with_one_bit_diff_constants1_logical_combined := [llvmfunc|
  llvm.func @and_ne_with_one_bit_diff_constants1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-52 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_and_ne_with_one_bit_diff_constants1_logical   : and_ne_with_one_bit_diff_constants1_logical_before  ⊑  and_ne_with_one_bit_diff_constants1_logical_combined := by
  unfold and_ne_with_one_bit_diff_constants1_logical_before and_ne_with_one_bit_diff_constants1_logical_combined
  simp_alive_peephole
  sorry
def or_eq_with_one_bit_diff_constants2_combined := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(65 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_or_eq_with_one_bit_diff_constants2   : or_eq_with_one_bit_diff_constants2_before  ⊑  or_eq_with_one_bit_diff_constants2_combined := by
  unfold or_eq_with_one_bit_diff_constants2_before or_eq_with_one_bit_diff_constants2_combined
  simp_alive_peephole
  sorry
def or_eq_with_one_bit_diff_constants2_logical_combined := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(65 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_or_eq_with_one_bit_diff_constants2_logical   : or_eq_with_one_bit_diff_constants2_logical_before  ⊑  or_eq_with_one_bit_diff_constants2_logical_combined := by
  unfold or_eq_with_one_bit_diff_constants2_logical_before or_eq_with_one_bit_diff_constants2_logical_combined
  simp_alive_peephole
  sorry
def and_ne_with_one_bit_diff_constants2_combined := [llvmfunc|
  llvm.func @and_ne_with_one_bit_diff_constants2(%arg0: i19) -> i1 {
    %0 = llvm.mlir.constant(-129 : i19) : i19
    %1 = llvm.mlir.constant(65 : i19) : i19
    %2 = llvm.and %arg0, %0  : i19
    %3 = llvm.icmp "ne" %2, %1 : i19
    llvm.return %3 : i1
  }]

theorem inst_combine_and_ne_with_one_bit_diff_constants2   : and_ne_with_one_bit_diff_constants2_before  ⊑  and_ne_with_one_bit_diff_constants2_combined := by
  unfold and_ne_with_one_bit_diff_constants2_before and_ne_with_one_bit_diff_constants2_combined
  simp_alive_peephole
  sorry
def and_ne_with_one_bit_diff_constants2_logical_combined := [llvmfunc|
  llvm.func @and_ne_with_one_bit_diff_constants2_logical(%arg0: i19) -> i1 {
    %0 = llvm.mlir.constant(-129 : i19) : i19
    %1 = llvm.mlir.constant(65 : i19) : i19
    %2 = llvm.and %arg0, %0  : i19
    %3 = llvm.icmp "ne" %2, %1 : i19
    llvm.return %3 : i1
  }]

theorem inst_combine_and_ne_with_one_bit_diff_constants2_logical   : and_ne_with_one_bit_diff_constants2_logical_before  ⊑  and_ne_with_one_bit_diff_constants2_logical_combined := by
  unfold and_ne_with_one_bit_diff_constants2_logical_before and_ne_with_one_bit_diff_constants2_logical_combined
  simp_alive_peephole
  sorry
def or_eq_with_one_bit_diff_constants3_combined := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_or_eq_with_one_bit_diff_constants3   : or_eq_with_one_bit_diff_constants3_before  ⊑  or_eq_with_one_bit_diff_constants3_combined := by
  unfold or_eq_with_one_bit_diff_constants3_before or_eq_with_one_bit_diff_constants3_combined
  simp_alive_peephole
  sorry
def or_eq_with_one_bit_diff_constants3_logical_combined := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants3_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_or_eq_with_one_bit_diff_constants3_logical   : or_eq_with_one_bit_diff_constants3_logical_before  ⊑  or_eq_with_one_bit_diff_constants3_logical_combined := by
  unfold or_eq_with_one_bit_diff_constants3_logical_before or_eq_with_one_bit_diff_constants3_logical_combined
  simp_alive_peephole
  sorry
def and_ne_with_one_bit_diff_constants3_combined := [llvmfunc|
  llvm.func @and_ne_with_one_bit_diff_constants3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(65 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_and_ne_with_one_bit_diff_constants3   : and_ne_with_one_bit_diff_constants3_before  ⊑  and_ne_with_one_bit_diff_constants3_combined := by
  unfold and_ne_with_one_bit_diff_constants3_before and_ne_with_one_bit_diff_constants3_combined
  simp_alive_peephole
  sorry
def and_ne_with_one_bit_diff_constants3_logical_combined := [llvmfunc|
  llvm.func @and_ne_with_one_bit_diff_constants3_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(65 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_and_ne_with_one_bit_diff_constants3_logical   : and_ne_with_one_bit_diff_constants3_logical_before  ⊑  and_ne_with_one_bit_diff_constants3_logical_combined := by
  unfold and_ne_with_one_bit_diff_constants3_logical_before and_ne_with_one_bit_diff_constants3_logical_combined
  simp_alive_peephole
  sorry
def or_eq_with_diff_one_combined := [llvmfunc|
  llvm.func @or_eq_with_diff_one(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-13 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_or_eq_with_diff_one   : or_eq_with_diff_one_before  ⊑  or_eq_with_diff_one_combined := by
  unfold or_eq_with_diff_one_before or_eq_with_diff_one_combined
  simp_alive_peephole
  sorry
def or_eq_with_diff_one_logical_combined := [llvmfunc|
  llvm.func @or_eq_with_diff_one_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-13 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_or_eq_with_diff_one_logical   : or_eq_with_diff_one_logical_before  ⊑  or_eq_with_diff_one_logical_combined := by
  unfold or_eq_with_diff_one_logical_before or_eq_with_diff_one_logical_combined
  simp_alive_peephole
  sorry
def and_ne_with_diff_one_combined := [llvmfunc|
  llvm.func @and_ne_with_diff_one(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-41 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_and_ne_with_diff_one   : and_ne_with_diff_one_before  ⊑  and_ne_with_diff_one_combined := by
  unfold and_ne_with_diff_one_before and_ne_with_diff_one_combined
  simp_alive_peephole
  sorry
def and_ne_with_diff_one_logical_combined := [llvmfunc|
  llvm.func @and_ne_with_diff_one_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-41 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_and_ne_with_diff_one_logical   : and_ne_with_diff_one_logical_before  ⊑  and_ne_with_diff_one_logical_combined := by
  unfold and_ne_with_diff_one_logical_before and_ne_with_diff_one_logical_combined
  simp_alive_peephole
  sorry
def or_eq_with_diff_one_signed_combined := [llvmfunc|
  llvm.func @or_eq_with_diff_one_signed(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_or_eq_with_diff_one_signed   : or_eq_with_diff_one_signed_before  ⊑  or_eq_with_diff_one_signed_combined := by
  unfold or_eq_with_diff_one_signed_before or_eq_with_diff_one_signed_combined
  simp_alive_peephole
  sorry
def or_eq_with_diff_one_signed_logical_combined := [llvmfunc|
  llvm.func @or_eq_with_diff_one_signed_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_or_eq_with_diff_one_signed_logical   : or_eq_with_diff_one_signed_logical_before  ⊑  or_eq_with_diff_one_signed_logical_combined := by
  unfold or_eq_with_diff_one_signed_logical_before or_eq_with_diff_one_signed_logical_combined
  simp_alive_peephole
  sorry
def and_ne_with_diff_one_signed_combined := [llvmfunc|
  llvm.func @and_ne_with_diff_one_signed(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(-2 : i64) : i64
    %2 = llvm.add %arg0, %0  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_and_ne_with_diff_one_signed   : and_ne_with_diff_one_signed_before  ⊑  and_ne_with_diff_one_signed_combined := by
  unfold and_ne_with_diff_one_signed_before and_ne_with_diff_one_signed_combined
  simp_alive_peephole
  sorry
def and_ne_with_diff_one_signed_logical_combined := [llvmfunc|
  llvm.func @and_ne_with_diff_one_signed_logical(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(-2 : i64) : i64
    %2 = llvm.add %arg0, %0  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_and_ne_with_diff_one_signed_logical   : and_ne_with_diff_one_signed_logical_before  ⊑  and_ne_with_diff_one_signed_logical_combined := by
  unfold and_ne_with_diff_one_signed_logical_before and_ne_with_diff_one_signed_logical_combined
  simp_alive_peephole
  sorry
def or_eq_with_one_bit_diff_constants2_splatvec_combined := [llvmfunc|
  llvm.func @or_eq_with_one_bit_diff_constants2_splatvec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-33> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_or_eq_with_one_bit_diff_constants2_splatvec   : or_eq_with_one_bit_diff_constants2_splatvec_before  ⊑  or_eq_with_one_bit_diff_constants2_splatvec_combined := by
  unfold or_eq_with_one_bit_diff_constants2_splatvec_before or_eq_with_one_bit_diff_constants2_splatvec_combined
  simp_alive_peephole
  sorry
def and_ne_with_diff_one_splatvec_combined := [llvmfunc|
  llvm.func @and_ne_with_diff_one_splatvec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-41> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_and_ne_with_diff_one_splatvec   : and_ne_with_diff_one_splatvec_before  ⊑  and_ne_with_diff_one_splatvec_combined := by
  unfold and_ne_with_diff_one_splatvec_before and_ne_with_diff_one_splatvec_combined
  simp_alive_peephole
  sorry
def simplify_before_foldAndOfICmps_combined := [llvmfunc|
  llvm.func @simplify_before_foldAndOfICmps(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.alloca %0 x i16 {alignment = 2 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.load %6 {alignment = 2 : i64} : !llvm.ptr -> i16
    %8 = llvm.icmp "eq" %7, %1 : i16
    %9 = llvm.zext %8 : i1 to i16
    %10 = llvm.icmp "ugt" %7, %9 : i16
    %11 = llvm.icmp "slt" %7, %2 : i16
    %12 = llvm.icmp "slt" %7, %3 : i16
    %13 = llvm.xor %12, %10  : i1
    %14 = llvm.xor %13, %4  : i1
    %15 = llvm.and %11, %14  : i1
    %16 = llvm.and %15, %10  : i1
    %17 = llvm.xor %10, %4  : i1
    %18 = llvm.or %12, %17  : i1
    %19 = llvm.sext %16 : i1 to i64
    %20 = llvm.getelementptr %5[%19] : (!llvm.ptr, i64) -> !llvm.ptr, i1
    llvm.store %7, %arg0 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.store %18, %arg0 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.store %20, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_simplify_before_foldAndOfICmps   : simplify_before_foldAndOfICmps_before  ⊑  simplify_before_foldAndOfICmps_combined := by
  unfold simplify_before_foldAndOfICmps_before simplify_before_foldAndOfICmps_combined
  simp_alive_peephole
  sorry
def PR42691_1_combined := [llvmfunc|
  llvm.func @PR42691_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483646 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR42691_1   : PR42691_1_before  ⊑  PR42691_1_combined := by
  unfold PR42691_1_before PR42691_1_combined
  simp_alive_peephole
  sorry
def PR42691_1_logical_combined := [llvmfunc|
  llvm.func @PR42691_1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483646 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR42691_1_logical   : PR42691_1_logical_before  ⊑  PR42691_1_logical_combined := by
  unfold PR42691_1_logical_before PR42691_1_logical_combined
  simp_alive_peephole
  sorry
def PR42691_2_combined := [llvmfunc|
  llvm.func @PR42691_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR42691_2   : PR42691_2_before  ⊑  PR42691_2_combined := by
  unfold PR42691_2_before PR42691_2_combined
  simp_alive_peephole
  sorry
def PR42691_2_logical_combined := [llvmfunc|
  llvm.func @PR42691_2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR42691_2_logical   : PR42691_2_logical_before  ⊑  PR42691_2_logical_combined := by
  unfold PR42691_2_logical_before PR42691_2_logical_combined
  simp_alive_peephole
  sorry
def PR42691_3_combined := [llvmfunc|
  llvm.func @PR42691_3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR42691_3   : PR42691_3_before  ⊑  PR42691_3_combined := by
  unfold PR42691_3_before PR42691_3_combined
  simp_alive_peephole
  sorry
def PR42691_3_logical_combined := [llvmfunc|
  llvm.func @PR42691_3_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR42691_3_logical   : PR42691_3_logical_before  ⊑  PR42691_3_logical_combined := by
  unfold PR42691_3_logical_before PR42691_3_logical_combined
  simp_alive_peephole
  sorry
def PR42691_4_combined := [llvmfunc|
  llvm.func @PR42691_4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR42691_4   : PR42691_4_before  ⊑  PR42691_4_combined := by
  unfold PR42691_4_before PR42691_4_combined
  simp_alive_peephole
  sorry
def PR42691_4_logical_combined := [llvmfunc|
  llvm.func @PR42691_4_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR42691_4_logical   : PR42691_4_logical_before  ⊑  PR42691_4_logical_combined := by
  unfold PR42691_4_logical_before PR42691_4_logical_combined
  simp_alive_peephole
  sorry
def PR42691_5_combined := [llvmfunc|
  llvm.func @PR42691_5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-2147483646 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR42691_5   : PR42691_5_before  ⊑  PR42691_5_combined := by
  unfold PR42691_5_before PR42691_5_combined
  simp_alive_peephole
  sorry
def PR42691_5_logical_combined := [llvmfunc|
  llvm.func @PR42691_5_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-2147483646 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR42691_5_logical   : PR42691_5_logical_before  ⊑  PR42691_5_logical_combined := by
  unfold PR42691_5_logical_before PR42691_5_logical_combined
  simp_alive_peephole
  sorry
def PR42691_6_combined := [llvmfunc|
  llvm.func @PR42691_6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483646 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR42691_6   : PR42691_6_before  ⊑  PR42691_6_combined := by
  unfold PR42691_6_before PR42691_6_combined
  simp_alive_peephole
  sorry
def PR42691_6_logical_combined := [llvmfunc|
  llvm.func @PR42691_6_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483646 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR42691_6_logical   : PR42691_6_logical_before  ⊑  PR42691_6_logical_combined := by
  unfold PR42691_6_logical_before PR42691_6_logical_combined
  simp_alive_peephole
  sorry
def PR42691_7_combined := [llvmfunc|
  llvm.func @PR42691_7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR42691_7   : PR42691_7_before  ⊑  PR42691_7_combined := by
  unfold PR42691_7_before PR42691_7_combined
  simp_alive_peephole
  sorry
def PR42691_7_logical_combined := [llvmfunc|
  llvm.func @PR42691_7_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR42691_7_logical   : PR42691_7_logical_before  ⊑  PR42691_7_logical_combined := by
  unfold PR42691_7_logical_before PR42691_7_logical_combined
  simp_alive_peephole
  sorry
def PR42691_8_combined := [llvmfunc|
  llvm.func @PR42691_8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-2147483635 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR42691_8   : PR42691_8_before  ⊑  PR42691_8_combined := by
  unfold PR42691_8_before PR42691_8_combined
  simp_alive_peephole
  sorry
def PR42691_8_logical_combined := [llvmfunc|
  llvm.func @PR42691_8_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-2147483635 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR42691_8_logical   : PR42691_8_logical_before  ⊑  PR42691_8_logical_combined := by
  unfold PR42691_8_logical_before PR42691_8_logical_combined
  simp_alive_peephole
  sorry
def PR42691_9_combined := [llvmfunc|
  llvm.func @PR42691_9(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-14 : i32) : i32
    %1 = llvm.mlir.constant(2147483633 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR42691_9   : PR42691_9_before  ⊑  PR42691_9_combined := by
  unfold PR42691_9_before PR42691_9_combined
  simp_alive_peephole
  sorry
def PR42691_9_logical_combined := [llvmfunc|
  llvm.func @PR42691_9_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-14 : i32) : i32
    %1 = llvm.mlir.constant(2147483633 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR42691_9_logical   : PR42691_9_logical_before  ⊑  PR42691_9_logical_combined := by
  unfold PR42691_9_logical_before PR42691_9_logical_combined
  simp_alive_peephole
  sorry
def PR42691_10_combined := [llvmfunc|
  llvm.func @PR42691_10(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-14 : i32) : i32
    %1 = llvm.mlir.constant(-15 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR42691_10   : PR42691_10_before  ⊑  PR42691_10_combined := by
  unfold PR42691_10_before PR42691_10_combined
  simp_alive_peephole
  sorry
def PR42691_10_logical_combined := [llvmfunc|
  llvm.func @PR42691_10_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-14 : i32) : i32
    %1 = llvm.mlir.constant(-15 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR42691_10_logical   : PR42691_10_logical_before  ⊑  PR42691_10_logical_combined := by
  unfold PR42691_10_logical_before PR42691_10_logical_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_eq_eq_combined := [llvmfunc|
  llvm.func @substitute_constant_and_eq_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_and_eq_eq   : substitute_constant_and_eq_eq_before  ⊑  substitute_constant_and_eq_eq_combined := by
  unfold substitute_constant_and_eq_eq_before substitute_constant_and_eq_eq_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_eq_eq_logical_combined := [llvmfunc|
  llvm.func @substitute_constant_and_eq_eq_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_substitute_constant_and_eq_eq_logical   : substitute_constant_and_eq_eq_logical_before  ⊑  substitute_constant_and_eq_eq_logical_combined := by
  unfold substitute_constant_and_eq_eq_logical_before substitute_constant_and_eq_eq_logical_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_eq_eq_commute_combined := [llvmfunc|
  llvm.func @substitute_constant_and_eq_eq_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_and_eq_eq_commute   : substitute_constant_and_eq_eq_commute_before  ⊑  substitute_constant_and_eq_eq_commute_combined := by
  unfold substitute_constant_and_eq_eq_commute_before substitute_constant_and_eq_eq_commute_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_eq_eq_commute_logical_combined := [llvmfunc|
  llvm.func @substitute_constant_and_eq_eq_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_and_eq_eq_commute_logical   : substitute_constant_and_eq_eq_commute_logical_before  ⊑  substitute_constant_and_eq_eq_commute_logical_combined := by
  unfold substitute_constant_and_eq_eq_commute_logical_before substitute_constant_and_eq_eq_commute_logical_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_eq_ugt_swap_combined := [llvmfunc|
  llvm.func @substitute_constant_and_eq_ugt_swap(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "ugt" %arg1, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_and_eq_ugt_swap   : substitute_constant_and_eq_ugt_swap_before  ⊑  substitute_constant_and_eq_ugt_swap_combined := by
  unfold substitute_constant_and_eq_ugt_swap_before substitute_constant_and_eq_ugt_swap_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_eq_ugt_swap_logical_combined := [llvmfunc|
  llvm.func @substitute_constant_and_eq_ugt_swap_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "ugt" %arg1, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_and_eq_ugt_swap_logical   : substitute_constant_and_eq_ugt_swap_logical_before  ⊑  substitute_constant_and_eq_ugt_swap_logical_combined := by
  unfold substitute_constant_and_eq_ugt_swap_logical_before substitute_constant_and_eq_ugt_swap_logical_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_eq_ne_vec_combined := [llvmfunc|
  llvm.func @substitute_constant_and_eq_ne_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, 97]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %2 = llvm.icmp "ne" %arg1, %0 : vector<2xi8>
    %3 = llvm.and %1, %2  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_substitute_constant_and_eq_ne_vec   : substitute_constant_and_eq_ne_vec_before  ⊑  substitute_constant_and_eq_ne_vec_combined := by
  unfold substitute_constant_and_eq_ne_vec_before substitute_constant_and_eq_ne_vec_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_eq_ne_vec_logical_combined := [llvmfunc|
  llvm.func @substitute_constant_and_eq_ne_vec_logical(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, 97]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %4 = llvm.icmp "ne" %arg1, %0 : vector<2xi8>
    %5 = llvm.select %3, %4, %2 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_substitute_constant_and_eq_ne_vec_logical   : substitute_constant_and_eq_ne_vec_logical_before  ⊑  substitute_constant_and_eq_ne_vec_logical_combined := by
  unfold substitute_constant_and_eq_ne_vec_logical_before substitute_constant_and_eq_ne_vec_logical_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_eq_sgt_use_combined := [llvmfunc|
  llvm.func @substitute_constant_and_eq_sgt_use(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.icmp "slt" %arg1, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_and_eq_sgt_use   : substitute_constant_and_eq_sgt_use_before  ⊑  substitute_constant_and_eq_sgt_use_combined := by
  unfold substitute_constant_and_eq_sgt_use_before substitute_constant_and_eq_sgt_use_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_eq_sgt_use_logical_combined := [llvmfunc|
  llvm.func @substitute_constant_and_eq_sgt_use_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.icmp "slt" %arg1, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_and_eq_sgt_use_logical   : substitute_constant_and_eq_sgt_use_logical_before  ⊑  substitute_constant_and_eq_sgt_use_logical_combined := by
  unfold substitute_constant_and_eq_sgt_use_logical_before substitute_constant_and_eq_sgt_use_logical_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_eq_sgt_use2_combined := [llvmfunc|
  llvm.func @substitute_constant_and_eq_sgt_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_and_eq_sgt_use2   : substitute_constant_and_eq_sgt_use2_before  ⊑  substitute_constant_and_eq_sgt_use2_combined := by
  unfold substitute_constant_and_eq_sgt_use2_before substitute_constant_and_eq_sgt_use2_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_eq_sgt_use2_logical_combined := [llvmfunc|
  llvm.func @substitute_constant_and_eq_sgt_use2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_and_eq_sgt_use2_logical   : substitute_constant_and_eq_sgt_use2_logical_before  ⊑  substitute_constant_and_eq_sgt_use2_logical_combined := by
  unfold substitute_constant_and_eq_sgt_use2_logical_before substitute_constant_and_eq_sgt_use2_logical_combined
  simp_alive_peephole
  sorry
def slt_and_max_combined := [llvmfunc|
  llvm.func @slt_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    llvm.call @use(%1) : (i1) -> ()
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_and_max   : slt_and_max_before  ⊑  slt_and_max_combined := by
  unfold slt_and_max_before slt_and_max_combined
  simp_alive_peephole
  sorry
def slt_and_max_logical_combined := [llvmfunc|
  llvm.func @slt_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    llvm.call @use(%1) : (i1) -> ()
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_and_max_logical   : slt_and_max_logical_before  ⊑  slt_and_max_logical_combined := by
  unfold slt_and_max_logical_before slt_and_max_logical_combined
  simp_alive_peephole
  sorry
def sge_and_max_combined := [llvmfunc|
  llvm.func @sge_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_sge_and_max   : sge_and_max_before  ⊑  sge_and_max_combined := by
  unfold sge_and_max_before sge_and_max_combined
  simp_alive_peephole
  sorry
def sge_and_max_logical_combined := [llvmfunc|
  llvm.func @sge_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_sge_and_max_logical   : sge_and_max_logical_before  ⊑  sge_and_max_logical_combined := by
  unfold sge_and_max_logical_before sge_and_max_logical_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_ne_ugt_swap_combined := [llvmfunc|
  llvm.func @substitute_constant_and_ne_ugt_swap(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_and_ne_ugt_swap   : substitute_constant_and_ne_ugt_swap_before  ⊑  substitute_constant_and_ne_ugt_swap_combined := by
  unfold substitute_constant_and_ne_ugt_swap_before substitute_constant_and_ne_ugt_swap_combined
  simp_alive_peephole
  sorry
def substitute_constant_and_ne_ugt_swap_logical_combined := [llvmfunc|
  llvm.func @substitute_constant_and_ne_ugt_swap_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_and_ne_ugt_swap_logical   : substitute_constant_and_ne_ugt_swap_logical_before  ⊑  substitute_constant_and_ne_ugt_swap_logical_combined := by
  unfold substitute_constant_and_ne_ugt_swap_logical_before substitute_constant_and_ne_ugt_swap_logical_combined
  simp_alive_peephole
  sorry
def substitute_constant_or_ne_swap_sle_combined := [llvmfunc|
  llvm.func @substitute_constant_or_ne_swap_sle(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "slt" %arg1, %1 : i8
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_substitute_constant_or_ne_swap_sle   : substitute_constant_or_ne_swap_sle_before  ⊑  substitute_constant_or_ne_swap_sle_combined := by
  unfold substitute_constant_or_ne_swap_sle_before substitute_constant_or_ne_swap_sle_combined
  simp_alive_peephole
  sorry
def substitute_constant_or_ne_swap_sle_logical_combined := [llvmfunc|
  llvm.func @substitute_constant_or_ne_swap_sle_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.icmp "slt" %arg1, %1 : i8
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_substitute_constant_or_ne_swap_sle_logical   : substitute_constant_or_ne_swap_sle_logical_before  ⊑  substitute_constant_or_ne_swap_sle_logical_combined := by
  unfold substitute_constant_or_ne_swap_sle_logical_before substitute_constant_or_ne_swap_sle_logical_combined
  simp_alive_peephole
  sorry
def substitute_constant_or_ne_uge_commute_combined := [llvmfunc|
  llvm.func @substitute_constant_or_ne_uge_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "ult" %arg1, %1 : i8
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_substitute_constant_or_ne_uge_commute   : substitute_constant_or_ne_uge_commute_before  ⊑  substitute_constant_or_ne_uge_commute_combined := by
  unfold substitute_constant_or_ne_uge_commute_before substitute_constant_or_ne_uge_commute_combined
  simp_alive_peephole
  sorry
def substitute_constant_or_ne_uge_commute_logical_combined := [llvmfunc|
  llvm.func @substitute_constant_or_ne_uge_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "ult" %arg1, %1 : i8
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_substitute_constant_or_ne_uge_commute_logical   : substitute_constant_or_ne_uge_commute_logical_before  ⊑  substitute_constant_or_ne_uge_commute_logical_combined := by
  unfold substitute_constant_or_ne_uge_commute_logical_before substitute_constant_or_ne_uge_commute_logical_combined
  simp_alive_peephole
  sorry
def substitute_constant_or_ne_slt_swap_vec_undef_combined := [llvmfunc|
  llvm.func @substitute_constant_or_ne_slt_swap_vec_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "slt" %arg1, %arg0 : vector<2xi8>
    %9 = llvm.or %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

theorem inst_combine_substitute_constant_or_ne_slt_swap_vec_undef   : substitute_constant_or_ne_slt_swap_vec_undef_before  ⊑  substitute_constant_or_ne_slt_swap_vec_undef_combined := by
  unfold substitute_constant_or_ne_slt_swap_vec_undef_before substitute_constant_or_ne_slt_swap_vec_undef_combined
  simp_alive_peephole
  sorry
def substitute_constant_or_ne_slt_swap_vec_poison_combined := [llvmfunc|
  llvm.func @substitute_constant_or_ne_slt_swap_vec_poison(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "slt" %arg1, %arg0 : vector<2xi8>
    %9 = llvm.or %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

theorem inst_combine_substitute_constant_or_ne_slt_swap_vec_poison   : substitute_constant_or_ne_slt_swap_vec_poison_before  ⊑  substitute_constant_or_ne_slt_swap_vec_poison_combined := by
  unfold substitute_constant_or_ne_slt_swap_vec_poison_before substitute_constant_or_ne_slt_swap_vec_poison_combined
  simp_alive_peephole
  sorry
def substitute_constant_or_ne_slt_swap_vec_logical_combined := [llvmfunc|
  llvm.func @substitute_constant_or_ne_slt_swap_vec_logical(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(true) : i1
    %8 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %9 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %10 = llvm.icmp "slt" %arg1, %arg0 : vector<2xi8>
    %11 = llvm.select %9, %8, %10 : vector<2xi1>, vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

theorem inst_combine_substitute_constant_or_ne_slt_swap_vec_logical   : substitute_constant_or_ne_slt_swap_vec_logical_before  ⊑  substitute_constant_or_ne_slt_swap_vec_logical_combined := by
  unfold substitute_constant_or_ne_slt_swap_vec_logical_before substitute_constant_or_ne_slt_swap_vec_logical_combined
  simp_alive_peephole
  sorry
def substitute_constant_or_eq_swap_ne_combined := [llvmfunc|
  llvm.func @substitute_constant_or_eq_swap_ne(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "ne" %arg1, %arg0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_or_eq_swap_ne   : substitute_constant_or_eq_swap_ne_before  ⊑  substitute_constant_or_eq_swap_ne_combined := by
  unfold substitute_constant_or_eq_swap_ne_before substitute_constant_or_eq_swap_ne_combined
  simp_alive_peephole
  sorry
def substitute_constant_or_eq_swap_ne_logical_combined := [llvmfunc|
  llvm.func @substitute_constant_or_eq_swap_ne_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "ne" %arg1, %arg0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_substitute_constant_or_eq_swap_ne_logical   : substitute_constant_or_eq_swap_ne_logical_before  ⊑  substitute_constant_or_eq_swap_ne_logical_combined := by
  unfold substitute_constant_or_eq_swap_ne_logical_before substitute_constant_or_eq_swap_ne_logical_combined
  simp_alive_peephole
  sorry
def substitute_constant_or_ne_sge_use_combined := [llvmfunc|
  llvm.func @substitute_constant_or_ne_sge_use(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg1, %1 : i8
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_substitute_constant_or_ne_sge_use   : substitute_constant_or_ne_sge_use_before  ⊑  substitute_constant_or_ne_sge_use_combined := by
  unfold substitute_constant_or_ne_sge_use_before substitute_constant_or_ne_sge_use_combined
  simp_alive_peephole
  sorry
def substitute_constant_or_ne_sge_use_logical_combined := [llvmfunc|
  llvm.func @substitute_constant_or_ne_sge_use_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(43 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg1, %1 : i8
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_substitute_constant_or_ne_sge_use_logical   : substitute_constant_or_ne_sge_use_logical_before  ⊑  substitute_constant_or_ne_sge_use_logical_combined := by
  unfold substitute_constant_or_ne_sge_use_logical_before substitute_constant_or_ne_sge_use_logical_combined
  simp_alive_peephole
  sorry
def substitute_constant_or_ne_ule_use2_combined := [llvmfunc|
  llvm.func @substitute_constant_or_ne_ule_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_or_ne_ule_use2   : substitute_constant_or_ne_ule_use2_before  ⊑  substitute_constant_or_ne_ule_use2_combined := by
  unfold substitute_constant_or_ne_ule_use2_before substitute_constant_or_ne_ule_use2_combined
  simp_alive_peephole
  sorry
def substitute_constant_or_ne_ule_use2_logical_combined := [llvmfunc|
  llvm.func @substitute_constant_or_ne_ule_use2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_substitute_constant_or_ne_ule_use2_logical   : substitute_constant_or_ne_ule_use2_logical_before  ⊑  substitute_constant_or_ne_ule_use2_logical_combined := by
  unfold substitute_constant_or_ne_ule_use2_logical_before substitute_constant_or_ne_ule_use2_logical_combined
  simp_alive_peephole
  sorry
def or_ranges_overlap_combined := [llvmfunc|
  llvm.func @or_ranges_overlap(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_or_ranges_overlap   : or_ranges_overlap_before  ⊑  or_ranges_overlap_combined := by
  unfold or_ranges_overlap_before or_ranges_overlap_combined
  simp_alive_peephole
  sorry
def or_ranges_adjacent_combined := [llvmfunc|
  llvm.func @or_ranges_adjacent(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_or_ranges_adjacent   : or_ranges_adjacent_before  ⊑  or_ranges_adjacent_combined := by
  unfold or_ranges_adjacent_before or_ranges_adjacent_combined
  simp_alive_peephole
  sorry
def or_ranges_separated_combined := [llvmfunc|
  llvm.func @or_ranges_separated(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.constant(-12 : i8) : i8
    %3 = llvm.mlir.constant(9 : i8) : i8
    %4 = llvm.add %arg0, %0  : i8
    %5 = llvm.icmp "ult" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.icmp "ult" %6, %3 : i8
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_or_ranges_separated   : or_ranges_separated_before  ⊑  or_ranges_separated_combined := by
  unfold or_ranges_separated_before or_ranges_separated_combined
  simp_alive_peephole
  sorry
def or_ranges_single_elem_right_combined := [llvmfunc|
  llvm.func @or_ranges_single_elem_right(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_or_ranges_single_elem_right   : or_ranges_single_elem_right_before  ⊑  or_ranges_single_elem_right_combined := by
  unfold or_ranges_single_elem_right_before or_ranges_single_elem_right_combined
  simp_alive_peephole
  sorry
def or_ranges_single_elem_left_combined := [llvmfunc|
  llvm.func @or_ranges_single_elem_left(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_or_ranges_single_elem_left   : or_ranges_single_elem_left_before  ⊑  or_ranges_single_elem_left_combined := by
  unfold or_ranges_single_elem_left_before or_ranges_single_elem_left_combined
  simp_alive_peephole
  sorry
def and_ranges_overlap_combined := [llvmfunc|
  llvm.func @and_ranges_overlap(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_and_ranges_overlap   : and_ranges_overlap_before  ⊑  and_ranges_overlap_combined := by
  unfold and_ranges_overlap_before and_ranges_overlap_combined
  simp_alive_peephole
  sorry
def and_ranges_overlap_single_combined := [llvmfunc|
  llvm.func @and_ranges_overlap_single(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_and_ranges_overlap_single   : and_ranges_overlap_single_before  ⊑  and_ranges_overlap_single_combined := by
  unfold and_ranges_overlap_single_before and_ranges_overlap_single_combined
  simp_alive_peephole
  sorry
def and_ranges_no_overlap_combined := [llvmfunc|
  llvm.func @and_ranges_no_overlap(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_and_ranges_no_overlap   : and_ranges_no_overlap_before  ⊑  and_ranges_no_overlap_combined := by
  unfold and_ranges_no_overlap_before and_ranges_no_overlap_combined
  simp_alive_peephole
  sorry
def and_ranges_signed_pred_combined := [llvmfunc|
  llvm.func @and_ranges_signed_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-9223372036854775681 : i64) : i64
    %1 = llvm.mlir.constant(-9223372036854775553 : i64) : i64
    %2 = llvm.add %arg0, %0  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_and_ranges_signed_pred   : and_ranges_signed_pred_before  ⊑  and_ranges_signed_pred_combined := by
  unfold and_ranges_signed_pred_before and_ranges_signed_pred_combined
  simp_alive_peephole
  sorry
def and_two_ranges_to_mask_and_range_combined := [llvmfunc|
  llvm.func @and_two_ranges_to_mask_and_range(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-33 : i8) : i8
    %1 = llvm.mlir.constant(-91 : i8) : i8
    %2 = llvm.mlir.constant(-26 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_and_two_ranges_to_mask_and_range   : and_two_ranges_to_mask_and_range_before  ⊑  and_two_ranges_to_mask_and_range_combined := by
  unfold and_two_ranges_to_mask_and_range_before and_two_ranges_to_mask_and_range_combined
  simp_alive_peephole
  sorry
def and_two_ranges_to_mask_and_range_not_pow2_diff_combined := [llvmfunc|
  llvm.func @and_two_ranges_to_mask_and_range_not_pow2_diff(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-123 : i8) : i8
    %1 = llvm.mlir.constant(-26 : i8) : i8
    %2 = llvm.mlir.constant(-90 : i8) : i8
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    %5 = llvm.add %arg0, %2  : i8
    %6 = llvm.icmp "ult" %5, %1 : i8
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_and_two_ranges_to_mask_and_range_not_pow2_diff   : and_two_ranges_to_mask_and_range_not_pow2_diff_before  ⊑  and_two_ranges_to_mask_and_range_not_pow2_diff_combined := by
  unfold and_two_ranges_to_mask_and_range_not_pow2_diff_before and_two_ranges_to_mask_and_range_not_pow2_diff_combined
  simp_alive_peephole
  sorry
def and_two_ranges_to_mask_and_range_different_sizes_combined := [llvmfunc|
  llvm.func @and_two_ranges_to_mask_and_range_different_sizes(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-123 : i8) : i8
    %1 = llvm.mlir.constant(-26 : i8) : i8
    %2 = llvm.mlir.constant(-90 : i8) : i8
    %3 = llvm.mlir.constant(-25 : i8) : i8
    %4 = llvm.add %arg0, %0  : i8
    %5 = llvm.icmp "ult" %4, %1 : i8
    %6 = llvm.add %arg0, %2  : i8
    %7 = llvm.icmp "ult" %6, %3 : i8
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_and_two_ranges_to_mask_and_range_different_sizes   : and_two_ranges_to_mask_and_range_different_sizes_before  ⊑  and_two_ranges_to_mask_and_range_different_sizes_combined := by
  unfold and_two_ranges_to_mask_and_range_different_sizes_before and_two_ranges_to_mask_and_range_different_sizes_combined
  simp_alive_peephole
  sorry
def and_two_ranges_to_mask_and_range_no_add_on_one_range_combined := [llvmfunc|
  llvm.func @and_two_ranges_to_mask_and_range_no_add_on_one_range(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-20 : i16) : i16
    %1 = llvm.mlir.constant(11 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.icmp "ugt" %2, %1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_and_two_ranges_to_mask_and_range_no_add_on_one_range   : and_two_ranges_to_mask_and_range_no_add_on_one_range_before  ⊑  and_two_ranges_to_mask_and_range_no_add_on_one_range_combined := by
  unfold and_two_ranges_to_mask_and_range_no_add_on_one_range_before and_two_ranges_to_mask_and_range_no_add_on_one_range_combined
  simp_alive_peephole
  sorry
def is_ascii_alphabetic_combined := [llvmfunc|
  llvm.func @is_ascii_alphabetic(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(-65 : i32) : i32
    %2 = llvm.mlir.constant(26 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "ult" %4, %2 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_is_ascii_alphabetic   : is_ascii_alphabetic_before  ⊑  is_ascii_alphabetic_combined := by
  unfold is_ascii_alphabetic_before is_ascii_alphabetic_combined
  simp_alive_peephole
  sorry
def is_ascii_alphabetic_inverted_combined := [llvmfunc|
  llvm.func @is_ascii_alphabetic_inverted(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(-91 : i32) : i32
    %2 = llvm.mlir.constant(-26 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "ult" %4, %2 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_is_ascii_alphabetic_inverted   : is_ascii_alphabetic_inverted_before  ⊑  is_ascii_alphabetic_inverted_combined := by
  unfold is_ascii_alphabetic_inverted_before is_ascii_alphabetic_inverted_combined
  simp_alive_peephole
  sorry
def bitwise_and_bitwise_and_icmps_combined := [llvmfunc|
  llvm.func @bitwise_and_bitwise_and_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    %3 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.and %4, %arg0  : i8
    %6 = llvm.icmp "eq" %5, %4 : i8
    %7 = llvm.and %2, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_bitwise_and_bitwise_and_icmps   : bitwise_and_bitwise_and_icmps_before  ⊑  bitwise_and_bitwise_and_icmps_combined := by
  unfold bitwise_and_bitwise_and_icmps_before bitwise_and_bitwise_and_icmps_combined
  simp_alive_peephole
  sorry
def bitwise_and_bitwise_and_icmps_comm1_combined := [llvmfunc|
  llvm.func @bitwise_and_bitwise_and_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    %3 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.and %4, %arg0  : i8
    %6 = llvm.icmp "eq" %5, %4 : i8
    %7 = llvm.and %2, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_bitwise_and_bitwise_and_icmps_comm1   : bitwise_and_bitwise_and_icmps_comm1_before  ⊑  bitwise_and_bitwise_and_icmps_comm1_combined := by
  unfold bitwise_and_bitwise_and_icmps_comm1_before bitwise_and_bitwise_and_icmps_comm1_combined
  simp_alive_peephole
  sorry
def bitwise_and_bitwise_and_icmps_comm2_combined := [llvmfunc|
  llvm.func @bitwise_and_bitwise_and_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    %3 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.and %4, %arg0  : i8
    %6 = llvm.icmp "eq" %5, %4 : i8
    %7 = llvm.and %6, %2  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_bitwise_and_bitwise_and_icmps_comm2   : bitwise_and_bitwise_and_icmps_comm2_before  ⊑  bitwise_and_bitwise_and_icmps_comm2_combined := by
  unfold bitwise_and_bitwise_and_icmps_comm2_before bitwise_and_bitwise_and_icmps_comm2_combined
  simp_alive_peephole
  sorry
def bitwise_and_bitwise_and_icmps_comm3_combined := [llvmfunc|
  llvm.func @bitwise_and_bitwise_and_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    %3 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.and %4, %arg0  : i8
    %6 = llvm.icmp "eq" %5, %4 : i8
    %7 = llvm.and %6, %2  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_bitwise_and_bitwise_and_icmps_comm3   : bitwise_and_bitwise_and_icmps_comm3_before  ⊑  bitwise_and_bitwise_and_icmps_comm3_combined := by
  unfold bitwise_and_bitwise_and_icmps_comm3_before bitwise_and_bitwise_and_icmps_comm3_combined
  simp_alive_peephole
  sorry
def bitwise_and_logical_and_icmps_combined := [llvmfunc|
  llvm.func @bitwise_and_logical_and_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %5 = llvm.or %4, %1  : i8
    %6 = llvm.and %5, %arg0  : i8
    %7 = llvm.icmp "eq" %6, %5 : i8
    %8 = llvm.select %3, %7, %2 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_bitwise_and_logical_and_icmps   : bitwise_and_logical_and_icmps_before  ⊑  bitwise_and_logical_and_icmps_combined := by
  unfold bitwise_and_logical_and_icmps_before bitwise_and_logical_and_icmps_combined
  simp_alive_peephole
  sorry
def bitwise_and_logical_and_icmps_comm1_combined := [llvmfunc|
  llvm.func @bitwise_and_logical_and_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %5 = llvm.or %4, %1  : i8
    %6 = llvm.and %5, %arg0  : i8
    %7 = llvm.icmp "eq" %6, %5 : i8
    %8 = llvm.select %3, %7, %2 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_bitwise_and_logical_and_icmps_comm1   : bitwise_and_logical_and_icmps_comm1_before  ⊑  bitwise_and_logical_and_icmps_comm1_combined := by
  unfold bitwise_and_logical_and_icmps_comm1_before bitwise_and_logical_and_icmps_comm1_combined
  simp_alive_peephole
  sorry
def bitwise_and_logical_and_icmps_comm2_combined := [llvmfunc|
  llvm.func @bitwise_and_logical_and_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %5 = llvm.freeze %4 : i8
    %6 = llvm.or %5, %1  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "eq" %7, %6 : i8
    %9 = llvm.select %8, %3, %2 : i1, i1
    llvm.return %9 : i1
  }]

theorem inst_combine_bitwise_and_logical_and_icmps_comm2   : bitwise_and_logical_and_icmps_comm2_before  ⊑  bitwise_and_logical_and_icmps_comm2_combined := by
  unfold bitwise_and_logical_and_icmps_comm2_before bitwise_and_logical_and_icmps_comm2_combined
  simp_alive_peephole
  sorry
def bitwise_and_logical_and_icmps_comm3_combined := [llvmfunc|
  llvm.func @bitwise_and_logical_and_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %5 = llvm.or %4, %1  : i8
    %6 = llvm.and %5, %arg0  : i8
    %7 = llvm.icmp "eq" %6, %5 : i8
    %8 = llvm.select %7, %3, %2 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_bitwise_and_logical_and_icmps_comm3   : bitwise_and_logical_and_icmps_comm3_before  ⊑  bitwise_and_logical_and_icmps_comm3_combined := by
  unfold bitwise_and_logical_and_icmps_comm3_before bitwise_and_logical_and_icmps_comm3_combined
  simp_alive_peephole
  sorry
def logical_and_bitwise_and_icmps_combined := [llvmfunc|
  llvm.func @logical_and_bitwise_and_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.and %4, %8  : i1
    %11 = llvm.select %10, %9, %3 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_and_bitwise_and_icmps   : logical_and_bitwise_and_icmps_before  ⊑  logical_and_bitwise_and_icmps_combined := by
  unfold logical_and_bitwise_and_icmps_before logical_and_bitwise_and_icmps_combined
  simp_alive_peephole
  sorry
def logical_and_bitwise_and_icmps_comm1_combined := [llvmfunc|
  llvm.func @logical_and_bitwise_and_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.and %4, %8  : i1
    %11 = llvm.select %9, %10, %3 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_and_bitwise_and_icmps_comm1   : logical_and_bitwise_and_icmps_comm1_before  ⊑  logical_and_bitwise_and_icmps_comm1_combined := by
  unfold logical_and_bitwise_and_icmps_comm1_before logical_and_bitwise_and_icmps_comm1_combined
  simp_alive_peephole
  sorry
def logical_and_bitwise_and_icmps_comm2_combined := [llvmfunc|
  llvm.func @logical_and_bitwise_and_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.and %8, %4  : i1
    %11 = llvm.select %10, %9, %3 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_and_bitwise_and_icmps_comm2   : logical_and_bitwise_and_icmps_comm2_before  ⊑  logical_and_bitwise_and_icmps_comm2_combined := by
  unfold logical_and_bitwise_and_icmps_comm2_before logical_and_bitwise_and_icmps_comm2_combined
  simp_alive_peephole
  sorry
def logical_and_bitwise_and_icmps_comm3_combined := [llvmfunc|
  llvm.func @logical_and_bitwise_and_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.and %8, %4  : i1
    %11 = llvm.select %9, %10, %3 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_and_bitwise_and_icmps_comm3   : logical_and_bitwise_and_icmps_comm3_before  ⊑  logical_and_bitwise_and_icmps_comm3_combined := by
  unfold logical_and_bitwise_and_icmps_comm3_before logical_and_bitwise_and_icmps_comm3_combined
  simp_alive_peephole
  sorry
def logical_and_logical_and_icmps_combined := [llvmfunc|
  llvm.func @logical_and_logical_and_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %4, %8, %3 : i1, i1
    %11 = llvm.select %10, %9, %3 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_and_logical_and_icmps   : logical_and_logical_and_icmps_before  ⊑  logical_and_logical_and_icmps_combined := by
  unfold logical_and_logical_and_icmps_before logical_and_logical_and_icmps_combined
  simp_alive_peephole
  sorry
def logical_and_logical_and_icmps_comm1_combined := [llvmfunc|
  llvm.func @logical_and_logical_and_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %9, %4, %3 : i1, i1
    %11 = llvm.select %10, %8, %3 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_and_logical_and_icmps_comm1   : logical_and_logical_and_icmps_comm1_before  ⊑  logical_and_logical_and_icmps_comm1_combined := by
  unfold logical_and_logical_and_icmps_comm1_before logical_and_logical_and_icmps_comm1_combined
  simp_alive_peephole
  sorry
def logical_and_logical_and_icmps_comm2_combined := [llvmfunc|
  llvm.func @logical_and_logical_and_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "ne" %5, %2 : i8
    %9 = llvm.icmp "ne" %7, %2 : i8
    %10 = llvm.select %8, %4, %3 : i1, i1
    %11 = llvm.select %10, %9, %3 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_and_logical_and_icmps_comm2   : logical_and_logical_and_icmps_comm2_before  ⊑  logical_and_logical_and_icmps_comm2_combined := by
  unfold logical_and_logical_and_icmps_comm2_before logical_and_logical_and_icmps_comm2_combined
  simp_alive_peephole
  sorry
def logical_and_logical_and_icmps_comm3_combined := [llvmfunc|
  llvm.func @logical_and_logical_and_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %5 = llvm.or %4, %1  : i8
    %6 = llvm.and %5, %arg0  : i8
    %7 = llvm.icmp "eq" %6, %5 : i8
    %8 = llvm.select %7, %3, %2 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_logical_and_logical_and_icmps_comm3   : logical_and_logical_and_icmps_comm3_before  ⊑  logical_and_logical_and_icmps_comm3_combined := by
  unfold logical_and_logical_and_icmps_comm3_before logical_and_logical_and_icmps_comm3_combined
  simp_alive_peephole
  sorry
def bitwise_or_bitwise_or_icmps_combined := [llvmfunc|
  llvm.func @bitwise_or_bitwise_or_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    %3 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.and %4, %arg0  : i8
    %6 = llvm.icmp "ne" %5, %4 : i8
    %7 = llvm.or %2, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_bitwise_or_bitwise_or_icmps   : bitwise_or_bitwise_or_icmps_before  ⊑  bitwise_or_bitwise_or_icmps_combined := by
  unfold bitwise_or_bitwise_or_icmps_before bitwise_or_bitwise_or_icmps_combined
  simp_alive_peephole
  sorry
def bitwise_or_bitwise_or_icmps_comm1_combined := [llvmfunc|
  llvm.func @bitwise_or_bitwise_or_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    %3 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.and %4, %arg0  : i8
    %6 = llvm.icmp "ne" %5, %4 : i8
    %7 = llvm.or %2, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_bitwise_or_bitwise_or_icmps_comm1   : bitwise_or_bitwise_or_icmps_comm1_before  ⊑  bitwise_or_bitwise_or_icmps_comm1_combined := by
  unfold bitwise_or_bitwise_or_icmps_comm1_before bitwise_or_bitwise_or_icmps_comm1_combined
  simp_alive_peephole
  sorry
def bitwise_or_bitwise_or_icmps_comm2_combined := [llvmfunc|
  llvm.func @bitwise_or_bitwise_or_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    %3 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.and %4, %arg0  : i8
    %6 = llvm.icmp "ne" %5, %4 : i8
    %7 = llvm.or %6, %2  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_bitwise_or_bitwise_or_icmps_comm2   : bitwise_or_bitwise_or_icmps_comm2_before  ⊑  bitwise_or_bitwise_or_icmps_comm2_combined := by
  unfold bitwise_or_bitwise_or_icmps_comm2_before bitwise_or_bitwise_or_icmps_comm2_combined
  simp_alive_peephole
  sorry
def bitwise_or_bitwise_or_icmps_comm3_combined := [llvmfunc|
  llvm.func @bitwise_or_bitwise_or_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    %3 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.and %4, %arg0  : i8
    %6 = llvm.icmp "ne" %5, %4 : i8
    %7 = llvm.or %6, %2  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_bitwise_or_bitwise_or_icmps_comm3   : bitwise_or_bitwise_or_icmps_comm3_before  ⊑  bitwise_or_bitwise_or_icmps_comm3_combined := by
  unfold bitwise_or_bitwise_or_icmps_comm3_before bitwise_or_bitwise_or_icmps_comm3_combined
  simp_alive_peephole
  sorry
def bitwise_or_logical_or_icmps_combined := [llvmfunc|
  llvm.func @bitwise_or_logical_or_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %5 = llvm.or %4, %1  : i8
    %6 = llvm.and %5, %arg0  : i8
    %7 = llvm.icmp "ne" %6, %5 : i8
    %8 = llvm.select %3, %2, %7 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_bitwise_or_logical_or_icmps   : bitwise_or_logical_or_icmps_before  ⊑  bitwise_or_logical_or_icmps_combined := by
  unfold bitwise_or_logical_or_icmps_before bitwise_or_logical_or_icmps_combined
  simp_alive_peephole
  sorry
def bitwise_or_logical_or_icmps_comm1_combined := [llvmfunc|
  llvm.func @bitwise_or_logical_or_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %5 = llvm.or %4, %1  : i8
    %6 = llvm.and %5, %arg0  : i8
    %7 = llvm.icmp "ne" %6, %5 : i8
    %8 = llvm.select %3, %2, %7 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_bitwise_or_logical_or_icmps_comm1   : bitwise_or_logical_or_icmps_comm1_before  ⊑  bitwise_or_logical_or_icmps_comm1_combined := by
  unfold bitwise_or_logical_or_icmps_comm1_before bitwise_or_logical_or_icmps_comm1_combined
  simp_alive_peephole
  sorry
def bitwise_or_logical_or_icmps_comm2_combined := [llvmfunc|
  llvm.func @bitwise_or_logical_or_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %5 = llvm.freeze %4 : i8
    %6 = llvm.or %5, %1  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "ne" %7, %6 : i8
    %9 = llvm.select %8, %2, %3 : i1, i1
    llvm.return %9 : i1
  }]

theorem inst_combine_bitwise_or_logical_or_icmps_comm2   : bitwise_or_logical_or_icmps_comm2_before  ⊑  bitwise_or_logical_or_icmps_comm2_combined := by
  unfold bitwise_or_logical_or_icmps_comm2_before bitwise_or_logical_or_icmps_comm2_combined
  simp_alive_peephole
  sorry
def bitwise_or_logical_or_icmps_comm3_combined := [llvmfunc|
  llvm.func @bitwise_or_logical_or_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %5 = llvm.or %4, %1  : i8
    %6 = llvm.and %5, %arg0  : i8
    %7 = llvm.icmp "ne" %6, %5 : i8
    %8 = llvm.select %7, %2, %3 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_bitwise_or_logical_or_icmps_comm3   : bitwise_or_logical_or_icmps_comm3_before  ⊑  bitwise_or_logical_or_icmps_comm3_combined := by
  unfold bitwise_or_logical_or_icmps_comm3_before bitwise_or_logical_or_icmps_comm3_combined
  simp_alive_peephole
  sorry
def logical_or_bitwise_or_icmps_combined := [llvmfunc|
  llvm.func @logical_or_bitwise_or_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.or %4, %8  : i1
    %11 = llvm.select %10, %3, %9 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_or_bitwise_or_icmps   : logical_or_bitwise_or_icmps_before  ⊑  logical_or_bitwise_or_icmps_combined := by
  unfold logical_or_bitwise_or_icmps_before logical_or_bitwise_or_icmps_combined
  simp_alive_peephole
  sorry
def logical_or_bitwise_or_icmps_comm1_combined := [llvmfunc|
  llvm.func @logical_or_bitwise_or_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.or %4, %8  : i1
    %11 = llvm.select %9, %3, %10 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_or_bitwise_or_icmps_comm1   : logical_or_bitwise_or_icmps_comm1_before  ⊑  logical_or_bitwise_or_icmps_comm1_combined := by
  unfold logical_or_bitwise_or_icmps_comm1_before logical_or_bitwise_or_icmps_comm1_combined
  simp_alive_peephole
  sorry
def logical_or_bitwise_or_icmps_comm2_combined := [llvmfunc|
  llvm.func @logical_or_bitwise_or_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.or %8, %4  : i1
    %11 = llvm.select %10, %3, %9 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_or_bitwise_or_icmps_comm2   : logical_or_bitwise_or_icmps_comm2_before  ⊑  logical_or_bitwise_or_icmps_comm2_combined := by
  unfold logical_or_bitwise_or_icmps_comm2_before logical_or_bitwise_or_icmps_comm2_combined
  simp_alive_peephole
  sorry
def logical_or_bitwise_or_icmps_comm3_combined := [llvmfunc|
  llvm.func @logical_or_bitwise_or_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.or %8, %4  : i1
    %11 = llvm.select %9, %3, %10 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_or_bitwise_or_icmps_comm3   : logical_or_bitwise_or_icmps_comm3_before  ⊑  logical_or_bitwise_or_icmps_comm3_combined := by
  unfold logical_or_bitwise_or_icmps_comm3_before logical_or_bitwise_or_icmps_comm3_combined
  simp_alive_peephole
  sorry
def logical_or_logical_or_icmps_combined := [llvmfunc|
  llvm.func @logical_or_logical_or_icmps(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %4, %3, %8 : i1, i1
    %11 = llvm.select %10, %3, %9 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_or_logical_or_icmps   : logical_or_logical_or_icmps_before  ⊑  logical_or_logical_or_icmps_combined := by
  unfold logical_or_logical_or_icmps_before logical_or_logical_or_icmps_combined
  simp_alive_peephole
  sorry
def logical_or_logical_or_icmps_comm1_combined := [llvmfunc|
  llvm.func @logical_or_logical_or_icmps_comm1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %9, %3, %4 : i1, i1
    %11 = llvm.select %10, %3, %8 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_or_logical_or_icmps_comm1   : logical_or_logical_or_icmps_comm1_before  ⊑  logical_or_logical_or_icmps_comm1_combined := by
  unfold logical_or_logical_or_icmps_comm1_before logical_or_logical_or_icmps_comm1_combined
  simp_alive_peephole
  sorry
def logical_or_logical_or_icmps_comm2_combined := [llvmfunc|
  llvm.func @logical_or_logical_or_icmps_comm2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg1, %0 : i8
    %5 = llvm.and %arg0, %1  : i8
    %6 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %7 = llvm.and %6, %arg0  : i8
    %8 = llvm.icmp "eq" %5, %2 : i8
    %9 = llvm.icmp "eq" %7, %2 : i8
    %10 = llvm.select %8, %3, %4 : i1, i1
    %11 = llvm.select %10, %3, %9 : i1, i1
    llvm.return %11 : i1
  }]

theorem inst_combine_logical_or_logical_or_icmps_comm2   : logical_or_logical_or_icmps_comm2_before  ⊑  logical_or_logical_or_icmps_comm2_combined := by
  unfold logical_or_logical_or_icmps_comm2_before logical_or_logical_or_icmps_comm2_combined
  simp_alive_peephole
  sorry
def logical_or_logical_or_icmps_comm3_combined := [llvmfunc|
  llvm.func @logical_or_logical_or_icmps_comm3(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    %4 = llvm.shl %1, %arg2 overflow<nuw>  : i8
    %5 = llvm.or %4, %1  : i8
    %6 = llvm.and %5, %arg0  : i8
    %7 = llvm.icmp "ne" %6, %5 : i8
    %8 = llvm.select %7, %2, %3 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_logical_or_logical_or_icmps_comm3   : logical_or_logical_or_icmps_comm3_before  ⊑  logical_or_logical_or_icmps_comm3_combined := by
  unfold logical_or_logical_or_icmps_comm3_before logical_or_logical_or_icmps_comm3_combined
  simp_alive_peephole
  sorry
def bitwise_and_logical_and_masked_icmp_asymmetric_combined := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_asymmetric(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.select %3, %arg0, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_bitwise_and_logical_and_masked_icmp_asymmetric   : bitwise_and_logical_and_masked_icmp_asymmetric_before  ⊑  bitwise_and_logical_and_masked_icmp_asymmetric_combined := by
  unfold bitwise_and_logical_and_masked_icmp_asymmetric_before bitwise_and_logical_and_masked_icmp_asymmetric_combined
  simp_alive_peephole
  sorry
def bitwise_and_logical_and_masked_icmp_allzeros_combined := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_allzeros(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.select %4, %arg0, %2 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_bitwise_and_logical_and_masked_icmp_allzeros   : bitwise_and_logical_and_masked_icmp_allzeros_before  ⊑  bitwise_and_logical_and_masked_icmp_allzeros_combined := by
  unfold bitwise_and_logical_and_masked_icmp_allzeros_before bitwise_and_logical_and_masked_icmp_allzeros_combined
  simp_alive_peephole
  sorry
def bitwise_and_logical_and_masked_icmp_allzeros_poison1_combined := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_allzeros_poison1(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.or %arg2, %0  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %arg0, %2 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_bitwise_and_logical_and_masked_icmp_allzeros_poison1   : bitwise_and_logical_and_masked_icmp_allzeros_poison1_before  ⊑  bitwise_and_logical_and_masked_icmp_allzeros_poison1_combined := by
  unfold bitwise_and_logical_and_masked_icmp_allzeros_poison1_before bitwise_and_logical_and_masked_icmp_allzeros_poison1_combined
  simp_alive_peephole
  sorry
def bitwise_and_logical_and_masked_icmp_allzeros_poison2_combined := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_allzeros_poison2(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.select %4, %arg0, %2 : i1, i1
    %6 = llvm.and %arg1, %arg2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_bitwise_and_logical_and_masked_icmp_allzeros_poison2   : bitwise_and_logical_and_masked_icmp_allzeros_poison2_before  ⊑  bitwise_and_logical_and_masked_icmp_allzeros_poison2_combined := by
  unfold bitwise_and_logical_and_masked_icmp_allzeros_poison2_before bitwise_and_logical_and_masked_icmp_allzeros_poison2_combined
  simp_alive_peephole
  sorry
def bitwise_and_logical_and_masked_icmp_allones_combined := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_allones(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.select %3, %arg0, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_bitwise_and_logical_and_masked_icmp_allones   : bitwise_and_logical_and_masked_icmp_allones_before  ⊑  bitwise_and_logical_and_masked_icmp_allones_combined := by
  unfold bitwise_and_logical_and_masked_icmp_allones_before bitwise_and_logical_and_masked_icmp_allones_combined
  simp_alive_peephole
  sorry
def bitwise_and_logical_and_masked_icmp_allones_poison1_combined := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_allones_poison1(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg2, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.select %4, %arg0, %1 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_bitwise_and_logical_and_masked_icmp_allones_poison1   : bitwise_and_logical_and_masked_icmp_allones_poison1_before  ⊑  bitwise_and_logical_and_masked_icmp_allones_poison1_combined := by
  unfold bitwise_and_logical_and_masked_icmp_allones_poison1_before bitwise_and_logical_and_masked_icmp_allones_poison1_combined
  simp_alive_peephole
  sorry
def bitwise_and_logical_and_masked_icmp_allones_poison2_combined := [llvmfunc|
  llvm.func @bitwise_and_logical_and_masked_icmp_allones_poison2(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.select %4, %arg0, %2 : i1, i1
    %6 = llvm.and %arg1, %arg2  : i32
    %7 = llvm.icmp "eq" %6, %arg2 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_bitwise_and_logical_and_masked_icmp_allones_poison2   : bitwise_and_logical_and_masked_icmp_allones_poison2_before  ⊑  bitwise_and_logical_and_masked_icmp_allones_poison2_combined := by
  unfold bitwise_and_logical_and_masked_icmp_allones_poison2_before bitwise_and_logical_and_masked_icmp_allones_poison2_combined
  simp_alive_peephole
  sorry
def samesign_combined := [llvmfunc|
  llvm.func @samesign(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_samesign   : samesign_before  ⊑  samesign_combined := by
  unfold samesign_before samesign_combined
  simp_alive_peephole
  sorry
def samesign_different_sign_bittest1_combined := [llvmfunc|
  llvm.func @samesign_different_sign_bittest1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %arg1  : vector<2xi32>
    %2 = llvm.icmp "sgt" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_samesign_different_sign_bittest1   : samesign_different_sign_bittest1_before  ⊑  samesign_different_sign_bittest1_combined := by
  unfold samesign_different_sign_bittest1_before samesign_different_sign_bittest1_combined
  simp_alive_peephole
  sorry
def samesign_different_sign_bittest2_combined := [llvmfunc|
  llvm.func @samesign_different_sign_bittest2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_samesign_different_sign_bittest2   : samesign_different_sign_bittest2_before  ⊑  samesign_different_sign_bittest2_combined := by
  unfold samesign_different_sign_bittest2_before samesign_different_sign_bittest2_combined
  simp_alive_peephole
  sorry
def samesign_commute1_combined := [llvmfunc|
  llvm.func @samesign_commute1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_samesign_commute1   : samesign_commute1_before  ⊑  samesign_commute1_combined := by
  unfold samesign_commute1_before samesign_commute1_combined
  simp_alive_peephole
  sorry
def samesign_commute2_combined := [llvmfunc|
  llvm.func @samesign_commute2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_samesign_commute2   : samesign_commute2_before  ⊑  samesign_commute2_combined := by
  unfold samesign_commute2_before samesign_commute2_combined
  simp_alive_peephole
  sorry
def samesign_commute3_combined := [llvmfunc|
  llvm.func @samesign_commute3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_samesign_commute3   : samesign_commute3_before  ⊑  samesign_commute3_combined := by
  unfold samesign_commute3_before samesign_commute3_combined
  simp_alive_peephole
  sorry
def samesign_violate_constraint1_combined := [llvmfunc|
  llvm.func @samesign_violate_constraint1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_samesign_violate_constraint1   : samesign_violate_constraint1_before  ⊑  samesign_violate_constraint1_combined := by
  unfold samesign_violate_constraint1_before samesign_violate_constraint1_combined
  simp_alive_peephole
  sorry
def samesign_violate_constraint2_combined := [llvmfunc|
  llvm.func @samesign_violate_constraint2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_samesign_violate_constraint2   : samesign_violate_constraint2_before  ⊑  samesign_violate_constraint2_combined := by
  unfold samesign_violate_constraint2_before samesign_violate_constraint2_combined
  simp_alive_peephole
  sorry
def samesign_mult_use_combined := [llvmfunc|
  llvm.func @samesign_mult_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.or %arg0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.xor %arg0, %arg1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_samesign_mult_use   : samesign_mult_use_before  ⊑  samesign_mult_use_combined := by
  unfold samesign_mult_use_before samesign_mult_use_combined
  simp_alive_peephole
  sorry
def samesign_mult_use2_combined := [llvmfunc|
  llvm.func @samesign_mult_use2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.xor %arg0, %arg1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_samesign_mult_use2   : samesign_mult_use2_before  ⊑  samesign_mult_use2_combined := by
  unfold samesign_mult_use2_before samesign_mult_use2_combined
  simp_alive_peephole
  sorry
def samesign_mult_use3_combined := [llvmfunc|
  llvm.func @samesign_mult_use3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_samesign_mult_use3   : samesign_mult_use3_before  ⊑  samesign_mult_use3_combined := by
  unfold samesign_mult_use3_before samesign_mult_use3_combined
  simp_alive_peephole
  sorry
def samesign_wrong_cmp_combined := [llvmfunc|
  llvm.func @samesign_wrong_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_samesign_wrong_cmp   : samesign_wrong_cmp_before  ⊑  samesign_wrong_cmp_combined := by
  unfold samesign_wrong_cmp_before samesign_wrong_cmp_combined
  simp_alive_peephole
  sorry
def samesign_inverted_combined := [llvmfunc|
  llvm.func @samesign_inverted(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_samesign_inverted   : samesign_inverted_before  ⊑  samesign_inverted_combined := by
  unfold samesign_inverted_before samesign_inverted_combined
  simp_alive_peephole
  sorry
def samesign_inverted_different_sign_bittest1_combined := [llvmfunc|
  llvm.func @samesign_inverted_different_sign_bittest1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_samesign_inverted_different_sign_bittest1   : samesign_inverted_different_sign_bittest1_before  ⊑  samesign_inverted_different_sign_bittest1_combined := by
  unfold samesign_inverted_different_sign_bittest1_before samesign_inverted_different_sign_bittest1_combined
  simp_alive_peephole
  sorry
def samesign_inverted_different_sign_bittest2_combined := [llvmfunc|
  llvm.func @samesign_inverted_different_sign_bittest2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_samesign_inverted_different_sign_bittest2   : samesign_inverted_different_sign_bittest2_before  ⊑  samesign_inverted_different_sign_bittest2_combined := by
  unfold samesign_inverted_different_sign_bittest2_before samesign_inverted_different_sign_bittest2_combined
  simp_alive_peephole
  sorry
def samesign_inverted_commute1_combined := [llvmfunc|
  llvm.func @samesign_inverted_commute1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_samesign_inverted_commute1   : samesign_inverted_commute1_before  ⊑  samesign_inverted_commute1_combined := by
  unfold samesign_inverted_commute1_before samesign_inverted_commute1_combined
  simp_alive_peephole
  sorry
def samesign_inverted_commute2_combined := [llvmfunc|
  llvm.func @samesign_inverted_commute2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_samesign_inverted_commute2   : samesign_inverted_commute2_before  ⊑  samesign_inverted_commute2_combined := by
  unfold samesign_inverted_commute2_before samesign_inverted_commute2_combined
  simp_alive_peephole
  sorry
def samesign_inverted_commute3_combined := [llvmfunc|
  llvm.func @samesign_inverted_commute3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_samesign_inverted_commute3   : samesign_inverted_commute3_before  ⊑  samesign_inverted_commute3_combined := by
  unfold samesign_inverted_commute3_before samesign_inverted_commute3_combined
  simp_alive_peephole
  sorry
def samesign_inverted_violate_constraint1_combined := [llvmfunc|
  llvm.func @samesign_inverted_violate_constraint1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.and %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_samesign_inverted_violate_constraint1   : samesign_inverted_violate_constraint1_before  ⊑  samesign_inverted_violate_constraint1_combined := by
  unfold samesign_inverted_violate_constraint1_before samesign_inverted_violate_constraint1_combined
  simp_alive_peephole
  sorry
def samesign_inverted_violate_constraint2_combined := [llvmfunc|
  llvm.func @samesign_inverted_violate_constraint2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_samesign_inverted_violate_constraint2   : samesign_inverted_violate_constraint2_before  ⊑  samesign_inverted_violate_constraint2_combined := by
  unfold samesign_inverted_violate_constraint2_before samesign_inverted_violate_constraint2_combined
  simp_alive_peephole
  sorry
def samesign_inverted_mult_use_combined := [llvmfunc|
  llvm.func @samesign_inverted_mult_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.or %arg0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.xor %arg0, %arg1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_samesign_inverted_mult_use   : samesign_inverted_mult_use_before  ⊑  samesign_inverted_mult_use_combined := by
  unfold samesign_inverted_mult_use_before samesign_inverted_mult_use_combined
  simp_alive_peephole
  sorry
def samesign_inverted_mult_use2_combined := [llvmfunc|
  llvm.func @samesign_inverted_mult_use2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_samesign_inverted_mult_use2   : samesign_inverted_mult_use2_before  ⊑  samesign_inverted_mult_use2_combined := by
  unfold samesign_inverted_mult_use2_before samesign_inverted_mult_use2_combined
  simp_alive_peephole
  sorry
def samesign_inverted_wrong_cmp_combined := [llvmfunc|
  llvm.func @samesign_inverted_wrong_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_samesign_inverted_wrong_cmp   : samesign_inverted_wrong_cmp_before  ⊑  samesign_inverted_wrong_cmp_combined := by
  unfold samesign_inverted_wrong_cmp_before samesign_inverted_wrong_cmp_combined
  simp_alive_peephole
  sorry
def icmp_eq_m1_and_eq_m1_combined := [llvmfunc|
  llvm.func @icmp_eq_m1_and_eq_m1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_m1_and_eq_m1   : icmp_eq_m1_and_eq_m1_before  ⊑  icmp_eq_m1_and_eq_m1_combined := by
  unfold icmp_eq_m1_and_eq_m1_before icmp_eq_m1_and_eq_m1_combined
  simp_alive_peephole
  sorry
def icmp_eq_m1_and_eq_poison_m1_combined := [llvmfunc|
  llvm.func @icmp_eq_m1_and_eq_poison_m1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_m1_and_eq_poison_m1   : icmp_eq_m1_and_eq_poison_m1_before  ⊑  icmp_eq_m1_and_eq_poison_m1_combined := by
  unfold icmp_eq_m1_and_eq_poison_m1_before icmp_eq_m1_and_eq_poison_m1_combined
  simp_alive_peephole
  sorry
def icmp_eq_poison_and_eq_m1_m2_combined := [llvmfunc|
  llvm.func @icmp_eq_poison_and_eq_m1_m2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_poison_and_eq_m1_m2   : icmp_eq_poison_and_eq_m1_m2_before  ⊑  icmp_eq_poison_and_eq_m1_m2_combined := by
  unfold icmp_eq_poison_and_eq_m1_m2_before icmp_eq_poison_and_eq_m1_m2_combined
  simp_alive_peephole
  sorry
def icmp_ne_m1_and_ne_m1_fail_combined := [llvmfunc|
  llvm.func @icmp_ne_m1_and_ne_m1_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "ne" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "ne" %arg1, %6 : vector<2xi8>
    %9 = llvm.and %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

theorem inst_combine_icmp_ne_m1_and_ne_m1_fail   : icmp_ne_m1_and_ne_m1_fail_before  ⊑  icmp_ne_m1_and_ne_m1_fail_combined := by
  unfold icmp_ne_m1_and_ne_m1_fail_before icmp_ne_m1_and_ne_m1_fail_combined
  simp_alive_peephole
  sorry
def icmp_eq_m1_or_eq_m1_fail_combined := [llvmfunc|
  llvm.func @icmp_eq_m1_or_eq_m1_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi8>
    %8 = llvm.icmp "eq" %arg1, %6 : vector<2xi8>
    %9 = llvm.or %7, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_m1_or_eq_m1_fail   : icmp_eq_m1_or_eq_m1_fail_before  ⊑  icmp_eq_m1_or_eq_m1_fail_combined := by
  unfold icmp_eq_m1_or_eq_m1_fail_before icmp_eq_m1_or_eq_m1_fail_combined
  simp_alive_peephole
  sorry
def icmp_ne_m1_or_ne_m1_combined := [llvmfunc|
  llvm.func @icmp_ne_m1_or_ne_m1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_icmp_ne_m1_or_ne_m1   : icmp_ne_m1_or_ne_m1_before  ⊑  icmp_ne_m1_or_ne_m1_combined := by
  unfold icmp_ne_m1_or_ne_m1_before icmp_ne_m1_or_ne_m1_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_sgt_0_i32_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_slt_0_or_icmp_sgt_0_i32   : icmp_slt_0_or_icmp_sgt_0_i32_before  ⊑  icmp_slt_0_or_icmp_sgt_0_i32_combined := by
  unfold icmp_slt_0_or_icmp_sgt_0_i32_before icmp_slt_0_or_icmp_sgt_0_i32_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_sgt_0_i64_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_icmp_slt_0_or_icmp_sgt_0_i64   : icmp_slt_0_or_icmp_sgt_0_i64_before  ⊑  icmp_slt_0_or_icmp_sgt_0_i64_combined := by
  unfold icmp_slt_0_or_icmp_sgt_0_i64_before icmp_slt_0_or_icmp_sgt_0_i64_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_sgt_0_i64_fail0_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64_fail0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_icmp_slt_0_or_icmp_sgt_0_i64_fail0   : icmp_slt_0_or_icmp_sgt_0_i64_fail0_before  ⊑  icmp_slt_0_or_icmp_sgt_0_i64_fail0_combined := by
  unfold icmp_slt_0_or_icmp_sgt_0_i64_fail0_before icmp_slt_0_or_icmp_sgt_0_i64_fail0_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_sgt_0_i64_fail1_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64_fail1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.ashr %arg0, %1  : i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %3, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_icmp_slt_0_or_icmp_sgt_0_i64_fail1   : icmp_slt_0_or_icmp_sgt_0_i64_fail1_before  ⊑  icmp_slt_0_or_icmp_sgt_0_i64_fail1_combined := by
  unfold icmp_slt_0_or_icmp_sgt_0_i64_fail1_before icmp_slt_0_or_icmp_sgt_0_i64_fail1_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_sgt_0_i64_fail2_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64_fail2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(62 : i64) : i64
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.zext %2 : i1 to i64
    %5 = llvm.or %3, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_icmp_slt_0_or_icmp_sgt_0_i64_fail2   : icmp_slt_0_or_icmp_sgt_0_i64_fail2_before  ⊑  icmp_slt_0_or_icmp_sgt_0_i64_fail2_combined := by
  unfold icmp_slt_0_or_icmp_sgt_0_i64_fail2_before icmp_slt_0_or_icmp_sgt_0_i64_fail2_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_sgt_0_i64_fail3_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64_fail3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(62 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.lshr %arg0, %1  : i64
    %4 = llvm.or %2, %3  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_icmp_slt_0_or_icmp_sgt_0_i64_fail3   : icmp_slt_0_or_icmp_sgt_0_i64_fail3_before  ⊑  icmp_slt_0_or_icmp_sgt_0_i64_fail3_combined := by
  unfold icmp_slt_0_or_icmp_sgt_0_i64_fail3_before icmp_slt_0_or_icmp_sgt_0_i64_fail3_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_sgt_0_i64x2_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64x2(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi64>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_icmp_slt_0_or_icmp_sgt_0_i64x2   : icmp_slt_0_or_icmp_sgt_0_i64x2_before  ⊑  icmp_slt_0_or_icmp_sgt_0_i64x2_combined := by
  unfold icmp_slt_0_or_icmp_sgt_0_i64x2_before icmp_slt_0_or_icmp_sgt_0_i64x2_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_sgt_0_i64x2_fail_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sgt_0_i64x2_fail(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi64>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_icmp_slt_0_or_icmp_sgt_0_i64x2_fail   : icmp_slt_0_or_icmp_sgt_0_i64x2_fail_before  ⊑  icmp_slt_0_or_icmp_sgt_0_i64x2_fail_combined := by
  unfold icmp_slt_0_or_icmp_sgt_0_i64x2_fail_before icmp_slt_0_or_icmp_sgt_0_i64x2_fail_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_and_icmp_sge_neg1_i32_combined := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_icmp_slt_0_and_icmp_sge_neg1_i32   : icmp_slt_0_and_icmp_sge_neg1_i32_before  ⊑  icmp_slt_0_and_icmp_sge_neg1_i32_combined := by
  unfold icmp_slt_0_and_icmp_sge_neg1_i32_before icmp_slt_0_and_icmp_sge_neg1_i32_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_sge_neg1_i32_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sge_neg1_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_icmp_slt_0_or_icmp_sge_neg1_i32   : icmp_slt_0_or_icmp_sge_neg1_i32_before  ⊑  icmp_slt_0_or_icmp_sge_neg1_i32_combined := by
  unfold icmp_slt_0_or_icmp_sge_neg1_i32_before icmp_slt_0_or_icmp_sge_neg1_i32_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_sge_100_i32_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_sge_100_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(99 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_slt_0_or_icmp_sge_100_i32   : icmp_slt_0_or_icmp_sge_100_i32_before  ⊑  icmp_slt_0_or_icmp_sge_100_i32_combined := by
  unfold icmp_slt_0_or_icmp_sge_100_i32_before icmp_slt_0_or_icmp_sge_100_i32_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_and_icmp_sge_neg1_i64_combined := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_icmp_slt_0_and_icmp_sge_neg1_i64   : icmp_slt_0_and_icmp_sge_neg1_i64_before  ⊑  icmp_slt_0_and_icmp_sge_neg1_i64_combined := by
  unfold icmp_slt_0_and_icmp_sge_neg1_i64_before icmp_slt_0_and_icmp_sge_neg1_i64_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_and_icmp_sge_neg2_i64_combined := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-3 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_icmp_slt_0_and_icmp_sge_neg2_i64   : icmp_slt_0_and_icmp_sge_neg2_i64_before  ⊑  icmp_slt_0_and_icmp_sge_neg2_i64_combined := by
  unfold icmp_slt_0_and_icmp_sge_neg2_i64_before icmp_slt_0_and_icmp_sge_neg2_i64_combined
  simp_alive_peephole
  sorry
def ashr_and_icmp_sge_neg1_i64_combined := [llvmfunc|
  llvm.func @ashr_and_icmp_sge_neg1_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    %2 = llvm.zext %1 : i1 to i64
    llvm.return %2 : i64
  }]

theorem inst_combine_ashr_and_icmp_sge_neg1_i64   : ashr_and_icmp_sge_neg1_i64_before  ⊑  ashr_and_icmp_sge_neg1_i64_combined := by
  unfold ashr_and_icmp_sge_neg1_i64_before ashr_and_icmp_sge_neg1_i64_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_and_icmp_sgt_neg1_i64_combined := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sgt_neg1_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_icmp_slt_0_and_icmp_sgt_neg1_i64   : icmp_slt_0_and_icmp_sgt_neg1_i64_before  ⊑  icmp_slt_0_and_icmp_sgt_neg1_i64_combined := by
  unfold icmp_slt_0_and_icmp_sgt_neg1_i64_before icmp_slt_0_and_icmp_sgt_neg1_i64_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_and_icmp_sge_neg1_i64_fail_combined := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i64_fail(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-2 : i64) : i64
    %1 = llvm.mlir.constant(62 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.icmp "sgt" %arg0, %0 : i64
    %5 = llvm.lshr %arg0, %1  : i64
    %6 = llvm.and %5, %2  : i64
    %7 = llvm.select %4, %6, %3 : i1, i64
    llvm.return %7 : i64
  }]

theorem inst_combine_icmp_slt_0_and_icmp_sge_neg1_i64_fail   : icmp_slt_0_and_icmp_sge_neg1_i64_fail_before  ⊑  icmp_slt_0_and_icmp_sge_neg1_i64_fail_combined := by
  unfold icmp_slt_0_and_icmp_sge_neg1_i64_fail_before icmp_slt_0_and_icmp_sge_neg1_i64_fail_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_and_icmp_sge_neg1_i32x2_combined := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i32x2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_slt_0_and_icmp_sge_neg1_i32x2   : icmp_slt_0_and_icmp_sge_neg1_i32x2_before  ⊑  icmp_slt_0_and_icmp_sge_neg1_i32x2_combined := by
  unfold icmp_slt_0_and_icmp_sge_neg1_i32x2_before icmp_slt_0_and_icmp_sge_neg1_i32x2_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_and_icmp_sge_neg2_i32x2_combined := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i32x2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_slt_0_and_icmp_sge_neg2_i32x2   : icmp_slt_0_and_icmp_sge_neg2_i32x2_before  ⊑  icmp_slt_0_and_icmp_sge_neg2_i32x2_combined := by
  unfold icmp_slt_0_and_icmp_sge_neg2_i32x2_before icmp_slt_0_and_icmp_sge_neg2_i32x2_combined
  simp_alive_peephole
  sorry
def icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_combined := [llvmfunc|
  llvm.func @icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32   : icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_before  ⊑  icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_combined := by
  unfold icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_before icmp_x_slt_0_xor_icmp_y_sgt_neg1_i32_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_xor_icmp_sgt_neg2_i32_combined := [llvmfunc|
  llvm.func @icmp_slt_0_xor_icmp_sgt_neg2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_slt_0_xor_icmp_sgt_neg2_i32   : icmp_slt_0_xor_icmp_sgt_neg2_i32_before  ⊑  icmp_slt_0_xor_icmp_sgt_neg2_i32_combined := by
  unfold icmp_slt_0_xor_icmp_sgt_neg2_i32_before icmp_slt_0_xor_icmp_sgt_neg2_i32_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_and_icmp_sge_neg1_i32_multiuse0_combined := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg1_i32_multiuse0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.call @use(%1) : (i1) -> ()
    llvm.return %3 : i32
  }]

theorem inst_combine_icmp_slt_0_and_icmp_sge_neg1_i32_multiuse0   : icmp_slt_0_and_icmp_sge_neg1_i32_multiuse0_before  ⊑  icmp_slt_0_and_icmp_sge_neg1_i32_multiuse0_combined := by
  unfold icmp_slt_0_and_icmp_sge_neg1_i32_multiuse0_before icmp_slt_0_and_icmp_sge_neg1_i32_multiuse0_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_and_icmp_sge_neg2_i32_multiuse1_combined := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i32_multiuse1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_icmp_slt_0_and_icmp_sge_neg2_i32_multiuse1   : icmp_slt_0_and_icmp_sge_neg2_i32_multiuse1_before  ⊑  icmp_slt_0_and_icmp_sge_neg2_i32_multiuse1_combined := by
  unfold icmp_slt_0_and_icmp_sge_neg2_i32_multiuse1_before icmp_slt_0_and_icmp_sge_neg2_i32_multiuse1_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_and_icmp_sge_neg2_i32_multiuse2_combined := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i32_multiuse2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_icmp_slt_0_and_icmp_sge_neg2_i32_multiuse2   : icmp_slt_0_and_icmp_sge_neg2_i32_multiuse2_before  ⊑  icmp_slt_0_and_icmp_sge_neg2_i32_multiuse2_combined := by
  unfold icmp_slt_0_and_icmp_sge_neg2_i32_multiuse2_before icmp_slt_0_and_icmp_sge_neg2_i32_multiuse2_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_and_icmp_sge_neg2_i32_multiuse_fail0_combined := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_sge_neg2_i32_multiuse_fail0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_icmp_slt_0_and_icmp_sge_neg2_i32_multiuse_fail0   : icmp_slt_0_and_icmp_sge_neg2_i32_multiuse_fail0_before  ⊑  icmp_slt_0_and_icmp_sge_neg2_i32_multiuse_fail0_combined := by
  unfold icmp_slt_0_and_icmp_sge_neg2_i32_multiuse_fail0_before icmp_slt_0_and_icmp_sge_neg2_i32_multiuse_fail0_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail1_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail1   : icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail1_before  ⊑  icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail1_combined := by
  unfold icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail1_before icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail1_combined
  simp_alive_peephole
  sorry
def icmp_x_slt_0_and_icmp_y_ne_neg2_i32_multiuse_fail2_combined := [llvmfunc|
  llvm.func @icmp_x_slt_0_and_icmp_y_ne_neg2_i32_multiuse_fail2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.lshr %arg1, %1  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_icmp_x_slt_0_and_icmp_y_ne_neg2_i32_multiuse_fail2   : icmp_x_slt_0_and_icmp_y_ne_neg2_i32_multiuse_fail2_before  ⊑  icmp_x_slt_0_and_icmp_y_ne_neg2_i32_multiuse_fail2_combined := by
  unfold icmp_x_slt_0_and_icmp_y_ne_neg2_i32_multiuse_fail2_before icmp_x_slt_0_and_icmp_y_ne_neg2_i32_multiuse_fail2_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail3_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail3   : icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail3_before  ⊑  icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail3_combined := by
  unfold icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail3_before icmp_slt_0_or_icmp_eq_100_i32_multiuse_fail3_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_eq_100_i32_fail_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_eq_100_i32_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.or %3, %2  : i1
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_icmp_slt_0_or_icmp_eq_100_i32_fail   : icmp_slt_0_or_icmp_eq_100_i32_fail_before  ⊑  icmp_slt_0_or_icmp_eq_100_i32_fail_combined := by
  unfold icmp_slt_0_or_icmp_eq_100_i32_fail_before icmp_slt_0_or_icmp_eq_100_i32_fail_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_and_icmp_ne_neg2_i32_fail_combined := [llvmfunc|
  llvm.func @icmp_slt_0_and_icmp_ne_neg2_i32_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.and %3, %2  : i1
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_icmp_slt_0_and_icmp_ne_neg2_i32_fail   : icmp_slt_0_and_icmp_ne_neg2_i32_fail_before  ⊑  icmp_slt_0_and_icmp_ne_neg2_i32_fail_combined := by
  unfold icmp_slt_0_and_icmp_ne_neg2_i32_fail_before icmp_slt_0_and_icmp_ne_neg2_i32_fail_combined
  simp_alive_peephole
  sorry
def icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_combined := [llvmfunc|
  llvm.func @icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg1, %1 : i32
    %4 = llvm.and %3, %2  : i1
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail   : icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_before  ⊑  icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_combined := by
  unfold icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_before icmp_x_slt_0_and_icmp_y_ne_neg2_i32_fail_combined
  simp_alive_peephole
  sorry
def icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_combined := [llvmfunc|
  llvm.func @icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg1, %1 : i32
    %4 = llvm.and %3, %2  : i1
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail   : icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_before  ⊑  icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_combined := by
  unfold icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_before icmp_x_slt_0_and_icmp_y_sgt_neg1_i32_fail_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_xor_icmp_sge_neg2_i32_fail_combined := [llvmfunc|
  llvm.func @icmp_slt_0_xor_icmp_sge_neg2_i32_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_slt_0_xor_icmp_sge_neg2_i32_fail   : icmp_slt_0_xor_icmp_sge_neg2_i32_fail_before  ⊑  icmp_slt_0_xor_icmp_sge_neg2_i32_fail_combined := by
  unfold icmp_slt_0_xor_icmp_sge_neg2_i32_fail_before icmp_slt_0_xor_icmp_sge_neg2_i32_fail_combined
  simp_alive_peephole
  sorry
def icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_combined := [llvmfunc|
  llvm.func @icmp_slt_0_or_icmp_add_1_sge_100_i32_fail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(99 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.icmp "slt" %arg0, %2 : i32
    %6 = llvm.or %5, %4  : i1
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_icmp_slt_0_or_icmp_add_1_sge_100_i32_fail   : icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_before  ⊑  icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_combined := by
  unfold icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_before icmp_slt_0_or_icmp_add_1_sge_100_i32_fail_combined
  simp_alive_peephole
  sorry
def logical_and_icmps1_combined := [llvmfunc|
  llvm.func @logical_and_icmps1(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(10086 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %arg1, %3, %1 : i1, i1
    %5 = llvm.icmp "slt" %arg0, %2 : i32
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_logical_and_icmps1   : logical_and_icmps1_before  ⊑  logical_and_icmps1_combined := by
  unfold logical_and_icmps1_before logical_and_icmps1_combined
  simp_alive_peephole
  sorry
def logical_and_icmps2_combined := [llvmfunc|
  llvm.func @logical_and_icmps2(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(10086 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %arg1, %3, %1 : i1, i1
    %5 = llvm.icmp "eq" %arg0, %2 : i32
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_logical_and_icmps2   : logical_and_icmps2_before  ⊑  logical_and_icmps2_combined := by
  unfold logical_and_icmps2_before logical_and_icmps2_combined
  simp_alive_peephole
  sorry
def logical_and_icmps_vec1_combined := [llvmfunc|
  llvm.func @logical_and_icmps_vec1(%arg0: vector<4xi32>, %arg1: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %3 = llvm.mlir.constant(dense<10086> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.icmp "sgt" %arg0, %0 : vector<4xi32>
    %5 = llvm.select %arg1, %4, %2 : vector<4xi1>, vector<4xi1>
    %6 = llvm.icmp "slt" %arg0, %3 : vector<4xi32>
    %7 = llvm.select %5, %6, %2 : vector<4xi1>, vector<4xi1>
    llvm.return %7 : vector<4xi1>
  }]

theorem inst_combine_logical_and_icmps_vec1   : logical_and_icmps_vec1_before  ⊑  logical_and_icmps_vec1_combined := by
  unfold logical_and_icmps_vec1_before logical_and_icmps_vec1_combined
  simp_alive_peephole
  sorry
def logical_and_icmps_fail1_combined := [llvmfunc|
  llvm.func @logical_and_icmps_fail1(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %arg2, %2, %1 : i1, i1
    %4 = llvm.icmp "slt" %arg0, %arg1 : i32
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_logical_and_icmps_fail1   : logical_and_icmps_fail1_before  ⊑  logical_and_icmps_fail1_combined := by
  unfold logical_and_icmps_fail1_before logical_and_icmps_fail1_combined
  simp_alive_peephole
  sorry
