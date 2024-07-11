import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  conditional-variable-length-signext-after-high-bit-extract
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_notrunc_add_before := [llvmfunc|
  llvm.func @t0_notrunc_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

def t0_notrunc_or_before := [llvmfunc|
  llvm.func @t0_notrunc_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.or %4, %7  : i32
    llvm.return %8 : i32
  }]

def t1_notrunc_sub_before := [llvmfunc|
  llvm.func @t1_notrunc_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.sub %4, %7  : i32
    llvm.return %8 : i32
  }]

def t2_trunc_add_before := [llvmfunc|
  llvm.func @t2_trunc_add(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    %11 = llvm.add %10, %7  : i32
    llvm.return %11 : i32
  }]

def t2_trunc_or_before := [llvmfunc|
  llvm.func @t2_trunc_or(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    %11 = llvm.or %10, %7  : i32
    llvm.return %11 : i32
  }]

def t3_trunc_sub_before := [llvmfunc|
  llvm.func @t3_trunc_sub(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    %11 = llvm.sub %7, %10  : i32
    llvm.return %11 : i32
  }]

def t4_commutativity0_before := [llvmfunc|
  llvm.func @t4_commutativity0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

def t5_commutativity1_before := [llvmfunc|
  llvm.func @t5_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "sgt" %arg0, %1 : i32
    %6 = llvm.shl %1, %arg1  : i32
    %7 = llvm.select %5, %2, %6 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

def t6_commutativity2_before := [llvmfunc|
  llvm.func @t6_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %7, %4  : i32
    llvm.return %8 : i32
  }]

def t7_trunc_extrause0_before := [llvmfunc|
  llvm.func @t7_trunc_extrause0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    %11 = llvm.add %10, %7  : i32
    llvm.return %11 : i32
  }]

def t8_trunc_extrause1_before := [llvmfunc|
  llvm.func @t8_trunc_extrause1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.add %10, %7  : i32
    llvm.return %11 : i32
  }]

def n9_trunc_extrause2_before := [llvmfunc|
  llvm.func @n9_trunc_extrause2(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.add %10, %7  : i32
    llvm.return %11 : i32
  }]

def t10_preserve_exact_before := [llvmfunc|
  llvm.func @t10_preserve_exact(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

def t11_different_zext_of_shamt_before := [llvmfunc|
  llvm.func @t11_different_zext_of_shamt(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.zext %arg1 : i8 to i16
    %4 = llvm.sub %0, %3  : i16
    %5 = llvm.zext %4 : i16 to i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i32
    %9 = llvm.shl %2, %8  : i32
    %10 = llvm.select %7, %9, %1 : i1, i32
    llvm.call @use16(%3) : (i16) -> ()
    llvm.call @use16(%4) : (i16) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.add %6, %10  : i32
    llvm.return %11 : i32
  }]

def t12_add_sext_of_magic_before := [llvmfunc|
  llvm.func @t12_add_sext_of_magic(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i16
    %9 = llvm.shl %2, %8  : i16
    %10 = llvm.select %7, %9, %3 : i1, i16
    %11 = llvm.sext %10 : i16 to i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use16(%10) : (i16) -> ()
    llvm.call @use32(%11) : (i32) -> ()
    %12 = llvm.add %6, %11  : i32
    llvm.return %12 : i32
  }]

def t13_sub_zext_of_magic_before := [llvmfunc|
  llvm.func @t13_sub_zext_of_magic(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i16
    %9 = llvm.shl %2, %8  : i16
    %10 = llvm.select %7, %9, %3 : i1, i16
    %11 = llvm.zext %10 : i16 to i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use16(%10) : (i16) -> ()
    llvm.call @use32(%11) : (i32) -> ()
    %12 = llvm.sub %6, %11  : i32
    llvm.return %12 : i32
  }]

def t14_add_sext_of_shl_before := [llvmfunc|
  llvm.func @t14_add_sext_of_shl(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.sub %0, %3  : i32
    %5 = llvm.lshr %arg0, %4  : i32
    %6 = llvm.icmp "slt" %arg0, %1 : i32
    %7 = llvm.zext %arg1 : i8 to i16
    %8 = llvm.shl %2, %7  : i16
    %9 = llvm.sext %8 : i16 to i32
    %10 = llvm.select %6, %9, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use1(%6) : (i1) -> ()
    llvm.call @use16(%7) : (i16) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.add %5, %10  : i32
    llvm.return %11 : i32
  }]

def t15_sub_zext_of_shl_before := [llvmfunc|
  llvm.func @t15_sub_zext_of_shl(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.sub %0, %3  : i32
    %5 = llvm.lshr %arg0, %4  : i32
    %6 = llvm.icmp "slt" %arg0, %1 : i32
    %7 = llvm.zext %arg1 : i8 to i16
    %8 = llvm.shl %2, %7  : i16
    %9 = llvm.zext %8 : i16 to i32
    %10 = llvm.select %6, %9, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use1(%6) : (i1) -> ()
    llvm.call @use16(%7) : (i16) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.sub %5, %10  : i32
    llvm.return %11 : i32
  }]

def n16_before := [llvmfunc|
  llvm.func @n16(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

def n17_add_before := [llvmfunc|
  llvm.func @n17_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

def n18_before := [llvmfunc|
  llvm.func @n18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %1, %6 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

def n19_before := [llvmfunc|
  llvm.func @n19(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg1, %1 : i32
    %6 = llvm.shl %2, %arg2  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

def n20_before := [llvmfunc|
  llvm.func @n20(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg2  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

def n21_before := [llvmfunc|
  llvm.func @n21(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "sgt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

def n22_before := [llvmfunc|
  llvm.func @n22(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.add %10, %7  : i32
    llvm.return %11 : i32
  }]

def n23_before := [llvmfunc|
  llvm.func @n23(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.ashr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

def n24_before := [llvmfunc|
  llvm.func @n24(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.sub %7, %4  : i32
    llvm.return %8 : i32
  }]

def n25_sub_before := [llvmfunc|
  llvm.func @n25_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.sub %4, %7  : i32
    llvm.return %8 : i32
  }]

def n26_before := [llvmfunc|
  llvm.func @n26(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

def n27_add_zext_of_magic_before := [llvmfunc|
  llvm.func @n27_add_zext_of_magic(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i16
    %9 = llvm.shl %2, %8  : i16
    %10 = llvm.select %7, %9, %3 : i1, i16
    %11 = llvm.zext %10 : i16 to i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use16(%10) : (i16) -> ()
    llvm.call @use32(%11) : (i32) -> ()
    %12 = llvm.add %6, %11  : i32
    llvm.return %12 : i32
  }]

def n28_sub_sext_of_magic_before := [llvmfunc|
  llvm.func @n28_sub_sext_of_magic(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i16
    %9 = llvm.shl %2, %8  : i16
    %10 = llvm.select %7, %9, %3 : i1, i16
    %11 = llvm.sext %10 : i16 to i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use16(%10) : (i16) -> ()
    llvm.call @use32(%11) : (i32) -> ()
    %12 = llvm.sub %6, %11  : i32
    llvm.return %12 : i32
  }]

def n290_or_with_wrong_magic_before := [llvmfunc|
  llvm.func @n290_or_with_wrong_magic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.or %4, %7  : i32
    llvm.return %8 : i32
  }]

def t0_notrunc_add_combined := [llvmfunc|
  llvm.func @t0_notrunc_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.ashr %arg0, %3  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t0_notrunc_add   : t0_notrunc_add_before  ⊑  t0_notrunc_add_combined := by
  unfold t0_notrunc_add_before t0_notrunc_add_combined
  simp_alive_peephole
  sorry
def t0_notrunc_or_combined := [llvmfunc|
  llvm.func @t0_notrunc_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.ashr %arg0, %3  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t0_notrunc_or   : t0_notrunc_or_before  ⊑  t0_notrunc_or_combined := by
  unfold t0_notrunc_or_before t0_notrunc_or_combined
  simp_alive_peephole
  sorry
def t1_notrunc_sub_combined := [llvmfunc|
  llvm.func @t1_notrunc_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nuw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.ashr %arg0, %3  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t1_notrunc_sub   : t1_notrunc_sub_before  ⊑  t1_notrunc_sub_combined := by
  unfold t1_notrunc_sub_before t1_notrunc_sub_combined
  simp_alive_peephole
  sorry
def t2_trunc_add_combined := [llvmfunc|
  llvm.func @t2_trunc_add(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.icmp "slt" %arg0, %1 : i64
    %8 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.ashr %arg0, %4  : i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.return %10 : i32
  }]

theorem inst_combine_t2_trunc_add   : t2_trunc_add_before  ⊑  t2_trunc_add_combined := by
  unfold t2_trunc_add_before t2_trunc_add_combined
  simp_alive_peephole
  sorry
def t2_trunc_or_combined := [llvmfunc|
  llvm.func @t2_trunc_or(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.icmp "slt" %arg0, %1 : i64
    %8 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.ashr %arg0, %4  : i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.return %10 : i32
  }]

theorem inst_combine_t2_trunc_or   : t2_trunc_or_before  ⊑  t2_trunc_or_combined := by
  unfold t2_trunc_or_before t2_trunc_or_combined
  simp_alive_peephole
  sorry
def t3_trunc_sub_combined := [llvmfunc|
  llvm.func @t3_trunc_sub(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.icmp "slt" %arg0, %1 : i64
    %8 = llvm.shl %2, %arg1 overflow<nuw>  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.ashr %arg0, %4  : i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.return %10 : i32
  }]

theorem inst_combine_t3_trunc_sub   : t3_trunc_sub_before  ⊑  t3_trunc_sub_combined := by
  unfold t3_trunc_sub_before t3_trunc_sub_combined
  simp_alive_peephole
  sorry
def t4_commutativity0_combined := [llvmfunc|
  llvm.func @t4_commutativity0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.ashr %arg0, %3  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t4_commutativity0   : t4_commutativity0_before  ⊑  t4_commutativity0_combined := by
  unfold t4_commutativity0_before t4_commutativity0_combined
  simp_alive_peephole
  sorry
def t5_commutativity1_combined := [llvmfunc|
  llvm.func @t5_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "sgt" %arg0, %1 : i32
    %6 = llvm.shl %1, %arg1 overflow<nsw>  : i32
    %7 = llvm.select %5, %2, %6 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.ashr %arg0, %3  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t5_commutativity1   : t5_commutativity1_before  ⊑  t5_commutativity1_combined := by
  unfold t5_commutativity1_before t5_commutativity1_combined
  simp_alive_peephole
  sorry
def t6_commutativity2_combined := [llvmfunc|
  llvm.func @t6_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.ashr %arg0, %3  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t6_commutativity2   : t6_commutativity2_before  ⊑  t6_commutativity2_combined := by
  unfold t6_commutativity2_before t6_commutativity2_combined
  simp_alive_peephole
  sorry
def t7_trunc_extrause0_combined := [llvmfunc|
  llvm.func @t7_trunc_extrause0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.icmp "slt" %arg0, %1 : i64
    %8 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.ashr %arg0, %4  : i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.return %10 : i32
  }]

theorem inst_combine_t7_trunc_extrause0   : t7_trunc_extrause0_before  ⊑  t7_trunc_extrause0_combined := by
  unfold t7_trunc_extrause0_before t7_trunc_extrause0_combined
  simp_alive_peephole
  sorry
def t8_trunc_extrause1_combined := [llvmfunc|
  llvm.func @t8_trunc_extrause1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.icmp "slt" %arg0, %1 : i64
    %8 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %9 = llvm.select %7, %8, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.ashr %arg0, %5  : i64
    %11 = llvm.trunc %10 : i64 to i32
    llvm.return %11 : i32
  }]

theorem inst_combine_t8_trunc_extrause1   : t8_trunc_extrause1_before  ⊑  t8_trunc_extrause1_combined := by
  unfold t8_trunc_extrause1_before t8_trunc_extrause1_combined
  simp_alive_peephole
  sorry
def n9_trunc_extrause2_combined := [llvmfunc|
  llvm.func @n9_trunc_extrause2(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.add %10, %7  : i32
    llvm.return %11 : i32
  }]

theorem inst_combine_n9_trunc_extrause2   : n9_trunc_extrause2_before  ⊑  n9_trunc_extrause2_combined := by
  unfold n9_trunc_extrause2_before n9_trunc_extrause2_combined
  simp_alive_peephole
  sorry
def t10_preserve_exact_combined := [llvmfunc|
  llvm.func @t10_preserve_exact(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.ashr %arg0, %3  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t10_preserve_exact   : t10_preserve_exact_before  ⊑  t10_preserve_exact_combined := by
  unfold t10_preserve_exact_before t10_preserve_exact_combined
  simp_alive_peephole
  sorry
def t11_different_zext_of_shamt_combined := [llvmfunc|
  llvm.func @t11_different_zext_of_shamt(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.zext %arg1 : i8 to i16
    %4 = llvm.sub %0, %3 overflow<nsw>  : i16
    %5 = llvm.zext %4 : i16 to i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i32
    %9 = llvm.shl %2, %8 overflow<nsw>  : i32
    %10 = llvm.select %7, %9, %1 : i1, i32
    llvm.call @use16(%3) : (i16) -> ()
    llvm.call @use16(%4) : (i16) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use32(%8) : (i32) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.ashr %arg0, %5  : i32
    llvm.return %11 : i32
  }]

theorem inst_combine_t11_different_zext_of_shamt   : t11_different_zext_of_shamt_before  ⊑  t11_different_zext_of_shamt_combined := by
  unfold t11_different_zext_of_shamt_before t11_different_zext_of_shamt_combined
  simp_alive_peephole
  sorry
def t12_add_sext_of_magic_combined := [llvmfunc|
  llvm.func @t12_add_sext_of_magic(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.sub %0, %4 overflow<nsw>  : i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i16
    %9 = llvm.shl %2, %8 overflow<nsw>  : i16
    %10 = llvm.select %7, %9, %3 : i1, i16
    %11 = llvm.sext %10 : i16 to i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use16(%10) : (i16) -> ()
    llvm.call @use32(%11) : (i32) -> ()
    %12 = llvm.ashr %arg0, %5  : i32
    llvm.return %12 : i32
  }]

theorem inst_combine_t12_add_sext_of_magic   : t12_add_sext_of_magic_before  ⊑  t12_add_sext_of_magic_combined := by
  unfold t12_add_sext_of_magic_before t12_add_sext_of_magic_combined
  simp_alive_peephole
  sorry
def t13_sub_zext_of_magic_combined := [llvmfunc|
  llvm.func @t13_sub_zext_of_magic(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.sub %0, %4 overflow<nsw>  : i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i16
    %9 = llvm.shl %2, %8 overflow<nuw>  : i16
    %10 = llvm.select %7, %9, %3 : i1, i16
    %11 = llvm.zext %10 : i16 to i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use16(%10) : (i16) -> ()
    llvm.call @use32(%11) : (i32) -> ()
    %12 = llvm.ashr %arg0, %5  : i32
    llvm.return %12 : i32
  }]

theorem inst_combine_t13_sub_zext_of_magic   : t13_sub_zext_of_magic_before  ⊑  t13_sub_zext_of_magic_combined := by
  unfold t13_sub_zext_of_magic_before t13_sub_zext_of_magic_combined
  simp_alive_peephole
  sorry
def t14_add_sext_of_shl_combined := [llvmfunc|
  llvm.func @t14_add_sext_of_shl(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.sub %0, %3 overflow<nsw>  : i32
    %5 = llvm.lshr %arg0, %4  : i32
    %6 = llvm.icmp "slt" %arg0, %1 : i32
    %7 = llvm.zext %arg1 : i8 to i16
    %8 = llvm.shl %2, %7 overflow<nsw>  : i16
    %9 = llvm.sext %8 : i16 to i32
    %10 = llvm.select %6, %9, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use1(%6) : (i1) -> ()
    llvm.call @use16(%7) : (i16) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.ashr %arg0, %4  : i32
    llvm.return %11 : i32
  }]

theorem inst_combine_t14_add_sext_of_shl   : t14_add_sext_of_shl_before  ⊑  t14_add_sext_of_shl_combined := by
  unfold t14_add_sext_of_shl_before t14_add_sext_of_shl_combined
  simp_alive_peephole
  sorry
def t15_sub_zext_of_shl_combined := [llvmfunc|
  llvm.func @t15_sub_zext_of_shl(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.sub %0, %3 overflow<nsw>  : i32
    %5 = llvm.lshr %arg0, %4  : i32
    %6 = llvm.icmp "slt" %arg0, %1 : i32
    %7 = llvm.zext %arg1 : i8 to i16
    %8 = llvm.shl %2, %7 overflow<nuw>  : i16
    %9 = llvm.zext %8 : i16 to i32
    %10 = llvm.select %6, %9, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use1(%6) : (i1) -> ()
    llvm.call @use16(%7) : (i16) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.ashr %arg0, %4  : i32
    llvm.return %11 : i32
  }]

theorem inst_combine_t15_sub_zext_of_shl   : t15_sub_zext_of_shl_before  ⊑  t15_sub_zext_of_shl_combined := by
  unfold t15_sub_zext_of_shl_before t15_sub_zext_of_shl_combined
  simp_alive_peephole
  sorry
def n16_combined := [llvmfunc|
  llvm.func @n16(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n16   : n16_before  ⊑  n16_combined := by
  unfold n16_before n16_combined
  simp_alive_peephole
  sorry
def n17_add_combined := [llvmfunc|
  llvm.func @n17_add(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nuw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n17_add   : n17_add_before  ⊑  n17_add_combined := by
  unfold n17_add_before n17_add_combined
  simp_alive_peephole
  sorry
def n18_combined := [llvmfunc|
  llvm.func @n18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %7 = llvm.select %5, %1, %6 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n18   : n18_before  ⊑  n18_combined := by
  unfold n18_before n18_combined
  simp_alive_peephole
  sorry
def n19_combined := [llvmfunc|
  llvm.func @n19(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg1, %1 : i32
    %6 = llvm.shl %2, %arg2 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n19   : n19_before  ⊑  n19_combined := by
  unfold n19_before n19_combined
  simp_alive_peephole
  sorry
def n20_combined := [llvmfunc|
  llvm.func @n20(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg2 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n20   : n20_before  ⊑  n20_combined := by
  unfold n20_before n20_combined
  simp_alive_peephole
  sorry
def n21_combined := [llvmfunc|
  llvm.func @n21(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "sgt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n21   : n21_before  ⊑  n21_combined := by
  unfold n21_before n21_combined
  simp_alive_peephole
  sorry
def n22_combined := [llvmfunc|
  llvm.func @n22(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %arg0, %1 : i64
    %9 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %10 = llvm.select %8, %9, %3 : i1, i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    llvm.call @use1(%8) : (i1) -> ()
    llvm.call @use32(%9) : (i32) -> ()
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.add %10, %7  : i32
    llvm.return %11 : i32
  }]

theorem inst_combine_n22   : n22_before  ⊑  n22_combined := by
  unfold n22_before n22_combined
  simp_alive_peephole
  sorry
def n23_combined := [llvmfunc|
  llvm.func @n23(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.ashr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n23   : n23_before  ⊑  n23_combined := by
  unfold n23_before n23_combined
  simp_alive_peephole
  sorry
def n24_combined := [llvmfunc|
  llvm.func @n24(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nuw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.sub %7, %4  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n24   : n24_before  ⊑  n24_combined := by
  unfold n24_before n24_combined
  simp_alive_peephole
  sorry
def n25_sub_combined := [llvmfunc|
  llvm.func @n25_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.sub %4, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n25_sub   : n25_sub_before  ⊑  n25_sub_combined := by
  unfold n25_sub_before n25_sub_combined
  simp_alive_peephole
  sorry
def n26_combined := [llvmfunc|
  llvm.func @n26(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.add %4, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n26   : n26_before  ⊑  n26_combined := by
  unfold n26_before n26_combined
  simp_alive_peephole
  sorry
def n27_add_zext_of_magic_combined := [llvmfunc|
  llvm.func @n27_add_zext_of_magic(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.sub %0, %4 overflow<nsw>  : i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i16
    %9 = llvm.shl %2, %8 overflow<nsw>  : i16
    %10 = llvm.select %7, %9, %3 : i1, i16
    %11 = llvm.zext %10 : i16 to i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use16(%10) : (i16) -> ()
    llvm.call @use32(%11) : (i32) -> ()
    %12 = llvm.add %6, %11  : i32
    llvm.return %12 : i32
  }]

theorem inst_combine_n27_add_zext_of_magic   : n27_add_zext_of_magic_before  ⊑  n27_add_zext_of_magic_combined := by
  unfold n27_add_zext_of_magic_before n27_add_zext_of_magic_combined
  simp_alive_peephole
  sorry
def n28_sub_sext_of_magic_combined := [llvmfunc|
  llvm.func @n28_sub_sext_of_magic(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.sub %0, %4 overflow<nsw>  : i32
    %6 = llvm.lshr %arg0, %5  : i32
    %7 = llvm.icmp "slt" %arg0, %1 : i32
    %8 = llvm.zext %arg1 : i8 to i16
    %9 = llvm.shl %2, %8 overflow<nuw>  : i16
    %10 = llvm.select %7, %9, %3 : i1, i16
    %11 = llvm.sext %10 : i16 to i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use1(%7) : (i1) -> ()
    llvm.call @use16(%8) : (i16) -> ()
    llvm.call @use16(%9) : (i16) -> ()
    llvm.call @use16(%10) : (i16) -> ()
    llvm.call @use32(%11) : (i32) -> ()
    %12 = llvm.sub %6, %11  : i32
    llvm.return %12 : i32
  }]

theorem inst_combine_n28_sub_sext_of_magic   : n28_sub_sext_of_magic_before  ⊑  n28_sub_sext_of_magic_combined := by
  unfold n28_sub_sext_of_magic_before n28_sub_sext_of_magic_combined
  simp_alive_peephole
  sorry
def n290_or_with_wrong_magic_combined := [llvmfunc|
  llvm.func @n290_or_with_wrong_magic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.shl %2, %arg1 overflow<nuw>  : i32
    %7 = llvm.select %5, %6, %1 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use1(%5) : (i1) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.or %4, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n290_or_with_wrong_magic   : n290_or_with_wrong_magic_before  ⊑  n290_or_with_wrong_magic_combined := by
  unfold n290_or_with_wrong_magic_before n290_or_with_wrong_magic_combined
  simp_alive_peephole
  sorry
