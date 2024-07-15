module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @ax() {addr_space = 0 : i32} : !llvm.array<0 x i8>
  llvm.mlir.global external constant @s5("12345\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s5_3("12345\00xyz") {addr_space = 0 : i32}
  llvm.func @strnlen(!llvm.ptr, i64) -> i64
  llvm.func @no_access_strnlen_p_n(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.call @strnlen(%arg0, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %0 : i64
  }
  llvm.func @access_strnlen_p_2(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.call @strnlen(%arg0, %0) : (!llvm.ptr, i64) -> i64
    llvm.return %1 : i64
  }
  llvm.func @access_strnlen_p_nz(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.or %arg1, %0  : i64
    %2 = llvm.call @strnlen(%arg0, %1) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @fold_strnlen_ax_0() -> i64 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @fold_strnlen_ax_1() -> i64 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @fold_strnlen_s5_0() -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @strnlen(%1, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @fold_strnlen_s5_4() -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @strnlen(%1, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @fold_strnlen_s5_5() -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.call @strnlen(%1, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @fold_strnlen_s5_m1() -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.call @strnlen(%1, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @fold_strnlen_s5_3_p4_5() -> i64 {
    %0 = llvm.mlir.constant("12345\00xyz") : !llvm.array<9 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<9 x i8>
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @fold_strnlen_s5_3_p5_5() -> i64 {
    %0 = llvm.mlir.constant("12345\00xyz") : !llvm.array<9 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<9 x i8>
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @fold_strnlen_s5_3_p6_3() -> i64 {
    %0 = llvm.mlir.constant("12345\00xyz") : !llvm.array<9 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(6 : i32) : i32
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<9 x i8>
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @call_strnlen_s5_3_p6_4() -> i64 {
    %0 = llvm.mlir.constant("12345\00xyz") : !llvm.array<9 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(6 : i32) : i32
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<9 x i8>
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }
}
