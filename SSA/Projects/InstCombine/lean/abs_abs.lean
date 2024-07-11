import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  abs_abs
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def abs_abs_x01_before := [llvmfunc|
  llvm.func @abs_abs_x01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def abs_abs_x01_vec_before := [llvmfunc|
  llvm.func @abs_abs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %4 = llvm.sub %2, %arg0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.select %3, %arg0, %4 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %0 : vector<2xi32>
    %7 = llvm.sub %2, %5 overflow<nsw>  : vector<2xi32>
    %8 = llvm.select %6, %5, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def abs_abs_x02_before := [llvmfunc|
  llvm.func @abs_abs_x02(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def abs_abs_x03_before := [llvmfunc|
  llvm.func @abs_abs_x03(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def abs_abs_x04_before := [llvmfunc|
  llvm.func @abs_abs_x04(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    %6 = llvm.icmp "sgt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %5, %7 : i1, i32
    llvm.return %8 : i32
  }]

def abs_abs_x04_vec_before := [llvmfunc|
  llvm.func @abs_abs_x04_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %5 = llvm.sub %2, %arg0 overflow<nsw>  : vector<2xi32>
    %6 = llvm.select %4, %5, %arg0 : vector<2xi1>, vector<2xi32>
    %7 = llvm.icmp "sgt" %6, %3 : vector<2xi32>
    %8 = llvm.sub %2, %6 overflow<nsw>  : vector<2xi32>
    %9 = llvm.select %7, %6, %8 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }]

def abs_abs_x05_before := [llvmfunc|
  llvm.func @abs_abs_x05(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def abs_abs_x06_before := [llvmfunc|
  llvm.func @abs_abs_x06(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }]

def abs_abs_x07_before := [llvmfunc|
  llvm.func @abs_abs_x07(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }]

def abs_abs_x08_before := [llvmfunc|
  llvm.func @abs_abs_x08(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def abs_abs_x09_before := [llvmfunc|
  llvm.func @abs_abs_x09(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def abs_abs_x10_before := [llvmfunc|
  llvm.func @abs_abs_x10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }]

def abs_abs_x11_before := [llvmfunc|
  llvm.func @abs_abs_x11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }]

def abs_abs_x12_before := [llvmfunc|
  llvm.func @abs_abs_x12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def abs_abs_x13_before := [llvmfunc|
  llvm.func @abs_abs_x13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %arg0, %4 : i1, i32
    %6 = llvm.icmp "slt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %7, %5 : i1, i32
    llvm.return %8 : i32
  }]

def abs_abs_x14_before := [llvmfunc|
  llvm.func @abs_abs_x14(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def abs_abs_x15_before := [llvmfunc|
  llvm.func @abs_abs_x15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def abs_abs_x16_before := [llvmfunc|
  llvm.func @abs_abs_x16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def abs_abs_x17_before := [llvmfunc|
  llvm.func @abs_abs_x17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def abs_abs_x18_before := [llvmfunc|
  llvm.func @abs_abs_x18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %4 = llvm.icmp "sgt" %2, %0 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    %6 = llvm.icmp "sgt" %5, %0 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %5, %7 : i1, i32
    llvm.return %8 : i32
  }]

def abs_abs_x02_vec_before := [llvmfunc|
  llvm.func @abs_abs_x02_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi32>
    %4 = llvm.icmp "sgt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %3, %arg0 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %2 : vector<2xi32>
    %7 = llvm.sub %1, %5 overflow<nsw>  : vector<2xi32>
    %8 = llvm.select %6, %5, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def abs_abs_x03_vec_before := [llvmfunc|
  llvm.func @abs_abs_x03_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.icmp "sgt" %3, %0 : vector<2xi32>
    %6 = llvm.select %5, %3, %4 : vector<2xi1>, vector<2xi32>
    %7 = llvm.icmp "sgt" %6, %0 : vector<2xi32>
    %8 = llvm.sub %2, %6 overflow<nsw>  : vector<2xi32>
    %9 = llvm.select %7, %6, %8 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }]

def nabs_nabs_x01_before := [llvmfunc|
  llvm.func @nabs_nabs_x01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_nabs_x02_before := [llvmfunc|
  llvm.func @nabs_nabs_x02(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_nabs_x03_before := [llvmfunc|
  llvm.func @nabs_nabs_x03(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_nabs_x04_before := [llvmfunc|
  llvm.func @nabs_nabs_x04(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %arg0, %4 : i1, i32
    %6 = llvm.icmp "sgt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %7, %5 : i1, i32
    llvm.return %8 : i32
  }]

def nabs_nabs_x05_before := [llvmfunc|
  llvm.func @nabs_nabs_x05(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_nabs_x06_before := [llvmfunc|
  llvm.func @nabs_nabs_x06(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }]

def nabs_nabs_x07_before := [llvmfunc|
  llvm.func @nabs_nabs_x07(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }]

def nabs_nabs_x08_before := [llvmfunc|
  llvm.func @nabs_nabs_x08(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_nabs_x09_before := [llvmfunc|
  llvm.func @nabs_nabs_x09(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_nabs_x10_before := [llvmfunc|
  llvm.func @nabs_nabs_x10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }]

def nabs_nabs_x11_before := [llvmfunc|
  llvm.func @nabs_nabs_x11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }]

def nabs_nabs_x12_before := [llvmfunc|
  llvm.func @nabs_nabs_x12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_nabs_x13_before := [llvmfunc|
  llvm.func @nabs_nabs_x13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    %6 = llvm.icmp "slt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %5, %7 : i1, i32
    llvm.return %8 : i32
  }]

def nabs_nabs_x14_before := [llvmfunc|
  llvm.func @nabs_nabs_x14(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_nabs_x15_before := [llvmfunc|
  llvm.func @nabs_nabs_x15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_nabs_x16_before := [llvmfunc|
  llvm.func @nabs_nabs_x16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_nabs_x17_before := [llvmfunc|
  llvm.func @nabs_nabs_x17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %arg0, %2 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_nabs_x18_before := [llvmfunc|
  llvm.func @nabs_nabs_x18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %4 = llvm.icmp "sgt" %2, %0 : i32
    %5 = llvm.select %4, %3, %2 : i1, i32
    %6 = llvm.icmp "sgt" %5, %0 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %7, %5 : i1, i32
    llvm.return %8 : i32
  }]

def nabs_nabs_x01_vec_before := [llvmfunc|
  llvm.func @nabs_nabs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi32>
    %4 = llvm.icmp "sgt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %arg0, %3 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %2 : vector<2xi32>
    %7 = llvm.sub %1, %5 overflow<nsw>  : vector<2xi32>
    %8 = llvm.select %6, %7, %5 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def nabs_nabs_x02_vec_before := [llvmfunc|
  llvm.func @nabs_nabs_x02_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.icmp "sgt" %3, %0 : vector<2xi32>
    %6 = llvm.select %5, %4, %3 : vector<2xi1>, vector<2xi32>
    %7 = llvm.icmp "sgt" %6, %0 : vector<2xi32>
    %8 = llvm.sub %2, %6 overflow<nsw>  : vector<2xi32>
    %9 = llvm.select %7, %8, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }]

def abs_nabs_x01_before := [llvmfunc|
  llvm.func @abs_nabs_x01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def abs_nabs_x02_before := [llvmfunc|
  llvm.func @abs_nabs_x02(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def abs_nabs_x03_before := [llvmfunc|
  llvm.func @abs_nabs_x03(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def abs_nabs_x04_before := [llvmfunc|
  llvm.func @abs_nabs_x04(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %arg0, %4 : i1, i32
    %6 = llvm.icmp "sgt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %5, %7 : i1, i32
    llvm.return %8 : i32
  }]

def abs_nabs_x05_before := [llvmfunc|
  llvm.func @abs_nabs_x05(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def abs_nabs_x06_before := [llvmfunc|
  llvm.func @abs_nabs_x06(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }]

def abs_nabs_x07_before := [llvmfunc|
  llvm.func @abs_nabs_x07(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }]

def abs_nabs_x08_before := [llvmfunc|
  llvm.func @abs_nabs_x08(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def abs_nabs_x09_before := [llvmfunc|
  llvm.func @abs_nabs_x09(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def abs_nabs_x10_before := [llvmfunc|
  llvm.func @abs_nabs_x10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }]

def abs_nabs_x11_before := [llvmfunc|
  llvm.func @abs_nabs_x11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }]

def abs_nabs_x12_before := [llvmfunc|
  llvm.func @abs_nabs_x12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def abs_nabs_x13_before := [llvmfunc|
  llvm.func @abs_nabs_x13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    %6 = llvm.icmp "slt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %7, %5 : i1, i32
    llvm.return %8 : i32
  }]

def abs_nabs_x14_before := [llvmfunc|
  llvm.func @abs_nabs_x14(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def abs_nabs_x15_before := [llvmfunc|
  llvm.func @abs_nabs_x15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def abs_nabs_x16_before := [llvmfunc|
  llvm.func @abs_nabs_x16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def abs_nabs_x17_before := [llvmfunc|
  llvm.func @abs_nabs_x17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %arg0, %2 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def abs_nabs_x18_before := [llvmfunc|
  llvm.func @abs_nabs_x18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %4 = llvm.icmp "sgt" %2, %0 : i32
    %5 = llvm.select %4, %3, %2 : i1, i32
    %6 = llvm.icmp "sgt" %5, %0 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %5, %7 : i1, i32
    llvm.return %8 : i32
  }]

def abs_nabs_x01_vec_before := [llvmfunc|
  llvm.func @abs_nabs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi32>
    %4 = llvm.icmp "sgt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %arg0, %3 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %2 : vector<2xi32>
    %7 = llvm.sub %1, %5 overflow<nsw>  : vector<2xi32>
    %8 = llvm.select %6, %5, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def abs_nabs_x02_vec_before := [llvmfunc|
  llvm.func @abs_nabs_x02_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.icmp "sgt" %3, %0 : vector<2xi32>
    %6 = llvm.select %5, %4, %3 : vector<2xi1>, vector<2xi32>
    %7 = llvm.icmp "sgt" %6, %0 : vector<2xi32>
    %8 = llvm.sub %2, %6 overflow<nsw>  : vector<2xi32>
    %9 = llvm.select %7, %6, %8 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }]

def nabs_abs_x01_before := [llvmfunc|
  llvm.func @nabs_abs_x01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_abs_x02_before := [llvmfunc|
  llvm.func @nabs_abs_x02(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_abs_x03_before := [llvmfunc|
  llvm.func @nabs_abs_x03(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_abs_x04_before := [llvmfunc|
  llvm.func @nabs_abs_x04(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    %6 = llvm.icmp "sgt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %7, %5 : i1, i32
    llvm.return %8 : i32
  }]

def nabs_abs_x05_before := [llvmfunc|
  llvm.func @nabs_abs_x05(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_abs_x06_before := [llvmfunc|
  llvm.func @nabs_abs_x06(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }]

def nabs_abs_x07_before := [llvmfunc|
  llvm.func @nabs_abs_x07(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }]

def nabs_abs_x08_before := [llvmfunc|
  llvm.func @nabs_abs_x08(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_abs_x09_before := [llvmfunc|
  llvm.func @nabs_abs_x09(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_abs_x10_before := [llvmfunc|
  llvm.func @nabs_abs_x10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %arg0, %2 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }]

def nabs_abs_x11_before := [llvmfunc|
  llvm.func @nabs_abs_x11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.select %1, %2, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %3, %5 : i1, i32
    llvm.return %6 : i32
  }]

def nabs_abs_x12_before := [llvmfunc|
  llvm.func @nabs_abs_x12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_abs_x13_before := [llvmfunc|
  llvm.func @nabs_abs_x13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %arg0, %4 : i1, i32
    %6 = llvm.icmp "slt" %5, %2 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %5, %7 : i1, i32
    llvm.return %8 : i32
  }]

def nabs_abs_x14_before := [llvmfunc|
  llvm.func @nabs_abs_x14(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %arg0, %3 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_abs_x15_before := [llvmfunc|
  llvm.func @nabs_abs_x15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_abs_x16_before := [llvmfunc|
  llvm.func @nabs_abs_x16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.select %2, %3, %arg0 : i1, i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.sub %1, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_abs_x17_before := [llvmfunc|
  llvm.func @nabs_abs_x17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    %6 = llvm.sub %0, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }]

def nabs_abs_x18_before := [llvmfunc|
  llvm.func @nabs_abs_x18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %4 = llvm.icmp "sgt" %2, %0 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    %6 = llvm.icmp "sgt" %5, %0 : i32
    %7 = llvm.sub %1, %5 overflow<nsw>  : i32
    %8 = llvm.select %6, %7, %5 : i1, i32
    llvm.return %8 : i32
  }]

def nabs_abs_x01_vec_before := [llvmfunc|
  llvm.func @nabs_abs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi32>
    %4 = llvm.icmp "sgt" %3, %2 : vector<2xi32>
    %5 = llvm.select %4, %3, %arg0 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %2 : vector<2xi32>
    %7 = llvm.sub %1, %5 overflow<nsw>  : vector<2xi32>
    %8 = llvm.select %6, %7, %5 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def nabs_abs_x02_vec_before := [llvmfunc|
  llvm.func @nabs_abs_x02_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<2xi32>
    %5 = llvm.icmp "sgt" %3, %0 : vector<2xi32>
    %6 = llvm.select %5, %3, %4 : vector<2xi1>, vector<2xi32>
    %7 = llvm.icmp "sgt" %6, %0 : vector<2xi32>
    %8 = llvm.sub %2, %6 overflow<nsw>  : vector<2xi32>
    %9 = llvm.select %7, %8, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }]

def abs_abs_x01_combined := [llvmfunc|
  llvm.func @abs_abs_x01(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x01   : abs_abs_x01_before  ⊑  abs_abs_x01_combined := by
  unfold abs_abs_x01_before abs_abs_x01_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x01   : abs_abs_x01_before  ⊑  abs_abs_x01_combined := by
  unfold abs_abs_x01_before abs_abs_x01_combined
  simp_alive_peephole
  sorry
def abs_abs_x01_vec_combined := [llvmfunc|
  llvm.func @abs_abs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_abs_abs_x01_vec   : abs_abs_x01_vec_before  ⊑  abs_abs_x01_vec_combined := by
  unfold abs_abs_x01_vec_before abs_abs_x01_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_abs_abs_x01_vec   : abs_abs_x01_vec_before  ⊑  abs_abs_x01_vec_combined := by
  unfold abs_abs_x01_vec_before abs_abs_x01_vec_combined
  simp_alive_peephole
  sorry
def abs_abs_x02_combined := [llvmfunc|
  llvm.func @abs_abs_x02(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x02   : abs_abs_x02_before  ⊑  abs_abs_x02_combined := by
  unfold abs_abs_x02_before abs_abs_x02_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x02   : abs_abs_x02_before  ⊑  abs_abs_x02_combined := by
  unfold abs_abs_x02_before abs_abs_x02_combined
  simp_alive_peephole
  sorry
def abs_abs_x03_combined := [llvmfunc|
  llvm.func @abs_abs_x03(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x03   : abs_abs_x03_before  ⊑  abs_abs_x03_combined := by
  unfold abs_abs_x03_before abs_abs_x03_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x03   : abs_abs_x03_before  ⊑  abs_abs_x03_combined := by
  unfold abs_abs_x03_before abs_abs_x03_combined
  simp_alive_peephole
  sorry
def abs_abs_x04_combined := [llvmfunc|
  llvm.func @abs_abs_x04(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x04   : abs_abs_x04_before  ⊑  abs_abs_x04_combined := by
  unfold abs_abs_x04_before abs_abs_x04_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x04   : abs_abs_x04_before  ⊑  abs_abs_x04_combined := by
  unfold abs_abs_x04_before abs_abs_x04_combined
  simp_alive_peephole
  sorry
def abs_abs_x04_vec_combined := [llvmfunc|
  llvm.func @abs_abs_x04_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_abs_abs_x04_vec   : abs_abs_x04_vec_before  ⊑  abs_abs_x04_vec_combined := by
  unfold abs_abs_x04_vec_before abs_abs_x04_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_abs_abs_x04_vec   : abs_abs_x04_vec_before  ⊑  abs_abs_x04_vec_combined := by
  unfold abs_abs_x04_vec_before abs_abs_x04_vec_combined
  simp_alive_peephole
  sorry
def abs_abs_x05_combined := [llvmfunc|
  llvm.func @abs_abs_x05(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x05   : abs_abs_x05_before  ⊑  abs_abs_x05_combined := by
  unfold abs_abs_x05_before abs_abs_x05_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x05   : abs_abs_x05_before  ⊑  abs_abs_x05_combined := by
  unfold abs_abs_x05_before abs_abs_x05_combined
  simp_alive_peephole
  sorry
def abs_abs_x06_combined := [llvmfunc|
  llvm.func @abs_abs_x06(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x06   : abs_abs_x06_before  ⊑  abs_abs_x06_combined := by
  unfold abs_abs_x06_before abs_abs_x06_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x06   : abs_abs_x06_before  ⊑  abs_abs_x06_combined := by
  unfold abs_abs_x06_before abs_abs_x06_combined
  simp_alive_peephole
  sorry
def abs_abs_x07_combined := [llvmfunc|
  llvm.func @abs_abs_x07(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x07   : abs_abs_x07_before  ⊑  abs_abs_x07_combined := by
  unfold abs_abs_x07_before abs_abs_x07_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x07   : abs_abs_x07_before  ⊑  abs_abs_x07_combined := by
  unfold abs_abs_x07_before abs_abs_x07_combined
  simp_alive_peephole
  sorry
def abs_abs_x08_combined := [llvmfunc|
  llvm.func @abs_abs_x08(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x08   : abs_abs_x08_before  ⊑  abs_abs_x08_combined := by
  unfold abs_abs_x08_before abs_abs_x08_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x08   : abs_abs_x08_before  ⊑  abs_abs_x08_combined := by
  unfold abs_abs_x08_before abs_abs_x08_combined
  simp_alive_peephole
  sorry
def abs_abs_x09_combined := [llvmfunc|
  llvm.func @abs_abs_x09(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x09   : abs_abs_x09_before  ⊑  abs_abs_x09_combined := by
  unfold abs_abs_x09_before abs_abs_x09_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x09   : abs_abs_x09_before  ⊑  abs_abs_x09_combined := by
  unfold abs_abs_x09_before abs_abs_x09_combined
  simp_alive_peephole
  sorry
def abs_abs_x10_combined := [llvmfunc|
  llvm.func @abs_abs_x10(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x10   : abs_abs_x10_before  ⊑  abs_abs_x10_combined := by
  unfold abs_abs_x10_before abs_abs_x10_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x10   : abs_abs_x10_before  ⊑  abs_abs_x10_combined := by
  unfold abs_abs_x10_before abs_abs_x10_combined
  simp_alive_peephole
  sorry
def abs_abs_x11_combined := [llvmfunc|
  llvm.func @abs_abs_x11(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x11   : abs_abs_x11_before  ⊑  abs_abs_x11_combined := by
  unfold abs_abs_x11_before abs_abs_x11_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x11   : abs_abs_x11_before  ⊑  abs_abs_x11_combined := by
  unfold abs_abs_x11_before abs_abs_x11_combined
  simp_alive_peephole
  sorry
def abs_abs_x12_combined := [llvmfunc|
  llvm.func @abs_abs_x12(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x12   : abs_abs_x12_before  ⊑  abs_abs_x12_combined := by
  unfold abs_abs_x12_before abs_abs_x12_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x12   : abs_abs_x12_before  ⊑  abs_abs_x12_combined := by
  unfold abs_abs_x12_before abs_abs_x12_combined
  simp_alive_peephole
  sorry
def abs_abs_x13_combined := [llvmfunc|
  llvm.func @abs_abs_x13(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x13   : abs_abs_x13_before  ⊑  abs_abs_x13_combined := by
  unfold abs_abs_x13_before abs_abs_x13_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x13   : abs_abs_x13_before  ⊑  abs_abs_x13_combined := by
  unfold abs_abs_x13_before abs_abs_x13_combined
  simp_alive_peephole
  sorry
def abs_abs_x14_combined := [llvmfunc|
  llvm.func @abs_abs_x14(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x14   : abs_abs_x14_before  ⊑  abs_abs_x14_combined := by
  unfold abs_abs_x14_before abs_abs_x14_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x14   : abs_abs_x14_before  ⊑  abs_abs_x14_combined := by
  unfold abs_abs_x14_before abs_abs_x14_combined
  simp_alive_peephole
  sorry
def abs_abs_x15_combined := [llvmfunc|
  llvm.func @abs_abs_x15(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x15   : abs_abs_x15_before  ⊑  abs_abs_x15_combined := by
  unfold abs_abs_x15_before abs_abs_x15_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x15   : abs_abs_x15_before  ⊑  abs_abs_x15_combined := by
  unfold abs_abs_x15_before abs_abs_x15_combined
  simp_alive_peephole
  sorry
def abs_abs_x16_combined := [llvmfunc|
  llvm.func @abs_abs_x16(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x16   : abs_abs_x16_before  ⊑  abs_abs_x16_combined := by
  unfold abs_abs_x16_before abs_abs_x16_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x16   : abs_abs_x16_before  ⊑  abs_abs_x16_combined := by
  unfold abs_abs_x16_before abs_abs_x16_combined
  simp_alive_peephole
  sorry
def abs_abs_x17_combined := [llvmfunc|
  llvm.func @abs_abs_x17(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_abs_x17   : abs_abs_x17_before  ⊑  abs_abs_x17_combined := by
  unfold abs_abs_x17_before abs_abs_x17_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_abs_x17   : abs_abs_x17_before  ⊑  abs_abs_x17_combined := by
  unfold abs_abs_x17_before abs_abs_x17_combined
  simp_alive_peephole
  sorry
def abs_abs_x18_combined := [llvmfunc|
  llvm.func @abs_abs_x18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_abs_x18   : abs_abs_x18_before  ⊑  abs_abs_x18_combined := by
  unfold abs_abs_x18_before abs_abs_x18_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_abs_abs_x18   : abs_abs_x18_before  ⊑  abs_abs_x18_combined := by
  unfold abs_abs_x18_before abs_abs_x18_combined
  simp_alive_peephole
  sorry
def abs_abs_x02_vec_combined := [llvmfunc|
  llvm.func @abs_abs_x02_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_abs_abs_x02_vec   : abs_abs_x02_vec_before  ⊑  abs_abs_x02_vec_combined := by
  unfold abs_abs_x02_vec_before abs_abs_x02_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_abs_abs_x02_vec   : abs_abs_x02_vec_before  ⊑  abs_abs_x02_vec_combined := by
  unfold abs_abs_x02_vec_before abs_abs_x02_vec_combined
  simp_alive_peephole
  sorry
def abs_abs_x03_vec_combined := [llvmfunc|
  llvm.func @abs_abs_x03_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_abs_abs_x03_vec   : abs_abs_x03_vec_before  ⊑  abs_abs_x03_vec_combined := by
  unfold abs_abs_x03_vec_before abs_abs_x03_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_abs_abs_x03_vec   : abs_abs_x03_vec_before  ⊑  abs_abs_x03_vec_combined := by
  unfold abs_abs_x03_vec_before abs_abs_x03_vec_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x01_combined := [llvmfunc|
  llvm.func @nabs_nabs_x01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x01   : nabs_nabs_x01_before  ⊑  nabs_nabs_x01_combined := by
  unfold nabs_nabs_x01_before nabs_nabs_x01_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x01   : nabs_nabs_x01_before  ⊑  nabs_nabs_x01_combined := by
  unfold nabs_nabs_x01_before nabs_nabs_x01_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x02_combined := [llvmfunc|
  llvm.func @nabs_nabs_x02(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x02   : nabs_nabs_x02_before  ⊑  nabs_nabs_x02_combined := by
  unfold nabs_nabs_x02_before nabs_nabs_x02_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x02   : nabs_nabs_x02_before  ⊑  nabs_nabs_x02_combined := by
  unfold nabs_nabs_x02_before nabs_nabs_x02_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x03_combined := [llvmfunc|
  llvm.func @nabs_nabs_x03(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x03   : nabs_nabs_x03_before  ⊑  nabs_nabs_x03_combined := by
  unfold nabs_nabs_x03_before nabs_nabs_x03_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x03   : nabs_nabs_x03_before  ⊑  nabs_nabs_x03_combined := by
  unfold nabs_nabs_x03_before nabs_nabs_x03_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x04_combined := [llvmfunc|
  llvm.func @nabs_nabs_x04(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x04   : nabs_nabs_x04_before  ⊑  nabs_nabs_x04_combined := by
  unfold nabs_nabs_x04_before nabs_nabs_x04_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x04   : nabs_nabs_x04_before  ⊑  nabs_nabs_x04_combined := by
  unfold nabs_nabs_x04_before nabs_nabs_x04_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x05_combined := [llvmfunc|
  llvm.func @nabs_nabs_x05(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x05   : nabs_nabs_x05_before  ⊑  nabs_nabs_x05_combined := by
  unfold nabs_nabs_x05_before nabs_nabs_x05_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x05   : nabs_nabs_x05_before  ⊑  nabs_nabs_x05_combined := by
  unfold nabs_nabs_x05_before nabs_nabs_x05_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x06_combined := [llvmfunc|
  llvm.func @nabs_nabs_x06(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x06   : nabs_nabs_x06_before  ⊑  nabs_nabs_x06_combined := by
  unfold nabs_nabs_x06_before nabs_nabs_x06_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x06   : nabs_nabs_x06_before  ⊑  nabs_nabs_x06_combined := by
  unfold nabs_nabs_x06_before nabs_nabs_x06_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x07_combined := [llvmfunc|
  llvm.func @nabs_nabs_x07(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x07   : nabs_nabs_x07_before  ⊑  nabs_nabs_x07_combined := by
  unfold nabs_nabs_x07_before nabs_nabs_x07_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x07   : nabs_nabs_x07_before  ⊑  nabs_nabs_x07_combined := by
  unfold nabs_nabs_x07_before nabs_nabs_x07_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x08_combined := [llvmfunc|
  llvm.func @nabs_nabs_x08(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x08   : nabs_nabs_x08_before  ⊑  nabs_nabs_x08_combined := by
  unfold nabs_nabs_x08_before nabs_nabs_x08_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x08   : nabs_nabs_x08_before  ⊑  nabs_nabs_x08_combined := by
  unfold nabs_nabs_x08_before nabs_nabs_x08_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x09_combined := [llvmfunc|
  llvm.func @nabs_nabs_x09(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x09   : nabs_nabs_x09_before  ⊑  nabs_nabs_x09_combined := by
  unfold nabs_nabs_x09_before nabs_nabs_x09_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x09   : nabs_nabs_x09_before  ⊑  nabs_nabs_x09_combined := by
  unfold nabs_nabs_x09_before nabs_nabs_x09_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x10_combined := [llvmfunc|
  llvm.func @nabs_nabs_x10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x10   : nabs_nabs_x10_before  ⊑  nabs_nabs_x10_combined := by
  unfold nabs_nabs_x10_before nabs_nabs_x10_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x10   : nabs_nabs_x10_before  ⊑  nabs_nabs_x10_combined := by
  unfold nabs_nabs_x10_before nabs_nabs_x10_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x11_combined := [llvmfunc|
  llvm.func @nabs_nabs_x11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x11   : nabs_nabs_x11_before  ⊑  nabs_nabs_x11_combined := by
  unfold nabs_nabs_x11_before nabs_nabs_x11_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x11   : nabs_nabs_x11_before  ⊑  nabs_nabs_x11_combined := by
  unfold nabs_nabs_x11_before nabs_nabs_x11_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x12_combined := [llvmfunc|
  llvm.func @nabs_nabs_x12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x12   : nabs_nabs_x12_before  ⊑  nabs_nabs_x12_combined := by
  unfold nabs_nabs_x12_before nabs_nabs_x12_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x12   : nabs_nabs_x12_before  ⊑  nabs_nabs_x12_combined := by
  unfold nabs_nabs_x12_before nabs_nabs_x12_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x13_combined := [llvmfunc|
  llvm.func @nabs_nabs_x13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x13   : nabs_nabs_x13_before  ⊑  nabs_nabs_x13_combined := by
  unfold nabs_nabs_x13_before nabs_nabs_x13_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x13   : nabs_nabs_x13_before  ⊑  nabs_nabs_x13_combined := by
  unfold nabs_nabs_x13_before nabs_nabs_x13_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x14_combined := [llvmfunc|
  llvm.func @nabs_nabs_x14(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x14   : nabs_nabs_x14_before  ⊑  nabs_nabs_x14_combined := by
  unfold nabs_nabs_x14_before nabs_nabs_x14_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x14   : nabs_nabs_x14_before  ⊑  nabs_nabs_x14_combined := by
  unfold nabs_nabs_x14_before nabs_nabs_x14_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x15_combined := [llvmfunc|
  llvm.func @nabs_nabs_x15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x15   : nabs_nabs_x15_before  ⊑  nabs_nabs_x15_combined := by
  unfold nabs_nabs_x15_before nabs_nabs_x15_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x15   : nabs_nabs_x15_before  ⊑  nabs_nabs_x15_combined := by
  unfold nabs_nabs_x15_before nabs_nabs_x15_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x16_combined := [llvmfunc|
  llvm.func @nabs_nabs_x16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x16   : nabs_nabs_x16_before  ⊑  nabs_nabs_x16_combined := by
  unfold nabs_nabs_x16_before nabs_nabs_x16_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x16   : nabs_nabs_x16_before  ⊑  nabs_nabs_x16_combined := by
  unfold nabs_nabs_x16_before nabs_nabs_x16_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x17_combined := [llvmfunc|
  llvm.func @nabs_nabs_x17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x17   : nabs_nabs_x17_before  ⊑  nabs_nabs_x17_combined := by
  unfold nabs_nabs_x17_before nabs_nabs_x17_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_nabs_x17   : nabs_nabs_x17_before  ⊑  nabs_nabs_x17_combined := by
  unfold nabs_nabs_x17_before nabs_nabs_x17_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x18_combined := [llvmfunc|
  llvm.func @nabs_nabs_x18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_nabs_x18   : nabs_nabs_x18_before  ⊑  nabs_nabs_x18_combined := by
  unfold nabs_nabs_x18_before nabs_nabs_x18_combined
  simp_alive_peephole
  sorry
    %3 = llvm.sub %0, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_nabs_nabs_x18   : nabs_nabs_x18_before  ⊑  nabs_nabs_x18_combined := by
  unfold nabs_nabs_x18_before nabs_nabs_x18_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x01_vec_combined := [llvmfunc|
  llvm.func @nabs_nabs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_nabs_nabs_x01_vec   : nabs_nabs_x01_vec_before  ⊑  nabs_nabs_x01_vec_combined := by
  unfold nabs_nabs_x01_vec_before nabs_nabs_x01_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.sub %1, %2  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_nabs_nabs_x01_vec   : nabs_nabs_x01_vec_before  ⊑  nabs_nabs_x01_vec_combined := by
  unfold nabs_nabs_x01_vec_before nabs_nabs_x01_vec_combined
  simp_alive_peephole
  sorry
def nabs_nabs_x02_vec_combined := [llvmfunc|
  llvm.func @nabs_nabs_x02_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_nabs_nabs_x02_vec   : nabs_nabs_x02_vec_before  ⊑  nabs_nabs_x02_vec_combined := by
  unfold nabs_nabs_x02_vec_before nabs_nabs_x02_vec_combined
  simp_alive_peephole
  sorry
    %4 = llvm.sub %1, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_nabs_nabs_x02_vec   : nabs_nabs_x02_vec_before  ⊑  nabs_nabs_x02_vec_combined := by
  unfold nabs_nabs_x02_vec_before nabs_nabs_x02_vec_combined
  simp_alive_peephole
  sorry
def abs_nabs_x01_combined := [llvmfunc|
  llvm.func @abs_nabs_x01(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x01   : abs_nabs_x01_before  ⊑  abs_nabs_x01_combined := by
  unfold abs_nabs_x01_before abs_nabs_x01_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x01   : abs_nabs_x01_before  ⊑  abs_nabs_x01_combined := by
  unfold abs_nabs_x01_before abs_nabs_x01_combined
  simp_alive_peephole
  sorry
def abs_nabs_x02_combined := [llvmfunc|
  llvm.func @abs_nabs_x02(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x02   : abs_nabs_x02_before  ⊑  abs_nabs_x02_combined := by
  unfold abs_nabs_x02_before abs_nabs_x02_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x02   : abs_nabs_x02_before  ⊑  abs_nabs_x02_combined := by
  unfold abs_nabs_x02_before abs_nabs_x02_combined
  simp_alive_peephole
  sorry
def abs_nabs_x03_combined := [llvmfunc|
  llvm.func @abs_nabs_x03(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x03   : abs_nabs_x03_before  ⊑  abs_nabs_x03_combined := by
  unfold abs_nabs_x03_before abs_nabs_x03_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x03   : abs_nabs_x03_before  ⊑  abs_nabs_x03_combined := by
  unfold abs_nabs_x03_before abs_nabs_x03_combined
  simp_alive_peephole
  sorry
def abs_nabs_x04_combined := [llvmfunc|
  llvm.func @abs_nabs_x04(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x04   : abs_nabs_x04_before  ⊑  abs_nabs_x04_combined := by
  unfold abs_nabs_x04_before abs_nabs_x04_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x04   : abs_nabs_x04_before  ⊑  abs_nabs_x04_combined := by
  unfold abs_nabs_x04_before abs_nabs_x04_combined
  simp_alive_peephole
  sorry
def abs_nabs_x05_combined := [llvmfunc|
  llvm.func @abs_nabs_x05(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x05   : abs_nabs_x05_before  ⊑  abs_nabs_x05_combined := by
  unfold abs_nabs_x05_before abs_nabs_x05_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x05   : abs_nabs_x05_before  ⊑  abs_nabs_x05_combined := by
  unfold abs_nabs_x05_before abs_nabs_x05_combined
  simp_alive_peephole
  sorry
def abs_nabs_x06_combined := [llvmfunc|
  llvm.func @abs_nabs_x06(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x06   : abs_nabs_x06_before  ⊑  abs_nabs_x06_combined := by
  unfold abs_nabs_x06_before abs_nabs_x06_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x06   : abs_nabs_x06_before  ⊑  abs_nabs_x06_combined := by
  unfold abs_nabs_x06_before abs_nabs_x06_combined
  simp_alive_peephole
  sorry
def abs_nabs_x07_combined := [llvmfunc|
  llvm.func @abs_nabs_x07(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x07   : abs_nabs_x07_before  ⊑  abs_nabs_x07_combined := by
  unfold abs_nabs_x07_before abs_nabs_x07_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x07   : abs_nabs_x07_before  ⊑  abs_nabs_x07_combined := by
  unfold abs_nabs_x07_before abs_nabs_x07_combined
  simp_alive_peephole
  sorry
def abs_nabs_x08_combined := [llvmfunc|
  llvm.func @abs_nabs_x08(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x08   : abs_nabs_x08_before  ⊑  abs_nabs_x08_combined := by
  unfold abs_nabs_x08_before abs_nabs_x08_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x08   : abs_nabs_x08_before  ⊑  abs_nabs_x08_combined := by
  unfold abs_nabs_x08_before abs_nabs_x08_combined
  simp_alive_peephole
  sorry
def abs_nabs_x09_combined := [llvmfunc|
  llvm.func @abs_nabs_x09(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x09   : abs_nabs_x09_before  ⊑  abs_nabs_x09_combined := by
  unfold abs_nabs_x09_before abs_nabs_x09_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x09   : abs_nabs_x09_before  ⊑  abs_nabs_x09_combined := by
  unfold abs_nabs_x09_before abs_nabs_x09_combined
  simp_alive_peephole
  sorry
def abs_nabs_x10_combined := [llvmfunc|
  llvm.func @abs_nabs_x10(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x10   : abs_nabs_x10_before  ⊑  abs_nabs_x10_combined := by
  unfold abs_nabs_x10_before abs_nabs_x10_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x10   : abs_nabs_x10_before  ⊑  abs_nabs_x10_combined := by
  unfold abs_nabs_x10_before abs_nabs_x10_combined
  simp_alive_peephole
  sorry
def abs_nabs_x11_combined := [llvmfunc|
  llvm.func @abs_nabs_x11(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x11   : abs_nabs_x11_before  ⊑  abs_nabs_x11_combined := by
  unfold abs_nabs_x11_before abs_nabs_x11_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x11   : abs_nabs_x11_before  ⊑  abs_nabs_x11_combined := by
  unfold abs_nabs_x11_before abs_nabs_x11_combined
  simp_alive_peephole
  sorry
def abs_nabs_x12_combined := [llvmfunc|
  llvm.func @abs_nabs_x12(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x12   : abs_nabs_x12_before  ⊑  abs_nabs_x12_combined := by
  unfold abs_nabs_x12_before abs_nabs_x12_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x12   : abs_nabs_x12_before  ⊑  abs_nabs_x12_combined := by
  unfold abs_nabs_x12_before abs_nabs_x12_combined
  simp_alive_peephole
  sorry
def abs_nabs_x13_combined := [llvmfunc|
  llvm.func @abs_nabs_x13(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x13   : abs_nabs_x13_before  ⊑  abs_nabs_x13_combined := by
  unfold abs_nabs_x13_before abs_nabs_x13_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x13   : abs_nabs_x13_before  ⊑  abs_nabs_x13_combined := by
  unfold abs_nabs_x13_before abs_nabs_x13_combined
  simp_alive_peephole
  sorry
def abs_nabs_x14_combined := [llvmfunc|
  llvm.func @abs_nabs_x14(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x14   : abs_nabs_x14_before  ⊑  abs_nabs_x14_combined := by
  unfold abs_nabs_x14_before abs_nabs_x14_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x14   : abs_nabs_x14_before  ⊑  abs_nabs_x14_combined := by
  unfold abs_nabs_x14_before abs_nabs_x14_combined
  simp_alive_peephole
  sorry
def abs_nabs_x15_combined := [llvmfunc|
  llvm.func @abs_nabs_x15(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x15   : abs_nabs_x15_before  ⊑  abs_nabs_x15_combined := by
  unfold abs_nabs_x15_before abs_nabs_x15_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x15   : abs_nabs_x15_before  ⊑  abs_nabs_x15_combined := by
  unfold abs_nabs_x15_before abs_nabs_x15_combined
  simp_alive_peephole
  sorry
def abs_nabs_x16_combined := [llvmfunc|
  llvm.func @abs_nabs_x16(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x16   : abs_nabs_x16_before  ⊑  abs_nabs_x16_combined := by
  unfold abs_nabs_x16_before abs_nabs_x16_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x16   : abs_nabs_x16_before  ⊑  abs_nabs_x16_combined := by
  unfold abs_nabs_x16_before abs_nabs_x16_combined
  simp_alive_peephole
  sorry
def abs_nabs_x17_combined := [llvmfunc|
  llvm.func @abs_nabs_x17(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x17   : abs_nabs_x17_before  ⊑  abs_nabs_x17_combined := by
  unfold abs_nabs_x17_before abs_nabs_x17_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_nabs_x17   : abs_nabs_x17_before  ⊑  abs_nabs_x17_combined := by
  unfold abs_nabs_x17_before abs_nabs_x17_combined
  simp_alive_peephole
  sorry
def abs_nabs_x18_combined := [llvmfunc|
  llvm.func @abs_nabs_x18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_nabs_x18   : abs_nabs_x18_before  ⊑  abs_nabs_x18_combined := by
  unfold abs_nabs_x18_before abs_nabs_x18_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_abs_nabs_x18   : abs_nabs_x18_before  ⊑  abs_nabs_x18_combined := by
  unfold abs_nabs_x18_before abs_nabs_x18_combined
  simp_alive_peephole
  sorry
def abs_nabs_x01_vec_combined := [llvmfunc|
  llvm.func @abs_nabs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_abs_nabs_x01_vec   : abs_nabs_x01_vec_before  ⊑  abs_nabs_x01_vec_combined := by
  unfold abs_nabs_x01_vec_before abs_nabs_x01_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_abs_nabs_x01_vec   : abs_nabs_x01_vec_before  ⊑  abs_nabs_x01_vec_combined := by
  unfold abs_nabs_x01_vec_before abs_nabs_x01_vec_combined
  simp_alive_peephole
  sorry
def abs_nabs_x02_vec_combined := [llvmfunc|
  llvm.func @abs_nabs_x02_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_abs_nabs_x02_vec   : abs_nabs_x02_vec_before  ⊑  abs_nabs_x02_vec_combined := by
  unfold abs_nabs_x02_vec_before abs_nabs_x02_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_abs_nabs_x02_vec   : abs_nabs_x02_vec_before  ⊑  abs_nabs_x02_vec_combined := by
  unfold abs_nabs_x02_vec_before abs_nabs_x02_vec_combined
  simp_alive_peephole
  sorry
def nabs_abs_x01_combined := [llvmfunc|
  llvm.func @nabs_abs_x01(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x01   : nabs_abs_x01_before  ⊑  nabs_abs_x01_combined := by
  unfold nabs_abs_x01_before nabs_abs_x01_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x01   : nabs_abs_x01_before  ⊑  nabs_abs_x01_combined := by
  unfold nabs_abs_x01_before nabs_abs_x01_combined
  simp_alive_peephole
  sorry
def nabs_abs_x02_combined := [llvmfunc|
  llvm.func @nabs_abs_x02(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x02   : nabs_abs_x02_before  ⊑  nabs_abs_x02_combined := by
  unfold nabs_abs_x02_before nabs_abs_x02_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x02   : nabs_abs_x02_before  ⊑  nabs_abs_x02_combined := by
  unfold nabs_abs_x02_before nabs_abs_x02_combined
  simp_alive_peephole
  sorry
def nabs_abs_x03_combined := [llvmfunc|
  llvm.func @nabs_abs_x03(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x03   : nabs_abs_x03_before  ⊑  nabs_abs_x03_combined := by
  unfold nabs_abs_x03_before nabs_abs_x03_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x03   : nabs_abs_x03_before  ⊑  nabs_abs_x03_combined := by
  unfold nabs_abs_x03_before nabs_abs_x03_combined
  simp_alive_peephole
  sorry
def nabs_abs_x04_combined := [llvmfunc|
  llvm.func @nabs_abs_x04(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x04   : nabs_abs_x04_before  ⊑  nabs_abs_x04_combined := by
  unfold nabs_abs_x04_before nabs_abs_x04_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x04   : nabs_abs_x04_before  ⊑  nabs_abs_x04_combined := by
  unfold nabs_abs_x04_before nabs_abs_x04_combined
  simp_alive_peephole
  sorry
def nabs_abs_x05_combined := [llvmfunc|
  llvm.func @nabs_abs_x05(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x05   : nabs_abs_x05_before  ⊑  nabs_abs_x05_combined := by
  unfold nabs_abs_x05_before nabs_abs_x05_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x05   : nabs_abs_x05_before  ⊑  nabs_abs_x05_combined := by
  unfold nabs_abs_x05_before nabs_abs_x05_combined
  simp_alive_peephole
  sorry
def nabs_abs_x06_combined := [llvmfunc|
  llvm.func @nabs_abs_x06(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x06   : nabs_abs_x06_before  ⊑  nabs_abs_x06_combined := by
  unfold nabs_abs_x06_before nabs_abs_x06_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x06   : nabs_abs_x06_before  ⊑  nabs_abs_x06_combined := by
  unfold nabs_abs_x06_before nabs_abs_x06_combined
  simp_alive_peephole
  sorry
def nabs_abs_x07_combined := [llvmfunc|
  llvm.func @nabs_abs_x07(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x07   : nabs_abs_x07_before  ⊑  nabs_abs_x07_combined := by
  unfold nabs_abs_x07_before nabs_abs_x07_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x07   : nabs_abs_x07_before  ⊑  nabs_abs_x07_combined := by
  unfold nabs_abs_x07_before nabs_abs_x07_combined
  simp_alive_peephole
  sorry
def nabs_abs_x08_combined := [llvmfunc|
  llvm.func @nabs_abs_x08(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x08   : nabs_abs_x08_before  ⊑  nabs_abs_x08_combined := by
  unfold nabs_abs_x08_before nabs_abs_x08_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x08   : nabs_abs_x08_before  ⊑  nabs_abs_x08_combined := by
  unfold nabs_abs_x08_before nabs_abs_x08_combined
  simp_alive_peephole
  sorry
def nabs_abs_x09_combined := [llvmfunc|
  llvm.func @nabs_abs_x09(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x09   : nabs_abs_x09_before  ⊑  nabs_abs_x09_combined := by
  unfold nabs_abs_x09_before nabs_abs_x09_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x09   : nabs_abs_x09_before  ⊑  nabs_abs_x09_combined := by
  unfold nabs_abs_x09_before nabs_abs_x09_combined
  simp_alive_peephole
  sorry
def nabs_abs_x10_combined := [llvmfunc|
  llvm.func @nabs_abs_x10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x10   : nabs_abs_x10_before  ⊑  nabs_abs_x10_combined := by
  unfold nabs_abs_x10_before nabs_abs_x10_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x10   : nabs_abs_x10_before  ⊑  nabs_abs_x10_combined := by
  unfold nabs_abs_x10_before nabs_abs_x10_combined
  simp_alive_peephole
  sorry
def nabs_abs_x11_combined := [llvmfunc|
  llvm.func @nabs_abs_x11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x11   : nabs_abs_x11_before  ⊑  nabs_abs_x11_combined := by
  unfold nabs_abs_x11_before nabs_abs_x11_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x11   : nabs_abs_x11_before  ⊑  nabs_abs_x11_combined := by
  unfold nabs_abs_x11_before nabs_abs_x11_combined
  simp_alive_peephole
  sorry
def nabs_abs_x12_combined := [llvmfunc|
  llvm.func @nabs_abs_x12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x12   : nabs_abs_x12_before  ⊑  nabs_abs_x12_combined := by
  unfold nabs_abs_x12_before nabs_abs_x12_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x12   : nabs_abs_x12_before  ⊑  nabs_abs_x12_combined := by
  unfold nabs_abs_x12_before nabs_abs_x12_combined
  simp_alive_peephole
  sorry
def nabs_abs_x13_combined := [llvmfunc|
  llvm.func @nabs_abs_x13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x13   : nabs_abs_x13_before  ⊑  nabs_abs_x13_combined := by
  unfold nabs_abs_x13_before nabs_abs_x13_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x13   : nabs_abs_x13_before  ⊑  nabs_abs_x13_combined := by
  unfold nabs_abs_x13_before nabs_abs_x13_combined
  simp_alive_peephole
  sorry
def nabs_abs_x14_combined := [llvmfunc|
  llvm.func @nabs_abs_x14(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x14   : nabs_abs_x14_before  ⊑  nabs_abs_x14_combined := by
  unfold nabs_abs_x14_before nabs_abs_x14_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x14   : nabs_abs_x14_before  ⊑  nabs_abs_x14_combined := by
  unfold nabs_abs_x14_before nabs_abs_x14_combined
  simp_alive_peephole
  sorry
def nabs_abs_x15_combined := [llvmfunc|
  llvm.func @nabs_abs_x15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x15   : nabs_abs_x15_before  ⊑  nabs_abs_x15_combined := by
  unfold nabs_abs_x15_before nabs_abs_x15_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x15   : nabs_abs_x15_before  ⊑  nabs_abs_x15_combined := by
  unfold nabs_abs_x15_before nabs_abs_x15_combined
  simp_alive_peephole
  sorry
def nabs_abs_x16_combined := [llvmfunc|
  llvm.func @nabs_abs_x16(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x16   : nabs_abs_x16_before  ⊑  nabs_abs_x16_combined := by
  unfold nabs_abs_x16_before nabs_abs_x16_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x16   : nabs_abs_x16_before  ⊑  nabs_abs_x16_combined := by
  unfold nabs_abs_x16_before nabs_abs_x16_combined
  simp_alive_peephole
  sorry
def nabs_abs_x17_combined := [llvmfunc|
  llvm.func @nabs_abs_x17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x17   : nabs_abs_x17_before  ⊑  nabs_abs_x17_combined := by
  unfold nabs_abs_x17_before nabs_abs_x17_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_abs_x17   : nabs_abs_x17_before  ⊑  nabs_abs_x17_combined := by
  unfold nabs_abs_x17_before nabs_abs_x17_combined
  simp_alive_peephole
  sorry
def nabs_abs_x18_combined := [llvmfunc|
  llvm.func @nabs_abs_x18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_nabs_abs_x18   : nabs_abs_x18_before  ⊑  nabs_abs_x18_combined := by
  unfold nabs_abs_x18_before nabs_abs_x18_combined
  simp_alive_peephole
  sorry
    %3 = llvm.sub %0, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_nabs_abs_x18   : nabs_abs_x18_before  ⊑  nabs_abs_x18_combined := by
  unfold nabs_abs_x18_before nabs_abs_x18_combined
  simp_alive_peephole
  sorry
def nabs_abs_x01_vec_combined := [llvmfunc|
  llvm.func @nabs_abs_x01_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_nabs_abs_x01_vec   : nabs_abs_x01_vec_before  ⊑  nabs_abs_x01_vec_combined := by
  unfold nabs_abs_x01_vec_before nabs_abs_x01_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_nabs_abs_x01_vec   : nabs_abs_x01_vec_before  ⊑  nabs_abs_x01_vec_combined := by
  unfold nabs_abs_x01_vec_before nabs_abs_x01_vec_combined
  simp_alive_peephole
  sorry
def nabs_abs_x02_vec_combined := [llvmfunc|
  llvm.func @nabs_abs_x02_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_nabs_abs_x02_vec   : nabs_abs_x02_vec_before  ⊑  nabs_abs_x02_vec_combined := by
  unfold nabs_abs_x02_vec_before nabs_abs_x02_vec_combined
  simp_alive_peephole
  sorry
    %4 = llvm.sub %1, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_nabs_abs_x02_vec   : nabs_abs_x02_vec_before  ⊑  nabs_abs_x02_vec_combined := by
  unfold nabs_abs_x02_vec_before nabs_abs_x02_vec_combined
  simp_alive_peephole
  sorry
