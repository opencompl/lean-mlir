import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-shr-lt-gt
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def lshrugt_01_00_before := [llvmfunc|
  llvm.func @lshrugt_01_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_01_before := [llvmfunc|
  llvm.func @lshrugt_01_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def lshrugt_01_02_before := [llvmfunc|
  llvm.func @lshrugt_01_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_03_before := [llvmfunc|
  llvm.func @lshrugt_01_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_04_before := [llvmfunc|
  llvm.func @lshrugt_01_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_05_before := [llvmfunc|
  llvm.func @lshrugt_01_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_06_before := [llvmfunc|
  llvm.func @lshrugt_01_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_07_before := [llvmfunc|
  llvm.func @lshrugt_01_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_08_before := [llvmfunc|
  llvm.func @lshrugt_01_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_09_before := [llvmfunc|
  llvm.func @lshrugt_01_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_10_before := [llvmfunc|
  llvm.func @lshrugt_01_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_11_before := [llvmfunc|
  llvm.func @lshrugt_01_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_12_before := [llvmfunc|
  llvm.func @lshrugt_01_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_13_before := [llvmfunc|
  llvm.func @lshrugt_01_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_14_before := [llvmfunc|
  llvm.func @lshrugt_01_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_15_before := [llvmfunc|
  llvm.func @lshrugt_01_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_00_before := [llvmfunc|
  llvm.func @lshrugt_02_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_01_before := [llvmfunc|
  llvm.func @lshrugt_02_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_02_before := [llvmfunc|
  llvm.func @lshrugt_02_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def lshrugt_02_03_before := [llvmfunc|
  llvm.func @lshrugt_02_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_04_before := [llvmfunc|
  llvm.func @lshrugt_02_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_05_before := [llvmfunc|
  llvm.func @lshrugt_02_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_06_before := [llvmfunc|
  llvm.func @lshrugt_02_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_07_before := [llvmfunc|
  llvm.func @lshrugt_02_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_08_before := [llvmfunc|
  llvm.func @lshrugt_02_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_09_before := [llvmfunc|
  llvm.func @lshrugt_02_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_10_before := [llvmfunc|
  llvm.func @lshrugt_02_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_11_before := [llvmfunc|
  llvm.func @lshrugt_02_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_12_before := [llvmfunc|
  llvm.func @lshrugt_02_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_13_before := [llvmfunc|
  llvm.func @lshrugt_02_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_14_before := [llvmfunc|
  llvm.func @lshrugt_02_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_15_before := [llvmfunc|
  llvm.func @lshrugt_02_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_00_before := [llvmfunc|
  llvm.func @lshrugt_03_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_01_before := [llvmfunc|
  llvm.func @lshrugt_03_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_02_before := [llvmfunc|
  llvm.func @lshrugt_03_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_03_before := [llvmfunc|
  llvm.func @lshrugt_03_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def lshrugt_03_04_before := [llvmfunc|
  llvm.func @lshrugt_03_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_05_before := [llvmfunc|
  llvm.func @lshrugt_03_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_06_before := [llvmfunc|
  llvm.func @lshrugt_03_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_07_before := [llvmfunc|
  llvm.func @lshrugt_03_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_08_before := [llvmfunc|
  llvm.func @lshrugt_03_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_09_before := [llvmfunc|
  llvm.func @lshrugt_03_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_10_before := [llvmfunc|
  llvm.func @lshrugt_03_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_11_before := [llvmfunc|
  llvm.func @lshrugt_03_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_12_before := [llvmfunc|
  llvm.func @lshrugt_03_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_13_before := [llvmfunc|
  llvm.func @lshrugt_03_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_14_before := [llvmfunc|
  llvm.func @lshrugt_03_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_15_before := [llvmfunc|
  llvm.func @lshrugt_03_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_00_before := [llvmfunc|
  llvm.func @lshrult_01_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_01_before := [llvmfunc|
  llvm.func @lshrult_01_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }]

def lshrult_01_02_before := [llvmfunc|
  llvm.func @lshrult_01_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_03_before := [llvmfunc|
  llvm.func @lshrult_01_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_04_before := [llvmfunc|
  llvm.func @lshrult_01_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_05_before := [llvmfunc|
  llvm.func @lshrult_01_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_06_before := [llvmfunc|
  llvm.func @lshrult_01_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_07_before := [llvmfunc|
  llvm.func @lshrult_01_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_08_before := [llvmfunc|
  llvm.func @lshrult_01_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_09_before := [llvmfunc|
  llvm.func @lshrult_01_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_10_before := [llvmfunc|
  llvm.func @lshrult_01_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_11_before := [llvmfunc|
  llvm.func @lshrult_01_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_12_before := [llvmfunc|
  llvm.func @lshrult_01_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_13_before := [llvmfunc|
  llvm.func @lshrult_01_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_14_before := [llvmfunc|
  llvm.func @lshrult_01_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_15_before := [llvmfunc|
  llvm.func @lshrult_01_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_00_before := [llvmfunc|
  llvm.func @lshrult_02_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_01_before := [llvmfunc|
  llvm.func @lshrult_02_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_02_before := [llvmfunc|
  llvm.func @lshrult_02_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }]

def lshrult_02_03_before := [llvmfunc|
  llvm.func @lshrult_02_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_04_before := [llvmfunc|
  llvm.func @lshrult_02_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_05_before := [llvmfunc|
  llvm.func @lshrult_02_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_06_before := [llvmfunc|
  llvm.func @lshrult_02_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_07_before := [llvmfunc|
  llvm.func @lshrult_02_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_08_before := [llvmfunc|
  llvm.func @lshrult_02_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_09_before := [llvmfunc|
  llvm.func @lshrult_02_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_10_before := [llvmfunc|
  llvm.func @lshrult_02_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_11_before := [llvmfunc|
  llvm.func @lshrult_02_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_12_before := [llvmfunc|
  llvm.func @lshrult_02_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_13_before := [llvmfunc|
  llvm.func @lshrult_02_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_14_before := [llvmfunc|
  llvm.func @lshrult_02_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_15_before := [llvmfunc|
  llvm.func @lshrult_02_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_00_before := [llvmfunc|
  llvm.func @lshrult_03_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_01_before := [llvmfunc|
  llvm.func @lshrult_03_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_02_before := [llvmfunc|
  llvm.func @lshrult_03_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_03_before := [llvmfunc|
  llvm.func @lshrult_03_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }]

def lshrult_03_04_before := [llvmfunc|
  llvm.func @lshrult_03_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_05_before := [llvmfunc|
  llvm.func @lshrult_03_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_06_before := [llvmfunc|
  llvm.func @lshrult_03_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_07_before := [llvmfunc|
  llvm.func @lshrult_03_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_08_before := [llvmfunc|
  llvm.func @lshrult_03_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_09_before := [llvmfunc|
  llvm.func @lshrult_03_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_10_before := [llvmfunc|
  llvm.func @lshrult_03_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_11_before := [llvmfunc|
  llvm.func @lshrult_03_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_12_before := [llvmfunc|
  llvm.func @lshrult_03_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_13_before := [llvmfunc|
  llvm.func @lshrult_03_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_14_before := [llvmfunc|
  llvm.func @lshrult_03_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_15_before := [llvmfunc|
  llvm.func @lshrult_03_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_00_before := [llvmfunc|
  llvm.func @ashrsgt_01_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_00_multiuse_before := [llvmfunc|
  llvm.func @ashrsgt_01_00_multiuse(%arg0: i4, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.store %2, %arg1 {alignment = 1 : i64} : i4, !llvm.ptr]

    llvm.return %3 : i1
  }]

def ashrsgt_01_01_before := [llvmfunc|
  llvm.func @ashrsgt_01_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashrsgt_01_02_before := [llvmfunc|
  llvm.func @ashrsgt_01_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_03_before := [llvmfunc|
  llvm.func @ashrsgt_01_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_04_before := [llvmfunc|
  llvm.func @ashrsgt_01_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_05_before := [llvmfunc|
  llvm.func @ashrsgt_01_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_06_before := [llvmfunc|
  llvm.func @ashrsgt_01_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_07_before := [llvmfunc|
  llvm.func @ashrsgt_01_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_08_before := [llvmfunc|
  llvm.func @ashrsgt_01_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_09_before := [llvmfunc|
  llvm.func @ashrsgt_01_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_10_before := [llvmfunc|
  llvm.func @ashrsgt_01_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_11_before := [llvmfunc|
  llvm.func @ashrsgt_01_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_12_before := [llvmfunc|
  llvm.func @ashrsgt_01_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_13_before := [llvmfunc|
  llvm.func @ashrsgt_01_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_14_before := [llvmfunc|
  llvm.func @ashrsgt_01_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_15_before := [llvmfunc|
  llvm.func @ashrsgt_01_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_00_before := [llvmfunc|
  llvm.func @ashrsgt_02_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_01_before := [llvmfunc|
  llvm.func @ashrsgt_02_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_02_before := [llvmfunc|
  llvm.func @ashrsgt_02_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashrsgt_02_03_before := [llvmfunc|
  llvm.func @ashrsgt_02_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_04_before := [llvmfunc|
  llvm.func @ashrsgt_02_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_05_before := [llvmfunc|
  llvm.func @ashrsgt_02_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_06_before := [llvmfunc|
  llvm.func @ashrsgt_02_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_07_before := [llvmfunc|
  llvm.func @ashrsgt_02_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_08_before := [llvmfunc|
  llvm.func @ashrsgt_02_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_09_before := [llvmfunc|
  llvm.func @ashrsgt_02_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_10_before := [llvmfunc|
  llvm.func @ashrsgt_02_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_11_before := [llvmfunc|
  llvm.func @ashrsgt_02_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_12_before := [llvmfunc|
  llvm.func @ashrsgt_02_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_13_before := [llvmfunc|
  llvm.func @ashrsgt_02_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_14_before := [llvmfunc|
  llvm.func @ashrsgt_02_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_15_before := [llvmfunc|
  llvm.func @ashrsgt_02_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_00_before := [llvmfunc|
  llvm.func @ashrsgt_03_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_01_before := [llvmfunc|
  llvm.func @ashrsgt_03_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_02_before := [llvmfunc|
  llvm.func @ashrsgt_03_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_03_before := [llvmfunc|
  llvm.func @ashrsgt_03_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashrsgt_03_04_before := [llvmfunc|
  llvm.func @ashrsgt_03_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_05_before := [llvmfunc|
  llvm.func @ashrsgt_03_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_06_before := [llvmfunc|
  llvm.func @ashrsgt_03_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_07_before := [llvmfunc|
  llvm.func @ashrsgt_03_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_08_before := [llvmfunc|
  llvm.func @ashrsgt_03_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_09_before := [llvmfunc|
  llvm.func @ashrsgt_03_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_10_before := [llvmfunc|
  llvm.func @ashrsgt_03_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_11_before := [llvmfunc|
  llvm.func @ashrsgt_03_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_12_before := [llvmfunc|
  llvm.func @ashrsgt_03_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_13_before := [llvmfunc|
  llvm.func @ashrsgt_03_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_14_before := [llvmfunc|
  llvm.func @ashrsgt_03_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_15_before := [llvmfunc|
  llvm.func @ashrsgt_03_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_00_before := [llvmfunc|
  llvm.func @ashrslt_01_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_01_before := [llvmfunc|
  llvm.func @ashrslt_01_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashrslt_01_02_before := [llvmfunc|
  llvm.func @ashrslt_01_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_03_before := [llvmfunc|
  llvm.func @ashrslt_01_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_04_before := [llvmfunc|
  llvm.func @ashrslt_01_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_05_before := [llvmfunc|
  llvm.func @ashrslt_01_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_06_before := [llvmfunc|
  llvm.func @ashrslt_01_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_07_before := [llvmfunc|
  llvm.func @ashrslt_01_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_08_before := [llvmfunc|
  llvm.func @ashrslt_01_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_09_before := [llvmfunc|
  llvm.func @ashrslt_01_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_10_before := [llvmfunc|
  llvm.func @ashrslt_01_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_11_before := [llvmfunc|
  llvm.func @ashrslt_01_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_12_before := [llvmfunc|
  llvm.func @ashrslt_01_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_13_before := [llvmfunc|
  llvm.func @ashrslt_01_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_14_before := [llvmfunc|
  llvm.func @ashrslt_01_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_15_before := [llvmfunc|
  llvm.func @ashrslt_01_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_00_before := [llvmfunc|
  llvm.func @ashrslt_02_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_01_before := [llvmfunc|
  llvm.func @ashrslt_02_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_02_before := [llvmfunc|
  llvm.func @ashrslt_02_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashrslt_02_03_before := [llvmfunc|
  llvm.func @ashrslt_02_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_04_before := [llvmfunc|
  llvm.func @ashrslt_02_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_05_before := [llvmfunc|
  llvm.func @ashrslt_02_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_06_before := [llvmfunc|
  llvm.func @ashrslt_02_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_07_before := [llvmfunc|
  llvm.func @ashrslt_02_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_08_before := [llvmfunc|
  llvm.func @ashrslt_02_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_09_before := [llvmfunc|
  llvm.func @ashrslt_02_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_10_before := [llvmfunc|
  llvm.func @ashrslt_02_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_11_before := [llvmfunc|
  llvm.func @ashrslt_02_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_12_before := [llvmfunc|
  llvm.func @ashrslt_02_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_13_before := [llvmfunc|
  llvm.func @ashrslt_02_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_14_before := [llvmfunc|
  llvm.func @ashrslt_02_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_15_before := [llvmfunc|
  llvm.func @ashrslt_02_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_00_before := [llvmfunc|
  llvm.func @ashrslt_03_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_01_before := [llvmfunc|
  llvm.func @ashrslt_03_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_02_before := [llvmfunc|
  llvm.func @ashrslt_03_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_03_before := [llvmfunc|
  llvm.func @ashrslt_03_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashrslt_03_04_before := [llvmfunc|
  llvm.func @ashrslt_03_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_05_before := [llvmfunc|
  llvm.func @ashrslt_03_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_06_before := [llvmfunc|
  llvm.func @ashrslt_03_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_07_before := [llvmfunc|
  llvm.func @ashrslt_03_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_08_before := [llvmfunc|
  llvm.func @ashrslt_03_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_09_before := [llvmfunc|
  llvm.func @ashrslt_03_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_10_before := [llvmfunc|
  llvm.func @ashrslt_03_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_11_before := [llvmfunc|
  llvm.func @ashrslt_03_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_12_before := [llvmfunc|
  llvm.func @ashrslt_03_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_13_before := [llvmfunc|
  llvm.func @ashrslt_03_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_14_before := [llvmfunc|
  llvm.func @ashrslt_03_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_15_before := [llvmfunc|
  llvm.func @ashrslt_03_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_00_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_01_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def lshrugt_01_02_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_03_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_04_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_05_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_06_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_07_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_08_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_09_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_10_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_11_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_12_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_13_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_14_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_01_15_exact_before := [llvmfunc|
  llvm.func @lshrugt_01_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_00_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_01_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_02_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def lshrugt_02_03_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_04_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_05_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_06_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_07_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_08_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_09_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_10_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_11_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_12_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_13_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_14_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_02_15_exact_before := [llvmfunc|
  llvm.func @lshrugt_02_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_00_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_01_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_02_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_03_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def lshrugt_03_04_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_05_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_06_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_07_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_08_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_09_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_10_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_11_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_12_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_13_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_14_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrugt_03_15_exact_before := [llvmfunc|
  llvm.func @lshrugt_03_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_eq_exact_before := [llvmfunc|
  llvm.func @ashr_eq_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_ne_exact_before := [llvmfunc|
  llvm.func @ashr_ne_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_ugt_exact_before := [llvmfunc|
  llvm.func @ashr_ugt_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_uge_exact_before := [llvmfunc|
  llvm.func @ashr_uge_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_ult_exact_before := [llvmfunc|
  llvm.func @ashr_ult_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_ule_exact_before := [llvmfunc|
  llvm.func @ashr_ule_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ule" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_sgt_exact_before := [llvmfunc|
  llvm.func @ashr_sgt_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_sge_exact_before := [llvmfunc|
  llvm.func @ashr_sge_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_slt_exact_before := [llvmfunc|
  llvm.func @ashr_slt_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_sle_exact_before := [llvmfunc|
  llvm.func @ashr_sle_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_eq_noexact_before := [llvmfunc|
  llvm.func @ashr_eq_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_ne_noexact_before := [llvmfunc|
  llvm.func @ashr_ne_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_ugt_noexact_before := [llvmfunc|
  llvm.func @ashr_ugt_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_uge_noexact_before := [llvmfunc|
  llvm.func @ashr_uge_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_ult_noexact_before := [llvmfunc|
  llvm.func @ashr_ult_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_ule_noexact_before := [llvmfunc|
  llvm.func @ashr_ule_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ule" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_sgt_noexact_before := [llvmfunc|
  llvm.func @ashr_sgt_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_sge_noexact_before := [llvmfunc|
  llvm.func @ashr_sge_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_slt_noexact_before := [llvmfunc|
  llvm.func @ashr_slt_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_sle_noexact_before := [llvmfunc|
  llvm.func @ashr_sle_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_00_00_ashr_extra_use_before := [llvmfunc|
  llvm.func @ashr_00_00_ashr_extra_use(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ule" %2, %1 : i8
    llvm.store %2, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return %3 : i1
  }]

def ashr_00_00_vec_before := [llvmfunc|
  llvm.func @ashr_00_00_vec(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<10> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.ashr %arg0, %0  : vector<4xi8>
    %3 = llvm.icmp "ule" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }]

def ashr_sgt_overflow_before := [llvmfunc|
  llvm.func @ashr_sgt_overflow(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshrult_01_00_exact_before := [llvmfunc|
  llvm.func @lshrult_01_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_01_exact_before := [llvmfunc|
  llvm.func @lshrult_01_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }]

def lshrult_01_02_exact_before := [llvmfunc|
  llvm.func @lshrult_01_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_03_exact_before := [llvmfunc|
  llvm.func @lshrult_01_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_04_exact_before := [llvmfunc|
  llvm.func @lshrult_01_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_05_exact_before := [llvmfunc|
  llvm.func @lshrult_01_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_06_exact_before := [llvmfunc|
  llvm.func @lshrult_01_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_07_exact_before := [llvmfunc|
  llvm.func @lshrult_01_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_08_exact_before := [llvmfunc|
  llvm.func @lshrult_01_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_09_exact_before := [llvmfunc|
  llvm.func @lshrult_01_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_10_exact_before := [llvmfunc|
  llvm.func @lshrult_01_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_11_exact_before := [llvmfunc|
  llvm.func @lshrult_01_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_12_exact_before := [llvmfunc|
  llvm.func @lshrult_01_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_13_exact_before := [llvmfunc|
  llvm.func @lshrult_01_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_14_exact_before := [llvmfunc|
  llvm.func @lshrult_01_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_01_15_exact_before := [llvmfunc|
  llvm.func @lshrult_01_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_00_exact_before := [llvmfunc|
  llvm.func @lshrult_02_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_01_exact_before := [llvmfunc|
  llvm.func @lshrult_02_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_02_exact_before := [llvmfunc|
  llvm.func @lshrult_02_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }]

def lshrult_02_03_exact_before := [llvmfunc|
  llvm.func @lshrult_02_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_04_exact_before := [llvmfunc|
  llvm.func @lshrult_02_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_05_exact_before := [llvmfunc|
  llvm.func @lshrult_02_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_06_exact_before := [llvmfunc|
  llvm.func @lshrult_02_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_07_exact_before := [llvmfunc|
  llvm.func @lshrult_02_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_08_exact_before := [llvmfunc|
  llvm.func @lshrult_02_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_09_exact_before := [llvmfunc|
  llvm.func @lshrult_02_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_10_exact_before := [llvmfunc|
  llvm.func @lshrult_02_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_11_exact_before := [llvmfunc|
  llvm.func @lshrult_02_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_12_exact_before := [llvmfunc|
  llvm.func @lshrult_02_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_13_exact_before := [llvmfunc|
  llvm.func @lshrult_02_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_14_exact_before := [llvmfunc|
  llvm.func @lshrult_02_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_02_15_exact_before := [llvmfunc|
  llvm.func @lshrult_02_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_00_exact_before := [llvmfunc|
  llvm.func @lshrult_03_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_01_exact_before := [llvmfunc|
  llvm.func @lshrult_03_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_02_exact_before := [llvmfunc|
  llvm.func @lshrult_03_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_03_exact_before := [llvmfunc|
  llvm.func @lshrult_03_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.lshr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }]

def lshrult_03_04_exact_before := [llvmfunc|
  llvm.func @lshrult_03_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_05_exact_before := [llvmfunc|
  llvm.func @lshrult_03_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_06_exact_before := [llvmfunc|
  llvm.func @lshrult_03_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_07_exact_before := [llvmfunc|
  llvm.func @lshrult_03_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_08_exact_before := [llvmfunc|
  llvm.func @lshrult_03_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_09_exact_before := [llvmfunc|
  llvm.func @lshrult_03_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_10_exact_before := [llvmfunc|
  llvm.func @lshrult_03_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_11_exact_before := [llvmfunc|
  llvm.func @lshrult_03_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_12_exact_before := [llvmfunc|
  llvm.func @lshrult_03_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_13_exact_before := [llvmfunc|
  llvm.func @lshrult_03_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_14_exact_before := [llvmfunc|
  llvm.func @lshrult_03_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshrult_03_15_exact_before := [llvmfunc|
  llvm.func @lshrult_03_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.lshr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_00_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_01_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashrsgt_01_02_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_03_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_04_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_05_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_06_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_07_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_08_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_09_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_10_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_11_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_12_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_13_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_14_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_01_15_exact_before := [llvmfunc|
  llvm.func @ashrsgt_01_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_00_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_01_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_02_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashrsgt_02_03_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_04_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_05_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_06_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_07_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_08_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_09_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_10_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_11_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_12_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_13_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_14_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_02_15_exact_before := [llvmfunc|
  llvm.func @ashrsgt_02_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_00_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_01_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_02_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_03_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashrsgt_03_04_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_05_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_06_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_07_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_08_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_09_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_10_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_11_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_12_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_13_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_14_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrsgt_03_15_exact_before := [llvmfunc|
  llvm.func @ashrsgt_03_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_00_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_01_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashrslt_01_02_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_03_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_04_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_05_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_06_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_07_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_08_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_09_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_10_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_11_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_12_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_13_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_14_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_01_15_exact_before := [llvmfunc|
  llvm.func @ashrslt_01_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_00_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_01_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_02_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashrslt_02_03_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_04_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_05_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_06_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_07_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_08_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_09_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_10_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_11_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_12_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_13_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_14_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_02_15_exact_before := [llvmfunc|
  llvm.func @ashrslt_02_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_00_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_01_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_02_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_03_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "slt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashrslt_03_04_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_05_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_06_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_07_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_08_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_09_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_10_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_11_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_12_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_13_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_14_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashrslt_03_15_exact_before := [llvmfunc|
  llvm.func @ashrslt_03_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "slt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_slt_exact_near_pow2_cmpval_before := [llvmfunc|
  llvm.func @ashr_slt_exact_near_pow2_cmpval(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_ult_exact_near_pow2_cmpval_before := [llvmfunc|
  llvm.func @ashr_ult_exact_near_pow2_cmpval(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def negtest_near_pow2_cmpval_ashr_slt_noexact_before := [llvmfunc|
  llvm.func @negtest_near_pow2_cmpval_ashr_slt_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_before := [llvmfunc|
  llvm.func @negtest_near_pow2_cmpval_ashr_wrong_cmp_pred(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def negtest_near_pow2_cmpval_isnt_close_to_pow2_before := [llvmfunc|
  llvm.func @negtest_near_pow2_cmpval_isnt_close_to_pow2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def negtest_near_pow2_cmpval_would_overflow_into_signbit_before := [llvmfunc|
  llvm.func @negtest_near_pow2_cmpval_would_overflow_into_signbit(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(33 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshrugt_01_00_combined := [llvmfunc|
  llvm.func @lshrugt_01_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_00   : lshrugt_01_00_before  ⊑  lshrugt_01_00_combined := by
  unfold lshrugt_01_00_before lshrugt_01_00_combined
  simp_alive_peephole
  sorry
def lshrugt_01_01_combined := [llvmfunc|
  llvm.func @lshrugt_01_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_01   : lshrugt_01_01_before  ⊑  lshrugt_01_01_combined := by
  unfold lshrugt_01_01_before lshrugt_01_01_combined
  simp_alive_peephole
  sorry
def lshrugt_01_02_combined := [llvmfunc|
  llvm.func @lshrugt_01_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_02   : lshrugt_01_02_before  ⊑  lshrugt_01_02_combined := by
  unfold lshrugt_01_02_before lshrugt_01_02_combined
  simp_alive_peephole
  sorry
def lshrugt_01_03_combined := [llvmfunc|
  llvm.func @lshrugt_01_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_03   : lshrugt_01_03_before  ⊑  lshrugt_01_03_combined := by
  unfold lshrugt_01_03_before lshrugt_01_03_combined
  simp_alive_peephole
  sorry
def lshrugt_01_04_combined := [llvmfunc|
  llvm.func @lshrugt_01_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-7 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_04   : lshrugt_01_04_before  ⊑  lshrugt_01_04_combined := by
  unfold lshrugt_01_04_before lshrugt_01_04_combined
  simp_alive_peephole
  sorry
def lshrugt_01_05_combined := [llvmfunc|
  llvm.func @lshrugt_01_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-5 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_05   : lshrugt_01_05_before  ⊑  lshrugt_01_05_combined := by
  unfold lshrugt_01_05_before lshrugt_01_05_combined
  simp_alive_peephole
  sorry
def lshrugt_01_06_combined := [llvmfunc|
  llvm.func @lshrugt_01_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-3 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_06   : lshrugt_01_06_before  ⊑  lshrugt_01_06_combined := by
  unfold lshrugt_01_06_before lshrugt_01_06_combined
  simp_alive_peephole
  sorry
def lshrugt_01_07_combined := [llvmfunc|
  llvm.func @lshrugt_01_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_07   : lshrugt_01_07_before  ⊑  lshrugt_01_07_combined := by
  unfold lshrugt_01_07_before lshrugt_01_07_combined
  simp_alive_peephole
  sorry
def lshrugt_01_08_combined := [llvmfunc|
  llvm.func @lshrugt_01_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_08   : lshrugt_01_08_before  ⊑  lshrugt_01_08_combined := by
  unfold lshrugt_01_08_before lshrugt_01_08_combined
  simp_alive_peephole
  sorry
def lshrugt_01_09_combined := [llvmfunc|
  llvm.func @lshrugt_01_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_09   : lshrugt_01_09_before  ⊑  lshrugt_01_09_combined := by
  unfold lshrugt_01_09_before lshrugt_01_09_combined
  simp_alive_peephole
  sorry
def lshrugt_01_10_combined := [llvmfunc|
  llvm.func @lshrugt_01_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_10   : lshrugt_01_10_before  ⊑  lshrugt_01_10_combined := by
  unfold lshrugt_01_10_before lshrugt_01_10_combined
  simp_alive_peephole
  sorry
def lshrugt_01_11_combined := [llvmfunc|
  llvm.func @lshrugt_01_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_11   : lshrugt_01_11_before  ⊑  lshrugt_01_11_combined := by
  unfold lshrugt_01_11_before lshrugt_01_11_combined
  simp_alive_peephole
  sorry
def lshrugt_01_12_combined := [llvmfunc|
  llvm.func @lshrugt_01_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_12   : lshrugt_01_12_before  ⊑  lshrugt_01_12_combined := by
  unfold lshrugt_01_12_before lshrugt_01_12_combined
  simp_alive_peephole
  sorry
def lshrugt_01_13_combined := [llvmfunc|
  llvm.func @lshrugt_01_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_13   : lshrugt_01_13_before  ⊑  lshrugt_01_13_combined := by
  unfold lshrugt_01_13_before lshrugt_01_13_combined
  simp_alive_peephole
  sorry
def lshrugt_01_14_combined := [llvmfunc|
  llvm.func @lshrugt_01_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_14   : lshrugt_01_14_before  ⊑  lshrugt_01_14_combined := by
  unfold lshrugt_01_14_before lshrugt_01_14_combined
  simp_alive_peephole
  sorry
def lshrugt_01_15_combined := [llvmfunc|
  llvm.func @lshrugt_01_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_15   : lshrugt_01_15_before  ⊑  lshrugt_01_15_combined := by
  unfold lshrugt_01_15_before lshrugt_01_15_combined
  simp_alive_peephole
  sorry
def lshrugt_02_00_combined := [llvmfunc|
  llvm.func @lshrugt_02_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_02_00   : lshrugt_02_00_before  ⊑  lshrugt_02_00_combined := by
  unfold lshrugt_02_00_before lshrugt_02_00_combined
  simp_alive_peephole
  sorry
def lshrugt_02_01_combined := [llvmfunc|
  llvm.func @lshrugt_02_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_02_01   : lshrugt_02_01_before  ⊑  lshrugt_02_01_combined := by
  unfold lshrugt_02_01_before lshrugt_02_01_combined
  simp_alive_peephole
  sorry
def lshrugt_02_02_combined := [llvmfunc|
  llvm.func @lshrugt_02_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-5 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_02_02   : lshrugt_02_02_before  ⊑  lshrugt_02_02_combined := by
  unfold lshrugt_02_02_before lshrugt_02_02_combined
  simp_alive_peephole
  sorry
def lshrugt_02_03_combined := [llvmfunc|
  llvm.func @lshrugt_02_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_03   : lshrugt_02_03_before  ⊑  lshrugt_02_03_combined := by
  unfold lshrugt_02_03_before lshrugt_02_03_combined
  simp_alive_peephole
  sorry
def lshrugt_02_04_combined := [llvmfunc|
  llvm.func @lshrugt_02_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_04   : lshrugt_02_04_before  ⊑  lshrugt_02_04_combined := by
  unfold lshrugt_02_04_before lshrugt_02_04_combined
  simp_alive_peephole
  sorry
def lshrugt_02_05_combined := [llvmfunc|
  llvm.func @lshrugt_02_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_05   : lshrugt_02_05_before  ⊑  lshrugt_02_05_combined := by
  unfold lshrugt_02_05_before lshrugt_02_05_combined
  simp_alive_peephole
  sorry
def lshrugt_02_06_combined := [llvmfunc|
  llvm.func @lshrugt_02_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_06   : lshrugt_02_06_before  ⊑  lshrugt_02_06_combined := by
  unfold lshrugt_02_06_before lshrugt_02_06_combined
  simp_alive_peephole
  sorry
def lshrugt_02_07_combined := [llvmfunc|
  llvm.func @lshrugt_02_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_07   : lshrugt_02_07_before  ⊑  lshrugt_02_07_combined := by
  unfold lshrugt_02_07_before lshrugt_02_07_combined
  simp_alive_peephole
  sorry
def lshrugt_02_08_combined := [llvmfunc|
  llvm.func @lshrugt_02_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_08   : lshrugt_02_08_before  ⊑  lshrugt_02_08_combined := by
  unfold lshrugt_02_08_before lshrugt_02_08_combined
  simp_alive_peephole
  sorry
def lshrugt_02_09_combined := [llvmfunc|
  llvm.func @lshrugt_02_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_09   : lshrugt_02_09_before  ⊑  lshrugt_02_09_combined := by
  unfold lshrugt_02_09_before lshrugt_02_09_combined
  simp_alive_peephole
  sorry
def lshrugt_02_10_combined := [llvmfunc|
  llvm.func @lshrugt_02_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_10   : lshrugt_02_10_before  ⊑  lshrugt_02_10_combined := by
  unfold lshrugt_02_10_before lshrugt_02_10_combined
  simp_alive_peephole
  sorry
def lshrugt_02_11_combined := [llvmfunc|
  llvm.func @lshrugt_02_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_11   : lshrugt_02_11_before  ⊑  lshrugt_02_11_combined := by
  unfold lshrugt_02_11_before lshrugt_02_11_combined
  simp_alive_peephole
  sorry
def lshrugt_02_12_combined := [llvmfunc|
  llvm.func @lshrugt_02_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_12   : lshrugt_02_12_before  ⊑  lshrugt_02_12_combined := by
  unfold lshrugt_02_12_before lshrugt_02_12_combined
  simp_alive_peephole
  sorry
def lshrugt_02_13_combined := [llvmfunc|
  llvm.func @lshrugt_02_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_13   : lshrugt_02_13_before  ⊑  lshrugt_02_13_combined := by
  unfold lshrugt_02_13_before lshrugt_02_13_combined
  simp_alive_peephole
  sorry
def lshrugt_02_14_combined := [llvmfunc|
  llvm.func @lshrugt_02_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_14   : lshrugt_02_14_before  ⊑  lshrugt_02_14_combined := by
  unfold lshrugt_02_14_before lshrugt_02_14_combined
  simp_alive_peephole
  sorry
def lshrugt_02_15_combined := [llvmfunc|
  llvm.func @lshrugt_02_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_15   : lshrugt_02_15_before  ⊑  lshrugt_02_15_combined := by
  unfold lshrugt_02_15_before lshrugt_02_15_combined
  simp_alive_peephole
  sorry
def lshrugt_03_00_combined := [llvmfunc|
  llvm.func @lshrugt_03_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_03_00   : lshrugt_03_00_before  ⊑  lshrugt_03_00_combined := by
  unfold lshrugt_03_00_before lshrugt_03_00_combined
  simp_alive_peephole
  sorry
def lshrugt_03_01_combined := [llvmfunc|
  llvm.func @lshrugt_03_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_01   : lshrugt_03_01_before  ⊑  lshrugt_03_01_combined := by
  unfold lshrugt_03_01_before lshrugt_03_01_combined
  simp_alive_peephole
  sorry
def lshrugt_03_02_combined := [llvmfunc|
  llvm.func @lshrugt_03_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_02   : lshrugt_03_02_before  ⊑  lshrugt_03_02_combined := by
  unfold lshrugt_03_02_before lshrugt_03_02_combined
  simp_alive_peephole
  sorry
def lshrugt_03_03_combined := [llvmfunc|
  llvm.func @lshrugt_03_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_03   : lshrugt_03_03_before  ⊑  lshrugt_03_03_combined := by
  unfold lshrugt_03_03_before lshrugt_03_03_combined
  simp_alive_peephole
  sorry
def lshrugt_03_04_combined := [llvmfunc|
  llvm.func @lshrugt_03_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_04   : lshrugt_03_04_before  ⊑  lshrugt_03_04_combined := by
  unfold lshrugt_03_04_before lshrugt_03_04_combined
  simp_alive_peephole
  sorry
def lshrugt_03_05_combined := [llvmfunc|
  llvm.func @lshrugt_03_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_05   : lshrugt_03_05_before  ⊑  lshrugt_03_05_combined := by
  unfold lshrugt_03_05_before lshrugt_03_05_combined
  simp_alive_peephole
  sorry
def lshrugt_03_06_combined := [llvmfunc|
  llvm.func @lshrugt_03_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_06   : lshrugt_03_06_before  ⊑  lshrugt_03_06_combined := by
  unfold lshrugt_03_06_before lshrugt_03_06_combined
  simp_alive_peephole
  sorry
def lshrugt_03_07_combined := [llvmfunc|
  llvm.func @lshrugt_03_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_07   : lshrugt_03_07_before  ⊑  lshrugt_03_07_combined := by
  unfold lshrugt_03_07_before lshrugt_03_07_combined
  simp_alive_peephole
  sorry
def lshrugt_03_08_combined := [llvmfunc|
  llvm.func @lshrugt_03_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_08   : lshrugt_03_08_before  ⊑  lshrugt_03_08_combined := by
  unfold lshrugt_03_08_before lshrugt_03_08_combined
  simp_alive_peephole
  sorry
def lshrugt_03_09_combined := [llvmfunc|
  llvm.func @lshrugt_03_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_09   : lshrugt_03_09_before  ⊑  lshrugt_03_09_combined := by
  unfold lshrugt_03_09_before lshrugt_03_09_combined
  simp_alive_peephole
  sorry
def lshrugt_03_10_combined := [llvmfunc|
  llvm.func @lshrugt_03_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_10   : lshrugt_03_10_before  ⊑  lshrugt_03_10_combined := by
  unfold lshrugt_03_10_before lshrugt_03_10_combined
  simp_alive_peephole
  sorry
def lshrugt_03_11_combined := [llvmfunc|
  llvm.func @lshrugt_03_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_11   : lshrugt_03_11_before  ⊑  lshrugt_03_11_combined := by
  unfold lshrugt_03_11_before lshrugt_03_11_combined
  simp_alive_peephole
  sorry
def lshrugt_03_12_combined := [llvmfunc|
  llvm.func @lshrugt_03_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_12   : lshrugt_03_12_before  ⊑  lshrugt_03_12_combined := by
  unfold lshrugt_03_12_before lshrugt_03_12_combined
  simp_alive_peephole
  sorry
def lshrugt_03_13_combined := [llvmfunc|
  llvm.func @lshrugt_03_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_13   : lshrugt_03_13_before  ⊑  lshrugt_03_13_combined := by
  unfold lshrugt_03_13_before lshrugt_03_13_combined
  simp_alive_peephole
  sorry
def lshrugt_03_14_combined := [llvmfunc|
  llvm.func @lshrugt_03_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_14   : lshrugt_03_14_before  ⊑  lshrugt_03_14_combined := by
  unfold lshrugt_03_14_before lshrugt_03_14_combined
  simp_alive_peephole
  sorry
def lshrugt_03_15_combined := [llvmfunc|
  llvm.func @lshrugt_03_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_15   : lshrugt_03_15_before  ⊑  lshrugt_03_15_combined := by
  unfold lshrugt_03_15_before lshrugt_03_15_combined
  simp_alive_peephole
  sorry
def lshrult_01_00_combined := [llvmfunc|
  llvm.func @lshrult_01_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_00   : lshrult_01_00_before  ⊑  lshrult_01_00_combined := by
  unfold lshrult_01_00_before lshrult_01_00_combined
  simp_alive_peephole
  sorry
def lshrult_01_01_combined := [llvmfunc|
  llvm.func @lshrult_01_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_01   : lshrult_01_01_before  ⊑  lshrult_01_01_combined := by
  unfold lshrult_01_01_before lshrult_01_01_combined
  simp_alive_peephole
  sorry
def lshrult_01_02_combined := [llvmfunc|
  llvm.func @lshrult_01_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(4 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_02   : lshrult_01_02_before  ⊑  lshrult_01_02_combined := by
  unfold lshrult_01_02_before lshrult_01_02_combined
  simp_alive_peephole
  sorry
def lshrult_01_03_combined := [llvmfunc|
  llvm.func @lshrult_01_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_03   : lshrult_01_03_before  ⊑  lshrult_01_03_combined := by
  unfold lshrult_01_03_before lshrult_01_03_combined
  simp_alive_peephole
  sorry
def lshrult_01_04_combined := [llvmfunc|
  llvm.func @lshrult_01_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_04   : lshrult_01_04_before  ⊑  lshrult_01_04_combined := by
  unfold lshrult_01_04_before lshrult_01_04_combined
  simp_alive_peephole
  sorry
def lshrult_01_05_combined := [llvmfunc|
  llvm.func @lshrult_01_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_05   : lshrult_01_05_before  ⊑  lshrult_01_05_combined := by
  unfold lshrult_01_05_before lshrult_01_05_combined
  simp_alive_peephole
  sorry
def lshrult_01_06_combined := [llvmfunc|
  llvm.func @lshrult_01_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_06   : lshrult_01_06_before  ⊑  lshrult_01_06_combined := by
  unfold lshrult_01_06_before lshrult_01_06_combined
  simp_alive_peephole
  sorry
def lshrult_01_07_combined := [llvmfunc|
  llvm.func @lshrult_01_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_07   : lshrult_01_07_before  ⊑  lshrult_01_07_combined := by
  unfold lshrult_01_07_before lshrult_01_07_combined
  simp_alive_peephole
  sorry
def lshrult_01_08_combined := [llvmfunc|
  llvm.func @lshrult_01_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_08   : lshrult_01_08_before  ⊑  lshrult_01_08_combined := by
  unfold lshrult_01_08_before lshrult_01_08_combined
  simp_alive_peephole
  sorry
def lshrult_01_09_combined := [llvmfunc|
  llvm.func @lshrult_01_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_09   : lshrult_01_09_before  ⊑  lshrult_01_09_combined := by
  unfold lshrult_01_09_before lshrult_01_09_combined
  simp_alive_peephole
  sorry
def lshrult_01_10_combined := [llvmfunc|
  llvm.func @lshrult_01_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_10   : lshrult_01_10_before  ⊑  lshrult_01_10_combined := by
  unfold lshrult_01_10_before lshrult_01_10_combined
  simp_alive_peephole
  sorry
def lshrult_01_11_combined := [llvmfunc|
  llvm.func @lshrult_01_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_11   : lshrult_01_11_before  ⊑  lshrult_01_11_combined := by
  unfold lshrult_01_11_before lshrult_01_11_combined
  simp_alive_peephole
  sorry
def lshrult_01_12_combined := [llvmfunc|
  llvm.func @lshrult_01_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_12   : lshrult_01_12_before  ⊑  lshrult_01_12_combined := by
  unfold lshrult_01_12_before lshrult_01_12_combined
  simp_alive_peephole
  sorry
def lshrult_01_13_combined := [llvmfunc|
  llvm.func @lshrult_01_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_13   : lshrult_01_13_before  ⊑  lshrult_01_13_combined := by
  unfold lshrult_01_13_before lshrult_01_13_combined
  simp_alive_peephole
  sorry
def lshrult_01_14_combined := [llvmfunc|
  llvm.func @lshrult_01_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_14   : lshrult_01_14_before  ⊑  lshrult_01_14_combined := by
  unfold lshrult_01_14_before lshrult_01_14_combined
  simp_alive_peephole
  sorry
def lshrult_01_15_combined := [llvmfunc|
  llvm.func @lshrult_01_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_15   : lshrult_01_15_before  ⊑  lshrult_01_15_combined := by
  unfold lshrult_01_15_before lshrult_01_15_combined
  simp_alive_peephole
  sorry
def lshrult_02_00_combined := [llvmfunc|
  llvm.func @lshrult_02_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_00   : lshrult_02_00_before  ⊑  lshrult_02_00_combined := by
  unfold lshrult_02_00_before lshrult_02_00_combined
  simp_alive_peephole
  sorry
def lshrult_02_01_combined := [llvmfunc|
  llvm.func @lshrult_02_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(4 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_02_01   : lshrult_02_01_before  ⊑  lshrult_02_01_combined := by
  unfold lshrult_02_01_before lshrult_02_01_combined
  simp_alive_peephole
  sorry
def lshrult_02_02_combined := [llvmfunc|
  llvm.func @lshrult_02_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_02_02   : lshrult_02_02_before  ⊑  lshrult_02_02_combined := by
  unfold lshrult_02_02_before lshrult_02_02_combined
  simp_alive_peephole
  sorry
def lshrult_02_03_combined := [llvmfunc|
  llvm.func @lshrult_02_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_02_03   : lshrult_02_03_before  ⊑  lshrult_02_03_combined := by
  unfold lshrult_02_03_before lshrult_02_03_combined
  simp_alive_peephole
  sorry
def lshrult_02_04_combined := [llvmfunc|
  llvm.func @lshrult_02_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_04   : lshrult_02_04_before  ⊑  lshrult_02_04_combined := by
  unfold lshrult_02_04_before lshrult_02_04_combined
  simp_alive_peephole
  sorry
def lshrult_02_05_combined := [llvmfunc|
  llvm.func @lshrult_02_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_05   : lshrult_02_05_before  ⊑  lshrult_02_05_combined := by
  unfold lshrult_02_05_before lshrult_02_05_combined
  simp_alive_peephole
  sorry
def lshrult_02_06_combined := [llvmfunc|
  llvm.func @lshrult_02_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_06   : lshrult_02_06_before  ⊑  lshrult_02_06_combined := by
  unfold lshrult_02_06_before lshrult_02_06_combined
  simp_alive_peephole
  sorry
def lshrult_02_07_combined := [llvmfunc|
  llvm.func @lshrult_02_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_07   : lshrult_02_07_before  ⊑  lshrult_02_07_combined := by
  unfold lshrult_02_07_before lshrult_02_07_combined
  simp_alive_peephole
  sorry
def lshrult_02_08_combined := [llvmfunc|
  llvm.func @lshrult_02_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_08   : lshrult_02_08_before  ⊑  lshrult_02_08_combined := by
  unfold lshrult_02_08_before lshrult_02_08_combined
  simp_alive_peephole
  sorry
def lshrult_02_09_combined := [llvmfunc|
  llvm.func @lshrult_02_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_09   : lshrult_02_09_before  ⊑  lshrult_02_09_combined := by
  unfold lshrult_02_09_before lshrult_02_09_combined
  simp_alive_peephole
  sorry
def lshrult_02_10_combined := [llvmfunc|
  llvm.func @lshrult_02_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_10   : lshrult_02_10_before  ⊑  lshrult_02_10_combined := by
  unfold lshrult_02_10_before lshrult_02_10_combined
  simp_alive_peephole
  sorry
def lshrult_02_11_combined := [llvmfunc|
  llvm.func @lshrult_02_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_11   : lshrult_02_11_before  ⊑  lshrult_02_11_combined := by
  unfold lshrult_02_11_before lshrult_02_11_combined
  simp_alive_peephole
  sorry
def lshrult_02_12_combined := [llvmfunc|
  llvm.func @lshrult_02_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_12   : lshrult_02_12_before  ⊑  lshrult_02_12_combined := by
  unfold lshrult_02_12_before lshrult_02_12_combined
  simp_alive_peephole
  sorry
def lshrult_02_13_combined := [llvmfunc|
  llvm.func @lshrult_02_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_13   : lshrult_02_13_before  ⊑  lshrult_02_13_combined := by
  unfold lshrult_02_13_before lshrult_02_13_combined
  simp_alive_peephole
  sorry
def lshrult_02_14_combined := [llvmfunc|
  llvm.func @lshrult_02_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_14   : lshrult_02_14_before  ⊑  lshrult_02_14_combined := by
  unfold lshrult_02_14_before lshrult_02_14_combined
  simp_alive_peephole
  sorry
def lshrult_02_15_combined := [llvmfunc|
  llvm.func @lshrult_02_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_15   : lshrult_02_15_before  ⊑  lshrult_02_15_combined := by
  unfold lshrult_02_15_before lshrult_02_15_combined
  simp_alive_peephole
  sorry
def lshrult_03_00_combined := [llvmfunc|
  llvm.func @lshrult_03_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_00   : lshrult_03_00_before  ⊑  lshrult_03_00_combined := by
  unfold lshrult_03_00_before lshrult_03_00_combined
  simp_alive_peephole
  sorry
def lshrult_03_01_combined := [llvmfunc|
  llvm.func @lshrult_03_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_03_01   : lshrult_03_01_before  ⊑  lshrult_03_01_combined := by
  unfold lshrult_03_01_before lshrult_03_01_combined
  simp_alive_peephole
  sorry
def lshrult_03_02_combined := [llvmfunc|
  llvm.func @lshrult_03_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_02   : lshrult_03_02_before  ⊑  lshrult_03_02_combined := by
  unfold lshrult_03_02_before lshrult_03_02_combined
  simp_alive_peephole
  sorry
def lshrult_03_03_combined := [llvmfunc|
  llvm.func @lshrult_03_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_03   : lshrult_03_03_before  ⊑  lshrult_03_03_combined := by
  unfold lshrult_03_03_before lshrult_03_03_combined
  simp_alive_peephole
  sorry
def lshrult_03_04_combined := [llvmfunc|
  llvm.func @lshrult_03_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_04   : lshrult_03_04_before  ⊑  lshrult_03_04_combined := by
  unfold lshrult_03_04_before lshrult_03_04_combined
  simp_alive_peephole
  sorry
def lshrult_03_05_combined := [llvmfunc|
  llvm.func @lshrult_03_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_05   : lshrult_03_05_before  ⊑  lshrult_03_05_combined := by
  unfold lshrult_03_05_before lshrult_03_05_combined
  simp_alive_peephole
  sorry
def lshrult_03_06_combined := [llvmfunc|
  llvm.func @lshrult_03_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_06   : lshrult_03_06_before  ⊑  lshrult_03_06_combined := by
  unfold lshrult_03_06_before lshrult_03_06_combined
  simp_alive_peephole
  sorry
def lshrult_03_07_combined := [llvmfunc|
  llvm.func @lshrult_03_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_07   : lshrult_03_07_before  ⊑  lshrult_03_07_combined := by
  unfold lshrult_03_07_before lshrult_03_07_combined
  simp_alive_peephole
  sorry
def lshrult_03_08_combined := [llvmfunc|
  llvm.func @lshrult_03_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_08   : lshrult_03_08_before  ⊑  lshrult_03_08_combined := by
  unfold lshrult_03_08_before lshrult_03_08_combined
  simp_alive_peephole
  sorry
def lshrult_03_09_combined := [llvmfunc|
  llvm.func @lshrult_03_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_09   : lshrult_03_09_before  ⊑  lshrult_03_09_combined := by
  unfold lshrult_03_09_before lshrult_03_09_combined
  simp_alive_peephole
  sorry
def lshrult_03_10_combined := [llvmfunc|
  llvm.func @lshrult_03_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_10   : lshrult_03_10_before  ⊑  lshrult_03_10_combined := by
  unfold lshrult_03_10_before lshrult_03_10_combined
  simp_alive_peephole
  sorry
def lshrult_03_11_combined := [llvmfunc|
  llvm.func @lshrult_03_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_11   : lshrult_03_11_before  ⊑  lshrult_03_11_combined := by
  unfold lshrult_03_11_before lshrult_03_11_combined
  simp_alive_peephole
  sorry
def lshrult_03_12_combined := [llvmfunc|
  llvm.func @lshrult_03_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_12   : lshrult_03_12_before  ⊑  lshrult_03_12_combined := by
  unfold lshrult_03_12_before lshrult_03_12_combined
  simp_alive_peephole
  sorry
def lshrult_03_13_combined := [llvmfunc|
  llvm.func @lshrult_03_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_13   : lshrult_03_13_before  ⊑  lshrult_03_13_combined := by
  unfold lshrult_03_13_before lshrult_03_13_combined
  simp_alive_peephole
  sorry
def lshrult_03_14_combined := [llvmfunc|
  llvm.func @lshrult_03_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_14   : lshrult_03_14_before  ⊑  lshrult_03_14_combined := by
  unfold lshrult_03_14_before lshrult_03_14_combined
  simp_alive_peephole
  sorry
def lshrult_03_15_combined := [llvmfunc|
  llvm.func @lshrult_03_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_15   : lshrult_03_15_before  ⊑  lshrult_03_15_combined := by
  unfold lshrult_03_15_before lshrult_03_15_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_00_combined := [llvmfunc|
  llvm.func @ashrsgt_01_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_00   : ashrsgt_01_00_before  ⊑  ashrsgt_01_00_combined := by
  unfold ashrsgt_01_00_before ashrsgt_01_00_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_00_multiuse_combined := [llvmfunc|
  llvm.func @ashrsgt_01_00_multiuse(%arg0: i4, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "sgt" %2, %1 : i4
    llvm.store %2, %arg1 {alignment = 1 : i64} : i4, !llvm.ptr
    llvm.return %3 : i1
  }]

theorem inst_combine_ashrsgt_01_00_multiuse   : ashrsgt_01_00_multiuse_before  ⊑  ashrsgt_01_00_multiuse_combined := by
  unfold ashrsgt_01_00_multiuse_before ashrsgt_01_00_multiuse_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_01_combined := [llvmfunc|
  llvm.func @ashrsgt_01_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_01   : ashrsgt_01_01_before  ⊑  ashrsgt_01_01_combined := by
  unfold ashrsgt_01_01_before ashrsgt_01_01_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_02_combined := [llvmfunc|
  llvm.func @ashrsgt_01_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_02   : ashrsgt_01_02_before  ⊑  ashrsgt_01_02_combined := by
  unfold ashrsgt_01_02_before ashrsgt_01_02_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_03_combined := [llvmfunc|
  llvm.func @ashrsgt_01_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_03   : ashrsgt_01_03_before  ⊑  ashrsgt_01_03_combined := by
  unfold ashrsgt_01_03_before ashrsgt_01_03_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_04_combined := [llvmfunc|
  llvm.func @ashrsgt_01_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_04   : ashrsgt_01_04_before  ⊑  ashrsgt_01_04_combined := by
  unfold ashrsgt_01_04_before ashrsgt_01_04_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_05_combined := [llvmfunc|
  llvm.func @ashrsgt_01_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_05   : ashrsgt_01_05_before  ⊑  ashrsgt_01_05_combined := by
  unfold ashrsgt_01_05_before ashrsgt_01_05_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_06_combined := [llvmfunc|
  llvm.func @ashrsgt_01_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_06   : ashrsgt_01_06_before  ⊑  ashrsgt_01_06_combined := by
  unfold ashrsgt_01_06_before ashrsgt_01_06_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_07_combined := [llvmfunc|
  llvm.func @ashrsgt_01_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_07   : ashrsgt_01_07_before  ⊑  ashrsgt_01_07_combined := by
  unfold ashrsgt_01_07_before ashrsgt_01_07_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_08_combined := [llvmfunc|
  llvm.func @ashrsgt_01_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_08   : ashrsgt_01_08_before  ⊑  ashrsgt_01_08_combined := by
  unfold ashrsgt_01_08_before ashrsgt_01_08_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_09_combined := [llvmfunc|
  llvm.func @ashrsgt_01_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_09   : ashrsgt_01_09_before  ⊑  ashrsgt_01_09_combined := by
  unfold ashrsgt_01_09_before ashrsgt_01_09_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_10_combined := [llvmfunc|
  llvm.func @ashrsgt_01_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_10   : ashrsgt_01_10_before  ⊑  ashrsgt_01_10_combined := by
  unfold ashrsgt_01_10_before ashrsgt_01_10_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_11_combined := [llvmfunc|
  llvm.func @ashrsgt_01_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_11   : ashrsgt_01_11_before  ⊑  ashrsgt_01_11_combined := by
  unfold ashrsgt_01_11_before ashrsgt_01_11_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_12_combined := [llvmfunc|
  llvm.func @ashrsgt_01_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-7 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_12   : ashrsgt_01_12_before  ⊑  ashrsgt_01_12_combined := by
  unfold ashrsgt_01_12_before ashrsgt_01_12_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_13_combined := [llvmfunc|
  llvm.func @ashrsgt_01_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-5 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_13   : ashrsgt_01_13_before  ⊑  ashrsgt_01_13_combined := by
  unfold ashrsgt_01_13_before ashrsgt_01_13_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_14_combined := [llvmfunc|
  llvm.func @ashrsgt_01_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-3 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_14   : ashrsgt_01_14_before  ⊑  ashrsgt_01_14_combined := by
  unfold ashrsgt_01_14_before ashrsgt_01_14_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_15_combined := [llvmfunc|
  llvm.func @ashrsgt_01_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_15   : ashrsgt_01_15_before  ⊑  ashrsgt_01_15_combined := by
  unfold ashrsgt_01_15_before ashrsgt_01_15_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_00_combined := [llvmfunc|
  llvm.func @ashrsgt_02_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_02_00   : ashrsgt_02_00_before  ⊑  ashrsgt_02_00_combined := by
  unfold ashrsgt_02_00_before ashrsgt_02_00_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_01_combined := [llvmfunc|
  llvm.func @ashrsgt_02_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_01   : ashrsgt_02_01_before  ⊑  ashrsgt_02_01_combined := by
  unfold ashrsgt_02_01_before ashrsgt_02_01_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_02_combined := [llvmfunc|
  llvm.func @ashrsgt_02_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_02   : ashrsgt_02_02_before  ⊑  ashrsgt_02_02_combined := by
  unfold ashrsgt_02_02_before ashrsgt_02_02_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_03_combined := [llvmfunc|
  llvm.func @ashrsgt_02_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_03   : ashrsgt_02_03_before  ⊑  ashrsgt_02_03_combined := by
  unfold ashrsgt_02_03_before ashrsgt_02_03_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_04_combined := [llvmfunc|
  llvm.func @ashrsgt_02_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_04   : ashrsgt_02_04_before  ⊑  ashrsgt_02_04_combined := by
  unfold ashrsgt_02_04_before ashrsgt_02_04_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_05_combined := [llvmfunc|
  llvm.func @ashrsgt_02_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_05   : ashrsgt_02_05_before  ⊑  ashrsgt_02_05_combined := by
  unfold ashrsgt_02_05_before ashrsgt_02_05_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_06_combined := [llvmfunc|
  llvm.func @ashrsgt_02_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_06   : ashrsgt_02_06_before  ⊑  ashrsgt_02_06_combined := by
  unfold ashrsgt_02_06_before ashrsgt_02_06_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_07_combined := [llvmfunc|
  llvm.func @ashrsgt_02_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_07   : ashrsgt_02_07_before  ⊑  ashrsgt_02_07_combined := by
  unfold ashrsgt_02_07_before ashrsgt_02_07_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_08_combined := [llvmfunc|
  llvm.func @ashrsgt_02_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_08   : ashrsgt_02_08_before  ⊑  ashrsgt_02_08_combined := by
  unfold ashrsgt_02_08_before ashrsgt_02_08_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_09_combined := [llvmfunc|
  llvm.func @ashrsgt_02_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_09   : ashrsgt_02_09_before  ⊑  ashrsgt_02_09_combined := by
  unfold ashrsgt_02_09_before ashrsgt_02_09_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_10_combined := [llvmfunc|
  llvm.func @ashrsgt_02_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_10   : ashrsgt_02_10_before  ⊑  ashrsgt_02_10_combined := by
  unfold ashrsgt_02_10_before ashrsgt_02_10_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_11_combined := [llvmfunc|
  llvm.func @ashrsgt_02_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_11   : ashrsgt_02_11_before  ⊑  ashrsgt_02_11_combined := by
  unfold ashrsgt_02_11_before ashrsgt_02_11_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_12_combined := [llvmfunc|
  llvm.func @ashrsgt_02_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_12   : ashrsgt_02_12_before  ⊑  ashrsgt_02_12_combined := by
  unfold ashrsgt_02_12_before ashrsgt_02_12_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_13_combined := [llvmfunc|
  llvm.func @ashrsgt_02_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_13   : ashrsgt_02_13_before  ⊑  ashrsgt_02_13_combined := by
  unfold ashrsgt_02_13_before ashrsgt_02_13_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_14_combined := [llvmfunc|
  llvm.func @ashrsgt_02_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-5 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_02_14   : ashrsgt_02_14_before  ⊑  ashrsgt_02_14_combined := by
  unfold ashrsgt_02_14_before ashrsgt_02_14_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_15_combined := [llvmfunc|
  llvm.func @ashrsgt_02_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_02_15   : ashrsgt_02_15_before  ⊑  ashrsgt_02_15_combined := by
  unfold ashrsgt_02_15_before ashrsgt_02_15_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_00_combined := [llvmfunc|
  llvm.func @ashrsgt_03_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_00   : ashrsgt_03_00_before  ⊑  ashrsgt_03_00_combined := by
  unfold ashrsgt_03_00_before ashrsgt_03_00_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_01_combined := [llvmfunc|
  llvm.func @ashrsgt_03_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_01   : ashrsgt_03_01_before  ⊑  ashrsgt_03_01_combined := by
  unfold ashrsgt_03_01_before ashrsgt_03_01_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_02_combined := [llvmfunc|
  llvm.func @ashrsgt_03_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_02   : ashrsgt_03_02_before  ⊑  ashrsgt_03_02_combined := by
  unfold ashrsgt_03_02_before ashrsgt_03_02_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_03_combined := [llvmfunc|
  llvm.func @ashrsgt_03_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_03   : ashrsgt_03_03_before  ⊑  ashrsgt_03_03_combined := by
  unfold ashrsgt_03_03_before ashrsgt_03_03_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_04_combined := [llvmfunc|
  llvm.func @ashrsgt_03_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_04   : ashrsgt_03_04_before  ⊑  ashrsgt_03_04_combined := by
  unfold ashrsgt_03_04_before ashrsgt_03_04_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_05_combined := [llvmfunc|
  llvm.func @ashrsgt_03_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_05   : ashrsgt_03_05_before  ⊑  ashrsgt_03_05_combined := by
  unfold ashrsgt_03_05_before ashrsgt_03_05_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_06_combined := [llvmfunc|
  llvm.func @ashrsgt_03_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_06   : ashrsgt_03_06_before  ⊑  ashrsgt_03_06_combined := by
  unfold ashrsgt_03_06_before ashrsgt_03_06_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_07_combined := [llvmfunc|
  llvm.func @ashrsgt_03_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_07   : ashrsgt_03_07_before  ⊑  ashrsgt_03_07_combined := by
  unfold ashrsgt_03_07_before ashrsgt_03_07_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_08_combined := [llvmfunc|
  llvm.func @ashrsgt_03_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_08   : ashrsgt_03_08_before  ⊑  ashrsgt_03_08_combined := by
  unfold ashrsgt_03_08_before ashrsgt_03_08_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_09_combined := [llvmfunc|
  llvm.func @ashrsgt_03_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_09   : ashrsgt_03_09_before  ⊑  ashrsgt_03_09_combined := by
  unfold ashrsgt_03_09_before ashrsgt_03_09_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_10_combined := [llvmfunc|
  llvm.func @ashrsgt_03_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_10   : ashrsgt_03_10_before  ⊑  ashrsgt_03_10_combined := by
  unfold ashrsgt_03_10_before ashrsgt_03_10_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_11_combined := [llvmfunc|
  llvm.func @ashrsgt_03_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_11   : ashrsgt_03_11_before  ⊑  ashrsgt_03_11_combined := by
  unfold ashrsgt_03_11_before ashrsgt_03_11_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_12_combined := [llvmfunc|
  llvm.func @ashrsgt_03_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_12   : ashrsgt_03_12_before  ⊑  ashrsgt_03_12_combined := by
  unfold ashrsgt_03_12_before ashrsgt_03_12_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_13_combined := [llvmfunc|
  llvm.func @ashrsgt_03_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_13   : ashrsgt_03_13_before  ⊑  ashrsgt_03_13_combined := by
  unfold ashrsgt_03_13_before ashrsgt_03_13_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_14_combined := [llvmfunc|
  llvm.func @ashrsgt_03_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_14   : ashrsgt_03_14_before  ⊑  ashrsgt_03_14_combined := by
  unfold ashrsgt_03_14_before ashrsgt_03_14_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_15_combined := [llvmfunc|
  llvm.func @ashrsgt_03_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_03_15   : ashrsgt_03_15_before  ⊑  ashrsgt_03_15_combined := by
  unfold ashrsgt_03_15_before ashrsgt_03_15_combined
  simp_alive_peephole
  sorry
def ashrslt_01_00_combined := [llvmfunc|
  llvm.func @ashrslt_01_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_00   : ashrslt_01_00_before  ⊑  ashrslt_01_00_combined := by
  unfold ashrslt_01_00_before ashrslt_01_00_combined
  simp_alive_peephole
  sorry
def ashrslt_01_01_combined := [llvmfunc|
  llvm.func @ashrslt_01_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_01   : ashrslt_01_01_before  ⊑  ashrslt_01_01_combined := by
  unfold ashrslt_01_01_before ashrslt_01_01_combined
  simp_alive_peephole
  sorry
def ashrslt_01_02_combined := [llvmfunc|
  llvm.func @ashrslt_01_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(4 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_02   : ashrslt_01_02_before  ⊑  ashrslt_01_02_combined := by
  unfold ashrslt_01_02_before ashrslt_01_02_combined
  simp_alive_peephole
  sorry
def ashrslt_01_03_combined := [llvmfunc|
  llvm.func @ashrslt_01_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_03   : ashrslt_01_03_before  ⊑  ashrslt_01_03_combined := by
  unfold ashrslt_01_03_before ashrslt_01_03_combined
  simp_alive_peephole
  sorry
def ashrslt_01_04_combined := [llvmfunc|
  llvm.func @ashrslt_01_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_04   : ashrslt_01_04_before  ⊑  ashrslt_01_04_combined := by
  unfold ashrslt_01_04_before ashrslt_01_04_combined
  simp_alive_peephole
  sorry
def ashrslt_01_05_combined := [llvmfunc|
  llvm.func @ashrslt_01_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_05   : ashrslt_01_05_before  ⊑  ashrslt_01_05_combined := by
  unfold ashrslt_01_05_before ashrslt_01_05_combined
  simp_alive_peephole
  sorry
def ashrslt_01_06_combined := [llvmfunc|
  llvm.func @ashrslt_01_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_06   : ashrslt_01_06_before  ⊑  ashrslt_01_06_combined := by
  unfold ashrslt_01_06_before ashrslt_01_06_combined
  simp_alive_peephole
  sorry
def ashrslt_01_07_combined := [llvmfunc|
  llvm.func @ashrslt_01_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_07   : ashrslt_01_07_before  ⊑  ashrslt_01_07_combined := by
  unfold ashrslt_01_07_before ashrslt_01_07_combined
  simp_alive_peephole
  sorry
def ashrslt_01_08_combined := [llvmfunc|
  llvm.func @ashrslt_01_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_08   : ashrslt_01_08_before  ⊑  ashrslt_01_08_combined := by
  unfold ashrslt_01_08_before ashrslt_01_08_combined
  simp_alive_peephole
  sorry
def ashrslt_01_09_combined := [llvmfunc|
  llvm.func @ashrslt_01_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_09   : ashrslt_01_09_before  ⊑  ashrslt_01_09_combined := by
  unfold ashrslt_01_09_before ashrslt_01_09_combined
  simp_alive_peephole
  sorry
def ashrslt_01_10_combined := [llvmfunc|
  llvm.func @ashrslt_01_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_10   : ashrslt_01_10_before  ⊑  ashrslt_01_10_combined := by
  unfold ashrslt_01_10_before ashrslt_01_10_combined
  simp_alive_peephole
  sorry
def ashrslt_01_11_combined := [llvmfunc|
  llvm.func @ashrslt_01_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_11   : ashrslt_01_11_before  ⊑  ashrslt_01_11_combined := by
  unfold ashrslt_01_11_before ashrslt_01_11_combined
  simp_alive_peephole
  sorry
def ashrslt_01_12_combined := [llvmfunc|
  llvm.func @ashrslt_01_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_12   : ashrslt_01_12_before  ⊑  ashrslt_01_12_combined := by
  unfold ashrslt_01_12_before ashrslt_01_12_combined
  simp_alive_peephole
  sorry
def ashrslt_01_13_combined := [llvmfunc|
  llvm.func @ashrslt_01_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_13   : ashrslt_01_13_before  ⊑  ashrslt_01_13_combined := by
  unfold ashrslt_01_13_before ashrslt_01_13_combined
  simp_alive_peephole
  sorry
def ashrslt_01_14_combined := [llvmfunc|
  llvm.func @ashrslt_01_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_14   : ashrslt_01_14_before  ⊑  ashrslt_01_14_combined := by
  unfold ashrslt_01_14_before ashrslt_01_14_combined
  simp_alive_peephole
  sorry
def ashrslt_01_15_combined := [llvmfunc|
  llvm.func @ashrslt_01_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_15   : ashrslt_01_15_before  ⊑  ashrslt_01_15_combined := by
  unfold ashrslt_01_15_before ashrslt_01_15_combined
  simp_alive_peephole
  sorry
def ashrslt_02_00_combined := [llvmfunc|
  llvm.func @ashrslt_02_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_02_00   : ashrslt_02_00_before  ⊑  ashrslt_02_00_combined := by
  unfold ashrslt_02_00_before ashrslt_02_00_combined
  simp_alive_peephole
  sorry
def ashrslt_02_01_combined := [llvmfunc|
  llvm.func @ashrslt_02_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(4 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_02_01   : ashrslt_02_01_before  ⊑  ashrslt_02_01_combined := by
  unfold ashrslt_02_01_before ashrslt_02_01_combined
  simp_alive_peephole
  sorry
def ashrslt_02_02_combined := [llvmfunc|
  llvm.func @ashrslt_02_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_02   : ashrslt_02_02_before  ⊑  ashrslt_02_02_combined := by
  unfold ashrslt_02_02_before ashrslt_02_02_combined
  simp_alive_peephole
  sorry
def ashrslt_02_03_combined := [llvmfunc|
  llvm.func @ashrslt_02_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_03   : ashrslt_02_03_before  ⊑  ashrslt_02_03_combined := by
  unfold ashrslt_02_03_before ashrslt_02_03_combined
  simp_alive_peephole
  sorry
def ashrslt_02_04_combined := [llvmfunc|
  llvm.func @ashrslt_02_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_04   : ashrslt_02_04_before  ⊑  ashrslt_02_04_combined := by
  unfold ashrslt_02_04_before ashrslt_02_04_combined
  simp_alive_peephole
  sorry
def ashrslt_02_05_combined := [llvmfunc|
  llvm.func @ashrslt_02_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_05   : ashrslt_02_05_before  ⊑  ashrslt_02_05_combined := by
  unfold ashrslt_02_05_before ashrslt_02_05_combined
  simp_alive_peephole
  sorry
def ashrslt_02_06_combined := [llvmfunc|
  llvm.func @ashrslt_02_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_06   : ashrslt_02_06_before  ⊑  ashrslt_02_06_combined := by
  unfold ashrslt_02_06_before ashrslt_02_06_combined
  simp_alive_peephole
  sorry
def ashrslt_02_07_combined := [llvmfunc|
  llvm.func @ashrslt_02_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_07   : ashrslt_02_07_before  ⊑  ashrslt_02_07_combined := by
  unfold ashrslt_02_07_before ashrslt_02_07_combined
  simp_alive_peephole
  sorry
def ashrslt_02_08_combined := [llvmfunc|
  llvm.func @ashrslt_02_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_08   : ashrslt_02_08_before  ⊑  ashrslt_02_08_combined := by
  unfold ashrslt_02_08_before ashrslt_02_08_combined
  simp_alive_peephole
  sorry
def ashrslt_02_09_combined := [llvmfunc|
  llvm.func @ashrslt_02_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_09   : ashrslt_02_09_before  ⊑  ashrslt_02_09_combined := by
  unfold ashrslt_02_09_before ashrslt_02_09_combined
  simp_alive_peephole
  sorry
def ashrslt_02_10_combined := [llvmfunc|
  llvm.func @ashrslt_02_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_10   : ashrslt_02_10_before  ⊑  ashrslt_02_10_combined := by
  unfold ashrslt_02_10_before ashrslt_02_10_combined
  simp_alive_peephole
  sorry
def ashrslt_02_11_combined := [llvmfunc|
  llvm.func @ashrslt_02_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_11   : ashrslt_02_11_before  ⊑  ashrslt_02_11_combined := by
  unfold ashrslt_02_11_before ashrslt_02_11_combined
  simp_alive_peephole
  sorry
def ashrslt_02_12_combined := [llvmfunc|
  llvm.func @ashrslt_02_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_12   : ashrslt_02_12_before  ⊑  ashrslt_02_12_combined := by
  unfold ashrslt_02_12_before ashrslt_02_12_combined
  simp_alive_peephole
  sorry
def ashrslt_02_13_combined := [llvmfunc|
  llvm.func @ashrslt_02_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_13   : ashrslt_02_13_before  ⊑  ashrslt_02_13_combined := by
  unfold ashrslt_02_13_before ashrslt_02_13_combined
  simp_alive_peephole
  sorry
def ashrslt_02_14_combined := [llvmfunc|
  llvm.func @ashrslt_02_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_14   : ashrslt_02_14_before  ⊑  ashrslt_02_14_combined := by
  unfold ashrslt_02_14_before ashrslt_02_14_combined
  simp_alive_peephole
  sorry
def ashrslt_02_15_combined := [llvmfunc|
  llvm.func @ashrslt_02_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_02_15   : ashrslt_02_15_before  ⊑  ashrslt_02_15_combined := by
  unfold ashrslt_02_15_before ashrslt_02_15_combined
  simp_alive_peephole
  sorry
def ashrslt_03_00_combined := [llvmfunc|
  llvm.func @ashrslt_03_00(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_03_00   : ashrslt_03_00_before  ⊑  ashrslt_03_00_combined := by
  unfold ashrslt_03_00_before ashrslt_03_00_combined
  simp_alive_peephole
  sorry
def ashrslt_03_01_combined := [llvmfunc|
  llvm.func @ashrslt_03_01(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_01   : ashrslt_03_01_before  ⊑  ashrslt_03_01_combined := by
  unfold ashrslt_03_01_before ashrslt_03_01_combined
  simp_alive_peephole
  sorry
def ashrslt_03_02_combined := [llvmfunc|
  llvm.func @ashrslt_03_02(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_02   : ashrslt_03_02_before  ⊑  ashrslt_03_02_combined := by
  unfold ashrslt_03_02_before ashrslt_03_02_combined
  simp_alive_peephole
  sorry
def ashrslt_03_03_combined := [llvmfunc|
  llvm.func @ashrslt_03_03(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_03   : ashrslt_03_03_before  ⊑  ashrslt_03_03_combined := by
  unfold ashrslt_03_03_before ashrslt_03_03_combined
  simp_alive_peephole
  sorry
def ashrslt_03_04_combined := [llvmfunc|
  llvm.func @ashrslt_03_04(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_04   : ashrslt_03_04_before  ⊑  ashrslt_03_04_combined := by
  unfold ashrslt_03_04_before ashrslt_03_04_combined
  simp_alive_peephole
  sorry
def ashrslt_03_05_combined := [llvmfunc|
  llvm.func @ashrslt_03_05(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_05   : ashrslt_03_05_before  ⊑  ashrslt_03_05_combined := by
  unfold ashrslt_03_05_before ashrslt_03_05_combined
  simp_alive_peephole
  sorry
def ashrslt_03_06_combined := [llvmfunc|
  llvm.func @ashrslt_03_06(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_06   : ashrslt_03_06_before  ⊑  ashrslt_03_06_combined := by
  unfold ashrslt_03_06_before ashrslt_03_06_combined
  simp_alive_peephole
  sorry
def ashrslt_03_07_combined := [llvmfunc|
  llvm.func @ashrslt_03_07(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_07   : ashrslt_03_07_before  ⊑  ashrslt_03_07_combined := by
  unfold ashrslt_03_07_before ashrslt_03_07_combined
  simp_alive_peephole
  sorry
def ashrslt_03_08_combined := [llvmfunc|
  llvm.func @ashrslt_03_08(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_08   : ashrslt_03_08_before  ⊑  ashrslt_03_08_combined := by
  unfold ashrslt_03_08_before ashrslt_03_08_combined
  simp_alive_peephole
  sorry
def ashrslt_03_09_combined := [llvmfunc|
  llvm.func @ashrslt_03_09(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_09   : ashrslt_03_09_before  ⊑  ashrslt_03_09_combined := by
  unfold ashrslt_03_09_before ashrslt_03_09_combined
  simp_alive_peephole
  sorry
def ashrslt_03_10_combined := [llvmfunc|
  llvm.func @ashrslt_03_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_10   : ashrslt_03_10_before  ⊑  ashrslt_03_10_combined := by
  unfold ashrslt_03_10_before ashrslt_03_10_combined
  simp_alive_peephole
  sorry
def ashrslt_03_11_combined := [llvmfunc|
  llvm.func @ashrslt_03_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_11   : ashrslt_03_11_before  ⊑  ashrslt_03_11_combined := by
  unfold ashrslt_03_11_before ashrslt_03_11_combined
  simp_alive_peephole
  sorry
def ashrslt_03_12_combined := [llvmfunc|
  llvm.func @ashrslt_03_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_12   : ashrslt_03_12_before  ⊑  ashrslt_03_12_combined := by
  unfold ashrslt_03_12_before ashrslt_03_12_combined
  simp_alive_peephole
  sorry
def ashrslt_03_13_combined := [llvmfunc|
  llvm.func @ashrslt_03_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_13   : ashrslt_03_13_before  ⊑  ashrslt_03_13_combined := by
  unfold ashrslt_03_13_before ashrslt_03_13_combined
  simp_alive_peephole
  sorry
def ashrslt_03_14_combined := [llvmfunc|
  llvm.func @ashrslt_03_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_14   : ashrslt_03_14_before  ⊑  ashrslt_03_14_combined := by
  unfold ashrslt_03_14_before ashrslt_03_14_combined
  simp_alive_peephole
  sorry
def ashrslt_03_15_combined := [llvmfunc|
  llvm.func @ashrslt_03_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_15   : ashrslt_03_15_before  ⊑  ashrslt_03_15_combined := by
  unfold ashrslt_03_15_before ashrslt_03_15_combined
  simp_alive_peephole
  sorry
def lshrugt_01_00_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "ne" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_00_exact   : lshrugt_01_00_exact_before  ⊑  lshrugt_01_00_exact_combined := by
  unfold lshrugt_01_00_exact_before lshrugt_01_00_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_01_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_01_exact   : lshrugt_01_01_exact_before  ⊑  lshrugt_01_01_exact_combined := by
  unfold lshrugt_01_01_exact_before lshrugt_01_01_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_02_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(4 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_02_exact   : lshrugt_01_02_exact_before  ⊑  lshrugt_01_02_exact_combined := by
  unfold lshrugt_01_02_exact_before lshrugt_01_02_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_03_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_03_exact   : lshrugt_01_03_exact_before  ⊑  lshrugt_01_03_exact_combined := by
  unfold lshrugt_01_03_exact_before lshrugt_01_03_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_04_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_04_exact   : lshrugt_01_04_exact_before  ⊑  lshrugt_01_04_exact_combined := by
  unfold lshrugt_01_04_exact_before lshrugt_01_04_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_05_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_05_exact   : lshrugt_01_05_exact_before  ⊑  lshrugt_01_05_exact_combined := by
  unfold lshrugt_01_05_exact_before lshrugt_01_05_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_06_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.icmp "eq" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_01_06_exact   : lshrugt_01_06_exact_before  ⊑  lshrugt_01_06_exact_combined := by
  unfold lshrugt_01_06_exact_before lshrugt_01_06_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_07_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_07_exact   : lshrugt_01_07_exact_before  ⊑  lshrugt_01_07_exact_combined := by
  unfold lshrugt_01_07_exact_before lshrugt_01_07_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_08_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_08_exact   : lshrugt_01_08_exact_before  ⊑  lshrugt_01_08_exact_combined := by
  unfold lshrugt_01_08_exact_before lshrugt_01_08_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_09_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_09_exact   : lshrugt_01_09_exact_before  ⊑  lshrugt_01_09_exact_combined := by
  unfold lshrugt_01_09_exact_before lshrugt_01_09_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_10_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_10_exact   : lshrugt_01_10_exact_before  ⊑  lshrugt_01_10_exact_combined := by
  unfold lshrugt_01_10_exact_before lshrugt_01_10_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_11_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_11_exact   : lshrugt_01_11_exact_before  ⊑  lshrugt_01_11_exact_combined := by
  unfold lshrugt_01_11_exact_before lshrugt_01_11_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_12_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_12_exact   : lshrugt_01_12_exact_before  ⊑  lshrugt_01_12_exact_combined := by
  unfold lshrugt_01_12_exact_before lshrugt_01_12_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_13_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_13_exact   : lshrugt_01_13_exact_before  ⊑  lshrugt_01_13_exact_combined := by
  unfold lshrugt_01_13_exact_before lshrugt_01_13_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_14_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_14_exact   : lshrugt_01_14_exact_before  ⊑  lshrugt_01_14_exact_combined := by
  unfold lshrugt_01_14_exact_before lshrugt_01_14_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_01_15_exact_combined := [llvmfunc|
  llvm.func @lshrugt_01_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_01_15_exact   : lshrugt_01_15_exact_before  ⊑  lshrugt_01_15_exact_combined := by
  unfold lshrugt_01_15_exact_before lshrugt_01_15_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_00_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "ne" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_02_00_exact   : lshrugt_02_00_exact_before  ⊑  lshrugt_02_00_exact_combined := by
  unfold lshrugt_02_00_exact_before lshrugt_02_00_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_01_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(4 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_02_01_exact   : lshrugt_02_01_exact_before  ⊑  lshrugt_02_01_exact_combined := by
  unfold lshrugt_02_01_exact_before lshrugt_02_01_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_02_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.icmp "eq" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_02_02_exact   : lshrugt_02_02_exact_before  ⊑  lshrugt_02_02_exact_combined := by
  unfold lshrugt_02_02_exact_before lshrugt_02_02_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_03_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_03_exact   : lshrugt_02_03_exact_before  ⊑  lshrugt_02_03_exact_combined := by
  unfold lshrugt_02_03_exact_before lshrugt_02_03_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_04_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_04_exact   : lshrugt_02_04_exact_before  ⊑  lshrugt_02_04_exact_combined := by
  unfold lshrugt_02_04_exact_before lshrugt_02_04_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_05_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_05_exact   : lshrugt_02_05_exact_before  ⊑  lshrugt_02_05_exact_combined := by
  unfold lshrugt_02_05_exact_before lshrugt_02_05_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_06_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_06_exact   : lshrugt_02_06_exact_before  ⊑  lshrugt_02_06_exact_combined := by
  unfold lshrugt_02_06_exact_before lshrugt_02_06_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_07_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_07_exact   : lshrugt_02_07_exact_before  ⊑  lshrugt_02_07_exact_combined := by
  unfold lshrugt_02_07_exact_before lshrugt_02_07_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_08_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_08_exact   : lshrugt_02_08_exact_before  ⊑  lshrugt_02_08_exact_combined := by
  unfold lshrugt_02_08_exact_before lshrugt_02_08_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_09_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_09_exact   : lshrugt_02_09_exact_before  ⊑  lshrugt_02_09_exact_combined := by
  unfold lshrugt_02_09_exact_before lshrugt_02_09_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_10_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_10_exact   : lshrugt_02_10_exact_before  ⊑  lshrugt_02_10_exact_combined := by
  unfold lshrugt_02_10_exact_before lshrugt_02_10_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_11_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_11_exact   : lshrugt_02_11_exact_before  ⊑  lshrugt_02_11_exact_combined := by
  unfold lshrugt_02_11_exact_before lshrugt_02_11_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_12_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_12_exact   : lshrugt_02_12_exact_before  ⊑  lshrugt_02_12_exact_combined := by
  unfold lshrugt_02_12_exact_before lshrugt_02_12_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_13_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_13_exact   : lshrugt_02_13_exact_before  ⊑  lshrugt_02_13_exact_combined := by
  unfold lshrugt_02_13_exact_before lshrugt_02_13_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_14_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_14_exact   : lshrugt_02_14_exact_before  ⊑  lshrugt_02_14_exact_combined := by
  unfold lshrugt_02_14_exact_before lshrugt_02_14_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_02_15_exact_combined := [llvmfunc|
  llvm.func @lshrugt_02_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_02_15_exact   : lshrugt_02_15_exact_before  ⊑  lshrugt_02_15_exact_combined := by
  unfold lshrugt_02_15_exact_before lshrugt_02_15_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_00_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "ne" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrugt_03_00_exact   : lshrugt_03_00_exact_before  ⊑  lshrugt_03_00_exact_combined := by
  unfold lshrugt_03_00_exact_before lshrugt_03_00_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_01_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_01_exact   : lshrugt_03_01_exact_before  ⊑  lshrugt_03_01_exact_combined := by
  unfold lshrugt_03_01_exact_before lshrugt_03_01_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_02_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_02_exact   : lshrugt_03_02_exact_before  ⊑  lshrugt_03_02_exact_combined := by
  unfold lshrugt_03_02_exact_before lshrugt_03_02_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_03_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_03_exact   : lshrugt_03_03_exact_before  ⊑  lshrugt_03_03_exact_combined := by
  unfold lshrugt_03_03_exact_before lshrugt_03_03_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_04_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_04_exact   : lshrugt_03_04_exact_before  ⊑  lshrugt_03_04_exact_combined := by
  unfold lshrugt_03_04_exact_before lshrugt_03_04_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_05_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_05_exact   : lshrugt_03_05_exact_before  ⊑  lshrugt_03_05_exact_combined := by
  unfold lshrugt_03_05_exact_before lshrugt_03_05_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_06_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_06_exact   : lshrugt_03_06_exact_before  ⊑  lshrugt_03_06_exact_combined := by
  unfold lshrugt_03_06_exact_before lshrugt_03_06_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_07_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_07_exact   : lshrugt_03_07_exact_before  ⊑  lshrugt_03_07_exact_combined := by
  unfold lshrugt_03_07_exact_before lshrugt_03_07_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_08_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_08_exact   : lshrugt_03_08_exact_before  ⊑  lshrugt_03_08_exact_combined := by
  unfold lshrugt_03_08_exact_before lshrugt_03_08_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_09_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_09_exact   : lshrugt_03_09_exact_before  ⊑  lshrugt_03_09_exact_combined := by
  unfold lshrugt_03_09_exact_before lshrugt_03_09_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_10_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_10_exact   : lshrugt_03_10_exact_before  ⊑  lshrugt_03_10_exact_combined := by
  unfold lshrugt_03_10_exact_before lshrugt_03_10_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_11_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_11_exact   : lshrugt_03_11_exact_before  ⊑  lshrugt_03_11_exact_combined := by
  unfold lshrugt_03_11_exact_before lshrugt_03_11_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_12_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_12_exact   : lshrugt_03_12_exact_before  ⊑  lshrugt_03_12_exact_combined := by
  unfold lshrugt_03_12_exact_before lshrugt_03_12_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_13_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_13_exact   : lshrugt_03_13_exact_before  ⊑  lshrugt_03_13_exact_combined := by
  unfold lshrugt_03_13_exact_before lshrugt_03_13_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_14_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_14_exact   : lshrugt_03_14_exact_before  ⊑  lshrugt_03_14_exact_combined := by
  unfold lshrugt_03_14_exact_before lshrugt_03_14_exact_combined
  simp_alive_peephole
  sorry
def lshrugt_03_15_exact_combined := [llvmfunc|
  llvm.func @lshrugt_03_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrugt_03_15_exact   : lshrugt_03_15_exact_before  ⊑  lshrugt_03_15_exact_combined := by
  unfold lshrugt_03_15_exact_before lshrugt_03_15_exact_combined
  simp_alive_peephole
  sorry
def ashr_eq_exact_combined := [llvmfunc|
  llvm.func @ashr_eq_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_eq_exact   : ashr_eq_exact_before  ⊑  ashr_eq_exact_combined := by
  unfold ashr_eq_exact_before ashr_eq_exact_combined
  simp_alive_peephole
  sorry
def ashr_ne_exact_combined := [llvmfunc|
  llvm.func @ashr_ne_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ne_exact   : ashr_ne_exact_before  ⊑  ashr_ne_exact_combined := by
  unfold ashr_ne_exact_before ashr_ne_exact_combined
  simp_alive_peephole
  sorry
def ashr_ugt_exact_combined := [llvmfunc|
  llvm.func @ashr_ugt_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_exact   : ashr_ugt_exact_before  ⊑  ashr_ugt_exact_combined := by
  unfold ashr_ugt_exact_before ashr_ugt_exact_combined
  simp_alive_peephole
  sorry
def ashr_uge_exact_combined := [llvmfunc|
  llvm.func @ashr_uge_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(72 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_uge_exact   : ashr_uge_exact_before  ⊑  ashr_uge_exact_combined := by
  unfold ashr_uge_exact_before ashr_uge_exact_combined
  simp_alive_peephole
  sorry
def ashr_ult_exact_combined := [llvmfunc|
  llvm.func @ashr_ult_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_exact   : ashr_ult_exact_before  ⊑  ashr_ult_exact_combined := by
  unfold ashr_ult_exact_before ashr_ult_exact_combined
  simp_alive_peephole
  sorry
def ashr_ule_exact_combined := [llvmfunc|
  llvm.func @ashr_ule_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(88 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ule_exact   : ashr_ule_exact_before  ⊑  ashr_ule_exact_combined := by
  unfold ashr_ule_exact_before ashr_ule_exact_combined
  simp_alive_peephole
  sorry
def ashr_sgt_exact_combined := [llvmfunc|
  llvm.func @ashr_sgt_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_sgt_exact   : ashr_sgt_exact_before  ⊑  ashr_sgt_exact_combined := by
  unfold ashr_sgt_exact_before ashr_sgt_exact_combined
  simp_alive_peephole
  sorry
def ashr_sge_exact_combined := [llvmfunc|
  llvm.func @ashr_sge_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(72 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_sge_exact   : ashr_sge_exact_before  ⊑  ashr_sge_exact_combined := by
  unfold ashr_sge_exact_before ashr_sge_exact_combined
  simp_alive_peephole
  sorry
def ashr_slt_exact_combined := [llvmfunc|
  llvm.func @ashr_slt_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_slt_exact   : ashr_slt_exact_before  ⊑  ashr_slt_exact_combined := by
  unfold ashr_slt_exact_before ashr_slt_exact_combined
  simp_alive_peephole
  sorry
def ashr_sle_exact_combined := [llvmfunc|
  llvm.func @ashr_sle_exact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(88 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_sle_exact   : ashr_sle_exact_before  ⊑  ashr_sle_exact_combined := by
  unfold ashr_sle_exact_before ashr_sle_exact_combined
  simp_alive_peephole
  sorry
def ashr_eq_noexact_combined := [llvmfunc|
  llvm.func @ashr_eq_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.mlir.constant(80 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ashr_eq_noexact   : ashr_eq_noexact_before  ⊑  ashr_eq_noexact_combined := by
  unfold ashr_eq_noexact_before ashr_eq_noexact_combined
  simp_alive_peephole
  sorry
def ashr_ne_noexact_combined := [llvmfunc|
  llvm.func @ashr_ne_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.mlir.constant(80 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ashr_ne_noexact   : ashr_ne_noexact_before  ⊑  ashr_ne_noexact_combined := by
  unfold ashr_ne_noexact_before ashr_ne_noexact_combined
  simp_alive_peephole
  sorry
def ashr_ugt_noexact_combined := [llvmfunc|
  llvm.func @ashr_ugt_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(87 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_noexact   : ashr_ugt_noexact_before  ⊑  ashr_ugt_noexact_combined := by
  unfold ashr_ugt_noexact_before ashr_ugt_noexact_combined
  simp_alive_peephole
  sorry
def ashr_uge_noexact_combined := [llvmfunc|
  llvm.func @ashr_uge_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(79 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_uge_noexact   : ashr_uge_noexact_before  ⊑  ashr_uge_noexact_combined := by
  unfold ashr_uge_noexact_before ashr_uge_noexact_combined
  simp_alive_peephole
  sorry
def ashr_ult_noexact_combined := [llvmfunc|
  llvm.func @ashr_ult_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_noexact   : ashr_ult_noexact_before  ⊑  ashr_ult_noexact_combined := by
  unfold ashr_ult_noexact_before ashr_ult_noexact_combined
  simp_alive_peephole
  sorry
def ashr_ule_noexact_combined := [llvmfunc|
  llvm.func @ashr_ule_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(88 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ule_noexact   : ashr_ule_noexact_before  ⊑  ashr_ule_noexact_combined := by
  unfold ashr_ule_noexact_before ashr_ule_noexact_combined
  simp_alive_peephole
  sorry
def ashr_sgt_noexact_combined := [llvmfunc|
  llvm.func @ashr_sgt_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(87 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_sgt_noexact   : ashr_sgt_noexact_before  ⊑  ashr_sgt_noexact_combined := by
  unfold ashr_sgt_noexact_before ashr_sgt_noexact_combined
  simp_alive_peephole
  sorry
def ashr_sge_noexact_combined := [llvmfunc|
  llvm.func @ashr_sge_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(79 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_sge_noexact   : ashr_sge_noexact_before  ⊑  ashr_sge_noexact_combined := by
  unfold ashr_sge_noexact_before ashr_sge_noexact_combined
  simp_alive_peephole
  sorry
def ashr_slt_noexact_combined := [llvmfunc|
  llvm.func @ashr_slt_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_slt_noexact   : ashr_slt_noexact_before  ⊑  ashr_slt_noexact_combined := by
  unfold ashr_slt_noexact_before ashr_slt_noexact_combined
  simp_alive_peephole
  sorry
def ashr_sle_noexact_combined := [llvmfunc|
  llvm.func @ashr_sle_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(88 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_sle_noexact   : ashr_sle_noexact_before  ⊑  ashr_sle_noexact_combined := by
  unfold ashr_sle_noexact_before ashr_sle_noexact_combined
  simp_alive_peephole
  sorry
def ashr_00_00_ashr_extra_use_combined := [llvmfunc|
  llvm.func @ashr_00_00_ashr_extra_use(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.store %2, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return %3 : i1
  }]

theorem inst_combine_ashr_00_00_ashr_extra_use   : ashr_00_00_ashr_extra_use_before  ⊑  ashr_00_00_ashr_extra_use_combined := by
  unfold ashr_00_00_ashr_extra_use_before ashr_00_00_ashr_extra_use_combined
  simp_alive_peephole
  sorry
def ashr_00_00_vec_combined := [llvmfunc|
  llvm.func @ashr_00_00_vec(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<88> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<4xi8>
    llvm.return %1 : vector<4xi1>
  }]

theorem inst_combine_ashr_00_00_vec   : ashr_00_00_vec_before  ⊑  ashr_00_00_vec_combined := by
  unfold ashr_00_00_vec_before ashr_00_00_vec_combined
  simp_alive_peephole
  sorry
def ashr_sgt_overflow_combined := [llvmfunc|
  llvm.func @ashr_sgt_overflow(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashr_sgt_overflow   : ashr_sgt_overflow_before  ⊑  ashr_sgt_overflow_combined := by
  unfold ashr_sgt_overflow_before ashr_sgt_overflow_combined
  simp_alive_peephole
  sorry
def lshrult_01_00_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_00_exact   : lshrult_01_00_exact_before  ⊑  lshrult_01_00_exact_combined := by
  unfold lshrult_01_00_exact_before lshrult_01_00_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_01_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "eq" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_01_exact   : lshrult_01_01_exact_before  ⊑  lshrult_01_01_exact_combined := by
  unfold lshrult_01_01_exact_before lshrult_01_01_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_02_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(4 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_02_exact   : lshrult_01_02_exact_before  ⊑  lshrult_01_02_exact_combined := by
  unfold lshrult_01_02_exact_before lshrult_01_02_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_03_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_03_exact   : lshrult_01_03_exact_before  ⊑  lshrult_01_03_exact_combined := by
  unfold lshrult_01_03_exact_before lshrult_01_03_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_04_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_04_exact   : lshrult_01_04_exact_before  ⊑  lshrult_01_04_exact_combined := by
  unfold lshrult_01_04_exact_before lshrult_01_04_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_05_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_05_exact   : lshrult_01_05_exact_before  ⊑  lshrult_01_05_exact_combined := by
  unfold lshrult_01_05_exact_before lshrult_01_05_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_06_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_06_exact   : lshrult_01_06_exact_before  ⊑  lshrult_01_06_exact_combined := by
  unfold lshrult_01_06_exact_before lshrult_01_06_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_07_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.icmp "ne" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_01_07_exact   : lshrult_01_07_exact_before  ⊑  lshrult_01_07_exact_combined := by
  unfold lshrult_01_07_exact_before lshrult_01_07_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_08_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_08_exact   : lshrult_01_08_exact_before  ⊑  lshrult_01_08_exact_combined := by
  unfold lshrult_01_08_exact_before lshrult_01_08_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_09_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_09_exact   : lshrult_01_09_exact_before  ⊑  lshrult_01_09_exact_combined := by
  unfold lshrult_01_09_exact_before lshrult_01_09_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_10_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_10_exact   : lshrult_01_10_exact_before  ⊑  lshrult_01_10_exact_combined := by
  unfold lshrult_01_10_exact_before lshrult_01_10_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_11_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_11_exact   : lshrult_01_11_exact_before  ⊑  lshrult_01_11_exact_combined := by
  unfold lshrult_01_11_exact_before lshrult_01_11_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_12_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_12_exact   : lshrult_01_12_exact_before  ⊑  lshrult_01_12_exact_combined := by
  unfold lshrult_01_12_exact_before lshrult_01_12_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_13_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_13_exact   : lshrult_01_13_exact_before  ⊑  lshrult_01_13_exact_combined := by
  unfold lshrult_01_13_exact_before lshrult_01_13_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_14_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_14_exact   : lshrult_01_14_exact_before  ⊑  lshrult_01_14_exact_combined := by
  unfold lshrult_01_14_exact_before lshrult_01_14_exact_combined
  simp_alive_peephole
  sorry
def lshrult_01_15_exact_combined := [llvmfunc|
  llvm.func @lshrult_01_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_01_15_exact   : lshrult_01_15_exact_before  ⊑  lshrult_01_15_exact_combined := by
  unfold lshrult_01_15_exact_before lshrult_01_15_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_00_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_00_exact   : lshrult_02_00_exact_before  ⊑  lshrult_02_00_exact_combined := by
  unfold lshrult_02_00_exact_before lshrult_02_00_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_01_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "eq" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_02_01_exact   : lshrult_02_01_exact_before  ⊑  lshrult_02_01_exact_combined := by
  unfold lshrult_02_01_exact_before lshrult_02_01_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_02_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_02_02_exact   : lshrult_02_02_exact_before  ⊑  lshrult_02_02_exact_combined := by
  unfold lshrult_02_02_exact_before lshrult_02_02_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_03_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.icmp "ne" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_02_03_exact   : lshrult_02_03_exact_before  ⊑  lshrult_02_03_exact_combined := by
  unfold lshrult_02_03_exact_before lshrult_02_03_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_04_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_04_exact   : lshrult_02_04_exact_before  ⊑  lshrult_02_04_exact_combined := by
  unfold lshrult_02_04_exact_before lshrult_02_04_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_05_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_05_exact   : lshrult_02_05_exact_before  ⊑  lshrult_02_05_exact_combined := by
  unfold lshrult_02_05_exact_before lshrult_02_05_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_06_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_06_exact   : lshrult_02_06_exact_before  ⊑  lshrult_02_06_exact_combined := by
  unfold lshrult_02_06_exact_before lshrult_02_06_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_07_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_07_exact   : lshrult_02_07_exact_before  ⊑  lshrult_02_07_exact_combined := by
  unfold lshrult_02_07_exact_before lshrult_02_07_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_08_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_08_exact   : lshrult_02_08_exact_before  ⊑  lshrult_02_08_exact_combined := by
  unfold lshrult_02_08_exact_before lshrult_02_08_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_09_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_09_exact   : lshrult_02_09_exact_before  ⊑  lshrult_02_09_exact_combined := by
  unfold lshrult_02_09_exact_before lshrult_02_09_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_10_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_10_exact   : lshrult_02_10_exact_before  ⊑  lshrult_02_10_exact_combined := by
  unfold lshrult_02_10_exact_before lshrult_02_10_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_11_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_11_exact   : lshrult_02_11_exact_before  ⊑  lshrult_02_11_exact_combined := by
  unfold lshrult_02_11_exact_before lshrult_02_11_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_12_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_12_exact   : lshrult_02_12_exact_before  ⊑  lshrult_02_12_exact_combined := by
  unfold lshrult_02_12_exact_before lshrult_02_12_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_13_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_13_exact   : lshrult_02_13_exact_before  ⊑  lshrult_02_13_exact_combined := by
  unfold lshrult_02_13_exact_before lshrult_02_13_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_14_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_14_exact   : lshrult_02_14_exact_before  ⊑  lshrult_02_14_exact_combined := by
  unfold lshrult_02_14_exact_before lshrult_02_14_exact_combined
  simp_alive_peephole
  sorry
def lshrult_02_15_exact_combined := [llvmfunc|
  llvm.func @lshrult_02_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_02_15_exact   : lshrult_02_15_exact_before  ⊑  lshrult_02_15_exact_combined := by
  unfold lshrult_02_15_exact_before lshrult_02_15_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_00_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_00_exact   : lshrult_03_00_exact_before  ⊑  lshrult_03_00_exact_combined := by
  unfold lshrult_03_00_exact_before lshrult_03_00_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_01_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "eq" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_lshrult_03_01_exact   : lshrult_03_01_exact_before  ⊑  lshrult_03_01_exact_combined := by
  unfold lshrult_03_01_exact_before lshrult_03_01_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_02_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_02_exact   : lshrult_03_02_exact_before  ⊑  lshrult_03_02_exact_combined := by
  unfold lshrult_03_02_exact_before lshrult_03_02_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_03_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_03_exact   : lshrult_03_03_exact_before  ⊑  lshrult_03_03_exact_combined := by
  unfold lshrult_03_03_exact_before lshrult_03_03_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_04_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_04_exact   : lshrult_03_04_exact_before  ⊑  lshrult_03_04_exact_combined := by
  unfold lshrult_03_04_exact_before lshrult_03_04_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_05_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_05_exact   : lshrult_03_05_exact_before  ⊑  lshrult_03_05_exact_combined := by
  unfold lshrult_03_05_exact_before lshrult_03_05_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_06_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_06_exact   : lshrult_03_06_exact_before  ⊑  lshrult_03_06_exact_combined := by
  unfold lshrult_03_06_exact_before lshrult_03_06_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_07_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_07_exact   : lshrult_03_07_exact_before  ⊑  lshrult_03_07_exact_combined := by
  unfold lshrult_03_07_exact_before lshrult_03_07_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_08_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_08_exact   : lshrult_03_08_exact_before  ⊑  lshrult_03_08_exact_combined := by
  unfold lshrult_03_08_exact_before lshrult_03_08_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_09_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_09_exact   : lshrult_03_09_exact_before  ⊑  lshrult_03_09_exact_combined := by
  unfold lshrult_03_09_exact_before lshrult_03_09_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_10_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_10_exact   : lshrult_03_10_exact_before  ⊑  lshrult_03_10_exact_combined := by
  unfold lshrult_03_10_exact_before lshrult_03_10_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_11_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_11_exact   : lshrult_03_11_exact_before  ⊑  lshrult_03_11_exact_combined := by
  unfold lshrult_03_11_exact_before lshrult_03_11_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_12_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_12_exact   : lshrult_03_12_exact_before  ⊑  lshrult_03_12_exact_combined := by
  unfold lshrult_03_12_exact_before lshrult_03_12_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_13_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_13_exact   : lshrult_03_13_exact_before  ⊑  lshrult_03_13_exact_combined := by
  unfold lshrult_03_13_exact_before lshrult_03_13_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_14_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_14_exact   : lshrult_03_14_exact_before  ⊑  lshrult_03_14_exact_combined := by
  unfold lshrult_03_14_exact_before lshrult_03_14_exact_combined
  simp_alive_peephole
  sorry
def lshrult_03_15_exact_combined := [llvmfunc|
  llvm.func @lshrult_03_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lshrult_03_15_exact   : lshrult_03_15_exact_before  ⊑  lshrult_03_15_exact_combined := by
  unfold lshrult_03_15_exact_before lshrult_03_15_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_00_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_00_exact   : ashrsgt_01_00_exact_before  ⊑  ashrsgt_01_00_exact_combined := by
  unfold ashrsgt_01_00_exact_before ashrsgt_01_00_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_01_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_01_exact   : ashrsgt_01_01_exact_before  ⊑  ashrsgt_01_01_exact_combined := by
  unfold ashrsgt_01_01_exact_before ashrsgt_01_01_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_02_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(4 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_02_exact   : ashrsgt_01_02_exact_before  ⊑  ashrsgt_01_02_exact_combined := by
  unfold ashrsgt_01_02_exact_before ashrsgt_01_02_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_03_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_03_exact   : ashrsgt_01_03_exact_before  ⊑  ashrsgt_01_03_exact_combined := by
  unfold ashrsgt_01_03_exact_before ashrsgt_01_03_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_04_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_04_exact   : ashrsgt_01_04_exact_before  ⊑  ashrsgt_01_04_exact_combined := by
  unfold ashrsgt_01_04_exact_before ashrsgt_01_04_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_05_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_05_exact   : ashrsgt_01_05_exact_before  ⊑  ashrsgt_01_05_exact_combined := by
  unfold ashrsgt_01_05_exact_before ashrsgt_01_05_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_06_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_06_exact   : ashrsgt_01_06_exact_before  ⊑  ashrsgt_01_06_exact_combined := by
  unfold ashrsgt_01_06_exact_before ashrsgt_01_06_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_07_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_07_exact   : ashrsgt_01_07_exact_before  ⊑  ashrsgt_01_07_exact_combined := by
  unfold ashrsgt_01_07_exact_before ashrsgt_01_07_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_08_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_08_exact   : ashrsgt_01_08_exact_before  ⊑  ashrsgt_01_08_exact_combined := by
  unfold ashrsgt_01_08_exact_before ashrsgt_01_08_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_09_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_09_exact   : ashrsgt_01_09_exact_before  ⊑  ashrsgt_01_09_exact_combined := by
  unfold ashrsgt_01_09_exact_before ashrsgt_01_09_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_10_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_10_exact   : ashrsgt_01_10_exact_before  ⊑  ashrsgt_01_10_exact_combined := by
  unfold ashrsgt_01_10_exact_before ashrsgt_01_10_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_11_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_01_11_exact   : ashrsgt_01_11_exact_before  ⊑  ashrsgt_01_11_exact_combined := by
  unfold ashrsgt_01_11_exact_before ashrsgt_01_11_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_12_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.icmp "ne" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_12_exact   : ashrsgt_01_12_exact_before  ⊑  ashrsgt_01_12_exact_combined := by
  unfold ashrsgt_01_12_exact_before ashrsgt_01_12_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_13_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_13_exact   : ashrsgt_01_13_exact_before  ⊑  ashrsgt_01_13_exact_combined := by
  unfold ashrsgt_01_13_exact_before ashrsgt_01_13_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_14_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_14_exact   : ashrsgt_01_14_exact_before  ⊑  ashrsgt_01_14_exact_combined := by
  unfold ashrsgt_01_14_exact_before ashrsgt_01_14_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_01_15_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_01_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_01_15_exact   : ashrsgt_01_15_exact_before  ⊑  ashrsgt_01_15_exact_combined := by
  unfold ashrsgt_01_15_exact_before ashrsgt_01_15_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_00_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_02_00_exact   : ashrsgt_02_00_exact_before  ⊑  ashrsgt_02_00_exact_combined := by
  unfold ashrsgt_02_00_exact_before ashrsgt_02_00_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_01_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_01_exact   : ashrsgt_02_01_exact_before  ⊑  ashrsgt_02_01_exact_combined := by
  unfold ashrsgt_02_01_exact_before ashrsgt_02_01_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_02_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_02_exact   : ashrsgt_02_02_exact_before  ⊑  ashrsgt_02_02_exact_combined := by
  unfold ashrsgt_02_02_exact_before ashrsgt_02_02_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_03_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_03_exact   : ashrsgt_02_03_exact_before  ⊑  ashrsgt_02_03_exact_combined := by
  unfold ashrsgt_02_03_exact_before ashrsgt_02_03_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_04_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_04_exact   : ashrsgt_02_04_exact_before  ⊑  ashrsgt_02_04_exact_combined := by
  unfold ashrsgt_02_04_exact_before ashrsgt_02_04_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_05_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_05_exact   : ashrsgt_02_05_exact_before  ⊑  ashrsgt_02_05_exact_combined := by
  unfold ashrsgt_02_05_exact_before ashrsgt_02_05_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_06_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_06_exact   : ashrsgt_02_06_exact_before  ⊑  ashrsgt_02_06_exact_combined := by
  unfold ashrsgt_02_06_exact_before ashrsgt_02_06_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_07_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_07_exact   : ashrsgt_02_07_exact_before  ⊑  ashrsgt_02_07_exact_combined := by
  unfold ashrsgt_02_07_exact_before ashrsgt_02_07_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_08_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_08_exact   : ashrsgt_02_08_exact_before  ⊑  ashrsgt_02_08_exact_combined := by
  unfold ashrsgt_02_08_exact_before ashrsgt_02_08_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_09_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_09_exact   : ashrsgt_02_09_exact_before  ⊑  ashrsgt_02_09_exact_combined := by
  unfold ashrsgt_02_09_exact_before ashrsgt_02_09_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_10_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_10_exact   : ashrsgt_02_10_exact_before  ⊑  ashrsgt_02_10_exact_combined := by
  unfold ashrsgt_02_10_exact_before ashrsgt_02_10_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_11_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_11_exact   : ashrsgt_02_11_exact_before  ⊑  ashrsgt_02_11_exact_combined := by
  unfold ashrsgt_02_11_exact_before ashrsgt_02_11_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_12_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_12_exact   : ashrsgt_02_12_exact_before  ⊑  ashrsgt_02_12_exact_combined := by
  unfold ashrsgt_02_12_exact_before ashrsgt_02_12_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_13_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_02_13_exact   : ashrsgt_02_13_exact_before  ⊑  ashrsgt_02_13_exact_combined := by
  unfold ashrsgt_02_13_exact_before ashrsgt_02_13_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_14_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.icmp "ne" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_02_14_exact   : ashrsgt_02_14_exact_before  ⊑  ashrsgt_02_14_exact_combined := by
  unfold ashrsgt_02_14_exact_before ashrsgt_02_14_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_02_15_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_02_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_02_15_exact   : ashrsgt_02_15_exact_before  ⊑  ashrsgt_02_15_exact_combined := by
  unfold ashrsgt_02_15_exact_before ashrsgt_02_15_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_00_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_00_exact   : ashrsgt_03_00_exact_before  ⊑  ashrsgt_03_00_exact_combined := by
  unfold ashrsgt_03_00_exact_before ashrsgt_03_00_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_01_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_01_exact   : ashrsgt_03_01_exact_before  ⊑  ashrsgt_03_01_exact_combined := by
  unfold ashrsgt_03_01_exact_before ashrsgt_03_01_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_02_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_02_exact   : ashrsgt_03_02_exact_before  ⊑  ashrsgt_03_02_exact_combined := by
  unfold ashrsgt_03_02_exact_before ashrsgt_03_02_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_03_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_03_exact   : ashrsgt_03_03_exact_before  ⊑  ashrsgt_03_03_exact_combined := by
  unfold ashrsgt_03_03_exact_before ashrsgt_03_03_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_04_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_04_exact   : ashrsgt_03_04_exact_before  ⊑  ashrsgt_03_04_exact_combined := by
  unfold ashrsgt_03_04_exact_before ashrsgt_03_04_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_05_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_05_exact   : ashrsgt_03_05_exact_before  ⊑  ashrsgt_03_05_exact_combined := by
  unfold ashrsgt_03_05_exact_before ashrsgt_03_05_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_06_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_06_exact   : ashrsgt_03_06_exact_before  ⊑  ashrsgt_03_06_exact_combined := by
  unfold ashrsgt_03_06_exact_before ashrsgt_03_06_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_07_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_07_exact   : ashrsgt_03_07_exact_before  ⊑  ashrsgt_03_07_exact_combined := by
  unfold ashrsgt_03_07_exact_before ashrsgt_03_07_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_08_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_08_exact   : ashrsgt_03_08_exact_before  ⊑  ashrsgt_03_08_exact_combined := by
  unfold ashrsgt_03_08_exact_before ashrsgt_03_08_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_09_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_09_exact   : ashrsgt_03_09_exact_before  ⊑  ashrsgt_03_09_exact_combined := by
  unfold ashrsgt_03_09_exact_before ashrsgt_03_09_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_10_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_10_exact   : ashrsgt_03_10_exact_before  ⊑  ashrsgt_03_10_exact_combined := by
  unfold ashrsgt_03_10_exact_before ashrsgt_03_10_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_11_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_11_exact   : ashrsgt_03_11_exact_before  ⊑  ashrsgt_03_11_exact_combined := by
  unfold ashrsgt_03_11_exact_before ashrsgt_03_11_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_12_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_12_exact   : ashrsgt_03_12_exact_before  ⊑  ashrsgt_03_12_exact_combined := by
  unfold ashrsgt_03_12_exact_before ashrsgt_03_12_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_13_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_13_exact   : ashrsgt_03_13_exact_before  ⊑  ashrsgt_03_13_exact_combined := by
  unfold ashrsgt_03_13_exact_before ashrsgt_03_13_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_14_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrsgt_03_14_exact   : ashrsgt_03_14_exact_before  ⊑  ashrsgt_03_14_exact_combined := by
  unfold ashrsgt_03_14_exact_before ashrsgt_03_14_exact_combined
  simp_alive_peephole
  sorry
def ashrsgt_03_15_exact_combined := [llvmfunc|
  llvm.func @ashrsgt_03_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrsgt_03_15_exact   : ashrsgt_03_15_exact_before  ⊑  ashrsgt_03_15_exact_combined := by
  unfold ashrsgt_03_15_exact_before ashrsgt_03_15_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_00_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_00_exact   : ashrslt_01_00_exact_before  ⊑  ashrslt_01_00_exact_combined := by
  unfold ashrslt_01_00_exact_before ashrslt_01_00_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_01_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_01_exact   : ashrslt_01_01_exact_before  ⊑  ashrslt_01_01_exact_combined := by
  unfold ashrslt_01_01_exact_before ashrslt_01_01_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_02_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(4 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_02_exact   : ashrslt_01_02_exact_before  ⊑  ashrslt_01_02_exact_combined := by
  unfold ashrslt_01_02_exact_before ashrslt_01_02_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_03_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_03_exact   : ashrslt_01_03_exact_before  ⊑  ashrslt_01_03_exact_combined := by
  unfold ashrslt_01_03_exact_before ashrslt_01_03_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_04_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_04_exact   : ashrslt_01_04_exact_before  ⊑  ashrslt_01_04_exact_combined := by
  unfold ashrslt_01_04_exact_before ashrslt_01_04_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_05_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_05_exact   : ashrslt_01_05_exact_before  ⊑  ashrslt_01_05_exact_combined := by
  unfold ashrslt_01_05_exact_before ashrslt_01_05_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_06_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_06_exact   : ashrslt_01_06_exact_before  ⊑  ashrslt_01_06_exact_combined := by
  unfold ashrslt_01_06_exact_before ashrslt_01_06_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_07_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_07_exact   : ashrslt_01_07_exact_before  ⊑  ashrslt_01_07_exact_combined := by
  unfold ashrslt_01_07_exact_before ashrslt_01_07_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_08_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_08_exact   : ashrslt_01_08_exact_before  ⊑  ashrslt_01_08_exact_combined := by
  unfold ashrslt_01_08_exact_before ashrslt_01_08_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_09_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_09_exact   : ashrslt_01_09_exact_before  ⊑  ashrslt_01_09_exact_combined := by
  unfold ashrslt_01_09_exact_before ashrslt_01_09_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_10_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_10_exact   : ashrslt_01_10_exact_before  ⊑  ashrslt_01_10_exact_combined := by
  unfold ashrslt_01_10_exact_before ashrslt_01_10_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_11_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_11_exact   : ashrslt_01_11_exact_before  ⊑  ashrslt_01_11_exact_combined := by
  unfold ashrslt_01_11_exact_before ashrslt_01_11_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_12_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_01_12_exact   : ashrslt_01_12_exact_before  ⊑  ashrslt_01_12_exact_combined := by
  unfold ashrslt_01_12_exact_before ashrslt_01_12_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_13_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_13_exact   : ashrslt_01_13_exact_before  ⊑  ashrslt_01_13_exact_combined := by
  unfold ashrslt_01_13_exact_before ashrslt_01_13_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_14_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_14_exact   : ashrslt_01_14_exact_before  ⊑  ashrslt_01_14_exact_combined := by
  unfold ashrslt_01_14_exact_before ashrslt_01_14_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_01_15_exact_combined := [llvmfunc|
  llvm.func @ashrslt_01_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_01_15_exact   : ashrslt_01_15_exact_before  ⊑  ashrslt_01_15_exact_combined := by
  unfold ashrslt_01_15_exact_before ashrslt_01_15_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_00_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_02_00_exact   : ashrslt_02_00_exact_before  ⊑  ashrslt_02_00_exact_combined := by
  unfold ashrslt_02_00_exact_before ashrslt_02_00_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_01_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(4 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_02_01_exact   : ashrslt_02_01_exact_before  ⊑  ashrslt_02_01_exact_combined := by
  unfold ashrslt_02_01_exact_before ashrslt_02_01_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_02_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_02_exact   : ashrslt_02_02_exact_before  ⊑  ashrslt_02_02_exact_combined := by
  unfold ashrslt_02_02_exact_before ashrslt_02_02_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_03_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_03_exact   : ashrslt_02_03_exact_before  ⊑  ashrslt_02_03_exact_combined := by
  unfold ashrslt_02_03_exact_before ashrslt_02_03_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_04_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_04_exact   : ashrslt_02_04_exact_before  ⊑  ashrslt_02_04_exact_combined := by
  unfold ashrslt_02_04_exact_before ashrslt_02_04_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_05_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_05_exact   : ashrslt_02_05_exact_before  ⊑  ashrslt_02_05_exact_combined := by
  unfold ashrslt_02_05_exact_before ashrslt_02_05_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_06_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_06_exact   : ashrslt_02_06_exact_before  ⊑  ashrslt_02_06_exact_combined := by
  unfold ashrslt_02_06_exact_before ashrslt_02_06_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_07_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_07_exact   : ashrslt_02_07_exact_before  ⊑  ashrslt_02_07_exact_combined := by
  unfold ashrslt_02_07_exact_before ashrslt_02_07_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_08_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_08_exact   : ashrslt_02_08_exact_before  ⊑  ashrslt_02_08_exact_combined := by
  unfold ashrslt_02_08_exact_before ashrslt_02_08_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_09_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_09_exact   : ashrslt_02_09_exact_before  ⊑  ashrslt_02_09_exact_combined := by
  unfold ashrslt_02_09_exact_before ashrslt_02_09_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_10_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_10_exact   : ashrslt_02_10_exact_before  ⊑  ashrslt_02_10_exact_combined := by
  unfold ashrslt_02_10_exact_before ashrslt_02_10_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_11_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_11_exact   : ashrslt_02_11_exact_before  ⊑  ashrslt_02_11_exact_combined := by
  unfold ashrslt_02_11_exact_before ashrslt_02_11_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_12_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_12_exact   : ashrslt_02_12_exact_before  ⊑  ashrslt_02_12_exact_combined := by
  unfold ashrslt_02_12_exact_before ashrslt_02_12_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_13_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_13_exact   : ashrslt_02_13_exact_before  ⊑  ashrslt_02_13_exact_combined := by
  unfold ashrslt_02_13_exact_before ashrslt_02_13_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_14_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_02_14_exact   : ashrslt_02_14_exact_before  ⊑  ashrslt_02_14_exact_combined := by
  unfold ashrslt_02_14_exact_before ashrslt_02_14_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_02_15_exact_combined := [llvmfunc|
  llvm.func @ashrslt_02_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_02_15_exact   : ashrslt_02_15_exact_before  ⊑  ashrslt_02_15_exact_combined := by
  unfold ashrslt_02_15_exact_before ashrslt_02_15_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_00_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_00_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashrslt_03_00_exact   : ashrslt_03_00_exact_before  ⊑  ashrslt_03_00_exact_combined := by
  unfold ashrslt_03_00_exact_before ashrslt_03_00_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_01_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_01_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_01_exact   : ashrslt_03_01_exact_before  ⊑  ashrslt_03_01_exact_combined := by
  unfold ashrslt_03_01_exact_before ashrslt_03_01_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_02_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_02_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_02_exact   : ashrslt_03_02_exact_before  ⊑  ashrslt_03_02_exact_combined := by
  unfold ashrslt_03_02_exact_before ashrslt_03_02_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_03_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_03_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_03_exact   : ashrslt_03_03_exact_before  ⊑  ashrslt_03_03_exact_combined := by
  unfold ashrslt_03_03_exact_before ashrslt_03_03_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_04_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_04_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_04_exact   : ashrslt_03_04_exact_before  ⊑  ashrslt_03_04_exact_combined := by
  unfold ashrslt_03_04_exact_before ashrslt_03_04_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_05_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_05_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_05_exact   : ashrslt_03_05_exact_before  ⊑  ashrslt_03_05_exact_combined := by
  unfold ashrslt_03_05_exact_before ashrslt_03_05_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_06_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_06_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_06_exact   : ashrslt_03_06_exact_before  ⊑  ashrslt_03_06_exact_combined := by
  unfold ashrslt_03_06_exact_before ashrslt_03_06_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_07_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_07_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_07_exact   : ashrslt_03_07_exact_before  ⊑  ashrslt_03_07_exact_combined := by
  unfold ashrslt_03_07_exact_before ashrslt_03_07_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_08_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_08_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_08_exact   : ashrslt_03_08_exact_before  ⊑  ashrslt_03_08_exact_combined := by
  unfold ashrslt_03_08_exact_before ashrslt_03_08_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_09_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_09_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_09_exact   : ashrslt_03_09_exact_before  ⊑  ashrslt_03_09_exact_combined := by
  unfold ashrslt_03_09_exact_before ashrslt_03_09_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_10_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_10_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_10_exact   : ashrslt_03_10_exact_before  ⊑  ashrslt_03_10_exact_combined := by
  unfold ashrslt_03_10_exact_before ashrslt_03_10_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_11_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_11_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_11_exact   : ashrslt_03_11_exact_before  ⊑  ashrslt_03_11_exact_combined := by
  unfold ashrslt_03_11_exact_before ashrslt_03_11_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_12_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_12_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_12_exact   : ashrslt_03_12_exact_before  ⊑  ashrslt_03_12_exact_combined := by
  unfold ashrslt_03_12_exact_before ashrslt_03_12_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_13_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_13_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_13_exact   : ashrslt_03_13_exact_before  ⊑  ashrslt_03_13_exact_combined := by
  unfold ashrslt_03_13_exact_before ashrslt_03_13_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_14_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_14_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_14_exact   : ashrslt_03_14_exact_before  ⊑  ashrslt_03_14_exact_combined := by
  unfold ashrslt_03_14_exact_before ashrslt_03_14_exact_combined
  simp_alive_peephole
  sorry
def ashrslt_03_15_exact_combined := [llvmfunc|
  llvm.func @ashrslt_03_15_exact(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashrslt_03_15_exact   : ashrslt_03_15_exact_before  ⊑  ashrslt_03_15_exact_combined := by
  unfold ashrslt_03_15_exact_before ashrslt_03_15_exact_combined
  simp_alive_peephole
  sorry
def ashr_slt_exact_near_pow2_cmpval_combined := [llvmfunc|
  llvm.func @ashr_slt_exact_near_pow2_cmpval(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_slt_exact_near_pow2_cmpval   : ashr_slt_exact_near_pow2_cmpval_before  ⊑  ashr_slt_exact_near_pow2_cmpval_combined := by
  unfold ashr_slt_exact_near_pow2_cmpval_before ashr_slt_exact_near_pow2_cmpval_combined
  simp_alive_peephole
  sorry
def ashr_ult_exact_near_pow2_cmpval_combined := [llvmfunc|
  llvm.func @ashr_ult_exact_near_pow2_cmpval(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_exact_near_pow2_cmpval   : ashr_ult_exact_near_pow2_cmpval_before  ⊑  ashr_ult_exact_near_pow2_cmpval_combined := by
  unfold ashr_ult_exact_near_pow2_cmpval_before ashr_ult_exact_near_pow2_cmpval_combined
  simp_alive_peephole
  sorry
def negtest_near_pow2_cmpval_ashr_slt_noexact_combined := [llvmfunc|
  llvm.func @negtest_near_pow2_cmpval_ashr_slt_noexact(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_negtest_near_pow2_cmpval_ashr_slt_noexact   : negtest_near_pow2_cmpval_ashr_slt_noexact_before  ⊑  negtest_near_pow2_cmpval_ashr_slt_noexact_combined := by
  unfold negtest_near_pow2_cmpval_ashr_slt_noexact_before negtest_near_pow2_cmpval_ashr_slt_noexact_combined
  simp_alive_peephole
  sorry
def negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_combined := [llvmfunc|
  llvm.func @negtest_near_pow2_cmpval_ashr_wrong_cmp_pred(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_negtest_near_pow2_cmpval_ashr_wrong_cmp_pred   : negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_before  ⊑  negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_combined := by
  unfold negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_before negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_combined
  simp_alive_peephole
  sorry
def negtest_near_pow2_cmpval_isnt_close_to_pow2_combined := [llvmfunc|
  llvm.func @negtest_near_pow2_cmpval_isnt_close_to_pow2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_negtest_near_pow2_cmpval_isnt_close_to_pow2   : negtest_near_pow2_cmpval_isnt_close_to_pow2_before  ⊑  negtest_near_pow2_cmpval_isnt_close_to_pow2_combined := by
  unfold negtest_near_pow2_cmpval_isnt_close_to_pow2_before negtest_near_pow2_cmpval_isnt_close_to_pow2_combined
  simp_alive_peephole
  sorry
def negtest_near_pow2_cmpval_would_overflow_into_signbit_combined := [llvmfunc|
  llvm.func @negtest_near_pow2_cmpval_would_overflow_into_signbit(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_negtest_near_pow2_cmpval_would_overflow_into_signbit   : negtest_near_pow2_cmpval_would_overflow_into_signbit_before  ⊑  negtest_near_pow2_cmpval_would_overflow_into_signbit_combined := by
  unfold negtest_near_pow2_cmpval_would_overflow_into_signbit_before negtest_near_pow2_cmpval_would_overflow_into_signbit_combined
  simp_alive_peephole
  sorry
