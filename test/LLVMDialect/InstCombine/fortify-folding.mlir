module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @a(dense<0> : tensor<60xi8>) {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<60 x i8>
  llvm.mlir.global common @b(dense<0> : tensor<60xi8>) {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<60 x i8>
  llvm.mlir.global private constant @".str"("abcdefghijk\00") {addr_space = 0 : i32, dso_local}
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
  }
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
  }
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
  }
  llvm.func @test_mempcpy() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(15 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__mempcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @test_not_mempcpy() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(60 : i64) : i64
    %5 = llvm.mlir.constant(59 : i64) : i64
    %6 = llvm.call @__mempcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @test_mempcpy_tail() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(15 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__mempcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
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
  }
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
  }
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
  }
  llvm.func @test_sprintf() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.call @__sprintf_chk(%2, %3, %4, %5) vararg(!llvm.func<i32 (ptr, i32, i64, ptr, ...)>) : (!llvm.ptr, i32, i64, !llvm.ptr) -> i32
    llvm.return %6 : i32
  }
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
  }
  llvm.func @test_sprintf_tail() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.call @__sprintf_chk(%2, %3, %4, %5) vararg(!llvm.func<i32 (ptr, i32, i64, ptr, ...)>) : (!llvm.ptr, i32, i64, !llvm.ptr) -> i32
    llvm.return %6 : i32
  }
  llvm.func @test_strcat() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.call @__strcat_chk(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @test_not_strcat() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.call @__strcat_chk(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @test_strcat_tail() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.call @__strcat_chk(%2, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @test_strlcat() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__strlcat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @test_not_strlcat() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.call @__strlcat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @test_strlcat_tail() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__strlcat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @test_strncat() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__strncat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @test_not_strncat() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.call @__strncat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @test_strncat_tail() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__strncat_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @test_strlcpy() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__strlcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @test_not_strlcpy() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.call @__strlcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @test_strlcpy_tail() -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(22 : i64) : i64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.call @__strlcpy_chk(%2, %3, %4, %5) : (!llvm.ptr, !llvm.ptr, i64, i64) -> i64
    llvm.return %6 : i64
  }
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
  }
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
  }
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
  }
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
  }
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
  }
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
  }
  llvm.func @__mempcpy_chk(!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
  llvm.func @__memccpy_chk(!llvm.ptr, !llvm.ptr, i32, i64, i64) -> !llvm.ptr
  llvm.func @__snprintf_chk(!llvm.ptr, i64, i32, i64, !llvm.ptr, ...) -> i32
  llvm.func @__sprintf_chk(!llvm.ptr, i32, i64, !llvm.ptr, ...) -> i32
  llvm.func @__strcat_chk(!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
  llvm.func @__strlcat_chk(!llvm.ptr, !llvm.ptr, i64, i64) -> i64
  llvm.func @__strncat_chk(!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
  llvm.func @__strlcpy_chk(!llvm.ptr, !llvm.ptr, i64, i64) -> i64
  llvm.func @__vsnprintf_chk(!llvm.ptr, i64, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
  llvm.func @__vsprintf_chk(!llvm.ptr, i32, i64, !llvm.ptr, !llvm.ptr) -> i32
}
