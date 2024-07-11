import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  with_overflow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def uaddtest1_before := [llvmfunc|
  llvm.func @uaddtest1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i8, i1)> 
    llvm.return %1 : i8
  }]

def uaddtest2_before := [llvmfunc|
  llvm.func @uaddtest2(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = "llvm.intr.uadd.with.overflow"(%1, %2) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    llvm.store %5, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %4 : i8
  }]

def uaddtest3_before := [llvmfunc|
  llvm.func @uaddtest3(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = "llvm.intr.uadd.with.overflow"(%1, %2) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    llvm.store %5, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %4 : i8
  }]

def uaddtest4_before := [llvmfunc|
  llvm.func @uaddtest4(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.undef : i8
    %1 = "llvm.intr.uadd.with.overflow"(%0, %arg0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def uaddtest5_before := [llvmfunc|
  llvm.func @uaddtest5(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.uadd.with.overflow"(%0, %arg0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def uaddtest6_before := [llvmfunc|
  llvm.func @uaddtest6(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

def uaddtest7_before := [llvmfunc|
  llvm.func @uaddtest7(%arg0: i8, %arg1: i8) -> i8 {
    %0 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i8, i1)> 
    llvm.return %1 : i8
  }]

def saddtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @saddtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = "llvm.intr.sadd.with.overflow"(%0, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %2 : !llvm.struct<(i32, i1)>
  }]

def uaddtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @uaddtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = "llvm.intr.uadd.with.overflow"(%1, %2) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }]

def ssubtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @ssubtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = "llvm.intr.ssub.with.overflow"(%0, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %2 : !llvm.struct<(i32, i1)>
  }]

def usubtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @usubtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = "llvm.intr.usub.with.overflow"(%2, %3) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %4 : !llvm.struct<(i32, i1)>
  }]

def smultest1_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @smultest1_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(4095 : i32) : i32
    %1 = llvm.mlir.constant(524287 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = "llvm.intr.smul.with.overflow"(%2, %3) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %4 : !llvm.struct<(i32, i1)>
  }]

def smultest2_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @smultest2_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    %2 = llvm.ashr %arg1, %0  : i32
    %3 = "llvm.intr.smul.with.overflow"(%1, %2) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }]

def smultest3_sw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @smultest3_sw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.ashr %arg1, %1  : i32
    %4 = "llvm.intr.smul.with.overflow"(%2, %3) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %4 : !llvm.struct<(i32, i1)>
  }]

def umultest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @umultest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = "llvm.intr.umul.with.overflow"(%1, %2) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }]

def umultest1_before := [llvmfunc|
  llvm.func @umultest1(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%0, %arg0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def umultest2_before := [llvmfunc|
  llvm.func @umultest2(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%0, %arg0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def umultest3_before := [llvmfunc|
  llvm.func @umultest3(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = "llvm.intr.umul.with.overflow"(%3, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    %6 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    %7 = llvm.select %5, %2, %6 : i1, i32
    llvm.return %7 : i32
  }]

def umultest4_before := [llvmfunc|
  llvm.func @umultest4(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = "llvm.intr.umul.with.overflow"(%3, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    %6 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    %7 = llvm.select %5, %2, %6 : i1, i32
    llvm.return %7 : i32
  }]

def umultest5(%arg0: i32, %arg1: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @umultest5(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.or %arg1, %0  : i32
    %3 = "llvm.intr.umul.with.overflow"(%1, %2) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }]

def overflow_div_add_before := [llvmfunc|
  llvm.func @overflow_div_add(%arg0: i32, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = "llvm.intr.sadd.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    llvm.return %4 : i1
  }]

def overflow_div_sub_before := [llvmfunc|
  llvm.func @overflow_div_sub(%arg0: i32, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(18 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.ashr %arg0, %0  : i32
    %4 = llvm.sdiv %3, %1  : i32
    %5 = "llvm.intr.ssub.with.overflow"(%4, %2) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %6 = llvm.extractvalue %5[1] : !llvm.struct<(i32, i1)> 
    llvm.return %6 : i1
  }]

def overflow_mod_mul_before := [llvmfunc|
  llvm.func @overflow_mod_mul(%arg0: i32, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = "llvm.intr.smul.with.overflow"(%1, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.return %3 : i1
  }]

def overflow_mod_overflow_mul_before := [llvmfunc|
  llvm.func @overflow_mod_overflow_mul(%arg0: i32, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = "llvm.intr.smul.with.overflow"(%1, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.return %3 : i1
  }]

def overflow_mod_mul2_before := [llvmfunc|
  llvm.func @overflow_mod_mul2(%arg0: i16, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.srem %0, %arg1  : i32
    %2 = "llvm.intr.smul.with.overflow"(%1, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.return %3 : i1
  }]

def ssubtest_reorder(%arg0: i8) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @ssubtest_reorder(%arg0: i8) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = "llvm.intr.ssub.with.overflow"(%0, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %2 : !llvm.struct<(i32, i1)>
  }]

def never_overflows_ssub_test0(%arg0: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @never_overflows_ssub_test0(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.ssub.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

def uadd_res_ult_x_before := [llvmfunc|
  llvm.func @uadd_res_ult_x(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.store %1, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr]

    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i1)> 
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def uadd_res_ult_y_before := [llvmfunc|
  llvm.func @uadd_res_ult_y(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.store %1, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr]

    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i1)> 
    %3 = llvm.icmp "ult" %2, %arg1 : i32
    llvm.return %3 : i1
  }]

def uadd_res_ugt_x_before := [llvmfunc|
  llvm.func @uadd_res_ugt_x(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.urem %0, %arg0  : i32
    %2 = "llvm.intr.uadd.with.overflow"(%1, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.store %3, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr]

    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ugt" %1, %4 : i32
    llvm.return %5 : i1
  }]

def uadd_res_ugt_y_before := [llvmfunc|
  llvm.func @uadd_res_ugt_y(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.urem %0, %arg1  : i32
    %2 = "llvm.intr.uadd.with.overflow"(%arg0, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.store %3, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr]

    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ugt" %1, %4 : i32
    llvm.return %5 : i1
  }]

def uadd_res_ult_const_before := [llvmfunc|
  llvm.func @uadd_res_ult_const(%arg0: i32, %arg1: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def uadd_res_ult_const_one_before := [llvmfunc|
  llvm.func @uadd_res_ult_const_one(%arg0: i32, %arg1: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def uadd_res_ult_const_minus_one_before := [llvmfunc|
  llvm.func @uadd_res_ult_const_minus_one(%arg0: i32, %arg1: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def sadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @sadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.sadd.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

def uadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @uadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

def ssub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @ssub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.ssub.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

def usub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @usub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.usub.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

def smul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @smul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.smul.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

def umul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @umul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.umul.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

def uadd_always_overflow(%arg0: i8) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @uadd_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %3 : !llvm.struct<(i8, i1)>
  }]

def usub_always_overflow(%arg0: i8) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @usub_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = "llvm.intr.usub.with.overflow"(%1, %2) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %3 : !llvm.struct<(i8, i1)>
  }]

def umul_always_overflow(%arg0: i8) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @umul_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = "llvm.intr.umul.with.overflow"(%2, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %3 : !llvm.struct<(i8, i1)>
  }]

def sadd_always_overflow(%arg0: i8) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @sadd_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(28 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = "llvm.intr.sadd.with.overflow"(%3, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %4 : !llvm.struct<(i8, i1)>
  }]

def ssub_always_overflow(%arg0: i8) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @ssub_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(29 : i8) : i8
    %1 = llvm.mlir.constant(-100 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = "llvm.intr.ssub.with.overflow"(%1, %3) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %4 : !llvm.struct<(i8, i1)>
  }]

def smul_always_overflow(%arg0: i8) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @smul_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = "llvm.intr.smul.with.overflow"(%3, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %4 : !llvm.struct<(i8, i1)>
  }]

def always_sadd_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @always_sadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<127> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.sadd.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def always_uadd_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @always_uadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.uadd.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def always_ssub_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @always_ssub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-128> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.ssub.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def always_usub_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @always_usub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %3 = "llvm.intr.usub.with.overflow"(%1, %2) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %3 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def always_smul_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @always_smul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<127> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.smul.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def always_umul_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @always_umul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.umul.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def never_sadd_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @never_sadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[-10, -20, 30, 40]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[-40, 10, -30, 20]> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.sadd.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def never_uadd_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @never_uadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[0, 32, 64, 16]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<32> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.uadd.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def never_ssub_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @never_ssub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-10> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[-10, -20, -30, -40]> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.ssub.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def never_usub_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @never_usub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[-128, 0, -1, 1]> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.usub.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def never_smul_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @never_smul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-6> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[9, 3, 10, 15]> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.smul.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def never_umul_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @never_umul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<15> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[15, 8, 4, 2]> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.umul.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def neutral_sadd_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @neutral_sadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %3 = "llvm.intr.sadd.with.overflow"(%0, %2) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %3 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def neutral_uadd_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @neutral_uadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %3 = "llvm.intr.uadd.with.overflow"(%0, %2) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %3 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def neutral_ssub_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @neutral_ssub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %3 = "llvm.intr.ssub.with.overflow"(%0, %2) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %3 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def neutral_usub_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @neutral_usub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %3 = "llvm.intr.usub.with.overflow"(%0, %2) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %3 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def neutral_smul_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @neutral_smul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.smul.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def neutral_umul_const_vector() -> !llvm.struct<_before := [llvmfunc|
  llvm.func @neutral_umul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.umul.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

def smul_neg1_before := [llvmfunc|
  llvm.func @smul_neg1(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def smul_neg1_vec_before := [llvmfunc|
  llvm.func @smul_neg1_vec(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr]

    llvm.return %2 : vector<4xi8>
  }]

def smul_neg1_vec_poison_before := [llvmfunc|
  llvm.func @smul_neg1_vec_poison(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = "llvm.intr.smul.with.overflow"(%arg0, %10) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %13 = llvm.extractvalue %11[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.store %13, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr]

    llvm.return %12 : vector<4xi8>
  }]

def smul_neg2_before := [llvmfunc|
  llvm.func @smul_neg2(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def umul_neg1_before := [llvmfunc|
  llvm.func @umul_neg1(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def umul_neg1_vec_before := [llvmfunc|
  llvm.func @umul_neg1_vec(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr]

    llvm.return %2 : vector<4xi8>
  }]

def umul_neg1_vec_poison_before := [llvmfunc|
  llvm.func @umul_neg1_vec_poison(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = "llvm.intr.umul.with.overflow"(%arg0, %10) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %13 = llvm.extractvalue %11[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.store %13, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr]

    llvm.return %12 : vector<4xi8>
  }]

def smul_not_neg1_vec_before := [llvmfunc|
  llvm.func @smul_not_neg1_vec(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = "llvm.intr.smul.with.overflow"(%arg0, %10) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %12 = llvm.extractvalue %11[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %12 : vector<4xi1>
  }]

def umul_neg1_select_before := [llvmfunc|
  llvm.func @umul_neg1_select(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.return %4 : i8
  }]

def umul_2_before := [llvmfunc|
  llvm.func @umul_2(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def umul_8_before := [llvmfunc|
  llvm.func @umul_8(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def umul_64_before := [llvmfunc|
  llvm.func @umul_64(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def umul_256_before := [llvmfunc|
  llvm.func @umul_256(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def umul_4_vec_poison_before := [llvmfunc|
  llvm.func @umul_4_vec_poison(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = "llvm.intr.umul.with.overflow"(%arg0, %10) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %13 = llvm.extractvalue %11[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.store %13, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr]

    llvm.return %12 : vector<4xi8>
  }]

def umul_3_before := [llvmfunc|
  llvm.func @umul_3(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def smul_4_before := [llvmfunc|
  llvm.func @smul_4(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def smul_16_before := [llvmfunc|
  llvm.func @smul_16(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def smul_32_before := [llvmfunc|
  llvm.func @smul_32(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def smul_128_before := [llvmfunc|
  llvm.func @smul_128(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def smul_2_vec_poison_before := [llvmfunc|
  llvm.func @smul_2_vec_poison(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = "llvm.intr.smul.with.overflow"(%arg0, %10) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %13 = llvm.extractvalue %11[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.store %13, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr]

    llvm.return %12 : vector<4xi8>
  }]

def smul_7_before := [llvmfunc|
  llvm.func @smul_7(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %2 : i8
  }]

def uaddtest1_combined := [llvmfunc|
  llvm.func @uaddtest1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_uaddtest1   : uaddtest1_before  ⊑  uaddtest1_combined := by
  unfold uaddtest1_before uaddtest1_combined
  simp_alive_peephole
  sorry
def uaddtest2_combined := [llvmfunc|
  llvm.func @uaddtest2(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %0  : i8
    %4 = llvm.add %2, %3 overflow<nuw>  : i8
    llvm.store %1, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_uaddtest2   : uaddtest2_before  ⊑  uaddtest2_combined := by
  unfold uaddtest2_before uaddtest2_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i8
  }]

theorem inst_combine_uaddtest2   : uaddtest2_before  ⊑  uaddtest2_combined := by
  unfold uaddtest2_before uaddtest2_combined
  simp_alive_peephole
  sorry
def uaddtest3_combined := [llvmfunc|
  llvm.func @uaddtest3(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg1, %0  : i8
    %4 = llvm.add %2, %3  : i8
    llvm.store %1, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_uaddtest3   : uaddtest3_before  ⊑  uaddtest3_combined := by
  unfold uaddtest3_before uaddtest3_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i8
  }]

theorem inst_combine_uaddtest3   : uaddtest3_before  ⊑  uaddtest3_combined := by
  unfold uaddtest3_before uaddtest3_combined
  simp_alive_peephole
  sorry
def uaddtest4_combined := [llvmfunc|
  llvm.func @uaddtest4(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(-1 : i8) : i8
    llvm.store %0, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_uaddtest4   : uaddtest4_before  ⊑  uaddtest4_combined := by
  unfold uaddtest4_before uaddtest4_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_uaddtest4   : uaddtest4_before  ⊑  uaddtest4_combined := by
  unfold uaddtest4_before uaddtest4_combined
  simp_alive_peephole
  sorry
def uaddtest5_combined := [llvmfunc|
  llvm.func @uaddtest5(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.store %0, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_uaddtest5   : uaddtest5_before  ⊑  uaddtest5_combined := by
  unfold uaddtest5_before uaddtest5_combined
  simp_alive_peephole
  sorry
    llvm.return %arg0 : i8
  }]

theorem inst_combine_uaddtest5   : uaddtest5_before  ⊑  uaddtest5_combined := by
  unfold uaddtest5_before uaddtest5_combined
  simp_alive_peephole
  sorry
def uaddtest6_combined := [llvmfunc|
  llvm.func @uaddtest6(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_uaddtest6   : uaddtest6_before  ⊑  uaddtest6_combined := by
  unfold uaddtest6_before uaddtest6_combined
  simp_alive_peephole
  sorry
def uaddtest7_combined := [llvmfunc|
  llvm.func @uaddtest7(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_uaddtest7   : uaddtest7_before  ⊑  uaddtest7_combined := by
  unfold uaddtest7_before uaddtest7_combined
  simp_alive_peephole
  sorry
def saddtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @saddtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i1)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.sext %arg0 : i8 to i32
    %6 = llvm.sext %arg1 : i8 to i32
    %7 = llvm.add %5, %6 overflow<nsw>  : i32
    %8 = llvm.insertvalue %7, %4[0] : !llvm.struct<(i32, i1)> 
    llvm.return %8 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_saddtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<   : saddtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<_before  ⊑  saddtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<_combined := by
  unfold saddtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<_before saddtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def uaddtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @uaddtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : !llvm.struct<(i32, i1)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(i32, i1)> 
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.and %arg1, %0  : i32
    %8 = llvm.add %6, %7 overflow<nuw>  : i32
    %9 = llvm.insertvalue %8, %5[0] : !llvm.struct<(i32, i1)> 
    llvm.return %9 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_uaddtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<   : uaddtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before  ⊑  uaddtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := by
  unfold uaddtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before uaddtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def ssubtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @ssubtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i1)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.sext %arg0 : i8 to i32
    %6 = llvm.sext %arg1 : i8 to i32
    %7 = llvm.sub %5, %6 overflow<nsw>  : i32
    %8 = llvm.insertvalue %7, %4[0] : !llvm.struct<(i32, i1)> 
    llvm.return %8 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_ssubtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<   : ssubtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<_before  ⊑  ssubtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<_combined := by
  unfold ssubtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<_before ssubtest_nsw(%arg0: i8, %arg1: i8) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def usubtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @usubtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.undef : !llvm.struct<(i32, i1)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<(i32, i1)> 
    %7 = llvm.or %arg0, %0  : i32
    %8 = llvm.and %arg1, %1  : i32
    %9 = llvm.sub %7, %8 overflow<nuw>  : i32
    %10 = llvm.insertvalue %9, %6[0] : !llvm.struct<(i32, i1)> 
    llvm.return %10 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_usubtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<   : usubtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before  ⊑  usubtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := by
  unfold usubtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before usubtest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def smultest1_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @smultest1_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(4095 : i32) : i32
    %1 = llvm.mlir.constant(524287 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.undef : !llvm.struct<(i32, i1)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<(i32, i1)> 
    %7 = llvm.and %arg0, %0  : i32
    %8 = llvm.and %arg1, %1  : i32
    %9 = llvm.mul %7, %8 overflow<nsw, nuw>  : i32
    %10 = llvm.insertvalue %9, %6[0] : !llvm.struct<(i32, i1)> 
    llvm.return %10 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_smultest1_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<   : smultest1_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before  ⊑  smultest1_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := by
  unfold smultest1_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before smultest1_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def smultest2_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @smultest2_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : !llvm.struct<(i32, i1)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(i32, i1)> 
    %6 = llvm.ashr %arg0, %0  : i32
    %7 = llvm.ashr %arg1, %0  : i32
    %8 = llvm.mul %6, %7 overflow<nsw>  : i32
    %9 = llvm.insertvalue %8, %5[0] : !llvm.struct<(i32, i1)> 
    llvm.return %9 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_smultest2_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<   : smultest2_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before  ⊑  smultest2_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := by
  unfold smultest2_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before smultest2_nsw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def smultest3_sw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @smultest3_sw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.ashr %arg1, %1  : i32
    %4 = "llvm.intr.smul.with.overflow"(%2, %3) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %4 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_smultest3_sw(%arg0: i32, %arg1: i32) -> !llvm.struct<   : smultest3_sw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before  ⊑  smultest3_sw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := by
  unfold smultest3_sw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before smultest3_sw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def umultest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @umultest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : !llvm.struct<(i32, i1)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(i32, i1)> 
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.and %arg1, %0  : i32
    %8 = llvm.mul %6, %7 overflow<nuw>  : i32
    %9 = llvm.insertvalue %8, %5[0] : !llvm.struct<(i32, i1)> 
    llvm.return %9 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_umultest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<   : umultest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before  ⊑  umultest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := by
  unfold umultest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_before umultest_nuw(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def umultest1_combined := [llvmfunc|
  llvm.func @umultest1(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    llvm.store %0, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_umultest1   : umultest1_before  ⊑  umultest1_combined := by
  unfold umultest1_before umultest1_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_umultest1   : umultest1_before  ⊑  umultest1_combined := by
  unfold umultest1_before umultest1_combined
  simp_alive_peephole
  sorry
def umultest2_combined := [llvmfunc|
  llvm.func @umultest2(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.store %0, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_umultest2   : umultest2_before  ⊑  umultest2_combined := by
  unfold umultest2_before umultest2_combined
  simp_alive_peephole
  sorry
    llvm.return %arg0 : i8
  }]

theorem inst_combine_umultest2   : umultest2_before  ⊑  umultest2_combined := by
  unfold umultest2_before umultest2_combined
  simp_alive_peephole
  sorry
def umultest3_combined := [llvmfunc|
  llvm.func @umultest3(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_umultest3   : umultest3_before  ⊑  umultest3_combined := by
  unfold umultest3_before umultest3_combined
  simp_alive_peephole
  sorry
def umultest4_combined := [llvmfunc|
  llvm.func @umultest4(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "sgt" %arg0, %2 : i32
    %6 = llvm.select %5, %4, %2 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_umultest4   : umultest4_before  ⊑  umultest4_combined := by
  unfold umultest4_before umultest4_combined
  simp_alive_peephole
  sorry
def umultest5(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @umultest5(%arg0: i32, %arg1: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : !llvm.struct<(i32, i1)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(i32, i1)> 
    %6 = llvm.or %arg0, %0  : i32
    %7 = llvm.or %arg1, %0  : i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.insertvalue %8, %5[0] : !llvm.struct<(i32, i1)> 
    llvm.return %9 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_umultest5(%arg0: i32, %arg1: i32) -> !llvm.struct<   : umultest5(%arg0: i32, %arg1: i32) -> !llvm.struct<_before  ⊑  umultest5(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined := by
  unfold umultest5(%arg0: i32, %arg1: i32) -> !llvm.struct<_before umultest5(%arg0: i32, %arg1: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def overflow_div_add_combined := [llvmfunc|
  llvm.func @overflow_div_add(%arg0: i32, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_overflow_div_add   : overflow_div_add_before  ⊑  overflow_div_add_combined := by
  unfold overflow_div_add_before overflow_div_add_combined
  simp_alive_peephole
  sorry
def overflow_div_sub_combined := [llvmfunc|
  llvm.func @overflow_div_sub(%arg0: i32, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_overflow_div_sub   : overflow_div_sub_before  ⊑  overflow_div_sub_combined := by
  unfold overflow_div_sub_before overflow_div_sub_combined
  simp_alive_peephole
  sorry
def overflow_mod_mul_combined := [llvmfunc|
  llvm.func @overflow_mod_mul(%arg0: i32, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_overflow_mod_mul   : overflow_mod_mul_before  ⊑  overflow_mod_mul_combined := by
  unfold overflow_mod_mul_before overflow_mod_mul_combined
  simp_alive_peephole
  sorry
def overflow_mod_overflow_mul_combined := [llvmfunc|
  llvm.func @overflow_mod_overflow_mul(%arg0: i32, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = "llvm.intr.smul.with.overflow"(%1, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.return %3 : i1
  }]

theorem inst_combine_overflow_mod_overflow_mul   : overflow_mod_overflow_mul_before  ⊑  overflow_mod_overflow_mul_combined := by
  unfold overflow_mod_overflow_mul_before overflow_mod_overflow_mul_combined
  simp_alive_peephole
  sorry
def overflow_mod_mul2_combined := [llvmfunc|
  llvm.func @overflow_mod_mul2(%arg0: i16, %arg1: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_overflow_mod_mul2   : overflow_mod_mul2_before  ⊑  overflow_mod_mul2_combined := by
  unfold overflow_mod_mul2_before overflow_mod_mul2_combined
  simp_alive_peephole
  sorry
def ssubtest_reorder(%arg0: i8) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @ssubtest_reorder(%arg0: i8) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : !llvm.struct<(i32, i1)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(i32, i1)> 
    %6 = llvm.sext %arg0 : i8 to i32
    %7 = llvm.sub %0, %6 overflow<nsw>  : i32
    %8 = llvm.insertvalue %7, %5[0] : !llvm.struct<(i32, i1)> 
    llvm.return %8 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_ssubtest_reorder(%arg0: i8) -> !llvm.struct<   : ssubtest_reorder(%arg0: i8) -> !llvm.struct<_before  ⊑  ssubtest_reorder(%arg0: i8) -> !llvm.struct<_combined := by
  unfold ssubtest_reorder(%arg0: i8) -> !llvm.struct<_before ssubtest_reorder(%arg0: i8) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def never_overflows_ssub_test0(%arg0: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @never_overflows_ssub_test0(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i1)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.insertvalue %arg0, %4[0] : !llvm.struct<(i32, i1)> 
    llvm.return %5 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_never_overflows_ssub_test0(%arg0: i32) -> !llvm.struct<   : never_overflows_ssub_test0(%arg0: i32) -> !llvm.struct<_before  ⊑  never_overflows_ssub_test0(%arg0: i32) -> !llvm.struct<_combined := by
  unfold never_overflows_ssub_test0(%arg0: i32) -> !llvm.struct<_before never_overflows_ssub_test0(%arg0: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def uadd_res_ult_x_combined := [llvmfunc|
  llvm.func @uadd_res_ult_x(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.store %1, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_uadd_res_ult_x   : uadd_res_ult_x_before  ⊑  uadd_res_ult_x_combined := by
  unfold uadd_res_ult_x_before uadd_res_ult_x_combined
  simp_alive_peephole
  sorry
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.return %2 : i1
  }]

theorem inst_combine_uadd_res_ult_x   : uadd_res_ult_x_before  ⊑  uadd_res_ult_x_combined := by
  unfold uadd_res_ult_x_before uadd_res_ult_x_combined
  simp_alive_peephole
  sorry
def uadd_res_ult_y_combined := [llvmfunc|
  llvm.func @uadd_res_ult_y(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.store %1, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_uadd_res_ult_y   : uadd_res_ult_y_before  ⊑  uadd_res_ult_y_combined := by
  unfold uadd_res_ult_y_before uadd_res_ult_y_combined
  simp_alive_peephole
  sorry
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i1)> 
    llvm.return %2 : i1
  }]

theorem inst_combine_uadd_res_ult_y   : uadd_res_ult_y_before  ⊑  uadd_res_ult_y_combined := by
  unfold uadd_res_ult_y_before uadd_res_ult_y_combined
  simp_alive_peephole
  sorry
def uadd_res_ugt_x_combined := [llvmfunc|
  llvm.func @uadd_res_ugt_x(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.urem %0, %arg0  : i32
    %2 = "llvm.intr.uadd.with.overflow"(%1, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.store %3, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_uadd_res_ugt_x   : uadd_res_ugt_x_before  ⊑  uadd_res_ugt_x_combined := by
  unfold uadd_res_ugt_x_before uadd_res_ugt_x_combined
  simp_alive_peephole
  sorry
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.return %4 : i1
  }]

theorem inst_combine_uadd_res_ugt_x   : uadd_res_ugt_x_before  ⊑  uadd_res_ugt_x_combined := by
  unfold uadd_res_ugt_x_before uadd_res_ugt_x_combined
  simp_alive_peephole
  sorry
def uadd_res_ugt_y_combined := [llvmfunc|
  llvm.func @uadd_res_ugt_y(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.urem %0, %arg1  : i32
    %2 = "llvm.intr.uadd.with.overflow"(%arg0, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.store %3, %arg2 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_uadd_res_ugt_y   : uadd_res_ugt_y_before  ⊑  uadd_res_ugt_y_combined := by
  unfold uadd_res_ugt_y_before uadd_res_ugt_y_combined
  simp_alive_peephole
  sorry
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.return %4 : i1
  }]

theorem inst_combine_uadd_res_ugt_y   : uadd_res_ugt_y_before  ⊑  uadd_res_ugt_y_combined := by
  unfold uadd_res_ugt_y_before uadd_res_ugt_y_combined
  simp_alive_peephole
  sorry
def uadd_res_ult_const_combined := [llvmfunc|
  llvm.func @uadd_res_ult_const(%arg0: i32, %arg1: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_uadd_res_ult_const   : uadd_res_ult_const_before  ⊑  uadd_res_ult_const_combined := by
  unfold uadd_res_ult_const_before uadd_res_ult_const_combined
  simp_alive_peephole
  sorry
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    llvm.return %3 : i1
  }]

theorem inst_combine_uadd_res_ult_const   : uadd_res_ult_const_before  ⊑  uadd_res_ult_const_combined := by
  unfold uadd_res_ult_const_before uadd_res_ult_const_combined
  simp_alive_peephole
  sorry
def uadd_res_ult_const_one_combined := [llvmfunc|
  llvm.func @uadd_res_ult_const_one(%arg0: i32, %arg1: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_uadd_res_ult_const_one   : uadd_res_ult_const_one_before  ⊑  uadd_res_ult_const_one_combined := by
  unfold uadd_res_ult_const_one_before uadd_res_ult_const_one_combined
  simp_alive_peephole
  sorry
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    llvm.return %3 : i1
  }]

theorem inst_combine_uadd_res_ult_const_one   : uadd_res_ult_const_one_before  ⊑  uadd_res_ult_const_one_combined := by
  unfold uadd_res_ult_const_one_before uadd_res_ult_const_one_combined
  simp_alive_peephole
  sorry
def uadd_res_ult_const_minus_one_combined := [llvmfunc|
  llvm.func @uadd_res_ult_const_minus_one(%arg0: i32, %arg1: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_uadd_res_ult_const_minus_one   : uadd_res_ult_const_minus_one_before  ⊑  uadd_res_ult_const_minus_one_combined := by
  unfold uadd_res_ult_const_minus_one_before uadd_res_ult_const_minus_one_combined
  simp_alive_peephole
  sorry
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    llvm.return %3 : i1
  }]

theorem inst_combine_uadd_res_ult_const_minus_one   : uadd_res_ult_const_minus_one_before  ⊑  uadd_res_ult_const_minus_one_combined := by
  unfold uadd_res_ult_const_minus_one_before uadd_res_ult_const_minus_one_combined
  simp_alive_peephole
  sorry
def sadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @sadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_sadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<   : sadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before  ⊑  sadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined := by
  unfold sadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before sadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def uadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @uadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_uadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<   : uadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before  ⊑  uadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined := by
  unfold uadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before uadd_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def ssub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @ssub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.ssub.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_ssub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<   : ssub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before  ⊑  ssub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined := by
  unfold ssub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before ssub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def usub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @usub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.usub.with.overflow"(%0, %arg0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_usub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<   : usub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before  ⊑  usub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined := by
  unfold usub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before usub_no_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def smul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @smul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_smul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<   : smul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before  ⊑  smul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined := by
  unfold smul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before smul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def umul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @umul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<(i32, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_umul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<   : umul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before  ⊑  umul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined := by
  unfold umul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_before umul_canonicalize_constant_arg0(%arg0: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def uadd_always_overflow(%arg0: i8) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @uadd_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : !llvm.struct<(i8, i1)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(i8, i1)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(i8, i1)> 
    %6 = llvm.and %arg0, %0  : i8
    %7 = llvm.insertvalue %6, %5[0] : !llvm.struct<(i8, i1)> 
    llvm.return %7 : !llvm.struct<(i8, i1)>
  }]

theorem inst_combine_uadd_always_overflow(%arg0: i8) -> !llvm.struct<   : uadd_always_overflow(%arg0: i8) -> !llvm.struct<_before  ⊑  uadd_always_overflow(%arg0: i8) -> !llvm.struct<_combined := by
  unfold uadd_always_overflow(%arg0: i8) -> !llvm.struct<_before uadd_always_overflow(%arg0: i8) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def usub_always_overflow(%arg0: i8) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @usub_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.poison : i8
    %4 = llvm.mlir.undef : !llvm.struct<(i8, i1)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<(i8, i1)> 
    %7 = llvm.or %arg0, %0  : i8
    %8 = llvm.sub %1, %7 overflow<nsw>  : i8
    %9 = llvm.insertvalue %8, %6[0] : !llvm.struct<(i8, i1)> 
    llvm.return %9 : !llvm.struct<(i8, i1)>
  }]

theorem inst_combine_usub_always_overflow(%arg0: i8) -> !llvm.struct<   : usub_always_overflow(%arg0: i8) -> !llvm.struct<_before  ⊑  usub_always_overflow(%arg0: i8) -> !llvm.struct<_combined := by
  unfold usub_always_overflow(%arg0: i8) -> !llvm.struct<_before usub_always_overflow(%arg0: i8) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def umul_always_overflow(%arg0: i8) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @umul_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : !llvm.struct<(i8, i1)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(i8, i1)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(i8, i1)> 
    %6 = llvm.shl %arg0, %0  : i8
    %7 = llvm.insertvalue %6, %5[0] : !llvm.struct<(i8, i1)> 
    llvm.return %7 : !llvm.struct<(i8, i1)>
  }]

theorem inst_combine_umul_always_overflow(%arg0: i8) -> !llvm.struct<   : umul_always_overflow(%arg0: i8) -> !llvm.struct<_before  ⊑  umul_always_overflow(%arg0: i8) -> !llvm.struct<_combined := by
  unfold umul_always_overflow(%arg0: i8) -> !llvm.struct<_before umul_always_overflow(%arg0: i8) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def sadd_always_overflow(%arg0: i8) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @sadd_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(28 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.poison : i8
    %4 = llvm.mlir.undef : !llvm.struct<(i8, i1)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<(i8, i1)> 
    %7 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %8 = llvm.add %7, %1 overflow<nuw>  : i8
    %9 = llvm.insertvalue %8, %6[0] : !llvm.struct<(i8, i1)> 
    llvm.return %9 : !llvm.struct<(i8, i1)>
  }]

theorem inst_combine_sadd_always_overflow(%arg0: i8) -> !llvm.struct<   : sadd_always_overflow(%arg0: i8) -> !llvm.struct<_before  ⊑  sadd_always_overflow(%arg0: i8) -> !llvm.struct<_combined := by
  unfold sadd_always_overflow(%arg0: i8) -> !llvm.struct<_before sadd_always_overflow(%arg0: i8) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def ssub_always_overflow(%arg0: i8) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @ssub_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(29 : i8) : i8
    %1 = llvm.mlir.constant(-100 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.poison : i8
    %4 = llvm.mlir.undef : !llvm.struct<(i8, i1)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<(i8, i1)> 
    %7 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %8 = llvm.sub %1, %7 overflow<nuw>  : i8
    %9 = llvm.insertvalue %8, %6[0] : !llvm.struct<(i8, i1)> 
    llvm.return %9 : !llvm.struct<(i8, i1)>
  }]

theorem inst_combine_ssub_always_overflow(%arg0: i8) -> !llvm.struct<   : ssub_always_overflow(%arg0: i8) -> !llvm.struct<_before  ⊑  ssub_always_overflow(%arg0: i8) -> !llvm.struct<_combined := by
  unfold ssub_always_overflow(%arg0: i8) -> !llvm.struct<_before ssub_always_overflow(%arg0: i8) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def smul_always_overflow(%arg0: i8) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @smul_always_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %3 = "llvm.intr.smul.with.overflow"(%2, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %3 : !llvm.struct<(i8, i1)>
  }]

theorem inst_combine_smul_always_overflow(%arg0: i8) -> !llvm.struct<   : smul_always_overflow(%arg0: i8) -> !llvm.struct<_before  ⊑  smul_always_overflow(%arg0: i8) -> !llvm.struct<_combined := by
  unfold smul_always_overflow(%arg0: i8) -> !llvm.struct<_before smul_always_overflow(%arg0: i8) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def always_sadd_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @always_sadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<-128> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_always_sadd_const_vector() -> !llvm.struct<   : always_sadd_const_vector() -> !llvm.struct<_before  ⊑  always_sadd_const_vector() -> !llvm.struct<_combined := by
  unfold always_sadd_const_vector() -> !llvm.struct<_before always_sadd_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def always_uadd_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @always_uadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %4 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %6 = llvm.insertvalue %1, %5[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %6 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_always_uadd_const_vector() -> !llvm.struct<   : always_uadd_const_vector() -> !llvm.struct<_before  ⊑  always_uadd_const_vector() -> !llvm.struct<_combined := by
  unfold always_uadd_const_vector() -> !llvm.struct<_before always_uadd_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def always_ssub_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @always_ssub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<127> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_always_ssub_const_vector() -> !llvm.struct<   : always_ssub_const_vector() -> !llvm.struct<_before  ⊑  always_ssub_const_vector() -> !llvm.struct<_combined := by
  unfold always_ssub_const_vector() -> !llvm.struct<_before always_ssub_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def always_usub_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @always_usub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_always_usub_const_vector() -> !llvm.struct<   : always_usub_const_vector() -> !llvm.struct<_before  ⊑  always_usub_const_vector() -> !llvm.struct<_combined := by
  unfold always_usub_const_vector() -> !llvm.struct<_before always_usub_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def always_smul_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @always_smul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<127> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %2 = "llvm.intr.smul.with.overflow"(%0, %1) : (vector<4xi8>, vector<4xi8>) -> !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    llvm.return %2 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_always_smul_const_vector() -> !llvm.struct<   : always_smul_const_vector() -> !llvm.struct<_before  ⊑  always_smul_const_vector() -> !llvm.struct<_combined := by
  unfold always_smul_const_vector() -> !llvm.struct<_before always_smul_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def always_umul_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @always_umul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<-3> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_always_umul_const_vector() -> !llvm.struct<   : always_umul_const_vector() -> !llvm.struct<_before  ⊑  always_umul_const_vector() -> !llvm.struct<_combined := by
  unfold always_umul_const_vector() -> !llvm.struct<_before always_umul_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def never_sadd_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @never_sadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<[-50, -10, 0, 60]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_never_sadd_const_vector() -> !llvm.struct<   : never_sadd_const_vector() -> !llvm.struct<_before  ⊑  never_sadd_const_vector() -> !llvm.struct<_combined := by
  unfold never_sadd_const_vector() -> !llvm.struct<_before never_sadd_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def never_uadd_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @never_uadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<[32, 64, 96, 48]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_never_uadd_const_vector() -> !llvm.struct<   : never_uadd_const_vector() -> !llvm.struct<_before  ⊑  never_uadd_const_vector() -> !llvm.struct<_combined := by
  unfold never_uadd_const_vector() -> !llvm.struct<_before never_uadd_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def never_ssub_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @never_ssub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<[0, 10, 20, 30]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_never_ssub_const_vector() -> !llvm.struct<   : never_ssub_const_vector() -> !llvm.struct<_before  ⊑  never_ssub_const_vector() -> !llvm.struct<_combined := by
  unfold never_ssub_const_vector() -> !llvm.struct<_before never_ssub_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def never_usub_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @never_usub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<[127, -1, 0, -2]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_never_usub_const_vector() -> !llvm.struct<   : never_usub_const_vector() -> !llvm.struct<_before  ⊑  never_usub_const_vector() -> !llvm.struct<_combined := by
  unfold never_usub_const_vector() -> !llvm.struct<_before never_usub_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def never_smul_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @never_smul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<[-54, -18, -60, -90]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_never_smul_const_vector() -> !llvm.struct<   : never_smul_const_vector() -> !llvm.struct<_before  ⊑  never_smul_const_vector() -> !llvm.struct<_combined := by
  unfold never_smul_const_vector() -> !llvm.struct<_before never_smul_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def never_umul_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @never_umul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<[-31, 120, 60, 30]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_never_umul_const_vector() -> !llvm.struct<   : never_umul_const_vector() -> !llvm.struct<_before  ⊑  never_umul_const_vector() -> !llvm.struct<_combined := by
  unfold never_umul_const_vector() -> !llvm.struct<_before never_umul_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def neutral_sadd_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @neutral_sadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_neutral_sadd_const_vector() -> !llvm.struct<   : neutral_sadd_const_vector() -> !llvm.struct<_before  ⊑  neutral_sadd_const_vector() -> !llvm.struct<_combined := by
  unfold neutral_sadd_const_vector() -> !llvm.struct<_before neutral_sadd_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def neutral_uadd_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @neutral_uadd_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_neutral_uadd_const_vector() -> !llvm.struct<   : neutral_uadd_const_vector() -> !llvm.struct<_before  ⊑  neutral_uadd_const_vector() -> !llvm.struct<_combined := by
  unfold neutral_uadd_const_vector() -> !llvm.struct<_before neutral_uadd_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def neutral_ssub_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @neutral_ssub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_neutral_ssub_const_vector() -> !llvm.struct<   : neutral_ssub_const_vector() -> !llvm.struct<_before  ⊑  neutral_ssub_const_vector() -> !llvm.struct<_combined := by
  unfold neutral_ssub_const_vector() -> !llvm.struct<_before neutral_ssub_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def neutral_usub_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @neutral_usub_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_neutral_usub_const_vector() -> !llvm.struct<   : neutral_usub_const_vector() -> !llvm.struct<_before  ⊑  neutral_usub_const_vector() -> !llvm.struct<_combined := by
  unfold neutral_usub_const_vector() -> !llvm.struct<_before neutral_usub_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def neutral_smul_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @neutral_smul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_neutral_smul_const_vector() -> !llvm.struct<   : neutral_smul_const_vector() -> !llvm.struct<_before  ⊑  neutral_smul_const_vector() -> !llvm.struct<_combined := by
  unfold neutral_smul_const_vector() -> !llvm.struct<_before neutral_smul_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def neutral_umul_const_vector() -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @neutral_umul_const_vector() -> !llvm.struct<(vector<4xi8>, vector<4xi1>)> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.mlir.undef : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<(vector<4xi8>, vector<4xi1>)> 
    llvm.return %5 : !llvm.struct<(vector<4xi8>, vector<4xi1>)>
  }]

theorem inst_combine_neutral_umul_const_vector() -> !llvm.struct<   : neutral_umul_const_vector() -> !llvm.struct<_before  ⊑  neutral_umul_const_vector() -> !llvm.struct<_combined := by
  unfold neutral_umul_const_vector() -> !llvm.struct<_before neutral_umul_const_vector() -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def smul_neg1_combined := [llvmfunc|
  llvm.func @smul_neg1(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_smul_neg1   : smul_neg1_before  ⊑  smul_neg1_combined := by
  unfold smul_neg1_before smul_neg1_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i8
  }]

theorem inst_combine_smul_neg1   : smul_neg1_before  ⊑  smul_neg1_combined := by
  unfold smul_neg1_before smul_neg1_combined
  simp_alive_peephole
  sorry
def smul_neg1_vec_combined := [llvmfunc|
  llvm.func @smul_neg1_vec(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<-128> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.sub %1, %arg0  : vector<4xi8>
    %4 = llvm.icmp "eq" %arg0, %2 : vector<4xi8>
    llvm.store %4, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr]

theorem inst_combine_smul_neg1_vec   : smul_neg1_vec_before  ⊑  smul_neg1_vec_combined := by
  unfold smul_neg1_vec_before smul_neg1_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_smul_neg1_vec   : smul_neg1_vec_before  ⊑  smul_neg1_vec_combined := by
  unfold smul_neg1_vec_before smul_neg1_vec_combined
  simp_alive_peephole
  sorry
def smul_neg1_vec_poison_combined := [llvmfunc|
  llvm.func @smul_neg1_vec_poison(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<-128> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.sub %1, %arg0  : vector<4xi8>
    %4 = llvm.icmp "eq" %arg0, %2 : vector<4xi8>
    llvm.store %4, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr]

theorem inst_combine_smul_neg1_vec_poison   : smul_neg1_vec_poison_before  ⊑  smul_neg1_vec_poison_combined := by
  unfold smul_neg1_vec_poison_before smul_neg1_vec_poison_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_smul_neg1_vec_poison   : smul_neg1_vec_poison_before  ⊑  smul_neg1_vec_poison_combined := by
  unfold smul_neg1_vec_poison_before smul_neg1_vec_poison_combined
  simp_alive_peephole
  sorry
def smul_neg2_combined := [llvmfunc|
  llvm.func @smul_neg2(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_smul_neg2   : smul_neg2_before  ⊑  smul_neg2_combined := by
  unfold smul_neg2_before smul_neg2_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i8
  }]

theorem inst_combine_smul_neg2   : smul_neg2_before  ⊑  smul_neg2_combined := by
  unfold smul_neg2_before smul_neg2_combined
  simp_alive_peephole
  sorry
def umul_neg1_combined := [llvmfunc|
  llvm.func @umul_neg1(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_umul_neg1   : umul_neg1_before  ⊑  umul_neg1_combined := by
  unfold umul_neg1_before umul_neg1_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i8
  }]

theorem inst_combine_umul_neg1   : umul_neg1_before  ⊑  umul_neg1_combined := by
  unfold umul_neg1_before umul_neg1_combined
  simp_alive_peephole
  sorry
def umul_neg1_vec_combined := [llvmfunc|
  llvm.func @umul_neg1_vec(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.sub %1, %arg0  : vector<4xi8>
    %4 = llvm.icmp "ugt" %arg0, %2 : vector<4xi8>
    llvm.store %4, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr]

theorem inst_combine_umul_neg1_vec   : umul_neg1_vec_before  ⊑  umul_neg1_vec_combined := by
  unfold umul_neg1_vec_before umul_neg1_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_umul_neg1_vec   : umul_neg1_vec_before  ⊑  umul_neg1_vec_combined := by
  unfold umul_neg1_vec_before umul_neg1_vec_combined
  simp_alive_peephole
  sorry
def umul_neg1_vec_poison_combined := [llvmfunc|
  llvm.func @umul_neg1_vec_poison(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.sub %1, %arg0  : vector<4xi8>
    %4 = llvm.icmp "ugt" %arg0, %2 : vector<4xi8>
    llvm.store %4, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr]

theorem inst_combine_umul_neg1_vec_poison   : umul_neg1_vec_poison_before  ⊑  umul_neg1_vec_poison_combined := by
  unfold umul_neg1_vec_poison_before umul_neg1_vec_poison_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_umul_neg1_vec_poison   : umul_neg1_vec_poison_before  ⊑  umul_neg1_vec_poison_combined := by
  unfold umul_neg1_vec_poison_before umul_neg1_vec_poison_combined
  simp_alive_peephole
  sorry
def smul_not_neg1_vec_combined := [llvmfunc|
  llvm.func @smul_not_neg1_vec(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<-43> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<-85> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.add %arg0, %0  : vector<4xi8>
    %3 = llvm.icmp "ult" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }]

theorem inst_combine_smul_not_neg1_vec   : smul_not_neg1_vec_before  ⊑  smul_not_neg1_vec_combined := by
  unfold smul_not_neg1_vec_before smul_not_neg1_vec_combined
  simp_alive_peephole
  sorry
def umul_neg1_select_combined := [llvmfunc|
  llvm.func @umul_neg1_select(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.sext %1 : i1 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umul_neg1_select   : umul_neg1_select_before  ⊑  umul_neg1_select_combined := by
  unfold umul_neg1_select_before umul_neg1_select_combined
  simp_alive_peephole
  sorry
def umul_2_combined := [llvmfunc|
  llvm.func @umul_2(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "slt" %arg0, %1 : i8
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_umul_2   : umul_2_before  ⊑  umul_2_combined := by
  unfold umul_2_before umul_2_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i8
  }]

theorem inst_combine_umul_2   : umul_2_before  ⊑  umul_2_combined := by
  unfold umul_2_before umul_2_combined
  simp_alive_peephole
  sorry
def umul_8_combined := [llvmfunc|
  llvm.func @umul_8(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_umul_8   : umul_8_before  ⊑  umul_8_combined := by
  unfold umul_8_before umul_8_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i8
  }]

theorem inst_combine_umul_8   : umul_8_before  ⊑  umul_8_combined := by
  unfold umul_8_before umul_8_combined
  simp_alive_peephole
  sorry
def umul_64_combined := [llvmfunc|
  llvm.func @umul_64(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_umul_64   : umul_64_before  ⊑  umul_64_combined := by
  unfold umul_64_before umul_64_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i8
  }]

theorem inst_combine_umul_64   : umul_64_before  ⊑  umul_64_combined := by
  unfold umul_64_before umul_64_combined
  simp_alive_peephole
  sorry
def umul_256_combined := [llvmfunc|
  llvm.func @umul_256(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    llvm.store %0, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_umul_256   : umul_256_before  ⊑  umul_256_combined := by
  unfold umul_256_before umul_256_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i8
  }]

theorem inst_combine_umul_256   : umul_256_before  ⊑  umul_256_combined := by
  unfold umul_256_before umul_256_combined
  simp_alive_peephole
  sorry
def umul_4_vec_poison_combined := [llvmfunc|
  llvm.func @umul_4_vec_poison(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<63> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shl %arg0, %0  : vector<4xi8>
    %3 = llvm.icmp "ugt" %arg0, %1 : vector<4xi8>
    llvm.store %3, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr]

theorem inst_combine_umul_4_vec_poison   : umul_4_vec_poison_before  ⊑  umul_4_vec_poison_combined := by
  unfold umul_4_vec_poison_before umul_4_vec_poison_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<4xi8>
  }]

theorem inst_combine_umul_4_vec_poison   : umul_4_vec_poison_before  ⊑  umul_4_vec_poison_combined := by
  unfold umul_4_vec_poison_before umul_4_vec_poison_combined
  simp_alive_peephole
  sorry
def umul_3_combined := [llvmfunc|
  llvm.func @umul_3(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_umul_3   : umul_3_before  ⊑  umul_3_combined := by
  unfold umul_3_before umul_3_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i8
  }]

theorem inst_combine_umul_3   : umul_3_before  ⊑  umul_3_combined := by
  unfold umul_3_before umul_3_combined
  simp_alive_peephole
  sorry
def smul_4_combined := [llvmfunc|
  llvm.func @smul_4(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.mlir.constant(-64 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.store %5, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_smul_4   : smul_4_before  ⊑  smul_4_combined := by
  unfold smul_4_before smul_4_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i8
  }]

theorem inst_combine_smul_4   : smul_4_before  ⊑  smul_4_combined := by
  unfold smul_4_before smul_4_combined
  simp_alive_peephole
  sorry
def smul_16_combined := [llvmfunc|
  llvm.func @smul_16(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.mlir.constant(-16 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.store %5, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_smul_16   : smul_16_before  ⊑  smul_16_combined := by
  unfold smul_16_before smul_16_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i8
  }]

theorem inst_combine_smul_16   : smul_16_before  ⊑  smul_16_combined := by
  unfold smul_16_before smul_16_combined
  simp_alive_peephole
  sorry
def smul_32_combined := [llvmfunc|
  llvm.func @smul_32(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.store %5, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_smul_32   : smul_32_before  ⊑  smul_32_combined := by
  unfold smul_32_before smul_32_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i8
  }]

theorem inst_combine_smul_32   : smul_32_before  ⊑  smul_32_combined := by
  unfold smul_32_before smul_32_combined
  simp_alive_peephole
  sorry
def smul_128_combined := [llvmfunc|
  llvm.func @smul_128(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_smul_128   : smul_128_before  ⊑  smul_128_combined := by
  unfold smul_128_before smul_128_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i8
  }]

theorem inst_combine_smul_128   : smul_128_before  ⊑  smul_128_combined := by
  unfold smul_128_before smul_128_combined
  simp_alive_peephole
  sorry
def smul_2_vec_poison_combined := [llvmfunc|
  llvm.func @smul_2_vec_poison(%arg0: vector<4xi8>, %arg1: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<64> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %4 = llvm.shl %arg0, %0  : vector<4xi8>
    %5 = llvm.add %arg0, %1  : vector<4xi8>
    %6 = llvm.icmp "slt" %5, %3 : vector<4xi8>
    llvm.store %6, %arg1 {alignment = 1 : i64} : vector<4xi1>, !llvm.ptr]

theorem inst_combine_smul_2_vec_poison   : smul_2_vec_poison_before  ⊑  smul_2_vec_poison_combined := by
  unfold smul_2_vec_poison_before smul_2_vec_poison_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<4xi8>
  }]

theorem inst_combine_smul_2_vec_poison   : smul_2_vec_poison_before  ⊑  smul_2_vec_poison_combined := by
  unfold smul_2_vec_poison_before smul_2_vec_poison_combined
  simp_alive_peephole
  sorry
def smul_7_combined := [llvmfunc|
  llvm.func @smul_7(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i8, i1)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_smul_7   : smul_7_before  ⊑  smul_7_combined := by
  unfold smul_7_before smul_7_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i8
  }]

theorem inst_combine_smul_7   : smul_7_before  ⊑  smul_7_combined := by
  unfold smul_7_before smul_7_combined
  simp_alive_peephole
  sorry
