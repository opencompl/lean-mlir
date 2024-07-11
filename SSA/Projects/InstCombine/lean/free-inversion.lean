import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  free-inversion
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def xor_1_before := [llvmfunc|
  llvm.func @xor_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.xor %4, %arg0  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def xor_2_before := [llvmfunc|
  llvm.func @xor_2(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.xor %arg0, %4  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def xor_fail_before := [llvmfunc|
  llvm.func @xor_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.select %arg1, %1, %arg3 : i1, i8
    %3 = llvm.xor %arg0, %2  : i8
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }]

def add_1_before := [llvmfunc|
  llvm.func @add_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.add %4, %arg0  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def add_2_before := [llvmfunc|
  llvm.func @add_2(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.add %arg0, %4  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def add_fail_before := [llvmfunc|
  llvm.func @add_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg2, %arg0  : i8
    %3 = llvm.xor %arg3, %0  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.add %arg0, %4  : i8
    %6 = llvm.xor %5, %1  : i8
    llvm.return %6 : i8
  }]

def sub_1_before := [llvmfunc|
  llvm.func @sub_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.sub %4, %arg0  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def sub_2_before := [llvmfunc|
  llvm.func @sub_2(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.sub %arg0, %4  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def sub_3_before := [llvmfunc|
  llvm.func @sub_3(%arg0: i128, %arg1: i1, %arg2: i128, %arg3: i128) -> i128 {
    %0 = llvm.mlir.constant(-1 : i128) : i128
    %1 = llvm.mlir.constant(123 : i128) : i128
    %2 = llvm.xor %arg2, %0  : i128
    %3 = llvm.xor %arg3, %1  : i128
    %4 = llvm.select %arg1, %2, %3 : i1, i128
    %5 = llvm.sub %arg0, %4  : i128
    %6 = llvm.xor %5, %0  : i128
    llvm.return %6 : i128
  }]

def sub_fail_before := [llvmfunc|
  llvm.func @sub_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.sub %4, %arg0  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def ashr_1_before := [llvmfunc|
  llvm.func @ashr_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.ashr %4, %arg0  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def ashr_2_fail_before := [llvmfunc|
  llvm.func @ashr_2_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.ashr %arg0, %4  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def select_1_before := [llvmfunc|
  llvm.func @select_1(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i1, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.mlir.constant(45 : i8) : i8
    %3 = llvm.xor %arg4, %0  : i8
    %4 = llvm.xor %arg5, %1  : i8
    %5 = llvm.select %arg3, %3, %4 : i1, i8
    %6 = llvm.xor %arg1, %2  : i8
    %7 = llvm.xor %arg2, %6  : i8
    %8 = llvm.select %arg0, %7, %5 : i1, i8
    %9 = llvm.xor %8, %0  : i8
    llvm.return %9 : i8
  }]

def select_2_before := [llvmfunc|
  llvm.func @select_2(%arg0: i1, %arg1: i8, %arg2: i1, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.mlir.constant(45 : i8) : i8
    %3 = llvm.xor %arg3, %0  : i8
    %4 = llvm.xor %arg4, %1  : i8
    %5 = llvm.select %arg2, %3, %4 : i1, i8
    %6 = llvm.xor %arg1, %2  : i8
    %7 = llvm.select %arg0, %5, %6 : i1, i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }]

def select_logic_or_fail_before := [llvmfunc|
  llvm.func @select_logic_or_fail(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.xor %arg2, %0  : i1
    %4 = llvm.icmp "eq" %arg3, %1 : i8
    %5 = llvm.select %arg1, %3, %4 : i1, i1
    %6 = llvm.select %arg0, %5, %2 : i1, i1
    %7 = llvm.xor %6, %0  : i1
    llvm.return %7 : i1
  }]

def select_logic_and_fail_before := [llvmfunc|
  llvm.func @select_logic_and_fail(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.icmp "eq" %arg3, %1 : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i1
    %5 = llvm.select %arg0, %0, %4 : i1, i1
    %6 = llvm.xor %5, %0  : i1
    llvm.return %6 : i1
  }]

def smin_1_before := [llvmfunc|
  llvm.func @smin_1(%arg0: i8, %arg1: i8, %arg2: i1, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg3, %0  : i8
    %3 = llvm.xor %arg4, %1  : i8
    %4 = llvm.select %arg2, %2, %3 : i1, i8
    %5 = llvm.xor %arg1, %0  : i8
    %6 = llvm.add %arg0, %5  : i8
    %7 = llvm.intr.smin(%6, %4)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }]

def smin_1_fail_before := [llvmfunc|
  llvm.func @smin_1_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.intr.smin(%arg0, %4)  : (i8, i8) -> i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

def umin_1_fail_before := [llvmfunc|
  llvm.func @umin_1_fail(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(85 : i8) : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.select %arg0, %2, %arg2 : i1, i8
    %4 = llvm.intr.umin(%3, %1)  : (i8, i8) -> i8
    %5 = llvm.xor %4, %0  : i8
    llvm.return %5 : i8
  }]

def smax_1_before := [llvmfunc|
  llvm.func @smax_1(%arg0: i8, %arg1: i8, %arg2: i1, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg3, %0  : i8
    %3 = llvm.xor %arg4, %1  : i8
    %4 = llvm.select %arg2, %2, %3 : i1, i8
    %5 = llvm.xor %arg1, %0  : i8
    %6 = llvm.sub %5, %arg0  : i8
    %7 = llvm.intr.smax(%6, %4)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }]

def smax_1_fail_before := [llvmfunc|
  llvm.func @smax_1_fail(%arg0: i8, %arg1: i8, %arg2: i1, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg3, %0  : i8
    %3 = llvm.xor %arg4, %1  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.select %arg2, %2, %3 : i1, i8
    %5 = llvm.xor %arg1, %0  : i8
    %6 = llvm.sub %5, %arg0  : i8
    %7 = llvm.intr.smax(%6, %4)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }]

def umax_1_before := [llvmfunc|
  llvm.func @umax_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.mlir.constant(85 : i8) : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %1  : i8
    %5 = llvm.select %arg1, %3, %4 : i1, i8
    %6 = llvm.intr.umax(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.xor %6, %0  : i8
    llvm.return %7 : i8
  }]

def umax_1_fail_before := [llvmfunc|
  llvm.func @umax_1_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.mlir.constant(85 : i8) : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %1  : i8
    %5 = llvm.select %arg1, %3, %4 : i1, i8
    llvm.call @use.i8(%5) : (i8) -> ()
    %6 = llvm.intr.umax(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.xor %6, %0  : i8
    llvm.return %7 : i8
  }]

def sub_both_freely_invertable_always_before := [llvmfunc|
  llvm.func @sub_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.sub %2, %3  : i8
    llvm.return %4 : i8
  }]

def add_both_freely_invertable_always_before := [llvmfunc|
  llvm.func @add_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.add %2, %3  : i8
    llvm.return %4 : i8
  }]

def xor_both_freely_invertable_always_before := [llvmfunc|
  llvm.func @xor_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.xor %2, %3  : i8
    llvm.return %4 : i8
  }]

def ashr_both_freely_invertable_always_before := [llvmfunc|
  llvm.func @ashr_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }]

def select_both_freely_invertable_always_before := [llvmfunc|
  llvm.func @select_both_freely_invertable_always(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %1  : i8
    %4 = llvm.select %arg0, %2, %3 : i1, i8
    llvm.return %4 : i8
  }]

def umin_both_freely_invertable_always_before := [llvmfunc|
  llvm.func @umin_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.intr.umin(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def umax_both_freely_invertable_always_before := [llvmfunc|
  llvm.func @umax_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.intr.umax(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def smin_both_freely_invertable_always_before := [llvmfunc|
  llvm.func @smin_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.intr.smin(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def smax_both_freely_invertable_always_before := [llvmfunc|
  llvm.func @smax_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.intr.smax(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def lshr_nneg_before := [llvmfunc|
  llvm.func @lshr_nneg(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.lshr %3, %arg1  : i8
    %5 = llvm.xor %4, %1  : i8
    llvm.return %5 : i8
  }]

def lshr_not_nneg_before := [llvmfunc|
  llvm.func @lshr_not_nneg(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.lshr %1, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

def lshr_not_nneg2_before := [llvmfunc|
  llvm.func @lshr_not_nneg2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %2, %1  : i8
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }]

def test_inv_free_before := [llvmfunc|
  llvm.func @test_inv_free(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i1), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i1)
  ^bb3:  // pred: ^bb1
    %2 = llvm.xor %arg2, %1  : i1
    llvm.br ^bb4(%2 : i1)
  ^bb4(%3: i1):  // 3 preds: ^bb1, ^bb2, ^bb3
    %4 = llvm.xor %arg3, %1  : i1
    %5 = llvm.or %3, %4  : i1
    llvm.cond_br %5, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    llvm.return %1 : i1
  ^bb6:  // pred: ^bb4
    llvm.return %0 : i1
  }]

def test_inv_free_i32_before := [llvmfunc|
  llvm.func @test_inv_free_i32(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i32), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb3:  // pred: ^bb1
    %2 = llvm.xor %arg2, %1  : i32
    llvm.br ^bb4(%2 : i32)
  ^bb4(%3: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %4 = llvm.xor %arg3, %1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }]

def test_inv_free_multiuse_before := [llvmfunc|
  llvm.func @test_inv_free_multiuse(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i1), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i1)
  ^bb3:  // pred: ^bb1
    %2 = llvm.xor %arg2, %1  : i1
    llvm.br ^bb4(%2 : i1)
  ^bb4(%3: i1):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.call @use.i1(%3) : (i1) -> ()
    %4 = llvm.xor %arg3, %1  : i1
    %5 = llvm.or %3, %4  : i1
    llvm.cond_br %5, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    llvm.return %1 : i1
  ^bb6:  // pred: ^bb4
    llvm.return %0 : i1
  }]

def test_inv_free_i32_newinst_before := [llvmfunc|
  llvm.func @test_inv_free_i32_newinst(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-8 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i32), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb3:  // pred: ^bb1
    %3 = llvm.ashr %2, %arg2  : i32
    llvm.br ^bb4(%3 : i32)
  ^bb4(%4: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %5 = llvm.xor %arg3, %1  : i32
    %6 = llvm.xor %4, %5  : i32
    llvm.return %6 : i32
  }]

def test_inv_free_loop_before := [llvmfunc|
  llvm.func @test_inv_free_loop(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i1), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i1)
  ^bb3:  // pred: ^bb1
    %2 = llvm.xor %arg2, %1  : i1
    llvm.br ^bb4(%2 : i1)
  ^bb4(%3: i1):  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    %4 = llvm.xor %arg3, %1  : i1
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.xor %3, %1  : i1
    llvm.cond_br %5, ^bb4(%6 : i1), ^bb5
  ^bb5:  // pred: ^bb4
    llvm.return %1 : i1
  }]

def xor_1_combined := [llvmfunc|
  llvm.func @xor_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-124 : i8) : i8
    %1 = llvm.xor %arg3, %0  : i8
    %2 = llvm.select %arg1, %arg2, %1 : i1, i8
    %3 = llvm.xor %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_xor_1   : xor_1_before  ⊑  xor_1_combined := by
  unfold xor_1_before xor_1_combined
  simp_alive_peephole
  sorry
def xor_2_combined := [llvmfunc|
  llvm.func @xor_2(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-124 : i8) : i8
    %1 = llvm.xor %arg3, %0  : i8
    %2 = llvm.select %arg1, %arg2, %1 : i1, i8
    %3 = llvm.xor %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_xor_2   : xor_2_before  ⊑  xor_2_combined := by
  unfold xor_2_before xor_2_combined
  simp_alive_peephole
  sorry
def xor_fail_combined := [llvmfunc|
  llvm.func @xor_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.select %arg1, %1, %arg3 : i1, i8
    %3 = llvm.xor %2, %arg0  : i8
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_xor_fail   : xor_fail_before  ⊑  xor_fail_combined := by
  unfold xor_fail_before xor_fail_combined
  simp_alive_peephole
  sorry
def add_1_combined := [llvmfunc|
  llvm.func @add_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-124 : i8) : i8
    %1 = llvm.xor %arg3, %0  : i8
    %2 = llvm.select %arg1, %arg2, %1 : i1, i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_add_1   : add_1_before  ⊑  add_1_combined := by
  unfold add_1_before add_1_combined
  simp_alive_peephole
  sorry
def add_2_combined := [llvmfunc|
  llvm.func @add_2(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-124 : i8) : i8
    %1 = llvm.xor %arg3, %0  : i8
    %2 = llvm.select %arg1, %arg2, %1 : i1, i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_add_2   : add_2_before  ⊑  add_2_combined := by
  unfold add_2_before add_2_combined
  simp_alive_peephole
  sorry
def add_fail_combined := [llvmfunc|
  llvm.func @add_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg2, %arg0  : i8
    %3 = llvm.xor %arg3, %0  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.add %4, %arg0  : i8
    %6 = llvm.xor %5, %1  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_add_fail   : add_fail_before  ⊑  add_fail_combined := by
  unfold add_fail_before add_fail_combined
  simp_alive_peephole
  sorry
def sub_1_combined := [llvmfunc|
  llvm.func @sub_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-124 : i8) : i8
    %1 = llvm.xor %arg3, %0  : i8
    %2 = llvm.select %arg1, %arg2, %1 : i1, i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_sub_1   : sub_1_before  ⊑  sub_1_combined := by
  unfold sub_1_before sub_1_combined
  simp_alive_peephole
  sorry
def sub_2_combined := [llvmfunc|
  llvm.func @sub_2(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-124 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.xor %arg3, %0  : i8
    %3 = llvm.select %arg1, %arg2, %2 : i1, i8
    %4 = llvm.add %3, %arg0  : i8
    %5 = llvm.sub %1, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_sub_2   : sub_2_before  ⊑  sub_2_combined := by
  unfold sub_2_before sub_2_combined
  simp_alive_peephole
  sorry
def sub_3_combined := [llvmfunc|
  llvm.func @sub_3(%arg0: i128, %arg1: i1, %arg2: i128, %arg3: i128) -> i128 {
    %0 = llvm.mlir.constant(-124 : i128) : i128
    %1 = llvm.mlir.constant(-2 : i128) : i128
    %2 = llvm.xor %arg3, %0  : i128
    %3 = llvm.select %arg1, %arg2, %2 : i1, i128
    %4 = llvm.add %3, %arg0  : i128
    %5 = llvm.sub %1, %4  : i128
    llvm.return %5 : i128
  }]

theorem inst_combine_sub_3   : sub_3_before  ⊑  sub_3_combined := by
  unfold sub_3_before sub_3_combined
  simp_alive_peephole
  sorry
def sub_fail_combined := [llvmfunc|
  llvm.func @sub_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-124 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %arg2, %3 : i1, i8
    %5 = llvm.add %4, %arg0  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_sub_fail   : sub_fail_before  ⊑  sub_fail_combined := by
  unfold sub_fail_before sub_fail_combined
  simp_alive_peephole
  sorry
def ashr_1_combined := [llvmfunc|
  llvm.func @ashr_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-124 : i8) : i8
    %1 = llvm.xor %arg3, %0  : i8
    %2 = llvm.select %arg1, %arg2, %1 : i1, i8
    %3 = llvm.ashr %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_ashr_1   : ashr_1_before  ⊑  ashr_1_combined := by
  unfold ashr_1_before ashr_1_combined
  simp_alive_peephole
  sorry
def ashr_2_fail_combined := [llvmfunc|
  llvm.func @ashr_2_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.ashr %arg0, %4  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_ashr_2_fail   : ashr_2_fail_before  ⊑  ashr_2_fail_combined := by
  unfold ashr_2_fail_before ashr_2_fail_combined
  simp_alive_peephole
  sorry
def select_1_combined := [llvmfunc|
  llvm.func @select_1(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i1, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(-46 : i8) : i8
    %1 = llvm.mlir.constant(-124 : i8) : i8
    %2 = llvm.xor %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.xor %arg5, %1  : i8
    %5 = llvm.select %arg3, %arg4, %4 : i1, i8
    %6 = llvm.select %arg0, %3, %5 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_select_1   : select_1_before  ⊑  select_1_combined := by
  unfold select_1_before select_1_combined
  simp_alive_peephole
  sorry
def select_2_combined := [llvmfunc|
  llvm.func @select_2(%arg0: i1, %arg1: i8, %arg2: i1, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(-124 : i8) : i8
    %1 = llvm.mlir.constant(-46 : i8) : i8
    %2 = llvm.xor %arg4, %0  : i8
    %3 = llvm.select %arg2, %arg3, %2 : i1, i8
    %4 = llvm.xor %arg1, %1  : i8
    %5 = llvm.select %arg0, %3, %4 : i1, i8
    llvm.return %5 : i8
  }]

theorem inst_combine_select_2   : select_2_before  ⊑  select_2_combined := by
  unfold select_2_before select_2_combined
  simp_alive_peephole
  sorry
def select_logic_or_fail_combined := [llvmfunc|
  llvm.func @select_logic_or_fail(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.xor %arg2, %0  : i1
    %4 = llvm.icmp "eq" %arg3, %1 : i8
    %5 = llvm.select %arg1, %3, %4 : i1, i1
    %6 = llvm.select %arg0, %5, %2 : i1, i1
    %7 = llvm.xor %6, %0  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_select_logic_or_fail   : select_logic_or_fail_before  ⊑  select_logic_or_fail_combined := by
  unfold select_logic_or_fail_before select_logic_or_fail_combined
  simp_alive_peephole
  sorry
def select_logic_and_fail_combined := [llvmfunc|
  llvm.func @select_logic_and_fail(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.icmp "eq" %arg3, %1 : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i1
    %5 = llvm.select %arg0, %0, %4 : i1, i1
    %6 = llvm.xor %5, %0  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_select_logic_and_fail   : select_logic_and_fail_before  ⊑  select_logic_and_fail_combined := by
  unfold select_logic_and_fail_before select_logic_and_fail_combined
  simp_alive_peephole
  sorry
def smin_1_combined := [llvmfunc|
  llvm.func @smin_1(%arg0: i8, %arg1: i8, %arg2: i1, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(-124 : i8) : i8
    %1 = llvm.sub %arg1, %arg0  : i8
    %2 = llvm.xor %arg4, %0  : i8
    %3 = llvm.select %arg2, %arg3, %2 : i1, i8
    %4 = llvm.intr.smax(%1, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_smin_1   : smin_1_before  ⊑  smin_1_combined := by
  unfold smin_1_before smin_1_combined
  simp_alive_peephole
  sorry
def smin_1_fail_combined := [llvmfunc|
  llvm.func @smin_1_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.intr.smin(%arg0, %4)  : (i8, i8) -> i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_smin_1_fail   : smin_1_fail_before  ⊑  smin_1_fail_combined := by
  unfold smin_1_fail_before smin_1_fail_combined
  simp_alive_peephole
  sorry
def umin_1_fail_combined := [llvmfunc|
  llvm.func @umin_1_fail(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(85 : i8) : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.select %arg0, %2, %arg2 : i1, i8
    %4 = llvm.intr.umin(%3, %1)  : (i8, i8) -> i8
    %5 = llvm.xor %4, %0  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_umin_1_fail   : umin_1_fail_before  ⊑  umin_1_fail_combined := by
  unfold umin_1_fail_before umin_1_fail_combined
  simp_alive_peephole
  sorry
def smax_1_combined := [llvmfunc|
  llvm.func @smax_1(%arg0: i8, %arg1: i8, %arg2: i1, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(-124 : i8) : i8
    %1 = llvm.add %arg1, %arg0  : i8
    %2 = llvm.xor %arg4, %0  : i8
    %3 = llvm.select %arg2, %arg3, %2 : i1, i8
    %4 = llvm.intr.smin(%1, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_smax_1   : smax_1_before  ⊑  smax_1_combined := by
  unfold smax_1_before smax_1_combined
  simp_alive_peephole
  sorry
def smax_1_fail_combined := [llvmfunc|
  llvm.func @smax_1_fail(%arg0: i8, %arg1: i8, %arg2: i1, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg3, %0  : i8
    %3 = llvm.xor %arg4, %1  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.select %arg2, %2, %3 : i1, i8
    %5 = llvm.xor %arg1, %0  : i8
    %6 = llvm.sub %5, %arg0  : i8
    %7 = llvm.intr.smax(%6, %4)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }]

theorem inst_combine_smax_1_fail   : smax_1_fail_before  ⊑  smax_1_fail_combined := by
  unfold smax_1_fail_before smax_1_fail_combined
  simp_alive_peephole
  sorry
def umax_1_combined := [llvmfunc|
  llvm.func @umax_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-124 : i8) : i8
    %1 = llvm.mlir.constant(-86 : i8) : i8
    %2 = llvm.xor %arg3, %0  : i8
    %3 = llvm.select %arg1, %arg2, %2 : i1, i8
    %4 = llvm.intr.umin(%3, %1)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_umax_1   : umax_1_before  ⊑  umax_1_combined := by
  unfold umax_1_before umax_1_combined
  simp_alive_peephole
  sorry
def umax_1_fail_combined := [llvmfunc|
  llvm.func @umax_1_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.mlir.constant(85 : i8) : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %1  : i8
    %5 = llvm.select %arg1, %3, %4 : i1, i8
    llvm.call @use.i8(%5) : (i8) -> ()
    %6 = llvm.intr.umax(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.xor %6, %0  : i8
    llvm.return %7 : i8
  }]

theorem inst_combine_umax_1_fail   : umax_1_fail_before  ⊑  umax_1_fail_combined := by
  unfold umax_1_fail_before umax_1_fail_combined
  simp_alive_peephole
  sorry
def sub_both_freely_invertable_always_combined := [llvmfunc|
  llvm.func @sub_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.sub %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_sub_both_freely_invertable_always   : sub_both_freely_invertable_always_before  ⊑  sub_both_freely_invertable_always_combined := by
  unfold sub_both_freely_invertable_always_before sub_both_freely_invertable_always_combined
  simp_alive_peephole
  sorry
def add_both_freely_invertable_always_combined := [llvmfunc|
  llvm.func @add_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.add %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_add_both_freely_invertable_always   : add_both_freely_invertable_always_before  ⊑  add_both_freely_invertable_always_combined := by
  unfold add_both_freely_invertable_always_before add_both_freely_invertable_always_combined
  simp_alive_peephole
  sorry
def xor_both_freely_invertable_always_combined := [llvmfunc|
  llvm.func @xor_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.xor %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_xor_both_freely_invertable_always   : xor_both_freely_invertable_always_before  ⊑  xor_both_freely_invertable_always_combined := by
  unfold xor_both_freely_invertable_always_before xor_both_freely_invertable_always_combined
  simp_alive_peephole
  sorry
def ashr_both_freely_invertable_always_combined := [llvmfunc|
  llvm.func @ashr_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_ashr_both_freely_invertable_always   : ashr_both_freely_invertable_always_before  ⊑  ashr_both_freely_invertable_always_combined := by
  unfold ashr_both_freely_invertable_always_before ashr_both_freely_invertable_always_combined
  simp_alive_peephole
  sorry
def select_both_freely_invertable_always_combined := [llvmfunc|
  llvm.func @select_both_freely_invertable_always(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %1  : i8
    %4 = llvm.select %arg0, %2, %3 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_select_both_freely_invertable_always   : select_both_freely_invertable_always_before  ⊑  select_both_freely_invertable_always_combined := by
  unfold select_both_freely_invertable_always_before select_both_freely_invertable_always_combined
  simp_alive_peephole
  sorry
def umin_both_freely_invertable_always_combined := [llvmfunc|
  llvm.func @umin_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.intr.umin(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_umin_both_freely_invertable_always   : umin_both_freely_invertable_always_before  ⊑  umin_both_freely_invertable_always_combined := by
  unfold umin_both_freely_invertable_always_before umin_both_freely_invertable_always_combined
  simp_alive_peephole
  sorry
def umax_both_freely_invertable_always_combined := [llvmfunc|
  llvm.func @umax_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.intr.umax(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_umax_both_freely_invertable_always   : umax_both_freely_invertable_always_before  ⊑  umax_both_freely_invertable_always_combined := by
  unfold umax_both_freely_invertable_always_before umax_both_freely_invertable_always_combined
  simp_alive_peephole
  sorry
def smin_both_freely_invertable_always_combined := [llvmfunc|
  llvm.func @smin_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.intr.smin(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_smin_both_freely_invertable_always   : smin_both_freely_invertable_always_before  ⊑  smin_both_freely_invertable_always_combined := by
  unfold smin_both_freely_invertable_always_before smin_both_freely_invertable_always_combined
  simp_alive_peephole
  sorry
def smax_both_freely_invertable_always_combined := [llvmfunc|
  llvm.func @smax_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.intr.smax(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_smax_both_freely_invertable_always   : smax_both_freely_invertable_always_before  ⊑  smax_both_freely_invertable_always_combined := by
  unfold smax_both_freely_invertable_always_before smax_both_freely_invertable_always_combined
  simp_alive_peephole
  sorry
def lshr_nneg_combined := [llvmfunc|
  llvm.func @lshr_nneg(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.ashr %arg0, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_lshr_nneg   : lshr_nneg_before  ⊑  lshr_nneg_combined := by
  unfold lshr_nneg_before lshr_nneg_combined
  simp_alive_peephole
  sorry
def lshr_not_nneg_combined := [llvmfunc|
  llvm.func @lshr_not_nneg(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.lshr %1, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_lshr_not_nneg   : lshr_not_nneg_before  ⊑  lshr_not_nneg_combined := by
  unfold lshr_not_nneg_before lshr_not_nneg_combined
  simp_alive_peephole
  sorry
def lshr_not_nneg2_combined := [llvmfunc|
  llvm.func @lshr_not_nneg2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_lshr_not_nneg2   : lshr_not_nneg2_before  ⊑  lshr_not_nneg2_combined := by
  unfold lshr_not_nneg2_before lshr_not_nneg2_combined
  simp_alive_peephole
  sorry
def test_inv_free_combined := [llvmfunc|
  llvm.func @test_inv_free(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i1), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i1)
  ^bb3:  // pred: ^bb1
    %2 = llvm.xor %arg2, %1  : i1
    llvm.br ^bb4(%2 : i1)
  ^bb4(%3: i1):  // 3 preds: ^bb1, ^bb2, ^bb3
    %4 = llvm.xor %arg3, %1  : i1
    %5 = llvm.or %3, %4  : i1
    llvm.cond_br %5, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    llvm.return %1 : i1
  ^bb6:  // pred: ^bb4
    llvm.return %0 : i1
  }]

theorem inst_combine_test_inv_free   : test_inv_free_before  ⊑  test_inv_free_combined := by
  unfold test_inv_free_before test_inv_free_combined
  simp_alive_peephole
  sorry
def test_inv_free_i32_combined := [llvmfunc|
  llvm.func @test_inv_free_i32(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i32), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb3:  // pred: ^bb1
    %2 = llvm.xor %arg2, %1  : i32
    llvm.br ^bb4(%2 : i32)
  ^bb4(%3: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %4 = llvm.xor %3, %arg3  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test_inv_free_i32   : test_inv_free_i32_before  ⊑  test_inv_free_i32_combined := by
  unfold test_inv_free_i32_before test_inv_free_i32_combined
  simp_alive_peephole
  sorry
def test_inv_free_multiuse_combined := [llvmfunc|
  llvm.func @test_inv_free_multiuse(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i1), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i1)
  ^bb3:  // pred: ^bb1
    %2 = llvm.xor %arg2, %1  : i1
    llvm.br ^bb4(%2 : i1)
  ^bb4(%3: i1):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.call @use.i1(%3) : (i1) -> ()
    %4 = llvm.xor %arg3, %1  : i1
    %5 = llvm.or %3, %4  : i1
    llvm.cond_br %5, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    llvm.return %1 : i1
  ^bb6:  // pred: ^bb4
    llvm.return %0 : i1
  }]

theorem inst_combine_test_inv_free_multiuse   : test_inv_free_multiuse_before  ⊑  test_inv_free_multiuse_combined := by
  unfold test_inv_free_multiuse_before test_inv_free_multiuse_combined
  simp_alive_peephole
  sorry
def test_inv_free_i32_newinst_combined := [llvmfunc|
  llvm.func @test_inv_free_i32_newinst(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-8 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i32), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb3:  // pred: ^bb1
    %3 = llvm.ashr %2, %arg2  : i32
    llvm.br ^bb4(%3 : i32)
  ^bb4(%4: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %5 = llvm.xor %4, %arg3  : i32
    %6 = llvm.xor %5, %1  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test_inv_free_i32_newinst   : test_inv_free_i32_newinst_before  ⊑  test_inv_free_i32_newinst_combined := by
  unfold test_inv_free_i32_newinst_before test_inv_free_i32_newinst_combined
  simp_alive_peephole
  sorry
def test_inv_free_loop_combined := [llvmfunc|
  llvm.func @test_inv_free_loop(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i1), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i1)
  ^bb3:  // pred: ^bb1
    %2 = llvm.xor %arg2, %1  : i1
    llvm.br ^bb4(%2 : i1)
  ^bb4(%3: i1):  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    %4 = llvm.xor %arg3, %1  : i1
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.xor %3, %1  : i1
    llvm.cond_br %5, ^bb4(%6 : i1), ^bb5
  ^bb5:  // pred: ^bb4
    llvm.return %1 : i1
  }]

theorem inst_combine_test_inv_free_loop   : test_inv_free_loop_before  ⊑  test_inv_free_loop_combined := by
  unfold test_inv_free_loop_before test_inv_free_loop_combined
  simp_alive_peephole
  sorry
