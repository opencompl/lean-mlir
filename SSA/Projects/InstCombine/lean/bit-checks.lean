import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bit-checks
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main1_before := [llvmfunc|
  llvm.func @main1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %4, %6  : i1
    %8 = llvm.select %7, %2, %0 : i1, i32
    llvm.return %8 : i32
  }]

def main1_logical_before := [llvmfunc|
  llvm.func @main1_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    %9 = llvm.select %8, %2, %0 : i1, i32
    llvm.return %9 : i32
  }]

def main2_before := [llvmfunc|
  llvm.func @main2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    %8 = llvm.select %7, %1, %0 : i1, i32
    llvm.return %8 : i32
  }]

def main2_logical_before := [llvmfunc|
  llvm.func @main2_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.select %5, %3, %7 : i1, i1
    %9 = llvm.select %8, %1, %0 : i1, i32
    llvm.return %9 : i32
  }]

def main3_before := [llvmfunc|
  llvm.func @main3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %1, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main3_logical_before := [llvmfunc|
  llvm.func @main3_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %8, %3 : i1, i1
    %10 = llvm.select %9, %1, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main3b_before := [llvmfunc|
  llvm.func @main3b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %1, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main3b_logical_before := [llvmfunc|
  llvm.func @main3b_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    %9 = llvm.select %6, %8, %3 : i1, i1
    %10 = llvm.select %9, %1, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main3e_like_before := [llvmfunc|
  llvm.func @main3e_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }]

def main3e_like_logical_before := [llvmfunc|
  llvm.func @main3e_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "eq" %5, %0 : i32
    %7 = llvm.select %4, %6, %1 : i1, i1
    %8 = llvm.select %7, %0, %2 : i1, i32
    llvm.return %8 : i32
  }]

def main3c_before := [llvmfunc|
  llvm.func @main3c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    %9 = llvm.select %8, %1, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main3c_logical_before := [llvmfunc|
  llvm.func @main3c_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %1 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    %10 = llvm.select %9, %1, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main3d_before := [llvmfunc|
  llvm.func @main3d(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    %9 = llvm.select %8, %1, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main3d_logical_before := [llvmfunc|
  llvm.func @main3d_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    %10 = llvm.select %9, %1, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main3f_like_before := [llvmfunc|
  llvm.func @main3f_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    %6 = llvm.or %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }]

def main3f_like_logical_before := [llvmfunc|
  llvm.func @main3f_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "ne" %5, %0 : i32
    %7 = llvm.select %4, %1, %6 : i1, i1
    %8 = llvm.select %7, %0, %2 : i1, i32
    llvm.return %8 : i32
  }]

def main4_before := [llvmfunc|
  llvm.func @main4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(48 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %arg0, %1  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main4_splat_before := [llvmfunc|
  llvm.func @main4_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<48> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %0 : vector<2xi32>
    %7 = llvm.and %arg0, %1  : vector<2xi32>
    %8 = llvm.icmp "eq" %7, %1 : vector<2xi32>
    %9 = llvm.and %6, %8  : vector<2xi1>
    %10 = llvm.select %9, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def main4_logical_before := [llvmfunc|
  llvm.func @main4_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(48 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %0 : i32
    %7 = llvm.and %arg0, %1  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.select %6, %8, %2 : i1, i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main4b_before := [llvmfunc|
  llvm.func @main4b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %arg0, %1  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main4b_logical_before := [llvmfunc|
  llvm.func @main4b_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %0 : i32
    %7 = llvm.and %arg0, %1  : i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    %9 = llvm.select %6, %8, %3 : i1, i1
    %10 = llvm.select %9, %2, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main4e_like_before := [llvmfunc|
  llvm.func @main4e_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %arg1 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "eq" %4, %arg2 : i32
    %6 = llvm.and %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }]

def main4e_like_logical_before := [llvmfunc|
  llvm.func @main4e_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "eq" %3, %arg1 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "eq" %5, %arg2 : i32
    %7 = llvm.select %4, %6, %0 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }]

def main4c_before := [llvmfunc|
  llvm.func @main4c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(48 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    %6 = llvm.and %arg0, %1  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.or %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main4c_logical_before := [llvmfunc|
  llvm.func @main4c_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(48 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %0 : i32
    %7 = llvm.and %arg0, %1  : i32
    %8 = llvm.icmp "ne" %7, %1 : i32
    %9 = llvm.select %6, %2, %8 : i1, i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main4d_before := [llvmfunc|
  llvm.func @main4d(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    %6 = llvm.and %arg0, %1  : i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    %8 = llvm.or %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main4d_logical_before := [llvmfunc|
  llvm.func @main4d_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %0 : i32
    %7 = llvm.and %arg0, %1  : i32
    %8 = llvm.icmp "eq" %7, %2 : i32
    %9 = llvm.select %6, %3, %8 : i1, i1
    %10 = llvm.select %9, %2, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main4f_like_before := [llvmfunc|
  llvm.func @main4f_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "ne" %2, %arg1 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "ne" %4, %arg2 : i32
    %6 = llvm.or %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }]

def main4f_like_logical_before := [llvmfunc|
  llvm.func @main4f_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "ne" %3, %arg1 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "ne" %5, %arg2 : i32
    %7 = llvm.select %4, %0, %6 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }]

def main5_like_before := [llvmfunc|
  llvm.func @main5_like(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.and %arg1, %0  : i32
    %6 = llvm.icmp "eq" %5, %0 : i32
    %7 = llvm.and %4, %6  : i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }]

def main5_like_logical_before := [llvmfunc|
  llvm.func @main5_like_logical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.and %arg1, %0  : i32
    %7 = llvm.icmp "eq" %6, %0 : i32
    %8 = llvm.select %5, %7, %1 : i1, i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main5e_like_before := [llvmfunc|
  llvm.func @main5e_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %arg0 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "eq" %4, %arg0 : i32
    %6 = llvm.and %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }]

def main5e_like_logical_before := [llvmfunc|
  llvm.func @main5e_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "eq" %3, %arg0 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "eq" %5, %arg0 : i32
    %7 = llvm.select %4, %6, %0 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }]

def main5c_like_before := [llvmfunc|
  llvm.func @main5c_like(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.and %arg1, %0  : i32
    %6 = llvm.icmp "ne" %5, %0 : i32
    %7 = llvm.or %4, %6  : i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }]

def main5c_like_logical_before := [llvmfunc|
  llvm.func @main5c_like_logical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    %6 = llvm.and %arg1, %0  : i32
    %7 = llvm.icmp "ne" %6, %0 : i32
    %8 = llvm.select %5, %1, %7 : i1, i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main5f_like_before := [llvmfunc|
  llvm.func @main5f_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "ne" %2, %arg0 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "ne" %4, %arg0 : i32
    %6 = llvm.or %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }]

def main5f_like_logical_before := [llvmfunc|
  llvm.func @main5f_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "ne" %3, %arg0 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "ne" %5, %arg0 : i32
    %7 = llvm.select %4, %0, %6 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }]

def main6_before := [llvmfunc|
  llvm.func @main6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.and %arg0, %2  : i32
    %9 = llvm.icmp "eq" %8, %3 : i32
    %10 = llvm.and %7, %9  : i1
    %11 = llvm.select %10, %4, %5 : i1, i32
    llvm.return %11 : i32
  }]

def main6_logical_before := [llvmfunc|
  llvm.func @main6_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.and %arg0, %0  : i32
    %8 = llvm.icmp "eq" %7, %1 : i32
    %9 = llvm.and %arg0, %2  : i32
    %10 = llvm.icmp "eq" %9, %3 : i32
    %11 = llvm.select %8, %10, %4 : i1, i1
    %12 = llvm.select %11, %5, %6 : i1, i32
    llvm.return %12 : i32
  }]

def main6b_before := [llvmfunc|
  llvm.func @main6b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "ne" %7, %3 : i32
    %9 = llvm.and %6, %8  : i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main6b_logical_before := [llvmfunc|
  llvm.func @main6b_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.and %arg0, %2  : i32
    %9 = llvm.icmp "ne" %8, %3 : i32
    %10 = llvm.select %7, %9, %4 : i1, i1
    %11 = llvm.select %10, %3, %5 : i1, i32
    llvm.return %11 : i32
  }]

def main6c_before := [llvmfunc|
  llvm.func @main6c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.and %arg0, %2  : i32
    %9 = llvm.icmp "ne" %8, %3 : i32
    %10 = llvm.or %7, %9  : i1
    %11 = llvm.select %10, %4, %5 : i1, i32
    llvm.return %11 : i32
  }]

def main6c_logical_before := [llvmfunc|
  llvm.func @main6c_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(48 : i32) : i32
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.and %arg0, %0  : i32
    %8 = llvm.icmp "ne" %7, %1 : i32
    %9 = llvm.and %arg0, %2  : i32
    %10 = llvm.icmp "ne" %9, %3 : i32
    %11 = llvm.select %8, %4, %10 : i1, i1
    %12 = llvm.select %11, %5, %6 : i1, i32
    llvm.return %12 : i32
  }]

def main6d_before := [llvmfunc|
  llvm.func @main6d(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.and %arg0, %2  : i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    %9 = llvm.or %6, %8  : i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main6d_logical_before := [llvmfunc|
  llvm.func @main6d_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.and %arg0, %2  : i32
    %9 = llvm.icmp "eq" %8, %3 : i32
    %10 = llvm.select %7, %4, %9 : i1, i1
    %11 = llvm.select %10, %3, %5 : i1, i32
    llvm.return %11 : i32
  }]

def main7a_before := [llvmfunc|
  llvm.func @main7a(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %arg1 : i32
    %4 = llvm.and %arg2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %arg2 : i32
    %6 = llvm.and %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }]

def main7a_logical_before := [llvmfunc|
  llvm.func @main7a_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %arg1 : i32
    %5 = llvm.and %arg2, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %arg2 : i32
    %7 = llvm.select %4, %6, %0 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }]

def main7b_before := [llvmfunc|
  llvm.func @main7b(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %arg1, %2 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "eq" %arg2, %4 : i32
    %6 = llvm.and %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }]

def main7b_logical_before := [llvmfunc|
  llvm.func @main7b_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %arg1  : i32
    %4 = llvm.icmp "eq" %arg1, %3 : i32
    %5 = llvm.and %arg0, %arg2  : i32
    %6 = llvm.icmp "eq" %arg2, %5 : i32
    %7 = llvm.select %4, %6, %0 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }]

def main7c_before := [llvmfunc|
  llvm.func @main7c(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.icmp "eq" %arg1, %2 : i32
    %4 = llvm.and %arg2, %arg0  : i32
    %5 = llvm.icmp "eq" %arg2, %4 : i32
    %6 = llvm.and %3, %5  : i1
    %7 = llvm.select %6, %0, %1 : i1, i32
    llvm.return %7 : i32
  }]

def main7c_logical_before := [llvmfunc|
  llvm.func @main7c_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg1, %arg0  : i32
    %4 = llvm.icmp "eq" %arg1, %3 : i32
    %5 = llvm.and %arg2, %arg0  : i32
    %6 = llvm.icmp "eq" %arg2, %5 : i32
    %7 = llvm.select %4, %6, %0 : i1, i1
    %8 = llvm.select %7, %1, %2 : i1, i32
    llvm.return %8 : i32
  }]

def main7d_before := [llvmfunc|
  llvm.func @main7d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg3  : i32
    %3 = llvm.and %arg2, %arg4  : i32
    %4 = llvm.and %arg0, %2  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.and %arg0, %3  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %0, %1 : i1, i32
    llvm.return %9 : i32
  }]

def main7d_logical_before := [llvmfunc|
  llvm.func @main7d_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg1, %arg3  : i32
    %4 = llvm.and %arg2, %arg4  : i32
    %5 = llvm.and %arg0, %3  : i32
    %6 = llvm.icmp "eq" %5, %3 : i32
    %7 = llvm.and %arg0, %4  : i32
    %8 = llvm.icmp "eq" %7, %4 : i32
    %9 = llvm.select %6, %8, %0 : i1, i1
    %10 = llvm.select %9, %1, %2 : i1, i32
    llvm.return %10 : i32
  }]

def main7e_before := [llvmfunc|
  llvm.func @main7e(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg3  : i32
    %3 = llvm.and %arg2, %arg4  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %0, %1 : i1, i32
    llvm.return %9 : i32
  }]

def main7e_logical_before := [llvmfunc|
  llvm.func @main7e_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg1, %arg3  : i32
    %4 = llvm.and %arg2, %arg4  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %5, %3 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %7, %4 : i32
    %9 = llvm.select %6, %8, %0 : i1, i1
    %10 = llvm.select %9, %1, %2 : i1, i32
    llvm.return %10 : i32
  }]

def main7f_before := [llvmfunc|
  llvm.func @main7f(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg3  : i32
    %3 = llvm.and %arg2, %arg4  : i32
    %4 = llvm.and %arg0, %2  : i32
    %5 = llvm.icmp "eq" %2, %4 : i32
    %6 = llvm.and %arg0, %3  : i32
    %7 = llvm.icmp "eq" %3, %6 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %0, %1 : i1, i32
    llvm.return %9 : i32
  }]

def main7f_logical_before := [llvmfunc|
  llvm.func @main7f_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg1, %arg3  : i32
    %4 = llvm.and %arg2, %arg4  : i32
    %5 = llvm.and %arg0, %3  : i32
    %6 = llvm.icmp "eq" %3, %5 : i32
    %7 = llvm.and %arg0, %4  : i32
    %8 = llvm.icmp "eq" %4, %7 : i32
    %9 = llvm.select %6, %8, %0 : i1, i1
    %10 = llvm.select %9, %1, %2 : i1, i32
    llvm.return %10 : i32
  }]

def main7g_before := [llvmfunc|
  llvm.func @main7g(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg3  : i32
    %3 = llvm.and %arg2, %arg4  : i32
    %4 = llvm.and %2, %arg0  : i32
    %5 = llvm.icmp "eq" %2, %4 : i32
    %6 = llvm.and %3, %arg0  : i32
    %7 = llvm.icmp "eq" %3, %6 : i32
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %0, %1 : i1, i32
    llvm.return %9 : i32
  }]

def main7g_logical_before := [llvmfunc|
  llvm.func @main7g_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg1, %arg3  : i32
    %4 = llvm.and %arg2, %arg4  : i32
    %5 = llvm.and %3, %arg0  : i32
    %6 = llvm.icmp "eq" %3, %5 : i32
    %7 = llvm.and %4, %arg0  : i32
    %8 = llvm.icmp "eq" %4, %7 : i32
    %9 = llvm.select %6, %8, %0 : i1, i1
    %10 = llvm.select %9, %1, %2 : i1, i32
    llvm.return %10 : i32
  }]

def main8_before := [llvmfunc|
  llvm.func @main8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "slt" %7, %2 : i8
    %9 = llvm.or %6, %8  : i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main8_logical_before := [llvmfunc|
  llvm.func @main8_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "slt" %8, %2 : i8
    %10 = llvm.select %7, %3, %9 : i1, i1
    %11 = llvm.select %10, %4, %5 : i1, i32
    llvm.return %11 : i32
  }]

def main9_before := [llvmfunc|
  llvm.func @main9(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "slt" %7, %2 : i8
    %9 = llvm.and %6, %8  : i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main9_logical_before := [llvmfunc|
  llvm.func @main9_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "slt" %8, %2 : i8
    %10 = llvm.select %7, %9, %3 : i1, i1
    %11 = llvm.select %10, %4, %5 : i1, i32
    llvm.return %11 : i32
  }]

def main10_before := [llvmfunc|
  llvm.func @main10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "sge" %7, %2 : i8
    %9 = llvm.and %6, %8  : i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main10_logical_before := [llvmfunc|
  llvm.func @main10_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "sge" %8, %2 : i8
    %10 = llvm.select %7, %9, %3 : i1, i1
    %11 = llvm.select %10, %4, %5 : i1, i32
    llvm.return %11 : i32
  }]

def main11_before := [llvmfunc|
  llvm.func @main11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "sge" %7, %2 : i8
    %9 = llvm.or %6, %8  : i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main11_logical_before := [llvmfunc|
  llvm.func @main11_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.and %arg0, %0  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "sge" %8, %2 : i8
    %10 = llvm.select %7, %3, %9 : i1, i1
    %11 = llvm.select %10, %4, %5 : i1, i32
    llvm.return %11 : i32
  }]

def main12_before := [llvmfunc|
  llvm.func @main12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.trunc %arg0 : i32 to i16
    %5 = llvm.icmp "slt" %4, %0 : i16
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.icmp "slt" %6, %1 : i8
    %8 = llvm.or %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main12_logical_before := [llvmfunc|
  llvm.func @main12_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.icmp "slt" %5, %0 : i16
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "slt" %7, %1 : i8
    %9 = llvm.select %6, %2, %8 : i1, i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main13_before := [llvmfunc|
  llvm.func @main13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.trunc %arg0 : i32 to i16
    %5 = llvm.icmp "slt" %4, %0 : i16
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.icmp "slt" %6, %1 : i8
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main13_logical_before := [llvmfunc|
  llvm.func @main13_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.icmp "slt" %5, %0 : i16
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "slt" %7, %1 : i8
    %9 = llvm.select %6, %8, %2 : i1, i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main14_before := [llvmfunc|
  llvm.func @main14(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.trunc %arg0 : i32 to i16
    %5 = llvm.icmp "sge" %4, %0 : i16
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.icmp "sge" %6, %1 : i8
    %8 = llvm.and %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main14_logical_before := [llvmfunc|
  llvm.func @main14_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.icmp "sge" %5, %0 : i16
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "sge" %7, %1 : i8
    %9 = llvm.select %6, %8, %2 : i1, i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main15_before := [llvmfunc|
  llvm.func @main15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.trunc %arg0 : i32 to i16
    %5 = llvm.icmp "sge" %4, %0 : i16
    %6 = llvm.trunc %arg0 : i32 to i8
    %7 = llvm.icmp "sge" %6, %1 : i8
    %8 = llvm.or %5, %7  : i1
    %9 = llvm.select %8, %2, %3 : i1, i32
    llvm.return %9 : i32
  }]

def main15_logical_before := [llvmfunc|
  llvm.func @main15_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.icmp "sge" %5, %0 : i16
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "sge" %7, %1 : i8
    %9 = llvm.select %6, %2, %8 : i1, i1
    %10 = llvm.select %9, %3, %4 : i1, i32
    llvm.return %10 : i32
  }]

def main1_combined := [llvmfunc|
  llvm.func @main1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main1   : main1_before  ⊑  main1_combined := by
  unfold main1_before main1_combined
  simp_alive_peephole
  sorry
def main1_logical_combined := [llvmfunc|
  llvm.func @main1_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main1_logical   : main1_logical_before  ⊑  main1_logical_combined := by
  unfold main1_logical_before main1_logical_combined
  simp_alive_peephole
  sorry
def main2_combined := [llvmfunc|
  llvm.func @main2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main2   : main2_before  ⊑  main2_combined := by
  unfold main2_before main2_combined
  simp_alive_peephole
  sorry
def main2_logical_combined := [llvmfunc|
  llvm.func @main2_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main2_logical   : main2_logical_before  ⊑  main2_logical_combined := by
  unfold main2_logical_before main2_logical_combined
  simp_alive_peephole
  sorry
def main3_combined := [llvmfunc|
  llvm.func @main3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(55 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main3   : main3_before  ⊑  main3_combined := by
  unfold main3_before main3_combined
  simp_alive_peephole
  sorry
def main3_logical_combined := [llvmfunc|
  llvm.func @main3_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(55 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main3_logical   : main3_logical_before  ⊑  main3_logical_combined := by
  unfold main3_logical_before main3_logical_combined
  simp_alive_peephole
  sorry
def main3b_combined := [llvmfunc|
  llvm.func @main3b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main3b   : main3b_before  ⊑  main3b_combined := by
  unfold main3b_before main3b_combined
  simp_alive_peephole
  sorry
def main3b_logical_combined := [llvmfunc|
  llvm.func @main3b_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main3b_logical   : main3b_logical_before  ⊑  main3b_logical_combined := by
  unfold main3b_logical_before main3b_logical_combined
  simp_alive_peephole
  sorry
def main3e_like_combined := [llvmfunc|
  llvm.func @main3e_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main3e_like   : main3e_like_before  ⊑  main3e_like_combined := by
  unfold main3e_like_before main3e_like_combined
  simp_alive_peephole
  sorry
def main3e_like_logical_combined := [llvmfunc|
  llvm.func @main3e_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_main3e_like_logical   : main3e_like_logical_before  ⊑  main3e_like_logical_combined := by
  unfold main3e_like_logical_before main3e_like_logical_combined
  simp_alive_peephole
  sorry
def main3c_combined := [llvmfunc|
  llvm.func @main3c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(55 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main3c   : main3c_before  ⊑  main3c_combined := by
  unfold main3c_before main3c_combined
  simp_alive_peephole
  sorry
def main3c_logical_combined := [llvmfunc|
  llvm.func @main3c_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(55 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main3c_logical   : main3c_logical_before  ⊑  main3c_logical_combined := by
  unfold main3c_logical_before main3c_logical_combined
  simp_alive_peephole
  sorry
def main3d_combined := [llvmfunc|
  llvm.func @main3d(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main3d   : main3d_before  ⊑  main3d_combined := by
  unfold main3d_before main3d_combined
  simp_alive_peephole
  sorry
def main3d_logical_combined := [llvmfunc|
  llvm.func @main3d_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main3d_logical   : main3d_logical_before  ⊑  main3d_logical_combined := by
  unfold main3d_logical_before main3d_logical_combined
  simp_alive_peephole
  sorry
def main3f_like_combined := [llvmfunc|
  llvm.func @main3f_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.or %arg1, %arg2  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main3f_like   : main3f_like_before  ⊑  main3f_like_combined := by
  unfold main3f_like_before main3f_like_combined
  simp_alive_peephole
  sorry
def main3f_like_logical_combined := [llvmfunc|
  llvm.func @main3f_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.and %arg0, %arg2  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.select %3, %5, %1 : i1, i1
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_main3f_like_logical   : main3f_like_logical_before  ⊑  main3f_like_logical_combined := by
  unfold main3f_like_logical_before main3f_like_logical_combined
  simp_alive_peephole
  sorry
def main4_combined := [llvmfunc|
  llvm.func @main4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(55 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main4   : main4_before  ⊑  main4_combined := by
  unfold main4_before main4_combined
  simp_alive_peephole
  sorry
def main4_splat_combined := [llvmfunc|
  llvm.func @main4_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<55> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_main4_splat   : main4_splat_before  ⊑  main4_splat_combined := by
  unfold main4_splat_before main4_splat_combined
  simp_alive_peephole
  sorry
def main4_logical_combined := [llvmfunc|
  llvm.func @main4_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(55 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main4_logical   : main4_logical_before  ⊑  main4_logical_combined := by
  unfold main4_logical_before main4_logical_combined
  simp_alive_peephole
  sorry
def main4b_combined := [llvmfunc|
  llvm.func @main4b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main4b   : main4b_before  ⊑  main4b_combined := by
  unfold main4b_before main4b_combined
  simp_alive_peephole
  sorry
def main4b_logical_combined := [llvmfunc|
  llvm.func @main4b_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main4b_logical   : main4b_logical_before  ⊑  main4b_logical_combined := by
  unfold main4b_logical_before main4b_logical_combined
  simp_alive_peephole
  sorry
def main4e_like_combined := [llvmfunc|
  llvm.func @main4e_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    %1 = llvm.and %0, %arg0  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main4e_like   : main4e_like_before  ⊑  main4e_like_combined := by
  unfold main4e_like_before main4e_like_combined
  simp_alive_peephole
  sorry
def main4e_like_logical_combined := [llvmfunc|
  llvm.func @main4e_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "ne" %1, %arg1 : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.icmp "ne" %3, %arg2 : i32
    %5 = llvm.select %2, %0, %4 : i1, i1
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main4e_like_logical   : main4e_like_logical_before  ⊑  main4e_like_logical_combined := by
  unfold main4e_like_logical_before main4e_like_logical_combined
  simp_alive_peephole
  sorry
def main4c_combined := [llvmfunc|
  llvm.func @main4c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(55 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main4c   : main4c_before  ⊑  main4c_combined := by
  unfold main4c_before main4c_combined
  simp_alive_peephole
  sorry
def main4c_logical_combined := [llvmfunc|
  llvm.func @main4c_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(55 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main4c_logical   : main4c_logical_before  ⊑  main4c_logical_combined := by
  unfold main4c_logical_before main4c_logical_combined
  simp_alive_peephole
  sorry
def main4d_combined := [llvmfunc|
  llvm.func @main4d(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main4d   : main4d_before  ⊑  main4d_combined := by
  unfold main4d_before main4d_combined
  simp_alive_peephole
  sorry
def main4d_logical_combined := [llvmfunc|
  llvm.func @main4d_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main4d_logical   : main4d_logical_before  ⊑  main4d_logical_combined := by
  unfold main4d_logical_before main4d_logical_combined
  simp_alive_peephole
  sorry
def main4f_like_combined := [llvmfunc|
  llvm.func @main4f_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    %1 = llvm.and %0, %arg0  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main4f_like   : main4f_like_before  ⊑  main4f_like_combined := by
  unfold main4f_like_before main4f_like_combined
  simp_alive_peephole
  sorry
def main4f_like_logical_combined := [llvmfunc|
  llvm.func @main4f_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "eq" %1, %arg1 : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.icmp "eq" %3, %arg2 : i32
    %5 = llvm.select %2, %4, %0 : i1, i1
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main4f_like_logical   : main4f_like_logical_before  ⊑  main4f_like_logical_combined := by
  unfold main4f_like_logical_before main4f_like_logical_combined
  simp_alive_peephole
  sorry
def main5_like_combined := [llvmfunc|
  llvm.func @main5_like(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main5_like   : main5_like_before  ⊑  main5_like_combined := by
  unfold main5_like_before main5_like_combined
  simp_alive_peephole
  sorry
def main5_like_logical_combined := [llvmfunc|
  llvm.func @main5_like_logical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.and %arg1, %0  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_main5_like_logical   : main5_like_logical_before  ⊑  main5_like_logical_combined := by
  unfold main5_like_logical_before main5_like_logical_combined
  simp_alive_peephole
  sorry
def main5e_like_combined := [llvmfunc|
  llvm.func @main5e_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg1, %arg2  : i32
    %1 = llvm.and %0, %arg0  : i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main5e_like   : main5e_like_before  ⊑  main5e_like_combined := by
  unfold main5e_like_before main5e_like_combined
  simp_alive_peephole
  sorry
def main5e_like_logical_combined := [llvmfunc|
  llvm.func @main5e_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.icmp "ne" %3, %arg0 : i32
    %5 = llvm.select %2, %0, %4 : i1, i1
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main5e_like_logical   : main5e_like_logical_before  ⊑  main5e_like_logical_combined := by
  unfold main5e_like_logical_before main5e_like_logical_combined
  simp_alive_peephole
  sorry
def main5c_like_combined := [llvmfunc|
  llvm.func @main5c_like(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main5c_like   : main5c_like_before  ⊑  main5c_like_combined := by
  unfold main5c_like_before main5c_like_combined
  simp_alive_peephole
  sorry
def main5c_like_logical_combined := [llvmfunc|
  llvm.func @main5c_like_logical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.and %arg1, %0  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    %6 = llvm.select %3, %5, %1 : i1, i1
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_main5c_like_logical   : main5c_like_logical_before  ⊑  main5c_like_logical_combined := by
  unfold main5c_like_logical_before main5c_like_logical_combined
  simp_alive_peephole
  sorry
def main5f_like_combined := [llvmfunc|
  llvm.func @main5f_like(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg1, %arg2  : i32
    %1 = llvm.and %0, %arg0  : i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main5f_like   : main5f_like_before  ⊑  main5f_like_combined := by
  unfold main5f_like_before main5f_like_combined
  simp_alive_peephole
  sorry
def main5f_like_logical_combined := [llvmfunc|
  llvm.func @main5f_like_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.icmp "eq" %3, %arg0 : i32
    %5 = llvm.select %2, %4, %0 : i1, i1
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main5f_like_logical   : main5f_like_logical_before  ⊑  main5f_like_logical_combined := by
  unfold main5f_like_logical_before main5f_like_logical_combined
  simp_alive_peephole
  sorry
def main6_combined := [llvmfunc|
  llvm.func @main6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(55 : i32) : i32
    %1 = llvm.mlir.constant(19 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main6   : main6_before  ⊑  main6_combined := by
  unfold main6_before main6_combined
  simp_alive_peephole
  sorry
def main6_logical_combined := [llvmfunc|
  llvm.func @main6_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(55 : i32) : i32
    %1 = llvm.mlir.constant(19 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main6_logical   : main6_logical_before  ⊑  main6_logical_combined := by
  unfold main6_logical_before main6_logical_combined
  simp_alive_peephole
  sorry
def main6b_combined := [llvmfunc|
  llvm.func @main6b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(19 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main6b   : main6b_before  ⊑  main6b_combined := by
  unfold main6b_before main6b_combined
  simp_alive_peephole
  sorry
def main6b_logical_combined := [llvmfunc|
  llvm.func @main6b_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(19 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main6b_logical   : main6b_logical_before  ⊑  main6b_logical_combined := by
  unfold main6b_logical_before main6b_logical_combined
  simp_alive_peephole
  sorry
def main6c_combined := [llvmfunc|
  llvm.func @main6c(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(55 : i32) : i32
    %1 = llvm.mlir.constant(19 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main6c   : main6c_before  ⊑  main6c_combined := by
  unfold main6c_before main6c_combined
  simp_alive_peephole
  sorry
def main6c_logical_combined := [llvmfunc|
  llvm.func @main6c_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(55 : i32) : i32
    %1 = llvm.mlir.constant(19 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main6c_logical   : main6c_logical_before  ⊑  main6c_logical_combined := by
  unfold main6c_logical_before main6c_logical_combined
  simp_alive_peephole
  sorry
def main6d_combined := [llvmfunc|
  llvm.func @main6d(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(19 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main6d   : main6d_before  ⊑  main6d_combined := by
  unfold main6d_before main6d_combined
  simp_alive_peephole
  sorry
def main6d_logical_combined := [llvmfunc|
  llvm.func @main6d_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(19 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main6d_logical   : main6d_logical_before  ⊑  main6d_logical_combined := by
  unfold main6d_logical_before main6d_logical_combined
  simp_alive_peephole
  sorry
def main7a_combined := [llvmfunc|
  llvm.func @main7a(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    %1 = llvm.and %0, %arg0  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main7a   : main7a_before  ⊑  main7a_combined := by
  unfold main7a_before main7a_combined
  simp_alive_peephole
  sorry
def main7a_logical_combined := [llvmfunc|
  llvm.func @main7a_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.icmp "ne" %1, %arg1 : i32
    %3 = llvm.and %arg2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %arg2 : i32
    %5 = llvm.select %2, %0, %4 : i1, i1
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main7a_logical   : main7a_logical_before  ⊑  main7a_logical_combined := by
  unfold main7a_logical_before main7a_logical_combined
  simp_alive_peephole
  sorry
def main7b_combined := [llvmfunc|
  llvm.func @main7b(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    %1 = llvm.and %0, %arg0  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main7b   : main7b_before  ⊑  main7b_combined := by
  unfold main7b_before main7b_combined
  simp_alive_peephole
  sorry
def main7b_logical_combined := [llvmfunc|
  llvm.func @main7b_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.icmp "ne" %1, %arg1 : i32
    %3 = llvm.and %arg0, %arg2  : i32
    %4 = llvm.icmp "ne" %3, %arg2 : i32
    %5 = llvm.select %2, %0, %4 : i1, i1
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main7b_logical   : main7b_logical_before  ⊑  main7b_logical_combined := by
  unfold main7b_logical_before main7b_logical_combined
  simp_alive_peephole
  sorry
def main7c_combined := [llvmfunc|
  llvm.func @main7c(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.or %arg1, %arg2  : i32
    %1 = llvm.and %0, %arg0  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_main7c   : main7c_before  ⊑  main7c_combined := by
  unfold main7c_before main7c_combined
  simp_alive_peephole
  sorry
def main7c_logical_combined := [llvmfunc|
  llvm.func @main7c_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.icmp "ne" %1, %arg1 : i32
    %3 = llvm.and %arg2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %arg2 : i32
    %5 = llvm.select %2, %0, %4 : i1, i1
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main7c_logical   : main7c_logical_before  ⊑  main7c_logical_combined := by
  unfold main7c_logical_before main7c_logical_combined
  simp_alive_peephole
  sorry
def main7d_combined := [llvmfunc|
  llvm.func @main7d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.and %arg1, %arg3  : i32
    %1 = llvm.and %arg2, %arg4  : i32
    %2 = llvm.or %0, %1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main7d   : main7d_before  ⊑  main7d_combined := by
  unfold main7d_before main7d_combined
  simp_alive_peephole
  sorry
def main7d_logical_combined := [llvmfunc|
  llvm.func @main7d_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg3  : i32
    %2 = llvm.and %arg2, %arg4  : i32
    %3 = llvm.and %1, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    %7 = llvm.select %4, %0, %6 : i1, i1
    %8 = llvm.zext %7 : i1 to i32
    llvm.return %8 : i32
  }]

theorem inst_combine_main7d_logical   : main7d_logical_before  ⊑  main7d_logical_combined := by
  unfold main7d_logical_before main7d_logical_combined
  simp_alive_peephole
  sorry
def main7e_combined := [llvmfunc|
  llvm.func @main7e(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.and %arg1, %arg3  : i32
    %1 = llvm.and %arg2, %arg4  : i32
    %2 = llvm.or %0, %1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main7e   : main7e_before  ⊑  main7e_combined := by
  unfold main7e_before main7e_combined
  simp_alive_peephole
  sorry
def main7e_logical_combined := [llvmfunc|
  llvm.func @main7e_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg3  : i32
    %2 = llvm.and %arg2, %arg4  : i32
    %3 = llvm.and %1, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %2, %arg0  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    %7 = llvm.select %4, %0, %6 : i1, i1
    %8 = llvm.zext %7 : i1 to i32
    llvm.return %8 : i32
  }]

theorem inst_combine_main7e_logical   : main7e_logical_before  ⊑  main7e_logical_combined := by
  unfold main7e_logical_before main7e_logical_combined
  simp_alive_peephole
  sorry
def main7f_combined := [llvmfunc|
  llvm.func @main7f(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.and %arg1, %arg3  : i32
    %1 = llvm.and %arg2, %arg4  : i32
    %2 = llvm.or %0, %1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main7f   : main7f_before  ⊑  main7f_combined := by
  unfold main7f_before main7f_combined
  simp_alive_peephole
  sorry
def main7f_logical_combined := [llvmfunc|
  llvm.func @main7f_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg3  : i32
    %2 = llvm.and %arg2, %arg4  : i32
    %3 = llvm.and %1, %arg0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %2, %arg0  : i32
    %6 = llvm.icmp "ne" %2, %5 : i32
    %7 = llvm.select %4, %0, %6 : i1, i1
    %8 = llvm.zext %7 : i1 to i32
    llvm.return %8 : i32
  }]

theorem inst_combine_main7f_logical   : main7f_logical_before  ⊑  main7f_logical_combined := by
  unfold main7f_logical_before main7f_logical_combined
  simp_alive_peephole
  sorry
def main7g_combined := [llvmfunc|
  llvm.func @main7g(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.and %arg1, %arg3  : i32
    %1 = llvm.and %arg2, %arg4  : i32
    %2 = llvm.or %0, %1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main7g   : main7g_before  ⊑  main7g_combined := by
  unfold main7g_before main7g_combined
  simp_alive_peephole
  sorry
def main7g_logical_combined := [llvmfunc|
  llvm.func @main7g_logical(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg3  : i32
    %2 = llvm.and %arg2, %arg4  : i32
    %3 = llvm.and %1, %arg0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %2, %arg0  : i32
    %6 = llvm.icmp "ne" %2, %5 : i32
    %7 = llvm.select %4, %0, %6 : i1, i1
    %8 = llvm.zext %7 : i1 to i32
    llvm.return %8 : i32
  }]

theorem inst_combine_main7g_logical   : main7g_logical_before  ⊑  main7g_logical_combined := by
  unfold main7g_logical_before main7g_logical_combined
  simp_alive_peephole
  sorry
def main8_combined := [llvmfunc|
  llvm.func @main8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(192 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main8   : main8_before  ⊑  main8_combined := by
  unfold main8_before main8_combined
  simp_alive_peephole
  sorry
def main8_logical_combined := [llvmfunc|
  llvm.func @main8_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(192 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main8_logical   : main8_logical_before  ⊑  main8_logical_combined := by
  unfold main8_logical_before main8_logical_combined
  simp_alive_peephole
  sorry
def main9_combined := [llvmfunc|
  llvm.func @main9(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(192 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main9   : main9_before  ⊑  main9_combined := by
  unfold main9_before main9_combined
  simp_alive_peephole
  sorry
def main9_logical_combined := [llvmfunc|
  llvm.func @main9_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(192 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main9_logical   : main9_logical_before  ⊑  main9_logical_combined := by
  unfold main9_logical_before main9_logical_combined
  simp_alive_peephole
  sorry
def main10_combined := [llvmfunc|
  llvm.func @main10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(192 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main10   : main10_before  ⊑  main10_combined := by
  unfold main10_before main10_combined
  simp_alive_peephole
  sorry
def main10_logical_combined := [llvmfunc|
  llvm.func @main10_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(192 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main10_logical   : main10_logical_before  ⊑  main10_logical_combined := by
  unfold main10_logical_before main10_logical_combined
  simp_alive_peephole
  sorry
def main11_combined := [llvmfunc|
  llvm.func @main11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(192 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main11   : main11_before  ⊑  main11_combined := by
  unfold main11_before main11_combined
  simp_alive_peephole
  sorry
def main11_logical_combined := [llvmfunc|
  llvm.func @main11_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(192 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main11_logical   : main11_logical_before  ⊑  main11_logical_combined := by
  unfold main11_logical_before main11_logical_combined
  simp_alive_peephole
  sorry
def main12_combined := [llvmfunc|
  llvm.func @main12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32896 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main12   : main12_before  ⊑  main12_combined := by
  unfold main12_before main12_combined
  simp_alive_peephole
  sorry
def main12_logical_combined := [llvmfunc|
  llvm.func @main12_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32896 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main12_logical   : main12_logical_before  ⊑  main12_logical_combined := by
  unfold main12_logical_before main12_logical_combined
  simp_alive_peephole
  sorry
def main13_combined := [llvmfunc|
  llvm.func @main13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32896 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main13   : main13_before  ⊑  main13_combined := by
  unfold main13_before main13_combined
  simp_alive_peephole
  sorry
def main13_logical_combined := [llvmfunc|
  llvm.func @main13_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32896 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main13_logical   : main13_logical_before  ⊑  main13_logical_combined := by
  unfold main13_logical_before main13_logical_combined
  simp_alive_peephole
  sorry
def main14_combined := [llvmfunc|
  llvm.func @main14(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32896 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main14   : main14_before  ⊑  main14_combined := by
  unfold main14_before main14_combined
  simp_alive_peephole
  sorry
def main14_logical_combined := [llvmfunc|
  llvm.func @main14_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32896 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_main14_logical   : main14_logical_before  ⊑  main14_logical_combined := by
  unfold main14_logical_before main14_logical_combined
  simp_alive_peephole
  sorry
def main15_combined := [llvmfunc|
  llvm.func @main15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32896 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main15   : main15_before  ⊑  main15_combined := by
  unfold main15_before main15_combined
  simp_alive_peephole
  sorry
def main15_logical_combined := [llvmfunc|
  llvm.func @main15_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32896 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main15_logical   : main15_logical_before  ⊑  main15_logical_combined := by
  unfold main15_logical_before main15_logical_combined
  simp_alive_peephole
  sorry
