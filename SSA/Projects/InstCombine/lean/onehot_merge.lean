import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  onehot_merge
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def and_consts_before := [llvmfunc|
  llvm.func @and_consts(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %0, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %2, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def and_consts_logical_before := [llvmfunc|
  llvm.func @and_consts_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %0, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %2, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    llvm.return %8 : i1
  }]

def and_consts_vector_before := [llvmfunc|
  llvm.func @and_consts_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %0, %arg0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.and %3, %arg0  : vector<2xi32>
    %7 = llvm.icmp "eq" %6, %2 : vector<2xi32>
    %8 = llvm.or %5, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }]

def foo1_and_before := [llvmfunc|
  llvm.func @foo1_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_logical_before := [llvmfunc|
  llvm.func @foo1_and_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_and_vector_before := [llvmfunc|
  llvm.func @foo1_and_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.shl %0, %arg1  : vector<2xi32>
    %4 = llvm.shl %0, %arg2  : vector<2xi32>
    %5 = llvm.and %3, %arg0  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi32>
    %7 = llvm.and %4, %arg0  : vector<2xi32>
    %8 = llvm.icmp "eq" %7, %2 : vector<2xi32>
    %9 = llvm.or %6, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

def foo1_and_commuted_before := [llvmfunc|
  llvm.func @foo1_and_commuted(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg0, %arg0  : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %2, %3  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %2  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.or %6, %8  : i1
    llvm.return %9 : i1
  }]

def foo1_and_commuted_logical_before := [llvmfunc|
  llvm.func @foo1_and_commuted_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mul %arg0, %arg0  : i32
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.shl %0, %arg2  : i32
    %6 = llvm.and %3, %4  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.and %5, %3  : i32
    %9 = llvm.icmp "eq" %8, %1 : i32
    %10 = llvm.select %7, %2, %9 : i1, i1
    llvm.return %10 : i1
  }]

def foo1_and_commuted_vector_before := [llvmfunc|
  llvm.func @foo1_and_commuted_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %4 = llvm.shl %0, %arg1  : vector<2xi32>
    %5 = llvm.shl %0, %arg2  : vector<2xi32>
    %6 = llvm.and %3, %4  : vector<2xi32>
    %7 = llvm.icmp "eq" %6, %2 : vector<2xi32>
    %8 = llvm.and %5, %3  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %2 : vector<2xi32>
    %10 = llvm.or %7, %9  : vector<2xi1>
    llvm.return %10 : vector<2xi1>
  }]

def or_consts_before := [llvmfunc|
  llvm.func @or_consts(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %0, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_consts_logical_before := [llvmfunc|
  llvm.func @or_consts_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %0, %arg0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %2, %arg0  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

def or_consts_vector_before := [llvmfunc|
  llvm.func @or_consts_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %0, %arg0  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    %6 = llvm.and %3, %arg0  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %2 : vector<2xi32>
    %8 = llvm.and %5, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }]

def foo1_or_before := [llvmfunc|
  llvm.func @foo1_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_or_logical_before := [llvmfunc|
  llvm.func @foo1_or_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "ne" %7, %1 : i32
    %9 = llvm.select %6, %8, %2 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_or_vector_before := [llvmfunc|
  llvm.func @foo1_or_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.shl %0, %arg1  : vector<2xi32>
    %4 = llvm.shl %0, %arg2  : vector<2xi32>
    %5 = llvm.and %3, %arg0  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi32>
    %7 = llvm.and %4, %arg0  : vector<2xi32>
    %8 = llvm.icmp "ne" %7, %2 : vector<2xi32>
    %9 = llvm.and %6, %8  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }]

def foo1_or_commuted_before := [llvmfunc|
  llvm.func @foo1_or_commuted(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg0, %arg0  : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %2, %3  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %4, %2  : i32
    %8 = llvm.icmp "ne" %7, %1 : i32
    %9 = llvm.and %6, %8  : i1
    llvm.return %9 : i1
  }]

def foo1_or_commuted_logical_before := [llvmfunc|
  llvm.func @foo1_or_commuted_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mul %arg0, %arg0  : i32
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.shl %0, %arg2  : i32
    %6 = llvm.and %3, %4  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.and %5, %3  : i32
    %9 = llvm.icmp "ne" %8, %1 : i32
    %10 = llvm.select %7, %9, %2 : i1, i1
    llvm.return %10 : i1
  }]

def foo1_or_commuted_vector_before := [llvmfunc|
  llvm.func @foo1_or_commuted_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %4 = llvm.shl %0, %arg1  : vector<2xi32>
    %5 = llvm.shl %0, %arg2  : vector<2xi32>
    %6 = llvm.and %3, %4  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %2 : vector<2xi32>
    %8 = llvm.and %5, %3  : vector<2xi32>
    %9 = llvm.icmp "ne" %8, %2 : vector<2xi32>
    %10 = llvm.and %7, %9  : vector<2xi1>
    llvm.return %10 : vector<2xi1>
  }]

def foo1_and_signbit_lshr_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.lshr %1, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %2 : i32
    %9 = llvm.or %6, %8  : i1
    llvm.return %9 : i1
  }]

def foo1_and_signbit_lshr_logical_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.lshr %1, %arg2  : i32
    %6 = llvm.and %4, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    %8 = llvm.and %5, %arg0  : i32
    %9 = llvm.icmp "eq" %8, %2 : i32
    %10 = llvm.select %7, %3, %9 : i1, i1
    llvm.return %10 : i1
  }]

def foo1_and_signbit_lshr_vector_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg1  : vector<2xi32>
    %5 = llvm.lshr %1, %arg2  : vector<2xi32>
    %6 = llvm.and %4, %arg0  : vector<2xi32>
    %7 = llvm.icmp "eq" %6, %3 : vector<2xi32>
    %8 = llvm.and %5, %arg0  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %3 : vector<2xi32>
    %10 = llvm.or %7, %9  : vector<2xi1>
    llvm.return %10 : vector<2xi1>
  }]

def foo1_or_signbit_lshr_before := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.lshr %1, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    %9 = llvm.and %6, %8  : i1
    llvm.return %9 : i1
  }]

def foo1_or_signbit_lshr_logical_before := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.lshr %1, %arg2  : i32
    %6 = llvm.and %4, %arg0  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.and %5, %arg0  : i32
    %9 = llvm.icmp "ne" %8, %2 : i32
    %10 = llvm.select %7, %9, %3 : i1, i1
    llvm.return %10 : i1
  }]

def foo1_or_signbit_lshr_vector_before := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg1  : vector<2xi32>
    %5 = llvm.lshr %1, %arg2  : vector<2xi32>
    %6 = llvm.and %4, %arg0  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %3 : vector<2xi32>
    %8 = llvm.and %5, %arg0  : vector<2xi32>
    %9 = llvm.icmp "ne" %8, %3 : vector<2xi32>
    %10 = llvm.and %7, %9  : vector<2xi1>
    llvm.return %10 : vector<2xi1>
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_logical_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_or_signbit_lshr_without_shifting_signbit_before := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.shl %arg0, %arg2  : i32
    %6 = llvm.icmp "slt" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def foo1_or_signbit_lshr_without_shifting_signbit_logical_before := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "slt" %6, %1 : i32
    %8 = llvm.select %5, %7, %2 : i1, i1
    llvm.return %8 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_both_sides_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_both_sides(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.shl %arg0, %arg2  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_both_sides_logical_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_both_sides_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.shl %arg0, %arg2  : i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.select %3, %1, %5 : i1, i1
    llvm.return %6 : i1
  }]

def foo1_or_signbit_lshr_without_shifting_signbit_both_sides_before := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit_both_sides(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.shl %arg0, %arg2  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }]

def foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat_before := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %arg1  : vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    %4 = llvm.shl %arg0, %arg2  : vector<2xi32>
    %5 = llvm.icmp "slt" %4, %1 : vector<2xi32>
    %6 = llvm.and %3, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def foo1_or_signbit_lshr_without_shifting_signbit_both_sides_logical_before := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit_both_sides_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.shl %arg0, %arg2  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %3, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

def foo1_and_extra_use_shl_before := [llvmfunc|
  llvm.func @foo1_and_extra_use_shl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    llvm.store %2, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_extra_use_shl_logical_before := [llvmfunc|
  llvm.func @foo1_and_extra_use_shl_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_and_extra_use_and_before := [llvmfunc|
  llvm.func @foo1_and_extra_use_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_extra_use_and_logical_before := [llvmfunc|
  llvm.func @foo1_and_extra_use_and_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    llvm.store %5, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_and_extra_use_cmp_before := [llvmfunc|
  llvm.func @foo1_and_extra_use_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.store %5, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_extra_use_cmp_logical_before := [llvmfunc|
  llvm.func @foo1_and_extra_use_cmp_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.store %6, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_and_extra_use_shl2_before := [llvmfunc|
  llvm.func @foo1_and_extra_use_shl2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_extra_use_shl2_logical_before := [llvmfunc|
  llvm.func @foo1_and_extra_use_shl2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_and_extra_use_and2_before := [llvmfunc|
  llvm.func @foo1_and_extra_use_and2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    llvm.store %6, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_extra_use_and2_logical_before := [llvmfunc|
  llvm.func @foo1_and_extra_use_and2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    llvm.store %7, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_and_extra_use_cmp2_before := [llvmfunc|
  llvm.func @foo1_and_extra_use_cmp2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %0, %arg2  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.store %7, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_extra_use_cmp2_logical_before := [llvmfunc|
  llvm.func @foo1_and_extra_use_cmp2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.shl %0, %arg2  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    llvm.store %8, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

    %9 = llvm.select %6, %2, %8 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    llvm.store %5, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.store %5, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.store %6, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    llvm.store %6, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    llvm.store %7, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    llvm.store %7, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.store %8, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

def foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_logical_before := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

def and_consts_combined := [llvmfunc|
  llvm.func @and_consts(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_and_consts   : and_consts_before  ⊑  and_consts_combined := by
  unfold and_consts_before and_consts_combined
  simp_alive_peephole
  sorry
def and_consts_logical_combined := [llvmfunc|
  llvm.func @and_consts_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_and_consts_logical   : and_consts_logical_before  ⊑  and_consts_logical_combined := by
  unfold and_consts_logical_before and_consts_logical_combined
  simp_alive_peephole
  sorry
def and_consts_vector_combined := [llvmfunc|
  llvm.func @and_consts_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_and_consts_vector   : and_consts_vector_before  ⊑  and_consts_vector_combined := by
  unfold and_consts_vector_before and_consts_vector_combined
  simp_alive_peephole
  sorry
def foo1_and_combined := [llvmfunc|
  llvm.func @foo1_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "ne" %4, %3 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_foo1_and   : foo1_and_before  ⊑  foo1_and_combined := by
  unfold foo1_and_before foo1_and_combined
  simp_alive_peephole
  sorry
def foo1_and_logical_combined := [llvmfunc|
  llvm.func @foo1_and_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %3 = llvm.freeze %2 : i32
    %4 = llvm.or %1, %3  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %4 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_foo1_and_logical   : foo1_and_logical_before  ⊑  foo1_and_logical_combined := by
  unfold foo1_and_logical_before foo1_and_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_vector_combined := [llvmfunc|
  llvm.func @foo1_and_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : vector<2xi32>
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %3 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_foo1_and_vector   : foo1_and_vector_before  ⊑  foo1_and_vector_combined := by
  unfold foo1_and_vector_before foo1_and_vector_combined
  simp_alive_peephole
  sorry
def foo1_and_commuted_combined := [llvmfunc|
  llvm.func @foo1_and_commuted(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.and %1, %4  : i32
    %6 = llvm.icmp "ne" %5, %4 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_foo1_and_commuted   : foo1_and_commuted_before  ⊑  foo1_and_commuted_combined := by
  unfold foo1_and_commuted_before foo1_and_commuted_combined
  simp_alive_peephole
  sorry
def foo1_and_commuted_logical_combined := [llvmfunc|
  llvm.func @foo1_and_commuted_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %4 = llvm.freeze %3 : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.and %1, %5  : i32
    %7 = llvm.icmp "ne" %6, %5 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_foo1_and_commuted_logical   : foo1_and_commuted_logical_before  ⊑  foo1_and_commuted_logical_combined := by
  unfold foo1_and_commuted_logical_before foo1_and_commuted_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_commuted_vector_combined := [llvmfunc|
  llvm.func @foo1_and_commuted_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : vector<2xi32>
    %3 = llvm.shl %0, %arg2 overflow<nuw>  : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    %5 = llvm.and %1, %4  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %4 : vector<2xi32>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_foo1_and_commuted_vector   : foo1_and_commuted_vector_before  ⊑  foo1_and_commuted_vector_combined := by
  unfold foo1_and_commuted_vector_before foo1_and_commuted_vector_combined
  simp_alive_peephole
  sorry
def or_consts_combined := [llvmfunc|
  llvm.func @or_consts(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_or_consts   : or_consts_before  ⊑  or_consts_combined := by
  unfold or_consts_before or_consts_combined
  simp_alive_peephole
  sorry
def or_consts_logical_combined := [llvmfunc|
  llvm.func @or_consts_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_or_consts_logical   : or_consts_logical_before  ⊑  or_consts_logical_combined := by
  unfold or_consts_logical_before or_consts_logical_combined
  simp_alive_peephole
  sorry
def or_consts_vector_combined := [llvmfunc|
  llvm.func @or_consts_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_or_consts_vector   : or_consts_vector_before  ⊑  or_consts_vector_combined := by
  unfold or_consts_vector_before or_consts_vector_combined
  simp_alive_peephole
  sorry
def foo1_or_combined := [llvmfunc|
  llvm.func @foo1_or(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_foo1_or   : foo1_or_before  ⊑  foo1_or_combined := by
  unfold foo1_or_before foo1_or_combined
  simp_alive_peephole
  sorry
def foo1_or_logical_combined := [llvmfunc|
  llvm.func @foo1_or_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %3 = llvm.freeze %2 : i32
    %4 = llvm.or %1, %3  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %4 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_foo1_or_logical   : foo1_or_logical_before  ⊑  foo1_or_logical_combined := by
  unfold foo1_or_logical_before foo1_or_logical_combined
  simp_alive_peephole
  sorry
def foo1_or_vector_combined := [llvmfunc|
  llvm.func @foo1_or_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : vector<2xi32>
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : vector<2xi32>
    %3 = llvm.or %1, %2  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %3 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_foo1_or_vector   : foo1_or_vector_before  ⊑  foo1_or_vector_combined := by
  unfold foo1_or_vector_before foo1_or_vector_combined
  simp_alive_peephole
  sorry
def foo1_or_commuted_combined := [llvmfunc|
  llvm.func @foo1_or_commuted(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.and %1, %4  : i32
    %6 = llvm.icmp "eq" %5, %4 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_foo1_or_commuted   : foo1_or_commuted_before  ⊑  foo1_or_commuted_combined := by
  unfold foo1_or_commuted_before foo1_or_commuted_combined
  simp_alive_peephole
  sorry
def foo1_or_commuted_logical_combined := [llvmfunc|
  llvm.func @foo1_or_commuted_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %4 = llvm.freeze %3 : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.and %1, %5  : i32
    %7 = llvm.icmp "eq" %6, %5 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_foo1_or_commuted_logical   : foo1_or_commuted_logical_before  ⊑  foo1_or_commuted_logical_combined := by
  unfold foo1_or_commuted_logical_before foo1_or_commuted_logical_combined
  simp_alive_peephole
  sorry
def foo1_or_commuted_vector_combined := [llvmfunc|
  llvm.func @foo1_or_commuted_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : vector<2xi32>
    %3 = llvm.shl %0, %arg2 overflow<nuw>  : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    %5 = llvm.and %1, %4  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %4 : vector<2xi32>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_foo1_or_commuted_vector   : foo1_or_commuted_vector_before  ⊑  foo1_or_commuted_vector_combined := by
  unfold foo1_or_commuted_vector_before foo1_or_commuted_vector_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.lshr %1, %arg2  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %4 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr   : foo1_and_signbit_lshr_before  ⊑  foo1_and_signbit_lshr_combined := by
  unfold foo1_and_signbit_lshr_before foo1_and_signbit_lshr_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_logical_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.lshr %1, %arg2  : i32
    %4 = llvm.freeze %3 : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.and %5, %arg0  : i32
    %7 = llvm.icmp "ne" %6, %5 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_logical   : foo1_and_signbit_lshr_logical_before  ⊑  foo1_and_signbit_lshr_logical_combined := by
  unfold foo1_and_signbit_lshr_logical_before foo1_and_signbit_lshr_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_vector_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : vector<2xi32>
    %3 = llvm.lshr %1, %arg2  : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    %5 = llvm.and %4, %arg0  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %4 : vector<2xi32>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_foo1_and_signbit_lshr_vector   : foo1_and_signbit_lshr_vector_before  ⊑  foo1_and_signbit_lshr_vector_combined := by
  unfold foo1_and_signbit_lshr_vector_before foo1_and_signbit_lshr_vector_combined
  simp_alive_peephole
  sorry
def foo1_or_signbit_lshr_combined := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.lshr %1, %arg2  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %4 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_foo1_or_signbit_lshr   : foo1_or_signbit_lshr_before  ⊑  foo1_or_signbit_lshr_combined := by
  unfold foo1_or_signbit_lshr_before foo1_or_signbit_lshr_combined
  simp_alive_peephole
  sorry
def foo1_or_signbit_lshr_logical_combined := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.lshr %1, %arg2  : i32
    %4 = llvm.freeze %3 : i32
    %5 = llvm.or %2, %4  : i32
    %6 = llvm.and %5, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %5 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_foo1_or_signbit_lshr_logical   : foo1_or_signbit_lshr_logical_before  ⊑  foo1_or_signbit_lshr_logical_combined := by
  unfold foo1_or_signbit_lshr_logical_before foo1_or_signbit_lshr_logical_combined
  simp_alive_peephole
  sorry
def foo1_or_signbit_lshr_vector_combined := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : vector<2xi32>
    %3 = llvm.lshr %1, %arg2  : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    %5 = llvm.and %4, %arg0  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %4 : vector<2xi32>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_foo1_or_signbit_lshr_vector   : foo1_or_signbit_lshr_vector_before  ⊑  foo1_or_signbit_lshr_vector_combined := by
  unfold foo1_or_signbit_lshr_vector_before foo1_or_signbit_lshr_vector_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit   : foo1_and_signbit_lshr_without_shifting_signbit_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_before foo1_and_signbit_lshr_without_shifting_signbit_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_logical_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_logical   : foo1_and_signbit_lshr_without_shifting_signbit_logical_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_logical_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_logical_before foo1_and_signbit_lshr_without_shifting_signbit_logical_combined
  simp_alive_peephole
  sorry
def foo1_or_signbit_lshr_without_shifting_signbit_combined := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.shl %arg0, %arg2  : i32
    %6 = llvm.icmp "slt" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_foo1_or_signbit_lshr_without_shifting_signbit   : foo1_or_signbit_lshr_without_shifting_signbit_before  ⊑  foo1_or_signbit_lshr_without_shifting_signbit_combined := by
  unfold foo1_or_signbit_lshr_without_shifting_signbit_before foo1_or_signbit_lshr_without_shifting_signbit_combined
  simp_alive_peephole
  sorry
def foo1_or_signbit_lshr_without_shifting_signbit_logical_combined := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "slt" %6, %1 : i32
    %8 = llvm.select %5, %7, %2 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_foo1_or_signbit_lshr_without_shifting_signbit_logical   : foo1_or_signbit_lshr_without_shifting_signbit_logical_before  ⊑  foo1_or_signbit_lshr_without_shifting_signbit_logical_combined := by
  unfold foo1_or_signbit_lshr_without_shifting_signbit_logical_before foo1_or_signbit_lshr_without_shifting_signbit_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_both_sides_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_both_sides(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.shl %arg0, %arg2  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_both_sides   : foo1_and_signbit_lshr_without_shifting_signbit_both_sides_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_both_sides_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_both_sides_before foo1_and_signbit_lshr_without_shifting_signbit_both_sides_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_both_sides_logical_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_both_sides_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.shl %arg0, %arg2  : i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.select %3, %1, %5 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_both_sides_logical   : foo1_and_signbit_lshr_without_shifting_signbit_both_sides_logical_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_both_sides_logical_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_both_sides_logical_before foo1_and_signbit_lshr_without_shifting_signbit_both_sides_logical_combined
  simp_alive_peephole
  sorry
def foo1_or_signbit_lshr_without_shifting_signbit_both_sides_combined := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit_both_sides(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.shl %arg0, %arg2  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_foo1_or_signbit_lshr_without_shifting_signbit_both_sides   : foo1_or_signbit_lshr_without_shifting_signbit_both_sides_before  ⊑  foo1_or_signbit_lshr_without_shifting_signbit_both_sides_combined := by
  unfold foo1_or_signbit_lshr_without_shifting_signbit_both_sides_before foo1_or_signbit_lshr_without_shifting_signbit_both_sides_combined
  simp_alive_peephole
  sorry
def foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat_combined := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %arg1  : vector<2xi32>
    %3 = llvm.shl %arg0, %arg2  : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi32>
    %5 = llvm.icmp "slt" %4, %1 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat   : foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat_before  ⊑  foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat_combined := by
  unfold foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat_before foo1_or_signbit_lshr_without_shifting_signbit_both_sides_splat_combined
  simp_alive_peephole
  sorry
def foo1_or_signbit_lshr_without_shifting_signbit_both_sides_logical_combined := [llvmfunc|
  llvm.func @foo1_or_signbit_lshr_without_shifting_signbit_both_sides_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.shl %arg0, %arg2  : i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %3, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_foo1_or_signbit_lshr_without_shifting_signbit_both_sides_logical   : foo1_or_signbit_lshr_without_shifting_signbit_both_sides_logical_before  ⊑  foo1_or_signbit_lshr_without_shifting_signbit_both_sides_logical_combined := by
  unfold foo1_or_signbit_lshr_without_shifting_signbit_both_sides_logical_before foo1_or_signbit_lshr_without_shifting_signbit_both_sides_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_extra_use_shl_combined := [llvmfunc|
  llvm.func @foo1_and_extra_use_shl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    llvm.store %1, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_extra_use_shl   : foo1_and_extra_use_shl_before  ⊑  foo1_and_extra_use_shl_combined := by
  unfold foo1_and_extra_use_shl_before foo1_and_extra_use_shl_combined
  simp_alive_peephole
  sorry
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "ne" %4, %3 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_foo1_and_extra_use_shl   : foo1_and_extra_use_shl_before  ⊑  foo1_and_extra_use_shl_combined := by
  unfold foo1_and_extra_use_shl_before foo1_and_extra_use_shl_combined
  simp_alive_peephole
  sorry
def foo1_and_extra_use_shl_logical_combined := [llvmfunc|
  llvm.func @foo1_and_extra_use_shl_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    llvm.store %1, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_extra_use_shl_logical   : foo1_and_extra_use_shl_logical_before  ⊑  foo1_and_extra_use_shl_logical_combined := by
  unfold foo1_and_extra_use_shl_logical_before foo1_and_extra_use_shl_logical_combined
  simp_alive_peephole
  sorry
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %3 = llvm.freeze %2 : i32
    %4 = llvm.or %1, %3  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %4 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_foo1_and_extra_use_shl_logical   : foo1_and_extra_use_shl_logical_before  ⊑  foo1_and_extra_use_shl_logical_combined := by
  unfold foo1_and_extra_use_shl_logical_before foo1_and_extra_use_shl_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_extra_use_and_combined := [llvmfunc|
  llvm.func @foo1_and_extra_use_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %3 = llvm.and %1, %arg0  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_extra_use_and   : foo1_and_extra_use_and_before  ⊑  foo1_and_extra_use_and_combined := by
  unfold foo1_and_extra_use_and_before foo1_and_extra_use_and_combined
  simp_alive_peephole
  sorry
    %4 = llvm.or %1, %2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %4 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_foo1_and_extra_use_and   : foo1_and_extra_use_and_before  ⊑  foo1_and_extra_use_and_combined := by
  unfold foo1_and_extra_use_and_before foo1_and_extra_use_and_combined
  simp_alive_peephole
  sorry
def foo1_and_extra_use_and_logical_combined := [llvmfunc|
  llvm.func @foo1_and_extra_use_and_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %3 = llvm.and %1, %arg0  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_extra_use_and_logical   : foo1_and_extra_use_and_logical_before  ⊑  foo1_and_extra_use_and_logical_combined := by
  unfold foo1_and_extra_use_and_logical_before foo1_and_extra_use_and_logical_combined
  simp_alive_peephole
  sorry
    %4 = llvm.freeze %2 : i32
    %5 = llvm.or %1, %4  : i32
    %6 = llvm.and %5, %arg0  : i32
    %7 = llvm.icmp "ne" %6, %5 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_foo1_and_extra_use_and_logical   : foo1_and_extra_use_and_logical_before  ⊑  foo1_and_extra_use_and_logical_combined := by
  unfold foo1_and_extra_use_and_logical_before foo1_and_extra_use_and_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_extra_use_cmp_combined := [llvmfunc|
  llvm.func @foo1_and_extra_use_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.store %5, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_foo1_and_extra_use_cmp   : foo1_and_extra_use_cmp_before  ⊑  foo1_and_extra_use_cmp_combined := by
  unfold foo1_and_extra_use_cmp_before foo1_and_extra_use_cmp_combined
  simp_alive_peephole
  sorry
    %6 = llvm.or %2, %3  : i32
    %7 = llvm.and %6, %arg0  : i32
    %8 = llvm.icmp "ne" %7, %6 : i32
    llvm.return %8 : i1
  }]

theorem inst_combine_foo1_and_extra_use_cmp   : foo1_and_extra_use_cmp_before  ⊑  foo1_and_extra_use_cmp_combined := by
  unfold foo1_and_extra_use_cmp_before foo1_and_extra_use_cmp_combined
  simp_alive_peephole
  sorry
def foo1_and_extra_use_cmp_logical_combined := [llvmfunc|
  llvm.func @foo1_and_extra_use_cmp_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.store %5, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_foo1_and_extra_use_cmp_logical   : foo1_and_extra_use_cmp_logical_before  ⊑  foo1_and_extra_use_cmp_logical_combined := by
  unfold foo1_and_extra_use_cmp_logical_before foo1_and_extra_use_cmp_logical_combined
  simp_alive_peephole
  sorry
    %6 = llvm.freeze %3 : i32
    %7 = llvm.or %2, %6  : i32
    %8 = llvm.and %7, %arg0  : i32
    %9 = llvm.icmp "ne" %8, %7 : i32
    llvm.return %9 : i1
  }]

theorem inst_combine_foo1_and_extra_use_cmp_logical   : foo1_and_extra_use_cmp_logical_before  ⊑  foo1_and_extra_use_cmp_logical_combined := by
  unfold foo1_and_extra_use_cmp_logical_before foo1_and_extra_use_cmp_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_extra_use_shl2_combined := [llvmfunc|
  llvm.func @foo1_and_extra_use_shl2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    llvm.store %2, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_extra_use_shl2   : foo1_and_extra_use_shl2_before  ⊑  foo1_and_extra_use_shl2_combined := by
  unfold foo1_and_extra_use_shl2_before foo1_and_extra_use_shl2_combined
  simp_alive_peephole
  sorry
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "ne" %4, %3 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_foo1_and_extra_use_shl2   : foo1_and_extra_use_shl2_before  ⊑  foo1_and_extra_use_shl2_combined := by
  unfold foo1_and_extra_use_shl2_before foo1_and_extra_use_shl2_combined
  simp_alive_peephole
  sorry
def foo1_and_extra_use_shl2_logical_combined := [llvmfunc|
  llvm.func @foo1_and_extra_use_shl2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %3 = llvm.freeze %2 : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_extra_use_shl2_logical   : foo1_and_extra_use_shl2_logical_before  ⊑  foo1_and_extra_use_shl2_logical_combined := by
  unfold foo1_and_extra_use_shl2_logical_before foo1_and_extra_use_shl2_logical_combined
  simp_alive_peephole
  sorry
    %4 = llvm.or %1, %3  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %4 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_foo1_and_extra_use_shl2_logical   : foo1_and_extra_use_shl2_logical_before  ⊑  foo1_and_extra_use_shl2_logical_combined := by
  unfold foo1_and_extra_use_shl2_logical_before foo1_and_extra_use_shl2_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_extra_use_and2_combined := [llvmfunc|
  llvm.func @foo1_and_extra_use_and2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_extra_use_and2   : foo1_and_extra_use_and2_before  ⊑  foo1_and_extra_use_and2_combined := by
  unfold foo1_and_extra_use_and2_before foo1_and_extra_use_and2_combined
  simp_alive_peephole
  sorry
    %4 = llvm.or %1, %2  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %4 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_foo1_and_extra_use_and2   : foo1_and_extra_use_and2_before  ⊑  foo1_and_extra_use_and2_combined := by
  unfold foo1_and_extra_use_and2_before foo1_and_extra_use_and2_combined
  simp_alive_peephole
  sorry
def foo1_and_extra_use_and2_logical_combined := [llvmfunc|
  llvm.func @foo1_and_extra_use_and2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %2 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %3 = llvm.freeze %2 : i32
    %4 = llvm.and %3, %arg0  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_extra_use_and2_logical   : foo1_and_extra_use_and2_logical_before  ⊑  foo1_and_extra_use_and2_logical_combined := by
  unfold foo1_and_extra_use_and2_logical_before foo1_and_extra_use_and2_logical_combined
  simp_alive_peephole
  sorry
    %5 = llvm.or %1, %3  : i32
    %6 = llvm.and %5, %arg0  : i32
    %7 = llvm.icmp "ne" %6, %5 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_foo1_and_extra_use_and2_logical   : foo1_and_extra_use_and2_logical_before  ⊑  foo1_and_extra_use_and2_logical_combined := by
  unfold foo1_and_extra_use_and2_logical_before foo1_and_extra_use_and2_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_extra_use_cmp2_combined := [llvmfunc|
  llvm.func @foo1_and_extra_use_cmp2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.store %5, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_foo1_and_extra_use_cmp2   : foo1_and_extra_use_cmp2_before  ⊑  foo1_and_extra_use_cmp2_combined := by
  unfold foo1_and_extra_use_cmp2_before foo1_and_extra_use_cmp2_combined
  simp_alive_peephole
  sorry
    %6 = llvm.or %2, %3  : i32
    %7 = llvm.and %6, %arg0  : i32
    %8 = llvm.icmp "ne" %7, %6 : i32
    llvm.return %8 : i1
  }]

theorem inst_combine_foo1_and_extra_use_cmp2   : foo1_and_extra_use_cmp2_before  ⊑  foo1_and_extra_use_cmp2_combined := by
  unfold foo1_and_extra_use_cmp2_before foo1_and_extra_use_cmp2_combined
  simp_alive_peephole
  sorry
def foo1_and_extra_use_cmp2_logical_combined := [llvmfunc|
  llvm.func @foo1_and_extra_use_cmp2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.shl %0, %arg2 overflow<nuw>  : i32
    %4 = llvm.freeze %3 : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.store %6, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_foo1_and_extra_use_cmp2_logical   : foo1_and_extra_use_cmp2_logical_before  ⊑  foo1_and_extra_use_cmp2_logical_combined := by
  unfold foo1_and_extra_use_cmp2_logical_before foo1_and_extra_use_cmp2_logical_combined
  simp_alive_peephole
  sorry
    %7 = llvm.or %2, %4  : i32
    %8 = llvm.and %7, %arg0  : i32
    %9 = llvm.icmp "ne" %8, %7 : i32
    llvm.return %9 : i1
  }]

theorem inst_combine_foo1_and_extra_use_cmp2_logical   : foo1_and_extra_use_cmp2_logical_before  ⊑  foo1_and_extra_use_cmp2_logical_combined := by
  unfold foo1_and_extra_use_cmp2_logical_before foo1_and_extra_use_cmp2_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    llvm.store %3, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_combined
  simp_alive_peephole
  sorry
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical_combined
  simp_alive_peephole
  sorry
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl1_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %4 = llvm.and %3, %arg0  : i32
    llvm.store %4, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_combined
  simp_alive_peephole
  sorry
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %5 = llvm.and %4, %arg0  : i32
    llvm.store %5, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical_combined
  simp_alive_peephole
  sorry
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_and_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.store %5, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_combined
  simp_alive_peephole
  sorry
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.store %6, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical_combined
  simp_alive_peephole
  sorry
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp1_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    llvm.store %6, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_combined
  simp_alive_peephole
  sorry
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    llvm.store %7, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical_combined
  simp_alive_peephole
  sorry
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_shl2_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    llvm.store %7, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_combined
  simp_alive_peephole
  sorry
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.store %8, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical_combined
  simp_alive_peephole
  sorry
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical   : foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical_before foo1_and_signbit_lshr_without_shifting_signbit_extra_use_cmp2_logical_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.shl %0, %arg1  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %arg2  : i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2   : foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_before foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_combined
  simp_alive_peephole
  sorry
def foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_logical_combined := [llvmfunc|
  llvm.func @foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.shl %0, %arg1  : i32
    %5 = llvm.and %4, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.shl %arg0, %arg2  : i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    llvm.return %9 : i1
  }]

theorem inst_combine_foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_logical   : foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_logical_before  ⊑  foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_logical_combined := by
  unfold foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_logical_before foo1_and_signbit_lshr_without_shifting_signbit_not_pwr2_logical_combined
  simp_alive_peephole
  sorry
