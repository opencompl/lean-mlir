module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @sx() {addr_space = 0 : i32} : !llvm.array<0 x i8>
  llvm.mlir.global external constant @a3("123") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s3("123\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s5("12345\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s5_3("12345\00abc\00") {addr_space = 0 : i32}
  llvm.func @strnlen(!llvm.ptr, i64) -> i64
  llvm.func @fold_strnlen_sx_pi_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @sx : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i8>
    %3 = llvm.call @strnlen(%2, %1) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @call_strnlen_sx_pi_n(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.addressof @sx : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.getelementptr inbounds %0[%1, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i8>
    %3 = llvm.call @strnlen(%2, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @call_strnlen_a3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @a3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }
  llvm.func @call_strnlen_a3_pi_3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @a3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }
  llvm.func @fold_strnlen_s3_pi_0(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %4 = llvm.call @strnlen(%3, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @call_strnlen_s5_pi_0(%arg0: i64 {llvm.zeroext}) -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @strnlen(%1, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @fold_strnlen_s5_3_pi_0(%arg0: i64 {llvm.zeroext}) -> i64 {
    %0 = llvm.mlir.constant("12345\00abc\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr, i32, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }
  llvm.func @call_strnlen_s5_3_pi_n(%arg0: i64 {llvm.zeroext}, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00abc\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %4 = llvm.call @strnlen(%3, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @fold_strnlen_a3_n(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @a3 : !llvm.ptr
    %2 = llvm.call @strnlen(%1, %arg0) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @fold_strnlen_s3_n(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.call @strnlen(%1, %arg0) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @fold_strnlen_a3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @a3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }
  llvm.func @fold_strnlen_s3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }
  llvm.func @fold_strnlen_s3_pi_3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }
  llvm.func @fold_strnlen_s3_pi_n(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %4 = llvm.call @strnlen(%3, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @call_strnlen_s5_3_pi_2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00abc\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    llvm.return %5 : i64
  }
}
