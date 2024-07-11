import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  not
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

def invert_icmp_before := [llvmfunc|
  llvm.func @invert_icmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

def invert_fcmp_before := [llvmfunc|
  llvm.func @invert_fcmp(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f32
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

def not_not_cmp_before := [llvmfunc|
  llvm.func @not_not_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "slt" %1, %2 : i32
    llvm.return %3 : i1
  }]

def not_not_cmp_vector_before := [llvmfunc|
  llvm.func @not_not_cmp_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.xor %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "ugt" %1, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def not_cmp_constant_before := [llvmfunc|
  llvm.func @not_cmp_constant(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def not_cmp_constant_vector_before := [llvmfunc|
  llvm.func @not_cmp_constant_vector(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.xor %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.icmp "sle" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def not_ashr_not_before := [llvmfunc|
  llvm.func @not_ashr_not(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.ashr %1, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

def not_ashr_const_before := [llvmfunc|
  llvm.func @not_ashr_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_ashr_const_splat_before := [llvmfunc|
  llvm.func @not_ashr_const_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %0, %arg0  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def not_lshr_const_negative_before := [llvmfunc|
  llvm.func @not_lshr_const_negative(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_lshr_const_before := [llvmfunc|
  llvm.func @not_lshr_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_lshr_const_splat_before := [llvmfunc|
  llvm.func @not_lshr_const_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %0, %arg0  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def not_sub_before := [llvmfunc|
  llvm.func @not_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

def not_sub_extra_use_before := [llvmfunc|
  llvm.func @not_sub_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

def not_sub_splat_before := [llvmfunc|
  llvm.func @not_sub_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def not_sub_extra_use_splat_before := [llvmfunc|
  llvm.func @not_sub_extra_use_splat(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def not_sub_vec_before := [llvmfunc|
  llvm.func @not_sub_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 123]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def not_sub_extra_use_vec_before := [llvmfunc|
  llvm.func @not_sub_extra_use_vec(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[123, 42]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def not_add_before := [llvmfunc|
  llvm.func @not_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }]

def not_add_splat_before := [llvmfunc|
  llvm.func @not_add_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def not_add_vec_before := [llvmfunc|
  llvm.func @not_add_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 123]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def not_select_cmp_cmp_before := [llvmfunc|
  llvm.func @not_select_cmp_cmp(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

def not_select_cmp_cmp_extra_use1_before := [llvmfunc|
  llvm.func @not_select_cmp_cmp_extra_use1(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

def not_select_cmp_cmp_extra_use2_before := [llvmfunc|
  llvm.func @not_select_cmp_cmp_extra_use2(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

def not_select_cmp_cmp_extra_use3_before := [llvmfunc|
  llvm.func @not_select_cmp_cmp_extra_use3(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

def not_select_cmp_cmp_extra_use4_before := [llvmfunc|
  llvm.func @not_select_cmp_cmp_extra_use4(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

def not_select_cmpt_before := [llvmfunc|
  llvm.func @not_select_cmpt(%arg0: f64, %arg1: f64, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.select %arg3, %1, %arg2 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

def not_select_cmpf_before := [llvmfunc|
  llvm.func @not_select_cmpf(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg1, %arg2 : i32
    %2 = llvm.select %arg3, %arg0, %1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

def not_select_cmpt_extra_use_before := [llvmfunc|
  llvm.func @not_select_cmpt_extra_use(%arg0: f64, %arg1: f64, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.select %arg3, %1, %arg2 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

def not_select_cmpf_extra_use_before := [llvmfunc|
  llvm.func @not_select_cmpf_extra_use(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg1, %arg2 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.select %arg3, %arg0, %1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

def not_or_neg_before := [llvmfunc|
  llvm.func @not_or_neg(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }]

def not_or_neg_commute_vec_before := [llvmfunc|
  llvm.func @not_or_neg_commute_vec(%arg0: vector<3xi5>, %arg1: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(3 : i5) : i5
    %1 = llvm.mlir.constant(2 : i5) : i5
    %2 = llvm.mlir.constant(1 : i5) : i5
    %3 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi5>) : vector<3xi5>
    %4 = llvm.mlir.poison : i5
    %5 = llvm.mlir.constant(0 : i5) : i5
    %6 = llvm.mlir.undef : vector<3xi5>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<3xi5>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %5, %8[%9 : i32] : vector<3xi5>
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.insertelement %4, %10[%11 : i32] : vector<3xi5>
    %13 = llvm.mlir.constant(-1 : i5) : i5
    %14 = llvm.mlir.undef : vector<3xi5>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<3xi5>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %4, %16[%17 : i32] : vector<3xi5>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %13, %18[%19 : i32] : vector<3xi5>
    %21 = llvm.mul %arg1, %3  : vector<3xi5>
    %22 = llvm.sub %12, %arg0  : vector<3xi5>
    %23 = llvm.or %21, %22  : vector<3xi5>
    %24 = llvm.xor %23, %20  : vector<3xi5>
    llvm.return %24 : vector<3xi5>
  }]

def not_or_neg_use1_before := [llvmfunc|
  llvm.func @not_or_neg_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }]

def not_or_neg_use2_before := [llvmfunc|
  llvm.func @not_or_neg_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.or %2, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }]

def not_select_bool_before := [llvmfunc|
  llvm.func @not_select_bool(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

def not_select_bool_const1_before := [llvmfunc|
  llvm.func @not_select_bool_const1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

def not_select_bool_const2_before := [llvmfunc|
  llvm.func @not_select_bool_const2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }]

def not_select_bool_const3_before := [llvmfunc|
  llvm.func @not_select_bool_const3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

def not_select_bool_const4_before := [llvmfunc|
  llvm.func @not_select_bool_const4(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }]

def not_logicalAnd_not_op0_before := [llvmfunc|
  llvm.func @not_logicalAnd_not_op0(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.select %4, %arg1, %3 : vector<2xi1>, vector<2xi1>
    %6 = llvm.xor %5, %1  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def not_logicalAnd_not_op1_before := [llvmfunc|
  llvm.func @not_logicalAnd_not_op1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

def not_logicalAnd_not_op0_use1_before := [llvmfunc|
  llvm.func @not_logicalAnd_not_op0_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

def not_logicalAnd_not_op0_use2_before := [llvmfunc|
  llvm.func @not_logicalAnd_not_op0_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

def not_logicalOr_not_op0_before := [llvmfunc|
  llvm.func @not_logicalOr_not_op0(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.select %2, %1, %arg1 : vector<2xi1>, vector<2xi1>
    %4 = llvm.xor %3, %1  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def not_logicalOr_not_op1_before := [llvmfunc|
  llvm.func @not_logicalOr_not_op1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

def not_logicalOr_not_op0_use1_before := [llvmfunc|
  llvm.func @not_logicalOr_not_op0_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

def not_logicalOr_not_op0_use2_before := [llvmfunc|
  llvm.func @not_logicalOr_not_op0_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

def bitcast_to_wide_elts_sext_bool_before := [llvmfunc|
  llvm.func @bitcast_to_wide_elts_sext_bool(%arg0: vector<4xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %2 = llvm.bitcast %1 : vector<4xi32> to vector<2xi64>
    %3 = llvm.xor %2, %0  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def bitcast_to_narrow_elts_sext_bool_before := [llvmfunc|
  llvm.func @bitcast_to_narrow_elts_sext_bool(%arg0: vector<4xi1>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %2 = llvm.bitcast %1 : vector<4xi32> to vector<8xi16>
    %3 = llvm.xor %2, %0  : vector<8xi16>
    llvm.return %3 : vector<8xi16>
  }]

def bitcast_to_vec_sext_bool_before := [llvmfunc|
  llvm.func @bitcast_to_vec_sext_bool(%arg0: i1) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.bitcast %1 : i32 to vector<2xi16>
    %3 = llvm.xor %2, %0  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def bitcast_to_scalar_sext_bool_before := [llvmfunc|
  llvm.func @bitcast_to_scalar_sext_bool(%arg0: vector<4xi1>) -> i128 {
    %0 = llvm.mlir.constant(-1 : i128) : i128
    %1 = llvm.sext %arg0 : vector<4xi1> to vector<4xi32>
    %2 = llvm.bitcast %1 : vector<4xi32> to i128
    %3 = llvm.xor %2, %0  : i128
    llvm.return %3 : i128
  }]

def bitcast_to_vec_sext_bool_use1_before := [llvmfunc|
  llvm.func @bitcast_to_vec_sext_bool_use1(%arg0: i1) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sext %arg0 : i1 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.bitcast %2 : i8 to vector<2xi4>
    %4 = llvm.xor %3, %1  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

def bitcast_to_scalar_sext_bool_use2_before := [llvmfunc|
  llvm.func @bitcast_to_scalar_sext_bool_use2(%arg0: vector<4xi1>) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sext %arg0 : vector<4xi1> to vector<4xi2>
    %2 = llvm.bitcast %1 : vector<4xi2> to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def invert_both_cmp_operands_add_before := [llvmfunc|
  llvm.func @invert_both_cmp_operands_add(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %arg1, %2  : i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    llvm.return %4 : i1
  }]

def invert_both_cmp_operands_sub_before := [llvmfunc|
  llvm.func @invert_both_cmp_operands_sub(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.sub %2, %arg1  : i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    llvm.return %4 : i1
  }]

def invert_both_cmp_operands_complex_before := [llvmfunc|
  llvm.func @invert_both_cmp_operands_complex(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg2, %0  : i32
    %3 = llvm.xor %arg3, %0  : i32
    %4 = llvm.add %arg3, %1  : i32
    %5 = llvm.select %arg0, %4, %2 : i1, i32
    %6 = llvm.icmp "sle" %5, %3 : i32
    llvm.return %6 : i1
  }]

def test_sext_before := [llvmfunc|
  llvm.func @test_sext(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.sext %2 : i1 to i32
    %4 = llvm.add %arg1, %3  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

def test_sext_vec_before := [llvmfunc|
  llvm.func @test_sext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi1> to vector<2xi32>
    %5 = llvm.add %arg1, %4  : vector<2xi32>
    %6 = llvm.xor %5, %2  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def test_zext_nneg_before := [llvmfunc|
  llvm.func @test_zext_nneg(%arg0: i32, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i64) : i64
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.add %arg1, %1  : i64
    %5 = llvm.add %3, %arg2  : i64
    %6 = llvm.sub %4, %5  : i64
    llvm.return %6 : i64
  }]

def test_trunc_before := [llvmfunc|
  llvm.func @test_trunc(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.add %3, %0 overflow<nsw>  : i32
    %5 = llvm.ashr %4, %1  : i32
    %6 = llvm.trunc %5 : i32 to i8
    %7 = llvm.xor %6, %2  : i8
    llvm.return %7 : i8
  }]

def test_trunc_vec_before := [llvmfunc|
  llvm.func @test_trunc_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %4 = llvm.add %3, %0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.ashr %4, %1  : vector<2xi32>
    %6 = llvm.trunc %5 : vector<2xi32> to vector<2xi8>
    %7 = llvm.xor %6, %2  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

def test_zext_before := [llvmfunc|
  llvm.func @test_zext(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.add %arg1, %3  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

def test_invert_demorgan_or_before := [llvmfunc|
  llvm.func @test_invert_demorgan_or(%arg0: i32, %arg1: i32, %arg2: i1) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.or %2, %3  : i1
    %5 = llvm.xor %arg2, %1  : i1
    %6 = llvm.or %5, %4  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @f1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @f2() : () -> ()
    llvm.unreachable
  }]

def test_invert_demorgan_or2_before := [llvmfunc|
  llvm.func @test_invert_demorgan_or2(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.mlir.constant(23 : i64) : i64
    %1 = llvm.mlir.constant(59 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i64
    %4 = llvm.icmp "ugt" %arg1, %1 : i64
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.icmp "ugt" %arg2, %1 : i64
    %7 = llvm.or %5, %6  : i1
    %8 = llvm.xor %7, %2  : i1
    llvm.return %8 : i1
  }]

def test_invert_demorgan_or3_before := [llvmfunc|
  llvm.func @test_invert_demorgan_or3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(178206 : i32) : i32
    %1 = llvm.mlir.constant(-195102 : i32) : i32
    %2 = llvm.mlir.constant(1506 : i32) : i32
    %3 = llvm.mlir.constant(-201547 : i32) : i32
    %4 = llvm.mlir.constant(716213 : i32) : i32
    %5 = llvm.mlir.constant(-918000 : i32) : i32
    %6 = llvm.mlir.constant(196112 : i32) : i32
    %7 = llvm.mlir.constant(true) : i1
    %8 = llvm.icmp "eq" %arg0, %0 : i32
    %9 = llvm.add %arg1, %1  : i32
    %10 = llvm.icmp "ult" %9, %2 : i32
    %11 = llvm.add %arg1, %3  : i32
    %12 = llvm.icmp "ult" %11, %4 : i32
    %13 = llvm.add %arg1, %5  : i32
    %14 = llvm.icmp "ult" %13, %6 : i32
    %15 = llvm.or %8, %10  : i1
    %16 = llvm.or %15, %12  : i1
    %17 = llvm.or %16, %14  : i1
    %18 = llvm.xor %17, %7  : i1
    llvm.return %18 : i1
  }]

def test_invert_demorgan_logical_or_before := [llvmfunc|
  llvm.func @test_invert_demorgan_logical_or(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(27 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i64
    %4 = llvm.icmp "eq" %arg1, %1 : i64
    %5 = llvm.select %3, %2, %4 : i1, i1
    %6 = llvm.icmp "eq" %arg0, %1 : i64
    %7 = llvm.or %6, %5  : i1
    %8 = llvm.xor %7, %2  : i1
    llvm.return %8 : i1
  }]

def test_invert_demorgan_and_before := [llvmfunc|
  llvm.func @test_invert_demorgan_and(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.xor %arg2, %1  : i1
    %6 = llvm.and %5, %4  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @f1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @f2() : () -> ()
    llvm.unreachable
  }]

def test_invert_demorgan_and2_before := [llvmfunc|
  llvm.func @test_invert_demorgan_and2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(9223372036854775807 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.add %arg0, %0  : i64
    %3 = llvm.and %2, %0  : i64
    %4 = llvm.xor %3, %1  : i64
    llvm.return %4 : i64
  }]

def test_invert_demorgan_and3_before := [llvmfunc|
  llvm.func @test_invert_demorgan_and3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(4095 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.add %arg1, %3  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

def test_invert_demorgan_logical_and_before := [llvmfunc|
  llvm.func @test_invert_demorgan_logical_and(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(27 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg0, %0 : i64
    %5 = llvm.icmp "eq" %arg1, %1 : i64
    %6 = llvm.select %4, %5, %2 : i1, i1
    %7 = llvm.icmp "eq" %arg0, %1 : i64
    %8 = llvm.or %7, %6  : i1
    %9 = llvm.xor %8, %3  : i1
    llvm.return %9 : i1
  }]

def test_invert_demorgan_and_multiuse_before := [llvmfunc|
  llvm.func @test_invert_demorgan_and_multiuse(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.xor %arg2, %1  : i1
    %6 = llvm.and %5, %4  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @f1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @f2() : () -> ()
    llvm.unreachable
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def invert_icmp_combined := [llvmfunc|
  llvm.func @invert_icmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_invert_icmp   : invert_icmp_before  ⊑  invert_icmp_combined := by
  unfold invert_icmp_before invert_icmp_combined
  simp_alive_peephole
  sorry
def invert_fcmp_combined := [llvmfunc|
  llvm.func @invert_fcmp(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f32
    llvm.return %0 : i1
  }]

theorem inst_combine_invert_fcmp   : invert_fcmp_before  ⊑  invert_fcmp_combined := by
  unfold invert_fcmp_before invert_fcmp_combined
  simp_alive_peephole
  sorry
def not_not_cmp_combined := [llvmfunc|
  llvm.func @not_not_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_not_not_cmp   : not_not_cmp_before  ⊑  not_not_cmp_combined := by
  unfold not_not_cmp_before not_not_cmp_combined
  simp_alive_peephole
  sorry
def not_not_cmp_vector_combined := [llvmfunc|
  llvm.func @not_not_cmp_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "ult" %arg0, %arg1 : vector<2xi32>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_not_not_cmp_vector   : not_not_cmp_vector_before  ⊑  not_not_cmp_vector_combined := by
  unfold not_not_cmp_vector_before not_not_cmp_vector_combined
  simp_alive_peephole
  sorry
def not_cmp_constant_combined := [llvmfunc|
  llvm.func @not_cmp_constant(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-43 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_not_cmp_constant   : not_cmp_constant_before  ⊑  not_cmp_constant_combined := by
  unfold not_cmp_constant_before not_cmp_constant_combined
  simp_alive_peephole
  sorry
def not_cmp_constant_vector_combined := [llvmfunc|
  llvm.func @not_cmp_constant_vector(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-43> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_not_cmp_constant_vector   : not_cmp_constant_vector_before  ⊑  not_cmp_constant_vector_combined := by
  unfold not_cmp_constant_vector_before not_cmp_constant_vector_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : vector<2xi32>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def not_ashr_not_combined := [llvmfunc|
  llvm.func @not_ashr_not(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_not_ashr_not   : not_ashr_not_before  ⊑  not_ashr_not_combined := by
  unfold not_ashr_not_before not_ashr_not_combined
  simp_alive_peephole
  sorry
def not_ashr_const_combined := [llvmfunc|
  llvm.func @not_ashr_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(41 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_not_ashr_const   : not_ashr_const_before  ⊑  not_ashr_const_combined := by
  unfold not_ashr_const_before not_ashr_const_combined
  simp_alive_peephole
  sorry
def not_ashr_const_splat_combined := [llvmfunc|
  llvm.func @not_ashr_const_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<41> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %0, %arg0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_not_ashr_const_splat   : not_ashr_const_splat_before  ⊑  not_ashr_const_splat_combined := by
  unfold not_ashr_const_splat_before not_ashr_const_splat_combined
  simp_alive_peephole
  sorry
def not_lshr_const_negative_combined := [llvmfunc|
  llvm.func @not_lshr_const_negative(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_lshr_const_negative   : not_lshr_const_negative_before  ⊑  not_lshr_const_negative_combined := by
  unfold not_lshr_const_negative_before not_lshr_const_negative_combined
  simp_alive_peephole
  sorry
def not_lshr_const_combined := [llvmfunc|
  llvm.func @not_lshr_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-43 : i8) : i8
    %1 = llvm.ashr %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_not_lshr_const   : not_lshr_const_before  ⊑  not_lshr_const_combined := by
  unfold not_lshr_const_before not_lshr_const_combined
  simp_alive_peephole
  sorry
def not_lshr_const_splat_combined := [llvmfunc|
  llvm.func @not_lshr_const_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-43> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %0, %arg0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_not_lshr_const_splat   : not_lshr_const_splat_before  ⊑  not_lshr_const_splat_combined := by
  unfold not_lshr_const_splat_before not_lshr_const_splat_combined
  simp_alive_peephole
  sorry
def not_sub_combined := [llvmfunc|
  llvm.func @not_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-124 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_not_sub   : not_sub_before  ⊑  not_sub_combined := by
  unfold not_sub_before not_sub_combined
  simp_alive_peephole
  sorry
def not_sub_extra_use_combined := [llvmfunc|
  llvm.func @not_sub_extra_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.constant(-124 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.add %arg0, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_sub_extra_use   : not_sub_extra_use_before  ⊑  not_sub_extra_use_combined := by
  unfold not_sub_extra_use_before not_sub_extra_use_combined
  simp_alive_peephole
  sorry
def not_sub_splat_combined := [llvmfunc|
  llvm.func @not_sub_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-124> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_not_sub_splat   : not_sub_splat_before  ⊑  not_sub_splat_combined := by
  unfold not_sub_splat_before not_sub_splat_combined
  simp_alive_peephole
  sorry
def not_sub_extra_use_splat_combined := [llvmfunc|
  llvm.func @not_sub_extra_use_splat(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-124> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %3 = llvm.add %arg0, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_not_sub_extra_use_splat   : not_sub_extra_use_splat_before  ⊑  not_sub_extra_use_splat_combined := by
  unfold not_sub_extra_use_splat_before not_sub_extra_use_splat_combined
  simp_alive_peephole
  sorry
def not_sub_vec_combined := [llvmfunc|
  llvm.func @not_sub_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-43, -124]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_not_sub_vec   : not_sub_vec_before  ⊑  not_sub_vec_combined := by
  unfold not_sub_vec_before not_sub_vec_combined
  simp_alive_peephole
  sorry
def not_sub_extra_use_vec_combined := [llvmfunc|
  llvm.func @not_sub_extra_use_vec(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[123, 42]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-124, -43]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %3 = llvm.add %arg0, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_not_sub_extra_use_vec   : not_sub_extra_use_vec_before  ⊑  not_sub_extra_use_vec_combined := by
  unfold not_sub_extra_use_vec_before not_sub_extra_use_vec_combined
  simp_alive_peephole
  sorry
def not_add_combined := [llvmfunc|
  llvm.func @not_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-124 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_not_add   : not_add_before  ⊑  not_add_combined := by
  unfold not_add_before not_add_combined
  simp_alive_peephole
  sorry
def not_add_splat_combined := [llvmfunc|
  llvm.func @not_add_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-124> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sub %0, %arg0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_not_add_splat   : not_add_splat_before  ⊑  not_add_splat_combined := by
  unfold not_add_splat_before not_add_splat_combined
  simp_alive_peephole
  sorry
def not_add_vec_combined := [llvmfunc|
  llvm.func @not_add_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-43, -124]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sub %0, %arg0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_not_add_vec   : not_add_vec_before  ⊑  not_add_vec_combined := by
  unfold not_add_vec_before not_add_vec_combined
  simp_alive_peephole
  sorry
def not_select_cmp_cmp_combined := [llvmfunc|
  llvm.func @not_select_cmp_cmp(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.fcmp "ole" %arg2, %arg3 : f32
    %2 = llvm.select %arg4, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_not_select_cmp_cmp   : not_select_cmp_cmp_before  ⊑  not_select_cmp_cmp_combined := by
  unfold not_select_cmp_cmp_before not_select_cmp_cmp_combined
  simp_alive_peephole
  sorry
def not_select_cmp_cmp_extra_use1_combined := [llvmfunc|
  llvm.func @not_select_cmp_cmp_extra_use1(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_not_select_cmp_cmp_extra_use1   : not_select_cmp_cmp_extra_use1_before  ⊑  not_select_cmp_cmp_extra_use1_combined := by
  unfold not_select_cmp_cmp_extra_use1_before not_select_cmp_cmp_extra_use1_combined
  simp_alive_peephole
  sorry
def not_select_cmp_cmp_extra_use2_combined := [llvmfunc|
  llvm.func @not_select_cmp_cmp_extra_use2(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_not_select_cmp_cmp_extra_use2   : not_select_cmp_cmp_extra_use2_before  ⊑  not_select_cmp_cmp_extra_use2_combined := by
  unfold not_select_cmp_cmp_extra_use2_before not_select_cmp_cmp_extra_use2_combined
  simp_alive_peephole
  sorry
def not_select_cmp_cmp_extra_use3_combined := [llvmfunc|
  llvm.func @not_select_cmp_cmp_extra_use3(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_not_select_cmp_cmp_extra_use3   : not_select_cmp_cmp_extra_use3_before  ⊑  not_select_cmp_cmp_extra_use3_combined := by
  unfold not_select_cmp_cmp_extra_use3_before not_select_cmp_cmp_extra_use3_combined
  simp_alive_peephole
  sorry
def not_select_cmp_cmp_extra_use4_combined := [llvmfunc|
  llvm.func @not_select_cmp_cmp_extra_use4(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: f32, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    %2 = llvm.fcmp "ugt" %arg2, %arg3 : f32
    %3 = llvm.select %arg4, %1, %2 : i1, i1
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_not_select_cmp_cmp_extra_use4   : not_select_cmp_cmp_extra_use4_before  ⊑  not_select_cmp_cmp_extra_use4_combined := by
  unfold not_select_cmp_cmp_extra_use4_before not_select_cmp_cmp_extra_use4_combined
  simp_alive_peephole
  sorry
def not_select_cmpt_combined := [llvmfunc|
  llvm.func @not_select_cmpt(%arg0: f64, %arg1: f64, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.select %arg3, %1, %arg2 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_select_cmpt   : not_select_cmpt_before  ⊑  not_select_cmpt_combined := by
  unfold not_select_cmpt_before not_select_cmpt_combined
  simp_alive_peephole
  sorry
def not_select_cmpf_combined := [llvmfunc|
  llvm.func @not_select_cmpf(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg1, %arg2 : i32
    %2 = llvm.select %arg3, %arg0, %1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_select_cmpf   : not_select_cmpf_before  ⊑  not_select_cmpf_combined := by
  unfold not_select_cmpf_before not_select_cmpf_combined
  simp_alive_peephole
  sorry
def not_select_cmpt_extra_use_combined := [llvmfunc|
  llvm.func @not_select_cmpt_extra_use(%arg0: f64, %arg1: f64, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.select %arg3, %1, %arg2 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_select_cmpt_extra_use   : not_select_cmpt_extra_use_before  ⊑  not_select_cmpt_extra_use_combined := by
  unfold not_select_cmpt_extra_use_before not_select_cmpt_extra_use_combined
  simp_alive_peephole
  sorry
def not_select_cmpf_extra_use_combined := [llvmfunc|
  llvm.func @not_select_cmpf_extra_use(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg1, %arg2 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.select %arg3, %arg0, %1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_select_cmpf_extra_use   : not_select_cmpf_extra_use_before  ⊑  not_select_cmpf_extra_use_combined := by
  unfold not_select_cmpf_extra_use_before not_select_cmpf_extra_use_combined
  simp_alive_peephole
  sorry
def not_or_neg_combined := [llvmfunc|
  llvm.func @not_or_neg(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg1, %0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.and %1, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_or_neg   : not_or_neg_before  ⊑  not_or_neg_combined := by
  unfold not_or_neg_before not_or_neg_combined
  simp_alive_peephole
  sorry
def not_or_neg_commute_vec_combined := [llvmfunc|
  llvm.func @not_or_neg_commute_vec(%arg0: vector<3xi5>, %arg1: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(3 : i5) : i5
    %1 = llvm.mlir.constant(2 : i5) : i5
    %2 = llvm.mlir.constant(1 : i5) : i5
    %3 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi5>) : vector<3xi5>
    %4 = llvm.mlir.constant(-1 : i5) : i5
    %5 = llvm.mlir.constant(dense<-1> : vector<3xi5>) : vector<3xi5>
    %6 = llvm.mul %arg1, %3  : vector<3xi5>
    %7 = llvm.add %arg0, %5  : vector<3xi5>
    %8 = llvm.xor %6, %5  : vector<3xi5>
    %9 = llvm.and %7, %8  : vector<3xi5>
    llvm.return %9 : vector<3xi5>
  }]

theorem inst_combine_not_or_neg_commute_vec   : not_or_neg_commute_vec_before  ⊑  not_or_neg_commute_vec_combined := by
  unfold not_or_neg_commute_vec_before not_or_neg_commute_vec_combined
  simp_alive_peephole
  sorry
def not_or_neg_use1_combined := [llvmfunc|
  llvm.func @not_or_neg_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_not_or_neg_use1   : not_or_neg_use1_before  ⊑  not_or_neg_use1_combined := by
  unfold not_or_neg_use1_before not_or_neg_use1_combined
  simp_alive_peephole
  sorry
def not_or_neg_use2_combined := [llvmfunc|
  llvm.func @not_or_neg_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.or %2, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_not_or_neg_use2   : not_or_neg_use2_before  ⊑  not_or_neg_use2_combined := by
  unfold not_or_neg_use2_before not_or_neg_use2_combined
  simp_alive_peephole
  sorry
def not_select_bool_combined := [llvmfunc|
  llvm.func @not_select_bool(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_not_select_bool   : not_select_bool_before  ⊑  not_select_bool_combined := by
  unfold not_select_bool_before not_select_bool_combined
  simp_alive_peephole
  sorry
def not_select_bool_const1_combined := [llvmfunc|
  llvm.func @not_select_bool_const1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_select_bool_const1   : not_select_bool_const1_before  ⊑  not_select_bool_const1_combined := by
  unfold not_select_bool_const1_before not_select_bool_const1_combined
  simp_alive_peephole
  sorry
def not_select_bool_const2_combined := [llvmfunc|
  llvm.func @not_select_bool_const2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_select_bool_const2   : not_select_bool_const2_before  ⊑  not_select_bool_const2_combined := by
  unfold not_select_bool_const2_before not_select_bool_const2_combined
  simp_alive_peephole
  sorry
def not_select_bool_const3_combined := [llvmfunc|
  llvm.func @not_select_bool_const3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_not_select_bool_const3   : not_select_bool_const3_before  ⊑  not_select_bool_const3_combined := by
  unfold not_select_bool_const3_before not_select_bool_const3_combined
  simp_alive_peephole
  sorry
def not_select_bool_const4_combined := [llvmfunc|
  llvm.func @not_select_bool_const4(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_not_select_bool_const4   : not_select_bool_const4_before  ⊑  not_select_bool_const4_combined := by
  unfold not_select_bool_const4_before not_select_bool_const4_combined
  simp_alive_peephole
  sorry
def not_logicalAnd_not_op0_combined := [llvmfunc|
  llvm.func @not_logicalAnd_not_op0(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg1, %1  : vector<2xi1>
    %3 = llvm.select %arg0, %1, %2 : vector<2xi1>, vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_not_logicalAnd_not_op0   : not_logicalAnd_not_op0_before  ⊑  not_logicalAnd_not_op0_combined := by
  unfold not_logicalAnd_not_op0_before not_logicalAnd_not_op0_combined
  simp_alive_peephole
  sorry
def not_logicalAnd_not_op1_combined := [llvmfunc|
  llvm.func @not_logicalAnd_not_op1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_not_logicalAnd_not_op1   : not_logicalAnd_not_op1_before  ⊑  not_logicalAnd_not_op1_combined := by
  unfold not_logicalAnd_not_op1_before not_logicalAnd_not_op1_combined
  simp_alive_peephole
  sorry
def not_logicalAnd_not_op0_use1_combined := [llvmfunc|
  llvm.func @not_logicalAnd_not_op0_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %arg0, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_logicalAnd_not_op0_use1   : not_logicalAnd_not_op0_use1_before  ⊑  not_logicalAnd_not_op0_use1_combined := by
  unfold not_logicalAnd_not_op0_use1_before not_logicalAnd_not_op0_use1_combined
  simp_alive_peephole
  sorry
def not_logicalAnd_not_op0_use2_combined := [llvmfunc|
  llvm.func @not_logicalAnd_not_op0_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_not_logicalAnd_not_op0_use2   : not_logicalAnd_not_op0_use2_before  ⊑  not_logicalAnd_not_op0_use2_combined := by
  unfold not_logicalAnd_not_op0_use2_before not_logicalAnd_not_op0_use2_combined
  simp_alive_peephole
  sorry
def not_logicalOr_not_op0_combined := [llvmfunc|
  llvm.func @not_logicalOr_not_op0(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg1, %1  : vector<2xi1>
    %5 = llvm.select %arg0, %4, %3 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_not_logicalOr_not_op0   : not_logicalOr_not_op0_before  ⊑  not_logicalOr_not_op0_combined := by
  unfold not_logicalOr_not_op0_before not_logicalOr_not_op0_combined
  simp_alive_peephole
  sorry
def not_logicalOr_not_op1_combined := [llvmfunc|
  llvm.func @not_logicalOr_not_op1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_logicalOr_not_op1   : not_logicalOr_not_op1_before  ⊑  not_logicalOr_not_op1_combined := by
  unfold not_logicalOr_not_op1_before not_logicalOr_not_op1_combined
  simp_alive_peephole
  sorry
def not_logicalOr_not_op0_use1_combined := [llvmfunc|
  llvm.func @not_logicalOr_not_op0_use1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %arg0, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_not_logicalOr_not_op0_use1   : not_logicalOr_not_op0_use1_before  ⊑  not_logicalOr_not_op0_use1_combined := by
  unfold not_logicalOr_not_op0_use1_before not_logicalOr_not_op0_use1_combined
  simp_alive_peephole
  sorry
def not_logicalOr_not_op0_use2_combined := [llvmfunc|
  llvm.func @not_logicalOr_not_op0_use2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_not_logicalOr_not_op0_use2   : not_logicalOr_not_op0_use2_before  ⊑  not_logicalOr_not_op0_use2_combined := by
  unfold not_logicalOr_not_op0_use2_before not_logicalOr_not_op0_use2_combined
  simp_alive_peephole
  sorry
def bitcast_to_wide_elts_sext_bool_combined := [llvmfunc|
  llvm.func @bitcast_to_wide_elts_sext_bool(%arg0: vector<4xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.xor %arg0, %1  : vector<4xi1>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.bitcast %3 : vector<4xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_bitcast_to_wide_elts_sext_bool   : bitcast_to_wide_elts_sext_bool_before  ⊑  bitcast_to_wide_elts_sext_bool_combined := by
  unfold bitcast_to_wide_elts_sext_bool_before bitcast_to_wide_elts_sext_bool_combined
  simp_alive_peephole
  sorry
def bitcast_to_narrow_elts_sext_bool_combined := [llvmfunc|
  llvm.func @bitcast_to_narrow_elts_sext_bool(%arg0: vector<4xi1>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.xor %arg0, %1  : vector<4xi1>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.bitcast %3 : vector<4xi32> to vector<8xi16>
    llvm.return %4 : vector<8xi16>
  }]

theorem inst_combine_bitcast_to_narrow_elts_sext_bool   : bitcast_to_narrow_elts_sext_bool_before  ⊑  bitcast_to_narrow_elts_sext_bool_combined := by
  unfold bitcast_to_narrow_elts_sext_bool_before bitcast_to_narrow_elts_sext_bool_combined
  simp_alive_peephole
  sorry
def bitcast_to_vec_sext_bool_combined := [llvmfunc|
  llvm.func @bitcast_to_vec_sext_bool(%arg0: i1) -> vector<2xi16> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.sext %1 : i1 to i32
    %3 = llvm.bitcast %2 : i32 to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_bitcast_to_vec_sext_bool   : bitcast_to_vec_sext_bool_before  ⊑  bitcast_to_vec_sext_bool_combined := by
  unfold bitcast_to_vec_sext_bool_before bitcast_to_vec_sext_bool_combined
  simp_alive_peephole
  sorry
def bitcast_to_scalar_sext_bool_combined := [llvmfunc|
  llvm.func @bitcast_to_scalar_sext_bool(%arg0: vector<4xi1>) -> i128 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.xor %arg0, %1  : vector<4xi1>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    %4 = llvm.bitcast %3 : vector<4xi32> to i128
    llvm.return %4 : i128
  }]

theorem inst_combine_bitcast_to_scalar_sext_bool   : bitcast_to_scalar_sext_bool_before  ⊑  bitcast_to_scalar_sext_bool_combined := by
  unfold bitcast_to_scalar_sext_bool_before bitcast_to_scalar_sext_bool_combined
  simp_alive_peephole
  sorry
def bitcast_to_vec_sext_bool_use1_combined := [llvmfunc|
  llvm.func @bitcast_to_vec_sext_bool_use1(%arg0: i1) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sext %arg0 : i1 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.bitcast %2 : i8 to vector<2xi4>
    %4 = llvm.xor %3, %1  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_bitcast_to_vec_sext_bool_use1   : bitcast_to_vec_sext_bool_use1_before  ⊑  bitcast_to_vec_sext_bool_use1_combined := by
  unfold bitcast_to_vec_sext_bool_use1_before bitcast_to_vec_sext_bool_use1_combined
  simp_alive_peephole
  sorry
def bitcast_to_scalar_sext_bool_use2_combined := [llvmfunc|
  llvm.func @bitcast_to_scalar_sext_bool_use2(%arg0: vector<4xi1>) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sext %arg0 : vector<4xi1> to vector<4xi2>
    %2 = llvm.bitcast %1 : vector<4xi2> to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_bitcast_to_scalar_sext_bool_use2   : bitcast_to_scalar_sext_bool_use2_before  ⊑  bitcast_to_scalar_sext_bool_use2_combined := by
  unfold bitcast_to_scalar_sext_bool_use2_before bitcast_to_scalar_sext_bool_use2_combined
  simp_alive_peephole
  sorry
def invert_both_cmp_operands_add_combined := [llvmfunc|
  llvm.func @invert_both_cmp_operands_add(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_invert_both_cmp_operands_add   : invert_both_cmp_operands_add_before  ⊑  invert_both_cmp_operands_add_combined := by
  unfold invert_both_cmp_operands_add_before invert_both_cmp_operands_add_combined
  simp_alive_peephole
  sorry
def invert_both_cmp_operands_sub_combined := [llvmfunc|
  llvm.func @invert_both_cmp_operands_sub(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-43 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_invert_both_cmp_operands_sub   : invert_both_cmp_operands_sub_before  ⊑  invert_both_cmp_operands_sub_combined := by
  unfold invert_both_cmp_operands_sub_before invert_both_cmp_operands_sub_combined
  simp_alive_peephole
  sorry
def invert_both_cmp_operands_complex_combined := [llvmfunc|
  llvm.func @invert_both_cmp_operands_complex(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.sub %arg1, %arg3  : i32
    %1 = llvm.select %arg0, %0, %arg2 : i1, i32
    %2 = llvm.icmp "sge" %1, %arg3 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_invert_both_cmp_operands_complex   : invert_both_cmp_operands_complex_before  ⊑  invert_both_cmp_operands_complex_combined := by
  unfold invert_both_cmp_operands_complex_before invert_both_cmp_operands_complex_combined
  simp_alive_peephole
  sorry
def test_sext_combined := [llvmfunc|
  llvm.func @test_sext(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.sext %2 : i1 to i32
    %4 = llvm.add %3, %arg1  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test_sext   : test_sext_before  ⊑  test_sext_combined := by
  unfold test_sext_before test_sext_combined
  simp_alive_peephole
  sorry
def test_sext_vec_combined := [llvmfunc|
  llvm.func @test_sext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi1> to vector<2xi32>
    %5 = llvm.add %4, %arg1  : vector<2xi32>
    %6 = llvm.xor %5, %2  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_test_sext_vec   : test_sext_vec_before  ⊑  test_sext_vec_combined := by
  unfold test_sext_vec_before test_sext_vec_combined
  simp_alive_peephole
  sorry
def test_zext_nneg_combined := [llvmfunc|
  llvm.func @test_zext_nneg(%arg0: i32, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i64) : i64
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.add %arg1, %1  : i64
    %5 = llvm.add %3, %arg2  : i64
    %6 = llvm.sub %4, %5  : i64
    llvm.return %6 : i64
  }]

theorem inst_combine_test_zext_nneg   : test_zext_nneg_before  ⊑  test_zext_nneg_combined := by
  unfold test_zext_nneg_before test_zext_nneg_combined
  simp_alive_peephole
  sorry
def test_trunc_combined := [llvmfunc|
  llvm.func @test_trunc(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.add %3, %0 overflow<nsw>  : i32
    %5 = llvm.ashr %4, %1  : i32
    %6 = llvm.trunc %5 : i32 to i8
    %7 = llvm.xor %6, %2  : i8
    llvm.return %7 : i8
  }]

theorem inst_combine_test_trunc   : test_trunc_before  ⊑  test_trunc_combined := by
  unfold test_trunc_before test_trunc_combined
  simp_alive_peephole
  sorry
def test_trunc_vec_combined := [llvmfunc|
  llvm.func @test_trunc_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %4 = llvm.add %3, %0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.ashr %4, %1  : vector<2xi32>
    %6 = llvm.trunc %5 : vector<2xi32> to vector<2xi8>
    %7 = llvm.xor %6, %2  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }]

theorem inst_combine_test_trunc_vec   : test_trunc_vec_before  ⊑  test_trunc_vec_combined := by
  unfold test_trunc_vec_before test_trunc_vec_combined
  simp_alive_peephole
  sorry
def test_zext_combined := [llvmfunc|
  llvm.func @test_zext(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.add %3, %arg1  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test_zext   : test_zext_before  ⊑  test_zext_combined := by
  unfold test_zext_before test_zext_combined
  simp_alive_peephole
  sorry
def test_invert_demorgan_or_combined := [llvmfunc|
  llvm.func @test_invert_demorgan_or(%arg0: i32, %arg1: i32, %arg2: i1) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.or %2, %3  : i1
    %5 = llvm.xor %arg2, %1  : i1
    %6 = llvm.or %4, %5  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @f1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @f2() : () -> ()
    llvm.unreachable
  }]

theorem inst_combine_test_invert_demorgan_or   : test_invert_demorgan_or_before  ⊑  test_invert_demorgan_or_combined := by
  unfold test_invert_demorgan_or_before test_invert_demorgan_or_combined
  simp_alive_peephole
  sorry
def test_invert_demorgan_or2_combined := [llvmfunc|
  llvm.func @test_invert_demorgan_or2(%arg0: i64, %arg1: i64, %arg2: i64) -> i1 {
    %0 = llvm.mlir.constant(23 : i64) : i64
    %1 = llvm.mlir.constant(59 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i64
    %4 = llvm.icmp "ugt" %arg1, %1 : i64
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.icmp "ugt" %arg2, %1 : i64
    %7 = llvm.or %5, %6  : i1
    %8 = llvm.xor %7, %2  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_test_invert_demorgan_or2   : test_invert_demorgan_or2_before  ⊑  test_invert_demorgan_or2_combined := by
  unfold test_invert_demorgan_or2_before test_invert_demorgan_or2_combined
  simp_alive_peephole
  sorry
def test_invert_demorgan_or3_combined := [llvmfunc|
  llvm.func @test_invert_demorgan_or3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(178206 : i32) : i32
    %1 = llvm.mlir.constant(-195102 : i32) : i32
    %2 = llvm.mlir.constant(1506 : i32) : i32
    %3 = llvm.mlir.constant(-201547 : i32) : i32
    %4 = llvm.mlir.constant(716213 : i32) : i32
    %5 = llvm.mlir.constant(-918000 : i32) : i32
    %6 = llvm.mlir.constant(196112 : i32) : i32
    %7 = llvm.mlir.constant(true) : i1
    %8 = llvm.icmp "eq" %arg0, %0 : i32
    %9 = llvm.add %arg1, %1  : i32
    %10 = llvm.icmp "ult" %9, %2 : i32
    %11 = llvm.add %arg1, %3  : i32
    %12 = llvm.icmp "ult" %11, %4 : i32
    %13 = llvm.add %arg1, %5  : i32
    %14 = llvm.icmp "ult" %13, %6 : i32
    %15 = llvm.or %8, %10  : i1
    %16 = llvm.or %15, %12  : i1
    %17 = llvm.or %16, %14  : i1
    %18 = llvm.xor %17, %7  : i1
    llvm.return %18 : i1
  }]

theorem inst_combine_test_invert_demorgan_or3   : test_invert_demorgan_or3_before  ⊑  test_invert_demorgan_or3_combined := by
  unfold test_invert_demorgan_or3_before test_invert_demorgan_or3_combined
  simp_alive_peephole
  sorry
def test_invert_demorgan_logical_or_combined := [llvmfunc|
  llvm.func @test_invert_demorgan_logical_or(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(27 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i64
    %4 = llvm.icmp "eq" %arg1, %1 : i64
    %5 = llvm.select %3, %2, %4 : i1, i1
    %6 = llvm.icmp "eq" %arg0, %1 : i64
    %7 = llvm.or %6, %5  : i1
    %8 = llvm.xor %7, %2  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_test_invert_demorgan_logical_or   : test_invert_demorgan_logical_or_before  ⊑  test_invert_demorgan_logical_or_combined := by
  unfold test_invert_demorgan_logical_or_before test_invert_demorgan_logical_or_combined
  simp_alive_peephole
  sorry
def test_invert_demorgan_and_combined := [llvmfunc|
  llvm.func @test_invert_demorgan_and(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.xor %arg2, %1  : i1
    %6 = llvm.and %4, %5  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @f1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @f2() : () -> ()
    llvm.unreachable
  }]

theorem inst_combine_test_invert_demorgan_and   : test_invert_demorgan_and_before  ⊑  test_invert_demorgan_and_combined := by
  unfold test_invert_demorgan_and_before test_invert_demorgan_and_combined
  simp_alive_peephole
  sorry
def test_invert_demorgan_and2_combined := [llvmfunc|
  llvm.func @test_invert_demorgan_and2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(9223372036854775807 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.add %arg0, %0  : i64
    %3 = llvm.and %2, %0  : i64
    %4 = llvm.xor %3, %1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_test_invert_demorgan_and2   : test_invert_demorgan_and2_before  ⊑  test_invert_demorgan_and2_combined := by
  unfold test_invert_demorgan_and2_before test_invert_demorgan_and2_combined
  simp_alive_peephole
  sorry
def test_invert_demorgan_and3_combined := [llvmfunc|
  llvm.func @test_invert_demorgan_and3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(4095 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.add %3, %arg1  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_test_invert_demorgan_and3   : test_invert_demorgan_and3_before  ⊑  test_invert_demorgan_and3_combined := by
  unfold test_invert_demorgan_and3_before test_invert_demorgan_and3_combined
  simp_alive_peephole
  sorry
def test_invert_demorgan_logical_and_combined := [llvmfunc|
  llvm.func @test_invert_demorgan_logical_and(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(27 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg0, %0 : i64
    %5 = llvm.icmp "eq" %arg1, %1 : i64
    %6 = llvm.select %4, %5, %2 : i1, i1
    %7 = llvm.icmp "eq" %arg0, %1 : i64
    %8 = llvm.or %7, %6  : i1
    %9 = llvm.xor %8, %3  : i1
    llvm.return %9 : i1
  }]

theorem inst_combine_test_invert_demorgan_logical_and   : test_invert_demorgan_logical_and_before  ⊑  test_invert_demorgan_logical_and_combined := by
  unfold test_invert_demorgan_logical_and_before test_invert_demorgan_logical_and_combined
  simp_alive_peephole
  sorry
def test_invert_demorgan_and_multiuse_combined := [llvmfunc|
  llvm.func @test_invert_demorgan_and_multiuse(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.xor %arg2, %1  : i1
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.and %5, %2  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @f1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @f2() : () -> ()
    llvm.unreachable
  }]

theorem inst_combine_test_invert_demorgan_and_multiuse   : test_invert_demorgan_and_multiuse_before  ⊑  test_invert_demorgan_and_multiuse_combined := by
  unfold test_invert_demorgan_and_multiuse_before test_invert_demorgan_and_multiuse_combined
  simp_alive_peephole
  sorry
