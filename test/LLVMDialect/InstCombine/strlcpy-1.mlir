module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @s4("1234\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @a5("12345") {addr_space = 0 : i32}
  llvm.func @strlcpy(!llvm.ptr, !llvm.ptr, i64) -> i64
  llvm.func @sink(!llvm.ptr, i64)
  llvm.func @fold_strlcpy_s0(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(-1 : i64) : i64
    %7 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %8 = llvm.call @strlcpy(%arg0, %7, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %8) : (!llvm.ptr, i64) -> ()
    %9 = llvm.call @strlcpy(%arg0, %7, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, i64) -> ()
    %10 = llvm.call @strlcpy(%arg0, %7, %6) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @fold_strlcpy_s1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(3 : i64) : i64
    %8 = llvm.mlir.constant(-1 : i64) : i64
    %9 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %10 = llvm.call @strlcpy(%arg0, %9, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, i64) -> ()
    %11 = llvm.call @strlcpy(%arg0, %9, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, i64) -> ()
    %12 = llvm.call @strlcpy(%arg0, %9, %6) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, i64) -> ()
    %13 = llvm.call @strlcpy(%arg0, %9, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, i64) -> ()
    %14 = llvm.call @strlcpy(%arg0, %9, %8) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %14) : (!llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @fold_strlcpy_s5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.constant(-1 : i64) : i64
    %9 = llvm.call @strlcpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, i64) -> ()
    %10 = llvm.call @strlcpy(%arg0, %1, %3) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, i64) -> ()
    %11 = llvm.call @strlcpy(%arg0, %1, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, i64) -> ()
    %12 = llvm.call @strlcpy(%arg0, %1, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, i64) -> ()
    %13 = llvm.call @strlcpy(%arg0, %1, %6) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, i64) -> ()
    %14 = llvm.call @strlcpy(%arg0, %1, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %14) : (!llvm.ptr, i64) -> ()
    %15 = llvm.call @strlcpy(%arg0, %1, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %15) : (!llvm.ptr, i64) -> ()
    %16 = llvm.call @strlcpy(%arg0, %1, %8) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %16) : (!llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @fold_strlcpy_s_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @strlcpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, i64) -> ()
    %4 = llvm.call @strlcpy(%arg0, %arg1, %1) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %4) : (!llvm.ptr, i64) -> ()
    %5 = llvm.call @strlcpy(%2, %arg1, %1) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %5) : (!llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @call_strlcpy_s0_n(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @s4 : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.mlir.constant(3 : i32) : i32
    %7 = llvm.call @strlcpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %7) : (!llvm.ptr, i64) -> ()
    %8 = llvm.call @strlcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %8) : (!llvm.ptr, i64) -> ()
    %9 = llvm.or %arg2, %1  : i64
    %10 = llvm.call @strlcpy(%arg0, %arg1, %9) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, i64) -> ()
    %11 = llvm.getelementptr %3[%4, %5] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %12 = llvm.call @strlcpy(%arg0, %11, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, i64) -> ()
    %13 = llvm.getelementptr %3[%4, %6] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %14 = llvm.call @strlcpy(%arg0, %13, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %14) : (!llvm.ptr, i64) -> ()
    %15 = llvm.call @strlcpy(%arg0, %3, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %15) : (!llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @fold_strlcpy_a5(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.mlir.constant(6 : i64) : i64
    %7 = llvm.mlir.constant(9 : i64) : i64
    %8 = llvm.call @strlcpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %8) : (!llvm.ptr, i64) -> ()
    %9 = llvm.call @strlcpy(%arg0, %1, %3) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, i64) -> ()
    %10 = llvm.call @strlcpy(%arg0, %1, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, i64) -> ()
    %11 = llvm.call @strlcpy(%arg0, %1, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, i64) -> ()
    %12 = llvm.call @strlcpy(%arg0, %1, %6) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, i64) -> ()
    %13 = llvm.call @strlcpy(%arg0, %1, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, i64) -> ()
    llvm.return
  }
}
