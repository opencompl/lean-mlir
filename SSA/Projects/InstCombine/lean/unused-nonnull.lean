import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  unused-nonnull
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main(%arg0: i32, %arg1: !llvm.ptr) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %4 = llvm.call @compute(%3, %arg0) : (!llvm.ptr, i32) -> i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.cond_br %5, ^bb3(%1 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %6 = llvm.icmp "eq" %3, %2 : !llvm.ptr
    llvm.cond_br %6, ^bb2, ^bb3(%4 : i32)
  ^bb2:  // pred: ^bb1
    llvm.call @call_if_null(%3) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%4 : i32)
  ^bb3(%7: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return %7 : i32
  }]

def compute_before := [llvmfunc|
  llvm.func @compute(%arg0: !llvm.ptr {llvm.nonnull, llvm.noundef}, %arg1: i32) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["noinline", "nounwind"]} {
    llvm.return %arg1 : i32
  }]

