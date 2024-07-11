import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  inselt-binop-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def add_constant_before := [llvmfunc|
  llvm.func @add_constant(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.add %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def add_constant_not_undef_lane_before := [llvmfunc|
  llvm.func @add_constant_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.add %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def sub_constant_op0_before := [llvmfunc|
  llvm.func @sub_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-42 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.sub %8, %9 overflow<nsw, nuw>  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def sub_constant_op0_not_undef_lane_before := [llvmfunc|
  llvm.func @sub_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.sub %2, %3 overflow<nuw>  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def sub_constant_op1_before := [llvmfunc|
  llvm.func @sub_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.sub %9, %8 overflow<nuw>  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def sub_constant_op1_not_undef_lane_before := [llvmfunc|
  llvm.func @sub_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.sub %3, %2 overflow<nuw>  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def mul_constant_before := [llvmfunc|
  llvm.func @mul_constant(%arg0: i8) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(-42 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<3xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi8>
    %11 = llvm.insertelement %arg0, %0[%1 : i32] : vector<3xi8>
    %12 = llvm.mul %11, %10  : vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }]

def mul_constant_not_undef_lane_before := [llvmfunc|
  llvm.func @mul_constant_not_undef_lane(%arg0: i8) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(-42 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.constant(42 : i8) : i8
    %5 = llvm.mlir.undef : vector<3xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %2, %9[%10 : i32] : vector<3xi8>
    %12 = llvm.insertelement %arg0, %0[%1 : i32] : vector<3xi8>
    %13 = llvm.mul %12, %11  : vector<3xi8>
    llvm.return %13 : vector<3xi8>
  }]

def shl_constant_op0_before := [llvmfunc|
  llvm.func @shl_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.shl %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def shl_constant_op0_not_undef_lane_before := [llvmfunc|
  llvm.func @shl_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.shl %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def shl_constant_op1_before := [llvmfunc|
  llvm.func @shl_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.shl %9, %8 overflow<nuw>  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def shl_constant_op1_not_undef_lane_before := [llvmfunc|
  llvm.func @shl_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.shl %3, %2 overflow<nuw>  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def ashr_constant_op0_before := [llvmfunc|
  llvm.func @ashr_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.ashr %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def ashr_constant_op0_not_undef_lane_before := [llvmfunc|
  llvm.func @ashr_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.ashr %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def ashr_constant_op1_before := [llvmfunc|
  llvm.func @ashr_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.ashr %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def ashr_constant_op1_not_undef_lane_before := [llvmfunc|
  llvm.func @ashr_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.ashr %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def lshr_constant_op0_before := [llvmfunc|
  llvm.func @lshr_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.lshr %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def lshr_constant_op0_not_undef_lane_before := [llvmfunc|
  llvm.func @lshr_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.lshr %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def lshr_constant_op1_before := [llvmfunc|
  llvm.func @lshr_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.lshr %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def lshr_constant_op1_not_undef_lane_before := [llvmfunc|
  llvm.func @lshr_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.lshr %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def urem_constant_op0_before := [llvmfunc|
  llvm.func @urem_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.urem %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def urem_constant_op0_not_undef_lane_before := [llvmfunc|
  llvm.func @urem_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.urem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def urem_constant_op1_before := [llvmfunc|
  llvm.func @urem_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.urem %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def urem_constant_op1_not_undef_lane_before := [llvmfunc|
  llvm.func @urem_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.urem %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def srem_constant_op0_before := [llvmfunc|
  llvm.func @srem_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.srem %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def srem_constant_op0_not_undef_lane_before := [llvmfunc|
  llvm.func @srem_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.srem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def srem_constant_op1_before := [llvmfunc|
  llvm.func @srem_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.srem %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def srem_constant_op1_not_undef_lane_before := [llvmfunc|
  llvm.func @srem_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.srem %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def udiv_constant_op0_before := [llvmfunc|
  llvm.func @udiv_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.udiv %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def udiv_constant_op0_not_undef_lane_before := [llvmfunc|
  llvm.func @udiv_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.udiv %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def udiv_constant_op1_before := [llvmfunc|
  llvm.func @udiv_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.udiv %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def udiv_constant_op1_not_undef_lane_before := [llvmfunc|
  llvm.func @udiv_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.udiv %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def sdiv_constant_op0_before := [llvmfunc|
  llvm.func @sdiv_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.sdiv %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def sdiv_constant_op0_not_undef_lane_before := [llvmfunc|
  llvm.func @sdiv_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.sdiv %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def sdiv_constant_op1_before := [llvmfunc|
  llvm.func @sdiv_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.sdiv %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def sdiv_constant_op1_not_undef_lane_before := [llvmfunc|
  llvm.func @sdiv_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.sdiv %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def and_constant_before := [llvmfunc|
  llvm.func @and_constant(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.and %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def and_constant_not_undef_lane_before := [llvmfunc|
  llvm.func @and_constant_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.and %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def or_constant_before := [llvmfunc|
  llvm.func @or_constant(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-42 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.or %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def or_constant_not_undef_lane_before := [llvmfunc|
  llvm.func @or_constant_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.or %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def xor_constant_before := [llvmfunc|
  llvm.func @xor_constant(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %10 = llvm.xor %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def xor_constant_not_undef_lane_before := [llvmfunc|
  llvm.func @xor_constant_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi8>
    %4 = llvm.xor %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def fadd_constant_before := [llvmfunc|
  llvm.func @fadd_constant(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.fadd %9, %8  : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }]

def fadd_constant_not_undef_lane_before := [llvmfunc|
  llvm.func @fadd_constant_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.fadd %3, %2  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def fsub_constant_op0_before := [llvmfunc|
  llvm.func @fsub_constant_op0(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.fsub %8, %9  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    llvm.return %10 : vector<2xf32>
  }]

def fsub_constant_op0_not_undef_lane_before := [llvmfunc|
  llvm.func @fsub_constant_op0_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.fsub %2, %3  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>]

    llvm.return %4 : vector<2xf32>
  }]

def fsub_constant_op1_before := [llvmfunc|
  llvm.func @fsub_constant_op1(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.fsub %9, %8  : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }]

def fsub_constant_op1_not_undef_lane_before := [llvmfunc|
  llvm.func @fsub_constant_op1_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.fsub %3, %2  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def fmul_constant_before := [llvmfunc|
  llvm.func @fmul_constant(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.fmul %9, %8  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf32>]

    llvm.return %10 : vector<2xf32>
  }]

def fmul_constant_not_undef_lane_before := [llvmfunc|
  llvm.func @fmul_constant_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.fmul %3, %2  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def fdiv_constant_op0_before := [llvmfunc|
  llvm.func @fdiv_constant_op0(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.fdiv %8, %9  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

    llvm.return %10 : vector<2xf32>
  }]

def fdiv_constant_op0_not_undef_lane_before := [llvmfunc|
  llvm.func @fdiv_constant_op0_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.fdiv %2, %3  {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    llvm.return %4 : vector<2xf32>
  }]

def fdiv_constant_op1_before := [llvmfunc|
  llvm.func @fdiv_constant_op1(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.fdiv %9, %8  : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }]

def fdiv_constant_op1_not_undef_lane_before := [llvmfunc|
  llvm.func @fdiv_constant_op1_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.fdiv %3, %2  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def frem_constant_op0_before := [llvmfunc|
  llvm.func @frem_constant_op0(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.frem %8, %9  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    llvm.return %10 : vector<2xf32>
  }]

def frem_constant_op0_not_undef_lane_before := [llvmfunc|
  llvm.func @frem_constant_op0_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.frem %2, %3  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def frem_constant_op1_before := [llvmfunc|
  llvm.func @frem_constant_op1(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %10 = llvm.frem %9, %8  {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    llvm.return %10 : vector<2xf32>
  }]

def frem_constant_op1_not_undef_lane_before := [llvmfunc|
  llvm.func @frem_constant_op1_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf32>
    %4 = llvm.frem %3, %2  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

    llvm.return %4 : vector<2xf32>
  }]

def add_constant_combined := [llvmfunc|
  llvm.func @add_constant(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.add %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_add_constant   : add_constant_before  ⊑  add_constant_combined := by
  unfold add_constant_before add_constant_combined
  simp_alive_peephole
  sorry
def add_constant_not_undef_lane_combined := [llvmfunc|
  llvm.func @add_constant_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.add %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_add_constant_not_undef_lane   : add_constant_not_undef_lane_before  ⊑  add_constant_not_undef_lane_combined := by
  unfold add_constant_not_undef_lane_before add_constant_not_undef_lane_combined
  simp_alive_peephole
  sorry
def sub_constant_op0_combined := [llvmfunc|
  llvm.func @sub_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(-42 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.sub %8, %9 overflow<nsw, nuw>  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_sub_constant_op0   : sub_constant_op0_before  ⊑  sub_constant_op0_combined := by
  unfold sub_constant_op0_before sub_constant_op0_combined
  simp_alive_peephole
  sorry
def sub_constant_op0_not_undef_lane_combined := [llvmfunc|
  llvm.func @sub_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.sub %2, %3 overflow<nuw>  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_sub_constant_op0_not_undef_lane   : sub_constant_op0_not_undef_lane_before  ⊑  sub_constant_op0_not_undef_lane_combined := by
  unfold sub_constant_op0_not_undef_lane_before sub_constant_op0_not_undef_lane_combined
  simp_alive_peephole
  sorry
def sub_constant_op1_combined := [llvmfunc|
  llvm.func @sub_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(-42 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.add %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_sub_constant_op1   : sub_constant_op1_before  ⊑  sub_constant_op1_combined := by
  unfold sub_constant_op1_before sub_constant_op1_combined
  simp_alive_peephole
  sorry
def sub_constant_op1_not_undef_lane_combined := [llvmfunc|
  llvm.func @sub_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[-42, 42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.add %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_sub_constant_op1_not_undef_lane   : sub_constant_op1_not_undef_lane_before  ⊑  sub_constant_op1_not_undef_lane_combined := by
  unfold sub_constant_op1_not_undef_lane_before sub_constant_op1_not_undef_lane_combined
  simp_alive_peephole
  sorry
def mul_constant_combined := [llvmfunc|
  llvm.func @mul_constant(%arg0: i8) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(-42 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<3xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi8>
    %11 = llvm.insertelement %arg0, %0[%1 : i64] : vector<3xi8>
    %12 = llvm.mul %11, %10  : vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }]

theorem inst_combine_mul_constant   : mul_constant_before  ⊑  mul_constant_combined := by
  unfold mul_constant_before mul_constant_combined
  simp_alive_peephole
  sorry
def mul_constant_not_undef_lane_combined := [llvmfunc|
  llvm.func @mul_constant_not_undef_lane(%arg0: i8) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<3xi8>
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(-42 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.constant(42 : i8) : i8
    %5 = llvm.mlir.undef : vector<3xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %2, %9[%10 : i32] : vector<3xi8>
    %12 = llvm.insertelement %arg0, %0[%1 : i64] : vector<3xi8>
    %13 = llvm.mul %12, %11  : vector<3xi8>
    llvm.return %13 : vector<3xi8>
  }]

theorem inst_combine_mul_constant_not_undef_lane   : mul_constant_not_undef_lane_before  ⊑  mul_constant_not_undef_lane_combined := by
  unfold mul_constant_not_undef_lane_before mul_constant_not_undef_lane_combined
  simp_alive_peephole
  sorry
def shl_constant_op0_combined := [llvmfunc|
  llvm.func @shl_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.shl %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_shl_constant_op0   : shl_constant_op0_before  ⊑  shl_constant_op0_combined := by
  unfold shl_constant_op0_before shl_constant_op0_combined
  simp_alive_peephole
  sorry
def shl_constant_op0_not_undef_lane_combined := [llvmfunc|
  llvm.func @shl_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.shl %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_shl_constant_op0_not_undef_lane   : shl_constant_op0_not_undef_lane_before  ⊑  shl_constant_op0_not_undef_lane_combined := by
  unfold shl_constant_op0_not_undef_lane_before shl_constant_op0_not_undef_lane_combined
  simp_alive_peephole
  sorry
def shl_constant_op1_combined := [llvmfunc|
  llvm.func @shl_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.shl %9, %8 overflow<nuw>  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_shl_constant_op1   : shl_constant_op1_before  ⊑  shl_constant_op1_combined := by
  unfold shl_constant_op1_before shl_constant_op1_combined
  simp_alive_peephole
  sorry
def shl_constant_op1_not_undef_lane_combined := [llvmfunc|
  llvm.func @shl_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.shl %3, %2 overflow<nuw>  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_shl_constant_op1_not_undef_lane   : shl_constant_op1_not_undef_lane_before  ⊑  shl_constant_op1_not_undef_lane_combined := by
  unfold shl_constant_op1_not_undef_lane_before shl_constant_op1_not_undef_lane_combined
  simp_alive_peephole
  sorry
def ashr_constant_op0_combined := [llvmfunc|
  llvm.func @ashr_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.ashr %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_ashr_constant_op0   : ashr_constant_op0_before  ⊑  ashr_constant_op0_combined := by
  unfold ashr_constant_op0_before ashr_constant_op0_combined
  simp_alive_peephole
  sorry
def ashr_constant_op0_not_undef_lane_combined := [llvmfunc|
  llvm.func @ashr_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.lshr %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_ashr_constant_op0_not_undef_lane   : ashr_constant_op0_not_undef_lane_before  ⊑  ashr_constant_op0_not_undef_lane_combined := by
  unfold ashr_constant_op0_not_undef_lane_before ashr_constant_op0_not_undef_lane_combined
  simp_alive_peephole
  sorry
def ashr_constant_op1_combined := [llvmfunc|
  llvm.func @ashr_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.ashr %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_ashr_constant_op1   : ashr_constant_op1_before  ⊑  ashr_constant_op1_combined := by
  unfold ashr_constant_op1_before ashr_constant_op1_combined
  simp_alive_peephole
  sorry
def ashr_constant_op1_not_undef_lane_combined := [llvmfunc|
  llvm.func @ashr_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.ashr %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_ashr_constant_op1_not_undef_lane   : ashr_constant_op1_not_undef_lane_before  ⊑  ashr_constant_op1_not_undef_lane_combined := by
  unfold ashr_constant_op1_not_undef_lane_before ashr_constant_op1_not_undef_lane_combined
  simp_alive_peephole
  sorry
def lshr_constant_op0_combined := [llvmfunc|
  llvm.func @lshr_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.lshr %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_lshr_constant_op0   : lshr_constant_op0_before  ⊑  lshr_constant_op0_combined := by
  unfold lshr_constant_op0_before lshr_constant_op0_combined
  simp_alive_peephole
  sorry
def lshr_constant_op0_not_undef_lane_combined := [llvmfunc|
  llvm.func @lshr_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.lshr %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_lshr_constant_op0_not_undef_lane   : lshr_constant_op0_not_undef_lane_before  ⊑  lshr_constant_op0_not_undef_lane_combined := by
  unfold lshr_constant_op0_not_undef_lane_before lshr_constant_op0_not_undef_lane_combined
  simp_alive_peephole
  sorry
def lshr_constant_op1_combined := [llvmfunc|
  llvm.func @lshr_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.lshr %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_lshr_constant_op1   : lshr_constant_op1_before  ⊑  lshr_constant_op1_combined := by
  unfold lshr_constant_op1_before lshr_constant_op1_combined
  simp_alive_peephole
  sorry
def lshr_constant_op1_not_undef_lane_combined := [llvmfunc|
  llvm.func @lshr_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.lshr %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_lshr_constant_op1_not_undef_lane   : lshr_constant_op1_not_undef_lane_before  ⊑  lshr_constant_op1_not_undef_lane_combined := by
  unfold lshr_constant_op1_not_undef_lane_before lshr_constant_op1_not_undef_lane_combined
  simp_alive_peephole
  sorry
def urem_constant_op0_combined := [llvmfunc|
  llvm.func @urem_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.urem %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_urem_constant_op0   : urem_constant_op0_before  ⊑  urem_constant_op0_combined := by
  unfold urem_constant_op0_before urem_constant_op0_combined
  simp_alive_peephole
  sorry
def urem_constant_op0_not_undef_lane_combined := [llvmfunc|
  llvm.func @urem_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.urem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_urem_constant_op0_not_undef_lane   : urem_constant_op0_not_undef_lane_before  ⊑  urem_constant_op0_not_undef_lane_combined := by
  unfold urem_constant_op0_not_undef_lane_before urem_constant_op0_not_undef_lane_combined
  simp_alive_peephole
  sorry
def urem_constant_op1_combined := [llvmfunc|
  llvm.func @urem_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_urem_constant_op1   : urem_constant_op1_before  ⊑  urem_constant_op1_combined := by
  unfold urem_constant_op1_before urem_constant_op1_combined
  simp_alive_peephole
  sorry
def urem_constant_op1_not_undef_lane_combined := [llvmfunc|
  llvm.func @urem_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.urem %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_urem_constant_op1_not_undef_lane   : urem_constant_op1_not_undef_lane_before  ⊑  urem_constant_op1_not_undef_lane_combined := by
  unfold urem_constant_op1_not_undef_lane_before urem_constant_op1_not_undef_lane_combined
  simp_alive_peephole
  sorry
def srem_constant_op0_combined := [llvmfunc|
  llvm.func @srem_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.srem %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_srem_constant_op0   : srem_constant_op0_before  ⊑  srem_constant_op0_combined := by
  unfold srem_constant_op0_before srem_constant_op0_combined
  simp_alive_peephole
  sorry
def srem_constant_op0_not_undef_lane_combined := [llvmfunc|
  llvm.func @srem_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.srem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_srem_constant_op0_not_undef_lane   : srem_constant_op0_not_undef_lane_before  ⊑  srem_constant_op0_not_undef_lane_combined := by
  unfold srem_constant_op0_not_undef_lane_before srem_constant_op0_not_undef_lane_combined
  simp_alive_peephole
  sorry
def srem_constant_op1_combined := [llvmfunc|
  llvm.func @srem_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_srem_constant_op1   : srem_constant_op1_before  ⊑  srem_constant_op1_combined := by
  unfold srem_constant_op1_before srem_constant_op1_combined
  simp_alive_peephole
  sorry
def srem_constant_op1_not_undef_lane_combined := [llvmfunc|
  llvm.func @srem_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.srem %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_srem_constant_op1_not_undef_lane   : srem_constant_op1_not_undef_lane_before  ⊑  srem_constant_op1_not_undef_lane_combined := by
  unfold srem_constant_op1_not_undef_lane_before srem_constant_op1_not_undef_lane_combined
  simp_alive_peephole
  sorry
def udiv_constant_op0_combined := [llvmfunc|
  llvm.func @udiv_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.udiv %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_udiv_constant_op0   : udiv_constant_op0_before  ⊑  udiv_constant_op0_combined := by
  unfold udiv_constant_op0_before udiv_constant_op0_combined
  simp_alive_peephole
  sorry
def udiv_constant_op0_not_undef_lane_combined := [llvmfunc|
  llvm.func @udiv_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.udiv %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_udiv_constant_op0_not_undef_lane   : udiv_constant_op0_not_undef_lane_before  ⊑  udiv_constant_op0_not_undef_lane_combined := by
  unfold udiv_constant_op0_not_undef_lane_before udiv_constant_op0_not_undef_lane_combined
  simp_alive_peephole
  sorry
def udiv_constant_op1_combined := [llvmfunc|
  llvm.func @udiv_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_udiv_constant_op1   : udiv_constant_op1_before  ⊑  udiv_constant_op1_combined := by
  unfold udiv_constant_op1_before udiv_constant_op1_combined
  simp_alive_peephole
  sorry
def udiv_constant_op1_not_undef_lane_combined := [llvmfunc|
  llvm.func @udiv_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.udiv %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_udiv_constant_op1_not_undef_lane   : udiv_constant_op1_not_undef_lane_before  ⊑  udiv_constant_op1_not_undef_lane_combined := by
  unfold udiv_constant_op1_not_undef_lane_before udiv_constant_op1_not_undef_lane_combined
  simp_alive_peephole
  sorry
def sdiv_constant_op0_combined := [llvmfunc|
  llvm.func @sdiv_constant_op0(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(5 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.sdiv %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_sdiv_constant_op0   : sdiv_constant_op0_before  ⊑  sdiv_constant_op0_combined := by
  unfold sdiv_constant_op0_before sdiv_constant_op0_combined
  simp_alive_peephole
  sorry
def sdiv_constant_op0_not_undef_lane_combined := [llvmfunc|
  llvm.func @sdiv_constant_op0_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.sdiv %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_sdiv_constant_op0_not_undef_lane   : sdiv_constant_op0_not_undef_lane_before  ⊑  sdiv_constant_op0_not_undef_lane_combined := by
  unfold sdiv_constant_op0_not_undef_lane_before sdiv_constant_op0_not_undef_lane_combined
  simp_alive_peephole
  sorry
def sdiv_constant_op1_combined := [llvmfunc|
  llvm.func @sdiv_constant_op1(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_sdiv_constant_op1   : sdiv_constant_op1_before  ⊑  sdiv_constant_op1_combined := by
  unfold sdiv_constant_op1_before sdiv_constant_op1_combined
  simp_alive_peephole
  sorry
def sdiv_constant_op1_not_undef_lane_combined := [llvmfunc|
  llvm.func @sdiv_constant_op1_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[5, 2]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.sdiv %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_sdiv_constant_op1_not_undef_lane   : sdiv_constant_op1_not_undef_lane_before  ⊑  sdiv_constant_op1_not_undef_lane_combined := by
  unfold sdiv_constant_op1_not_undef_lane_before sdiv_constant_op1_not_undef_lane_combined
  simp_alive_peephole
  sorry
def and_constant_combined := [llvmfunc|
  llvm.func @and_constant(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.and %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_and_constant   : and_constant_before  ⊑  and_constant_combined := by
  unfold and_constant_before and_constant_combined
  simp_alive_peephole
  sorry
def and_constant_not_undef_lane_combined := [llvmfunc|
  llvm.func @and_constant_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.and %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_and_constant_not_undef_lane   : and_constant_not_undef_lane_before  ⊑  and_constant_not_undef_lane_combined := by
  unfold and_constant_not_undef_lane_before and_constant_not_undef_lane_combined
  simp_alive_peephole
  sorry
def or_constant_combined := [llvmfunc|
  llvm.func @or_constant(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(-42 : i8) : i8
    %3 = llvm.mlir.undef : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.or %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_or_constant   : or_constant_before  ⊑  or_constant_combined := by
  unfold or_constant_before or_constant_combined
  simp_alive_peephole
  sorry
def or_constant_not_undef_lane_combined := [llvmfunc|
  llvm.func @or_constant_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.or %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_or_constant_not_undef_lane   : or_constant_not_undef_lane_before  ⊑  or_constant_not_undef_lane_combined := by
  unfold or_constant_not_undef_lane_before or_constant_not_undef_lane_combined
  simp_alive_peephole
  sorry
def xor_constant_combined := [llvmfunc|
  llvm.func @xor_constant(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    %4 = llvm.mlir.undef : vector<2xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi8>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %10 = llvm.xor %9, %8  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_xor_constant   : xor_constant_before  ⊑  xor_constant_combined := by
  unfold xor_constant_before xor_constant_combined
  simp_alive_peephole
  sorry
def xor_constant_not_undef_lane_combined := [llvmfunc|
  llvm.func @xor_constant_not_undef_lane(%arg0: i8) -> vector<2xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %4 = llvm.xor %3, %2  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_xor_constant_not_undef_lane   : xor_constant_not_undef_lane_before  ⊑  xor_constant_not_undef_lane_combined := by
  unfold xor_constant_not_undef_lane_before xor_constant_not_undef_lane_combined
  simp_alive_peephole
  sorry
def fadd_constant_combined := [llvmfunc|
  llvm.func @fadd_constant(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %10 = llvm.fadd %9, %8  : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }]

theorem inst_combine_fadd_constant   : fadd_constant_before  ⊑  fadd_constant_combined := by
  unfold fadd_constant_before fadd_constant_combined
  simp_alive_peephole
  sorry
def fadd_constant_not_undef_lane_combined := [llvmfunc|
  llvm.func @fadd_constant_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %4 = llvm.fadd %3, %2  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_fadd_constant_not_undef_lane   : fadd_constant_not_undef_lane_before  ⊑  fadd_constant_not_undef_lane_combined := by
  unfold fadd_constant_not_undef_lane_before fadd_constant_not_undef_lane_combined
  simp_alive_peephole
  sorry
def fsub_constant_op0_combined := [llvmfunc|
  llvm.func @fsub_constant_op0(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %10 = llvm.fsub %8, %9  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }]

theorem inst_combine_fsub_constant_op0   : fsub_constant_op0_before  ⊑  fsub_constant_op0_combined := by
  unfold fsub_constant_op0_before fsub_constant_op0_combined
  simp_alive_peephole
  sorry
def fsub_constant_op0_not_undef_lane_combined := [llvmfunc|
  llvm.func @fsub_constant_op0_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %4 = llvm.fsub %2, %3  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_fsub_constant_op0_not_undef_lane   : fsub_constant_op0_not_undef_lane_before  ⊑  fsub_constant_op0_not_undef_lane_combined := by
  unfold fsub_constant_op0_not_undef_lane_before fsub_constant_op0_not_undef_lane_combined
  simp_alive_peephole
  sorry
def fsub_constant_op1_combined := [llvmfunc|
  llvm.func @fsub_constant_op1(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %10 = llvm.fadd %9, %8  : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }]

theorem inst_combine_fsub_constant_op1   : fsub_constant_op1_before  ⊑  fsub_constant_op1_combined := by
  unfold fsub_constant_op1_before fsub_constant_op1_combined
  simp_alive_peephole
  sorry
def fsub_constant_op1_not_undef_lane_combined := [llvmfunc|
  llvm.func @fsub_constant_op1_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[-4.200000e+01, 4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %4 = llvm.fadd %3, %2  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_fsub_constant_op1_not_undef_lane   : fsub_constant_op1_not_undef_lane_before  ⊑  fsub_constant_op1_not_undef_lane_combined := by
  unfold fsub_constant_op1_not_undef_lane_before fsub_constant_op1_not_undef_lane_combined
  simp_alive_peephole
  sorry
def fmul_constant_combined := [llvmfunc|
  llvm.func @fmul_constant(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %10 = llvm.fmul %9, %8  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }]

theorem inst_combine_fmul_constant   : fmul_constant_before  ⊑  fmul_constant_combined := by
  unfold fmul_constant_before fmul_constant_combined
  simp_alive_peephole
  sorry
def fmul_constant_not_undef_lane_combined := [llvmfunc|
  llvm.func @fmul_constant_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %4 = llvm.fmul %3, %2  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_fmul_constant_not_undef_lane   : fmul_constant_not_undef_lane_before  ⊑  fmul_constant_not_undef_lane_combined := by
  unfold fmul_constant_not_undef_lane_before fmul_constant_not_undef_lane_combined
  simp_alive_peephole
  sorry
def fdiv_constant_op0_combined := [llvmfunc|
  llvm.func @fdiv_constant_op0(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %10 = llvm.fdiv %8, %9  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }]

theorem inst_combine_fdiv_constant_op0   : fdiv_constant_op0_before  ⊑  fdiv_constant_op0_combined := by
  unfold fdiv_constant_op0_before fdiv_constant_op0_combined
  simp_alive_peephole
  sorry
def fdiv_constant_op0_not_undef_lane_combined := [llvmfunc|
  llvm.func @fdiv_constant_op0_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %4 = llvm.fdiv %2, %3  {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_fdiv_constant_op0_not_undef_lane   : fdiv_constant_op0_not_undef_lane_before  ⊑  fdiv_constant_op0_not_undef_lane_combined := by
  unfold fdiv_constant_op0_not_undef_lane_before fdiv_constant_op0_not_undef_lane_combined
  simp_alive_peephole
  sorry
def fdiv_constant_op1_combined := [llvmfunc|
  llvm.func @fdiv_constant_op1(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %10 = llvm.fdiv %9, %8  : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }]

theorem inst_combine_fdiv_constant_op1   : fdiv_constant_op1_before  ⊑  fdiv_constant_op1_combined := by
  unfold fdiv_constant_op1_before fdiv_constant_op1_combined
  simp_alive_peephole
  sorry
def fdiv_constant_op1_not_undef_lane_combined := [llvmfunc|
  llvm.func @fdiv_constant_op1_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %4 = llvm.fdiv %3, %2  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_fdiv_constant_op1_not_undef_lane   : fdiv_constant_op1_not_undef_lane_before  ⊑  fdiv_constant_op1_not_undef_lane_combined := by
  unfold fdiv_constant_op1_not_undef_lane_before fdiv_constant_op1_not_undef_lane_combined
  simp_alive_peephole
  sorry
def frem_constant_op0_combined := [llvmfunc|
  llvm.func @frem_constant_op0(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %10 = llvm.frem %8, %9  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }]

theorem inst_combine_frem_constant_op0   : frem_constant_op0_before  ⊑  frem_constant_op0_combined := by
  unfold frem_constant_op0_before frem_constant_op0_combined
  simp_alive_peephole
  sorry
def frem_constant_op0_not_undef_lane_combined := [llvmfunc|
  llvm.func @frem_constant_op0_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %4 = llvm.frem %2, %3  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_frem_constant_op0_not_undef_lane   : frem_constant_op0_not_undef_lane_before  ⊑  frem_constant_op0_not_undef_lane_combined := by
  unfold frem_constant_op0_not_undef_lane_before frem_constant_op0_not_undef_lane_combined
  simp_alive_peephole
  sorry
def frem_constant_op1_combined := [llvmfunc|
  llvm.func @frem_constant_op1(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<2xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xf32>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %10 = llvm.frem %9, %8  {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }]

theorem inst_combine_frem_constant_op1   : frem_constant_op1_before  ⊑  frem_constant_op1_combined := by
  unfold frem_constant_op1_before frem_constant_op1_combined
  simp_alive_peephole
  sorry
def frem_constant_op1_not_undef_lane_combined := [llvmfunc|
  llvm.func @frem_constant_op1_not_undef_lane(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf32>
    %4 = llvm.frem %3, %2  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_frem_constant_op1_not_undef_lane   : frem_constant_op1_not_undef_lane_before  ⊑  frem_constant_op1_not_undef_lane_combined := by
  unfold frem_constant_op1_not_undef_lane_before frem_constant_op1_not_undef_lane_combined
  simp_alive_peephole
  sorry
