import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vec_demanded_elts
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: f32) -> i32 {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.fmul %arg0, %arg0  : f32
    %7 = llvm.insertelement %6, %0[%1 : i32] : vector<4xf32>
    %8 = llvm.insertelement %2, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %2, %8[%4 : i32] : vector<4xf32>
    %10 = llvm.insertelement %2, %9[%5 : i32] : vector<4xf32>
    %11 = llvm.bitcast %10 : vector<4xf32> to vector<4xi32>
    %12 = llvm.extractelement %11[%1 : i32] : vector<4xi32>
    llvm.return %12 : i32
  }]

def get_image_before := [llvmfunc|
  llvm.func @get_image() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<100xi8>) : vector<100xi8>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(80 : i8) : i8
    %6 = llvm.call @fgetc(%0) : (!llvm.ptr) -> i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.insertelement %7, %2[%3 : i32] : vector<100xi8>
    %9 = llvm.extractelement %8[%4 : i32] : vector<100xi8>
    %10 = llvm.icmp "eq" %9, %5 : i8
    llvm.cond_br %10, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.unreachable
  }]

def vac_before := [llvmfunc|
  llvm.func @vac(%arg0: !llvm.ptr {llvm.nocapture}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xf32>]

    %6 = llvm.insertelement %0, %5[%1 : i32] : vector<4xf32>
    %7 = llvm.insertelement %0, %6[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %0, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %0, %8[%4 : i32] : vector<4xf32>
    llvm.store %9, %arg0 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr]

    llvm.return
  }]

def dead_shuffle_elt_before := [llvmfunc|
  llvm.func @dead_shuffle_elt(%arg0: vector<4xf32>, %arg1: vector<2xf32>) -> vector<4xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.shufflevector %arg1, %arg1 [0, 1, 0, 1] : vector<2xf32> 
    %1 = llvm.shufflevector %arg0, %0 [4, 5, 2, 3] : vector<4xf32> 
    llvm.return %1 : vector<4xf32>
  }]

def test_fptrunc_before := [llvmfunc|
  llvm.func @test_fptrunc(%arg0: f64) -> vector<2xf32> {
    %0 = llvm.mlir.undef : vector<4xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.undef : vector<4xf32>
    %7 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf64>
    %8 = llvm.insertelement %2, %7[%3 : i32] : vector<4xf64>
    %9 = llvm.insertelement %2, %8[%4 : i32] : vector<4xf64>
    %10 = llvm.insertelement %2, %9[%5 : i32] : vector<4xf64>
    %11 = llvm.fptrunc %10 : vector<4xf64> to vector<4xf32>
    %12 = llvm.shufflevector %11, %6 [0, 1] : vector<4xf32> 
    llvm.return %12 : vector<2xf32>
  }]

def test_fpext_before := [llvmfunc|
  llvm.func @test_fpext(%arg0: f32) -> vector<2xf64> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.undef : vector<4xf64>
    %7 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %8 = llvm.insertelement %2, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %2, %8[%4 : i32] : vector<4xf32>
    %10 = llvm.insertelement %2, %9[%5 : i32] : vector<4xf32>
    %11 = llvm.fpext %10 : vector<4xf32> to vector<4xf64>
    %12 = llvm.shufflevector %11, %6 [0, 1] : vector<4xf64> 
    llvm.return %12 : vector<2xf64>
  }]

def test_shuffle_before := [llvmfunc|
  llvm.func @test_shuffle(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<4xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xf64>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xf64>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf64>
    %11 = llvm.shufflevector %arg0, %10 [0, 1, 2, 5] : vector<4xf64> 
    llvm.return %11 : vector<4xf64>
  }]

def test_select_before := [llvmfunc|
  llvm.func @test_select(%arg0: f32, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %7 = llvm.mlir.constant(3 : i32) : i32
    %8 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %9 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %10 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %11 = llvm.mlir.constant(true) : i1
    %12 = llvm.mlir.constant(false) : i1
    %13 = llvm.mlir.constant(dense<[true, false, false, true]> : vector<4xi1>) : vector<4xi1>
    %14 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %15 = llvm.insertelement %2, %14[%3 : i32] : vector<4xf32>
    %16 = llvm.insertelement %4, %15[%5 : i32] : vector<4xf32>
    %17 = llvm.insertelement %6, %16[%7 : i32] : vector<4xf32>
    %18 = llvm.insertelement %arg1, %0[%1 : i32] : vector<4xf32>
    %19 = llvm.insertelement %8, %18[%3 : i32] : vector<4xf32>
    %20 = llvm.insertelement %9, %19[%5 : i32] : vector<4xf32>
    %21 = llvm.insertelement %10, %20[%7 : i32] : vector<4xf32>
    %22 = llvm.select %13, %17, %21 : vector<4xi1>, vector<4xf32>
    llvm.return %22 : vector<4xf32>
  }]

def PR24922_before := [llvmfunc|
  llvm.func @PR24922(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.addressof @PR24922 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i1
    %3 = llvm.mlir.undef : vector<2xi1>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi1>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : vector<2xi1>
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %10 = llvm.select %7, %arg0, %9 : vector<2xi1>, vector<2xi64>
    llvm.return %10 : vector<2xi64>
  }]

def inselt_shuf_no_demand_before := [llvmfunc|
  llvm.func @inselt_shuf_no_demand(%arg0: f32, %arg1: f32, %arg2: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %arg1, %4[%2 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg2, %5[%3 : i32] : vector<4xf32>
    %7 = llvm.shufflevector %6, %0 [0, -1, -1, -1] : vector<4xf32> 
    llvm.return %7 : vector<4xf32>
  }]

def inselt_shuf_no_demand_commute_before := [llvmfunc|
  llvm.func @inselt_shuf_no_demand_commute(%arg0: f32, %arg1: f32, %arg2: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %arg1, %4[%2 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg2, %5[%3 : i32] : vector<4xf32>
    %7 = llvm.shufflevector %0, %6 [4, -1, -1, -1] : vector<4xf32> 
    llvm.return %7 : vector<4xf32>
  }]

def inselt_shuf_no_demand_multiuse_before := [llvmfunc|
  llvm.func @inselt_shuf_no_demand_multiuse(%arg0: i32, %arg1: i32, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<4xi32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xi32>
    %8 = llvm.add %7, %arg2  : vector<4xi32>
    %9 = llvm.insertelement %arg1, %8[%4 : i32] : vector<4xi32>
    %10 = llvm.shufflevector %9, %0 [0, 1, -1, -1] : vector<4xi32> 
    llvm.return %10 : vector<4xi32>
  }]

def inselt_shuf_no_demand_bogus_insert_index_in_chain_before := [llvmfunc|
  llvm.func @inselt_shuf_no_demand_bogus_insert_index_in_chain(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %4 = llvm.insertelement %arg1, %3[%arg3 : i32] : vector<4xf32>
    %5 = llvm.insertelement %arg2, %4[%2 : i32] : vector<4xf32>
    %6 = llvm.shufflevector %5, %0 [0, -1, -1, -1] : vector<4xf32> 
    llvm.return %6 : vector<4xf32>
  }]

def shuf_add_before := [llvmfunc|
  llvm.func @shuf_add(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [1, -1, 2] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_sub_before := [llvmfunc|
  llvm.func @shuf_sub(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [0, -1, 2] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_mul_before := [llvmfunc|
  llvm.func @shuf_mul(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [0, 2, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_and_before := [llvmfunc|
  llvm.func @shuf_and(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.and %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [1, 1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_or_before := [llvmfunc|
  llvm.func @shuf_or(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.or %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [1, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_xor_before := [llvmfunc|
  llvm.func @shuf_xor(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.xor %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_lshr_const_op0_before := [llvmfunc|
  llvm.func @shuf_lshr_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.lshr %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, 1, -1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_lshr_const_op1_before := [llvmfunc|
  llvm.func @shuf_lshr_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.lshr %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, 1, -1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_ashr_const_op0_before := [llvmfunc|
  llvm.func @shuf_ashr_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.ashr %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [0, -1, 1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_ashr_const_op1_before := [llvmfunc|
  llvm.func @shuf_ashr_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.ashr %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [0, -1, 1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_shl_const_op0_before := [llvmfunc|
  llvm.func @shuf_shl_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_shl_const_op1_before := [llvmfunc|
  llvm.func @shuf_shl_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_sdiv_const_op0_before := [llvmfunc|
  llvm.func @shuf_sdiv_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.sdiv %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [0, -1, 1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_sdiv_const_op1_before := [llvmfunc|
  llvm.func @shuf_sdiv_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.sdiv %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [1, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_srem_const_op0_before := [llvmfunc|
  llvm.func @shuf_srem_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.srem %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [1, -1, 2] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_srem_const_op1_before := [llvmfunc|
  llvm.func @shuf_srem_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.srem %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_udiv_const_op0_before := [llvmfunc|
  llvm.func @shuf_udiv_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.udiv %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_udiv_const_op1_before := [llvmfunc|
  llvm.func @shuf_udiv_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.udiv %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_urem_const_op0_before := [llvmfunc|
  llvm.func @shuf_urem_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.urem %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, 1, -1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_urem_const_op1_before := [llvmfunc|
  llvm.func @shuf_urem_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.undef : vector<3xi8>
    %2 = llvm.urem %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [-1, 1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

def shuf_fadd_before := [llvmfunc|
  llvm.func @shuf_fadd(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.fadd %arg0, %0  : vector<3xf32>
    %3 = llvm.shufflevector %2, %1 [-1, 1, 0] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }]

def shuf_fsub_before := [llvmfunc|
  llvm.func @shuf_fsub(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<3xf32>]

    %3 = llvm.shufflevector %2, %1 [-1, 0, 2] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }]

def shuf_fmul_before := [llvmfunc|
  llvm.func @shuf_fmul(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<3xf32>]

    %3 = llvm.shufflevector %2, %1 [-1, 1, 0] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }]

def shuf_fdiv_const_op0_before := [llvmfunc|
  llvm.func @shuf_fdiv_const_op0(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : vector<3xf32>]

    %3 = llvm.shufflevector %2, %1 [-1, 0, 2] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }]

def shuf_fdiv_const_op1_before := [llvmfunc|
  llvm.func @shuf_fdiv_const_op1(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<3xf32>]

    %3 = llvm.shufflevector %2, %1 [-1, 1, 0] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }]

def shuf_frem_const_op0_before := [llvmfunc|
  llvm.func @shuf_frem_const_op0(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.frem %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : vector<3xf32>]

    %3 = llvm.shufflevector %2, %1 [-1, 2, 0] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }]

def shuf_frem_const_op1_before := [llvmfunc|
  llvm.func @shuf_frem_const_op1(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.undef : vector<3xf32>
    %2 = llvm.frem %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : vector<3xf32>]

    %3 = llvm.shufflevector %2, %1 [1, -1, 2] : vector<3xf32> 
    llvm.return %3 : vector<3xf32>
  }]

def gep_vbase_w_s_idx_before := [llvmfunc|
  llvm.func @gep_vbase_w_s_idx(%arg0: !llvm.vec<2 x ptr>, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%arg1] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i32
    %2 = llvm.extractelement %1[%0 : i32] : !llvm.vec<2 x ptr>
    llvm.return %2 : !llvm.ptr
  }]

def gep_splat_base_w_s_idx_before := [llvmfunc|
  llvm.func @gep_splat_base_w_s_idx(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.shufflevector %4, %0 [0, 0] : !llvm.vec<2 x ptr> 
    %6 = llvm.getelementptr %5[%2] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i32
    %7 = llvm.extractelement %6[%3 : i32] : !llvm.vec<2 x ptr>
    llvm.return %7 : !llvm.ptr
  }]

def gep_splat_base_w_cv_idx_before := [llvmfunc|
  llvm.func @gep_splat_base_w_cv_idx(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.shufflevector %4, %0 [0, 0] : !llvm.vec<2 x ptr> 
    %6 = llvm.getelementptr %5[%2] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %7 = llvm.extractelement %6[%3 : i32] : !llvm.vec<2 x ptr>
    llvm.return %7 : !llvm.ptr
  }]

def gep_splat_base_w_vidx_before := [llvmfunc|
  llvm.func @gep_splat_base_w_vidx(%arg0: !llvm.ptr, %arg1: vector<2xi64>) -> !llvm.ptr {
    %0 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.shufflevector %3, %0 [0, 0] : !llvm.vec<2 x ptr> 
    %5 = llvm.getelementptr %4[%arg1] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %6 = llvm.extractelement %5[%2 : i32] : !llvm.vec<2 x ptr>
    llvm.return %6 : !llvm.ptr
  }]

def gep_cvbase_w_s_idx_before := [llvmfunc|
  llvm.func @gep_cvbase_w_s_idx(%arg0: !llvm.vec<2 x ptr>, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @GLOBAL : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : !llvm.vec<2 x ptr>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.getelementptr %6[%arg1] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i32
    %9 = llvm.extractelement %8[%7 : i32] : !llvm.vec<2 x ptr>
    llvm.return %9 : !llvm.ptr
  }]

def gep_cvbase_w_cv_idx_before := [llvmfunc|
  llvm.func @gep_cvbase_w_cv_idx(%arg0: !llvm.vec<2 x ptr>, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @GLOBAL : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : !llvm.vec<2 x ptr>
    %7 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.getelementptr %6[%7] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %10 = llvm.extractelement %9[%8 : i32] : !llvm.vec<2 x ptr>
    llvm.return %10 : !llvm.ptr
  }]

def gep_sbase_w_cv_idx_before := [llvmfunc|
  llvm.func @gep_sbase_w_cv_idx(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %3 = llvm.extractelement %2[%1 : i32] : !llvm.vec<2 x ptr>
    llvm.return %3 : !llvm.ptr
  }]

def gep_sbase_w_splat_idx_before := [llvmfunc|
  llvm.func @gep_sbase_w_splat_idx(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.undef : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xi64>
    %4 = llvm.shufflevector %3, %0 [0, 0] : vector<2xi64> 
    %5 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %6 = llvm.extractelement %5[%2 : i32] : !llvm.vec<2 x ptr>
    llvm.return %6 : !llvm.ptr
  }]

def gep_splat_both_before := [llvmfunc|
  llvm.func @gep_splat_both(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.shufflevector %4, %0 [0, 0] : !llvm.vec<2 x ptr> 
    %6 = llvm.insertelement %arg1, %2[%1 : i32] : vector<2xi64>
    %7 = llvm.shufflevector %6, %2 [0, 0] : vector<2xi64> 
    %8 = llvm.getelementptr %5[%7] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %9 = llvm.extractelement %8[%3 : i32] : !llvm.vec<2 x ptr>
    llvm.return %9 : !llvm.ptr
  }]

def gep_all_lanes_undef_before := [llvmfunc|
  llvm.func @gep_all_lanes_undef(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.insertelement %arg1, %2[%3 : i32] : vector<2xi64>
    %6 = llvm.getelementptr %4[%5] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    llvm.return %6 : !llvm.vec<2 x ptr>
  }]

def gep_demanded_lane_undef_before := [llvmfunc|
  llvm.func @gep_demanded_lane_undef(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.insertelement %arg1, %2[%3 : i32] : vector<2xi64>
    %6 = llvm.getelementptr %4[%5] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %7 = llvm.extractelement %6[%3 : i32] : !llvm.vec<2 x ptr>
    llvm.return %7 : !llvm.ptr
  }]

def PR41624_before := [llvmfunc|
  llvm.func @PR41624(%arg0: !llvm.vec<2 x ptr>) -> !llvm.ptr {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.getelementptr %arg0[%0, 0] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.struct<(i32, i32)>
    %4 = llvm.extractelement %3[%1 : i32] : !llvm.vec<2 x ptr>
    llvm.return %4 : !llvm.ptr
  }]

def zero_sized_type_extract_before := [llvmfunc|
  llvm.func @zero_sized_type_extract(%arg0: vector<4xi64>, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @global : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<4 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<4 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<4 x ptr>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<4 x ptr>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<4 x ptr>
    %10 = llvm.mlir.constant(0 : i64) : i64
    %11 = llvm.mlir.constant(dense<0> : vector<4xi64>) : vector<4xi64>
    %12 = llvm.getelementptr inbounds %9[%11, %arg0] : (!llvm.vec<4 x ptr>, vector<4xi64>, vector<4xi64>) -> !llvm.vec<4 x ptr>, !llvm.array<0 x i32>
    %13 = llvm.extractelement %12[%10 : i64] : !llvm.vec<4 x ptr>
    llvm.return %13 : !llvm.ptr
  }]

def select_cond_with_eq_true_false_elts_before := [llvmfunc|
  llvm.func @select_cond_with_eq_true_false_elts(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 5, 6, 7] : vector<4xi8> 
    %2 = llvm.shufflevector %arg2, %0 [0, 0, 0, 0] : vector<4xi1> 
    %3 = llvm.select %2, %1, %arg1 : vector<4xi1>, vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

def select_cond_with_eq_true_false_elts2_before := [llvmfunc|
  llvm.func @select_cond_with_eq_true_false_elts2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 5, 6, 7] : vector<4xi8> 
    %2 = llvm.shufflevector %arg2, %0 [0, 1, 0, 1] : vector<4xi1> 
    %3 = llvm.select %2, %1, %arg0 : vector<4xi1>, vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

def select_cond_with_eq_true_false_elts3_before := [llvmfunc|
  llvm.func @select_cond_with_eq_true_false_elts3(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi1>) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %arg1 [1, 3, 5, -1] : vector<4xf32> 
    %2 = llvm.shufflevector %arg1, %arg0 [0, 7, 6, -1] : vector<4xf32> 
    %3 = llvm.shufflevector %arg2, %0 [-1, 1, 2, 3] : vector<4xi1> 
    %4 = llvm.select %3, %1, %2 : vector<4xi1>, vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

def select_cond_with_undef_true_false_elts_before := [llvmfunc|
  llvm.func @select_cond_with_undef_true_false_elts(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.mlir.undef : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %arg1 [-1, 5, 6, 7] : vector<4xi8> 
    %2 = llvm.shufflevector %arg2, %0 [0, 1, 0, 1] : vector<4xi1> 
    %3 = llvm.select %2, %1, %arg0 : vector<4xi1>, vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

def select_cond__before := [llvmfunc|
  llvm.func @select_cond_(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>, %arg3: i1) -> vector<4xi8> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.insertelement %arg3, %arg2[%0 : i32] : vector<4xi1>
    %2 = llvm.shufflevector %arg0, %arg1 [0, 5, 6, 7] : vector<4xi8> 
    %3 = llvm.select %1, %2, %arg0 : vector<4xi1>, vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

def ins_of_ext_before := [llvmfunc|
  llvm.func @ins_of_ext(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xf32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<4xf32>
    %6 = llvm.insertelement %5, %1[%0 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg1, %6[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg1, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg1, %8[%4 : i32] : vector<4xf32>
    llvm.return %9 : vector<4xf32>
  }]

def ins_of_ext_twice_before := [llvmfunc|
  llvm.func @ins_of_ext_twice(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xf32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<4xf32>
    %6 = llvm.insertelement %5, %1[%0 : i32] : vector<4xf32>
    %7 = llvm.extractelement %arg0[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %7, %6[%2 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg1, %8[%3 : i32] : vector<4xf32>
    %10 = llvm.insertelement %arg1, %9[%4 : i32] : vector<4xf32>
    llvm.return %10 : vector<4xf32>
  }]

def ins_of_ext_wrong_demand_before := [llvmfunc|
  llvm.func @ins_of_ext_wrong_demand(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xf32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.extractelement %arg0[%0 : i32] : vector<4xf32>
    %5 = llvm.insertelement %4, %1[%0 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg1, %6[%3 : i32] : vector<4xf32>
    llvm.return %7 : vector<4xf32>
  }]

def ins_of_ext_wrong_type_before := [llvmfunc|
  llvm.func @ins_of_ext_wrong_type(%arg0: vector<5xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xf32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<5xf32>
    %6 = llvm.insertelement %5, %1[%0 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg1, %6[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg1, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg1, %8[%4 : i32] : vector<4xf32>
    llvm.return %9 : vector<4xf32>
  }]

def ins_of_ext_undef_elts_propagation_before := [llvmfunc|
  llvm.func @ins_of_ext_undef_elts_propagation(%arg0: vector<4xi4>, %arg1: vector<4xi4>, %arg2: i4) -> vector<4xi4> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xi4>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.extractelement %arg0[%0 : i32] : vector<4xi4>
    %4 = llvm.insertelement %3, %1[%0 : i32] : vector<4xi4>
    %5 = llvm.insertelement %arg2, %4[%2 : i32] : vector<4xi4>
    %6 = llvm.shufflevector %5, %arg1 [0, 6, 2, 7] : vector<4xi4> 
    llvm.return %6 : vector<4xi4>
  }]

def ins_of_ext_undef_elts_propagation2_before := [llvmfunc|
  llvm.func @ins_of_ext_undef_elts_propagation2(%arg0: vector<8xi4>, %arg1: vector<8xi4>, %arg2: i4) -> vector<8xi4> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<8xi4>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.extractelement %arg0[%0 : i32] : vector<8xi4>
    %5 = llvm.insertelement %4, %1[%0 : i32] : vector<8xi4>
    %6 = llvm.extractelement %arg0[%2 : i32] : vector<8xi4>
    %7 = llvm.insertelement %6, %5[%2 : i32] : vector<8xi4>
    %8 = llvm.insertelement %arg2, %7[%3 : i32] : vector<8xi4>
    %9 = llvm.shufflevector %8, %arg1 [0, 1, 2, 11, 10, 9, 8, -1] : vector<8xi4> 
    %10 = llvm.shufflevector %9, %arg0 [0, 1, 2, 3, 4, 5, 6, 15] : vector<8xi4> 
    llvm.return %10 : vector<8xi4>
  }]

def common_binop_demand_via_splat_op0_before := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %2 = llvm.mul %1, %arg1  : vector<2xi4>
    %3 = llvm.mul %arg0, %arg1  : vector<2xi4>
    %4 = llvm.shufflevector %3, %0 [0, 0] : vector<2xi4> 
    llvm.call @use(%2) : (vector<2xi4>) -> ()
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.return
  }]

def common_binop_demand_via_splat_op1_before := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.poison : vector<2xi4>
    %4 = llvm.sub %2, %arg0  : vector<2xi4>
    %5 = llvm.shufflevector %arg1, %3 [0, 0] : vector<2xi4> 
    %6 = llvm.mul %4, %5  : vector<2xi4>
    %7 = llvm.mul %4, %arg1  : vector<2xi4>
    %8 = llvm.shufflevector %7, %3 [0, 0] : vector<2xi4> 
    llvm.call @use(%8) : (vector<2xi4>) -> ()
    llvm.call @use(%6) : (vector<2xi4>) -> ()
    llvm.return
  }]

def common_binop_demand_via_splat_op0_commute_before := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op0_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(2 : i4) : i4
    %4 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.mlir.poison : vector<2xi4>
    %6 = llvm.sub %2, %arg0  : vector<2xi4>
    %7 = llvm.sub %4, %arg1  : vector<2xi4>
    %8 = llvm.shufflevector %6, %5 [0, 0] : vector<2xi4> 
    %9 = llvm.mul %7, %8  : vector<2xi4>
    %10 = llvm.mul %6, %7  : vector<2xi4>
    %11 = llvm.shufflevector %10, %5 [0, 0] : vector<2xi4> 
    llvm.call @use(%11) : (vector<2xi4>) -> ()
    llvm.call @use(%9) : (vector<2xi4>) -> ()
    llvm.return
  }]

def common_binop_demand_via_splat_op1_commute_before := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op1_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(3 : i4) : i4
    %4 = llvm.mlir.constant(2 : i4) : i4
    %5 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi4>) : vector<2xi4>
    %6 = llvm.mlir.poison : vector<2xi4>
    %7 = llvm.sub %2, %arg0  : vector<2xi4>
    %8 = llvm.sub %5, %arg1  : vector<2xi4>
    %9 = llvm.shufflevector %8, %6 [0, 0] : vector<2xi4> 
    %10 = llvm.mul %9, %7  : vector<2xi4>
    %11 = llvm.mul %7, %8  : vector<2xi4>
    %12 = llvm.shufflevector %11, %6 [0, 0] : vector<2xi4> 
    llvm.call @use(%12) : (vector<2xi4>) -> ()
    llvm.call @use(%10) : (vector<2xi4>) -> ()
    llvm.return
  }]

def common_binop_demand_via_splat_op0_wrong_commute_before := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op0_wrong_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %2 = llvm.sub %arg1, %1  : vector<2xi4>
    %3 = llvm.sub %arg0, %arg1  : vector<2xi4>
    %4 = llvm.shufflevector %3, %0 [0, 0] : vector<2xi4> 
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.call @use(%2) : (vector<2xi4>) -> ()
    llvm.return
  }]

def common_binop_demand_via_splat_op0_not_dominated1_before := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op0_not_dominated1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mul %arg0, %arg1  : vector<2xi4>
    %2 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.mul %2, %arg1  : vector<2xi4>
    %4 = llvm.shufflevector %1, %0 [0, 0] : vector<2xi4> 
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.return
  }]

def common_binop_demand_via_splat_op0_not_dominated2_before := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op0_not_dominated2(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mul %arg0, %arg1  : vector<2xi4>
    %2 = llvm.shufflevector %1, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %4 = llvm.mul %3, %arg1  : vector<2xi4>
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.call @use(%2) : (vector<2xi4>) -> ()
    llvm.return
  }]

def common_binop_demand_via_extelt_op0_before := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.sub %2, %arg1  : vector<2xi4>
    %4 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi4>
    %5 = llvm.extractelement %4[%1 : i32] : vector<2xi4>
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }]

def common_binop_demand_via_extelt_op1_before := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op1(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> f32 {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, 1.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.poison : vector<2xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.fsub %0, %arg0  : vector<2xf32>
    %4 = llvm.shufflevector %arg1, %1 [0, 0] : vector<2xf32> 
    %5 = llvm.fdiv %3, %4  : vector<2xf32>
    %6 = llvm.fdiv %3, %arg1  : vector<2xf32>
    %7 = llvm.extractelement %6[%2 : i32] : vector<2xf32>
    llvm.call @use_fp(%5) : (vector<2xf32>) -> ()
    llvm.return %7 : f32
  }]

def common_binop_demand_via_extelt_op0_commute_before := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0_commute(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> f32 {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, 1.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(dense<[3.000000e+00, 2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.poison : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.fsub %0, %arg0  : vector<2xf32>
    %5 = llvm.fsub %1, %arg1  : vector<2xf32>
    %6 = llvm.shufflevector %4, %2 [0, 0] : vector<2xf32> 
    %7 = llvm.fmul %5, %6  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

    %8 = llvm.fmul %4, %5  {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    %9 = llvm.extractelement %8[%3 : i32] : vector<2xf32>
    llvm.call @use_fp(%7) : (vector<2xf32>) -> ()
    llvm.return %9 : f32
  }]

def common_binop_demand_via_extelt_op1_commute_before := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op1_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(3 : i4) : i4
    %4 = llvm.mlir.constant(2 : i4) : i4
    %5 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi4>) : vector<2xi4>
    %6 = llvm.mlir.poison : vector<2xi4>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.sub %2, %arg0  : vector<2xi4>
    %9 = llvm.sub %5, %arg1  : vector<2xi4>
    %10 = llvm.shufflevector %9, %6 [0, 0] : vector<2xi4> 
    %11 = llvm.or %10, %8  : vector<2xi4>
    %12 = llvm.or %8, %9  : vector<2xi4>
    %13 = llvm.extractelement %12[%7 : i32] : vector<2xi4>
    llvm.call @use(%11) : (vector<2xi4>) -> ()
    llvm.return %13 : i4
  }]

def common_binop_demand_via_extelt_op0_wrong_commute_before := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0_wrong_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.sub %arg1, %2  : vector<2xi4>
    %4 = llvm.sub %arg0, %arg1  : vector<2xi4>
    %5 = llvm.extractelement %4[%1 : i32] : vector<2xi4>
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }]

def common_binop_demand_via_extelt_op0_not_dominated1_before := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0_not_dominated1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    %5 = llvm.extractelement %2[%1 : i32] : vector<2xi4>
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }]

def common_binop_demand_via_extelt_op0_not_dominated2_before := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0_not_dominated2(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : vector<2xi4>
    %2 = llvm.mul %arg0, %arg1  : vector<2xi4>
    %3 = llvm.extractelement %2[%0 : i32] : vector<2xi4>
    %4 = llvm.shufflevector %arg0, %1 [0, 0] : vector<2xi4> 
    %5 = llvm.mul %4, %arg1  : vector<2xi4>
    llvm.call @use(%5) : (vector<2xi4>) -> ()
    llvm.return %3 : i4
  }]

def common_binop_demand_via_extelt_op0_mismatch_elt0_before := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0_mismatch_elt0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [1, 1] : vector<2xi4> 
    %3 = llvm.sub %2, %arg1  : vector<2xi4>
    %4 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi4>
    %5 = llvm.extractelement %4[%1 : i32] : vector<2xi4>
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }]

def common_binop_demand_via_extelt_op0_mismatch_elt1_before := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0_mismatch_elt1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.sub %2, %arg1  : vector<2xi4>
    %4 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi4>
    %5 = llvm.extractelement %4[%1 : i32] : vector<2xi4>
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }]

def common_binop_demand_via_splat_mask_poison_before := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_mask_poison(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg1, %0 [0, -1] : vector<2xi8> 
    %2 = llvm.add %arg0, %1  : vector<2xi8>
    %3 = llvm.add %arg0, %arg1  : vector<2xi8>
    %4 = llvm.shufflevector %3, %0 [0, 0] : vector<2xi8> 
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def common_binop_demand_via_splat_mask_poison_2_before := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_mask_poison_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg1, %0 [-1, 0] : vector<2xi8> 
    %2 = llvm.add %arg0, %1  : vector<2xi8>
    %3 = llvm.add %arg0, %arg1  : vector<2xi8>
    %4 = llvm.shufflevector %3, %arg1 [0, 2] : vector<2xi8> 
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def common_binop_demand_via_splat_mask_poison_3_before := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_mask_poison_3(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg1, %0 [-1, 0] : vector<2xi8> 
    %2 = llvm.add %arg0, %1  : vector<2xi8>
    %3 = llvm.add %arg0, %arg1  : vector<2xi8>
    %4 = llvm.shufflevector %3, %0 [0, 0] : vector<2xi8> 
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: f32) -> i32 {
    %0 = llvm.fmul %arg0, %arg0  : f32
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def get_image_combined := [llvmfunc|
  llvm.func @get_image() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.call @fgetc(%0) : (!llvm.ptr) -> i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.unreachable
  }]

theorem inst_combine_get_image   : get_image_before  ⊑  get_image_combined := by
  unfold get_image_before get_image_combined
  simp_alive_peephole
  sorry
def vac_combined := [llvmfunc|
  llvm.func @vac(%arg0: !llvm.ptr {llvm.nocapture}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    llvm.store %1, %arg0 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr]

theorem inst_combine_vac   : vac_before  ⊑  vac_combined := by
  unfold vac_before vac_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_vac   : vac_before  ⊑  vac_combined := by
  unfold vac_before vac_combined
  simp_alive_peephole
  sorry
def dead_shuffle_elt_combined := [llvmfunc|
  llvm.func @dead_shuffle_elt(%arg0: vector<4xf32>, %arg1: vector<2xf32>) -> vector<4xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg1, %0 [0, 1, -1, -1] : vector<2xf32> 
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, 7] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_dead_shuffle_elt   : dead_shuffle_elt_before  ⊑  dead_shuffle_elt_combined := by
  unfold dead_shuffle_elt_before dead_shuffle_elt_combined
  simp_alive_peephole
  sorry
def test_fptrunc_combined := [llvmfunc|
  llvm.func @test_fptrunc(%arg0: f64) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.poison : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.insertelement %arg0, %6[%7 : i64] : vector<2xf64>
    %9 = llvm.fptrunc %8 : vector<2xf64> to vector<2xf32>
    llvm.return %9 : vector<2xf32>
  }]

theorem inst_combine_test_fptrunc   : test_fptrunc_before  ⊑  test_fptrunc_combined := by
  unfold test_fptrunc_before test_fptrunc_combined
  simp_alive_peephole
  sorry
def test_fpext_combined := [llvmfunc|
  llvm.func @test_fpext(%arg0: f32) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.insertelement %arg0, %6[%7 : i64] : vector<2xf32>
    %9 = llvm.fpext %8 : vector<2xf32> to vector<2xf64>
    llvm.return %9 : vector<2xf64>
  }]

theorem inst_combine_test_fpext   : test_fpext_before  ⊑  test_fpext_combined := by
  unfold test_fpext_before test_fpext_combined
  simp_alive_peephole
  sorry
def test_shuffle_combined := [llvmfunc|
  llvm.func @test_shuffle(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf64>
    llvm.return %2 : vector<4xf64>
  }]

theorem inst_combine_test_shuffle   : test_shuffle_before  ⊑  test_shuffle_combined := by
  unfold test_shuffle_before test_shuffle_combined
  simp_alive_peephole
  sorry
def test_select_combined := [llvmfunc|
  llvm.func @test_select(%arg0: f32, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %13 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %14 = llvm.mlir.undef : vector<4xf32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : vector<4xf32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %13, %16[%17 : i32] : vector<4xf32>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %12, %18[%19 : i32] : vector<4xf32>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : vector<4xf32>
    %23 = llvm.insertelement %arg0, %10[%11 : i64] : vector<4xf32>
    %24 = llvm.shufflevector %23, %22 [0, 5, 6, 3] : vector<4xf32> 
    llvm.return %24 : vector<4xf32>
  }]

theorem inst_combine_test_select   : test_select_before  ⊑  test_select_combined := by
  unfold test_select_before test_select_combined
  simp_alive_peephole
  sorry
def PR24922_combined := [llvmfunc|
  llvm.func @PR24922(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.addressof @PR24922 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i1
    %3 = llvm.mlir.undef : vector<2xi1>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi1>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : vector<2xi1>
    %8 = llvm.mlir.poison : i64
    %9 = llvm.mlir.constant(0 : i64) : i64
    %10 = llvm.mlir.undef : vector<2xi64>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<2xi64>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %8, %12[%13 : i32] : vector<2xi64>
    %15 = llvm.select %7, %arg0, %14 : vector<2xi1>, vector<2xi64>
    llvm.return %15 : vector<2xi64>
  }]

theorem inst_combine_PR24922   : PR24922_before  ⊑  PR24922_combined := by
  unfold PR24922_before PR24922_combined
  simp_alive_peephole
  sorry
def inselt_shuf_no_demand_combined := [llvmfunc|
  llvm.func @inselt_shuf_no_demand(%arg0: f32, %arg1: f32, %arg2: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.undef : f32
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf32>
    llvm.return %10 : vector<4xf32>
  }]

theorem inst_combine_inselt_shuf_no_demand   : inselt_shuf_no_demand_before  ⊑  inselt_shuf_no_demand_combined := by
  unfold inselt_shuf_no_demand_before inselt_shuf_no_demand_combined
  simp_alive_peephole
  sorry
def inselt_shuf_no_demand_commute_combined := [llvmfunc|
  llvm.func @inselt_shuf_no_demand_commute(%arg0: f32, %arg1: f32, %arg2: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.undef : f32
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf32>
    llvm.return %10 : vector<4xf32>
  }]

theorem inst_combine_inselt_shuf_no_demand_commute   : inselt_shuf_no_demand_commute_before  ⊑  inselt_shuf_no_demand_commute_combined := by
  unfold inselt_shuf_no_demand_commute_before inselt_shuf_no_demand_commute_combined
  simp_alive_peephole
  sorry
def inselt_shuf_no_demand_multiuse_combined := [llvmfunc|
  llvm.func @inselt_shuf_no_demand_multiuse(%arg0: i32, %arg1: i32, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xi32>
    %4 = llvm.insertelement %arg1, %3[%2 : i64] : vector<4xi32>
    %5 = llvm.add %4, %arg2  : vector<4xi32>
    %6 = llvm.shufflevector %5, %0 [0, 1, -1, -1] : vector<4xi32> 
    llvm.return %6 : vector<4xi32>
  }]

theorem inst_combine_inselt_shuf_no_demand_multiuse   : inselt_shuf_no_demand_multiuse_before  ⊑  inselt_shuf_no_demand_multiuse_combined := by
  unfold inselt_shuf_no_demand_multiuse_before inselt_shuf_no_demand_multiuse_combined
  simp_alive_peephole
  sorry
def inselt_shuf_no_demand_bogus_insert_index_in_chain_combined := [llvmfunc|
  llvm.func @inselt_shuf_no_demand_bogus_insert_index_in_chain(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.undef : f32
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.poison : vector<4xf32>
    %12 = llvm.insertelement %arg1, %10[%arg3 : i32] : vector<4xf32>
    %13 = llvm.shufflevector %12, %11 [0, -1, -1, -1] : vector<4xf32> 
    llvm.return %13 : vector<4xf32>
  }]

theorem inst_combine_inselt_shuf_no_demand_bogus_insert_index_in_chain   : inselt_shuf_no_demand_bogus_insert_index_in_chain_before  ⊑  inselt_shuf_no_demand_bogus_insert_index_in_chain_combined := by
  unfold inselt_shuf_no_demand_bogus_insert_index_in_chain_before inselt_shuf_no_demand_bogus_insert_index_in_chain_combined
  simp_alive_peephole
  sorry
def shuf_add_combined := [llvmfunc|
  llvm.func @shuf_add(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.mlir.poison : vector<3xi8>
    %11 = llvm.add %arg0, %9 overflow<nsw>  : vector<3xi8>
    %12 = llvm.shufflevector %11, %10 [1, -1, 2] : vector<3xi8> 
    llvm.return %12 : vector<3xi8>
  }]

theorem inst_combine_shuf_add   : shuf_add_before  ⊑  shuf_add_combined := by
  unfold shuf_add_before shuf_add_combined
  simp_alive_peephole
  sorry
def shuf_sub_combined := [llvmfunc|
  llvm.func @shuf_sub(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.mlir.poison : vector<3xi8>
    %11 = llvm.sub %9, %arg0 overflow<nuw>  : vector<3xi8>
    %12 = llvm.shufflevector %11, %10 [0, -1, 2] : vector<3xi8> 
    llvm.return %12 : vector<3xi8>
  }]

theorem inst_combine_shuf_sub   : shuf_sub_before  ⊑  shuf_sub_combined := by
  unfold shuf_sub_before shuf_sub_combined
  simp_alive_peephole
  sorry
def shuf_mul_combined := [llvmfunc|
  llvm.func @shuf_mul(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.mlir.poison : vector<3xi8>
    %11 = llvm.mul %arg0, %9 overflow<nsw>  : vector<3xi8>
    %12 = llvm.shufflevector %11, %10 [0, 2, 0] : vector<3xi8> 
    llvm.return %12 : vector<3xi8>
  }]

theorem inst_combine_shuf_mul   : shuf_mul_before  ⊑  shuf_mul_combined := by
  unfold shuf_mul_before shuf_mul_combined
  simp_alive_peephole
  sorry
def shuf_and_combined := [llvmfunc|
  llvm.func @shuf_and(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.mlir.poison : vector<3xi8>
    %11 = llvm.and %arg0, %9  : vector<3xi8>
    %12 = llvm.shufflevector %11, %10 [1, 1, 0] : vector<3xi8> 
    llvm.return %12 : vector<3xi8>
  }]

theorem inst_combine_shuf_and   : shuf_and_before  ⊑  shuf_and_combined := by
  unfold shuf_and_before shuf_and_combined
  simp_alive_peephole
  sorry
def shuf_or_combined := [llvmfunc|
  llvm.func @shuf_or(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.mlir.poison : vector<3xi8>
    %11 = llvm.or %arg0, %9  : vector<3xi8>
    %12 = llvm.shufflevector %11, %10 [1, -1, 0] : vector<3xi8> 
    llvm.return %12 : vector<3xi8>
  }]

theorem inst_combine_shuf_or   : shuf_or_before  ⊑  shuf_or_combined := by
  unfold shuf_or_before shuf_or_combined
  simp_alive_peephole
  sorry
def shuf_xor_combined := [llvmfunc|
  llvm.func @shuf_xor(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.mlir.poison : vector<3xi8>
    %11 = llvm.xor %arg0, %9  : vector<3xi8>
    %12 = llvm.shufflevector %11, %10 [2, -1, 0] : vector<3xi8> 
    llvm.return %12 : vector<3xi8>
  }]

theorem inst_combine_shuf_xor   : shuf_xor_before  ⊑  shuf_xor_combined := by
  unfold shuf_xor_before shuf_xor_combined
  simp_alive_peephole
  sorry
def shuf_lshr_const_op0_combined := [llvmfunc|
  llvm.func @shuf_lshr_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.lshr %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, 1, -1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_lshr_const_op0   : shuf_lshr_const_op0_before  ⊑  shuf_lshr_const_op0_combined := by
  unfold shuf_lshr_const_op0_before shuf_lshr_const_op0_combined
  simp_alive_peephole
  sorry
def shuf_lshr_const_op1_combined := [llvmfunc|
  llvm.func @shuf_lshr_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.lshr %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, 1, -1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_lshr_const_op1   : shuf_lshr_const_op1_before  ⊑  shuf_lshr_const_op1_combined := by
  unfold shuf_lshr_const_op1_before shuf_lshr_const_op1_combined
  simp_alive_peephole
  sorry
def shuf_ashr_const_op0_combined := [llvmfunc|
  llvm.func @shuf_ashr_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.lshr %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [0, -1, 1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_ashr_const_op0   : shuf_ashr_const_op0_before  ⊑  shuf_ashr_const_op0_combined := by
  unfold shuf_ashr_const_op0_before shuf_ashr_const_op0_combined
  simp_alive_peephole
  sorry
def shuf_ashr_const_op1_combined := [llvmfunc|
  llvm.func @shuf_ashr_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.ashr %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [0, -1, 1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_ashr_const_op1   : shuf_ashr_const_op1_before  ⊑  shuf_ashr_const_op1_combined := by
  unfold shuf_ashr_const_op1_before shuf_ashr_const_op1_combined
  simp_alive_peephole
  sorry
def shuf_shl_const_op0_combined := [llvmfunc|
  llvm.func @shuf_shl_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_shl_const_op0   : shuf_shl_const_op0_before  ⊑  shuf_shl_const_op0_combined := by
  unfold shuf_shl_const_op0_before shuf_shl_const_op0_combined
  simp_alive_peephole
  sorry
def shuf_shl_const_op1_combined := [llvmfunc|
  llvm.func @shuf_shl_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_shl_const_op1   : shuf_shl_const_op1_before  ⊑  shuf_shl_const_op1_combined := by
  unfold shuf_shl_const_op1_before shuf_shl_const_op1_combined
  simp_alive_peephole
  sorry
def shuf_sdiv_const_op0_combined := [llvmfunc|
  llvm.func @shuf_sdiv_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.sdiv %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [0, -1, 1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_sdiv_const_op0   : shuf_sdiv_const_op0_before  ⊑  shuf_sdiv_const_op0_combined := by
  unfold shuf_sdiv_const_op0_before shuf_sdiv_const_op0_combined
  simp_alive_peephole
  sorry
def shuf_sdiv_const_op1_combined := [llvmfunc|
  llvm.func @shuf_sdiv_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.sdiv %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [1, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_sdiv_const_op1   : shuf_sdiv_const_op1_before  ⊑  shuf_sdiv_const_op1_combined := by
  unfold shuf_sdiv_const_op1_before shuf_sdiv_const_op1_combined
  simp_alive_peephole
  sorry
def shuf_srem_const_op0_combined := [llvmfunc|
  llvm.func @shuf_srem_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.srem %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [1, -1, 2] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_srem_const_op0   : shuf_srem_const_op0_before  ⊑  shuf_srem_const_op0_combined := by
  unfold shuf_srem_const_op0_before shuf_srem_const_op0_combined
  simp_alive_peephole
  sorry
def shuf_srem_const_op1_combined := [llvmfunc|
  llvm.func @shuf_srem_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.srem %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_srem_const_op1   : shuf_srem_const_op1_before  ⊑  shuf_srem_const_op1_combined := by
  unfold shuf_srem_const_op1_before shuf_srem_const_op1_combined
  simp_alive_peephole
  sorry
def shuf_udiv_const_op0_combined := [llvmfunc|
  llvm.func @shuf_udiv_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.udiv %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_udiv_const_op0   : shuf_udiv_const_op0_before  ⊑  shuf_udiv_const_op0_combined := by
  unfold shuf_udiv_const_op0_before shuf_udiv_const_op0_combined
  simp_alive_peephole
  sorry
def shuf_udiv_const_op1_combined := [llvmfunc|
  llvm.func @shuf_udiv_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.udiv %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, -1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_udiv_const_op1   : shuf_udiv_const_op1_before  ⊑  shuf_udiv_const_op1_combined := by
  unfold shuf_udiv_const_op1_before shuf_udiv_const_op1_combined
  simp_alive_peephole
  sorry
def shuf_urem_const_op0_combined := [llvmfunc|
  llvm.func @shuf_urem_const_op0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.urem %0, %arg0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [2, 1, -1] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_urem_const_op0   : shuf_urem_const_op0_before  ⊑  shuf_urem_const_op0_combined := by
  unfold shuf_urem_const_op0_before shuf_urem_const_op0_combined
  simp_alive_peephole
  sorry
def shuf_urem_const_op1_combined := [llvmfunc|
  llvm.func @shuf_urem_const_op1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.poison : vector<3xi8>
    %2 = llvm.urem %arg0, %0  : vector<3xi8>
    %3 = llvm.shufflevector %2, %1 [-1, 1, 0] : vector<3xi8> 
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_urem_const_op1   : shuf_urem_const_op1_before  ⊑  shuf_urem_const_op1_combined := by
  unfold shuf_urem_const_op1_before shuf_urem_const_op1_combined
  simp_alive_peephole
  sorry
def shuf_fadd_combined := [llvmfunc|
  llvm.func @shuf_fadd(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<3xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xf32>
    %10 = llvm.mlir.poison : vector<3xf32>
    %11 = llvm.fadd %arg0, %9  : vector<3xf32>
    %12 = llvm.shufflevector %11, %10 [-1, 1, 0] : vector<3xf32> 
    llvm.return %12 : vector<3xf32>
  }]

theorem inst_combine_shuf_fadd   : shuf_fadd_before  ⊑  shuf_fadd_combined := by
  unfold shuf_fadd_before shuf_fadd_combined
  simp_alive_peephole
  sorry
def shuf_fsub_combined := [llvmfunc|
  llvm.func @shuf_fsub(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<3xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xf32>
    %10 = llvm.mlir.poison : vector<3xf32>
    %11 = llvm.fsub %9, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<3xf32>]

theorem inst_combine_shuf_fsub   : shuf_fsub_before  ⊑  shuf_fsub_combined := by
  unfold shuf_fsub_before shuf_fsub_combined
  simp_alive_peephole
  sorry
    %12 = llvm.shufflevector %11, %10 [-1, 0, 2] : vector<3xf32> 
    llvm.return %12 : vector<3xf32>
  }]

theorem inst_combine_shuf_fsub   : shuf_fsub_before  ⊑  shuf_fsub_combined := by
  unfold shuf_fsub_before shuf_fsub_combined
  simp_alive_peephole
  sorry
def shuf_fmul_combined := [llvmfunc|
  llvm.func @shuf_fmul(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<3xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xf32>
    %10 = llvm.mlir.poison : vector<3xf32>
    %11 = llvm.fmul %arg0, %9  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<3xf32>]

theorem inst_combine_shuf_fmul   : shuf_fmul_before  ⊑  shuf_fmul_combined := by
  unfold shuf_fmul_before shuf_fmul_combined
  simp_alive_peephole
  sorry
    %12 = llvm.shufflevector %11, %10 [-1, 1, 0] : vector<3xf32> 
    llvm.return %12 : vector<3xf32>
  }]

theorem inst_combine_shuf_fmul   : shuf_fmul_before  ⊑  shuf_fmul_combined := by
  unfold shuf_fmul_before shuf_fmul_combined
  simp_alive_peephole
  sorry
def shuf_fdiv_const_op0_combined := [llvmfunc|
  llvm.func @shuf_fdiv_const_op0(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<3xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xf32>
    %10 = llvm.mlir.poison : vector<3xf32>
    %11 = llvm.fdiv %9, %arg0  {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : vector<3xf32>]

theorem inst_combine_shuf_fdiv_const_op0   : shuf_fdiv_const_op0_before  ⊑  shuf_fdiv_const_op0_combined := by
  unfold shuf_fdiv_const_op0_before shuf_fdiv_const_op0_combined
  simp_alive_peephole
  sorry
    %12 = llvm.shufflevector %11, %10 [-1, 0, 2] : vector<3xf32> 
    llvm.return %12 : vector<3xf32>
  }]

theorem inst_combine_shuf_fdiv_const_op0   : shuf_fdiv_const_op0_before  ⊑  shuf_fdiv_const_op0_combined := by
  unfold shuf_fdiv_const_op0_before shuf_fdiv_const_op0_combined
  simp_alive_peephole
  sorry
def shuf_fdiv_const_op1_combined := [llvmfunc|
  llvm.func @shuf_fdiv_const_op1(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<3xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xf32>
    %10 = llvm.mlir.poison : vector<3xf32>
    %11 = llvm.fdiv %arg0, %9  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<3xf32>]

theorem inst_combine_shuf_fdiv_const_op1   : shuf_fdiv_const_op1_before  ⊑  shuf_fdiv_const_op1_combined := by
  unfold shuf_fdiv_const_op1_before shuf_fdiv_const_op1_combined
  simp_alive_peephole
  sorry
    %12 = llvm.shufflevector %11, %10 [-1, 1, 0] : vector<3xf32> 
    llvm.return %12 : vector<3xf32>
  }]

theorem inst_combine_shuf_fdiv_const_op1   : shuf_fdiv_const_op1_before  ⊑  shuf_fdiv_const_op1_combined := by
  unfold shuf_fdiv_const_op1_before shuf_fdiv_const_op1_combined
  simp_alive_peephole
  sorry
def shuf_frem_const_op0_combined := [llvmfunc|
  llvm.func @shuf_frem_const_op0(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<3xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xf32>
    %10 = llvm.mlir.poison : vector<3xf32>
    %11 = llvm.frem %9, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : vector<3xf32>]

theorem inst_combine_shuf_frem_const_op0   : shuf_frem_const_op0_before  ⊑  shuf_frem_const_op0_combined := by
  unfold shuf_frem_const_op0_before shuf_frem_const_op0_combined
  simp_alive_peephole
  sorry
    %12 = llvm.shufflevector %11, %10 [-1, 2, 0] : vector<3xf32> 
    llvm.return %12 : vector<3xf32>
  }]

theorem inst_combine_shuf_frem_const_op0   : shuf_frem_const_op0_before  ⊑  shuf_frem_const_op0_combined := by
  unfold shuf_frem_const_op0_before shuf_frem_const_op0_combined
  simp_alive_peephole
  sorry
def shuf_frem_const_op1_combined := [llvmfunc|
  llvm.func @shuf_frem_const_op1(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.poison : f32
    %3 = llvm.mlir.undef : vector<3xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xf32>
    %10 = llvm.mlir.poison : vector<3xf32>
    %11 = llvm.frem %arg0, %9  {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : vector<3xf32>]

theorem inst_combine_shuf_frem_const_op1   : shuf_frem_const_op1_before  ⊑  shuf_frem_const_op1_combined := by
  unfold shuf_frem_const_op1_before shuf_frem_const_op1_combined
  simp_alive_peephole
  sorry
    %12 = llvm.shufflevector %11, %10 [1, -1, 2] : vector<3xf32> 
    llvm.return %12 : vector<3xf32>
  }]

theorem inst_combine_shuf_frem_const_op1   : shuf_frem_const_op1_before  ⊑  shuf_frem_const_op1_combined := by
  unfold shuf_frem_const_op1_before shuf_frem_const_op1_combined
  simp_alive_peephole
  sorry
def gep_vbase_w_s_idx_combined := [llvmfunc|
  llvm.func @gep_vbase_w_s_idx(%arg0: !llvm.vec<2 x ptr>, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : !llvm.vec<2 x ptr>
    %2 = llvm.getelementptr %1[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_gep_vbase_w_s_idx   : gep_vbase_w_s_idx_before  ⊑  gep_vbase_w_s_idx_combined := by
  unfold gep_vbase_w_s_idx_before gep_vbase_w_s_idx_combined
  simp_alive_peephole
  sorry
def gep_splat_base_w_s_idx_combined := [llvmfunc|
  llvm.func @gep_splat_base_w_s_idx(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_gep_splat_base_w_s_idx   : gep_splat_base_w_s_idx_before  ⊑  gep_splat_base_w_s_idx_combined := by
  unfold gep_splat_base_w_s_idx_before gep_splat_base_w_s_idx_combined
  simp_alive_peephole
  sorry
def gep_splat_base_w_cv_idx_combined := [llvmfunc|
  llvm.func @gep_splat_base_w_cv_idx(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.poison : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.poison : i64
    %3 = llvm.mlir.undef : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi64>
    %8 = llvm.insertelement %arg0, %0[%1 : i64] : !llvm.vec<2 x ptr>
    %9 = llvm.getelementptr %8[%7] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %10 = llvm.extractelement %9[%1 : i64] : !llvm.vec<2 x ptr>
    llvm.return %10 : !llvm.ptr
  }]

theorem inst_combine_gep_splat_base_w_cv_idx   : gep_splat_base_w_cv_idx_before  ⊑  gep_splat_base_w_cv_idx_combined := by
  unfold gep_splat_base_w_cv_idx_before gep_splat_base_w_cv_idx_combined
  simp_alive_peephole
  sorry
def gep_splat_base_w_vidx_combined := [llvmfunc|
  llvm.func @gep_splat_base_w_vidx(%arg0: !llvm.ptr, %arg1: vector<2xi64>) -> !llvm.ptr {
    %0 = llvm.mlir.poison : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : !llvm.vec<2 x ptr>
    %3 = llvm.getelementptr %2[%arg1] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %4 = llvm.extractelement %3[%1 : i64] : !llvm.vec<2 x ptr>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_gep_splat_base_w_vidx   : gep_splat_base_w_vidx_before  ⊑  gep_splat_base_w_vidx_combined := by
  unfold gep_splat_base_w_vidx_before gep_splat_base_w_vidx_combined
  simp_alive_peephole
  sorry
def gep_cvbase_w_s_idx_combined := [llvmfunc|
  llvm.func @gep_cvbase_w_s_idx(%arg0: !llvm.vec<2 x ptr>, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @GLOBAL : !llvm.ptr
    %2 = llvm.getelementptr %1[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_gep_cvbase_w_s_idx   : gep_cvbase_w_s_idx_before  ⊑  gep_cvbase_w_s_idx_combined := by
  unfold gep_cvbase_w_s_idx_before gep_cvbase_w_s_idx_combined
  simp_alive_peephole
  sorry
def gep_cvbase_w_cv_idx_combined := [llvmfunc|
  llvm.func @gep_cvbase_w_cv_idx(%arg0: !llvm.vec<2 x ptr>, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @GLOBAL : !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_gep_cvbase_w_cv_idx   : gep_cvbase_w_cv_idx_before  ⊑  gep_cvbase_w_cv_idx_combined := by
  unfold gep_cvbase_w_cv_idx_before gep_cvbase_w_cv_idx_combined
  simp_alive_peephole
  sorry
def gep_sbase_w_cv_idx_combined := [llvmfunc|
  llvm.func @gep_sbase_w_cv_idx(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_gep_sbase_w_cv_idx   : gep_sbase_w_cv_idx_before  ⊑  gep_sbase_w_cv_idx_combined := by
  unfold gep_sbase_w_cv_idx_before gep_sbase_w_cv_idx_combined
  simp_alive_peephole
  sorry
def gep_sbase_w_splat_idx_combined := [llvmfunc|
  llvm.func @gep_sbase_w_splat_idx(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_gep_sbase_w_splat_idx   : gep_sbase_w_splat_idx_before  ⊑  gep_sbase_w_splat_idx_combined := by
  unfold gep_sbase_w_splat_idx_before gep_sbase_w_splat_idx_combined
  simp_alive_peephole
  sorry
def gep_splat_both_combined := [llvmfunc|
  llvm.func @gep_splat_both(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.poison : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.poison : vector<2xi64>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : !llvm.vec<2 x ptr>
    %4 = llvm.insertelement %arg1, %2[%1 : i64] : vector<2xi64>
    %5 = llvm.getelementptr %3[%4] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %6 = llvm.extractelement %5[%1 : i64] : !llvm.vec<2 x ptr>
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_gep_splat_both   : gep_splat_both_before  ⊑  gep_splat_both_combined := by
  unfold gep_splat_both_before gep_splat_both_combined
  simp_alive_peephole
  sorry
def gep_all_lanes_undef_combined := [llvmfunc|
  llvm.func @gep_all_lanes_undef(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.undef : !llvm.ptr
    %1 = llvm.mlir.poison : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : !llvm.vec<2 x ptr>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : !llvm.vec<2 x ptr>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.poison : i64
    %9 = llvm.mlir.undef : i64
    %10 = llvm.mlir.undef : vector<2xi64>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<2xi64>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %8, %12[%13 : i32] : vector<2xi64>
    %15 = llvm.mlir.constant(1 : i64) : i64
    %16 = llvm.insertelement %arg0, %6[%7 : i64] : !llvm.vec<2 x ptr>
    %17 = llvm.insertelement %arg1, %14[%15 : i64] : vector<2xi64>
    %18 = llvm.getelementptr %16[%17] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    llvm.return %18 : !llvm.vec<2 x ptr>
  }]

theorem inst_combine_gep_all_lanes_undef   : gep_all_lanes_undef_before  ⊑  gep_all_lanes_undef_combined := by
  unfold gep_all_lanes_undef_before gep_all_lanes_undef_combined
  simp_alive_peephole
  sorry
def gep_demanded_lane_undef_combined := [llvmfunc|
  llvm.func @gep_demanded_lane_undef(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.undef : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_gep_demanded_lane_undef   : gep_demanded_lane_undef_before  ⊑  gep_demanded_lane_undef_combined := by
  unfold gep_demanded_lane_undef_before gep_demanded_lane_undef_combined
  simp_alive_peephole
  sorry
def PR41624_combined := [llvmfunc|
  llvm.func @PR41624(%arg0: !llvm.vec<2 x ptr>) -> !llvm.ptr {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.getelementptr %arg0[%0, 0] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.struct<(i32, i32)>
    %5 = llvm.extractelement %4[%3 : i64] : !llvm.vec<2 x ptr>
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_PR41624   : PR41624_before  ⊑  PR41624_combined := by
  unfold PR41624_before PR41624_combined
  simp_alive_peephole
  sorry
def zero_sized_type_extract_combined := [llvmfunc|
  llvm.func @zero_sized_type_extract(%arg0: vector<4xi64>, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.poison : !llvm.ptr
    %1 = llvm.mlir.addressof @global : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.vec<4 x ptr>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : !llvm.vec<4 x ptr>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : !llvm.vec<4 x ptr>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : !llvm.vec<4 x ptr>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : !llvm.vec<4 x ptr>
    %11 = llvm.mlir.poison : i64
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.undef : vector<4xi64>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %12, %13[%14 : i32] : vector<4xi64>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %11, %15[%16 : i32] : vector<4xi64>
    %18 = llvm.mlir.constant(2 : i32) : i32
    %19 = llvm.insertelement %11, %17[%18 : i32] : vector<4xi64>
    %20 = llvm.mlir.constant(3 : i32) : i32
    %21 = llvm.insertelement %11, %19[%20 : i32] : vector<4xi64>
    %22 = llvm.getelementptr inbounds %10[%21, %arg0] : (!llvm.vec<4 x ptr>, vector<4xi64>, vector<4xi64>) -> !llvm.vec<4 x ptr>, !llvm.array<0 x i32>
    %23 = llvm.extractelement %22[%12 : i64] : !llvm.vec<4 x ptr>
    llvm.return %23 : !llvm.ptr
  }]

theorem inst_combine_zero_sized_type_extract   : zero_sized_type_extract_before  ⊑  zero_sized_type_extract_combined := by
  unfold zero_sized_type_extract_before zero_sized_type_extract_combined
  simp_alive_peephole
  sorry
def select_cond_with_eq_true_false_elts_combined := [llvmfunc|
  llvm.func @select_cond_with_eq_true_false_elts(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.select %arg2, %arg0, %arg1 : vector<4xi1>, vector<4xi8>
    %1 = llvm.shufflevector %0, %arg1 [0, 5, 6, 7] : vector<4xi8> 
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_select_cond_with_eq_true_false_elts   : select_cond_with_eq_true_false_elts_before  ⊑  select_cond_with_eq_true_false_elts_combined := by
  unfold select_cond_with_eq_true_false_elts_before select_cond_with_eq_true_false_elts_combined
  simp_alive_peephole
  sorry
def select_cond_with_eq_true_false_elts2_combined := [llvmfunc|
  llvm.func @select_cond_with_eq_true_false_elts2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi1>
    %1 = llvm.shufflevector %arg2, %0 [-1, 1, 0, 1] : vector<4xi1> 
    %2 = llvm.select %1, %arg1, %arg0 : vector<4xi1>, vector<4xi8>
    %3 = llvm.shufflevector %arg0, %2 [0, 5, 6, 7] : vector<4xi8> 
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_select_cond_with_eq_true_false_elts2   : select_cond_with_eq_true_false_elts2_before  ⊑  select_cond_with_eq_true_false_elts2_combined := by
  unfold select_cond_with_eq_true_false_elts2_before select_cond_with_eq_true_false_elts2_combined
  simp_alive_peephole
  sorry
def select_cond_with_eq_true_false_elts3_combined := [llvmfunc|
  llvm.func @select_cond_with_eq_true_false_elts3(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi1>) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xi1>
    %1 = llvm.shufflevector %arg0, %arg1 [1, 3, 5, -1] : vector<4xf32> 
    %2 = llvm.shufflevector %arg1, %arg0 [0, 7, 6, -1] : vector<4xf32> 
    %3 = llvm.shufflevector %arg2, %0 [-1, 1, 2, 3] : vector<4xi1> 
    %4 = llvm.select %3, %1, %2 : vector<4xi1>, vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

theorem inst_combine_select_cond_with_eq_true_false_elts3   : select_cond_with_eq_true_false_elts3_before  ⊑  select_cond_with_eq_true_false_elts3_combined := by
  unfold select_cond_with_eq_true_false_elts3_before select_cond_with_eq_true_false_elts3_combined
  simp_alive_peephole
  sorry
def select_cond_with_undef_true_false_elts_combined := [llvmfunc|
  llvm.func @select_cond_with_undef_true_false_elts(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.poison : vector<4xi1>
    %2 = llvm.shufflevector %arg1, %0 [-1, 1, 2, 3] : vector<4xi8> 
    %3 = llvm.shufflevector %arg2, %1 [0, 1, 0, 1] : vector<4xi1> 
    %4 = llvm.select %3, %2, %arg0 : vector<4xi1>, vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

theorem inst_combine_select_cond_with_undef_true_false_elts   : select_cond_with_undef_true_false_elts_before  ⊑  select_cond_with_undef_true_false_elts_combined := by
  unfold select_cond_with_undef_true_false_elts_before select_cond_with_undef_true_false_elts_combined
  simp_alive_peephole
  sorry
def select_cond__combined := [llvmfunc|
  llvm.func @select_cond_(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi1>, %arg3: i1) -> vector<4xi8> {
    %0 = llvm.select %arg2, %arg1, %arg0 : vector<4xi1>, vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 5, 6, 7] : vector<4xi8> 
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_select_cond_   : select_cond__before  ⊑  select_cond__combined := by
  unfold select_cond__before select_cond__combined
  simp_alive_peephole
  sorry
def ins_of_ext_combined := [llvmfunc|
  llvm.func @ins_of_ext(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.insertelement %arg1, %arg0[%0 : i64] : vector<4xf32>
    %4 = llvm.insertelement %arg1, %3[%1 : i64] : vector<4xf32>
    %5 = llvm.insertelement %arg1, %4[%2 : i64] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

theorem inst_combine_ins_of_ext   : ins_of_ext_before  ⊑  ins_of_ext_combined := by
  unfold ins_of_ext_before ins_of_ext_combined
  simp_alive_peephole
  sorry
def ins_of_ext_twice_combined := [llvmfunc|
  llvm.func @ins_of_ext_twice(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.insertelement %arg1, %arg0[%0 : i64] : vector<4xf32>
    %3 = llvm.insertelement %arg1, %2[%1 : i64] : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_ins_of_ext_twice   : ins_of_ext_twice_before  ⊑  ins_of_ext_twice_combined := by
  unfold ins_of_ext_twice_before ins_of_ext_twice_combined
  simp_alive_peephole
  sorry
def ins_of_ext_wrong_demand_combined := [llvmfunc|
  llvm.func @ins_of_ext_wrong_demand(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.undef : f32
    %2 = llvm.mlir.poison : f32
    %3 = llvm.mlir.undef : vector<4xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xf32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xf32>
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.extractelement %arg0[%0 : i64] : vector<4xf32>
    %15 = llvm.insertelement %14, %11[%0 : i64] : vector<4xf32>
    %16 = llvm.insertelement %arg1, %15[%12 : i64] : vector<4xf32>
    %17 = llvm.insertelement %arg1, %16[%13 : i64] : vector<4xf32>
    llvm.return %17 : vector<4xf32>
  }]

theorem inst_combine_ins_of_ext_wrong_demand   : ins_of_ext_wrong_demand_before  ⊑  ins_of_ext_wrong_demand_combined := by
  unfold ins_of_ext_wrong_demand_before ins_of_ext_wrong_demand_combined
  simp_alive_peephole
  sorry
def ins_of_ext_wrong_type_combined := [llvmfunc|
  llvm.func @ins_of_ext_wrong_type(%arg0: vector<5xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xf32>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.extractelement %arg0[%0 : i64] : vector<5xf32>
    %6 = llvm.insertelement %5, %1[%0 : i64] : vector<4xf32>
    %7 = llvm.insertelement %arg1, %6[%2 : i64] : vector<4xf32>
    %8 = llvm.insertelement %arg1, %7[%3 : i64] : vector<4xf32>
    %9 = llvm.insertelement %arg1, %8[%4 : i64] : vector<4xf32>
    llvm.return %9 : vector<4xf32>
  }]

theorem inst_combine_ins_of_ext_wrong_type   : ins_of_ext_wrong_type_before  ⊑  ins_of_ext_wrong_type_combined := by
  unfold ins_of_ext_wrong_type_before ins_of_ext_wrong_type_combined
  simp_alive_peephole
  sorry
def ins_of_ext_undef_elts_propagation_combined := [llvmfunc|
  llvm.func @ins_of_ext_undef_elts_propagation(%arg0: vector<4xi4>, %arg1: vector<4xi4>, %arg2: i4) -> vector<4xi4> {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.insertelement %arg2, %arg0[%0 : i64] : vector<4xi4>
    %2 = llvm.shufflevector %1, %arg1 [0, 6, 2, 7] : vector<4xi4> 
    llvm.return %2 : vector<4xi4>
  }]

theorem inst_combine_ins_of_ext_undef_elts_propagation   : ins_of_ext_undef_elts_propagation_before  ⊑  ins_of_ext_undef_elts_propagation_combined := by
  unfold ins_of_ext_undef_elts_propagation_before ins_of_ext_undef_elts_propagation_combined
  simp_alive_peephole
  sorry
def ins_of_ext_undef_elts_propagation2_combined := [llvmfunc|
  llvm.func @ins_of_ext_undef_elts_propagation2(%arg0: vector<8xi4>, %arg1: vector<8xi4>, %arg2: i4) -> vector<8xi4> {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.insertelement %arg2, %arg0[%0 : i64] : vector<8xi4>
    %2 = llvm.shufflevector %1, %arg1 [0, 1, 2, 11, 10, 9, 8, -1] : vector<8xi4> 
    %3 = llvm.shufflevector %2, %arg0 [0, 1, 2, 3, 4, 5, 6, 15] : vector<8xi4> 
    llvm.return %3 : vector<8xi4>
  }]

theorem inst_combine_ins_of_ext_undef_elts_propagation2   : ins_of_ext_undef_elts_propagation2_before  ⊑  ins_of_ext_undef_elts_propagation2_combined := by
  unfold ins_of_ext_undef_elts_propagation2_before ins_of_ext_undef_elts_propagation2_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_splat_op0_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %2 = llvm.mul %1, %arg1  : vector<2xi4>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xi4> 
    llvm.call @use(%2) : (vector<2xi4>) -> ()
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.return
  }]

theorem inst_combine_common_binop_demand_via_splat_op0   : common_binop_demand_via_splat_op0_before  ⊑  common_binop_demand_via_splat_op0_combined := by
  unfold common_binop_demand_via_splat_op0_before common_binop_demand_via_splat_op0_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_splat_op1_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.poison : vector<2xi4>
    %4 = llvm.sub %2, %arg0  : vector<2xi4>
    %5 = llvm.shufflevector %arg1, %3 [0, 0] : vector<2xi4> 
    %6 = llvm.mul %4, %5  : vector<2xi4>
    %7 = llvm.shufflevector %6, %3 [0, 0] : vector<2xi4> 
    llvm.call @use(%7) : (vector<2xi4>) -> ()
    llvm.call @use(%6) : (vector<2xi4>) -> ()
    llvm.return
  }]

theorem inst_combine_common_binop_demand_via_splat_op1   : common_binop_demand_via_splat_op1_before  ⊑  common_binop_demand_via_splat_op1_combined := by
  unfold common_binop_demand_via_splat_op1_before common_binop_demand_via_splat_op1_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_splat_op0_commute_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op0_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.poison : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.mlir.constant(2 : i4) : i4
    %8 = llvm.mlir.constant(1 : i4) : i4
    %9 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi4>) : vector<2xi4>
    %10 = llvm.mlir.poison : vector<2xi4>
    %11 = llvm.sub %6, %arg0  : vector<2xi4>
    %12 = llvm.sub %9, %arg1  : vector<2xi4>
    %13 = llvm.shufflevector %11, %10 [0, 0] : vector<2xi4> 
    %14 = llvm.mul %12, %13  : vector<2xi4>
    %15 = llvm.shufflevector %14, %10 [0, 0] : vector<2xi4> 
    llvm.call @use(%15) : (vector<2xi4>) -> ()
    llvm.call @use(%14) : (vector<2xi4>) -> ()
    llvm.return
  }]

theorem inst_combine_common_binop_demand_via_splat_op0_commute   : common_binop_demand_via_splat_op0_commute_before  ⊑  common_binop_demand_via_splat_op0_commute_combined := by
  unfold common_binop_demand_via_splat_op0_commute_before common_binop_demand_via_splat_op0_commute_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_splat_op1_commute_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op1_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.poison : i4
    %4 = llvm.mlir.constant(2 : i4) : i4
    %5 = llvm.mlir.undef : vector<2xi4>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xi4>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<2xi4>
    %10 = llvm.mlir.poison : vector<2xi4>
    %11 = llvm.sub %2, %arg0  : vector<2xi4>
    %12 = llvm.sub %9, %arg1  : vector<2xi4>
    %13 = llvm.shufflevector %12, %10 [0, 0] : vector<2xi4> 
    %14 = llvm.mul %13, %11  : vector<2xi4>
    %15 = llvm.shufflevector %14, %10 [0, 0] : vector<2xi4> 
    llvm.call @use(%15) : (vector<2xi4>) -> ()
    llvm.call @use(%14) : (vector<2xi4>) -> ()
    llvm.return
  }]

theorem inst_combine_common_binop_demand_via_splat_op1_commute   : common_binop_demand_via_splat_op1_commute_before  ⊑  common_binop_demand_via_splat_op1_commute_combined := by
  unfold common_binop_demand_via_splat_op1_commute_before common_binop_demand_via_splat_op1_commute_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_splat_op0_wrong_commute_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op0_wrong_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %2 = llvm.sub %arg1, %1  : vector<2xi4>
    %3 = llvm.sub %arg0, %arg1  : vector<2xi4>
    %4 = llvm.shufflevector %3, %0 [0, 0] : vector<2xi4> 
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.call @use(%2) : (vector<2xi4>) -> ()
    llvm.return
  }]

theorem inst_combine_common_binop_demand_via_splat_op0_wrong_commute   : common_binop_demand_via_splat_op0_wrong_commute_before  ⊑  common_binop_demand_via_splat_op0_wrong_commute_combined := by
  unfold common_binop_demand_via_splat_op0_wrong_commute_before common_binop_demand_via_splat_op0_wrong_commute_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_splat_op0_not_dominated1_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op0_not_dominated1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mul %arg0, %arg1  : vector<2xi4>
    %2 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.mul %2, %arg1  : vector<2xi4>
    %4 = llvm.shufflevector %1, %0 [0, 0] : vector<2xi4> 
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.return
  }]

theorem inst_combine_common_binop_demand_via_splat_op0_not_dominated1   : common_binop_demand_via_splat_op0_not_dominated1_before  ⊑  common_binop_demand_via_splat_op0_not_dominated1_combined := by
  unfold common_binop_demand_via_splat_op0_not_dominated1_before common_binop_demand_via_splat_op0_not_dominated1_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_splat_op0_not_dominated2_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_op0_not_dominated2(%arg0: vector<2xi4>, %arg1: vector<2xi4>) {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mul %arg0, %arg1  : vector<2xi4>
    %2 = llvm.shufflevector %1, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %4 = llvm.mul %3, %arg1  : vector<2xi4>
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.call @use(%2) : (vector<2xi4>) -> ()
    llvm.return
  }]

theorem inst_combine_common_binop_demand_via_splat_op0_not_dominated2   : common_binop_demand_via_splat_op0_not_dominated2_before  ⊑  common_binop_demand_via_splat_op0_not_dominated2_combined := by
  unfold common_binop_demand_via_splat_op0_not_dominated2_before common_binop_demand_via_splat_op0_not_dominated2_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_extelt_op0_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.sub %2, %arg1  : vector<2xi4>
    %4 = llvm.extractelement %3[%1 : i64] : vector<2xi4>
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.return %4 : i4
  }]

theorem inst_combine_common_binop_demand_via_extelt_op0   : common_binop_demand_via_extelt_op0_before  ⊑  common_binop_demand_via_extelt_op0_combined := by
  unfold common_binop_demand_via_extelt_op0_before common_binop_demand_via_extelt_op0_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_extelt_op1_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op1(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> f32 {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, 1.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.poison : vector<2xf32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.fsub %0, %arg0  : vector<2xf32>
    %4 = llvm.shufflevector %arg1, %1 [0, 0] : vector<2xf32> 
    %5 = llvm.fdiv %3, %4  : vector<2xf32>
    %6 = llvm.extractelement %5[%2 : i64] : vector<2xf32>
    llvm.call @use_fp(%5) : (vector<2xf32>) -> ()
    llvm.return %6 : f32
  }]

theorem inst_combine_common_binop_demand_via_extelt_op1   : common_binop_demand_via_extelt_op1_before  ⊑  common_binop_demand_via_extelt_op1_combined := by
  unfold common_binop_demand_via_extelt_op1_before common_binop_demand_via_extelt_op1_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_extelt_op0_commute_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0_commute(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> f32 {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(dense<[3.000000e+00, 2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %8 = llvm.mlir.poison : vector<2xf32>
    %9 = llvm.mlir.constant(0 : i64) : i64
    %10 = llvm.fsub %6, %arg0  : vector<2xf32>
    %11 = llvm.fsub %7, %arg1  : vector<2xf32>
    %12 = llvm.shufflevector %10, %8 [0, 0] : vector<2xf32> 
    %13 = llvm.fmul %11, %12  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

theorem inst_combine_common_binop_demand_via_extelt_op0_commute   : common_binop_demand_via_extelt_op0_commute_before  ⊑  common_binop_demand_via_extelt_op0_commute_combined := by
  unfold common_binop_demand_via_extelt_op0_commute_before common_binop_demand_via_extelt_op0_commute_combined
  simp_alive_peephole
  sorry
    %14 = llvm.extractelement %13[%9 : i64] : vector<2xf32>
    llvm.call @use_fp(%13) : (vector<2xf32>) -> ()
    llvm.return %14 : f32
  }]

theorem inst_combine_common_binop_demand_via_extelt_op0_commute   : common_binop_demand_via_extelt_op0_commute_before  ⊑  common_binop_demand_via_extelt_op0_commute_combined := by
  unfold common_binop_demand_via_extelt_op0_commute_before common_binop_demand_via_extelt_op0_commute_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_extelt_op1_commute_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op1_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.poison : i4
    %4 = llvm.mlir.constant(2 : i4) : i4
    %5 = llvm.mlir.undef : vector<2xi4>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xi4>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<2xi4>
    %10 = llvm.mlir.poison : vector<2xi4>
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.sub %2, %arg0  : vector<2xi4>
    %13 = llvm.sub %9, %arg1  : vector<2xi4>
    %14 = llvm.shufflevector %13, %10 [0, 0] : vector<2xi4> 
    %15 = llvm.or %14, %12  : vector<2xi4>
    %16 = llvm.extractelement %15[%11 : i64] : vector<2xi4>
    llvm.call @use(%15) : (vector<2xi4>) -> ()
    llvm.return %16 : i4
  }]

theorem inst_combine_common_binop_demand_via_extelt_op1_commute   : common_binop_demand_via_extelt_op1_commute_before  ⊑  common_binop_demand_via_extelt_op1_commute_combined := by
  unfold common_binop_demand_via_extelt_op1_commute_before common_binop_demand_via_extelt_op1_commute_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_extelt_op0_wrong_commute_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0_wrong_commute(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.sub %arg1, %2  : vector<2xi4>
    %4 = llvm.sub %arg0, %arg1  : vector<2xi4>
    %5 = llvm.extractelement %4[%1 : i64] : vector<2xi4>
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }]

theorem inst_combine_common_binop_demand_via_extelt_op0_wrong_commute   : common_binop_demand_via_extelt_op0_wrong_commute_before  ⊑  common_binop_demand_via_extelt_op0_wrong_commute_combined := by
  unfold common_binop_demand_via_extelt_op0_wrong_commute_before common_binop_demand_via_extelt_op0_wrong_commute_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_extelt_op0_not_dominated1_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0_not_dominated1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %4 = llvm.xor %3, %arg1  : vector<2xi4>
    %5 = llvm.extractelement %2[%1 : i64] : vector<2xi4>
    llvm.call @use(%4) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }]

theorem inst_combine_common_binop_demand_via_extelt_op0_not_dominated1   : common_binop_demand_via_extelt_op0_not_dominated1_before  ⊑  common_binop_demand_via_extelt_op0_not_dominated1_combined := by
  unfold common_binop_demand_via_extelt_op0_not_dominated1_before common_binop_demand_via_extelt_op0_not_dominated1_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_extelt_op0_not_dominated2_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0_not_dominated2(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.poison : vector<2xi4>
    %2 = llvm.mul %arg0, %arg1  : vector<2xi4>
    %3 = llvm.extractelement %2[%0 : i64] : vector<2xi4>
    %4 = llvm.shufflevector %arg0, %1 [0, 0] : vector<2xi4> 
    %5 = llvm.mul %4, %arg1  : vector<2xi4>
    llvm.call @use(%5) : (vector<2xi4>) -> ()
    llvm.return %3 : i4
  }]

theorem inst_combine_common_binop_demand_via_extelt_op0_not_dominated2   : common_binop_demand_via_extelt_op0_not_dominated2_before  ⊑  common_binop_demand_via_extelt_op0_not_dominated2_combined := by
  unfold common_binop_demand_via_extelt_op0_not_dominated2_before common_binop_demand_via_extelt_op0_not_dominated2_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_extelt_op0_mismatch_elt0_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0_mismatch_elt0(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.shufflevector %arg0, %0 [1, 1] : vector<2xi4> 
    %3 = llvm.sub %2, %arg1  : vector<2xi4>
    %4 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi4>
    %5 = llvm.extractelement %4[%1 : i64] : vector<2xi4>
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }]

theorem inst_combine_common_binop_demand_via_extelt_op0_mismatch_elt0   : common_binop_demand_via_extelt_op0_mismatch_elt0_before  ⊑  common_binop_demand_via_extelt_op0_mismatch_elt0_combined := by
  unfold common_binop_demand_via_extelt_op0_mismatch_elt0_before common_binop_demand_via_extelt_op0_mismatch_elt0_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_extelt_op0_mismatch_elt1_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_extelt_op0_mismatch_elt1(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> i4 {
    %0 = llvm.mlir.poison : vector<2xi4>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.shufflevector %arg0, %0 [0, 0] : vector<2xi4> 
    %3 = llvm.sub %2, %arg1  : vector<2xi4>
    %4 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi4>
    %5 = llvm.extractelement %4[%1 : i64] : vector<2xi4>
    llvm.call @use(%3) : (vector<2xi4>) -> ()
    llvm.return %5 : i4
  }]

theorem inst_combine_common_binop_demand_via_extelt_op0_mismatch_elt1   : common_binop_demand_via_extelt_op0_mismatch_elt1_before  ⊑  common_binop_demand_via_extelt_op0_mismatch_elt1_combined := by
  unfold common_binop_demand_via_extelt_op0_mismatch_elt1_before common_binop_demand_via_extelt_op0_mismatch_elt1_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_splat_mask_poison_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_mask_poison(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg1, %0 [0, -1] : vector<2xi8> 
    %2 = llvm.add %1, %arg0  : vector<2xi8>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xi8> 
    %4 = llvm.add %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_common_binop_demand_via_splat_mask_poison   : common_binop_demand_via_splat_mask_poison_before  ⊑  common_binop_demand_via_splat_mask_poison_combined := by
  unfold common_binop_demand_via_splat_mask_poison_before common_binop_demand_via_splat_mask_poison_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_splat_mask_poison_2_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_mask_poison_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg1, %0 [-1, 0] : vector<2xi8> 
    %2 = llvm.add %1, %arg0  : vector<2xi8>
    %3 = llvm.shufflevector %2, %arg1 [0, 2] : vector<2xi8> 
    %4 = llvm.add %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_common_binop_demand_via_splat_mask_poison_2   : common_binop_demand_via_splat_mask_poison_2_before  ⊑  common_binop_demand_via_splat_mask_poison_2_combined := by
  unfold common_binop_demand_via_splat_mask_poison_2_before common_binop_demand_via_splat_mask_poison_2_combined
  simp_alive_peephole
  sorry
def common_binop_demand_via_splat_mask_poison_3_combined := [llvmfunc|
  llvm.func @common_binop_demand_via_splat_mask_poison_3(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.shufflevector %arg1, %0 [-1, 0] : vector<2xi8> 
    %2 = llvm.add %1, %arg0  : vector<2xi8>
    %3 = llvm.shufflevector %2, %0 [0, 0] : vector<2xi8> 
    %4 = llvm.add %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_common_binop_demand_via_splat_mask_poison_3   : common_binop_demand_via_splat_mask_poison_3_before  ⊑  common_binop_demand_via_splat_mask_poison_3_combined := by
  unfold common_binop_demand_via_splat_mask_poison_3_before common_binop_demand_via_splat_mask_poison_3_combined
  simp_alive_peephole
  sorry
