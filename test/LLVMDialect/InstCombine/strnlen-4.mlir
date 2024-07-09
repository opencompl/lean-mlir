module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @sx() {addr_space = 0 : i32} : !llvm.array<0 x i8>
  llvm.mlir.global external constant @s3("123\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s5("12345\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s5_3("12345\00abc\00") {addr_space = 0 : i32}
  llvm.func @strnlen(!llvm.ptr, i64) -> i64
  llvm.func @fold_strnlen_s3_pi_s5_n(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s5 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %6 = llvm.select %arg0, %5, %4 : i1, !llvm.ptr
    %7 = llvm.call @strnlen(%6, %arg2) : (!llvm.ptr, i64) -> i64
    llvm.return %7 : i64
  }
  llvm.func @call_strnlen_s3_pi_xbounds_s5_n(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s5 : !llvm.ptr
    %5 = llvm.getelementptr %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %6 = llvm.select %arg0, %5, %4 : i1, !llvm.ptr
    %7 = llvm.call @strnlen(%6, %arg2) : (!llvm.ptr, i64) -> i64
    llvm.return %7 : i64
  }
  llvm.func @call_strnlen_s3_pi_sx_n(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @sx : !llvm.ptr
    %4 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %5 = llvm.select %arg0, %4, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %arg2) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @fold_strnlen_s3_s5_pi_n(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @s3 : !llvm.ptr
    %4 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %5 = llvm.call @strnlen(%4, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }
}
