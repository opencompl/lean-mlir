module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global private unnamed_addr constant @".str"("str\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.1"("%%\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.2"("%c\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.3"("%s\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str.4"(dense<0> : tensor<1xi8>) {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : !llvm.array<1 x i8>
  llvm.func @snprintf(!llvm.ptr, i64, !llvm.ptr, ...) -> i32
  llvm.func @test_not_const_fmt(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @snprintf(%arg0, %0, %arg1) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_not_const_fmt_zero_size_return_value(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @snprintf(%arg0, %0, %arg1) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_not_const_size(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call @snprintf(%arg0, %arg1, %1) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_return_value(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @snprintf(%arg0, %0, %2) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_percentage(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant("%%\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %3 = llvm.call @snprintf(%arg0, %0, %2) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_null_buf_return_value() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @".str" : !llvm.ptr
    %4 = llvm.call @snprintf(%0, %1, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_percentage_return_value() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("%%\00") : !llvm.array<3 x i8>
    %3 = llvm.mlir.addressof @".str.1" : !llvm.ptr
    %4 = llvm.call @snprintf(%0, %1, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_correct_copy(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @snprintf(%arg0, %0, %2) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_char_zero_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.2" : !llvm.ptr
    %3 = llvm.mlir.constant(65 : i32) : i32
    %4 = llvm.call @snprintf(%arg0, %0, %2, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_char_small_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.2" : !llvm.ptr
    %3 = llvm.mlir.constant(65 : i32) : i32
    %4 = llvm.call @snprintf(%arg0, %0, %2, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_char_ok_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.2" : !llvm.ptr
    %3 = llvm.mlir.constant(65 : i32) : i32
    %4 = llvm.call @snprintf(%arg0, %0, %2, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_str_zero_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %3 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.call @snprintf(%arg0, %0, %2, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }
  llvm.func @test_str_small_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %3 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.call @snprintf(%arg0, %0, %2, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }
  llvm.func @test_str_ok_size(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %3 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.call @snprintf(%arg0, %0, %2, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }
  llvm.func @test_str_ok_size_tail(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %3 = llvm.mlir.addressof @".str.4" : !llvm.ptr
    %4 = llvm.call @snprintf(%arg0, %0, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_str_ok_size_musttail(%arg0: !llvm.ptr, %arg1: i64, %arg2: !llvm.ptr, ...) -> i32 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %3 = llvm.mlir.addressof @".str.4" : !llvm.ptr
    %4 = llvm.call @snprintf(%arg0, %0, %3) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_str_ok_size_tail2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %3 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.call @snprintf(%arg0, %0, %2, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }
  llvm.func @test_str_ok_size_musttail2(%arg0: !llvm.ptr, %arg1: i64, %arg2: !llvm.ptr, ...) -> i32 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @".str.3" : !llvm.ptr
    %3 = llvm.mlir.constant("str\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.call @snprintf(%arg0, %0, %2, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }
}
