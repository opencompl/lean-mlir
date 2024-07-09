module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a11111("\01\01\01\01\01") {addr_space = 0 : i32}
  llvm.mlir.global external constant @a1110111("\01\01\01\00\01\01\01") {addr_space = 0 : i32}
  llvm.func @memrchr(!llvm.ptr, i32, i64) -> !llvm.ptr
  llvm.func @fold_memrchr_a11111_c_5(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\01\01") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a11111 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a11111_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\01\01") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a11111 : !llvm.ptr
    %2 = llvm.call @memrchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a1110111_c_3(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @call_memrchr_a1110111_c_4(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @call_memrchr_a1110111_c_7(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @call_memrchr_a1110111_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.call @memrchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
}
