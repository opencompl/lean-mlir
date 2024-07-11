import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ptr-replace-alloca
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def remove_alloca_use_arg_before := [llvmfunc|
  llvm.func @remove_alloca_use_arg(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 4 : i64} : (i32) -> !llvm.ptr<1>]

    "llvm.intr.memcpy"(%7, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %8 = llvm.getelementptr inbounds %7[%5, %6] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%8 : !llvm.ptr<1>)
  ^bb2:  // pred: ^bb0
    %9 = llvm.getelementptr inbounds %7[%5, %0] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%9 : !llvm.ptr<1>)
  ^bb3(%10: !llvm.ptr<1>):  // 2 preds: ^bb1, ^bb2
    %11 = llvm.load %10 {alignment = 1 : i64} : !llvm.ptr<1> -> i8]

    llvm.return %11 : i8
  }]

def volatile_load_keep_alloca_before := [llvmfunc|
  llvm.func @volatile_load_keep_alloca(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 4 : i64} : (i32) -> !llvm.ptr<1>]

    "llvm.intr.memcpy"(%7, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %8 = llvm.getelementptr inbounds %7[%5, %0] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%8 : !llvm.ptr<1>)
  ^bb2:  // pred: ^bb0
    %9 = llvm.getelementptr inbounds %7[%5, %6] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%9 : !llvm.ptr<1>)
  ^bb3(%10: !llvm.ptr<1>):  // 2 preds: ^bb1, ^bb2
    %11 = llvm.load volatile %10 {alignment = 1 : i64} : !llvm.ptr<1> -> i8]

    llvm.return %11 : i8
  }]

def no_memcpy_keep_alloca_before := [llvmfunc|
  llvm.func @no_memcpy_keep_alloca(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 4 : i64} : (i32) -> !llvm.ptr<1>]

    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%4 : !llvm.ptr<1>)
  ^bb2:  // pred: ^bb0
    %5 = llvm.getelementptr inbounds %3[%1, %2] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%5 : !llvm.ptr<1>)
  ^bb3(%6: !llvm.ptr<1>):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.load volatile %6 {alignment = 1 : i64} : !llvm.ptr<1> -> i8]

    llvm.return %7 : i8
  }]

def loop_phi_remove_alloca_before := [llvmfunc|
  llvm.func @loop_phi_remove_alloca(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 4 : i64} : (i32) -> !llvm.ptr<1>]

    "llvm.intr.memcpy"(%7, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()]

    %8 = llvm.getelementptr inbounds %7[%5, %0] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb1(%8 : !llvm.ptr<1>)
  ^bb1(%9: !llvm.ptr<1>):  // 2 preds: ^bb0, ^bb2
    llvm.cond_br %arg0, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %10 = llvm.getelementptr inbounds %7[%5, %6] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb1(%10 : !llvm.ptr<1>)
  ^bb3:  // pred: ^bb1
    %11 = llvm.load %9 {alignment = 1 : i64} : !llvm.ptr<1> -> i8]

    llvm.return %11 : i8
  }]

def remove_alloca_ptr_arg_before := [llvmfunc|
  llvm.func @remove_alloca_ptr_arg(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%5 : !llvm.ptr)
  ^bb2(%6: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %7 : i32
  }]

def loop_phi_late_memtransfer_remove_alloca_before := [llvmfunc|
  llvm.func @loop_phi_late_memtransfer_remove_alloca(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %5 = llvm.mlir.addressof @g1 : !llvm.ptr
    %6 = llvm.mlir.constant(32 : i64) : i64
    %7 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 4 : i64} : (i32) -> !llvm.ptr<1>]

    %8 = llvm.getelementptr inbounds %7[%1, %0] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb1(%8 : !llvm.ptr<1>)
  ^bb1(%9: !llvm.ptr<1>):  // 2 preds: ^bb0, ^bb2
    llvm.cond_br %arg0, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %10 = llvm.getelementptr inbounds %7[%1, %2] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    "llvm.intr.memcpy"(%7, %5, %6) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()]

    llvm.br ^bb1(%10 : !llvm.ptr<1>)
  ^bb3:  // pred: ^bb1
    %11 = llvm.load %9 {alignment = 1 : i64} : !llvm.ptr<1> -> i8]

    llvm.return %11 : i8
  }]

def test_memcpy_after_phi_before := [llvmfunc|
  llvm.func @test_memcpy_after_phi(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%5 : !llvm.ptr)
  ^bb2(%6: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %7 : i32
  }]

def addrspace_diff_keep_alloca_before := [llvmfunc|
  llvm.func @addrspace_diff_keep_alloca(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()]

    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%5 : !llvm.ptr)
  ^bb2(%6: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %7 : i32
  }]

def addrspace_diff_keep_alloca_extra_gep_before := [llvmfunc|
  llvm.func @addrspace_diff_keep_alloca_extra_gep(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()]

    %7 = llvm.getelementptr %6[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%7 : !llvm.ptr)
  ^bb2(%8: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %9 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %9 : i32
  }]

def addrspace_diff_remove_alloca_before := [llvmfunc|
  llvm.func @addrspace_diff_remove_alloca(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%7, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()]

    %8 = llvm.getelementptr inbounds %7[%5, %6] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<32 x i8>
    llvm.cond_br %arg0, ^bb1, ^bb2(%8 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%7 : !llvm.ptr)
  ^bb2(%9: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %10 = llvm.load %9 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %10 : i32
  }]

def phi_loop_before := [llvmfunc|
  llvm.func @phi_loop(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.br ^bb1(%6 : !llvm.ptr)
  ^bb1(%7: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.getelementptr %7[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.cond_br %arg0, ^bb2, ^bb1(%8 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %9 : i32
  }]

def phi_loop_different_addrspace_before := [llvmfunc|
  llvm.func @phi_loop_different_addrspace(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()]

    llvm.br ^bb1(%6 : !llvm.ptr)
  ^bb1(%7: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.getelementptr %7[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.cond_br %arg0, ^bb2, ^bb1(%8 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %9 : i32
  }]

def select_same_addrspace_remove_alloca_before := [llvmfunc|
  llvm.func @select_same_addrspace_remove_alloca(%arg0: i1, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    %6 = llvm.select %arg0, %5, %arg1 : i1, !llvm.ptr
    %7 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %7 : i8
  }]

def select_after_memcpy_keep_alloca_before := [llvmfunc|
  llvm.func @select_after_memcpy_keep_alloca(%arg0: i1, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.select %arg0, %5, %arg1 : i1, !llvm.ptr
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    %7 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %7 : i8
  }]

def select_diff_addrspace_keep_alloca_before := [llvmfunc|
  llvm.func @select_diff_addrspace_keep_alloca(%arg0: i1, %arg1: !llvm.ptr<1>) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr<1>]

    "llvm.intr.memcpy"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()]

    %6 = llvm.select %arg0, %5, %arg1 : i1, !llvm.ptr<1>
    %7 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr<1> -> i8]

    llvm.return %7 : i8
  }]

def select_diff_addrspace_remove_alloca_before := [llvmfunc|
  llvm.func @select_diff_addrspace_remove_alloca(%arg0: i1, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.constant(4 : i64) : i64
    %8 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%8, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()]

    %9 = llvm.getelementptr inbounds %8[%5, %6] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<32 x i8>
    %10 = llvm.select %arg0, %8, %9 : i1, !llvm.ptr
    %11 = llvm.getelementptr inbounds %10[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %12 = llvm.load %11 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %12 : i8
  }]

def call_readonly_remove_alloca_before := [llvmfunc|
  llvm.func @call_readonly_remove_alloca() -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr<1>]

    "llvm.intr.memcpy"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()]

    %6 = llvm.addrspacecast %5 : !llvm.ptr<1> to !llvm.ptr
    %7 = llvm.call @readonly_callee(%6) : (!llvm.ptr) -> i8
    llvm.return %7 : i8
  }]

def call_readonly_keep_alloca2_before := [llvmfunc|
  llvm.func @call_readonly_keep_alloca2() -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(16 : i64) : i64
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(16 : i32) : i32
    %7 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %8 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr<1>]

    "llvm.intr.memcpy"(%8, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()]

    %9 = llvm.getelementptr inbounds %8[%5, %6] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    "llvm.intr.memcpy"(%9, %7, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr<1>, i64) -> ()]

    %10 = llvm.addrspacecast %8 : !llvm.ptr<1> to !llvm.ptr
    %11 = llvm.call @readonly_callee(%10) : (!llvm.ptr) -> i8
    llvm.return %11 : i8
  }]

def remove_alloca_use_arg_combined := [llvmfunc|
  llvm.func @remove_alloca_use_arg(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %4 = llvm.mlir.addressof @g1 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<32 x i8>
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.getelementptr inbounds %4[%1, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<32 x i8>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%7 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%5 : !llvm.ptr)
  ^bb3(%8: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %9 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %9 : i8
  }]

theorem inst_combine_remove_alloca_use_arg   : remove_alloca_use_arg_before  ⊑  remove_alloca_use_arg_combined := by
  unfold remove_alloca_use_arg_before remove_alloca_use_arg_combined
  simp_alive_peephole
  sorry
def volatile_load_keep_alloca_combined := [llvmfunc|
  llvm.func @volatile_load_keep_alloca(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(1 : i64) : i64
    %8 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 4 : i64} : (i32) -> !llvm.ptr<1>
    "llvm.intr.memcpy"(%8, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %9 = llvm.getelementptr inbounds %8[%5, %7] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%9 : !llvm.ptr<1>)
  ^bb2:  // pred: ^bb0
    %10 = llvm.getelementptr inbounds %8[%5, %6] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%10 : !llvm.ptr<1>)
  ^bb3(%11: !llvm.ptr<1>):  // 2 preds: ^bb1, ^bb2
    %12 = llvm.load volatile %11 {alignment = 1 : i64} : !llvm.ptr<1> -> i8
    llvm.return %12 : i8
  }]

theorem inst_combine_volatile_load_keep_alloca   : volatile_load_keep_alloca_before  ⊑  volatile_load_keep_alloca_combined := by
  unfold volatile_load_keep_alloca_before volatile_load_keep_alloca_combined
  simp_alive_peephole
  sorry
def no_memcpy_keep_alloca_combined := [llvmfunc|
  llvm.func @no_memcpy_keep_alloca(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 4 : i64} : (i32) -> !llvm.ptr<1>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.getelementptr inbounds %4[%1, %3] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%5 : !llvm.ptr<1>)
  ^bb2:  // pred: ^bb0
    %6 = llvm.getelementptr inbounds %4[%1, %2] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.br ^bb3(%6 : !llvm.ptr<1>)
  ^bb3(%7: !llvm.ptr<1>):  // 2 preds: ^bb1, ^bb2
    %8 = llvm.load volatile %7 {alignment = 1 : i64} : !llvm.ptr<1> -> i8
    llvm.return %8 : i8
  }]

theorem inst_combine_no_memcpy_keep_alloca   : no_memcpy_keep_alloca_before  ⊑  no_memcpy_keep_alloca_combined := by
  unfold no_memcpy_keep_alloca_before no_memcpy_keep_alloca_combined
  simp_alive_peephole
  sorry
def loop_phi_remove_alloca_combined := [llvmfunc|
  llvm.func @loop_phi_remove_alloca(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %4 = llvm.mlir.addressof @g1 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<32 x i8>
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.getelementptr inbounds %4[%1, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<32 x i8>
    llvm.br ^bb1(%5 : !llvm.ptr)
  ^bb1(%8: !llvm.ptr):  // 2 preds: ^bb0, ^bb2
    llvm.cond_br %arg0, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb1(%7 : !llvm.ptr)
  ^bb3:  // pred: ^bb1
    %9 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %9 : i8
  }]

theorem inst_combine_loop_phi_remove_alloca   : loop_phi_remove_alloca_before  ⊑  loop_phi_remove_alloca_combined := by
  unfold loop_phi_remove_alloca_before loop_phi_remove_alloca_combined
  simp_alive_peephole
  sorry
def remove_alloca_ptr_arg_combined := [llvmfunc|
  llvm.func @remove_alloca_ptr_arg(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @g1 : !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%2 : !llvm.ptr)
  ^bb2(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_remove_alloca_ptr_arg   : remove_alloca_ptr_arg_before  ⊑  remove_alloca_ptr_arg_combined := by
  unfold remove_alloca_ptr_arg_before remove_alloca_ptr_arg_combined
  simp_alive_peephole
  sorry
def loop_phi_late_memtransfer_remove_alloca_combined := [llvmfunc|
  llvm.func @loop_phi_late_memtransfer_remove_alloca(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %4 = llvm.mlir.addressof @g1 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<32 x i8>
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.getelementptr inbounds %4[%1, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<32 x i8>
    llvm.br ^bb1(%5 : !llvm.ptr)
  ^bb1(%8: !llvm.ptr):  // 2 preds: ^bb0, ^bb2
    llvm.cond_br %arg0, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb1(%7 : !llvm.ptr)
  ^bb3:  // pred: ^bb1
    %9 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %9 : i8
  }]

theorem inst_combine_loop_phi_late_memtransfer_remove_alloca   : loop_phi_late_memtransfer_remove_alloca_before  ⊑  loop_phi_late_memtransfer_remove_alloca_combined := by
  unfold loop_phi_late_memtransfer_remove_alloca_before loop_phi_late_memtransfer_remove_alloca_combined
  simp_alive_peephole
  sorry
def test_memcpy_after_phi_combined := [llvmfunc|
  llvm.func @test_memcpy_after_phi(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%5 : !llvm.ptr)
  ^bb2(%6: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %7 : i32
  }]

theorem inst_combine_test_memcpy_after_phi   : test_memcpy_after_phi_before  ⊑  test_memcpy_after_phi_combined := by
  unfold test_memcpy_after_phi_before test_memcpy_after_phi_combined
  simp_alive_peephole
  sorry
def addrspace_diff_keep_alloca_combined := [llvmfunc|
  llvm.func @addrspace_diff_keep_alloca(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%5 : !llvm.ptr)
  ^bb2(%6: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %7 : i32
  }]

theorem inst_combine_addrspace_diff_keep_alloca   : addrspace_diff_keep_alloca_before  ⊑  addrspace_diff_keep_alloca_combined := by
  unfold addrspace_diff_keep_alloca_before addrspace_diff_keep_alloca_combined
  simp_alive_peephole
  sorry
def addrspace_diff_keep_alloca_extra_gep_combined := [llvmfunc|
  llvm.func @addrspace_diff_keep_alloca_extra_gep(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    %7 = llvm.getelementptr inbounds %6[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.br ^bb2(%7 : !llvm.ptr)
  ^bb2(%8: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %9 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %9 : i32
  }]

theorem inst_combine_addrspace_diff_keep_alloca_extra_gep   : addrspace_diff_keep_alloca_extra_gep_before  ⊑  addrspace_diff_keep_alloca_extra_gep_combined := by
  unfold addrspace_diff_keep_alloca_extra_gep_before addrspace_diff_keep_alloca_extra_gep_combined
  simp_alive_peephole
  sorry
def addrspace_diff_remove_alloca_combined := [llvmfunc|
  llvm.func @addrspace_diff_remove_alloca(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %4 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %5 = llvm.getelementptr inbounds %4[%1, %0] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    llvm.cond_br %arg0, ^bb1, ^bb2(%5 : !llvm.ptr<1>)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%4 : !llvm.ptr<1>)
  ^bb2(%6: !llvm.ptr<1>):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    llvm.return %7 : i32
  }]

theorem inst_combine_addrspace_diff_remove_alloca   : addrspace_diff_remove_alloca_before  ⊑  addrspace_diff_remove_alloca_combined := by
  unfold addrspace_diff_remove_alloca_before addrspace_diff_remove_alloca_combined
  simp_alive_peephole
  sorry
def phi_loop_combined := [llvmfunc|
  llvm.func @phi_loop(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @g1 : !llvm.ptr
    %3 = llvm.mlir.constant(4 : i64) : i64
    llvm.br ^bb1(%2 : !llvm.ptr)
  ^bb1(%4: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.getelementptr %4[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.cond_br %arg0, ^bb2, ^bb1(%5 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    %6 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %6 : i32
  }]

theorem inst_combine_phi_loop   : phi_loop_before  ⊑  phi_loop_combined := by
  unfold phi_loop_before phi_loop_combined
  simp_alive_peephole
  sorry
def phi_loop_different_addrspace_combined := [llvmfunc|
  llvm.func @phi_loop_different_addrspace(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()
    llvm.br ^bb1(%6 : !llvm.ptr)
  ^bb1(%7: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.getelementptr %7[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.cond_br %arg0, ^bb2, ^bb1(%8 : !llvm.ptr)
  ^bb2:  // pred: ^bb1
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %9 : i32
  }]

theorem inst_combine_phi_loop_different_addrspace   : phi_loop_different_addrspace_before  ⊑  phi_loop_different_addrspace_combined := by
  unfold phi_loop_different_addrspace_before phi_loop_different_addrspace_combined
  simp_alive_peephole
  sorry
def select_same_addrspace_remove_alloca_combined := [llvmfunc|
  llvm.func @select_same_addrspace_remove_alloca(%arg0: i1, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @g1 : !llvm.ptr
    %3 = llvm.select %arg0, %2, %arg1 : i1, !llvm.ptr
    %4 = llvm.load %3 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_select_same_addrspace_remove_alloca   : select_same_addrspace_remove_alloca_before  ⊑  select_same_addrspace_remove_alloca_combined := by
  unfold select_same_addrspace_remove_alloca_before select_same_addrspace_remove_alloca_combined
  simp_alive_peephole
  sorry
def select_after_memcpy_keep_alloca_combined := [llvmfunc|
  llvm.func @select_after_memcpy_keep_alloca(%arg0: i1, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.select %arg0, %5, %arg1 : i1, !llvm.ptr
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %7 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %7 : i8
  }]

theorem inst_combine_select_after_memcpy_keep_alloca   : select_after_memcpy_keep_alloca_before  ⊑  select_after_memcpy_keep_alloca_combined := by
  unfold select_after_memcpy_keep_alloca_before select_after_memcpy_keep_alloca_combined
  simp_alive_peephole
  sorry
def select_diff_addrspace_keep_alloca_combined := [llvmfunc|
  llvm.func @select_diff_addrspace_keep_alloca(%arg0: i1, %arg1: !llvm.ptr<1>) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr<1>
    "llvm.intr.memcpy"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()
    %6 = llvm.select %arg0, %5, %arg1 : i1, !llvm.ptr<1>
    %7 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr<1> -> i8
    llvm.return %7 : i8
  }]

theorem inst_combine_select_diff_addrspace_keep_alloca   : select_diff_addrspace_keep_alloca_before  ⊑  select_diff_addrspace_keep_alloca_combined := by
  unfold select_diff_addrspace_keep_alloca_before select_diff_addrspace_keep_alloca_combined
  simp_alive_peephole
  sorry
def select_diff_addrspace_remove_alloca_combined := [llvmfunc|
  llvm.func @select_diff_addrspace_remove_alloca(%arg0: i1, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_select_diff_addrspace_remove_alloca   : select_diff_addrspace_remove_alloca_before  ⊑  select_diff_addrspace_remove_alloca_combined := by
  unfold select_diff_addrspace_remove_alloca_before select_diff_addrspace_remove_alloca_combined
  simp_alive_peephole
  sorry
def call_readonly_remove_alloca_combined := [llvmfunc|
  llvm.func @call_readonly_remove_alloca() -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @g1 : !llvm.ptr
    %3 = llvm.call @readonly_callee(%2) : (!llvm.ptr) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_call_readonly_remove_alloca   : call_readonly_remove_alloca_before  ⊑  call_readonly_remove_alloca_combined := by
  unfold call_readonly_remove_alloca_before call_readonly_remove_alloca_combined
  simp_alive_peephole
  sorry
def call_readonly_keep_alloca2_combined := [llvmfunc|
  llvm.func @call_readonly_keep_alloca2() -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr
    %4 = llvm.mlir.constant(16 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.mlir.addressof @g2 : !llvm.ptr<1>
    %7 = llvm.alloca %0 x !llvm.array<32 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr<1>
    "llvm.intr.memcpy"(%7, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()
    %8 = llvm.getelementptr inbounds %7[%5, %4] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.array<32 x i8>
    "llvm.intr.memcpy"(%8, %6, %4) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr<1>, i64) -> ()
    %9 = llvm.addrspacecast %7 : !llvm.ptr<1> to !llvm.ptr
    %10 = llvm.call @readonly_callee(%9) : (!llvm.ptr) -> i8
    llvm.return %10 : i8
  }]

theorem inst_combine_call_readonly_keep_alloca2   : call_readonly_keep_alloca2_before  ⊑  call_readonly_keep_alloca2_combined := by
  unfold call_readonly_keep_alloca2_before call_readonly_keep_alloca2_combined
  simp_alive_peephole
  sorry
