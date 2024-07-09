module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @ax() {addr_space = 0 : i32} : !llvm.array<8 x i8>
  llvm.mlir.global external constant @a01230123("01230123") {addr_space = 0 : i32}
  llvm.mlir.global external constant @b01230123("01230123") {addr_space = 0 : i32}
  llvm.mlir.global external constant @c01230129("01230129") {addr_space = 0 : i32}
  llvm.mlir.global external constant @d9123012("9123012") {addr_space = 0 : i32}
  llvm.func @memcmp(!llvm.ptr, !llvm.ptr, i64) -> i32
  llvm.func @fold_memcmp_a_b_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @b01230123 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %9 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %10 = llvm.getelementptr %1[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %11 = llvm.getelementptr %1[%2, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %12 = llvm.getelementptr %1[%2, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %13 = llvm.getelementptr %1[%2, %7] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %14 = llvm.call @memcmp(%8, %1, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %14, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %15 = llvm.call @memcmp(%8, %9, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %16 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %15, %16 {alignment = 4 : i64} : i32, !llvm.ptr
    %17 = llvm.call @memcmp(%8, %10, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %18 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %17, %18 {alignment = 4 : i64} : i32, !llvm.ptr
    %19 = llvm.call @memcmp(%8, %11, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %20 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %19, %20 {alignment = 4 : i64} : i32, !llvm.ptr
    %21 = llvm.call @memcmp(%8, %12, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %22 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %21, %22 {alignment = 4 : i64} : i32, !llvm.ptr
    %23 = llvm.call @memcmp(%8, %13, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %24 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %23, %24 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @call_memcmp_a_ax_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %2 = llvm.mlir.addressof @ax : !llvm.ptr
    %3 = llvm.call @memcmp(%1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %3, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_memcmp_a_c_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("01230129") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @c01230129 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %9 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %10 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %11 = llvm.getelementptr %1[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %12 = llvm.getelementptr %1[%2, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %13 = llvm.getelementptr %1[%2, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %14 = llvm.getelementptr %1[%2, %7] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %15 = llvm.call @memcmp(%9, %1, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %15, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %16 = llvm.call @memcmp(%9, %10, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %17 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %16, %17 {alignment = 4 : i64} : i32, !llvm.ptr
    %18 = llvm.call @memcmp(%9, %11, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %19 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %18, %19 {alignment = 4 : i64} : i32, !llvm.ptr
    %20 = llvm.call @memcmp(%9, %12, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %21 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %20, %21 {alignment = 4 : i64} : i32, !llvm.ptr
    %22 = llvm.call @memcmp(%9, %13, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %23 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %23 {alignment = 4 : i64} : i32, !llvm.ptr
    %24 = llvm.call @memcmp(%9, %13, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %25 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %24, %25 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_memcmp_a_d_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(6 : i64) : i64
    %5 = llvm.mlir.constant("9123012") : !llvm.array<7 x i8>
    %6 = llvm.mlir.addressof @d9123012 : !llvm.ptr
    %7 = llvm.mlir.constant(2 : i64) : i64
    %8 = llvm.mlir.constant(3 : i64) : i64
    %9 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %10 = llvm.getelementptr %1[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %11 = llvm.getelementptr %6[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %12 = llvm.getelementptr %6[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %13 = llvm.call @memcmp(%1, %6, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %13, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %14 = llvm.call @memcmp(%1, %11, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %15 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %14, %15 {alignment = 4 : i64} : i32, !llvm.ptr
    %16 = llvm.call @memcmp(%9, %11, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %17 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %16, %17 {alignment = 4 : i64} : i32, !llvm.ptr
    %18 = llvm.call @memcmp(%10, %12, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %19 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %18, %19 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_memcmp_a_d_nz(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %2 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %3 = llvm.mlir.constant("9123012") : !llvm.array<7 x i8>
    %4 = llvm.mlir.addressof @d9123012 : !llvm.ptr
    %5 = llvm.or %arg1, %0  : i64
    %6 = llvm.call @memcmp(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
