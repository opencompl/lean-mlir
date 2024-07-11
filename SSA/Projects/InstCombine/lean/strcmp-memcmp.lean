import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strcmp-memcmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def strcmp_memcmp_before := [llvmfunc|
  llvm.func @strcmp_memcmp(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp2_before := [llvmfunc|
  llvm.func @strcmp_memcmp2(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp3_before := [llvmfunc|
  llvm.func @strcmp_memcmp3(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "ne" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp4_before := [llvmfunc|
  llvm.func @strcmp_memcmp4(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "ne" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp5_before := [llvmfunc|
  llvm.func @strcmp_memcmp5(%arg0: !llvm.ptr {llvm.dereferenceable = 5 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp6_before := [llvmfunc|
  llvm.func @strcmp_memcmp6(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "sgt" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp7_before := [llvmfunc|
  llvm.func @strcmp_memcmp7(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "slt" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp8_before := [llvmfunc|
  llvm.func @strcmp_memcmp8(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp9_before := [llvmfunc|
  llvm.func @strcmp_memcmp9(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("abc\00de\00\00") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @abc : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strncmp_memcmp_before := [llvmfunc|
  llvm.func @strncmp_memcmp(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp2_before := [llvmfunc|
  llvm.func @strncmp_memcmp2(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(11 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "ne" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp3_before := [llvmfunc|
  llvm.func @strncmp_memcmp3(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(11 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp4_before := [llvmfunc|
  llvm.func @strncmp_memcmp4(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp5_before := [llvmfunc|
  llvm.func @strncmp_memcmp5(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp6_before := [llvmfunc|
  llvm.func @strncmp_memcmp6(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "ne" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp7_before := [llvmfunc|
  llvm.func @strncmp_memcmp7(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp8_before := [llvmfunc|
  llvm.func @strncmp_memcmp8(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp9_before := [llvmfunc|
  llvm.func @strncmp_memcmp9(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "sgt" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp10_before := [llvmfunc|
  llvm.func @strncmp_memcmp10(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "slt" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp11_before := [llvmfunc|
  llvm.func @strncmp_memcmp11(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp12_before := [llvmfunc|
  llvm.func @strncmp_memcmp12(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp13_before := [llvmfunc|
  llvm.func @strncmp_memcmp13(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("abc\00de\00\00") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @abc : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp14_before := [llvmfunc|
  llvm.func @strncmp_memcmp14(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("abc\00de\00\00") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @abc : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strcmp_memcmp_bad_before := [llvmfunc|
  llvm.func @strcmp_memcmp_bad(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "sgt" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp_bad2_before := [llvmfunc|
  llvm.func @strcmp_memcmp_bad2(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "slt" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp_bad3_before := [llvmfunc|
  llvm.func @strcmp_memcmp_bad3(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def strcmp_memcmp_bad4_before := [llvmfunc|
  llvm.func @strcmp_memcmp_bad4(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp_bad5_before := [llvmfunc|
  llvm.func @strcmp_memcmp_bad5(%arg0: !llvm.ptr {llvm.dereferenceable = 3 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp_bad6_before := [llvmfunc|
  llvm.func @strcmp_memcmp_bad6(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strcmp(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

def strcmp_memcmp_bad7_before := [llvmfunc|
  llvm.func @strcmp_memcmp_bad7(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp_bad8_before := [llvmfunc|
  llvm.func @strcmp_memcmp_bad8(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %2 : i32
  }]

def strncmp_memcmp_bad_before := [llvmfunc|
  llvm.func @strncmp_memcmp_bad(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "sgt" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp_bad1_before := [llvmfunc|
  llvm.func @strncmp_memcmp_bad1(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "slt" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp_bad2_before := [llvmfunc|
  llvm.func @strncmp_memcmp_bad2(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}, %arg1: i64) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.call @strncmp(%1, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %4 = llvm.icmp "slt" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strncmp_memcmp_bad3_before := [llvmfunc|
  llvm.func @strncmp_memcmp_bad3(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def strncmp_memcmp_bad4_before := [llvmfunc|
  llvm.func @strncmp_memcmp_bad4(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %3 : i32
  }]

def strcmp_memcmp_msan_before := [llvmfunc|
  llvm.func @strcmp_memcmp_msan(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["sanitize_memory"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

def strcmp_memcmp_combined := [llvmfunc|
  llvm.func @strcmp_memcmp(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strcmp_memcmp   : strcmp_memcmp_before  ⊑  strcmp_memcmp_combined := by
  unfold strcmp_memcmp_before strcmp_memcmp_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp2_combined := [llvmfunc|
  llvm.func @strcmp_memcmp2(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strcmp_memcmp2   : strcmp_memcmp2_before  ⊑  strcmp_memcmp2_combined := by
  unfold strcmp_memcmp2_before strcmp_memcmp2_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp3_combined := [llvmfunc|
  llvm.func @strcmp_memcmp3(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "ne" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strcmp_memcmp3   : strcmp_memcmp3_before  ⊑  strcmp_memcmp3_combined := by
  unfold strcmp_memcmp3_before strcmp_memcmp3_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp4_combined := [llvmfunc|
  llvm.func @strcmp_memcmp4(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "ne" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strcmp_memcmp4   : strcmp_memcmp4_before  ⊑  strcmp_memcmp4_combined := by
  unfold strcmp_memcmp4_before strcmp_memcmp4_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp5_combined := [llvmfunc|
  llvm.func @strcmp_memcmp5(%arg0: !llvm.ptr {llvm.dereferenceable = 5 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strcmp_memcmp5   : strcmp_memcmp5_before  ⊑  strcmp_memcmp5_combined := by
  unfold strcmp_memcmp5_before strcmp_memcmp5_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp6_combined := [llvmfunc|
  llvm.func @strcmp_memcmp6(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "sgt" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strcmp_memcmp6   : strcmp_memcmp6_before  ⊑  strcmp_memcmp6_combined := by
  unfold strcmp_memcmp6_before strcmp_memcmp6_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp7_combined := [llvmfunc|
  llvm.func @strcmp_memcmp7(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(31 : i32) : i32
    %4 = llvm.call @memcmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.lshr %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_strcmp_memcmp7   : strcmp_memcmp7_before  ⊑  strcmp_memcmp7_combined := by
  unfold strcmp_memcmp7_before strcmp_memcmp7_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp8_combined := [llvmfunc|
  llvm.func @strcmp_memcmp8(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strcmp_memcmp8   : strcmp_memcmp8_before  ⊑  strcmp_memcmp8_combined := by
  unfold strcmp_memcmp8_before strcmp_memcmp8_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp9_combined := [llvmfunc|
  llvm.func @strcmp_memcmp9(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("abc\00de\00\00") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @abc : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strcmp_memcmp9   : strcmp_memcmp9_before  ⊑  strcmp_memcmp9_combined := by
  unfold strcmp_memcmp9_before strcmp_memcmp9_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp_combined := [llvmfunc|
  llvm.func @strncmp_memcmp(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp   : strncmp_memcmp_before  ⊑  strncmp_memcmp_combined := by
  unfold strncmp_memcmp_before strncmp_memcmp_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp2_combined := [llvmfunc|
  llvm.func @strncmp_memcmp2(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "ne" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp2   : strncmp_memcmp2_before  ⊑  strncmp_memcmp2_combined := by
  unfold strncmp_memcmp2_before strncmp_memcmp2_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp3_combined := [llvmfunc|
  llvm.func @strncmp_memcmp3(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp3   : strncmp_memcmp3_before  ⊑  strncmp_memcmp3_combined := by
  unfold strncmp_memcmp3_before strncmp_memcmp3_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp4_combined := [llvmfunc|
  llvm.func @strncmp_memcmp4(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp4   : strncmp_memcmp4_before  ⊑  strncmp_memcmp4_combined := by
  unfold strncmp_memcmp4_before strncmp_memcmp4_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp5_combined := [llvmfunc|
  llvm.func @strncmp_memcmp5(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp5   : strncmp_memcmp5_before  ⊑  strncmp_memcmp5_combined := by
  unfold strncmp_memcmp5_before strncmp_memcmp5_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp6_combined := [llvmfunc|
  llvm.func @strncmp_memcmp6(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "ne" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp6   : strncmp_memcmp6_before  ⊑  strncmp_memcmp6_combined := by
  unfold strncmp_memcmp6_before strncmp_memcmp6_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp7_combined := [llvmfunc|
  llvm.func @strncmp_memcmp7(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp7   : strncmp_memcmp7_before  ⊑  strncmp_memcmp7_combined := by
  unfold strncmp_memcmp7_before strncmp_memcmp7_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp8_combined := [llvmfunc|
  llvm.func @strncmp_memcmp8(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp8   : strncmp_memcmp8_before  ⊑  strncmp_memcmp8_combined := by
  unfold strncmp_memcmp8_before strncmp_memcmp8_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp9_combined := [llvmfunc|
  llvm.func @strncmp_memcmp9(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "sgt" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp9   : strncmp_memcmp9_before  ⊑  strncmp_memcmp9_combined := by
  unfold strncmp_memcmp9_before strncmp_memcmp9_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp10_combined := [llvmfunc|
  llvm.func @strncmp_memcmp10(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(31 : i32) : i32
    %4 = llvm.call @memcmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.lshr %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_strncmp_memcmp10   : strncmp_memcmp10_before  ⊑  strncmp_memcmp10_combined := by
  unfold strncmp_memcmp10_before strncmp_memcmp10_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp11_combined := [llvmfunc|
  llvm.func @strncmp_memcmp11(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp11   : strncmp_memcmp11_before  ⊑  strncmp_memcmp11_combined := by
  unfold strncmp_memcmp11_before strncmp_memcmp11_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp12_combined := [llvmfunc|
  llvm.func @strncmp_memcmp12(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp12   : strncmp_memcmp12_before  ⊑  strncmp_memcmp12_combined := by
  unfold strncmp_memcmp12_before strncmp_memcmp12_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp13_combined := [llvmfunc|
  llvm.func @strncmp_memcmp13(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("abc\00de\00\00") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @abc : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp13   : strncmp_memcmp13_before  ⊑  strncmp_memcmp13_combined := by
  unfold strncmp_memcmp13_before strncmp_memcmp13_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp14_combined := [llvmfunc|
  llvm.func @strncmp_memcmp14(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("abc\00de\00\00") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @abc : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @memcmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp14   : strncmp_memcmp14_before  ⊑  strncmp_memcmp14_combined := by
  unfold strncmp_memcmp14_before strncmp_memcmp14_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp_bad_combined := [llvmfunc|
  llvm.func @strcmp_memcmp_bad(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "sgt" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_strcmp_memcmp_bad   : strcmp_memcmp_bad_before  ⊑  strcmp_memcmp_bad_combined := by
  unfold strcmp_memcmp_bad_before strcmp_memcmp_bad_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp_bad2_combined := [llvmfunc|
  llvm.func @strcmp_memcmp_bad2(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "slt" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_strcmp_memcmp_bad2   : strcmp_memcmp_bad2_before  ⊑  strcmp_memcmp_bad2_combined := by
  unfold strcmp_memcmp_bad2_before strcmp_memcmp_bad2_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp_bad3_combined := [llvmfunc|
  llvm.func @strcmp_memcmp_bad3(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_strcmp_memcmp_bad3   : strcmp_memcmp_bad3_before  ⊑  strcmp_memcmp_bad3_combined := by
  unfold strcmp_memcmp_bad3_before strcmp_memcmp_bad3_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp_bad4_combined := [llvmfunc|
  llvm.func @strcmp_memcmp_bad4(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_strcmp_memcmp_bad4   : strcmp_memcmp_bad4_before  ⊑  strcmp_memcmp_bad4_combined := by
  unfold strcmp_memcmp_bad4_before strcmp_memcmp_bad4_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp_bad5_combined := [llvmfunc|
  llvm.func @strcmp_memcmp_bad5(%arg0: !llvm.ptr {llvm.dereferenceable = 3 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_strcmp_memcmp_bad5   : strcmp_memcmp_bad5_before  ⊑  strcmp_memcmp_bad5_combined := by
  unfold strcmp_memcmp_bad5_before strcmp_memcmp_bad5_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp_bad6_combined := [llvmfunc|
  llvm.func @strcmp_memcmp_bad6(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strcmp(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_strcmp_memcmp_bad6   : strcmp_memcmp_bad6_before  ⊑  strcmp_memcmp_bad6_combined := by
  unfold strcmp_memcmp_bad6_before strcmp_memcmp_bad6_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp_bad7_combined := [llvmfunc|
  llvm.func @strcmp_memcmp_bad7(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_strcmp_memcmp_bad7   : strcmp_memcmp_bad7_before  ⊑  strcmp_memcmp_bad7_combined := by
  unfold strcmp_memcmp_bad7_before strcmp_memcmp_bad7_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp_bad8_combined := [llvmfunc|
  llvm.func @strcmp_memcmp_bad8(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %2 : i32
  }]

theorem inst_combine_strcmp_memcmp_bad8   : strcmp_memcmp_bad8_before  ⊑  strcmp_memcmp_bad8_combined := by
  unfold strcmp_memcmp_bad8_before strcmp_memcmp_bad8_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp_bad_combined := [llvmfunc|
  llvm.func @strncmp_memcmp_bad(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "sgt" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp_bad   : strncmp_memcmp_bad_before  ⊑  strncmp_memcmp_bad_combined := by
  unfold strncmp_memcmp_bad_before strncmp_memcmp_bad_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp_bad1_combined := [llvmfunc|
  llvm.func @strncmp_memcmp_bad1(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "slt" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp_bad1   : strncmp_memcmp_bad1_before  ⊑  strncmp_memcmp_bad1_combined := by
  unfold strncmp_memcmp_bad1_before strncmp_memcmp_bad1_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp_bad2_combined := [llvmfunc|
  llvm.func @strncmp_memcmp_bad2(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}, %arg1: i64) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.call @strncmp(%1, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %4 = llvm.icmp "slt" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_strncmp_memcmp_bad2   : strncmp_memcmp_bad2_before  ⊑  strncmp_memcmp_bad2_combined := by
  unfold strncmp_memcmp_bad2_before strncmp_memcmp_bad2_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp_bad3_combined := [llvmfunc|
  llvm.func @strncmp_memcmp_bad3(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%1, %arg0, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %5 = llvm.icmp "eq" %4, %3 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_strncmp_memcmp_bad3   : strncmp_memcmp_bad3_before  ⊑  strncmp_memcmp_bad3_combined := by
  unfold strncmp_memcmp_bad3_before strncmp_memcmp_bad3_combined
  simp_alive_peephole
  sorry
def strncmp_memcmp_bad4_combined := [llvmfunc|
  llvm.func @strncmp_memcmp_bad4(%arg0: !llvm.ptr {llvm.dereferenceable = 4 : i64}) -> i32 attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.call @use(%4) : (i32) -> ()
    llvm.return %3 : i32
  }]

theorem inst_combine_strncmp_memcmp_bad4   : strncmp_memcmp_bad4_before  ⊑  strncmp_memcmp_bad4_combined := by
  unfold strncmp_memcmp_bad4_before strncmp_memcmp_bad4_combined
  simp_alive_peephole
  sorry
def strcmp_memcmp_msan_combined := [llvmfunc|
  llvm.func @strcmp_memcmp_msan(%arg0: !llvm.ptr {llvm.dereferenceable = 12 : i64}) -> i32 attributes {passthrough = ["sanitize_memory"]} {
    %0 = llvm.mlir.constant("key\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @key : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strcmp(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_strcmp_memcmp_msan   : strcmp_memcmp_msan_before  ⊑  strcmp_memcmp_msan_combined := by
  unfold strcmp_memcmp_msan_before strcmp_memcmp_msan_combined
  simp_alive_peephole
  sorry
