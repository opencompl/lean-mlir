import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and-or-not
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def and_to_xor1_before := [llvmfunc|
  llvm.func @and_to_xor1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }]

def and_to_xor2_before := [llvmfunc|
  llvm.func @and_to_xor2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def and_to_xor3_before := [llvmfunc|
  llvm.func @and_to_xor3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }]

def and_to_xor4_before := [llvmfunc|
  llvm.func @and_to_xor4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def and_to_xor1_vec_before := [llvmfunc|
  llvm.func @and_to_xor1_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.or %arg0, %arg1  : vector<4xi32>
    %2 = llvm.and %arg0, %arg1  : vector<4xi32>
    %3 = llvm.xor %2, %0  : vector<4xi32>
    %4 = llvm.and %1, %3  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def and_to_nxor1_before := [llvmfunc|
  llvm.func @and_to_nxor1(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %4  : i32
    %6 = llvm.or %3, %2  : i32
    %7 = llvm.and %5, %6  : i32
    llvm.return %7 : i32
  }]

def and_to_nxor2_before := [llvmfunc|
  llvm.func @and_to_nxor2(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %4  : i32
    %6 = llvm.or %2, %3  : i32
    %7 = llvm.and %5, %6  : i32
    llvm.return %7 : i32
  }]

def and_to_nxor3_before := [llvmfunc|
  llvm.func @and_to_nxor3(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %3, %2  : i32
    %6 = llvm.or %1, %4  : i32
    %7 = llvm.and %5, %6  : i32
    llvm.return %7 : i32
  }]

def and_to_nxor4_before := [llvmfunc|
  llvm.func @and_to_nxor4(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %3, %2  : i32
    %6 = llvm.or %4, %1  : i32
    %7 = llvm.and %5, %6  : i32
    llvm.return %7 : i32
  }]

def or_to_xor1_before := [llvmfunc|
  llvm.func @or_to_xor1(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %1, %4  : i32
    %6 = llvm.and %3, %2  : i32
    %7 = llvm.or %5, %6  : i32
    llvm.return %7 : i32
  }]

def or_to_xor2_before := [llvmfunc|
  llvm.func @or_to_xor2(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %1, %4  : i32
    %6 = llvm.and %2, %3  : i32
    %7 = llvm.or %5, %6  : i32
    llvm.return %7 : i32
  }]

def or_to_xor3_before := [llvmfunc|
  llvm.func @or_to_xor3(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %3, %2  : i32
    %6 = llvm.and %4, %1  : i32
    %7 = llvm.or %5, %6  : i32
    llvm.return %7 : i32
  }]

def or_to_xor4_before := [llvmfunc|
  llvm.func @or_to_xor4(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %3, %2  : i32
    %6 = llvm.and %1, %4  : i32
    %7 = llvm.or %5, %6  : i32
    llvm.return %7 : i32
  }]

def or_to_nxor1_before := [llvmfunc|
  llvm.func @or_to_nxor1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

def or_to_nxor2_before := [llvmfunc|
  llvm.func @or_to_nxor2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg1, %arg0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }]

def or_to_nxor3_before := [llvmfunc|
  llvm.func @or_to_nxor3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

def or_to_nxor4_before := [llvmfunc|
  llvm.func @or_to_nxor4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }]

def xor_to_xor1_before := [llvmfunc|
  llvm.func @xor_to_xor1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def xor_to_xor2_before := [llvmfunc|
  llvm.func @xor_to_xor2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def xor_to_xor3_before := [llvmfunc|
  llvm.func @xor_to_xor3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def xor_to_xor4_before := [llvmfunc|
  llvm.func @xor_to_xor4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def xor_to_xor5_before := [llvmfunc|
  llvm.func @xor_to_xor5(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %4  : i32
    %6 = llvm.or %3, %2  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }]

def xor_to_xor6_before := [llvmfunc|
  llvm.func @xor_to_xor6(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %4  : i32
    %6 = llvm.or %2, %3  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }]

def xor_to_xor7_before := [llvmfunc|
  llvm.func @xor_to_xor7(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %4  : i32
    %6 = llvm.or %3, %2  : i32
    %7 = llvm.xor %6, %5  : i32
    llvm.return %7 : i32
  }]

def xor_to_xor8_before := [llvmfunc|
  llvm.func @xor_to_xor8(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %4, %1  : i32
    %6 = llvm.or %3, %2  : i32
    %7 = llvm.xor %6, %5  : i32
    llvm.return %7 : i32
  }]

def xor_to_xor9_before := [llvmfunc|
  llvm.func @xor_to_xor9(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %1, %4  : i32
    %6 = llvm.and %3, %2  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }]

def xor_to_xor10_before := [llvmfunc|
  llvm.func @xor_to_xor10(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %1, %4  : i32
    %6 = llvm.and %2, %3  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }]

def xor_to_xor11_before := [llvmfunc|
  llvm.func @xor_to_xor11(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %1, %4  : i32
    %6 = llvm.and %3, %2  : i32
    %7 = llvm.xor %6, %5  : i32
    llvm.return %7 : i32
  }]

def xor_to_xor12_before := [llvmfunc|
  llvm.func @xor_to_xor12(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.and %3, %2  : i32
    %7 = llvm.xor %6, %5  : i32
    llvm.return %7 : i32
  }]

def PR32830_before := [llvmfunc|
  llvm.func @PR32830(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.xor %arg1, %0  : i64
    %3 = llvm.or %2, %arg0  : i64
    %4 = llvm.or %1, %arg2  : i64
    %5 = llvm.and %3, %4  : i64
    llvm.return %5 : i64
  }]

def and_to_nxor_multiuse_before := [llvmfunc|
  llvm.func @and_to_nxor_multiuse(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %3, %2  : i32
    %6 = llvm.or %4, %1  : i32
    %7 = llvm.and %5, %6  : i32
    %8 = llvm.mul %5, %6  : i32
    %9 = llvm.mul %8, %7  : i32
    llvm.return %9 : i32
  }]

def or_to_nxor_multiuse_before := [llvmfunc|
  llvm.func @or_to_nxor_multiuse(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    %5 = llvm.mul %1, %3  : i32
    %6 = llvm.mul %5, %4  : i32
    llvm.return %6 : i32
  }]

def xor_to_xnor1_before := [llvmfunc|
  llvm.func @xor_to_xnor1(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %2  : i32
    %6 = llvm.or %3, %4  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }]

def xor_to_xnor2_before := [llvmfunc|
  llvm.func @xor_to_xnor2(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %1, %2  : i32
    %6 = llvm.or %4, %3  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }]

def xor_to_xnor3_before := [llvmfunc|
  llvm.func @xor_to_xnor3(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.or %1, %2  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }]

def xor_to_xnor4_before := [llvmfunc|
  llvm.func @xor_to_xnor4(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.or %2, %1  : i32
    %7 = llvm.xor %5, %6  : i32
    llvm.return %7 : i32
  }]

def simplify_or_common_op_commute0_before := [llvmfunc|
  llvm.func @simplify_or_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg0, %arg1  : i4
    %2 = llvm.and %1, %arg2  : i4
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.or %3, %arg0  : i4
    llvm.return %4 : i4
  }]

def simplify_or_common_op_commute1_before := [llvmfunc|
  llvm.func @simplify_or_common_op_commute1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg1, %arg0  : i4
    %2 = llvm.and %1, %arg2  : i4
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.or %3, %arg0  : i4
    llvm.return %4 : i4
  }]

def simplify_or_common_op_commute2_before := [llvmfunc|
  llvm.func @simplify_or_common_op_commute2(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mul %arg2, %arg2  : i4
    %2 = llvm.and %arg0, %arg1  : i4
    %3 = llvm.and %1, %2  : i4
    %4 = llvm.and %3, %arg3  : i4
    %5 = llvm.xor %4, %0  : i4
    %6 = llvm.or %5, %arg0  : i4
    llvm.return %6 : i4
  }]

def simplify_or_common_op_commute3_before := [llvmfunc|
  llvm.func @simplify_or_common_op_commute3(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mul %arg2, %arg2  : vector<2xi4>
    %3 = llvm.and %arg1, %arg0  : vector<2xi4>
    %4 = llvm.and %2, %3  : vector<2xi4>
    %5 = llvm.xor %4, %1  : vector<2xi4>
    %6 = llvm.or %arg0, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def simplify_and_common_op_commute0_before := [llvmfunc|
  llvm.func @simplify_and_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.or %arg0, %arg1  : i4
    llvm.call @use(%arg0) : (i4) -> ()
    %2 = llvm.or %1, %arg2  : i4
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.and %3, %arg0  : i4
    llvm.return %4 : i4
  }]

def simplify_and_common_op_commute1_before := [llvmfunc|
  llvm.func @simplify_and_common_op_commute1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.or %arg1, %arg0  : i4
    %2 = llvm.or %1, %arg2  : i4
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.and %3, %arg0  : i4
    llvm.return %4 : i4
  }]

def simplify_and_common_op_commute2_before := [llvmfunc|
  llvm.func @simplify_and_common_op_commute2(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mul %arg2, %arg2  : i4
    %2 = llvm.or %arg0, %arg1  : i4
    %3 = llvm.or %1, %2  : i4
    %4 = llvm.or %3, %arg3  : i4
    %5 = llvm.xor %4, %0  : i4
    %6 = llvm.and %5, %arg0  : i4
    llvm.return %6 : i4
  }]

def simplify_and_common_op_commute3_before := [llvmfunc|
  llvm.func @simplify_and_common_op_commute3(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.mul %arg2, %arg2  : vector<2xi4>
    %3 = llvm.or %arg1, %arg0  : vector<2xi4>
    %4 = llvm.or %2, %3  : vector<2xi4>
    %5 = llvm.xor %4, %1  : vector<2xi4>
    %6 = llvm.and %arg0, %5  : vector<2xi4>
    llvm.return %6 : vector<2xi4>
  }]

def simplify_and_common_op_use1_before := [llvmfunc|
  llvm.func @simplify_and_common_op_use1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.or %arg0, %arg1  : i4
    llvm.call @use(%arg1) : (i4) -> ()
    %2 = llvm.or %1, %arg2  : i4
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.and %3, %arg0  : i4
    llvm.return %4 : i4
  }]

def simplify_and_common_op_use2_before := [llvmfunc|
  llvm.func @simplify_and_common_op_use2(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.or %arg1, %arg0  : i4
    llvm.call @use(%arg1) : (i4) -> ()
    %2 = llvm.or %1, %arg2  : i4
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.and %3, %arg0  : i4
    llvm.return %4 : i4
  }]

def simplify_and_common_op_use3_before := [llvmfunc|
  llvm.func @simplify_and_common_op_use3(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.or %arg0, %arg1  : i4
    %2 = llvm.or %1, %arg2  : i4
    llvm.call @use(%arg2) : (i4) -> ()
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.and %3, %arg0  : i4
    llvm.return %4 : i4
  }]

def reduce_xor_common_op_commute0_before := [llvmfunc|
  llvm.func @reduce_xor_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg0, %arg1  : i4
    %1 = llvm.xor %0, %arg2  : i4
    %2 = llvm.or %1, %arg0  : i4
    llvm.return %2 : i4
  }]

def reduce_xor_common_op_commute1_before := [llvmfunc|
  llvm.func @reduce_xor_common_op_commute1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg1, %arg0  : i4
    %1 = llvm.xor %0, %arg2  : i4
    %2 = llvm.or %1, %arg0  : i4
    llvm.return %2 : i4
  }]

def annihilate_xor_common_op_commute2_before := [llvmfunc|
  llvm.func @annihilate_xor_common_op_commute2(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: i4) -> i4 {
    %0 = llvm.mul %arg2, %arg2  : i4
    %1 = llvm.xor %arg0, %arg1  : i4
    %2 = llvm.xor %0, %1  : i4
    %3 = llvm.xor %2, %arg3  : i4
    %4 = llvm.xor %3, %arg0  : i4
    llvm.return %4 : i4
  }]

def reduce_xor_common_op_commute3_before := [llvmfunc|
  llvm.func @reduce_xor_common_op_commute3(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mul %arg2, %arg2  : vector<2xi4>
    %1 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %2 = llvm.xor %0, %1  : vector<2xi4>
    %3 = llvm.or %arg0, %2  : vector<2xi4>
    llvm.return %3 : vector<2xi4>
  }]

def and_to_xor1_combined := [llvmfunc|
  llvm.func @and_to_xor1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_and_to_xor1   : and_to_xor1_before  ⊑  and_to_xor1_combined := by
  unfold and_to_xor1_before and_to_xor1_combined
  simp_alive_peephole
  sorry
def and_to_xor2_combined := [llvmfunc|
  llvm.func @and_to_xor2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_and_to_xor2   : and_to_xor2_before  ⊑  and_to_xor2_combined := by
  unfold and_to_xor2_before and_to_xor2_combined
  simp_alive_peephole
  sorry
def and_to_xor3_combined := [llvmfunc|
  llvm.func @and_to_xor3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_and_to_xor3   : and_to_xor3_before  ⊑  and_to_xor3_combined := by
  unfold and_to_xor3_before and_to_xor3_combined
  simp_alive_peephole
  sorry
def and_to_xor4_combined := [llvmfunc|
  llvm.func @and_to_xor4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg1, %arg0  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_and_to_xor4   : and_to_xor4_before  ⊑  and_to_xor4_combined := by
  unfold and_to_xor4_before and_to_xor4_combined
  simp_alive_peephole
  sorry
def and_to_xor1_vec_combined := [llvmfunc|
  llvm.func @and_to_xor1_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.xor %arg0, %arg1  : vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_and_to_xor1_vec   : and_to_xor1_vec_before  ⊑  and_to_xor1_vec_combined := by
  unfold and_to_xor1_vec_before and_to_xor1_vec_combined
  simp_alive_peephole
  sorry
def and_to_nxor1_combined := [llvmfunc|
  llvm.func @and_to_nxor1(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_and_to_nxor1   : and_to_nxor1_before  ⊑  and_to_nxor1_combined := by
  unfold and_to_nxor1_before and_to_nxor1_combined
  simp_alive_peephole
  sorry
def and_to_nxor2_combined := [llvmfunc|
  llvm.func @and_to_nxor2(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_and_to_nxor2   : and_to_nxor2_before  ⊑  and_to_nxor2_combined := by
  unfold and_to_nxor2_before and_to_nxor2_combined
  simp_alive_peephole
  sorry
def and_to_nxor3_combined := [llvmfunc|
  llvm.func @and_to_nxor3(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_and_to_nxor3   : and_to_nxor3_before  ⊑  and_to_nxor3_combined := by
  unfold and_to_nxor3_before and_to_nxor3_combined
  simp_alive_peephole
  sorry
def and_to_nxor4_combined := [llvmfunc|
  llvm.func @and_to_nxor4(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_and_to_nxor4   : and_to_nxor4_before  ⊑  and_to_nxor4_combined := by
  unfold and_to_nxor4_before and_to_nxor4_combined
  simp_alive_peephole
  sorry
def or_to_xor1_combined := [llvmfunc|
  llvm.func @or_to_xor1(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.fptosi %arg1 : f32 to i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_or_to_xor1   : or_to_xor1_before  ⊑  or_to_xor1_combined := by
  unfold or_to_xor1_before or_to_xor1_combined
  simp_alive_peephole
  sorry
def or_to_xor2_combined := [llvmfunc|
  llvm.func @or_to_xor2(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.fptosi %arg1 : f32 to i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_or_to_xor2   : or_to_xor2_before  ⊑  or_to_xor2_combined := by
  unfold or_to_xor2_before or_to_xor2_combined
  simp_alive_peephole
  sorry
def or_to_xor3_combined := [llvmfunc|
  llvm.func @or_to_xor3(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.fptosi %arg1 : f32 to i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_or_to_xor3   : or_to_xor3_before  ⊑  or_to_xor3_combined := by
  unfold or_to_xor3_before or_to_xor3_combined
  simp_alive_peephole
  sorry
def or_to_xor4_combined := [llvmfunc|
  llvm.func @or_to_xor4(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.fptosi %arg1 : f32 to i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_or_to_xor4   : or_to_xor4_before  ⊑  or_to_xor4_combined := by
  unfold or_to_xor4_before or_to_xor4_combined
  simp_alive_peephole
  sorry
def or_to_nxor1_combined := [llvmfunc|
  llvm.func @or_to_nxor1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_or_to_nxor1   : or_to_nxor1_before  ⊑  or_to_nxor1_combined := by
  unfold or_to_nxor1_before or_to_nxor1_combined
  simp_alive_peephole
  sorry
def or_to_nxor2_combined := [llvmfunc|
  llvm.func @or_to_nxor2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_or_to_nxor2   : or_to_nxor2_before  ⊑  or_to_nxor2_combined := by
  unfold or_to_nxor2_before or_to_nxor2_combined
  simp_alive_peephole
  sorry
def or_to_nxor3_combined := [llvmfunc|
  llvm.func @or_to_nxor3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_or_to_nxor3   : or_to_nxor3_before  ⊑  or_to_nxor3_combined := by
  unfold or_to_nxor3_before or_to_nxor3_combined
  simp_alive_peephole
  sorry
def or_to_nxor4_combined := [llvmfunc|
  llvm.func @or_to_nxor4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_or_to_nxor4   : or_to_nxor4_before  ⊑  or_to_nxor4_combined := by
  unfold or_to_nxor4_before or_to_nxor4_combined
  simp_alive_peephole
  sorry
def xor_to_xor1_combined := [llvmfunc|
  llvm.func @xor_to_xor1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_xor_to_xor1   : xor_to_xor1_before  ⊑  xor_to_xor1_combined := by
  unfold xor_to_xor1_before xor_to_xor1_combined
  simp_alive_peephole
  sorry
def xor_to_xor2_combined := [llvmfunc|
  llvm.func @xor_to_xor2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_xor_to_xor2   : xor_to_xor2_before  ⊑  xor_to_xor2_combined := by
  unfold xor_to_xor2_before xor_to_xor2_combined
  simp_alive_peephole
  sorry
def xor_to_xor3_combined := [llvmfunc|
  llvm.func @xor_to_xor3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_xor_to_xor3   : xor_to_xor3_before  ⊑  xor_to_xor3_combined := by
  unfold xor_to_xor3_before xor_to_xor3_combined
  simp_alive_peephole
  sorry
def xor_to_xor4_combined := [llvmfunc|
  llvm.func @xor_to_xor4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg1, %arg0  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_xor_to_xor4   : xor_to_xor4_before  ⊑  xor_to_xor4_combined := by
  unfold xor_to_xor4_before xor_to_xor4_combined
  simp_alive_peephole
  sorry
def xor_to_xor5_combined := [llvmfunc|
  llvm.func @xor_to_xor5(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.fptosi %arg1 : f32 to i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_xor_to_xor5   : xor_to_xor5_before  ⊑  xor_to_xor5_combined := by
  unfold xor_to_xor5_before xor_to_xor5_combined
  simp_alive_peephole
  sorry
def xor_to_xor6_combined := [llvmfunc|
  llvm.func @xor_to_xor6(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.fptosi %arg1 : f32 to i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_xor_to_xor6   : xor_to_xor6_before  ⊑  xor_to_xor6_combined := by
  unfold xor_to_xor6_before xor_to_xor6_combined
  simp_alive_peephole
  sorry
def xor_to_xor7_combined := [llvmfunc|
  llvm.func @xor_to_xor7(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.fptosi %arg1 : f32 to i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_xor_to_xor7   : xor_to_xor7_before  ⊑  xor_to_xor7_combined := by
  unfold xor_to_xor7_before xor_to_xor7_combined
  simp_alive_peephole
  sorry
def xor_to_xor8_combined := [llvmfunc|
  llvm.func @xor_to_xor8(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.fptosi %arg1 : f32 to i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_xor_to_xor8   : xor_to_xor8_before  ⊑  xor_to_xor8_combined := by
  unfold xor_to_xor8_before xor_to_xor8_combined
  simp_alive_peephole
  sorry
def xor_to_xor9_combined := [llvmfunc|
  llvm.func @xor_to_xor9(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.fptosi %arg1 : f32 to i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_xor_to_xor9   : xor_to_xor9_before  ⊑  xor_to_xor9_combined := by
  unfold xor_to_xor9_before xor_to_xor9_combined
  simp_alive_peephole
  sorry
def xor_to_xor10_combined := [llvmfunc|
  llvm.func @xor_to_xor10(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.fptosi %arg1 : f32 to i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_xor_to_xor10   : xor_to_xor10_before  ⊑  xor_to_xor10_combined := by
  unfold xor_to_xor10_before xor_to_xor10_combined
  simp_alive_peephole
  sorry
def xor_to_xor11_combined := [llvmfunc|
  llvm.func @xor_to_xor11(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.fptosi %arg1 : f32 to i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_xor_to_xor11   : xor_to_xor11_before  ⊑  xor_to_xor11_combined := by
  unfold xor_to_xor11_before xor_to_xor11_combined
  simp_alive_peephole
  sorry
def xor_to_xor12_combined := [llvmfunc|
  llvm.func @xor_to_xor12(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.fptosi %arg1 : f32 to i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_xor_to_xor12   : xor_to_xor12_before  ⊑  xor_to_xor12_combined := by
  unfold xor_to_xor12_before xor_to_xor12_combined
  simp_alive_peephole
  sorry
def PR32830_combined := [llvmfunc|
  llvm.func @PR32830(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.xor %arg1, %0  : i64
    %3 = llvm.or %2, %arg0  : i64
    %4 = llvm.or %1, %arg2  : i64
    %5 = llvm.and %3, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_PR32830   : PR32830_before  ⊑  PR32830_combined := by
  unfold PR32830_before PR32830_combined
  simp_alive_peephole
  sorry
def and_to_nxor_multiuse_combined := [llvmfunc|
  llvm.func @and_to_nxor_multiuse(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %3, %2  : i32
    %6 = llvm.or %4, %1  : i32
    %7 = llvm.and %5, %6  : i32
    %8 = llvm.mul %5, %6  : i32
    %9 = llvm.mul %8, %7  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_and_to_nxor_multiuse   : and_to_nxor_multiuse_before  ⊑  and_to_nxor_multiuse_combined := by
  unfold and_to_nxor_multiuse_before and_to_nxor_multiuse_combined
  simp_alive_peephole
  sorry
def or_to_nxor_multiuse_combined := [llvmfunc|
  llvm.func @or_to_nxor_multiuse(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    %5 = llvm.mul %1, %3  : i32
    %6 = llvm.mul %5, %4  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_or_to_nxor_multiuse   : or_to_nxor_multiuse_before  ⊑  or_to_nxor_multiuse_combined := by
  unfold or_to_nxor_multiuse_before or_to_nxor_multiuse_combined
  simp_alive_peephole
  sorry
def xor_to_xnor1_combined := [llvmfunc|
  llvm.func @xor_to_xnor1(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_xor_to_xnor1   : xor_to_xnor1_before  ⊑  xor_to_xnor1_combined := by
  unfold xor_to_xnor1_before xor_to_xnor1_combined
  simp_alive_peephole
  sorry
def xor_to_xnor2_combined := [llvmfunc|
  llvm.func @xor_to_xnor2(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_xor_to_xnor2   : xor_to_xnor2_before  ⊑  xor_to_xnor2_combined := by
  unfold xor_to_xnor2_before xor_to_xnor2_combined
  simp_alive_peephole
  sorry
def xor_to_xnor3_combined := [llvmfunc|
  llvm.func @xor_to_xnor3(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_xor_to_xnor3   : xor_to_xnor3_before  ⊑  xor_to_xnor3_combined := by
  unfold xor_to_xnor3_before xor_to_xnor3_combined
  simp_alive_peephole
  sorry
def xor_to_xnor4_combined := [llvmfunc|
  llvm.func @xor_to_xnor4(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.fptosi %arg0 : f32 to i32
    %2 = llvm.fptosi %arg1 : f32 to i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_xor_to_xnor4   : xor_to_xnor4_before  ⊑  xor_to_xnor4_combined := by
  unfold xor_to_xnor4_before xor_to_xnor4_combined
  simp_alive_peephole
  sorry
def simplify_or_common_op_commute0_combined := [llvmfunc|
  llvm.func @simplify_or_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    llvm.return %0 : i4
  }]

theorem inst_combine_simplify_or_common_op_commute0   : simplify_or_common_op_commute0_before  ⊑  simplify_or_common_op_commute0_combined := by
  unfold simplify_or_common_op_commute0_before simplify_or_common_op_commute0_combined
  simp_alive_peephole
  sorry
def simplify_or_common_op_commute1_combined := [llvmfunc|
  llvm.func @simplify_or_common_op_commute1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    llvm.return %0 : i4
  }]

theorem inst_combine_simplify_or_common_op_commute1   : simplify_or_common_op_commute1_before  ⊑  simplify_or_common_op_commute1_combined := by
  unfold simplify_or_common_op_commute1_before simplify_or_common_op_commute1_combined
  simp_alive_peephole
  sorry
def simplify_or_common_op_commute2_combined := [llvmfunc|
  llvm.func @simplify_or_common_op_commute2(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    llvm.return %0 : i4
  }]

theorem inst_combine_simplify_or_common_op_commute2   : simplify_or_common_op_commute2_before  ⊑  simplify_or_common_op_commute2_combined := by
  unfold simplify_or_common_op_commute2_before simplify_or_common_op_commute2_combined
  simp_alive_peephole
  sorry
def simplify_or_common_op_commute3_combined := [llvmfunc|
  llvm.func @simplify_or_common_op_commute3(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    llvm.return %1 : vector<2xi4>
  }]

theorem inst_combine_simplify_or_common_op_commute3   : simplify_or_common_op_commute3_before  ⊑  simplify_or_common_op_commute3_combined := by
  unfold simplify_or_common_op_commute3_before simplify_or_common_op_commute3_combined
  simp_alive_peephole
  sorry
def simplify_and_common_op_commute0_combined := [llvmfunc|
  llvm.func @simplify_and_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    llvm.call @use(%arg0) : (i4) -> ()
    llvm.return %0 : i4
  }]

theorem inst_combine_simplify_and_common_op_commute0   : simplify_and_common_op_commute0_before  ⊑  simplify_and_common_op_commute0_combined := by
  unfold simplify_and_common_op_commute0_before simplify_and_common_op_commute0_combined
  simp_alive_peephole
  sorry
def simplify_and_common_op_commute1_combined := [llvmfunc|
  llvm.func @simplify_and_common_op_commute1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    llvm.return %0 : i4
  }]

theorem inst_combine_simplify_and_common_op_commute1   : simplify_and_common_op_commute1_before  ⊑  simplify_and_common_op_commute1_combined := by
  unfold simplify_and_common_op_commute1_before simplify_and_common_op_commute1_combined
  simp_alive_peephole
  sorry
def simplify_and_common_op_commute2_combined := [llvmfunc|
  llvm.func @simplify_and_common_op_commute2(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: i4) -> i4 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    llvm.return %0 : i4
  }]

theorem inst_combine_simplify_and_common_op_commute2   : simplify_and_common_op_commute2_before  ⊑  simplify_and_common_op_commute2_combined := by
  unfold simplify_and_common_op_commute2_before simplify_and_common_op_commute2_combined
  simp_alive_peephole
  sorry
def simplify_and_common_op_commute3_combined := [llvmfunc|
  llvm.func @simplify_and_common_op_commute3(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(dense<0> : vector<2xi4>) : vector<2xi4>
    llvm.return %1 : vector<2xi4>
  }]

theorem inst_combine_simplify_and_common_op_commute3   : simplify_and_common_op_commute3_before  ⊑  simplify_and_common_op_commute3_combined := by
  unfold simplify_and_common_op_commute3_before simplify_and_common_op_commute3_combined
  simp_alive_peephole
  sorry
def simplify_and_common_op_use1_combined := [llvmfunc|
  llvm.func @simplify_and_common_op_use1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    llvm.call @use(%arg1) : (i4) -> ()
    llvm.return %0 : i4
  }]

theorem inst_combine_simplify_and_common_op_use1   : simplify_and_common_op_use1_before  ⊑  simplify_and_common_op_use1_combined := by
  unfold simplify_and_common_op_use1_before simplify_and_common_op_use1_combined
  simp_alive_peephole
  sorry
def simplify_and_common_op_use2_combined := [llvmfunc|
  llvm.func @simplify_and_common_op_use2(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    llvm.call @use(%arg1) : (i4) -> ()
    %1 = llvm.or %arg0, %arg2  : i4
    %2 = llvm.or %1, %arg1  : i4
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.and %3, %arg0  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_simplify_and_common_op_use2   : simplify_and_common_op_use2_before  ⊑  simplify_and_common_op_use2_combined := by
  unfold simplify_and_common_op_use2_before simplify_and_common_op_use2_combined
  simp_alive_peephole
  sorry
def simplify_and_common_op_use3_combined := [llvmfunc|
  llvm.func @simplify_and_common_op_use3(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.or %arg0, %arg1  : i4
    %2 = llvm.or %1, %arg2  : i4
    llvm.call @use(%arg2) : (i4) -> ()
    %3 = llvm.xor %2, %0  : i4
    %4 = llvm.and %3, %arg0  : i4
    llvm.return %4 : i4
  }]

theorem inst_combine_simplify_and_common_op_use3   : simplify_and_common_op_use3_before  ⊑  simplify_and_common_op_use3_combined := by
  unfold simplify_and_common_op_use3_before simplify_and_common_op_use3_combined
  simp_alive_peephole
  sorry
def reduce_xor_common_op_commute0_combined := [llvmfunc|
  llvm.func @reduce_xor_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg1, %arg2  : i4
    %1 = llvm.or %0, %arg0  : i4
    llvm.return %1 : i4
  }]

theorem inst_combine_reduce_xor_common_op_commute0   : reduce_xor_common_op_commute0_before  ⊑  reduce_xor_common_op_commute0_combined := by
  unfold reduce_xor_common_op_commute0_before reduce_xor_common_op_commute0_combined
  simp_alive_peephole
  sorry
def reduce_xor_common_op_commute1_combined := [llvmfunc|
  llvm.func @reduce_xor_common_op_commute1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.xor %arg1, %arg2  : i4
    %1 = llvm.or %0, %arg0  : i4
    llvm.return %1 : i4
  }]

theorem inst_combine_reduce_xor_common_op_commute1   : reduce_xor_common_op_commute1_before  ⊑  reduce_xor_common_op_commute1_combined := by
  unfold reduce_xor_common_op_commute1_before reduce_xor_common_op_commute1_combined
  simp_alive_peephole
  sorry
def annihilate_xor_common_op_commute2_combined := [llvmfunc|
  llvm.func @annihilate_xor_common_op_commute2(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: i4) -> i4 {
    %0 = llvm.mul %arg2, %arg2  : i4
    %1 = llvm.xor %0, %arg1  : i4
    %2 = llvm.xor %1, %arg3  : i4
    llvm.return %2 : i4
  }]

theorem inst_combine_annihilate_xor_common_op_commute2   : annihilate_xor_common_op_commute2_before  ⊑  annihilate_xor_common_op_commute2_combined := by
  unfold annihilate_xor_common_op_commute2_before annihilate_xor_common_op_commute2_combined
  simp_alive_peephole
  sorry
def reduce_xor_common_op_commute3_combined := [llvmfunc|
  llvm.func @reduce_xor_common_op_commute3(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mul %arg2, %arg2  : vector<2xi4>
    %1 = llvm.xor %0, %arg1  : vector<2xi4>
    %2 = llvm.or %1, %arg0  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_reduce_xor_common_op_commute3   : reduce_xor_common_op_commute3_before  ⊑  reduce_xor_common_op_commute3_combined := by
  unfold reduce_xor_common_op_commute3_before reduce_xor_common_op_commute3_combined
  simp_alive_peephole
  sorry
