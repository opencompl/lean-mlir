import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  overflow_to_sat
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def uadd_before := [llvmfunc|
  llvm.func @uadd(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.select %2, %0, %3 : i1, i32
    llvm.return %4 : i32
  }]

def usub_before := [llvmfunc|
  llvm.func @usub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.select %2, %0, %3 : i1, i32
    llvm.return %4 : i32
  }]

def sadd_x_lt_min_before := [llvmfunc|
  llvm.func @sadd_x_lt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_x_lt_max_before := [llvmfunc|
  llvm.func @sadd_x_lt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_x_le_min_before := [llvmfunc|
  llvm.func @sadd_x_le_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_x_le_max_before := [llvmfunc|
  llvm.func @sadd_x_le_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_x_gt_min_before := [llvmfunc|
  llvm.func @sadd_x_gt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_x_gt_max_before := [llvmfunc|
  llvm.func @sadd_x_gt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_x_ge_min_before := [llvmfunc|
  llvm.func @sadd_x_ge_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_x_ge_max_before := [llvmfunc|
  llvm.func @sadd_x_ge_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_y_lt_min_before := [llvmfunc|
  llvm.func @sadd_y_lt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_y_lt_max_before := [llvmfunc|
  llvm.func @sadd_y_lt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_y_le_min_before := [llvmfunc|
  llvm.func @sadd_y_le_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_y_le_max_before := [llvmfunc|
  llvm.func @sadd_y_le_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_y_gt_min_before := [llvmfunc|
  llvm.func @sadd_y_gt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_y_gt_max_before := [llvmfunc|
  llvm.func @sadd_y_gt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_y_ge_min_before := [llvmfunc|
  llvm.func @sadd_y_ge_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_y_ge_max_before := [llvmfunc|
  llvm.func @sadd_y_ge_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_x_lt_min_before := [llvmfunc|
  llvm.func @ssub_x_lt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_x_lt_max_before := [llvmfunc|
  llvm.func @ssub_x_lt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_x_le_min_before := [llvmfunc|
  llvm.func @ssub_x_le_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_x_le_max_before := [llvmfunc|
  llvm.func @ssub_x_le_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_x_lt2_min_before := [llvmfunc|
  llvm.func @ssub_x_lt2_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_x_lt2_max_before := [llvmfunc|
  llvm.func @ssub_x_lt2_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_x_gt_min_before := [llvmfunc|
  llvm.func @ssub_x_gt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_x_gt_max_before := [llvmfunc|
  llvm.func @ssub_x_gt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_x_ge_min_before := [llvmfunc|
  llvm.func @ssub_x_ge_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_x_ge_max_before := [llvmfunc|
  llvm.func @ssub_x_ge_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_x_gt2_min_before := [llvmfunc|
  llvm.func @ssub_x_gt2_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_x_gt2_max_before := [llvmfunc|
  llvm.func @ssub_x_gt2_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_y_lt_min_before := [llvmfunc|
  llvm.func @ssub_y_lt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_y_lt_max_before := [llvmfunc|
  llvm.func @ssub_y_lt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_y_le_min_before := [llvmfunc|
  llvm.func @ssub_y_le_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_y_le_max_before := [llvmfunc|
  llvm.func @ssub_y_le_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_y_gt_min_before := [llvmfunc|
  llvm.func @ssub_y_gt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_y_gt_max_before := [llvmfunc|
  llvm.func @ssub_y_gt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_y_ge_min_before := [llvmfunc|
  llvm.func @ssub_y_ge_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def ssub_y_ge_max_before := [llvmfunc|
  llvm.func @ssub_y_ge_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

def sadd_i32_before := [llvmfunc|
  llvm.func @sadd_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(2147483647 : i32) : i32
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %4, %7, %5 : i1, i32
    llvm.return %8 : i32
  }]

def ssub_i32_before := [llvmfunc|
  llvm.func @ssub_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(2147483647 : i32) : i32
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %4, %7, %5 : i1, i32
    llvm.return %8 : i32
  }]

def sadd_bounds_before := [llvmfunc|
  llvm.func @sadd_bounds(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.mlir.constant(127 : i32) : i32
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %4, %7, %5 : i1, i32
    llvm.return %8 : i32
  }]

def ssub_bounds_before := [llvmfunc|
  llvm.func @ssub_bounds(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.mlir.constant(127 : i32) : i32
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %4, %7, %5 : i1, i32
    llvm.return %8 : i32
  }]

def uadd_combined := [llvmfunc|
  llvm.func @uadd(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.uadd.sat(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd   : uadd_before  ⊑  uadd_combined := by
  unfold uadd_before uadd_combined
  simp_alive_peephole
  sorry
def usub_combined := [llvmfunc|
  llvm.func @usub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_usub   : usub_before  ⊑  usub_combined := by
  unfold usub_before usub_combined
  simp_alive_peephole
  sorry
def sadd_x_lt_min_combined := [llvmfunc|
  llvm.func @sadd_x_lt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_sadd_x_lt_min   : sadd_x_lt_min_before  ⊑  sadd_x_lt_min_combined := by
  unfold sadd_x_lt_min_before sadd_x_lt_min_combined
  simp_alive_peephole
  sorry
def sadd_x_lt_max_combined := [llvmfunc|
  llvm.func @sadd_x_lt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.sadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_sadd_x_lt_max   : sadd_x_lt_max_before  ⊑  sadd_x_lt_max_combined := by
  unfold sadd_x_lt_max_before sadd_x_lt_max_combined
  simp_alive_peephole
  sorry
def sadd_x_le_min_combined := [llvmfunc|
  llvm.func @sadd_x_le_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_sadd_x_le_min   : sadd_x_le_min_before  ⊑  sadd_x_le_min_combined := by
  unfold sadd_x_le_min_before sadd_x_le_min_combined
  simp_alive_peephole
  sorry
def sadd_x_le_max_combined := [llvmfunc|
  llvm.func @sadd_x_le_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.sadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_sadd_x_le_max   : sadd_x_le_max_before  ⊑  sadd_x_le_max_combined := by
  unfold sadd_x_le_max_before sadd_x_le_max_combined
  simp_alive_peephole
  sorry
def sadd_x_gt_min_combined := [llvmfunc|
  llvm.func @sadd_x_gt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.sadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_sadd_x_gt_min   : sadd_x_gt_min_before  ⊑  sadd_x_gt_min_combined := by
  unfold sadd_x_gt_min_before sadd_x_gt_min_combined
  simp_alive_peephole
  sorry
def sadd_x_gt_max_combined := [llvmfunc|
  llvm.func @sadd_x_gt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_sadd_x_gt_max   : sadd_x_gt_max_before  ⊑  sadd_x_gt_max_combined := by
  unfold sadd_x_gt_max_before sadd_x_gt_max_combined
  simp_alive_peephole
  sorry
def sadd_x_ge_min_combined := [llvmfunc|
  llvm.func @sadd_x_ge_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.sadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_sadd_x_ge_min   : sadd_x_ge_min_before  ⊑  sadd_x_ge_min_combined := by
  unfold sadd_x_ge_min_before sadd_x_ge_min_combined
  simp_alive_peephole
  sorry
def sadd_x_ge_max_combined := [llvmfunc|
  llvm.func @sadd_x_ge_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_sadd_x_ge_max   : sadd_x_ge_max_before  ⊑  sadd_x_ge_max_combined := by
  unfold sadd_x_ge_max_before sadd_x_ge_max_combined
  simp_alive_peephole
  sorry
def sadd_y_lt_min_combined := [llvmfunc|
  llvm.func @sadd_y_lt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_sadd_y_lt_min   : sadd_y_lt_min_before  ⊑  sadd_y_lt_min_combined := by
  unfold sadd_y_lt_min_before sadd_y_lt_min_combined
  simp_alive_peephole
  sorry
def sadd_y_lt_max_combined := [llvmfunc|
  llvm.func @sadd_y_lt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.sadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_sadd_y_lt_max   : sadd_y_lt_max_before  ⊑  sadd_y_lt_max_combined := by
  unfold sadd_y_lt_max_before sadd_y_lt_max_combined
  simp_alive_peephole
  sorry
def sadd_y_le_min_combined := [llvmfunc|
  llvm.func @sadd_y_le_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_sadd_y_le_min   : sadd_y_le_min_before  ⊑  sadd_y_le_min_combined := by
  unfold sadd_y_le_min_before sadd_y_le_min_combined
  simp_alive_peephole
  sorry
def sadd_y_le_max_combined := [llvmfunc|
  llvm.func @sadd_y_le_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.sadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_sadd_y_le_max   : sadd_y_le_max_before  ⊑  sadd_y_le_max_combined := by
  unfold sadd_y_le_max_before sadd_y_le_max_combined
  simp_alive_peephole
  sorry
def sadd_y_gt_min_combined := [llvmfunc|
  llvm.func @sadd_y_gt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.sadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_sadd_y_gt_min   : sadd_y_gt_min_before  ⊑  sadd_y_gt_min_combined := by
  unfold sadd_y_gt_min_before sadd_y_gt_min_combined
  simp_alive_peephole
  sorry
def sadd_y_gt_max_combined := [llvmfunc|
  llvm.func @sadd_y_gt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_sadd_y_gt_max   : sadd_y_gt_max_before  ⊑  sadd_y_gt_max_combined := by
  unfold sadd_y_gt_max_before sadd_y_gt_max_combined
  simp_alive_peephole
  sorry
def sadd_y_ge_min_combined := [llvmfunc|
  llvm.func @sadd_y_ge_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.sadd.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_sadd_y_ge_min   : sadd_y_ge_min_before  ⊑  sadd_y_ge_min_combined := by
  unfold sadd_y_ge_min_before sadd_y_ge_min_combined
  simp_alive_peephole
  sorry
def sadd_y_ge_max_combined := [llvmfunc|
  llvm.func @sadd_y_ge_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_sadd_y_ge_max   : sadd_y_ge_max_before  ⊑  sadd_y_ge_max_combined := by
  unfold sadd_y_ge_max_before sadd_y_ge_max_combined
  simp_alive_peephole
  sorry
def ssub_x_lt_min_combined := [llvmfunc|
  llvm.func @ssub_x_lt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_ssub_x_lt_min   : ssub_x_lt_min_before  ⊑  ssub_x_lt_min_combined := by
  unfold ssub_x_lt_min_before ssub_x_lt_min_combined
  simp_alive_peephole
  sorry
def ssub_x_lt_max_combined := [llvmfunc|
  llvm.func @ssub_x_lt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_ssub_x_lt_max   : ssub_x_lt_max_before  ⊑  ssub_x_lt_max_combined := by
  unfold ssub_x_lt_max_before ssub_x_lt_max_combined
  simp_alive_peephole
  sorry
def ssub_x_le_min_combined := [llvmfunc|
  llvm.func @ssub_x_le_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_ssub_x_le_min   : ssub_x_le_min_before  ⊑  ssub_x_le_min_combined := by
  unfold ssub_x_le_min_before ssub_x_le_min_combined
  simp_alive_peephole
  sorry
def ssub_x_le_max_combined := [llvmfunc|
  llvm.func @ssub_x_le_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_ssub_x_le_max   : ssub_x_le_max_before  ⊑  ssub_x_le_max_combined := by
  unfold ssub_x_le_max_before ssub_x_le_max_combined
  simp_alive_peephole
  sorry
def ssub_x_lt2_min_combined := [llvmfunc|
  llvm.func @ssub_x_lt2_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_ssub_x_lt2_min   : ssub_x_lt2_min_before  ⊑  ssub_x_lt2_min_combined := by
  unfold ssub_x_lt2_min_before ssub_x_lt2_min_combined
  simp_alive_peephole
  sorry
def ssub_x_lt2_max_combined := [llvmfunc|
  llvm.func @ssub_x_lt2_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_ssub_x_lt2_max   : ssub_x_lt2_max_before  ⊑  ssub_x_lt2_max_combined := by
  unfold ssub_x_lt2_max_before ssub_x_lt2_max_combined
  simp_alive_peephole
  sorry
def ssub_x_gt_min_combined := [llvmfunc|
  llvm.func @ssub_x_gt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_ssub_x_gt_min   : ssub_x_gt_min_before  ⊑  ssub_x_gt_min_combined := by
  unfold ssub_x_gt_min_before ssub_x_gt_min_combined
  simp_alive_peephole
  sorry
def ssub_x_gt_max_combined := [llvmfunc|
  llvm.func @ssub_x_gt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_ssub_x_gt_max   : ssub_x_gt_max_before  ⊑  ssub_x_gt_max_combined := by
  unfold ssub_x_gt_max_before ssub_x_gt_max_combined
  simp_alive_peephole
  sorry
def ssub_x_ge_min_combined := [llvmfunc|
  llvm.func @ssub_x_ge_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_ssub_x_ge_min   : ssub_x_ge_min_before  ⊑  ssub_x_ge_min_combined := by
  unfold ssub_x_ge_min_before ssub_x_ge_min_combined
  simp_alive_peephole
  sorry
def ssub_x_ge_max_combined := [llvmfunc|
  llvm.func @ssub_x_ge_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_ssub_x_ge_max   : ssub_x_ge_max_before  ⊑  ssub_x_ge_max_combined := by
  unfold ssub_x_ge_max_before ssub_x_ge_max_combined
  simp_alive_peephole
  sorry
def ssub_x_gt2_min_combined := [llvmfunc|
  llvm.func @ssub_x_gt2_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_ssub_x_gt2_min   : ssub_x_gt2_min_before  ⊑  ssub_x_gt2_min_combined := by
  unfold ssub_x_gt2_min_before ssub_x_gt2_min_combined
  simp_alive_peephole
  sorry
def ssub_x_gt2_max_combined := [llvmfunc|
  llvm.func @ssub_x_gt2_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_ssub_x_gt2_max   : ssub_x_gt2_max_before  ⊑  ssub_x_gt2_max_combined := by
  unfold ssub_x_gt2_max_before ssub_x_gt2_max_combined
  simp_alive_peephole
  sorry
def ssub_y_lt_min_combined := [llvmfunc|
  llvm.func @ssub_y_lt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_ssub_y_lt_min   : ssub_y_lt_min_before  ⊑  ssub_y_lt_min_combined := by
  unfold ssub_y_lt_min_before ssub_y_lt_min_combined
  simp_alive_peephole
  sorry
def ssub_y_lt_max_combined := [llvmfunc|
  llvm.func @ssub_y_lt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_ssub_y_lt_max   : ssub_y_lt_max_before  ⊑  ssub_y_lt_max_combined := by
  unfold ssub_y_lt_max_before ssub_y_lt_max_combined
  simp_alive_peephole
  sorry
def ssub_y_le_min_combined := [llvmfunc|
  llvm.func @ssub_y_le_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_ssub_y_le_min   : ssub_y_le_min_before  ⊑  ssub_y_le_min_combined := by
  unfold ssub_y_le_min_before ssub_y_le_min_combined
  simp_alive_peephole
  sorry
def ssub_y_le_max_combined := [llvmfunc|
  llvm.func @ssub_y_le_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_ssub_y_le_max   : ssub_y_le_max_before  ⊑  ssub_y_le_max_combined := by
  unfold ssub_y_le_max_before ssub_y_le_max_combined
  simp_alive_peephole
  sorry
def ssub_y_gt_min_combined := [llvmfunc|
  llvm.func @ssub_y_gt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_ssub_y_gt_min   : ssub_y_gt_min_before  ⊑  ssub_y_gt_min_combined := by
  unfold ssub_y_gt_min_before ssub_y_gt_min_combined
  simp_alive_peephole
  sorry
def ssub_y_gt_max_combined := [llvmfunc|
  llvm.func @ssub_y_gt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_ssub_y_gt_max   : ssub_y_gt_max_before  ⊑  ssub_y_gt_max_combined := by
  unfold ssub_y_gt_max_before ssub_y_gt_max_combined
  simp_alive_peephole
  sorry
def ssub_y_ge_min_combined := [llvmfunc|
  llvm.func @ssub_y_ge_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }]

theorem inst_combine_ssub_y_ge_min   : ssub_y_ge_min_before  ⊑  ssub_y_ge_min_combined := by
  unfold ssub_y_ge_min_before ssub_y_ge_min_combined
  simp_alive_peephole
  sorry
def ssub_y_ge_max_combined := [llvmfunc|
  llvm.func @ssub_y_ge_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_ssub_y_ge_max   : ssub_y_ge_max_before  ⊑  ssub_y_ge_max_combined := by
  unfold ssub_y_ge_max_before ssub_y_ge_max_combined
  simp_alive_peephole
  sorry
def sadd_i32_combined := [llvmfunc|
  llvm.func @sadd_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.sadd.sat(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_sadd_i32   : sadd_i32_before  ⊑  sadd_i32_combined := by
  unfold sadd_i32_before sadd_i32_combined
  simp_alive_peephole
  sorry
def ssub_i32_combined := [llvmfunc|
  llvm.func @ssub_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.ssub.sat(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ssub_i32   : ssub_i32_before  ⊑  ssub_i32_combined := by
  unfold ssub_i32_before ssub_i32_combined
  simp_alive_peephole
  sorry
def sadd_bounds_combined := [llvmfunc|
  llvm.func @sadd_bounds(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.mlir.constant(127 : i32) : i32
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %4, %7, %5 : i1, i32
    llvm.return %8 : i32
  }]

theorem inst_combine_sadd_bounds   : sadd_bounds_before  ⊑  sadd_bounds_combined := by
  unfold sadd_bounds_before sadd_bounds_combined
  simp_alive_peephole
  sorry
def ssub_bounds_combined := [llvmfunc|
  llvm.func @ssub_bounds(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.mlir.constant(127 : i32) : i32
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %4, %7, %5 : i1, i32
    llvm.return %8 : i32
  }]

theorem inst_combine_ssub_bounds   : ssub_bounds_before  ⊑  ssub_bounds_combined := by
  unfold ssub_bounds_before ssub_bounds_combined
  simp_alive_peephole
  sorry
