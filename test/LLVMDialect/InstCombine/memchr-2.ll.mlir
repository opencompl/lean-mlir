module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @ax() {addr_space = 0 : i32} : !llvm.array<0 x i8>
  llvm.mlir.global external constant @a12345("\01\02\03\04\05") {addr_space = 0 : i32}
  llvm.mlir.global external constant @a123f45("\01\02\03\F4\05") {addr_space = 0 : i32}
  llvm.func @memchr(!llvm.ptr, i32, i64) -> !llvm.ptr
  llvm.func @fold_memchr_a12345_6_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.call @memchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @fold_memchr_a12345_4_2() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memchr_a12345_4_3() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memchr_a12345_3_3() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memchr_a12345_3_9() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(9 : i64) : i64
    %4 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memchr_a123f45_500_9() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\F4\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a123f45 : !llvm.ptr
    %2 = llvm.mlir.constant(500 : i32) : i32
    %3 = llvm.mlir.constant(9 : i64) : i64
    %4 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_a12345_3_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call @memchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @fold_a12345_259_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(259 : i32) : i32
    %3 = llvm.call @memchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @call_ax_1_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @memchr(%0, %1, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
}
