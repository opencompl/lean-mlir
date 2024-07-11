import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-factorize
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def logic_and_logic_or_1_before := [llvmfunc|
  llvm.func @logic_and_logic_or_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def logic_and_logic_or_2_before := [llvmfunc|
  llvm.func @logic_and_logic_or_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def logic_and_logic_or_3_before := [llvmfunc|
  llvm.func @logic_and_logic_or_3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def logic_and_logic_or_4_before := [llvmfunc|
  llvm.func @logic_and_logic_or_4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def logic_and_logic_or_5_before := [llvmfunc|
  llvm.func @logic_and_logic_or_5(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def logic_and_logic_or_6_before := [llvmfunc|
  llvm.func @logic_and_logic_or_6(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def logic_and_logic_or_7_before := [llvmfunc|
  llvm.func @logic_and_logic_or_7(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def logic_and_logic_or_8_before := [llvmfunc|
  llvm.func @logic_and_logic_or_8(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def logic_and_logic_or_vector_before := [llvmfunc|
  llvm.func @logic_and_logic_or_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg0, %arg1, %1 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %6 = llvm.select %4, %3, %5 : vector<3xi1>, vector<3xi1>
    llvm.return %6 : vector<3xi1>
  }]

def logic_and_logic_or_vector_poison1_before := [llvmfunc|
  llvm.func @logic_and_logic_or_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.poison : i1
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.select %arg0, %arg1, %1 : vector<3xi1>, vector<3xi1>
    %12 = llvm.select %arg0, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %11, %10, %12 : vector<3xi1>, vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }]

def logic_and_logic_or_vector_poison2_before := [llvmfunc|
  llvm.func @logic_and_logic_or_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %10 = llvm.mlir.constant(true) : i1
    %11 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %12 = llvm.select %arg0, %arg1, %8 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %arg0, %arg2, %9 : vector<3xi1>, vector<3xi1>
    %14 = llvm.select %12, %11, %13 : vector<3xi1>, vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }]

def logic_and_logic_or_vector_poison3_before := [llvmfunc|
  llvm.func @logic_and_logic_or_vector_poison3(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.poison : i1
    %3 = llvm.mlir.undef : vector<3xi1>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi1>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : vector<3xi1>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi1>
    %10 = llvm.mlir.constant(true) : i1
    %11 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %12 = llvm.select %arg0, %arg1, %1 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %arg0, %arg2, %9 : vector<3xi1>, vector<3xi1>
    %14 = llvm.select %12, %11, %13 : vector<3xi1>, vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }]

def logic_and_logic_or_not_one_use_before := [llvmfunc|
  llvm.func @logic_and_logic_or_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.call @use(%3) : (i1) -> ()
    llvm.return %4 : i1
  }]

def and_logic_and_logic_or_1_before := [llvmfunc|
  llvm.func @and_logic_and_logic_or_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg0, %arg1  : i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def and_logic_and_logic_or_2_before := [llvmfunc|
  llvm.func @and_logic_and_logic_or_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg0, %arg1  : i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def and_logic_and_logic_or_3_before := [llvmfunc|
  llvm.func @and_logic_and_logic_or_3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg1, %arg0  : i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def and_logic_and_logic_or_4_before := [llvmfunc|
  llvm.func @and_logic_and_logic_or_4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg1, %arg0  : i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def and_logic_and_logic_or_5_before := [llvmfunc|
  llvm.func @and_logic_and_logic_or_5(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg0, %arg1  : i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def and_logic_and_logic_or_6_before := [llvmfunc|
  llvm.func @and_logic_and_logic_or_6(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg0, %arg1  : i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def and_logic_and_logic_or_7_before := [llvmfunc|
  llvm.func @and_logic_and_logic_or_7(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg1, %arg0  : i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def and_logic_and_logic_or_8_before := [llvmfunc|
  llvm.func @and_logic_and_logic_or_8(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg1, %arg0  : i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def and_logic_and_logic_or_vector_before := [llvmfunc|
  llvm.func @and_logic_and_logic_or_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.and %arg0, %arg1  : vector<3xi1>
    %5 = llvm.select %arg0, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %6 = llvm.select %4, %3, %5 : vector<3xi1>, vector<3xi1>
    llvm.return %6 : vector<3xi1>
  }]

def and_logic_and_logic_or_vector_poison1_before := [llvmfunc|
  llvm.func @and_logic_and_logic_or_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(true) : i1
    %10 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %11 = llvm.and %arg0, %arg1  : vector<3xi1>
    %12 = llvm.select %arg0, %arg2, %8 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %11, %10, %12 : vector<3xi1>, vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }]

def and_logic_and_logic_or_vector_poison2_before := [llvmfunc|
  llvm.func @and_logic_and_logic_or_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.poison : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.and %arg0, %arg1  : vector<3xi1>
    %12 = llvm.select %arg0, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %11, %10, %12 : vector<3xi1>, vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }]

def and_logic_and_logic_or_not_one_use_before := [llvmfunc|
  llvm.func @and_logic_and_logic_or_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg1, %arg0  : i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.call @use(%3) : (i1) -> ()
    llvm.return %4 : i1
  }]

def and_and_logic_or_1_before := [llvmfunc|
  llvm.func @and_and_logic_or_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.and %arg0, %arg2  : i1
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def and_and_logic_or_2_before := [llvmfunc|
  llvm.func @and_and_logic_or_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.and %arg0, %arg2  : i1
    %3 = llvm.select %2, %0, %1 : i1, i1
    llvm.return %3 : i1
  }]

def and_and_logic_or_vector_before := [llvmfunc|
  llvm.func @and_and_logic_or_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.and %arg0, %arg1  : vector<3xi1>
    %3 = llvm.and %arg0, %arg2  : vector<3xi1>
    %4 = llvm.select %2, %1, %3 : vector<3xi1>, vector<3xi1>
    llvm.return %4 : vector<3xi1>
  }]

def and_and_logic_or_vector_poison_before := [llvmfunc|
  llvm.func @and_and_logic_or_vector_poison(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.and %arg0, %arg1  : vector<3xi1>
    %10 = llvm.and %arg0, %arg2  : vector<3xi1>
    %11 = llvm.select %9, %8, %10 : vector<3xi1>, vector<3xi1>
    llvm.return %11 : vector<3xi1>
  }]

def and_and_logic_or_not_one_use_before := [llvmfunc|
  llvm.func @and_and_logic_or_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.and %arg0, %arg2  : i1
    %3 = llvm.select %2, %0, %1 : i1, i1
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %3 : i1
  }]

def logic_or_logic_and_1_before := [llvmfunc|
  llvm.func @logic_or_logic_and_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def logic_or_logic_and_2_before := [llvmfunc|
  llvm.func @logic_or_logic_and_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg0 : i1, i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def logic_or_logic_and_3_before := [llvmfunc|
  llvm.func @logic_or_logic_and_3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg0 : i1, i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def logic_or_logic_and_4_before := [llvmfunc|
  llvm.func @logic_or_logic_and_4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def logic_or_logic_and_5_before := [llvmfunc|
  llvm.func @logic_or_logic_and_5(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def logic_or_logic_and_6_before := [llvmfunc|
  llvm.func @logic_or_logic_and_6(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg0 : i1, i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def logic_or_logic_and_7_before := [llvmfunc|
  llvm.func @logic_or_logic_and_7(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg0 : i1, i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def logic_or_logic_and_8_before := [llvmfunc|
  llvm.func @logic_or_logic_and_8(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def logic_or_logic_and_vector_before := [llvmfunc|
  llvm.func @logic_or_logic_and_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg0, %1, %arg1 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %6 = llvm.select %4, %5, %3 : vector<3xi1>, vector<3xi1>
    llvm.return %6 : vector<3xi1>
  }]

def logic_or_logic_and_vector_poison1_before := [llvmfunc|
  llvm.func @logic_or_logic_and_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %10 = llvm.mlir.constant(false) : i1
    %11 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %12 = llvm.select %arg0, %8, %arg1 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %arg0, %9, %arg2 : vector<3xi1>, vector<3xi1>
    %14 = llvm.select %12, %13, %11 : vector<3xi1>, vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }]

def logic_or_logic_and_vector_poison2_before := [llvmfunc|
  llvm.func @logic_or_logic_and_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.poison : i1
    %3 = llvm.mlir.undef : vector<3xi1>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : vector<3xi1>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi1>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi1>
    %10 = llvm.mlir.constant(false) : i1
    %11 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %12 = llvm.select %arg0, %1, %arg1 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %arg0, %9, %arg2 : vector<3xi1>, vector<3xi1>
    %14 = llvm.select %12, %13, %11 : vector<3xi1>, vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }]

def logic_or_logic_and_vector_poison3_before := [llvmfunc|
  llvm.func @logic_or_logic_and_vector_poison3(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.poison : i1
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.select %arg0, %1, %arg1 : vector<3xi1>, vector<3xi1>
    %12 = llvm.select %arg0, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %11, %12, %10 : vector<3xi1>, vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }]

def logic_or_logic_and_not_one_use_before := [llvmfunc|
  llvm.func @logic_or_logic_and_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.call @use(%3) : (i1) -> ()
    llvm.return %4 : i1
  }]

def or_logic_or_logic_and_1_before := [llvmfunc|
  llvm.func @or_logic_or_logic_and_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg0, %arg1  : i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def or_logic_or_logic_and_2_before := [llvmfunc|
  llvm.func @or_logic_or_logic_and_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg0, %arg1  : i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def or_logic_or_logic_and_3_before := [llvmfunc|
  llvm.func @or_logic_or_logic_and_3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg0, %arg1  : i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def or_logic_or_logic_and_4_before := [llvmfunc|
  llvm.func @or_logic_or_logic_and_4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg0, %arg1  : i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def or_logic_or_logic_and_5_before := [llvmfunc|
  llvm.func @or_logic_or_logic_and_5(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg1, %arg0  : i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def or_logic_or_logic_and_6_before := [llvmfunc|
  llvm.func @or_logic_or_logic_and_6(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg1, %arg0  : i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def or_logic_or_logic_and_7_before := [llvmfunc|
  llvm.func @or_logic_or_logic_and_7(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg1, %arg0  : i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def or_logic_or_logic_and_8_before := [llvmfunc|
  llvm.func @or_logic_or_logic_and_8(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg1, %arg0  : i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def or_logic_or_logic_and_vector_before := [llvmfunc|
  llvm.func @or_logic_or_logic_and_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.or %arg0, %arg1  : vector<3xi1>
    %5 = llvm.select %arg0, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %6 = llvm.select %4, %5, %3 : vector<3xi1>, vector<3xi1>
    llvm.return %6 : vector<3xi1>
  }]

def or_logic_or_logic_and_vector_poison1_before := [llvmfunc|
  llvm.func @or_logic_or_logic_and_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(false) : i1
    %10 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %11 = llvm.or %arg0, %arg1  : vector<3xi1>
    %12 = llvm.select %arg0, %8, %arg2 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %11, %12, %10 : vector<3xi1>, vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }]

def or_logic_or_logic_and_vector_poison2_before := [llvmfunc|
  llvm.func @or_logic_or_logic_and_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.poison : i1
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.or %arg0, %arg1  : vector<3xi1>
    %12 = llvm.select %arg0, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %11, %12, %10 : vector<3xi1>, vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }]

def or_logic_or_logic_and_not_one_use_before := [llvmfunc|
  llvm.func @or_logic_or_logic_and_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg0, %arg1  : i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.call @use(%3) : (i1) -> ()
    llvm.return %4 : i1
  }]

def or_or_logic_and_1_before := [llvmfunc|
  llvm.func @or_or_logic_and_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.or %arg2, %arg0  : i1
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }]

def or_or_logic_and_2_before := [llvmfunc|
  llvm.func @or_or_logic_and_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.or %arg2, %arg0  : i1
    %3 = llvm.select %2, %1, %0 : i1, i1
    llvm.return %3 : i1
  }]

def or_or_logic_and_vector_before := [llvmfunc|
  llvm.func @or_or_logic_and_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.or %arg0, %arg1  : vector<3xi1>
    %3 = llvm.or %arg2, %arg0  : vector<3xi1>
    %4 = llvm.select %2, %3, %1 : vector<3xi1>, vector<3xi1>
    llvm.return %4 : vector<3xi1>
  }]

def or_or_logic_and_vector_poison_before := [llvmfunc|
  llvm.func @or_or_logic_and_vector_poison(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.or %arg0, %arg1  : vector<3xi1>
    %10 = llvm.or %arg2, %arg0  : vector<3xi1>
    %11 = llvm.select %9, %10, %8 : vector<3xi1>, vector<3xi1>
    llvm.return %11 : vector<3xi1>
  }]

def or_or_logic_and_not_one_use_before := [llvmfunc|
  llvm.func @or_or_logic_and_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.or %arg2, %arg0  : i1
    %3 = llvm.select %2, %1, %0 : i1, i1
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %3 : i1
  }]

def logic_and_logic_or_1_combined := [llvmfunc|
  llvm.func @logic_and_logic_or_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg2 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_and_logic_or_1   : logic_and_logic_or_1_before  ⊑  logic_and_logic_or_1_combined := by
  unfold logic_and_logic_or_1_before logic_and_logic_or_1_combined
  simp_alive_peephole
  sorry
def logic_and_logic_or_2_combined := [llvmfunc|
  llvm.func @logic_and_logic_or_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg2 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_and_logic_or_2   : logic_and_logic_or_2_before  ⊑  logic_and_logic_or_2_combined := by
  unfold logic_and_logic_or_2_before logic_and_logic_or_2_combined
  simp_alive_peephole
  sorry
def logic_and_logic_or_3_combined := [llvmfunc|
  llvm.func @logic_and_logic_or_3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg2 : i1, i1
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_and_logic_or_3   : logic_and_logic_or_3_before  ⊑  logic_and_logic_or_3_combined := by
  unfold logic_and_logic_or_3_before logic_and_logic_or_3_combined
  simp_alive_peephole
  sorry
def logic_and_logic_or_4_combined := [llvmfunc|
  llvm.func @logic_and_logic_or_4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg2 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_and_logic_or_4   : logic_and_logic_or_4_before  ⊑  logic_and_logic_or_4_combined := by
  unfold logic_and_logic_or_4_before logic_and_logic_or_4_combined
  simp_alive_peephole
  sorry
def logic_and_logic_or_5_combined := [llvmfunc|
  llvm.func @logic_and_logic_or_5(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_and_logic_or_5   : logic_and_logic_or_5_before  ⊑  logic_and_logic_or_5_combined := by
  unfold logic_and_logic_or_5_before logic_and_logic_or_5_combined
  simp_alive_peephole
  sorry
def logic_and_logic_or_6_combined := [llvmfunc|
  llvm.func @logic_and_logic_or_6(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_and_logic_or_6   : logic_and_logic_or_6_before  ⊑  logic_and_logic_or_6_combined := by
  unfold logic_and_logic_or_6_before logic_and_logic_or_6_combined
  simp_alive_peephole
  sorry
def logic_and_logic_or_7_combined := [llvmfunc|
  llvm.func @logic_and_logic_or_7(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg1 : i1, i1
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_and_logic_or_7   : logic_and_logic_or_7_before  ⊑  logic_and_logic_or_7_combined := by
  unfold logic_and_logic_or_7_before logic_and_logic_or_7_combined
  simp_alive_peephole
  sorry
def logic_and_logic_or_8_combined := [llvmfunc|
  llvm.func @logic_and_logic_or_8(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_and_logic_or_8   : logic_and_logic_or_8_before  ⊑  logic_and_logic_or_8_combined := by
  unfold logic_and_logic_or_8_before logic_and_logic_or_8_combined
  simp_alive_peephole
  sorry
def logic_and_logic_or_vector_combined := [llvmfunc|
  llvm.func @logic_and_logic_or_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg1, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %4, %3 : vector<3xi1>, vector<3xi1>
    llvm.return %5 : vector<3xi1>
  }]

theorem inst_combine_logic_and_logic_or_vector   : logic_and_logic_or_vector_before  ⊑  logic_and_logic_or_vector_combined := by
  unfold logic_and_logic_or_vector_before logic_and_logic_or_vector_combined
  simp_alive_peephole
  sorry
def logic_and_logic_or_vector_poison1_combined := [llvmfunc|
  llvm.func @logic_and_logic_or_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg1, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %4, %3 : vector<3xi1>, vector<3xi1>
    llvm.return %5 : vector<3xi1>
  }]

theorem inst_combine_logic_and_logic_or_vector_poison1   : logic_and_logic_or_vector_poison1_before  ⊑  logic_and_logic_or_vector_poison1_combined := by
  unfold logic_and_logic_or_vector_poison1_before logic_and_logic_or_vector_poison1_combined
  simp_alive_peephole
  sorry
def logic_and_logic_or_vector_poison2_combined := [llvmfunc|
  llvm.func @logic_and_logic_or_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %10 = llvm.mlir.constant(true) : i1
    %11 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %12 = llvm.select %arg0, %arg1, %8 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %arg0, %arg2, %9 : vector<3xi1>, vector<3xi1>
    %14 = llvm.select %12, %11, %13 : vector<3xi1>, vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }]

theorem inst_combine_logic_and_logic_or_vector_poison2   : logic_and_logic_or_vector_poison2_before  ⊑  logic_and_logic_or_vector_poison2_combined := by
  unfold logic_and_logic_or_vector_poison2_before logic_and_logic_or_vector_poison2_combined
  simp_alive_peephole
  sorry
def logic_and_logic_or_vector_poison3_combined := [llvmfunc|
  llvm.func @logic_and_logic_or_vector_poison3(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.poison : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.select %arg1, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %12 = llvm.select %arg0, %11, %10 : vector<3xi1>, vector<3xi1>
    llvm.return %12 : vector<3xi1>
  }]

theorem inst_combine_logic_and_logic_or_vector_poison3   : logic_and_logic_or_vector_poison3_before  ⊑  logic_and_logic_or_vector_poison3_combined := by
  unfold logic_and_logic_or_vector_poison3_before logic_and_logic_or_vector_poison3_combined
  simp_alive_peephole
  sorry
def logic_and_logic_or_not_one_use_combined := [llvmfunc|
  llvm.func @logic_and_logic_or_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.call @use(%3) : (i1) -> ()
    llvm.return %4 : i1
  }]

theorem inst_combine_logic_and_logic_or_not_one_use   : logic_and_logic_or_not_one_use_before  ⊑  logic_and_logic_or_not_one_use_combined := by
  unfold logic_and_logic_or_not_one_use_before logic_and_logic_or_not_one_use_combined
  simp_alive_peephole
  sorry
def and_logic_and_logic_or_1_combined := [llvmfunc|
  llvm.func @and_logic_and_logic_or_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg2 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_logic_and_logic_or_1   : and_logic_and_logic_or_1_before  ⊑  and_logic_and_logic_or_1_combined := by
  unfold and_logic_and_logic_or_1_before and_logic_and_logic_or_1_combined
  simp_alive_peephole
  sorry
def and_logic_and_logic_or_2_combined := [llvmfunc|
  llvm.func @and_logic_and_logic_or_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg2 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_logic_and_logic_or_2   : and_logic_and_logic_or_2_before  ⊑  and_logic_and_logic_or_2_combined := by
  unfold and_logic_and_logic_or_2_before and_logic_and_logic_or_2_combined
  simp_alive_peephole
  sorry
def and_logic_and_logic_or_3_combined := [llvmfunc|
  llvm.func @and_logic_and_logic_or_3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg2 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_logic_and_logic_or_3   : and_logic_and_logic_or_3_before  ⊑  and_logic_and_logic_or_3_combined := by
  unfold and_logic_and_logic_or_3_before and_logic_and_logic_or_3_combined
  simp_alive_peephole
  sorry
def and_logic_and_logic_or_4_combined := [llvmfunc|
  llvm.func @and_logic_and_logic_or_4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg2 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_logic_and_logic_or_4   : and_logic_and_logic_or_4_before  ⊑  and_logic_and_logic_or_4_combined := by
  unfold and_logic_and_logic_or_4_before and_logic_and_logic_or_4_combined
  simp_alive_peephole
  sorry
def and_logic_and_logic_or_5_combined := [llvmfunc|
  llvm.func @and_logic_and_logic_or_5(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_logic_and_logic_or_5   : and_logic_and_logic_or_5_before  ⊑  and_logic_and_logic_or_5_combined := by
  unfold and_logic_and_logic_or_5_before and_logic_and_logic_or_5_combined
  simp_alive_peephole
  sorry
def and_logic_and_logic_or_6_combined := [llvmfunc|
  llvm.func @and_logic_and_logic_or_6(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg2, %0, %arg1 : i1, i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_and_logic_and_logic_or_6   : and_logic_and_logic_or_6_before  ⊑  and_logic_and_logic_or_6_combined := by
  unfold and_logic_and_logic_or_6_before and_logic_and_logic_or_6_combined
  simp_alive_peephole
  sorry
def and_logic_and_logic_or_7_combined := [llvmfunc|
  llvm.func @and_logic_and_logic_or_7(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_and_logic_and_logic_or_7   : and_logic_and_logic_or_7_before  ⊑  and_logic_and_logic_or_7_combined := by
  unfold and_logic_and_logic_or_7_before and_logic_and_logic_or_7_combined
  simp_alive_peephole
  sorry
def and_logic_and_logic_or_8_combined := [llvmfunc|
  llvm.func @and_logic_and_logic_or_8(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg2, %0, %arg1 : i1, i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_and_logic_and_logic_or_8   : and_logic_and_logic_or_8_before  ⊑  and_logic_and_logic_or_8_combined := by
  unfold and_logic_and_logic_or_8_before and_logic_and_logic_or_8_combined
  simp_alive_peephole
  sorry
def and_logic_and_logic_or_vector_combined := [llvmfunc|
  llvm.func @and_logic_and_logic_or_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg1, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %4, %3 : vector<3xi1>, vector<3xi1>
    llvm.return %5 : vector<3xi1>
  }]

theorem inst_combine_and_logic_and_logic_or_vector   : and_logic_and_logic_or_vector_before  ⊑  and_logic_and_logic_or_vector_combined := by
  unfold and_logic_and_logic_or_vector_before and_logic_and_logic_or_vector_combined
  simp_alive_peephole
  sorry
def and_logic_and_logic_or_vector_poison1_combined := [llvmfunc|
  llvm.func @and_logic_and_logic_or_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.poison : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %2, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.select %arg1, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %12 = llvm.select %arg0, %11, %10 : vector<3xi1>, vector<3xi1>
    llvm.return %12 : vector<3xi1>
  }]

theorem inst_combine_and_logic_and_logic_or_vector_poison1   : and_logic_and_logic_or_vector_poison1_before  ⊑  and_logic_and_logic_or_vector_poison1_combined := by
  unfold and_logic_and_logic_or_vector_poison1_before and_logic_and_logic_or_vector_poison1_combined
  simp_alive_peephole
  sorry
def and_logic_and_logic_or_vector_poison2_combined := [llvmfunc|
  llvm.func @and_logic_and_logic_or_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg1, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %4, %3 : vector<3xi1>, vector<3xi1>
    llvm.return %5 : vector<3xi1>
  }]

theorem inst_combine_and_logic_and_logic_or_vector_poison2   : and_logic_and_logic_or_vector_poison2_before  ⊑  and_logic_and_logic_or_vector_poison2_combined := by
  unfold and_logic_and_logic_or_vector_poison2_before and_logic_and_logic_or_vector_poison2_combined
  simp_alive_peephole
  sorry
def and_logic_and_logic_or_not_one_use_combined := [llvmfunc|
  llvm.func @and_logic_and_logic_or_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.select %arg2, %arg0, %0 : i1, i1
    %3 = llvm.select %arg2, %arg0, %1 : i1, i1
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_and_logic_and_logic_or_not_one_use   : and_logic_and_logic_or_not_one_use_before  ⊑  and_logic_and_logic_or_not_one_use_combined := by
  unfold and_logic_and_logic_or_not_one_use_before and_logic_and_logic_or_not_one_use_combined
  simp_alive_peephole
  sorry
def and_and_logic_or_1_combined := [llvmfunc|
  llvm.func @and_and_logic_or_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg2 : i1, i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_and_and_logic_or_1   : and_and_logic_or_1_before  ⊑  and_and_logic_or_1_combined := by
  unfold and_and_logic_or_1_before and_and_logic_or_1_combined
  simp_alive_peephole
  sorry
def and_and_logic_or_2_combined := [llvmfunc|
  llvm.func @and_and_logic_or_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg2, %0, %arg1 : i1, i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_and_and_logic_or_2   : and_and_logic_or_2_before  ⊑  and_and_logic_or_2_combined := by
  unfold and_and_logic_or_2_before and_and_logic_or_2_combined
  simp_alive_peephole
  sorry
def and_and_logic_or_vector_combined := [llvmfunc|
  llvm.func @and_and_logic_or_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.select %arg1, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %3 = llvm.and %2, %arg0  : vector<3xi1>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_and_and_logic_or_vector   : and_and_logic_or_vector_before  ⊑  and_and_logic_or_vector_combined := by
  unfold and_and_logic_or_vector_before and_and_logic_or_vector_combined
  simp_alive_peephole
  sorry
def and_and_logic_or_vector_poison_combined := [llvmfunc|
  llvm.func @and_and_logic_or_vector_poison(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.select %arg1, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %3 = llvm.and %2, %arg0  : vector<3xi1>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_and_and_logic_or_vector_poison   : and_and_logic_or_vector_poison_before  ⊑  and_and_logic_or_vector_poison_combined := by
  unfold and_and_logic_or_vector_poison_before and_and_logic_or_vector_poison_combined
  simp_alive_peephole
  sorry
def and_and_logic_or_not_one_use_combined := [llvmfunc|
  llvm.func @and_and_logic_or_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.and %arg1, %arg0  : i1
    %1 = llvm.and %arg0, %arg2  : i1
    %2 = llvm.select %arg2, %arg0, %0 : i1, i1
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.return %2 : i1
  }]

theorem inst_combine_and_and_logic_or_not_one_use   : and_and_logic_or_not_one_use_before  ⊑  and_and_logic_or_not_one_use_combined := by
  unfold and_and_logic_or_not_one_use_before and_and_logic_or_not_one_use_combined
  simp_alive_peephole
  sorry
def logic_or_logic_and_1_combined := [llvmfunc|
  llvm.func @logic_or_logic_and_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg2, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_or_logic_and_1   : logic_or_logic_and_1_before  ⊑  logic_or_logic_and_1_combined := by
  unfold logic_or_logic_and_1_before logic_or_logic_and_1_combined
  simp_alive_peephole
  sorry
def logic_or_logic_and_2_combined := [llvmfunc|
  llvm.func @logic_or_logic_and_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg2, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_or_logic_and_2   : logic_or_logic_and_2_before  ⊑  logic_or_logic_and_2_combined := by
  unfold logic_or_logic_and_2_before logic_or_logic_and_2_combined
  simp_alive_peephole
  sorry
def logic_or_logic_and_3_combined := [llvmfunc|
  llvm.func @logic_or_logic_and_3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg2, %0 : i1, i1
    %3 = llvm.select %2, %1, %arg0 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_or_logic_and_3   : logic_or_logic_and_3_before  ⊑  logic_or_logic_and_3_combined := by
  unfold logic_or_logic_and_3_before logic_or_logic_and_3_combined
  simp_alive_peephole
  sorry
def logic_or_logic_and_4_combined := [llvmfunc|
  llvm.func @logic_or_logic_and_4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg2, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_or_logic_and_4   : logic_or_logic_and_4_before  ⊑  logic_or_logic_and_4_combined := by
  unfold logic_or_logic_and_4_before logic_or_logic_and_4_combined
  simp_alive_peephole
  sorry
def logic_or_logic_and_5_combined := [llvmfunc|
  llvm.func @logic_or_logic_and_5(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg2, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_or_logic_and_5   : logic_or_logic_and_5_before  ⊑  logic_or_logic_and_5_combined := by
  unfold logic_or_logic_and_5_before logic_or_logic_and_5_combined
  simp_alive_peephole
  sorry
def logic_or_logic_and_6_combined := [llvmfunc|
  llvm.func @logic_or_logic_and_6(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg2, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_or_logic_and_6   : logic_or_logic_and_6_before  ⊑  logic_or_logic_and_6_combined := by
  unfold logic_or_logic_and_6_before logic_or_logic_and_6_combined
  simp_alive_peephole
  sorry
def logic_or_logic_and_7_combined := [llvmfunc|
  llvm.func @logic_or_logic_and_7(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg2, %arg1, %0 : i1, i1
    %3 = llvm.select %2, %1, %arg0 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_or_logic_and_7   : logic_or_logic_and_7_before  ⊑  logic_or_logic_and_7_combined := by
  unfold logic_or_logic_and_7_before logic_or_logic_and_7_combined
  simp_alive_peephole
  sorry
def logic_or_logic_and_8_combined := [llvmfunc|
  llvm.func @logic_or_logic_and_8(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg2, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_or_logic_and_8   : logic_or_logic_and_8_before  ⊑  logic_or_logic_and_8_combined := by
  unfold logic_or_logic_and_8_before logic_or_logic_and_8_combined
  simp_alive_peephole
  sorry
def logic_or_logic_and_vector_combined := [llvmfunc|
  llvm.func @logic_or_logic_and_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg1, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %3, %4 : vector<3xi1>, vector<3xi1>
    llvm.return %5 : vector<3xi1>
  }]

theorem inst_combine_logic_or_logic_and_vector   : logic_or_logic_and_vector_before  ⊑  logic_or_logic_and_vector_combined := by
  unfold logic_or_logic_and_vector_before logic_or_logic_and_vector_combined
  simp_alive_peephole
  sorry
def logic_or_logic_and_vector_poison1_combined := [llvmfunc|
  llvm.func @logic_or_logic_and_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %10 = llvm.mlir.constant(false) : i1
    %11 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %12 = llvm.select %arg0, %8, %arg1 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %arg0, %9, %arg2 : vector<3xi1>, vector<3xi1>
    %14 = llvm.select %12, %13, %11 : vector<3xi1>, vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }]

theorem inst_combine_logic_or_logic_and_vector_poison1   : logic_or_logic_and_vector_poison1_before  ⊑  logic_or_logic_and_vector_poison1_combined := by
  unfold logic_or_logic_and_vector_poison1_before logic_or_logic_and_vector_poison1_combined
  simp_alive_peephole
  sorry
def logic_or_logic_and_vector_poison2_combined := [llvmfunc|
  llvm.func @logic_or_logic_and_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.poison : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %2, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.select %arg1, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %12 = llvm.select %arg0, %10, %11 : vector<3xi1>, vector<3xi1>
    llvm.return %12 : vector<3xi1>
  }]

theorem inst_combine_logic_or_logic_and_vector_poison2   : logic_or_logic_and_vector_poison2_before  ⊑  logic_or_logic_and_vector_poison2_combined := by
  unfold logic_or_logic_and_vector_poison2_before logic_or_logic_and_vector_poison2_combined
  simp_alive_peephole
  sorry
def logic_or_logic_and_vector_poison3_combined := [llvmfunc|
  llvm.func @logic_or_logic_and_vector_poison3(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg1, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %3, %4 : vector<3xi1>, vector<3xi1>
    llvm.return %5 : vector<3xi1>
  }]

theorem inst_combine_logic_or_logic_and_vector_poison3   : logic_or_logic_and_vector_poison3_before  ⊑  logic_or_logic_and_vector_poison3_combined := by
  unfold logic_or_logic_and_vector_poison3_before logic_or_logic_and_vector_poison3_combined
  simp_alive_peephole
  sorry
def logic_or_logic_and_not_one_use_combined := [llvmfunc|
  llvm.func @logic_or_logic_and_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.select %arg2, %0, %arg0 : i1, i1
    %3 = llvm.select %arg2, %1, %arg0 : i1, i1
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_logic_or_logic_and_not_one_use   : logic_or_logic_and_not_one_use_before  ⊑  logic_or_logic_and_not_one_use_combined := by
  unfold logic_or_logic_and_not_one_use_before logic_or_logic_and_not_one_use_combined
  simp_alive_peephole
  sorry
def or_logic_or_logic_and_1_combined := [llvmfunc|
  llvm.func @or_logic_or_logic_and_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg2, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_logic_or_logic_and_1   : or_logic_or_logic_and_1_before  ⊑  or_logic_or_logic_and_1_combined := by
  unfold or_logic_or_logic_and_1_before or_logic_or_logic_and_1_combined
  simp_alive_peephole
  sorry
def or_logic_or_logic_and_2_combined := [llvmfunc|
  llvm.func @or_logic_or_logic_and_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg2, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_logic_or_logic_and_2   : or_logic_or_logic_and_2_before  ⊑  or_logic_or_logic_and_2_combined := by
  unfold or_logic_or_logic_and_2_before or_logic_or_logic_and_2_combined
  simp_alive_peephole
  sorry
def or_logic_or_logic_and_3_combined := [llvmfunc|
  llvm.func @or_logic_or_logic_and_3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg2, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_logic_or_logic_and_3   : or_logic_or_logic_and_3_before  ⊑  or_logic_or_logic_and_3_combined := by
  unfold or_logic_or_logic_and_3_before or_logic_or_logic_and_3_combined
  simp_alive_peephole
  sorry
def or_logic_or_logic_and_4_combined := [llvmfunc|
  llvm.func @or_logic_or_logic_and_4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg2, %arg1, %0 : i1, i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_or_logic_or_logic_and_4   : or_logic_or_logic_and_4_before  ⊑  or_logic_or_logic_and_4_combined := by
  unfold or_logic_or_logic_and_4_before or_logic_or_logic_and_4_combined
  simp_alive_peephole
  sorry
def or_logic_or_logic_and_5_combined := [llvmfunc|
  llvm.func @or_logic_or_logic_and_5(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg2, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_logic_or_logic_and_5   : or_logic_or_logic_and_5_before  ⊑  or_logic_or_logic_and_5_combined := by
  unfold or_logic_or_logic_and_5_before or_logic_or_logic_and_5_combined
  simp_alive_peephole
  sorry
def or_logic_or_logic_and_6_combined := [llvmfunc|
  llvm.func @or_logic_or_logic_and_6(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg2, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_logic_or_logic_and_6   : or_logic_or_logic_and_6_before  ⊑  or_logic_or_logic_and_6_combined := by
  unfold or_logic_or_logic_and_6_before or_logic_or_logic_and_6_combined
  simp_alive_peephole
  sorry
def or_logic_or_logic_and_7_combined := [llvmfunc|
  llvm.func @or_logic_or_logic_and_7(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg2, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %1, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_or_logic_or_logic_and_7   : or_logic_or_logic_and_7_before  ⊑  or_logic_or_logic_and_7_combined := by
  unfold or_logic_or_logic_and_7_before or_logic_or_logic_and_7_combined
  simp_alive_peephole
  sorry
def or_logic_or_logic_and_8_combined := [llvmfunc|
  llvm.func @or_logic_or_logic_and_8(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg2, %arg1, %0 : i1, i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_or_logic_or_logic_and_8   : or_logic_or_logic_and_8_before  ⊑  or_logic_or_logic_and_8_combined := by
  unfold or_logic_or_logic_and_8_before or_logic_or_logic_and_8_combined
  simp_alive_peephole
  sorry
def or_logic_or_logic_and_vector_combined := [llvmfunc|
  llvm.func @or_logic_or_logic_and_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg1, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %3, %4 : vector<3xi1>, vector<3xi1>
    llvm.return %5 : vector<3xi1>
  }]

theorem inst_combine_or_logic_or_logic_and_vector   : or_logic_or_logic_and_vector_before  ⊑  or_logic_or_logic_and_vector_combined := by
  unfold or_logic_or_logic_and_vector_before or_logic_or_logic_and_vector_combined
  simp_alive_peephole
  sorry
def or_logic_or_logic_and_vector_poison1_combined := [llvmfunc|
  llvm.func @or_logic_or_logic_and_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.poison : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %2, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.select %arg1, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %12 = llvm.select %arg0, %10, %11 : vector<3xi1>, vector<3xi1>
    llvm.return %12 : vector<3xi1>
  }]

theorem inst_combine_or_logic_or_logic_and_vector_poison1   : or_logic_or_logic_and_vector_poison1_before  ⊑  or_logic_or_logic_and_vector_poison1_combined := by
  unfold or_logic_or_logic_and_vector_poison1_before or_logic_or_logic_and_vector_poison1_combined
  simp_alive_peephole
  sorry
def or_logic_or_logic_and_vector_poison2_combined := [llvmfunc|
  llvm.func @or_logic_or_logic_and_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg1, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %3, %4 : vector<3xi1>, vector<3xi1>
    llvm.return %5 : vector<3xi1>
  }]

theorem inst_combine_or_logic_or_logic_and_vector_poison2   : or_logic_or_logic_and_vector_poison2_before  ⊑  or_logic_or_logic_and_vector_poison2_combined := by
  unfold or_logic_or_logic_and_vector_poison2_before or_logic_or_logic_and_vector_poison2_combined
  simp_alive_peephole
  sorry
def or_logic_or_logic_and_not_one_use_combined := [llvmfunc|
  llvm.func @or_logic_or_logic_and_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.select %arg2, %0, %arg0 : i1, i1
    %3 = llvm.select %arg2, %1, %arg0 : i1, i1
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_or_logic_or_logic_and_not_one_use   : or_logic_or_logic_and_not_one_use_before  ⊑  or_logic_or_logic_and_not_one_use_combined := by
  unfold or_logic_or_logic_and_not_one_use_before or_logic_or_logic_and_not_one_use_combined
  simp_alive_peephole
  sorry
def or_or_logic_and_1_combined := [llvmfunc|
  llvm.func @or_or_logic_and_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg2, %0 : i1, i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_or_or_logic_and_1   : or_or_logic_and_1_before  ⊑  or_or_logic_and_1_combined := by
  unfold or_or_logic_and_1_before or_or_logic_and_1_combined
  simp_alive_peephole
  sorry
def or_or_logic_and_2_combined := [llvmfunc|
  llvm.func @or_or_logic_and_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg2, %arg1, %0 : i1, i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_or_or_logic_and_2   : or_or_logic_and_2_before  ⊑  or_or_logic_and_2_combined := by
  unfold or_or_logic_and_2_before or_or_logic_and_2_combined
  simp_alive_peephole
  sorry
def or_or_logic_and_vector_combined := [llvmfunc|
  llvm.func @or_or_logic_and_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.select %arg1, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %3 = llvm.or %2, %arg0  : vector<3xi1>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_or_or_logic_and_vector   : or_or_logic_and_vector_before  ⊑  or_or_logic_and_vector_combined := by
  unfold or_or_logic_and_vector_before or_or_logic_and_vector_combined
  simp_alive_peephole
  sorry
def or_or_logic_and_vector_poison_combined := [llvmfunc|
  llvm.func @or_or_logic_and_vector_poison(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.select %arg1, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %3 = llvm.or %2, %arg0  : vector<3xi1>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_or_or_logic_and_vector_poison   : or_or_logic_and_vector_poison_before  ⊑  or_or_logic_and_vector_poison_combined := by
  unfold or_or_logic_and_vector_poison_before or_or_logic_and_vector_poison_combined
  simp_alive_peephole
  sorry
def or_or_logic_and_not_one_use_combined := [llvmfunc|
  llvm.func @or_or_logic_and_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i1
    %1 = llvm.or %arg2, %arg0  : i1
    %2 = llvm.select %arg2, %0, %arg0 : i1, i1
    llvm.call @use(%0) : (i1) -> ()
    llvm.call @use(%1) : (i1) -> ()
    llvm.return %2 : i1
  }]

theorem inst_combine_or_or_logic_and_not_one_use   : or_or_logic_and_not_one_use_before  ⊑  or_or_logic_and_not_one_use_combined := by
  unfold or_or_logic_and_not_one_use_before or_or_logic_and_not_one_use_combined
  simp_alive_peephole
  sorry
