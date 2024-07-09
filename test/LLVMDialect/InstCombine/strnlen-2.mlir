module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @s3("123\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s5("12345\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s5_3("12345\00678\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s6("123456\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s7("1234567\00") {addr_space = 0 : i32}
  llvm.func @strnlen(!llvm.ptr, i64) -> i64
  llvm.func @fold_strnlen_s3_s5_0(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @fold_strnlen_s3_s5_1(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @fold_strnlen_s3_s5_3(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @fold_strnlen_s3_s5_4(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @fold_strnlen_s3_s5_5(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @fold_strnlen_s5_6(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(6 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @fold_strnlen_s3_s5_s7_4(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @s5 : !llvm.ptr
    %4 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @s7 : !llvm.ptr
    %6 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.addressof @s3 : !llvm.ptr
    %8 = llvm.mlir.constant(4 : i64) : i64
    %9 = llvm.icmp "eq" %arg0, %0 : i32
    %10 = llvm.icmp "eq" %arg0, %1 : i32
    %11 = llvm.select %10, %3, %5 : i1, !llvm.ptr
    %12 = llvm.select %9, %7, %11 : i1, !llvm.ptr
    %13 = llvm.call @strnlen(%12, %8) : (!llvm.ptr, i64) -> i64
    llvm.return %13 : i64
  }
  llvm.func @fold_strnlen_s3_s5_s7_6(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @s5 : !llvm.ptr
    %4 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @s7 : !llvm.ptr
    %6 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.addressof @s3 : !llvm.ptr
    %8 = llvm.mlir.constant(6 : i64) : i64
    %9 = llvm.icmp "eq" %arg0, %0 : i32
    %10 = llvm.icmp "eq" %arg0, %1 : i32
    %11 = llvm.select %10, %3, %5 : i1, !llvm.ptr
    %12 = llvm.select %9, %7, %11 : i1, !llvm.ptr
    %13 = llvm.call @strnlen(%12, %8) : (!llvm.ptr, i64) -> i64
    llvm.return %13 : i64
  }
  llvm.func @fold_strnlen_s3_s5_s7_8(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @s5 : !llvm.ptr
    %4 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @s7 : !llvm.ptr
    %6 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.addressof @s3 : !llvm.ptr
    %8 = llvm.mlir.constant(8 : i64) : i64
    %9 = llvm.icmp "eq" %arg0, %0 : i32
    %10 = llvm.icmp "eq" %arg0, %1 : i32
    %11 = llvm.select %10, %3, %5 : i1, !llvm.ptr
    %12 = llvm.select %9, %7, %11 : i1, !llvm.ptr
    %13 = llvm.call @strnlen(%12, %8) : (!llvm.ptr, i64) -> i64
    llvm.return %13 : i64
  }
}
