module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a("abcdef\7F") {addr_space = 0 : i32}
  llvm.mlir.global external constant @b("abcdef\80") {addr_space = 0 : i32}
  llvm.func @memcmp(!llvm.ptr, !llvm.ptr, i64) -> i32
  llvm.func @fold_memcmp_cst_cst(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("abcdef\7F") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.mlir.constant(6 : i64) : i64
    %5 = llvm.mlir.constant("abcdef\80") : !llvm.array<7 x i8>
    %6 = llvm.mlir.addressof @b : !llvm.ptr
    %7 = llvm.mlir.constant(2 : i64) : i64
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.mlir.constant(3 : i64) : i64
    %10 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %11 = llvm.getelementptr %1[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %12 = llvm.getelementptr %6[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %13 = llvm.getelementptr %6[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %14 = llvm.call @memcmp(%10, %12, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %14, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %15 = llvm.call @memcmp(%12, %10, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %16 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %15, %16 {alignment = 4 : i64} : i32, !llvm.ptr
    %17 = llvm.call @memcmp(%11, %13, %8) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %18 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %17, %18 {alignment = 4 : i64} : i32, !llvm.ptr
    %19 = llvm.call @memcmp(%13, %11, %8) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %20 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %19, %20 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_memcmp_cst_var(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("abcdef\7F") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.mlir.constant("abcdef\80") : !llvm.array<7 x i8>
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant(2 : i64) : i64
    %8 = llvm.mlir.constant(3 : i64) : i64
    %9 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %10 = llvm.getelementptr %5[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %11 = llvm.call @memcmp(%1, %5, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %11, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %12 = llvm.call @memcmp(%5, %1, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %13 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %12, %13 {alignment = 4 : i64} : i32, !llvm.ptr
    %14 = llvm.call @memcmp(%9, %10, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %15 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %14, %15 {alignment = 4 : i64} : i32, !llvm.ptr
    %16 = llvm.call @memcmp(%10, %9, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %17 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %16, %17 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
