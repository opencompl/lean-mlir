import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  result-of-usub-is-non-zero-and-no-overflow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_noncanonical_ignoreme_before := [llvmfunc|
  llvm.func @t0_noncanonical_ignoreme(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %1, %arg0 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }]

def t0_noncanonical_ignoreme_logical_before := [llvmfunc|
  llvm.func @t0_noncanonical_ignoreme_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ule" %2, %arg0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }]

def t1_logical_before := [llvmfunc|
  llvm.func @t1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }]

def t1_strict_before := [llvmfunc|
  llvm.func @t1_strict(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }]

def t1_strict_logical_before := [llvmfunc|
  llvm.func @t1_strict_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%2) : (!llvm.struct<(i8, i1)>) -> ()
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %0  : i1
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.icmp "ne" %3, %1 : i8
    %7 = llvm.and %6, %5  : i1
    llvm.return %7 : i1
  }]

def t2_logical_before := [llvmfunc|
  llvm.func @t2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%3) : (!llvm.struct<(i8, i1)>) -> ()
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.xor %5, %0  : i1
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.icmp "ne" %4, %1 : i8
    %8 = llvm.select %7, %6, %2 : i1, i1
    llvm.return %8 : i1
  }]

def t3_commutability0_before := [llvmfunc|
  llvm.func @t3_commutability0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }]

def t3_commutability0_logical_before := [llvmfunc|
  llvm.func @t3_commutability0_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }]

def t4_commutability1_before := [llvmfunc|
  llvm.func @t4_commutability1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def t4_commutability1_logical_before := [llvmfunc|
  llvm.func @t4_commutability1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }]

def t5_commutability2_before := [llvmfunc|
  llvm.func @t5_commutability2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def t5_commutability2_logical_before := [llvmfunc|
  llvm.func @t5_commutability2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }]

def t6_commutability_before := [llvmfunc|
  llvm.func @t6_commutability(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%2) : (!llvm.struct<(i8, i1)>) -> ()
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %0  : i1
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.icmp "ne" %3, %1 : i8
    %7 = llvm.and %5, %6  : i1
    llvm.return %7 : i1
  }]

def t6_commutability_logical_before := [llvmfunc|
  llvm.func @t6_commutability_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%3) : (!llvm.struct<(i8, i1)>) -> ()
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.xor %5, %0  : i1
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.icmp "ne" %4, %1 : i8
    %8 = llvm.select %6, %7, %2 : i1, i1
    llvm.return %8 : i1
  }]

def t7_before := [llvmfunc|
  llvm.func @t7(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }]

def t7_logical_before := [llvmfunc|
  llvm.func @t7_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %1, %3 : i1, i1
    llvm.return %5 : i1
  }]

def t7_nonstrict_before := [llvmfunc|
  llvm.func @t7_nonstrict(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }]

def t7_nonstrict_logical_before := [llvmfunc|
  llvm.func @t7_nonstrict_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %1, %3 : i1, i1
    llvm.return %5 : i1
  }]

def t8_before := [llvmfunc|
  llvm.func @t8(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%1) : (!llvm.struct<(i8, i1)>) -> ()
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i8
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def t8_logical_before := [llvmfunc|
  llvm.func @t8_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%2) : (!llvm.struct<(i8, i1)>) -> ()
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "eq" %3, %0 : i8
    %6 = llvm.select %5, %1, %4 : i1, i1
    llvm.return %6 : i1
  }]

def t9_commutative_before := [llvmfunc|
  llvm.func @t9_commutative(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ult" %arg0, %1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }]

def t9_commutative_logical_before := [llvmfunc|
  llvm.func @t9_commutative_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %arg0, %2 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %1, %3 : i1, i1
    llvm.return %5 : i1
  }]

def t10_before := [llvmfunc|
  llvm.func @t10(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %2 = llvm.sub %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def t10_logical_before := [llvmfunc|
  llvm.func @t10_logical(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %3 = llvm.sub %arg0, %2  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.icmp "ult" %3, %arg0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "ne" %3, %0 : i64
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %5, %4, %1 : i1, i1
    llvm.return %6 : i1
  }]

def t11_commutative_before := [llvmfunc|
  llvm.func @t11_commutative(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %2 = llvm.sub %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.icmp "ugt" %arg0, %2 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def t11_commutative_logical_before := [llvmfunc|
  llvm.func @t11_commutative_logical(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %3 = llvm.sub %arg0, %2  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.icmp "ugt" %arg0, %3 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "ne" %3, %0 : i64
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %5, %4, %1 : i1, i1
    llvm.return %6 : i1
  }]

def t12_before := [llvmfunc|
  llvm.func @t12(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %2 = llvm.sub %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.icmp "uge" %2, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def t12_logical_before := [llvmfunc|
  llvm.func @t12_logical(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %3 = llvm.sub %arg0, %2  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.icmp "uge" %3, %arg0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "eq" %3, %0 : i64
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %5, %1, %4 : i1, i1
    llvm.return %6 : i1
  }]

def t13_before := [llvmfunc|
  llvm.func @t13(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %2 = llvm.sub %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.icmp "ule" %arg0, %2 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def t13_logical_before := [llvmfunc|
  llvm.func @t13_logical(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %3 = llvm.sub %arg0, %2  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.icmp "ule" %arg0, %3 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "eq" %3, %0 : i64
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %5, %1, %4 : i1, i1
    llvm.return %6 : i1
  }]

def t14_bad_before := [llvmfunc|
  llvm.func @t14_bad(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.icmp "ult" %1, %arg0 : i64
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %1, %0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }]

def t14_bad_logical_before := [llvmfunc|
  llvm.func @t14_bad_logical(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %2, %0 : i64
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }]

def base_ult_offset_before := [llvmfunc|
  llvm.func @base_ult_offset(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.icmp "ule" %arg0, %arg1 : i8
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }]

def base_ult_offset_logical_before := [llvmfunc|
  llvm.func @base_ult_offset_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ule" %arg0, %arg1 : i8
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }]

def base_uge_offset_before := [llvmfunc|
  llvm.func @base_uge_offset(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i8
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }]

def base_uge_offset_logical_before := [llvmfunc|
  llvm.func @base_uge_offset_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %0 : i8
    %4 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %5 = llvm.select %4, %1, %3 : i1, i1
    llvm.return %5 : i1
  }]

def t0_noncanonical_ignoreme_combined := [llvmfunc|
  llvm.func @t0_noncanonical_ignoreme(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ult" %arg1, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t0_noncanonical_ignoreme   : t0_noncanonical_ignoreme_before  ⊑  t0_noncanonical_ignoreme_combined := by
  unfold t0_noncanonical_ignoreme_before t0_noncanonical_ignoreme_combined
  simp_alive_peephole
  sorry
def t0_noncanonical_ignoreme_logical_combined := [llvmfunc|
  llvm.func @t0_noncanonical_ignoreme_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ult" %arg1, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t0_noncanonical_ignoreme_logical   : t0_noncanonical_ignoreme_logical_before  ⊑  t0_noncanonical_ignoreme_logical_combined := by
  unfold t0_noncanonical_ignoreme_logical_before t0_noncanonical_ignoreme_logical_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t1_logical_combined := [llvmfunc|
  llvm.func @t1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t1_logical   : t1_logical_before  ⊑  t1_logical_combined := by
  unfold t1_logical_before t1_logical_combined
  simp_alive_peephole
  sorry
def t1_strict_combined := [llvmfunc|
  llvm.func @t1_strict(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_t1_strict   : t1_strict_before  ⊑  t1_strict_combined := by
  unfold t1_strict_before t1_strict_combined
  simp_alive_peephole
  sorry
def t1_strict_logical_combined := [llvmfunc|
  llvm.func @t1_strict_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_t1_strict_logical   : t1_strict_logical_before  ⊑  t1_strict_logical_combined := by
  unfold t1_strict_logical_before t1_strict_logical_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%2) : (!llvm.struct<(i8, i1)>) -> ()
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %0  : i1
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.icmp "ne" %3, %1 : i8
    %7 = llvm.and %6, %5  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def t2_logical_combined := [llvmfunc|
  llvm.func @t2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%2) : (!llvm.struct<(i8, i1)>) -> ()
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %0  : i1
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.icmp "ne" %3, %1 : i8
    %7 = llvm.and %6, %5  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_t2_logical   : t2_logical_before  ⊑  t2_logical_combined := by
  unfold t2_logical_before t2_logical_combined
  simp_alive_peephole
  sorry
def t3_commutability0_combined := [llvmfunc|
  llvm.func @t3_commutability0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ult" %arg1, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t3_commutability0   : t3_commutability0_before  ⊑  t3_commutability0_combined := by
  unfold t3_commutability0_before t3_commutability0_combined
  simp_alive_peephole
  sorry
def t3_commutability0_logical_combined := [llvmfunc|
  llvm.func @t3_commutability0_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ult" %arg1, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t3_commutability0_logical   : t3_commutability0_logical_before  ⊑  t3_commutability0_logical_combined := by
  unfold t3_commutability0_logical_before t3_commutability0_logical_combined
  simp_alive_peephole
  sorry
def t4_commutability1_combined := [llvmfunc|
  llvm.func @t4_commutability1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t4_commutability1   : t4_commutability1_before  ⊑  t4_commutability1_combined := by
  unfold t4_commutability1_before t4_commutability1_combined
  simp_alive_peephole
  sorry
def t4_commutability1_logical_combined := [llvmfunc|
  llvm.func @t4_commutability1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t4_commutability1_logical   : t4_commutability1_logical_before  ⊑  t4_commutability1_logical_combined := by
  unfold t4_commutability1_logical_before t4_commutability1_logical_combined
  simp_alive_peephole
  sorry
def t5_commutability2_combined := [llvmfunc|
  llvm.func @t5_commutability2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t5_commutability2   : t5_commutability2_before  ⊑  t5_commutability2_combined := by
  unfold t5_commutability2_before t5_commutability2_combined
  simp_alive_peephole
  sorry
def t5_commutability2_logical_combined := [llvmfunc|
  llvm.func @t5_commutability2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t5_commutability2_logical   : t5_commutability2_logical_before  ⊑  t5_commutability2_logical_combined := by
  unfold t5_commutability2_logical_before t5_commutability2_logical_combined
  simp_alive_peephole
  sorry
def t6_commutability_combined := [llvmfunc|
  llvm.func @t6_commutability(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%2) : (!llvm.struct<(i8, i1)>) -> ()
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %0  : i1
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.icmp "ne" %3, %1 : i8
    %7 = llvm.and %6, %5  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_t6_commutability   : t6_commutability_before  ⊑  t6_commutability_combined := by
  unfold t6_commutability_before t6_commutability_combined
  simp_alive_peephole
  sorry
def t6_commutability_logical_combined := [llvmfunc|
  llvm.func @t6_commutability_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%2) : (!llvm.struct<(i8, i1)>) -> ()
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %0  : i1
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.icmp "ne" %3, %1 : i8
    %7 = llvm.and %6, %5  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_t6_commutability_logical   : t6_commutability_logical_before  ⊑  t6_commutability_logical_combined := by
  unfold t6_commutability_logical_before t6_commutability_logical_combined
  simp_alive_peephole
  sorry
def t7_combined := [llvmfunc|
  llvm.func @t7(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t7   : t7_before  ⊑  t7_combined := by
  unfold t7_before t7_combined
  simp_alive_peephole
  sorry
def t7_logical_combined := [llvmfunc|
  llvm.func @t7_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t7_logical   : t7_logical_before  ⊑  t7_logical_combined := by
  unfold t7_logical_before t7_logical_combined
  simp_alive_peephole
  sorry
def t7_nonstrict_combined := [llvmfunc|
  llvm.func @t7_nonstrict(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_t7_nonstrict   : t7_nonstrict_before  ⊑  t7_nonstrict_combined := by
  unfold t7_nonstrict_before t7_nonstrict_combined
  simp_alive_peephole
  sorry
def t7_nonstrict_logical_combined := [llvmfunc|
  llvm.func @t7_nonstrict_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_t7_nonstrict_logical   : t7_nonstrict_logical_before  ⊑  t7_nonstrict_logical_combined := by
  unfold t7_nonstrict_logical_before t7_nonstrict_logical_combined
  simp_alive_peephole
  sorry
def t8_combined := [llvmfunc|
  llvm.func @t8(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%1) : (!llvm.struct<(i8, i1)>) -> ()
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i8
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_t8   : t8_before  ⊑  t8_combined := by
  unfold t8_before t8_combined
  simp_alive_peephole
  sorry
def t8_logical_combined := [llvmfunc|
  llvm.func @t8_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.call @useagg(%1) : (!llvm.struct<(i8, i1)>) -> ()
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %2, %0 : i8
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_t8_logical   : t8_logical_before  ⊑  t8_logical_combined := by
  unfold t8_logical_before t8_logical_combined
  simp_alive_peephole
  sorry
def t9_commutative_combined := [llvmfunc|
  llvm.func @t9_commutative(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "uge" %arg1, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t9_commutative   : t9_commutative_before  ⊑  t9_commutative_combined := by
  unfold t9_commutative_before t9_commutative_combined
  simp_alive_peephole
  sorry
def t9_commutative_logical_combined := [llvmfunc|
  llvm.func @t9_commutative_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "uge" %arg1, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t9_commutative_logical   : t9_commutative_logical_before  ⊑  t9_commutative_logical_combined := by
  unfold t9_commutative_logical_before t9_commutative_logical_combined
  simp_alive_peephole
  sorry
def t10_combined := [llvmfunc|
  llvm.func @t10(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %1 = llvm.sub %arg0, %0  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.icmp "ule" %0, %arg0 : i64
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %0, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ult" %0, %arg0 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_t10   : t10_before  ⊑  t10_combined := by
  unfold t10_before t10_combined
  simp_alive_peephole
  sorry
def t10_logical_combined := [llvmfunc|
  llvm.func @t10_logical(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %1 = llvm.sub %arg0, %0  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.icmp "ule" %0, %arg0 : i64
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %0, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ult" %0, %arg0 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_t10_logical   : t10_logical_before  ⊑  t10_logical_combined := by
  unfold t10_logical_before t10_logical_combined
  simp_alive_peephole
  sorry
def t11_commutative_combined := [llvmfunc|
  llvm.func @t11_commutative(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %1 = llvm.sub %arg0, %0  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.icmp "ule" %0, %arg0 : i64
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %0, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ult" %0, %arg0 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_t11_commutative   : t11_commutative_before  ⊑  t11_commutative_combined := by
  unfold t11_commutative_before t11_commutative_combined
  simp_alive_peephole
  sorry
def t11_commutative_logical_combined := [llvmfunc|
  llvm.func @t11_commutative_logical(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %1 = llvm.sub %arg0, %0  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.icmp "ule" %0, %arg0 : i64
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %0, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ult" %0, %arg0 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_t11_commutative_logical   : t11_commutative_logical_before  ⊑  t11_commutative_logical_combined := by
  unfold t11_commutative_logical_before t11_commutative_logical_combined
  simp_alive_peephole
  sorry
def t12_combined := [llvmfunc|
  llvm.func @t12(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %1 = llvm.sub %arg0, %0  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.icmp "ugt" %0, %arg0 : i64
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %0, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "uge" %0, %arg0 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_t12   : t12_before  ⊑  t12_combined := by
  unfold t12_before t12_combined
  simp_alive_peephole
  sorry
def t12_logical_combined := [llvmfunc|
  llvm.func @t12_logical(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %1 = llvm.sub %arg0, %0  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.icmp "ugt" %0, %arg0 : i64
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %0, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "uge" %0, %arg0 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_t12_logical   : t12_logical_before  ⊑  t12_logical_combined := by
  unfold t12_logical_before t12_logical_combined
  simp_alive_peephole
  sorry
def t13_combined := [llvmfunc|
  llvm.func @t13(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %1 = llvm.sub %arg0, %0  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.icmp "ugt" %0, %arg0 : i64
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %0, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "uge" %0, %arg0 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_t13   : t13_before  ⊑  t13_combined := by
  unfold t13_before t13_combined
  simp_alive_peephole
  sorry
def t13_logical_combined := [llvmfunc|
  llvm.func @t13_logical(%arg0: i64, %arg1: !llvm.ptr {llvm.nonnull}) -> i1 {
    %0 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %1 = llvm.sub %arg0, %0  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.icmp "ugt" %0, %arg0 : i64
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %0, %arg0 : i64
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "uge" %0, %arg0 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_t13_logical   : t13_logical_before  ⊑  t13_logical_combined := by
  unfold t13_logical_before t13_logical_combined
  simp_alive_peephole
  sorry
def t14_bad_combined := [llvmfunc|
  llvm.func @t14_bad(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i64
    llvm.call @use64(%0) : (i64) -> ()
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i64
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_t14_bad   : t14_bad_before  ⊑  t14_bad_combined := by
  unfold t14_bad_before t14_bad_combined
  simp_alive_peephole
  sorry
def t14_bad_logical_combined := [llvmfunc|
  llvm.func @t14_bad_logical(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i64
    llvm.call @use64(%0) : (i64) -> ()
    %1 = llvm.icmp "ult" %0, %arg0 : i64
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i64
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_t14_bad_logical   : t14_bad_logical_before  ⊑  t14_bad_logical_combined := by
  unfold t14_bad_logical_before t14_bad_logical_combined
  simp_alive_peephole
  sorry
def base_ult_offset_combined := [llvmfunc|
  llvm.func @base_ult_offset(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_base_ult_offset   : base_ult_offset_before  ⊑  base_ult_offset_combined := by
  unfold base_ult_offset_before base_ult_offset_combined
  simp_alive_peephole
  sorry
def base_ult_offset_logical_combined := [llvmfunc|
  llvm.func @base_ult_offset_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_base_ult_offset_logical   : base_ult_offset_logical_before  ⊑  base_ult_offset_logical_combined := by
  unfold base_ult_offset_logical_before base_ult_offset_logical_combined
  simp_alive_peephole
  sorry
def base_uge_offset_combined := [llvmfunc|
  llvm.func @base_uge_offset(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_base_uge_offset   : base_uge_offset_before  ⊑  base_uge_offset_combined := by
  unfold base_uge_offset_before base_uge_offset_combined
  simp_alive_peephole
  sorry
def base_uge_offset_logical_combined := [llvmfunc|
  llvm.func @base_uge_offset_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_base_uge_offset_logical   : base_uge_offset_logical_before  ⊑  base_uge_offset_logical_combined := by
  unfold base_uge_offset_logical_before base_uge_offset_logical_combined
  simp_alive_peephole
  sorry
