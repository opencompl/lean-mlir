import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sub-of-negatible
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def t3_before := [llvmfunc|
  llvm.func @t3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.shl %1, %arg1  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def n3_before := [llvmfunc|
  llvm.func @n3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.shl %1, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def t4_before := [llvmfunc|
  llvm.func @t4(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(44 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def select_of_constants_multi_use_before := [llvmfunc|
  llvm.func @select_of_constants_multi_use(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %2, %3  : i8
    llvm.return %4 : i8
  }]

def PR52261_before := [llvmfunc|
  llvm.func @PR52261(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.sub %2, %3 overflow<nsw>  : i32
    %5 = llvm.and %3, %4  : i32
    llvm.return %5 : i32
  }]

def n4_before := [llvmfunc|
  llvm.func @n4(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(44 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def n5_before := [llvmfunc|
  llvm.func @n5(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.select %arg1, %0, %arg2 : i1, i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def t6_before := [llvmfunc|
  llvm.func @t6(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-42 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def t7_before := [llvmfunc|
  llvm.func @t7(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def n8_before := [llvmfunc|
  llvm.func @n8(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def t9_before := [llvmfunc|
  llvm.func @t9(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg1, %arg0  : i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def n10_before := [llvmfunc|
  llvm.func @n10(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg1, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def neg_of_sub_from_constant_before := [llvmfunc|
  llvm.func @neg_of_sub_from_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def neg_of_sub_from_constant_multi_use_before := [llvmfunc|
  llvm.func @neg_of_sub_from_constant_multi_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def sub_from_constant_of_sub_from_constant_before := [llvmfunc|
  llvm.func @sub_from_constant_of_sub_from_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def sub_from_constant_of_sub_from_constant_multi_use_before := [llvmfunc|
  llvm.func @sub_from_constant_of_sub_from_constant_multi_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def sub_from_variable_of_sub_from_constant_before := [llvmfunc|
  llvm.func @sub_from_variable_of_sub_from_constant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }]

def sub_from_variable_of_sub_from_constant_multi_use_before := [llvmfunc|
  llvm.func @sub_from_variable_of_sub_from_constant_multi_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }]

def t12_before := [llvmfunc|
  llvm.func @t12(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %1, %2  : i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def n13_before := [llvmfunc|
  llvm.func @n13(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %1, %arg2  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def n14_before := [llvmfunc|
  llvm.func @n14(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %1, %2  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def neg_of_add_with_constant_before := [llvmfunc|
  llvm.func @neg_of_add_with_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def neg_of_add_with_constant_multi_use_before := [llvmfunc|
  llvm.func @neg_of_add_with_constant_multi_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def sub_from_constant_of_add_with_constant_before := [llvmfunc|
  llvm.func @sub_from_constant_of_add_with_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def sub_from_constant_of_add_with_constant_multi_use_before := [llvmfunc|
  llvm.func @sub_from_constant_of_add_with_constant_multi_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def sub_from_variable_of_add_with_constant_before := [llvmfunc|
  llvm.func @sub_from_variable_of_add_with_constant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }]

def sub_from_variable_of_add_with_constant_multi_use_before := [llvmfunc|
  llvm.func @sub_from_variable_of_add_with_constant_multi_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }]

def t15_before := [llvmfunc|
  llvm.func @t15(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.mul %1, %arg2  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def n16_before := [llvmfunc|
  llvm.func @n16(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.mul %1, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def t16_before := [llvmfunc|
  llvm.func @t16(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %1, %arg1  : i8
    llvm.br ^bb3(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i8)
  ^bb3(%3: i8):  // 2 preds: ^bb1, ^bb2
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }]

def n17_before := [llvmfunc|
  llvm.func @n17(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %1, %arg1  : i8
    llvm.br ^bb3(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i8)
  ^bb3(%3: i8):  // 2 preds: ^bb1, ^bb2
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }]

def n19_before := [llvmfunc|
  llvm.func @n19(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.sub %0, %arg1  : i8
    llvm.br ^bb3(%1 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : i8)
  ^bb3(%2: i8):  // 2 preds: ^bb1, ^bb2
    %3 = llvm.sub %0, %2  : i8
    llvm.return %3 : i8
  }]

def phi_with_duplicate_incoming_basic_blocks_before := [llvmfunc|
  llvm.func @phi_with_duplicate_incoming_basic_blocks(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(84 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    llvm.cond_br %arg2, ^bb1(%arg1 : i32), ^bb2(%1 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
    llvm.switch %4 : i32, ^bb3 [
      0: ^bb2(%3 : i32),
      42: ^bb2(%3 : i32)
    ]
  ^bb2(%5: i32):  // 3 preds: ^bb0, ^bb1, ^bb1
    %6 = llvm.sub %2, %5  : i32
    %7 = llvm.call @use32gen1(%6) : (i32) -> i1
    llvm.cond_br %7, ^bb1(%6 : i32), ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return
  }]

def t20_before := [llvmfunc|
  llvm.func @t20(%arg0: i8, %arg1: i16) -> i8 {
    %0 = llvm.mlir.constant(-42 : i16) : i16
    %1 = llvm.shl %0, %arg1  : i16
    %2 = llvm.trunc %1 : i16 to i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def n21_before := [llvmfunc|
  llvm.func @n21(%arg0: i8, %arg1: i16) -> i8 {
    %0 = llvm.mlir.constant(-42 : i16) : i16
    %1 = llvm.shl %0, %arg1  : i16
    %2 = llvm.trunc %1 : i16 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def negate_xor_before := [llvmfunc|
  llvm.func @negate_xor(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.sub %1, %2  : i4
    llvm.return %3 : i4
  }]

def negate_xor_vec_before := [llvmfunc|
  llvm.func @negate_xor_vec(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.mlir.constant(dense<[5, -6]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i4) : i4
    %4 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.xor %arg0, %2  : vector<2xi4>
    %6 = llvm.sub %4, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def negate_xor_use_before := [llvmfunc|
  llvm.func @negate_xor_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def negate_shl_xor_before := [llvmfunc|
  llvm.func @negate_shl_xor(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.shl %2, %arg1  : i4
    %4 = llvm.sub %1, %3  : i4
    llvm.return %4 : i4
  }]

def negate_shl_not_uses_before := [llvmfunc|
  llvm.func @negate_shl_not_uses(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %2, %arg1  : i8
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }]

def negate_mul_not_uses_vec_before := [llvmfunc|
  llvm.func @negate_mul_not_uses_vec(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(0 : i4) : i4
    %3 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.xor %arg0, %1  : vector<2xi4>
    llvm.call @use_v2i4(%4) : (vector<2xi4>) -> ()
    %5 = llvm.mul %4, %arg1  : vector<2xi4>
    %6 = llvm.sub %3, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def negate_sdiv_before := [llvmfunc|
  llvm.func @negate_sdiv(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def negate_sdiv_extrause_before := [llvmfunc|
  llvm.func @negate_sdiv_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def negate_sdiv_extrause2_before := [llvmfunc|
  llvm.func @negate_sdiv_extrause2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.sdiv %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def negate_ashr_before := [llvmfunc|
  llvm.func @negate_ashr(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def negate_lshr_before := [llvmfunc|
  llvm.func @negate_lshr(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def negate_ashr_extrause_before := [llvmfunc|
  llvm.func @negate_ashr_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def negate_lshr_extrause_before := [llvmfunc|
  llvm.func @negate_lshr_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def negate_ashr_wrongshift_before := [llvmfunc|
  llvm.func @negate_ashr_wrongshift(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def negate_lshr_wrongshift_before := [llvmfunc|
  llvm.func @negate_lshr_wrongshift(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def negate_sext_before := [llvmfunc|
  llvm.func @negate_sext(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def negate_zext_before := [llvmfunc|
  llvm.func @negate_zext(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.zext %arg1 : i1 to i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def negate_sext_extrause_before := [llvmfunc|
  llvm.func @negate_sext_extrause(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def negate_zext_extrause_before := [llvmfunc|
  llvm.func @negate_zext_extrause(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.zext %arg1 : i1 to i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def negate_sext_wrongwidth_before := [llvmfunc|
  llvm.func @negate_sext_wrongwidth(%arg0: i8, %arg1: i2) -> i8 {
    %0 = llvm.sext %arg1 : i2 to i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def negate_zext_wrongwidth_before := [llvmfunc|
  llvm.func @negate_zext_wrongwidth(%arg0: i8, %arg1: i2) -> i8 {
    %0 = llvm.zext %arg1 : i2 to i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

def negate_shufflevector_oneinput_reverse_before := [llvmfunc|
  llvm.func @negate_shufflevector_oneinput_reverse(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-6, 5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.undef : vector<2xi4>
    %4 = llvm.shl %2, %arg0  : vector<2xi4>
    %5 = llvm.shufflevector %4, %3 [1, 0] : vector<2xi4> 
    %6 = llvm.sub %arg1, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def negate_shufflevector_oneinput_second_lane_is_undef_before := [llvmfunc|
  llvm.func @negate_shufflevector_oneinput_second_lane_is_undef(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-6, 5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.undef : vector<2xi4>
    %4 = llvm.shl %2, %arg0  : vector<2xi4>
    %5 = llvm.shufflevector %4, %3 [0, 2] : vector<2xi4> 
    %6 = llvm.sub %arg1, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def negate_shufflevector_twoinputs_before := [llvmfunc|
  llvm.func @negate_shufflevector_twoinputs(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-6, 5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(-1 : i4) : i4
    %4 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.shl %2, %arg0  : vector<2xi4>
    %6 = llvm.xor %arg1, %4  : vector<2xi4>
    %7 = llvm.shufflevector %5, %6 [0, 3] : vector<2xi4> 
    %8 = llvm.sub %arg2, %7  : vector<2xi4>
    llvm.return %8 : vector<2xi4>
  }]

def negate_shufflevector_oneinput_extrause_before := [llvmfunc|
  llvm.func @negate_shufflevector_oneinput_extrause(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-6, 5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.undef : vector<2xi4>
    %4 = llvm.shl %2, %arg0  : vector<2xi4>
    %5 = llvm.shufflevector %4, %3 [1, 0] : vector<2xi4> 
    llvm.call @use_v2i4(%5) : (vector<2xi4>) -> ()
    %6 = llvm.sub %arg1, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def negation_of_zeroext_of_nonnegative_before := [llvmfunc|
  llvm.func @negation_of_zeroext_of_nonnegative(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "sge" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.zext %2 : i8 to i16
    %5 = llvm.sub %1, %4  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }]

def negation_of_zeroext_of_positive_before := [llvmfunc|
  llvm.func @negation_of_zeroext_of_positive(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.zext %2 : i8 to i16
    %5 = llvm.sub %1, %4  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }]

def negation_of_signext_of_negative_before := [llvmfunc|
  llvm.func @negation_of_signext_of_negative(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.sext %2 : i8 to i16
    %5 = llvm.sub %1, %4  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }]

def negation_of_signext_of_nonpositive_before := [llvmfunc|
  llvm.func @negation_of_signext_of_nonpositive(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "sle" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.sext %2 : i8 to i16
    %5 = llvm.sub %1, %4  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }]

def negation_of_signext_of_nonnegative__wrong_cast_before := [llvmfunc|
  llvm.func @negation_of_signext_of_nonnegative__wrong_cast(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "sge" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.sext %2 : i8 to i16
    %5 = llvm.sub %1, %4  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }]

def negation_of_zeroext_of_negative_wrongcast_before := [llvmfunc|
  llvm.func @negation_of_zeroext_of_negative_wrongcast(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.zext %2 : i8 to i16
    %5 = llvm.sub %1, %4  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }]

def negation_of_increment_via_or_with_no_common_bits_set_before := [llvmfunc|
  llvm.func @negation_of_increment_via_or_with_no_common_bits_set(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg1, %0  : i8
    %2 = llvm.or %1, %0  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def negation_of_increment_via_or_with_no_common_bits_set_extrause_before := [llvmfunc|
  llvm.func @negation_of_increment_via_or_with_no_common_bits_set_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg1, %0  : i8
    %2 = llvm.or %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def negation_of_increment_via_or_common_bits_set_before := [llvmfunc|
  llvm.func @negation_of_increment_via_or_common_bits_set(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.shl %arg1, %0  : i8
    %3 = llvm.or %2, %1  : i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def negation_of_increment_via_or_disjoint_before := [llvmfunc|
  llvm.func @negation_of_increment_via_or_disjoint(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.or %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def add_via_or_with_no_common_bits_set_before := [llvmfunc|
  llvm.func @add_via_or_with_no_common_bits_set(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    %6 = llvm.sub %arg0, %5  : i8
    llvm.return %6 : i8
  }]

def add_via_or_with_common_bit_maybe_set_before := [llvmfunc|
  llvm.func @add_via_or_with_common_bit_maybe_set(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(4 : i8) : i8
    %3 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    %6 = llvm.sub %arg0, %5  : i8
    llvm.return %6 : i8
  }]

def add_via_or_with_no_common_bits_set_extrause_before := [llvmfunc|
  llvm.func @add_via_or_with_no_common_bits_set_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.call @use8(%5) : (i8) -> ()
    %6 = llvm.sub %arg0, %5  : i8
    llvm.return %6 : i8
  }]

def negate_extractelement_before := [llvmfunc|
  llvm.func @negate_extractelement(%arg0: vector<2xi4>, %arg1: i32, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    llvm.call @use_v2i4(%2) : (vector<2xi4>) -> ()
    %3 = llvm.extractelement %2[%arg1 : i32] : vector<2xi4>
    %4 = llvm.sub %arg2, %3  : i4
    llvm.return %4 : i4
  }]

def negate_extractelement_extrause_before := [llvmfunc|
  llvm.func @negate_extractelement_extrause(%arg0: vector<2xi4>, %arg1: i32, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    llvm.call @use_v2i4(%2) : (vector<2xi4>) -> ()
    %3 = llvm.extractelement %2[%arg1 : i32] : vector<2xi4>
    llvm.call @use4(%3) : (i4) -> ()
    %4 = llvm.sub %arg2, %3  : i4
    llvm.return %4 : i4
  }]

def negate_insertelement_before := [llvmfunc|
  llvm.func @negate_insertelement(%arg0: vector<2xi4>, %arg1: i4, %arg2: i32, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    %3 = llvm.sub %0, %arg1  : i4
    %4 = llvm.insertelement %3, %2[%arg2 : i32] : vector<2xi4>
    %5 = llvm.sub %arg3, %4  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def negate_insertelement_extrause_before := [llvmfunc|
  llvm.func @negate_insertelement_extrause(%arg0: vector<2xi4>, %arg1: i4, %arg2: i32, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    %3 = llvm.sub %0, %arg1  : i4
    %4 = llvm.insertelement %3, %2[%arg2 : i32] : vector<2xi4>
    llvm.call @use_v2i4(%4) : (vector<2xi4>) -> ()
    %5 = llvm.sub %arg3, %4  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

def negate_insertelement_nonnegatible_base_before := [llvmfunc|
  llvm.func @negate_insertelement_nonnegatible_base(%arg0: vector<2xi4>, %arg1: i4, %arg2: i32, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.sub %0, %arg1  : i4
    %2 = llvm.insertelement %1, %arg0[%arg2 : i32] : vector<2xi4>
    %3 = llvm.sub %arg3, %2  : vector<2xi4>
    llvm.return %3 : vector<2xi4>
  }]

def negate_insertelement_nonnegatible_insert_before := [llvmfunc|
  llvm.func @negate_insertelement_nonnegatible_insert(%arg0: vector<2xi4>, %arg1: i4, %arg2: i32, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    %3 = llvm.insertelement %arg1, %2[%arg2 : i32] : vector<2xi4>
    %4 = llvm.sub %arg3, %3  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

def negate_left_shift_by_constant_prefer_keeping_shl_before := [llvmfunc|
  llvm.func @negate_left_shift_by_constant_prefer_keeping_shl(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def negate_left_shift_by_constant_prefer_keeping_shl_extrause_before := [llvmfunc|
  llvm.func @negate_left_shift_by_constant_prefer_keeping_shl_extrause(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }]

def negate_left_shift_by_constant_before := [llvmfunc|
  llvm.func @negate_left_shift_by_constant(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.sub %arg3, %arg2  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.shl %1, %0  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def negate_left_shift_by_constant_extrause_before := [llvmfunc|
  llvm.func @negate_left_shift_by_constant_extrause(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.sub %arg3, %arg2  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.shl %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def negate_add_with_single_negatible_operand_before := [llvmfunc|
  llvm.func @negate_add_with_single_negatible_operand(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def negate_add_with_single_negatible_operand_depth2_before := [llvmfunc|
  llvm.func @negate_add_with_single_negatible_operand_depth2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(21 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.mul %2, %arg1  : i8
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }]

def negate_add_with_single_negatible_operand_extrause_before := [llvmfunc|
  llvm.func @negate_add_with_single_negatible_operand_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

def negate_add_with_single_negatible_operand_non_negation_before := [llvmfunc|
  llvm.func @negate_add_with_single_negatible_operand_non_negation(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }]

def negate_abs_before := [llvmfunc|
  llvm.func @negate_abs(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg0 : i1, i8
    %4 = llvm.sub %arg1, %3  : i8
    llvm.return %4 : i8
  }]

def negate_nabs_before := [llvmfunc|
  llvm.func @negate_nabs(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %1 : i1, i8
    %4 = llvm.sub %arg1, %3  : i8
    llvm.return %4 : i8
  }]

def negate_select_of_op_vs_negated_op_before := [llvmfunc|
  llvm.func @negate_select_of_op_vs_negated_op(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.select %arg2, %1, %arg0 : i1, i8
    %3 = llvm.sub %arg1, %2  : i8
    llvm.return %3 : i8
  }]

def dont_negate_ordinary_select_before := [llvmfunc|
  llvm.func @dont_negate_ordinary_select(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i8 {
    %0 = llvm.select %arg3, %arg0, %arg1 : i1, i8
    %1 = llvm.sub %arg2, %0  : i8
    llvm.return %1 : i8
  }]

def negate_select_of_negation_poison_before := [llvmfunc|
  llvm.func @negate_select_of_negation_poison(%arg0: vector<2xi1>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.sub %6, %arg1  : vector<2xi32>
    %9 = llvm.select %arg0, %8, %arg1 : vector<2xi1>, vector<2xi32>
    %10 = llvm.sub %7, %9  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def negate_freeze_before := [llvmfunc|
  llvm.func @negate_freeze(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.sub %arg0, %arg1  : i4
    %1 = llvm.freeze %0 : i4
    %2 = llvm.sub %arg2, %1  : i4
    llvm.return %2 : i4
  }]

def negate_freeze_extrause_before := [llvmfunc|
  llvm.func @negate_freeze_extrause(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.sub %arg0, %arg1  : i4
    %1 = llvm.freeze %0 : i4
    llvm.call @use4(%1) : (i4) -> ()
    %2 = llvm.sub %arg2, %1  : i4
    llvm.return %2 : i4
  }]

def noncanonical_mul_with_constant_as_first_operand_before := [llvmfunc|
  llvm.func @noncanonical_mul_with_constant_as_first_operand() {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.mul %1, %4 overflow<nsw>  : i16
    %6 = llvm.sext %5 : i16 to i32
    %7 = llvm.sub %2, %6 overflow<nsw>  : i32
    llvm.br ^bb1(%7 : i32)
  }]

def PR56601_before := [llvmfunc|
  llvm.func @PR56601(%arg0: vector<1xi64>, %arg1: vector<1xi64>) -> vector<1xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<1xi64>) : vector<1xi64>
    %1 = llvm.mlir.constant(dense<12> : vector<1xi64>) : vector<1xi64>
    %2 = llvm.mlir.constant(-4 : i64) : i64
    %3 = llvm.mlir.addressof @g : !llvm.ptr
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.add %4, %2  : i64
    %6 = llvm.mlir.undef : vector<1xi64>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<1xi64>
    %9 = llvm.mlir.constant(-3 : i64) : i64
    %10 = llvm.add %4, %9  : i64
    %11 = llvm.mlir.undef : vector<1xi64>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<1xi64>
    %14 = llvm.mul %arg0, %0 overflow<nsw>  : vector<1xi64>
    %15 = llvm.mul %arg1, %1 overflow<nsw>  : vector<1xi64>
    %16 = llvm.add %14, %8  : vector<1xi64>
    %17 = llvm.add %15, %13  : vector<1xi64>
    %18 = llvm.sub %16, %17  : vector<1xi64>
    llvm.return %18 : vector<1xi64>
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.add %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
def t3_combined := [llvmfunc|
  llvm.func @t3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.shl %arg2, %arg1  : i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t3   : t3_before  ⊑  t3_combined := by
  unfold t3_before t3_combined
  simp_alive_peephole
  sorry
def n3_combined := [llvmfunc|
  llvm.func @n3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.shl %1, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n3   : n3_before  ⊑  n3_combined := by
  unfold n3_before n3_combined
  simp_alive_peephole
  sorry
def t4_combined := [llvmfunc|
  llvm.func @t4(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-44 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t4   : t4_before  ⊑  t4_combined := by
  unfold t4_before t4_combined
  simp_alive_peephole
  sorry
def select_of_constants_multi_use_combined := [llvmfunc|
  llvm.func @select_of_constants_multi_use(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.constant(-2 : i8) : i8
    %4 = llvm.select %arg0, %0, %1 : i1, i8
    %5 = llvm.select %arg0, %2, %3 : i1, i8
    llvm.call @use8(%5) : (i8) -> ()
    llvm.return %4 : i8
  }]

theorem inst_combine_select_of_constants_multi_use   : select_of_constants_multi_use_before  ⊑  select_of_constants_multi_use_combined := by
  unfold select_of_constants_multi_use_before select_of_constants_multi_use_combined
  simp_alive_peephole
  sorry
def PR52261_combined := [llvmfunc|
  llvm.func @PR52261(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_PR52261   : PR52261_before  ⊑  PR52261_combined := by
  unfold PR52261_before PR52261_combined
  simp_alive_peephole
  sorry
def n4_combined := [llvmfunc|
  llvm.func @n4(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(44 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n4   : n4_before  ⊑  n4_combined := by
  unfold n4_before n4_combined
  simp_alive_peephole
  sorry
def n5_combined := [llvmfunc|
  llvm.func @n5(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.select %arg1, %0, %arg2 : i1, i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_n5   : n5_before  ⊑  n5_combined := by
  unfold n5_before n5_combined
  simp_alive_peephole
  sorry
def t6_combined := [llvmfunc|
  llvm.func @t6(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.select %arg1, %1, %arg2 : i1, i8
    %4 = llvm.add %3, %arg0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_t6   : t6_before  ⊑  t6_combined := by
  unfold t6_before t6_combined
  simp_alive_peephole
  sorry
def t7_combined := [llvmfunc|
  llvm.func @t7(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg2 overflow<nsw>  : i8
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.add %3, %arg0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_t7   : t7_before  ⊑  t7_combined := by
  unfold t7_before t7_combined
  simp_alive_peephole
  sorry
def n8_combined := [llvmfunc|
  llvm.func @n8(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_n8   : n8_before  ⊑  n8_combined := by
  unfold n8_before n8_combined
  simp_alive_peephole
  sorry
def t9_combined := [llvmfunc|
  llvm.func @t9(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_t9   : t9_before  ⊑  t9_combined := by
  unfold t9_before t9_combined
  simp_alive_peephole
  sorry
def n10_combined := [llvmfunc|
  llvm.func @n10(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg1, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_n10   : n10_before  ⊑  n10_combined := by
  unfold n10_before n10_combined
  simp_alive_peephole
  sorry
def neg_of_sub_from_constant_combined := [llvmfunc|
  llvm.func @neg_of_sub_from_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_neg_of_sub_from_constant   : neg_of_sub_from_constant_before  ⊑  neg_of_sub_from_constant_combined := by
  unfold neg_of_sub_from_constant_before neg_of_sub_from_constant_combined
  simp_alive_peephole
  sorry
def neg_of_sub_from_constant_multi_use_combined := [llvmfunc|
  llvm.func @neg_of_sub_from_constant_multi_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.sub %1, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    llvm.return %2 : i8
  }]

theorem inst_combine_neg_of_sub_from_constant_multi_use   : neg_of_sub_from_constant_multi_use_before  ⊑  neg_of_sub_from_constant_multi_use_combined := by
  unfold neg_of_sub_from_constant_multi_use_before neg_of_sub_from_constant_multi_use_combined
  simp_alive_peephole
  sorry
def sub_from_constant_of_sub_from_constant_combined := [llvmfunc|
  llvm.func @sub_from_constant_of_sub_from_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-31 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sub_from_constant_of_sub_from_constant   : sub_from_constant_of_sub_from_constant_before  ⊑  sub_from_constant_of_sub_from_constant_combined := by
  unfold sub_from_constant_of_sub_from_constant_before sub_from_constant_of_sub_from_constant_combined
  simp_alive_peephole
  sorry
def sub_from_constant_of_sub_from_constant_multi_use_combined := [llvmfunc|
  llvm.func @sub_from_constant_of_sub_from_constant_multi_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-31 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %arg0, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_sub_from_constant_of_sub_from_constant_multi_use   : sub_from_constant_of_sub_from_constant_multi_use_before  ⊑  sub_from_constant_of_sub_from_constant_multi_use_combined := by
  unfold sub_from_constant_of_sub_from_constant_multi_use_before sub_from_constant_of_sub_from_constant_multi_use_combined
  simp_alive_peephole
  sorry
def sub_from_variable_of_sub_from_constant_combined := [llvmfunc|
  llvm.func @sub_from_variable_of_sub_from_constant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.add %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_from_variable_of_sub_from_constant   : sub_from_variable_of_sub_from_constant_before  ⊑  sub_from_variable_of_sub_from_constant_combined := by
  unfold sub_from_variable_of_sub_from_constant_before sub_from_variable_of_sub_from_constant_combined
  simp_alive_peephole
  sorry
def sub_from_variable_of_sub_from_constant_multi_use_combined := [llvmfunc|
  llvm.func @sub_from_variable_of_sub_from_constant_multi_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_from_variable_of_sub_from_constant_multi_use   : sub_from_variable_of_sub_from_constant_multi_use_before  ⊑  sub_from_variable_of_sub_from_constant_multi_use_combined := by
  unfold sub_from_variable_of_sub_from_constant_multi_use_before sub_from_variable_of_sub_from_constant_multi_use_combined
  simp_alive_peephole
  sorry
def t12_combined := [llvmfunc|
  llvm.func @t12(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %arg1, %arg2  : i8
    %4 = llvm.add %3, %arg0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_t12   : t12_before  ⊑  t12_combined := by
  unfold t12_before t12_combined
  simp_alive_peephole
  sorry
def n13_combined := [llvmfunc|
  llvm.func @n13(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg1, %arg2  : i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n13   : n13_before  ⊑  n13_combined := by
  unfold n13_before n13_combined
  simp_alive_peephole
  sorry
def n14_combined := [llvmfunc|
  llvm.func @n14(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %arg1, %arg2  : i8
    %4 = llvm.sub %0, %3  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.add %3, %arg0  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_n14   : n14_before  ⊑  n14_combined := by
  unfold n14_before n14_combined
  simp_alive_peephole
  sorry
def neg_of_add_with_constant_combined := [llvmfunc|
  llvm.func @neg_of_add_with_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_neg_of_add_with_constant   : neg_of_add_with_constant_before  ⊑  neg_of_add_with_constant_combined := by
  unfold neg_of_add_with_constant_before neg_of_add_with_constant_combined
  simp_alive_peephole
  sorry
def neg_of_add_with_constant_multi_use_combined := [llvmfunc|
  llvm.func @neg_of_add_with_constant_multi_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-42 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_neg_of_add_with_constant_multi_use   : neg_of_add_with_constant_multi_use_before  ⊑  neg_of_add_with_constant_multi_use_combined := by
  unfold neg_of_add_with_constant_multi_use_before neg_of_add_with_constant_multi_use_combined
  simp_alive_peephole
  sorry
def sub_from_constant_of_add_with_constant_combined := [llvmfunc|
  llvm.func @sub_from_constant_of_add_with_constant(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-31 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sub_from_constant_of_add_with_constant   : sub_from_constant_of_add_with_constant_before  ⊑  sub_from_constant_of_add_with_constant_combined := by
  unfold sub_from_constant_of_add_with_constant_before sub_from_constant_of_add_with_constant_combined
  simp_alive_peephole
  sorry
def sub_from_constant_of_add_with_constant_multi_use_combined := [llvmfunc|
  llvm.func @sub_from_constant_of_add_with_constant_multi_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-31 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_sub_from_constant_of_add_with_constant_multi_use   : sub_from_constant_of_add_with_constant_multi_use_before  ⊑  sub_from_constant_of_add_with_constant_multi_use_combined := by
  unfold sub_from_constant_of_add_with_constant_multi_use_before sub_from_constant_of_add_with_constant_multi_use_combined
  simp_alive_peephole
  sorry
def sub_from_variable_of_add_with_constant_combined := [llvmfunc|
  llvm.func @sub_from_variable_of_add_with_constant(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_from_variable_of_add_with_constant   : sub_from_variable_of_add_with_constant_before  ⊑  sub_from_variable_of_add_with_constant_combined := by
  unfold sub_from_variable_of_add_with_constant_before sub_from_variable_of_add_with_constant_combined
  simp_alive_peephole
  sorry
def sub_from_variable_of_add_with_constant_multi_use_combined := [llvmfunc|
  llvm.func @sub_from_variable_of_add_with_constant_multi_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_from_variable_of_add_with_constant_multi_use   : sub_from_variable_of_add_with_constant_multi_use_before  ⊑  sub_from_variable_of_add_with_constant_multi_use_combined := by
  unfold sub_from_variable_of_add_with_constant_multi_use_before sub_from_variable_of_add_with_constant_multi_use_combined
  simp_alive_peephole
  sorry
def t15_combined := [llvmfunc|
  llvm.func @t15(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %arg2  : i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t15   : t15_before  ⊑  t15_combined := by
  unfold t15_before t15_combined
  simp_alive_peephole
  sorry
def n16_combined := [llvmfunc|
  llvm.func @n16(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.mul %1, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n16   : n16_before  ⊑  n16_combined := by
  unfold n16_before n16_combined
  simp_alive_peephole
  sorry
def t16_combined := [llvmfunc|
  llvm.func @t16(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i8)
  ^bb3(%1: i8):  // 2 preds: ^bb1, ^bb2
    llvm.return %1 : i8
  }]

theorem inst_combine_t16   : t16_before  ⊑  t16_combined := by
  unfold t16_before t16_combined
  simp_alive_peephole
  sorry
def n17_combined := [llvmfunc|
  llvm.func @n17(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %1, %arg1  : i8
    llvm.br ^bb3(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i8)
  ^bb3(%3: i8):  // 2 preds: ^bb1, ^bb2
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_n17   : n17_before  ⊑  n17_combined := by
  unfold n17_before n17_combined
  simp_alive_peephole
  sorry
def n19_combined := [llvmfunc|
  llvm.func @n19(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.sub %0, %arg1  : i8
    llvm.br ^bb3(%1 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : i8)
  ^bb3(%2: i8):  // 2 preds: ^bb1, ^bb2
    %3 = llvm.sub %0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n19   : n19_before  ⊑  n19_combined := by
  unfold n19_before n19_combined
  simp_alive_peephole
  sorry
def phi_with_duplicate_incoming_basic_blocks_combined := [llvmfunc|
  llvm.func @phi_with_duplicate_incoming_basic_blocks(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: i32) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-84 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.cond_br %arg2, ^bb1(%arg1 : i32), ^bb2(%1 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb2
    llvm.switch %3 : i32, ^bb3 [
      0: ^bb2(%2 : i32),
      42: ^bb2(%2 : i32)
    ]
  ^bb2(%4: i32):  // 3 preds: ^bb0, ^bb1, ^bb1
    %5 = llvm.call @use32gen1(%4) : (i32) -> i1
    llvm.cond_br %5, ^bb1(%4 : i32), ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return
  }]

theorem inst_combine_phi_with_duplicate_incoming_basic_blocks   : phi_with_duplicate_incoming_basic_blocks_before  ⊑  phi_with_duplicate_incoming_basic_blocks_combined := by
  unfold phi_with_duplicate_incoming_basic_blocks_before phi_with_duplicate_incoming_basic_blocks_combined
  simp_alive_peephole
  sorry
def t20_combined := [llvmfunc|
  llvm.func @t20(%arg0: i8, %arg1: i16) -> i8 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.shl %0, %arg1  : i16
    %2 = llvm.trunc %1 : i16 to i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t20   : t20_before  ⊑  t20_combined := by
  unfold t20_before t20_combined
  simp_alive_peephole
  sorry
def n21_combined := [llvmfunc|
  llvm.func @n21(%arg0: i8, %arg1: i16) -> i8 {
    %0 = llvm.mlir.constant(-42 : i16) : i16
    %1 = llvm.shl %0, %arg1  : i16
    %2 = llvm.trunc %1 : i16 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n21   : n21_before  ⊑  n21_combined := by
  unfold n21_before n21_combined
  simp_alive_peephole
  sorry
def negate_xor_combined := [llvmfunc|
  llvm.func @negate_xor(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.add %2, %1  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_negate_xor   : negate_xor_before  ⊑  negate_xor_combined := by
  unfold negate_xor_before negate_xor_combined
  simp_alive_peephole
  sorry
def negate_xor_vec_combined := [llvmfunc|
  llvm.func @negate_xor_vec(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-6, 5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(1 : i4) : i4
    %4 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %5 = llvm.xor %arg0, %2  : vector<2xi4>
    %6 = llvm.add %5, %4  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

theorem inst_combine_negate_xor_vec   : negate_xor_vec_before  ⊑  negate_xor_vec_combined := by
  unfold negate_xor_vec_before negate_xor_vec_combined
  simp_alive_peephole
  sorry
def negate_xor_use_combined := [llvmfunc|
  llvm.func @negate_xor_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_negate_xor_use   : negate_xor_use_before  ⊑  negate_xor_use_combined := by
  unfold negate_xor_use_before negate_xor_use_combined
  simp_alive_peephole
  sorry
def negate_shl_xor_combined := [llvmfunc|
  llvm.func @negate_shl_xor(%arg0: i4, %arg1: i4) -> i4 {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.add %2, %1  : i4
    %4 = llvm.shl %3, %arg1  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_negate_shl_xor   : negate_shl_xor_before  ⊑  negate_shl_xor_combined := by
  unfold negate_shl_xor_before negate_shl_xor_combined
  simp_alive_peephole
  sorry
def negate_shl_not_uses_combined := [llvmfunc|
  llvm.func @negate_shl_not_uses(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.xor %arg0, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %2, %arg1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_negate_shl_not_uses   : negate_shl_not_uses_before  ⊑  negate_shl_not_uses_combined := by
  unfold negate_shl_not_uses_before negate_shl_not_uses_combined
  simp_alive_peephole
  sorry
def negate_mul_not_uses_vec_combined := [llvmfunc|
  llvm.func @negate_mul_not_uses_vec(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(dense<1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mlir.constant(-1 : i4) : i4
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.add %arg0, %1  : vector<2xi4>
    %5 = llvm.xor %arg0, %3  : vector<2xi4>
    llvm.call @use_v2i4(%5) : (vector<2xi4>) -> ()
    %6 = llvm.mul %4, %arg1  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

theorem inst_combine_negate_mul_not_uses_vec   : negate_mul_not_uses_vec_before  ⊑  negate_mul_not_uses_vec_combined := by
  unfold negate_mul_not_uses_vec_before negate_mul_not_uses_vec_combined
  simp_alive_peephole
  sorry
def negate_sdiv_combined := [llvmfunc|
  llvm.func @negate_sdiv(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.sdiv %arg1, %0  : i8
    %2 = llvm.add %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_negate_sdiv   : negate_sdiv_before  ⊑  negate_sdiv_combined := by
  unfold negate_sdiv_before negate_sdiv_combined
  simp_alive_peephole
  sorry
def negate_sdiv_extrause_combined := [llvmfunc|
  llvm.func @negate_sdiv_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_negate_sdiv_extrause   : negate_sdiv_extrause_before  ⊑  negate_sdiv_extrause_combined := by
  unfold negate_sdiv_extrause_before negate_sdiv_extrause_combined
  simp_alive_peephole
  sorry
def negate_sdiv_extrause2_combined := [llvmfunc|
  llvm.func @negate_sdiv_extrause2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.sdiv %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_negate_sdiv_extrause2   : negate_sdiv_extrause2_before  ⊑  negate_sdiv_extrause2_combined := by
  unfold negate_sdiv_extrause2_before negate_sdiv_extrause2_combined
  simp_alive_peephole
  sorry
def negate_ashr_combined := [llvmfunc|
  llvm.func @negate_ashr(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    %2 = llvm.add %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_negate_ashr   : negate_ashr_before  ⊑  negate_ashr_combined := by
  unfold negate_ashr_before negate_ashr_combined
  simp_alive_peephole
  sorry
def negate_lshr_combined := [llvmfunc|
  llvm.func @negate_lshr(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg1, %0  : i8
    %2 = llvm.add %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_negate_lshr   : negate_lshr_before  ⊑  negate_lshr_combined := by
  unfold negate_lshr_before negate_lshr_combined
  simp_alive_peephole
  sorry
def negate_ashr_extrause_combined := [llvmfunc|
  llvm.func @negate_ashr_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_negate_ashr_extrause   : negate_ashr_extrause_before  ⊑  negate_ashr_extrause_combined := by
  unfold negate_ashr_extrause_before negate_ashr_extrause_combined
  simp_alive_peephole
  sorry
def negate_lshr_extrause_combined := [llvmfunc|
  llvm.func @negate_lshr_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_negate_lshr_extrause   : negate_lshr_extrause_before  ⊑  negate_lshr_extrause_combined := by
  unfold negate_lshr_extrause_before negate_lshr_extrause_combined
  simp_alive_peephole
  sorry
def negate_ashr_wrongshift_combined := [llvmfunc|
  llvm.func @negate_ashr_wrongshift(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_negate_ashr_wrongshift   : negate_ashr_wrongshift_before  ⊑  negate_ashr_wrongshift_combined := by
  unfold negate_ashr_wrongshift_before negate_ashr_wrongshift_combined
  simp_alive_peephole
  sorry
def negate_lshr_wrongshift_combined := [llvmfunc|
  llvm.func @negate_lshr_wrongshift(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_negate_lshr_wrongshift   : negate_lshr_wrongshift_before  ⊑  negate_lshr_wrongshift_combined := by
  unfold negate_lshr_wrongshift_before negate_lshr_wrongshift_combined
  simp_alive_peephole
  sorry
def negate_sext_combined := [llvmfunc|
  llvm.func @negate_sext(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.zext %arg1 : i1 to i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_negate_sext   : negate_sext_before  ⊑  negate_sext_combined := by
  unfold negate_sext_before negate_sext_combined
  simp_alive_peephole
  sorry
def negate_zext_combined := [llvmfunc|
  llvm.func @negate_zext(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_negate_zext   : negate_zext_before  ⊑  negate_zext_combined := by
  unfold negate_zext_before negate_zext_combined
  simp_alive_peephole
  sorry
def negate_sext_extrause_combined := [llvmfunc|
  llvm.func @negate_sext_extrause(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.sext %arg1 : i1 to i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_negate_sext_extrause   : negate_sext_extrause_before  ⊑  negate_sext_extrause_combined := by
  unfold negate_sext_extrause_before negate_sext_extrause_combined
  simp_alive_peephole
  sorry
def negate_zext_extrause_combined := [llvmfunc|
  llvm.func @negate_zext_extrause(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.zext %arg1 : i1 to i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_negate_zext_extrause   : negate_zext_extrause_before  ⊑  negate_zext_extrause_combined := by
  unfold negate_zext_extrause_before negate_zext_extrause_combined
  simp_alive_peephole
  sorry
def negate_sext_wrongwidth_combined := [llvmfunc|
  llvm.func @negate_sext_wrongwidth(%arg0: i8, %arg1: i2) -> i8 {
    %0 = llvm.sext %arg1 : i2 to i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_negate_sext_wrongwidth   : negate_sext_wrongwidth_before  ⊑  negate_sext_wrongwidth_combined := by
  unfold negate_sext_wrongwidth_before negate_sext_wrongwidth_combined
  simp_alive_peephole
  sorry
def negate_zext_wrongwidth_combined := [llvmfunc|
  llvm.func @negate_zext_wrongwidth(%arg0: i8, %arg1: i2) -> i8 {
    %0 = llvm.zext %arg1 : i2 to i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_negate_zext_wrongwidth   : negate_zext_wrongwidth_before  ⊑  negate_zext_wrongwidth_combined := by
  unfold negate_zext_wrongwidth_before negate_zext_wrongwidth_combined
  simp_alive_peephole
  sorry
def negate_shufflevector_oneinput_reverse_combined := [llvmfunc|
  llvm.func @negate_shufflevector_oneinput_reverse(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-5 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[6, -5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.poison : vector<2xi4>
    %4 = llvm.shl %2, %arg0  : vector<2xi4>
    %5 = llvm.shufflevector %4, %3 [1, 0] : vector<2xi4> 
    %6 = llvm.add %5, %arg1  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

theorem inst_combine_negate_shufflevector_oneinput_reverse   : negate_shufflevector_oneinput_reverse_before  ⊑  negate_shufflevector_oneinput_reverse_combined := by
  unfold negate_shufflevector_oneinput_reverse_before negate_shufflevector_oneinput_reverse_combined
  simp_alive_peephole
  sorry
def negate_shufflevector_oneinput_second_lane_is_undef_combined := [llvmfunc|
  llvm.func @negate_shufflevector_oneinput_second_lane_is_undef(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-5 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[6, -5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.undef : i4
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.shl %2, %arg0  : vector<2xi4>
    %6 = llvm.insertelement %3, %5[%4 : i64] : vector<2xi4>
    %7 = llvm.add %6, %arg1  : vector<2xi4>
    llvm.return %7 : vector<2xi4>
  }]

theorem inst_combine_negate_shufflevector_oneinput_second_lane_is_undef   : negate_shufflevector_oneinput_second_lane_is_undef_before  ⊑  negate_shufflevector_oneinput_second_lane_is_undef_combined := by
  unfold negate_shufflevector_oneinput_second_lane_is_undef_before negate_shufflevector_oneinput_second_lane_is_undef_combined
  simp_alive_peephole
  sorry
def negate_shufflevector_twoinputs_combined := [llvmfunc|
  llvm.func @negate_shufflevector_twoinputs(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-5 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[6, -5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.constant(1 : i4) : i4
    %4 = llvm.mlir.poison : i4
    %5 = llvm.mlir.undef : vector<2xi4>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xi4>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<2xi4>
    %10 = llvm.shl %2, %arg0  : vector<2xi4>
    %11 = llvm.add %arg1, %9  : vector<2xi4>
    %12 = llvm.shufflevector %10, %11 [0, 3] : vector<2xi4> 
    %13 = llvm.add %12, %arg2  : vector<2xi4>
    llvm.return %13 : vector<2xi4>
  }]

theorem inst_combine_negate_shufflevector_twoinputs   : negate_shufflevector_twoinputs_before  ⊑  negate_shufflevector_twoinputs_combined := by
  unfold negate_shufflevector_twoinputs_before negate_shufflevector_twoinputs_combined
  simp_alive_peephole
  sorry
def negate_shufflevector_oneinput_extrause_combined := [llvmfunc|
  llvm.func @negate_shufflevector_oneinput_extrause(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.mlir.constant(dense<[-6, 5]> : vector<2xi4>) : vector<2xi4>
    %3 = llvm.mlir.poison : vector<2xi4>
    %4 = llvm.shl %2, %arg0  : vector<2xi4>
    %5 = llvm.shufflevector %4, %3 [1, 0] : vector<2xi4> 
    llvm.call @use_v2i4(%5) : (vector<2xi4>) -> ()
    %6 = llvm.sub %arg1, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

theorem inst_combine_negate_shufflevector_oneinput_extrause   : negate_shufflevector_oneinput_extrause_before  ⊑  negate_shufflevector_oneinput_extrause_combined := by
  unfold negate_shufflevector_oneinput_extrause_before negate_shufflevector_oneinput_extrause_combined
  simp_alive_peephole
  sorry
def negation_of_zeroext_of_nonnegative_combined := [llvmfunc|
  llvm.func @negation_of_zeroext_of_nonnegative(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "sgt" %3, %1 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.zext %3 : i8 to i16
    %6 = llvm.sub %2, %5 overflow<nsw>  : i16
    llvm.return %6 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i16
  }]

theorem inst_combine_negation_of_zeroext_of_nonnegative   : negation_of_zeroext_of_nonnegative_before  ⊑  negation_of_zeroext_of_nonnegative_combined := by
  unfold negation_of_zeroext_of_nonnegative_before negation_of_zeroext_of_nonnegative_combined
  simp_alive_peephole
  sorry
def negation_of_zeroext_of_positive_combined := [llvmfunc|
  llvm.func @negation_of_zeroext_of_positive(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.zext %2 : i8 to i16
    %5 = llvm.sub %1, %4 overflow<nsw>  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }]

theorem inst_combine_negation_of_zeroext_of_positive   : negation_of_zeroext_of_positive_before  ⊑  negation_of_zeroext_of_positive_combined := by
  unfold negation_of_zeroext_of_positive_before negation_of_zeroext_of_positive_combined
  simp_alive_peephole
  sorry
def negation_of_signext_of_negative_combined := [llvmfunc|
  llvm.func @negation_of_signext_of_negative(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.sext %2 : i8 to i16
    %5 = llvm.sub %1, %4 overflow<nsw>  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }]

theorem inst_combine_negation_of_signext_of_negative   : negation_of_signext_of_negative_before  ⊑  negation_of_signext_of_negative_combined := by
  unfold negation_of_signext_of_negative_before negation_of_signext_of_negative_combined
  simp_alive_peephole
  sorry
def negation_of_signext_of_nonpositive_combined := [llvmfunc|
  llvm.func @negation_of_signext_of_nonpositive(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.sext %3 : i8 to i16
    %6 = llvm.sub %2, %5 overflow<nsw>  : i16
    llvm.return %6 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i16
  }]

theorem inst_combine_negation_of_signext_of_nonpositive   : negation_of_signext_of_nonpositive_before  ⊑  negation_of_signext_of_nonpositive_combined := by
  unfold negation_of_signext_of_nonpositive_before negation_of_signext_of_nonpositive_combined
  simp_alive_peephole
  sorry
def negation_of_signext_of_nonnegative__wrong_cast_combined := [llvmfunc|
  llvm.func @negation_of_signext_of_nonnegative__wrong_cast(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "sgt" %3, %1 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.zext %3 : i8 to i16
    %6 = llvm.sub %2, %5 overflow<nsw>  : i16
    llvm.return %6 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i16
  }]

theorem inst_combine_negation_of_signext_of_nonnegative__wrong_cast   : negation_of_signext_of_nonnegative__wrong_cast_before  ⊑  negation_of_signext_of_nonnegative__wrong_cast_combined := by
  unfold negation_of_signext_of_nonnegative__wrong_cast_before negation_of_signext_of_nonnegative__wrong_cast_combined
  simp_alive_peephole
  sorry
def negation_of_zeroext_of_negative_wrongcast_combined := [llvmfunc|
  llvm.func @negation_of_zeroext_of_negative_wrongcast(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.zext %2 : i8 to i16
    %5 = llvm.sub %1, %4 overflow<nsw>  : i16
    llvm.return %5 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }]

theorem inst_combine_negation_of_zeroext_of_negative_wrongcast   : negation_of_zeroext_of_negative_wrongcast_before  ⊑  negation_of_zeroext_of_negative_wrongcast_combined := by
  unfold negation_of_zeroext_of_negative_wrongcast_before negation_of_zeroext_of_negative_wrongcast_combined
  simp_alive_peephole
  sorry
def negation_of_increment_via_or_with_no_common_bits_set_combined := [llvmfunc|
  llvm.func @negation_of_increment_via_or_with_no_common_bits_set(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %arg1, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.add %3, %arg0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_negation_of_increment_via_or_with_no_common_bits_set   : negation_of_increment_via_or_with_no_common_bits_set_before  ⊑  negation_of_increment_via_or_with_no_common_bits_set_combined := by
  unfold negation_of_increment_via_or_with_no_common_bits_set_before negation_of_increment_via_or_with_no_common_bits_set_combined
  simp_alive_peephole
  sorry
def negation_of_increment_via_or_with_no_common_bits_set_extrause_combined := [llvmfunc|
  llvm.func @negation_of_increment_via_or_with_no_common_bits_set_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg1, %0  : i8
    %2 = llvm.or %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_negation_of_increment_via_or_with_no_common_bits_set_extrause   : negation_of_increment_via_or_with_no_common_bits_set_extrause_before  ⊑  negation_of_increment_via_or_with_no_common_bits_set_extrause_combined := by
  unfold negation_of_increment_via_or_with_no_common_bits_set_extrause_before negation_of_increment_via_or_with_no_common_bits_set_extrause_combined
  simp_alive_peephole
  sorry
def negation_of_increment_via_or_common_bits_set_combined := [llvmfunc|
  llvm.func @negation_of_increment_via_or_common_bits_set(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.shl %arg1, %0  : i8
    %3 = llvm.or %2, %1  : i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_negation_of_increment_via_or_common_bits_set   : negation_of_increment_via_or_common_bits_set_before  ⊑  negation_of_increment_via_or_common_bits_set_combined := by
  unfold negation_of_increment_via_or_common_bits_set_before negation_of_increment_via_or_common_bits_set_combined
  simp_alive_peephole
  sorry
def negation_of_increment_via_or_disjoint_combined := [llvmfunc|
  llvm.func @negation_of_increment_via_or_disjoint(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.add %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_negation_of_increment_via_or_disjoint   : negation_of_increment_via_or_disjoint_before  ⊑  negation_of_increment_via_or_disjoint_combined := by
  unfold negation_of_increment_via_or_disjoint_before negation_of_increment_via_or_disjoint_combined
  simp_alive_peephole
  sorry
def add_via_or_with_no_common_bits_set_combined := [llvmfunc|
  llvm.func @add_via_or_with_no_common_bits_set(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(-3 : i8) : i8
    %3 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %arg1, %1  : i8
    %5 = llvm.add %4, %2  : i8
    %6 = llvm.add %5, %arg0  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_add_via_or_with_no_common_bits_set   : add_via_or_with_no_common_bits_set_before  ⊑  add_via_or_with_no_common_bits_set_combined := by
  unfold add_via_or_with_no_common_bits_set_before add_via_or_with_no_common_bits_set_combined
  simp_alive_peephole
  sorry
def add_via_or_with_common_bit_maybe_set_combined := [llvmfunc|
  llvm.func @add_via_or_with_common_bit_maybe_set(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(4 : i8) : i8
    %3 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    %6 = llvm.sub %arg0, %5  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_add_via_or_with_common_bit_maybe_set   : add_via_or_with_common_bit_maybe_set_before  ⊑  add_via_or_with_common_bit_maybe_set_combined := by
  unfold add_via_or_with_common_bit_maybe_set_before add_via_or_with_common_bit_maybe_set_combined
  simp_alive_peephole
  sorry
def add_via_or_with_no_common_bits_set_extrause_combined := [llvmfunc|
  llvm.func @add_via_or_with_no_common_bits_set_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.call @use8(%5) : (i8) -> ()
    %6 = llvm.sub %arg0, %5  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_add_via_or_with_no_common_bits_set_extrause   : add_via_or_with_no_common_bits_set_extrause_before  ⊑  add_via_or_with_no_common_bits_set_extrause_combined := by
  unfold add_via_or_with_no_common_bits_set_extrause_before add_via_or_with_no_common_bits_set_extrause_combined
  simp_alive_peephole
  sorry
def negate_extractelement_combined := [llvmfunc|
  llvm.func @negate_extractelement(%arg0: vector<2xi4>, %arg1: i32, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    llvm.call @use_v2i4(%2) : (vector<2xi4>) -> ()
    %3 = llvm.extractelement %arg0[%arg1 : i32] : vector<2xi4>
    %4 = llvm.add %3, %arg2  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_negate_extractelement   : negate_extractelement_before  ⊑  negate_extractelement_combined := by
  unfold negate_extractelement_before negate_extractelement_combined
  simp_alive_peephole
  sorry
def negate_extractelement_extrause_combined := [llvmfunc|
  llvm.func @negate_extractelement_extrause(%arg0: vector<2xi4>, %arg1: i32, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    llvm.call @use_v2i4(%2) : (vector<2xi4>) -> ()
    %3 = llvm.extractelement %2[%arg1 : i32] : vector<2xi4>
    llvm.call @use4(%3) : (i4) -> ()
    %4 = llvm.sub %arg2, %3  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_negate_extractelement_extrause   : negate_extractelement_extrause_before  ⊑  negate_extractelement_extrause_combined := by
  unfold negate_extractelement_extrause_before negate_extractelement_extrause_combined
  simp_alive_peephole
  sorry
def negate_insertelement_combined := [llvmfunc|
  llvm.func @negate_insertelement(%arg0: vector<2xi4>, %arg1: i4, %arg2: i32, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.insertelement %arg1, %arg0[%arg2 : i32] : vector<2xi4>
    %1 = llvm.add %0, %arg3  : vector<2xi4>
    llvm.return %1 : vector<2xi4>
  }]

theorem inst_combine_negate_insertelement   : negate_insertelement_before  ⊑  negate_insertelement_combined := by
  unfold negate_insertelement_before negate_insertelement_combined
  simp_alive_peephole
  sorry
def negate_insertelement_extrause_combined := [llvmfunc|
  llvm.func @negate_insertelement_extrause(%arg0: vector<2xi4>, %arg1: i4, %arg2: i32, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    %3 = llvm.sub %0, %arg1  : i4
    %4 = llvm.insertelement %3, %2[%arg2 : i32] : vector<2xi4>
    llvm.call @use_v2i4(%4) : (vector<2xi4>) -> ()
    %5 = llvm.sub %arg3, %4  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }]

theorem inst_combine_negate_insertelement_extrause   : negate_insertelement_extrause_before  ⊑  negate_insertelement_extrause_combined := by
  unfold negate_insertelement_extrause_before negate_insertelement_extrause_combined
  simp_alive_peephole
  sorry
def negate_insertelement_nonnegatible_base_combined := [llvmfunc|
  llvm.func @negate_insertelement_nonnegatible_base(%arg0: vector<2xi4>, %arg1: i4, %arg2: i32, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.sub %0, %arg1  : i4
    %2 = llvm.insertelement %1, %arg0[%arg2 : i32] : vector<2xi4>
    %3 = llvm.sub %arg3, %2  : vector<2xi4>
    llvm.return %3 : vector<2xi4>
  }]

theorem inst_combine_negate_insertelement_nonnegatible_base   : negate_insertelement_nonnegatible_base_before  ⊑  negate_insertelement_nonnegatible_base_combined := by
  unfold negate_insertelement_nonnegatible_base_before negate_insertelement_nonnegatible_base_combined
  simp_alive_peephole
  sorry
def negate_insertelement_nonnegatible_insert_combined := [llvmfunc|
  llvm.func @negate_insertelement_nonnegatible_insert(%arg0: vector<2xi4>, %arg1: i4, %arg2: i32, %arg3: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.sub %1, %arg0  : vector<2xi4>
    %3 = llvm.insertelement %arg1, %2[%arg2 : i32] : vector<2xi4>
    %4 = llvm.sub %arg3, %3  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }]

theorem inst_combine_negate_insertelement_nonnegatible_insert   : negate_insertelement_nonnegatible_insert_before  ⊑  negate_insertelement_nonnegatible_insert_combined := by
  unfold negate_insertelement_nonnegatible_insert_before negate_insertelement_nonnegatible_insert_combined
  simp_alive_peephole
  sorry
def negate_left_shift_by_constant_prefer_keeping_shl_combined := [llvmfunc|
  llvm.func @negate_left_shift_by_constant_prefer_keeping_shl(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %arg2, %1  : i8
    %4 = llvm.add %3, %arg0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_negate_left_shift_by_constant_prefer_keeping_shl   : negate_left_shift_by_constant_prefer_keeping_shl_before  ⊑  negate_left_shift_by_constant_prefer_keeping_shl_combined := by
  unfold negate_left_shift_by_constant_prefer_keeping_shl_before negate_left_shift_by_constant_prefer_keeping_shl_combined
  simp_alive_peephole
  sorry
def negate_left_shift_by_constant_prefer_keeping_shl_extrause_combined := [llvmfunc|
  llvm.func @negate_left_shift_by_constant_prefer_keeping_shl_extrause(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_negate_left_shift_by_constant_prefer_keeping_shl_extrause   : negate_left_shift_by_constant_prefer_keeping_shl_extrause_before  ⊑  negate_left_shift_by_constant_prefer_keeping_shl_extrause_combined := by
  unfold negate_left_shift_by_constant_prefer_keeping_shl_extrause_before negate_left_shift_by_constant_prefer_keeping_shl_extrause_combined
  simp_alive_peephole
  sorry
def negate_left_shift_by_constant_combined := [llvmfunc|
  llvm.func @negate_left_shift_by_constant(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.sub %arg3, %arg2  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.shl %1, %0  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_negate_left_shift_by_constant   : negate_left_shift_by_constant_before  ⊑  negate_left_shift_by_constant_combined := by
  unfold negate_left_shift_by_constant_before negate_left_shift_by_constant_combined
  simp_alive_peephole
  sorry
def negate_left_shift_by_constant_extrause_combined := [llvmfunc|
  llvm.func @negate_left_shift_by_constant_extrause(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.sub %arg3, %arg2  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.shl %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_negate_left_shift_by_constant_extrause   : negate_left_shift_by_constant_extrause_before  ⊑  negate_left_shift_by_constant_extrause_combined := by
  unfold negate_left_shift_by_constant_extrause_before negate_left_shift_by_constant_extrause_combined
  simp_alive_peephole
  sorry
def negate_add_with_single_negatible_operand_combined := [llvmfunc|
  llvm.func @negate_add_with_single_negatible_operand(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_negate_add_with_single_negatible_operand   : negate_add_with_single_negatible_operand_before  ⊑  negate_add_with_single_negatible_operand_combined := by
  unfold negate_add_with_single_negatible_operand_before negate_add_with_single_negatible_operand_combined
  simp_alive_peephole
  sorry
def negate_add_with_single_negatible_operand_depth2_combined := [llvmfunc|
  llvm.func @negate_add_with_single_negatible_operand_depth2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-21 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.mul %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_negate_add_with_single_negatible_operand_depth2   : negate_add_with_single_negatible_operand_depth2_before  ⊑  negate_add_with_single_negatible_operand_depth2_combined := by
  unfold negate_add_with_single_negatible_operand_depth2_before negate_add_with_single_negatible_operand_depth2_combined
  simp_alive_peephole
  sorry
def negate_add_with_single_negatible_operand_extrause_combined := [llvmfunc|
  llvm.func @negate_add_with_single_negatible_operand_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-42 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_negate_add_with_single_negatible_operand_extrause   : negate_add_with_single_negatible_operand_extrause_before  ⊑  negate_add_with_single_negatible_operand_extrause_combined := by
  unfold negate_add_with_single_negatible_operand_extrause_before negate_add_with_single_negatible_operand_extrause_combined
  simp_alive_peephole
  sorry
def negate_add_with_single_negatible_operand_non_negation_combined := [llvmfunc|
  llvm.func @negate_add_with_single_negatible_operand_non_negation(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_negate_add_with_single_negatible_operand_non_negation   : negate_add_with_single_negatible_operand_non_negation_before  ⊑  negate_add_with_single_negatible_operand_non_negation_combined := by
  unfold negate_add_with_single_negatible_operand_non_negation_before negate_add_with_single_negatible_operand_non_negation_combined
  simp_alive_peephole
  sorry
def negate_abs_combined := [llvmfunc|
  llvm.func @negate_abs(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8]

theorem inst_combine_negate_abs   : negate_abs_before  ⊑  negate_abs_combined := by
  unfold negate_abs_before negate_abs_combined
  simp_alive_peephole
  sorry
    %3 = llvm.sub %arg1, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_negate_abs   : negate_abs_before  ⊑  negate_abs_combined := by
  unfold negate_abs_before negate_abs_combined
  simp_alive_peephole
  sorry
def negate_nabs_combined := [llvmfunc|
  llvm.func @negate_nabs(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8]

theorem inst_combine_negate_nabs   : negate_nabs_before  ⊑  negate_nabs_combined := by
  unfold negate_nabs_before negate_nabs_combined
  simp_alive_peephole
  sorry
    %3 = llvm.add %2, %arg1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_negate_nabs   : negate_nabs_before  ⊑  negate_nabs_combined := by
  unfold negate_nabs_before negate_nabs_combined
  simp_alive_peephole
  sorry
def negate_select_of_op_vs_negated_op_combined := [llvmfunc|
  llvm.func @negate_select_of_op_vs_negated_op(%arg0: i8, %arg1: i8, %arg2: i1) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.select %arg2, %arg0, %1 : i1, i8
    %3 = llvm.add %2, %arg1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_negate_select_of_op_vs_negated_op   : negate_select_of_op_vs_negated_op_before  ⊑  negate_select_of_op_vs_negated_op_combined := by
  unfold negate_select_of_op_vs_negated_op_before negate_select_of_op_vs_negated_op_combined
  simp_alive_peephole
  sorry
def dont_negate_ordinary_select_combined := [llvmfunc|
  llvm.func @dont_negate_ordinary_select(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i8 {
    %0 = llvm.select %arg3, %arg0, %arg1 : i1, i8
    %1 = llvm.sub %arg2, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_dont_negate_ordinary_select   : dont_negate_ordinary_select_before  ⊑  dont_negate_ordinary_select_combined := by
  unfold dont_negate_ordinary_select_before dont_negate_ordinary_select_combined
  simp_alive_peephole
  sorry
def negate_select_of_negation_poison_combined := [llvmfunc|
  llvm.func @negate_select_of_negation_poison(%arg0: vector<2xi1>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.sub %6, %arg1  : vector<2xi32>
    %8 = llvm.select %arg0, %arg1, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

theorem inst_combine_negate_select_of_negation_poison   : negate_select_of_negation_poison_before  ⊑  negate_select_of_negation_poison_combined := by
  unfold negate_select_of_negation_poison_before negate_select_of_negation_poison_combined
  simp_alive_peephole
  sorry
def negate_freeze_combined := [llvmfunc|
  llvm.func @negate_freeze(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.sub %arg1, %arg0  : i4
    %1 = llvm.freeze %0 : i4
    %2 = llvm.add %1, %arg2  : i4
    llvm.return %2 : i4
  }]

theorem inst_combine_negate_freeze   : negate_freeze_before  ⊑  negate_freeze_combined := by
  unfold negate_freeze_before negate_freeze_combined
  simp_alive_peephole
  sorry
def negate_freeze_extrause_combined := [llvmfunc|
  llvm.func @negate_freeze_extrause(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.sub %arg0, %arg1  : i4
    %1 = llvm.freeze %0 : i4
    llvm.call @use4(%1) : (i4) -> ()
    %2 = llvm.sub %arg2, %1  : i4
    llvm.return %2 : i4
  }]

theorem inst_combine_negate_freeze_extrause   : negate_freeze_extrause_before  ⊑  negate_freeze_extrause_combined := by
  unfold negate_freeze_extrause_before negate_freeze_extrause_combined
  simp_alive_peephole
  sorry
def noncanonical_mul_with_constant_as_first_operand_combined := [llvmfunc|
  llvm.func @noncanonical_mul_with_constant_as_first_operand() {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.br ^bb1
  }]

theorem inst_combine_noncanonical_mul_with_constant_as_first_operand   : noncanonical_mul_with_constant_as_first_operand_before  ⊑  noncanonical_mul_with_constant_as_first_operand_combined := by
  unfold noncanonical_mul_with_constant_as_first_operand_before noncanonical_mul_with_constant_as_first_operand_combined
  simp_alive_peephole
  sorry
def PR56601_combined := [llvmfunc|
  llvm.func @PR56601(%arg0: vector<1xi64>, %arg1: vector<1xi64>) -> vector<1xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<1xi64>) : vector<1xi64>
    %1 = llvm.mlir.constant(dense<12> : vector<1xi64>) : vector<1xi64>
    %2 = llvm.mlir.constant(-4 : i64) : i64
    %3 = llvm.mlir.addressof @g : !llvm.ptr
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.add %4, %2  : i64
    %6 = llvm.mlir.undef : vector<1xi64>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<1xi64>
    %9 = llvm.mlir.constant(-3 : i64) : i64
    %10 = llvm.add %4, %9  : i64
    %11 = llvm.mlir.undef : vector<1xi64>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<1xi64>
    %14 = llvm.mul %arg0, %0 overflow<nsw>  : vector<1xi64>
    %15 = llvm.mul %arg1, %1 overflow<nsw>  : vector<1xi64>
    %16 = llvm.add %14, %8  : vector<1xi64>
    %17 = llvm.add %15, %13  : vector<1xi64>
    %18 = llvm.sub %16, %17  : vector<1xi64>
    llvm.return %18 : vector<1xi64>
  }]

theorem inst_combine_PR56601   : PR56601_before  ⊑  PR56601_combined := by
  unfold PR56601_before PR56601_combined
  simp_alive_peephole
  sorry
