module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @ax() {addr_space = 0 : i32} : !llvm.array<0 x i8>
  llvm.mlir.global external constant @a12345("\01\02\03\04\05") {addr_space = 0 : i32}
  llvm.mlir.global external constant @a123123("\01\02\03\01\02\03") {addr_space = 0 : i32}
  llvm.func @memrchr(!llvm.ptr, i32, i64) -> !llvm.ptr
  llvm.func @fold_memrchr_ax_c_0(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @memrchr(%0, %arg0, %1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a12345_3_0() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a12345_1_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a12345_5_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a123123_1_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a123123_3_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_ax_c_1(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @memrchr(%0, %arg0, %1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a12345_5_5() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a12345_5_4() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.constant(4 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a12345_4_5() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a12345p1_1_4() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @memrchr(%5, %3, %4) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a12345p1_2_4() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.call @memrchr(%6, %4, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %7 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a12345_2_5() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a12345_0_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a12345_3_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a12345_5_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a123123_3_5() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a123123_3_6() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a123123_2_6() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a123123_1_6() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a123123_0_6() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @fold_memrchr_a123123_0_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @call_memrchr_a123123_3_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @call_memrchr_a123123_2_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @call_memrchr_a123123_1_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
}
