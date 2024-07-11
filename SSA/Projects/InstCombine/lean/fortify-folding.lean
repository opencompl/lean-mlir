import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fortify-folding
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_memccpy_before := [llvmfunc|
  llvm.func @test_memccpy() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(60 : i64) : i64
    %6 = llvm.mlir.constant(-1 : i64) : i64
    %7 = llvm.call @__memccpy_chk(%2, %3, %4, %5, %6) : (!llvm.ptr, !llvm.ptr, i32, i64, i64) -> !llvm.ptr
    llvm.return %7 : !llvm.ptr
  }]

def test_not_memccpy_before := [llvmfunc|
  llvm.func @test_not_memccpy() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(60 : i64) : i64
    %6 = llvm.mlir.constant(59 : i64) : i64
    %7 = llvm.call @__memccpy_chk(%2, %3, %4, %5, %6) : (!llvm.ptr, !llvm.ptr, i32, i64, i64) -> !llvm.ptr
    llvm.return %7 : !llvm.ptr
  }]

def test_memccpy_tail_before := [llvmfunc|
  llvm.func @test_memccpy_tail() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(60 : i64) : i64
    %6 = llvm.mlir.constant(-1 : i64) : i64
    %7 = llvm.call @__memccpy_chk(%2, %3, %4, %5, %6) : (!llvm.ptr, !llvm.ptr, i32, i64, i64) -> !llvm.ptr
    llvm.return %7 : !llvm.ptr
  }]

def test_mempcpy_before := [llvmfunc|
  llvm.func @test_mempcpy() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(15 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__mempcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

def test_not_mempcpy_before := [llvmfunc|
  llvm.func @test_not_mempcpy() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(60 : i64) : i64
    %5 = llvm.mlir.constant(59 : i64) : i64
    %6 = llvm.call @__mempcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

def test_mempcpy_tail_before := [llvmfunc|
  llvm.func @test_mempcpy_tail() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(15 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__mempcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

def test_snprintf_before := [llvmfunc|
  llvm.func @test_snprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(60 : i64) : i64
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.mlir.addressof @b : !llvm.ptr
    %7 = llvm.call @__snprintf_chk(%2, %3, %4, %5, %6) vararg(!llvm.func<i32 (ptr, i64, i32, i64, ptr, ...)>) : (!llvm.ptr, i64, i32, i64, !llvm.ptr) -> i32
    llvm.return %7 : i32
  }]

def test_not_snprintf_before := [llvmfunc|
  llvm.func @test_not_snprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(60 : i64) : i64
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(59 : i64) : i64
    %6 = llvm.mlir.addressof @b : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.mlir.constant(-1 : i64) : i64
    %9 = llvm.call @__snprintf_chk(%2, %3, %4, %5, %6) vararg(!llvm.func<i32 (ptr, i64, i32, i64, ptr, ...)>) : (!llvm.ptr, i64, i32, i64, !llvm.ptr) -> i32
    %10 = llvm.call @__snprintf_chk(%2, %3, %7, %8, %6) vararg(!llvm.func<i32 (ptr, i64, i32, i64, ptr, ...)>) : (!llvm.ptr, i64, i32, i64, !llvm.ptr) -> i32
    llvm.return %9 : i32
  }]

def test_snprintf_tail_before := [llvmfunc|
  llvm.func @test_snprintf_tail() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(60 : i64) : i64
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.mlir.addressof @b : !llvm.ptr
    %7 = llvm.call @__snprintf_chk(%2, %3, %4, %5, %6) vararg(!llvm.func<i32 (ptr, i64, i32, i64, ptr, ...)>) : (!llvm.ptr, i64, i32, i64, !llvm.ptr) -> i32
    llvm.return %7 : i32
  }]

def test_sprintf_before := [llvmfunc|
  llvm.func @test_sprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.call @__sprintf_chk(%2, %3, %4, %5) vararg(!llvm.func<i32 (ptr, i32, i64, ptr, ...)>) : (!llvm.ptr, i32, i64, !llvm.ptr) -> i32
    llvm.return %6 : i32
  }]

def test_not_sprintf_before := [llvmfunc|
  llvm.func @test_not_sprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(59 : i64) : i64
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(-1 : i64) : i64
    %8 = llvm.call @__sprintf_chk(%2, %3, %4, %5) vararg(!llvm.func<i32 (ptr, i32, i64, ptr, ...)>) : (!llvm.ptr, i32, i64, !llvm.ptr) -> i32
    %9 = llvm.call @__sprintf_chk(%2, %6, %7, %5) vararg(!llvm.func<i32 (ptr, i32, i64, ptr, ...)>) : (!llvm.ptr, i32, i64, !llvm.ptr) -> i32
    llvm.return %8 : i32
  }]

def test_sprintf_tail_before := [llvmfunc|
  llvm.func @test_sprintf_tail() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.call @__sprintf_chk(%2, %3, %4, %5) vararg(!llvm.func<i32 (ptr, i32, i64, ptr, ...)>) : (!llvm.ptr, i32, i64, !llvm.ptr) -> i32
    llvm.return %6 : i32
  }]

def test_strcat_before := [llvmfunc|
  llvm.func @test_strcat() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.call @__strcat_chk(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def test_not_strcat_before := [llvmfunc|
  llvm.func @test_not_strcat() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.call @__strcat_chk(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def test_strcat_tail_before := [llvmfunc|
  llvm.func @test_strcat_tail() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.call @__strcat_chk(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def test_strlcat_before := [llvmfunc|
  llvm.func @test_strlcat() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__strlcat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }]

def test_not_strlcat_before := [llvmfunc|
  llvm.func @test_not_strlcat() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.call @__strlcat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }]

def test_strlcat_tail_before := [llvmfunc|
  llvm.func @test_strlcat_tail() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__strlcat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }]

def test_strncat_before := [llvmfunc|
  llvm.func @test_strncat() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__strncat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

def test_not_strncat_before := [llvmfunc|
  llvm.func @test_not_strncat() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.call @__strncat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

def test_strncat_tail_before := [llvmfunc|
  llvm.func @test_strncat_tail() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__strncat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

def test_strlcpy_before := [llvmfunc|
  llvm.func @test_strlcpy() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__strlcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }]

def test_not_strlcpy_before := [llvmfunc|
  llvm.func @test_not_strlcpy() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.call @__strlcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }]

def test_strlcpy_tail_before := [llvmfunc|
  llvm.func @test_strlcpy_tail() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__strlcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }]

def test_vsnprintf_before := [llvmfunc|
  llvm.func @test_vsnprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(4 : i64) : i64
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.mlir.addressof @b : !llvm.ptr
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.call @__vsnprintf_chk(%2, %3, %4, %5, %6, %7) : (!llvm.ptr, i64, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %8 : i32
  }]

def test_not_vsnprintf_before := [llvmfunc|
  llvm.func @test_not_vsnprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(4 : i64) : i64
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.addressof @b : !llvm.ptr
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.mlir.constant(-1 : i64) : i64
    %10 = llvm.call @__vsnprintf_chk(%2, %3, %4, %5, %6, %7) : (!llvm.ptr, i64, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
    %11 = llvm.call @__vsnprintf_chk(%2, %3, %8, %9, %6, %7) : (!llvm.ptr, i64, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %10 : i32
  }]

def test_vsnprintf_tail_before := [llvmfunc|
  llvm.func @test_vsnprintf_tail() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(4 : i64) : i64
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.mlir.addressof @b : !llvm.ptr
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.call @__vsnprintf_chk(%2, %3, %4, %5, %6, %7) : (!llvm.ptr, i64, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %8 : i32
  }]

def test_vsprintf_before := [llvmfunc|
  llvm.func @test_vsprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.call @__vsprintf_chk(%2, %3, %4, %5, %6) : (!llvm.ptr, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %7 : i32
  }]

def test_not_vsprintf_before := [llvmfunc|
  llvm.func @test_not_vsprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.mlir.constant(-1 : i64) : i64
    %9 = llvm.call @__vsprintf_chk(%2, %3, %4, %5, %6) : (!llvm.ptr, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
    %10 = llvm.call @__vsprintf_chk(%2, %7, %8, %5, %6) : (!llvm.ptr, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %9 : i32
  }]

def test_vsprintf_tail_before := [llvmfunc|
  llvm.func @test_vsprintf_tail() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.call @__vsprintf_chk(%2, %3, %4, %5, %6) : (!llvm.ptr, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %7 : i32
  }]

def test_memccpy_combined := [llvmfunc|
  llvm.func @test_memccpy() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(60 : i64) : i64
    %6 = llvm.call @memccpy(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_test_memccpy   : test_memccpy_before  ⊑  test_memccpy_combined := by
  unfold test_memccpy_before test_memccpy_combined
  simp_alive_peephole
  sorry
def test_not_memccpy_combined := [llvmfunc|
  llvm.func @test_not_memccpy() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(60 : i64) : i64
    %6 = llvm.mlir.constant(59 : i64) : i64
    %7 = llvm.call @__memccpy_chk(%2, %3, %4, %5, %6) : (!llvm.ptr, !llvm.ptr, i32, i64, i64) -> !llvm.ptr
    llvm.return %7 : !llvm.ptr
  }]

theorem inst_combine_test_not_memccpy   : test_not_memccpy_before  ⊑  test_not_memccpy_combined := by
  unfold test_not_memccpy_before test_not_memccpy_combined
  simp_alive_peephole
  sorry
def test_memccpy_tail_combined := [llvmfunc|
  llvm.func @test_memccpy_tail() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(60 : i64) : i64
    %6 = llvm.call @memccpy(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_test_memccpy_tail   : test_memccpy_tail_before  ⊑  test_memccpy_tail_combined := by
  unfold test_memccpy_tail_before test_memccpy_tail_combined
  simp_alive_peephole
  sorry
def test_mempcpy_combined := [llvmfunc|
  llvm.func @test_mempcpy() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(15 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.getelementptr inbounds %2[%5, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<60 x i8>
    "llvm.intr.memcpy"(%2, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_test_mempcpy   : test_mempcpy_before  ⊑  test_mempcpy_combined := by
  unfold test_mempcpy_before test_mempcpy_combined
  simp_alive_peephole
  sorry
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_test_mempcpy   : test_mempcpy_before  ⊑  test_mempcpy_combined := by
  unfold test_mempcpy_before test_mempcpy_combined
  simp_alive_peephole
  sorry
def test_not_mempcpy_combined := [llvmfunc|
  llvm.func @test_not_mempcpy() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(60 : i64) : i64
    %5 = llvm.mlir.constant(59 : i64) : i64
    %6 = llvm.call @__mempcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_test_not_mempcpy   : test_not_mempcpy_before  ⊑  test_not_mempcpy_combined := by
  unfold test_not_mempcpy_before test_not_mempcpy_combined
  simp_alive_peephole
  sorry
def test_mempcpy_tail_combined := [llvmfunc|
  llvm.func @test_mempcpy_tail() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(15 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.getelementptr inbounds %2[%5, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<60 x i8>
    "llvm.intr.memcpy"(%2, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_test_mempcpy_tail   : test_mempcpy_tail_before  ⊑  test_mempcpy_tail_combined := by
  unfold test_mempcpy_tail_before test_mempcpy_tail_combined
  simp_alive_peephole
  sorry
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_test_mempcpy_tail   : test_mempcpy_tail_before  ⊑  test_mempcpy_tail_combined := by
  unfold test_mempcpy_tail_before test_mempcpy_tail_combined
  simp_alive_peephole
  sorry
def test_snprintf_combined := [llvmfunc|
  llvm.func @test_snprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(60 : i64) : i64
    %4 = llvm.mlir.addressof @b : !llvm.ptr
    %5 = llvm.call @snprintf(%2, %3, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test_snprintf   : test_snprintf_before  ⊑  test_snprintf_combined := by
  unfold test_snprintf_before test_snprintf_combined
  simp_alive_peephole
  sorry
def test_not_snprintf_combined := [llvmfunc|
  llvm.func @test_not_snprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(60 : i64) : i64
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(59 : i64) : i64
    %6 = llvm.mlir.addressof @b : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.mlir.constant(-1 : i64) : i64
    %9 = llvm.call @__snprintf_chk(%2, %3, %4, %5, %6) vararg(!llvm.func<i32 (ptr, i64, i32, i64, ptr, ...)>) : (!llvm.ptr, i64, i32, i64, !llvm.ptr) -> i32
    %10 = llvm.call @__snprintf_chk(%2, %3, %7, %8, %6) vararg(!llvm.func<i32 (ptr, i64, i32, i64, ptr, ...)>) : (!llvm.ptr, i64, i32, i64, !llvm.ptr) -> i32
    llvm.return %9 : i32
  }]

theorem inst_combine_test_not_snprintf   : test_not_snprintf_before  ⊑  test_not_snprintf_combined := by
  unfold test_not_snprintf_before test_not_snprintf_combined
  simp_alive_peephole
  sorry
def test_snprintf_tail_combined := [llvmfunc|
  llvm.func @test_snprintf_tail() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(60 : i64) : i64
    %4 = llvm.mlir.addressof @b : !llvm.ptr
    %5 = llvm.call @snprintf(%2, %3, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test_snprintf_tail   : test_snprintf_tail_before  ⊑  test_snprintf_tail_combined := by
  unfold test_snprintf_tail_before test_snprintf_tail_combined
  simp_alive_peephole
  sorry
def test_sprintf_combined := [llvmfunc|
  llvm.func @test_sprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.call @sprintf(%2, %3) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_sprintf   : test_sprintf_before  ⊑  test_sprintf_combined := by
  unfold test_sprintf_before test_sprintf_combined
  simp_alive_peephole
  sorry
def test_not_sprintf_combined := [llvmfunc|
  llvm.func @test_not_sprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(59 : i64) : i64
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(-1 : i64) : i64
    %8 = llvm.call @__sprintf_chk(%2, %3, %4, %5) vararg(!llvm.func<i32 (ptr, i32, i64, ptr, ...)>) : (!llvm.ptr, i32, i64, !llvm.ptr) -> i32
    %9 = llvm.call @__sprintf_chk(%2, %6, %7, %5) vararg(!llvm.func<i32 (ptr, i32, i64, ptr, ...)>) : (!llvm.ptr, i32, i64, !llvm.ptr) -> i32
    llvm.return %8 : i32
  }]

theorem inst_combine_test_not_sprintf   : test_not_sprintf_before  ⊑  test_not_sprintf_combined := by
  unfold test_not_sprintf_before test_not_sprintf_combined
  simp_alive_peephole
  sorry
def test_sprintf_tail_combined := [llvmfunc|
  llvm.func @test_sprintf_tail() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.call @sprintf(%2, %3) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_sprintf_tail   : test_sprintf_tail_before  ⊑  test_sprintf_tail_combined := by
  unfold test_sprintf_tail_before test_sprintf_tail_combined
  simp_alive_peephole
  sorry
def test_strcat_combined := [llvmfunc|
  llvm.func @test_strcat() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.call @strcat(%2, %3) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test_strcat   : test_strcat_before  ⊑  test_strcat_combined := by
  unfold test_strcat_before test_strcat_combined
  simp_alive_peephole
  sorry
def test_not_strcat_combined := [llvmfunc|
  llvm.func @test_not_strcat() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.call @__strcat_chk(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_test_not_strcat   : test_not_strcat_before  ⊑  test_not_strcat_combined := by
  unfold test_not_strcat_before test_not_strcat_combined
  simp_alive_peephole
  sorry
def test_strcat_tail_combined := [llvmfunc|
  llvm.func @test_strcat_tail() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.call @strcat(%2, %3) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test_strcat_tail   : test_strcat_tail_before  ⊑  test_strcat_tail_combined := by
  unfold test_strcat_tail_before test_strcat_tail_combined
  simp_alive_peephole
  sorry
def test_strlcat_combined := [llvmfunc|
  llvm.func @test_strlcat() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.call @strlcat(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_strlcat   : test_strlcat_before  ⊑  test_strlcat_combined := by
  unfold test_strlcat_before test_strlcat_combined
  simp_alive_peephole
  sorry
def test_not_strlcat_combined := [llvmfunc|
  llvm.func @test_not_strlcat() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.call @__strlcat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }]

theorem inst_combine_test_not_strlcat   : test_not_strlcat_before  ⊑  test_not_strlcat_combined := by
  unfold test_not_strlcat_before test_not_strlcat_combined
  simp_alive_peephole
  sorry
def test_strlcat_tail_combined := [llvmfunc|
  llvm.func @test_strlcat_tail() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.call @strlcat(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_strlcat_tail   : test_strlcat_tail_before  ⊑  test_strlcat_tail_combined := by
  unfold test_strlcat_tail_before test_strlcat_tail_combined
  simp_alive_peephole
  sorry
def test_strncat_combined := [llvmfunc|
  llvm.func @test_strncat() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.call @strncat(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test_strncat   : test_strncat_before  ⊑  test_strncat_combined := by
  unfold test_strncat_before test_strncat_combined
  simp_alive_peephole
  sorry
def test_not_strncat_combined := [llvmfunc|
  llvm.func @test_not_strncat() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.call @__strncat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_test_not_strncat   : test_not_strncat_before  ⊑  test_not_strncat_combined := by
  unfold test_not_strncat_before test_not_strncat_combined
  simp_alive_peephole
  sorry
def test_strncat_tail_combined := [llvmfunc|
  llvm.func @test_strncat_tail() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.call @strncat(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test_strncat_tail   : test_strncat_tail_before  ⊑  test_strncat_tail_combined := by
  unfold test_strncat_tail_before test_strncat_tail_combined
  simp_alive_peephole
  sorry
def test_strlcpy_combined := [llvmfunc|
  llvm.func @test_strlcpy() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.call @strlcpy(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_strlcpy   : test_strlcpy_before  ⊑  test_strlcpy_combined := by
  unfold test_strlcpy_before test_strlcpy_combined
  simp_alive_peephole
  sorry
def test_not_strlcpy_combined := [llvmfunc|
  llvm.func @test_not_strlcpy() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.call @__strlcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }]

theorem inst_combine_test_not_strlcpy   : test_not_strlcpy_before  ⊑  test_not_strlcpy_combined := by
  unfold test_not_strlcpy_before test_not_strlcpy_combined
  simp_alive_peephole
  sorry
def test_strlcpy_tail_combined := [llvmfunc|
  llvm.func @test_strlcpy_tail() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.call @strlcpy(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_strlcpy_tail   : test_strlcpy_tail_before  ⊑  test_strlcpy_tail_combined := by
  unfold test_strlcpy_tail_before test_strlcpy_tail_combined
  simp_alive_peephole
  sorry
def test_vsnprintf_combined := [llvmfunc|
  llvm.func @test_vsnprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(4 : i64) : i64
    %4 = llvm.mlir.addressof @b : !llvm.ptr
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.call @vsnprintf(%2, %3, %4, %5) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test_vsnprintf   : test_vsnprintf_before  ⊑  test_vsnprintf_combined := by
  unfold test_vsnprintf_before test_vsnprintf_combined
  simp_alive_peephole
  sorry
def test_not_vsnprintf_combined := [llvmfunc|
  llvm.func @test_not_vsnprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(4 : i64) : i64
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.addressof @b : !llvm.ptr
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.mlir.constant(-1 : i64) : i64
    %10 = llvm.call @__vsnprintf_chk(%2, %3, %4, %5, %6, %7) : (!llvm.ptr, i64, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
    %11 = llvm.call @__vsnprintf_chk(%2, %3, %8, %9, %6, %7) : (!llvm.ptr, i64, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %10 : i32
  }]

theorem inst_combine_test_not_vsnprintf   : test_not_vsnprintf_before  ⊑  test_not_vsnprintf_combined := by
  unfold test_not_vsnprintf_before test_not_vsnprintf_combined
  simp_alive_peephole
  sorry
def test_vsnprintf_tail_combined := [llvmfunc|
  llvm.func @test_vsnprintf_tail() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(4 : i64) : i64
    %4 = llvm.mlir.addressof @b : !llvm.ptr
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.call @vsnprintf(%2, %3, %4, %5) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test_vsnprintf_tail   : test_vsnprintf_tail_before  ⊑  test_vsnprintf_tail_combined := by
  unfold test_vsnprintf_tail_before test_vsnprintf_tail_combined
  simp_alive_peephole
  sorry
def test_vsprintf_combined := [llvmfunc|
  llvm.func @test_vsprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.call @vsprintf(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test_vsprintf   : test_vsprintf_before  ⊑  test_vsprintf_combined := by
  unfold test_vsprintf_before test_vsprintf_combined
  simp_alive_peephole
  sorry
def test_not_vsprintf_combined := [llvmfunc|
  llvm.func @test_not_vsprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.mlir.constant(-1 : i64) : i64
    %9 = llvm.call @__vsprintf_chk(%2, %3, %4, %5, %6) : (!llvm.ptr, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
    %10 = llvm.call @__vsprintf_chk(%2, %7, %8, %5, %6) : (!llvm.ptr, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %9 : i32
  }]

theorem inst_combine_test_not_vsprintf   : test_not_vsprintf_before  ⊑  test_not_vsprintf_combined := by
  unfold test_not_vsprintf_before test_not_vsprintf_combined
  simp_alive_peephole
  sorry
def test_vsprintf_tail_combined := [llvmfunc|
  llvm.func @test_vsprintf_tail() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.call @vsprintf(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test_vsprintf_tail   : test_vsprintf_tail_before  ⊑  test_vsprintf_tail_combined := by
  unfold test_vsprintf_tail_before test_vsprintf_tail_combined
  simp_alive_peephole
  sorry
