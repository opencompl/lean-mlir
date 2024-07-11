import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  nested-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def andcond_before := [llvmfunc|
  llvm.func @andcond(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %3 = llvm.select %1, %arg4, %2 : i1, i8
    llvm.return %3 : i8
  }]

def orcond_before := [llvmfunc|
  llvm.func @orcond(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %3 = llvm.select %1, %2, %arg4 : i1, i8
    llvm.return %3 : i8
  }]

def andcond.extrause0_before := [llvmfunc|
  llvm.func @andcond.extrause0(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %3 = llvm.select %1, %arg4, %2 : i1, i8
    llvm.return %3 : i8
  }]

def orcond.extrause0_before := [llvmfunc|
  llvm.func @orcond.extrause0(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %3 = llvm.select %1, %2, %arg4 : i1, i8
    llvm.return %3 : i8
  }]

def andcond.extrause1_before := [llvmfunc|
  llvm.func @andcond.extrause1(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.select %1, %arg4, %2 : i1, i8
    llvm.return %3 : i8
  }]

def orcond.extrause1_before := [llvmfunc|
  llvm.func @orcond.extrause1(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.select %1, %2, %arg4 : i1, i8
    llvm.return %3 : i8
  }]

def andcond.extrause2_before := [llvmfunc|
  llvm.func @andcond.extrause2(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.select %1, %arg4, %2 : i1, i8
    llvm.return %3 : i8
  }]

def orcond.extrause2_before := [llvmfunc|
  llvm.func @orcond.extrause2(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.select %1, %2, %arg4 : i1, i8
    llvm.return %3 : i8
  }]

def andcond.different.inner.cond_before := [llvmfunc|
  llvm.func @andcond.different.inner.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg2, %0 : i1, i1
    %2 = llvm.select %arg1, %arg3, %arg4 : i1, i8
    %3 = llvm.select %1, %arg5, %2 : i1, i8
    llvm.return %3 : i8
  }]

def orcond.different.inner.cond_before := [llvmfunc|
  llvm.func @orcond.different.inner.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg2 : i1, i1
    %2 = llvm.select %arg1, %arg3, %arg4 : i1, i8
    %3 = llvm.select %1, %2, %arg5 : i1, i8
    llvm.return %3 : i8
  }]

def andcond.different.inner.cond.both.inverted_before := [llvmfunc|
  llvm.func @andcond.different.inner.cond.both.inverted(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg2, %1 : i1, i1
    %4 = llvm.xor %arg1, %0  : i1
    %5 = llvm.select %4, %arg4, %1 : i1, i1
    %6 = llvm.select %3, %arg5, %5 : i1, i1
    llvm.return %6 : i1
  }]

def orcond.different.inner.cond.both.inverted_before := [llvmfunc|
  llvm.func @orcond.different.inner.cond.both.inverted(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg2 : i1, i1
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %3, %0, %arg3 : i1, i1
    %5 = llvm.select %2, %4, %arg5 : i1, i1
    llvm.return %5 : i1
  }]

def andcond.different.inner.cond.inverted.in.outer.cond_before := [llvmfunc|
  llvm.func @andcond.different.inner.cond.inverted.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg2, %1 : i1, i1
    %4 = llvm.select %arg1, %arg4, %1 : i1, i1
    %5 = llvm.select %3, %arg5, %4 : i1, i1
    llvm.return %5 : i1
  }]

def orcond.different.inner.cond.inverted.in.outer.cond_before := [llvmfunc|
  llvm.func @orcond.different.inner.cond.inverted.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg2 : i1, i1
    %3 = llvm.select %arg1, %0, %arg3 : i1, i1
    %4 = llvm.select %2, %3, %arg5 : i1, i1
    llvm.return %4 : i1
  }]

def andcond.different.inner.cond.inverted.in.inner.sel_before := [llvmfunc|
  llvm.func @andcond.different.inner.cond.inverted.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg2, %0 : i1, i1
    %3 = llvm.xor %arg1, %1  : i1
    %4 = llvm.select %3, %arg4, %0 : i1, i1
    %5 = llvm.select %2, %arg5, %4 : i1, i1
    llvm.return %5 : i1
  }]

def orcond.different.inner.cond.inverted.in.inner.sel_before := [llvmfunc|
  llvm.func @orcond.different.inner.cond.inverted.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg2 : i1, i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %2, %0, %arg3 : i1, i1
    %4 = llvm.select %1, %3, %arg5 : i1, i1
    llvm.return %4 : i1
  }]

def D139275_c4001580_before := [llvmfunc|
  llvm.func @D139275_c4001580(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.xor %arg0, %arg1  : i1
    %1 = llvm.and %arg2, %arg1  : i1
    %2 = llvm.select %0, %arg3, %arg4 : i1, i8
    %3 = llvm.select %1, %arg5, %2 : i1, i8
    llvm.return %3 : i8
  }]

def andcond.001.inv.outer.cond_before := [llvmfunc|
  llvm.func @andcond.001.inv.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %arg2, %arg3 : i1, i1
    %4 = llvm.xor %2, %1  : i1
    %5 = llvm.select %4, %3, %0 : i1, i1
    llvm.return %5 : i1
  }]

def orcond.001.inv.outer.cond_before := [llvmfunc|
  llvm.func @orcond.001.inv.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i1
    %3 = llvm.xor %1, %0  : i1
    %4 = llvm.select %3, %0, %2 : i1, i1
    llvm.return %4 : i1
  }]

def andcond.010.inv.inner.cond.in.inner.sel_before := [llvmfunc|
  llvm.func @andcond.010.inv.inner.cond.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.xor %arg0, %1  : i1
    %4 = llvm.select %3, %arg3, %0 : i1, i1
    %5 = llvm.select %2, %arg4, %4 : i1, i1
    llvm.return %5 : i1
  }]

def orcond.010.inv.inner.cond.in.inner.sel_before := [llvmfunc|
  llvm.func @orcond.010.inv.inner.cond.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %0, %arg2 : i1, i1
    %4 = llvm.select %1, %3, %arg4 : i1, i1
    llvm.return %4 : i1
  }]

def andcond.100.inv.inner.cond.in.outer.cond_before := [llvmfunc|
  llvm.func @andcond.100.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    %4 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %5 = llvm.select %3, %arg4, %4 : i1, i8
    llvm.return %5 : i8
  }]

def orcond.100.inv.inner.cond.in.outer.cond_before := [llvmfunc|
  llvm.func @orcond.100.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    %4 = llvm.select %2, %3, %arg4 : i1, i8
    llvm.return %4 : i8
  }]

def andcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel_before := [llvmfunc|
  llvm.func @andcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.xor %arg0, %1  : i1
    %4 = llvm.select %3, %1, %arg3 : i1, i1
    %5 = llvm.xor %2, %1  : i1
    llvm.call @use.i1(%4) : (i1) -> ()
    %6 = llvm.select %5, %4, %0 : i1, i1
    llvm.return %6 : i1
  }]

def orcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel_before := [llvmfunc|
  llvm.func @orcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %arg2, %1 : i1, i1
    llvm.call @use.i1(%4) : (i1) -> ()
    %5 = llvm.xor %2, %0  : i1
    %6 = llvm.select %5, %0, %4 : i1, i1
    llvm.return %6 : i1
  }]

def andcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond_before := [llvmfunc|
  llvm.func @andcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    %4 = llvm.select %arg0, %arg2, %arg3 : i1, i1
    llvm.call @use.i1(%4) : (i1) -> ()
    %5 = llvm.xor %3, %0  : i1
    %6 = llvm.select %5, %4, %1 : i1, i1
    llvm.return %6 : i1
  }]

def orcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond_before := [llvmfunc|
  llvm.func @orcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %arg2, %arg3 : i1, i1
    llvm.call @use.i1(%3) : (i1) -> ()
    %4 = llvm.xor %2, %0  : i1
    %5 = llvm.select %4, %0, %3 : i1, i1
    llvm.return %5 : i1
  }]

def andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_before := [llvmfunc|
  llvm.func @andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    %4 = llvm.xor %arg0, %0  : i1
    %5 = llvm.select %4, %arg3, %1 : i1, i1
    %6 = llvm.select %3, %arg4, %5 : i1, i1
    llvm.return %6 : i1
  }]

def orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_before := [llvmfunc|
  llvm.func @orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %0, %arg2 : i1, i1
    %5 = llvm.select %2, %4, %arg4 : i1, i1
    llvm.return %5 : i1
  }]

def andcond.111.inv.all.conds_before := [llvmfunc|
  llvm.func @andcond.111.inv.all.conds(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.call @use.i1(%3) : (i1) -> ()
    %4 = llvm.xor %arg0, %0  : i1
    %5 = llvm.select %4, %arg3, %1 : i1, i1
    llvm.call @use.i1(%5) : (i1) -> ()
    %6 = llvm.xor %3, %0  : i1
    %7 = llvm.select %6, %5, %1 : i1, i1
    llvm.return %7 : i1
  }]

def orcond.111.inv.all.conds_before := [llvmfunc|
  llvm.func @orcond.111.inv.all.conds(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg1 : i1, i1
    llvm.call @use.i1(%2) : (i1) -> ()
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %0, %arg2 : i1, i1
    llvm.call @use.i1(%4) : (i1) -> ()
    %5 = llvm.xor %2, %0  : i1
    %6 = llvm.select %5, %0, %4 : i1, i1
    llvm.return %6 : i1
  }]

def test_implied_true_before := [llvmfunc|
  llvm.func @test_implied_true(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "slt" %arg0, %0 : i8
    %5 = llvm.icmp "slt" %arg0, %1 : i8
    %6 = llvm.select %4, %1, %2 : i1, i8
    %7 = llvm.select %5, %6, %3 : i1, i8
    llvm.return %7 : i8
  }]

def test_implied_true_vec_before := [llvmfunc|
  llvm.func @test_implied_true_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %5 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    %6 = llvm.icmp "slt" %arg0, %2 : vector<2xi8>
    %7 = llvm.select %5, %2, %3 : vector<2xi1>, vector<2xi8>
    %8 = llvm.select %6, %7, %4 : vector<2xi1>, vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

def test_implied_true_falseval_before := [llvmfunc|
  llvm.func @test_implied_true_falseval(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "slt" %arg0, %0 : i8
    %5 = llvm.icmp "sgt" %arg0, %1 : i8
    %6 = llvm.select %4, %1, %2 : i1, i8
    %7 = llvm.select %5, %3, %6 : i1, i8
    llvm.return %7 : i8
  }]

def test_implied_false_before := [llvmfunc|
  llvm.func @test_implied_false(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "sgt" %arg0, %0 : i8
    %5 = llvm.icmp "slt" %arg0, %1 : i8
    %6 = llvm.select %4, %1, %2 : i1, i8
    %7 = llvm.select %5, %6, %3 : i1, i8
    llvm.return %7 : i8
  }]

def test_imply_fail_before := [llvmfunc|
  llvm.func @test_imply_fail(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "slt" %arg0, %0 : i8
    %5 = llvm.icmp "slt" %arg0, %1 : i8
    %6 = llvm.select %4, %1, %2 : i1, i8
    %7 = llvm.select %5, %6, %3 : i1, i8
    llvm.return %7 : i8
  }]

def test_imply_type_mismatch_before := [llvmfunc|
  llvm.func @test_imply_type_mismatch(%arg0: vector<2xi8>, %arg1: i8) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %5 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    %6 = llvm.icmp "slt" %arg1, %1 : i8
    %7 = llvm.select %5, %2, %3 : vector<2xi1>, vector<2xi8>
    %8 = llvm.select %6, %7, %4 : i1, vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

def test_dont_crash_before := [llvmfunc|
  llvm.func @test_dont_crash(%arg0: i1, %arg1: vector<4xi1>, %arg2: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.select %arg0, %arg1, %1 : i1, vector<4xi1>
    %3 = llvm.and %2, %arg2  : vector<4xi1>
    llvm.return %3 : vector<4xi1>
  }]

def andcond_combined := [llvmfunc|
  llvm.func @andcond(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.select %arg1, %arg4, %arg2 : i1, i8
    %1 = llvm.select %arg0, %0, %arg3 : i1, i8
    llvm.return %1 : i8
  }]

theorem inst_combine_andcond   : andcond_before  ⊑  andcond_combined := by
  unfold andcond_before andcond_combined
  simp_alive_peephole
  sorry
def orcond_combined := [llvmfunc|
  llvm.func @orcond(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.select %arg1, %arg3, %arg4 : i1, i8
    %1 = llvm.select %arg0, %arg2, %0 : i1, i8
    llvm.return %1 : i8
  }]

theorem inst_combine_orcond   : orcond_before  ⊑  orcond_combined := by
  unfold orcond_before orcond_combined
  simp_alive_peephole
  sorry
def andcond.extrause0_combined := [llvmfunc|
  llvm.func @andcond.extrause0(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %arg1, %arg4, %arg2 : i1, i8
    %3 = llvm.select %arg0, %2, %arg3 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_andcond.extrause0   : andcond.extrause0_before  ⊑  andcond.extrause0_combined := by
  unfold andcond.extrause0_before andcond.extrause0_combined
  simp_alive_peephole
  sorry
def orcond.extrause0_combined := [llvmfunc|
  llvm.func @orcond.extrause0(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %arg1, %arg3, %arg4 : i1, i8
    %3 = llvm.select %arg0, %arg2, %2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_orcond.extrause0   : orcond.extrause0_before  ⊑  orcond.extrause0_combined := by
  unfold orcond.extrause0_before orcond.extrause0_combined
  simp_alive_peephole
  sorry
def andcond.extrause1_combined := [llvmfunc|
  llvm.func @andcond.extrause1(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.select %arg1, %arg4, %arg2 : i1, i8
    %2 = llvm.select %arg0, %1, %arg3 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_andcond.extrause1   : andcond.extrause1_before  ⊑  andcond.extrause1_combined := by
  unfold andcond.extrause1_before andcond.extrause1_combined
  simp_alive_peephole
  sorry
def orcond.extrause1_combined := [llvmfunc|
  llvm.func @orcond.extrause1(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.select %arg1, %arg3, %arg4 : i1, i8
    %2 = llvm.select %arg0, %arg2, %1 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_orcond.extrause1   : orcond.extrause1_before  ⊑  orcond.extrause1_combined := by
  unfold orcond.extrause1_before orcond.extrause1_combined
  simp_alive_peephole
  sorry
def andcond.extrause2_combined := [llvmfunc|
  llvm.func @andcond.extrause2(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.select %1, %arg4, %2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_andcond.extrause2   : andcond.extrause2_before  ⊑  andcond.extrause2_combined := by
  unfold andcond.extrause2_before andcond.extrause2_combined
  simp_alive_peephole
  sorry
def orcond.extrause2_combined := [llvmfunc|
  llvm.func @orcond.extrause2(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg1 : i1, i1
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.select %1, %2, %arg4 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_orcond.extrause2   : orcond.extrause2_before  ⊑  orcond.extrause2_combined := by
  unfold orcond.extrause2_before orcond.extrause2_combined
  simp_alive_peephole
  sorry
def andcond.different.inner.cond_combined := [llvmfunc|
  llvm.func @andcond.different.inner.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg2, %0 : i1, i1
    %2 = llvm.select %arg1, %arg3, %arg4 : i1, i8
    %3 = llvm.select %1, %arg5, %2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_andcond.different.inner.cond   : andcond.different.inner.cond_before  ⊑  andcond.different.inner.cond_combined := by
  unfold andcond.different.inner.cond_before andcond.different.inner.cond_combined
  simp_alive_peephole
  sorry
def orcond.different.inner.cond_combined := [llvmfunc|
  llvm.func @orcond.different.inner.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg2 : i1, i1
    %2 = llvm.select %arg1, %arg3, %arg4 : i1, i8
    %3 = llvm.select %1, %2, %arg5 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_orcond.different.inner.cond   : orcond.different.inner.cond_before  ⊑  orcond.different.inner.cond_combined := by
  unfold orcond.different.inner.cond_before orcond.different.inner.cond_combined
  simp_alive_peephole
  sorry
def andcond.different.inner.cond.both.inverted_combined := [llvmfunc|
  llvm.func @andcond.different.inner.cond.both.inverted(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg2, %1 : i1, i1
    %4 = llvm.xor %arg1, %0  : i1
    %5 = llvm.select %4, %arg4, %1 : i1, i1
    %6 = llvm.select %3, %arg5, %5 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_andcond.different.inner.cond.both.inverted   : andcond.different.inner.cond.both.inverted_before  ⊑  andcond.different.inner.cond.both.inverted_combined := by
  unfold andcond.different.inner.cond.both.inverted_before andcond.different.inner.cond.both.inverted_combined
  simp_alive_peephole
  sorry
def orcond.different.inner.cond.both.inverted_combined := [llvmfunc|
  llvm.func @orcond.different.inner.cond.both.inverted(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg2 : i1, i1
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %3, %0, %arg3 : i1, i1
    %5 = llvm.select %2, %4, %arg5 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_orcond.different.inner.cond.both.inverted   : orcond.different.inner.cond.both.inverted_before  ⊑  orcond.different.inner.cond.both.inverted_combined := by
  unfold orcond.different.inner.cond.both.inverted_before orcond.different.inner.cond.both.inverted_combined
  simp_alive_peephole
  sorry
def andcond.different.inner.cond.inverted.in.outer.cond_combined := [llvmfunc|
  llvm.func @andcond.different.inner.cond.inverted.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg2, %1 : i1, i1
    %4 = llvm.select %arg1, %arg4, %1 : i1, i1
    %5 = llvm.select %3, %arg5, %4 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_andcond.different.inner.cond.inverted.in.outer.cond   : andcond.different.inner.cond.inverted.in.outer.cond_before  ⊑  andcond.different.inner.cond.inverted.in.outer.cond_combined := by
  unfold andcond.different.inner.cond.inverted.in.outer.cond_before andcond.different.inner.cond.inverted.in.outer.cond_combined
  simp_alive_peephole
  sorry
def orcond.different.inner.cond.inverted.in.outer.cond_combined := [llvmfunc|
  llvm.func @orcond.different.inner.cond.inverted.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %1, %0, %arg2 : i1, i1
    %3 = llvm.select %arg1, %0, %arg3 : i1, i1
    %4 = llvm.select %2, %3, %arg5 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_orcond.different.inner.cond.inverted.in.outer.cond   : orcond.different.inner.cond.inverted.in.outer.cond_before  ⊑  orcond.different.inner.cond.inverted.in.outer.cond_combined := by
  unfold orcond.different.inner.cond.inverted.in.outer.cond_before orcond.different.inner.cond.inverted.in.outer.cond_combined
  simp_alive_peephole
  sorry
def andcond.different.inner.cond.inverted.in.inner.sel_combined := [llvmfunc|
  llvm.func @andcond.different.inner.cond.inverted.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg2, %0 : i1, i1
    %3 = llvm.xor %arg1, %1  : i1
    %4 = llvm.select %3, %arg4, %0 : i1, i1
    %5 = llvm.select %2, %arg5, %4 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_andcond.different.inner.cond.inverted.in.inner.sel   : andcond.different.inner.cond.inverted.in.inner.sel_before  ⊑  andcond.different.inner.cond.inverted.in.inner.sel_combined := by
  unfold andcond.different.inner.cond.inverted.in.inner.sel_before andcond.different.inner.cond.inverted.in.inner.sel_combined
  simp_alive_peephole
  sorry
def orcond.different.inner.cond.inverted.in.inner.sel_combined := [llvmfunc|
  llvm.func @orcond.different.inner.cond.inverted.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg2 : i1, i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %2, %0, %arg3 : i1, i1
    %4 = llvm.select %1, %3, %arg5 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_orcond.different.inner.cond.inverted.in.inner.sel   : orcond.different.inner.cond.inverted.in.inner.sel_before  ⊑  orcond.different.inner.cond.inverted.in.inner.sel_combined := by
  unfold orcond.different.inner.cond.inverted.in.inner.sel_before orcond.different.inner.cond.inverted.in.inner.sel_combined
  simp_alive_peephole
  sorry
def D139275_c4001580_combined := [llvmfunc|
  llvm.func @D139275_c4001580(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.xor %arg0, %arg1  : i1
    %1 = llvm.and %arg2, %arg1  : i1
    %2 = llvm.select %0, %arg3, %arg4 : i1, i8
    %3 = llvm.select %1, %arg5, %2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_D139275_c4001580   : D139275_c4001580_before  ⊑  D139275_c4001580_combined := by
  unfold D139275_c4001580_before D139275_c4001580_combined
  simp_alive_peephole
  sorry
def andcond.001.inv.outer.cond_combined := [llvmfunc|
  llvm.func @andcond.001.inv.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %2, %arg2, %1 : i1, i1
    %4 = llvm.select %arg0, %3, %arg3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_andcond.001.inv.outer.cond   : andcond.001.inv.outer.cond_before  ⊑  andcond.001.inv.outer.cond_combined := by
  unfold andcond.001.inv.outer.cond_before andcond.001.inv.outer.cond_combined
  simp_alive_peephole
  sorry
def orcond.001.inv.outer.cond_combined := [llvmfunc|
  llvm.func @orcond.001.inv.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.select %1, %0, %arg3 : i1, i1
    %3 = llvm.select %arg0, %arg2, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_orcond.001.inv.outer.cond   : orcond.001.inv.outer.cond_before  ⊑  orcond.001.inv.outer.cond_combined := by
  unfold orcond.001.inv.outer.cond_before orcond.001.inv.outer.cond_combined
  simp_alive_peephole
  sorry
def andcond.010.inv.inner.cond.in.inner.sel_combined := [llvmfunc|
  llvm.func @andcond.010.inv.inner.cond.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg1, %arg4, %0 : i1, i1
    %2 = llvm.select %arg0, %1, %arg3 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_andcond.010.inv.inner.cond.in.inner.sel   : andcond.010.inv.inner.cond.in.inner.sel_before  ⊑  andcond.010.inv.inner.cond.in.inner.sel_combined := by
  unfold andcond.010.inv.inner.cond.in.inner.sel_before andcond.010.inv.inner.cond.in.inner.sel_combined
  simp_alive_peephole
  sorry
def orcond.010.inv.inner.cond.in.inner.sel_combined := [llvmfunc|
  llvm.func @orcond.010.inv.inner.cond.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg4 : i1, i1
    %2 = llvm.select %arg0, %arg2, %1 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_orcond.010.inv.inner.cond.in.inner.sel   : orcond.010.inv.inner.cond.in.inner.sel_before  ⊑  orcond.010.inv.inner.cond.in.inner.sel_combined := by
  unfold orcond.010.inv.inner.cond.in.inner.sel_before orcond.010.inv.inner.cond.in.inner.sel_combined
  simp_alive_peephole
  sorry
def andcond.100.inv.inner.cond.in.outer.cond_combined := [llvmfunc|
  llvm.func @andcond.100.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.select %arg1, %arg4, %arg3 : i1, i8
    %1 = llvm.select %arg0, %arg2, %0 : i1, i8
    llvm.return %1 : i8
  }]

theorem inst_combine_andcond.100.inv.inner.cond.in.outer.cond   : andcond.100.inv.inner.cond.in.outer.cond_before  ⊑  andcond.100.inv.inner.cond.in.outer.cond_combined := by
  unfold andcond.100.inv.inner.cond.in.outer.cond_before andcond.100.inv.inner.cond.in.outer.cond_combined
  simp_alive_peephole
  sorry
def orcond.100.inv.inner.cond.in.outer.cond_combined := [llvmfunc|
  llvm.func @orcond.100.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.select %arg1, %arg2, %arg4 : i1, i8
    %1 = llvm.select %arg0, %0, %arg3 : i1, i8
    llvm.return %1 : i8
  }]

theorem inst_combine_orcond.100.inv.inner.cond.in.outer.cond   : orcond.100.inv.inner.cond.in.outer.cond_before  ⊑  orcond.100.inv.inner.cond.in.outer.cond_combined := by
  unfold orcond.100.inv.inner.cond.in.outer.cond_before orcond.100.inv.inner.cond.in.outer.cond_combined
  simp_alive_peephole
  sorry
def andcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel_combined := [llvmfunc|
  llvm.func @andcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %0, %arg3 : i1, i1
    llvm.call @use.i1(%3) : (i1) -> ()
    %4 = llvm.xor %arg1, %0  : i1
    %5 = llvm.select %4, %arg3, %1 : i1, i1
    %6 = llvm.xor %arg0, %0  : i1
    %7 = llvm.select %6, %0, %5 : i1, i1
    llvm.return %7 : i1
  }]

theorem inst_combine_andcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel   : andcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel_before  ⊑  andcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel_combined := by
  unfold andcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel_before andcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel_combined
  simp_alive_peephole
  sorry
def orcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel_combined := [llvmfunc|
  llvm.func @orcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg2, %1 : i1, i1
    llvm.call @use.i1(%3) : (i1) -> ()
    %4 = llvm.xor %arg1, %0  : i1
    %5 = llvm.select %4, %0, %arg2 : i1, i1
    %6 = llvm.xor %arg0, %0  : i1
    %7 = llvm.select %6, %5, %1 : i1, i1
    llvm.return %7 : i1
  }]

theorem inst_combine_orcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel   : orcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel_before  ⊑  orcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel_combined := by
  unfold orcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel_before orcond.011.inv.outer.cond.inv.inner.cond.in.inner.sel_combined
  simp_alive_peephole
  sorry
def andcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond_combined := [llvmfunc|
  llvm.func @andcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %arg2, %arg3 : i1, i1
    llvm.call @use.i1(%2) : (i1) -> ()
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %3, %arg3, %1 : i1, i1
    %5 = llvm.select %arg0, %arg2, %4 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_andcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond   : andcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond_before  ⊑  andcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond_combined := by
  unfold andcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond_before andcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond_combined
  simp_alive_peephole
  sorry
def orcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond_combined := [llvmfunc|
  llvm.func @orcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %arg2, %arg3 : i1, i1
    llvm.call @use.i1(%1) : (i1) -> ()
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.select %2, %0, %arg2 : i1, i1
    %4 = llvm.select %arg0, %3, %arg3 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_orcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond   : orcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond_before  ⊑  orcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond_combined := by
  unfold orcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond_before orcond.101.inv.outer.cond.inv.inner.cond.in.outer.cond_combined
  simp_alive_peephole
  sorry
def andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_combined := [llvmfunc|
  llvm.func @andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %arg1, %arg4, %arg3 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond   : andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_before  ⊑  andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_combined := by
  unfold andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_before andcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_combined
  simp_alive_peephole
  sorry
def orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_combined := [llvmfunc|
  llvm.func @orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.select %arg1, %arg2, %arg4 : i1, i1
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond   : orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_before  ⊑  orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_combined := by
  unfold orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_before orcond.110.inv.inner.cond.in.inner.sel.inv.inner.cond.in.outer.cond_combined
  simp_alive_peephole
  sorry
def andcond.111.inv.all.conds_combined := [llvmfunc|
  llvm.func @andcond.111.inv.all.conds(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.call @use.i1(%3) : (i1) -> ()
    %4 = llvm.xor %arg0, %0  : i1
    %5 = llvm.select %4, %arg3, %1 : i1, i1
    llvm.call @use.i1(%5) : (i1) -> ()
    %6 = llvm.select %arg0, %0, %arg1 : i1, i1
    %7 = llvm.xor %6, %0  : i1
    %8 = llvm.select %7, %arg3, %1 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_andcond.111.inv.all.conds   : andcond.111.inv.all.conds_before  ⊑  andcond.111.inv.all.conds_combined := by
  unfold andcond.111.inv.all.conds_before andcond.111.inv.all.conds_combined
  simp_alive_peephole
  sorry
def orcond.111.inv.all.conds_combined := [llvmfunc|
  llvm.func @orcond.111.inv.all.conds(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %0, %arg1 : i1, i1
    llvm.call @use.i1(%3) : (i1) -> ()
    %4 = llvm.xor %arg0, %0  : i1
    %5 = llvm.select %4, %0, %arg2 : i1, i1
    llvm.call @use.i1(%5) : (i1) -> ()
    %6 = llvm.select %arg0, %arg1, %1 : i1, i1
    %7 = llvm.xor %6, %0  : i1
    %8 = llvm.select %7, %0, %arg2 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_orcond.111.inv.all.conds   : orcond.111.inv.all.conds_before  ⊑  orcond.111.inv.all.conds_combined := by
  unfold orcond.111.inv.all.conds_before orcond.111.inv.all.conds_combined
  simp_alive_peephole
  sorry
def test_implied_true_combined := [llvmfunc|
  llvm.func @test_implied_true(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "slt" %arg0, %0 : i8
    %5 = llvm.icmp "slt" %arg0, %1 : i8
    %6 = llvm.select %4, %1, %2 : i1, i8
    %7 = llvm.select %5, %6, %3 : i1, i8
    llvm.return %7 : i8
  }]

theorem inst_combine_test_implied_true   : test_implied_true_before  ⊑  test_implied_true_combined := by
  unfold test_implied_true_before test_implied_true_combined
  simp_alive_peephole
  sorry
def test_implied_true_vec_combined := [llvmfunc|
  llvm.func @test_implied_true_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %5 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    %6 = llvm.icmp "slt" %arg0, %2 : vector<2xi8>
    %7 = llvm.select %5, %2, %3 : vector<2xi1>, vector<2xi8>
    %8 = llvm.select %6, %7, %4 : vector<2xi1>, vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

theorem inst_combine_test_implied_true_vec   : test_implied_true_vec_before  ⊑  test_implied_true_vec_combined := by
  unfold test_implied_true_vec_before test_implied_true_vec_combined
  simp_alive_peephole
  sorry
def test_implied_true_falseval_combined := [llvmfunc|
  llvm.func @test_implied_true_falseval(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "slt" %arg0, %0 : i8
    %5 = llvm.icmp "sgt" %arg0, %1 : i8
    %6 = llvm.select %4, %1, %2 : i1, i8
    %7 = llvm.select %5, %3, %6 : i1, i8
    llvm.return %7 : i8
  }]

theorem inst_combine_test_implied_true_falseval   : test_implied_true_falseval_before  ⊑  test_implied_true_falseval_combined := by
  unfold test_implied_true_falseval_before test_implied_true_falseval_combined
  simp_alive_peephole
  sorry
def test_implied_false_combined := [llvmfunc|
  llvm.func @test_implied_false(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "sgt" %arg0, %0 : i8
    %5 = llvm.icmp "slt" %arg0, %1 : i8
    %6 = llvm.select %4, %1, %2 : i1, i8
    %7 = llvm.select %5, %6, %3 : i1, i8
    llvm.return %7 : i8
  }]

theorem inst_combine_test_implied_false   : test_implied_false_before  ⊑  test_implied_false_combined := by
  unfold test_implied_false_before test_implied_false_combined
  simp_alive_peephole
  sorry
def test_imply_fail_combined := [llvmfunc|
  llvm.func @test_imply_fail(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(20 : i8) : i8
    %4 = llvm.icmp "slt" %arg0, %0 : i8
    %5 = llvm.icmp "slt" %arg0, %1 : i8
    %6 = llvm.select %4, %1, %2 : i1, i8
    %7 = llvm.select %5, %6, %3 : i1, i8
    llvm.return %7 : i8
  }]

theorem inst_combine_test_imply_fail   : test_imply_fail_before  ⊑  test_imply_fail_combined := by
  unfold test_imply_fail_before test_imply_fail_combined
  simp_alive_peephole
  sorry
def test_imply_type_mismatch_combined := [llvmfunc|
  llvm.func @test_imply_type_mismatch(%arg0: vector<2xi8>, %arg1: i8) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %5 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    %6 = llvm.icmp "slt" %arg1, %1 : i8
    %7 = llvm.select %5, %2, %3 : vector<2xi1>, vector<2xi8>
    %8 = llvm.select %6, %7, %4 : i1, vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

theorem inst_combine_test_imply_type_mismatch   : test_imply_type_mismatch_before  ⊑  test_imply_type_mismatch_combined := by
  unfold test_imply_type_mismatch_before test_imply_type_mismatch_combined
  simp_alive_peephole
  sorry
def test_dont_crash_combined := [llvmfunc|
  llvm.func @test_dont_crash(%arg0: i1, %arg1: vector<4xi1>, %arg2: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.select %arg0, %arg1, %1 : i1, vector<4xi1>
    %3 = llvm.and %2, %arg2  : vector<4xi1>
    llvm.return %3 : vector<4xi1>
  }]

theorem inst_combine_test_dont_crash   : test_dont_crash_before  ⊑  test_dont_crash_combined := by
  unfold test_dont_crash_before test_dont_crash_combined
  simp_alive_peephole
  sorry
