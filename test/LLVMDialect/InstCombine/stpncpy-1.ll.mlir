module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a4("1234") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s4("1234\00") {addr_space = 0 : i32}
  llvm.mlir.global private constant @str("4\00\00\00") {addr_space = 0 : i32, dso_local}
  llvm.mlir.global private constant @str.1("4\00\00\00\00\00\00\00\00\00") {addr_space = 0 : i32, dso_local}
  llvm.mlir.global private constant @str.2("1234\00\00\00\00\00\00") {addr_space = 0 : i32, dso_local}
  llvm.mlir.global private unnamed_addr constant @str.3("4\00\00\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @str.4("4\00\00\00\00\00\00\00\00\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @str.5("1234\00\00\00\00\00\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.func @stpncpy(!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
  llvm.func @sink(!llvm.ptr, !llvm.ptr)
  llvm.func @fold_stpncpy_overlap(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @stpncpy(%arg0, %arg0, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @stpncpy(%arg0, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @call_stpncpy_overlap(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.call @stpncpy(%arg0, %arg0, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @stpncpy(%arg0, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    %4 = llvm.call @stpncpy(%arg0, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @fold_stpncpy_s0(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(9 : i64) : i64
    %8 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %9 = llvm.call @stpncpy(%arg0, %8, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, !llvm.ptr) -> ()
    %10 = llvm.call @stpncpy(%arg0, %8, %5) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    %11 = llvm.call @stpncpy(%arg0, %8, %6) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    %12 = llvm.call @stpncpy(%arg0, %8, %7) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, !llvm.ptr) -> ()
    %13 = llvm.call @stpncpy(%arg0, %8, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @fold_stpncpy_s1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(3 : i64) : i64
    %8 = llvm.mlir.constant(9 : i64) : i64
    %9 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %10 = llvm.call @stpncpy(%arg0, %9, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    %11 = llvm.call @stpncpy(%arg0, %9, %5) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    %12 = llvm.call @stpncpy(%arg0, %9, %6) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, !llvm.ptr) -> ()
    %13 = llvm.call @stpncpy(%arg0, %9, %7) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    %14 = llvm.call @stpncpy(%arg0, %9, %8) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %14) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @fold_stpncpy_s4(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(9 : i64) : i64
    %8 = llvm.call @stpncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %8) : (!llvm.ptr, !llvm.ptr) -> ()
    %9 = llvm.call @stpncpy(%arg0, %1, %3) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, !llvm.ptr) -> ()
    %10 = llvm.call @stpncpy(%arg0, %1, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    %11 = llvm.call @stpncpy(%arg0, %1, %5) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    %12 = llvm.call @stpncpy(%arg0, %1, %6) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, !llvm.ptr) -> ()
    %13 = llvm.call @stpncpy(%arg0, %1, %7) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @call_stpncpy_xx_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("1234") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @a4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %5 = llvm.mlir.addressof @s4 : !llvm.ptr
    %6 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<4 x i8>
    %7 = llvm.call @stpncpy(%arg0, %6, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %7) : (!llvm.ptr, !llvm.ptr) -> ()
    %8 = llvm.call @stpncpy(%arg0, %1, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %8) : (!llvm.ptr, !llvm.ptr) -> ()
    %9 = llvm.getelementptr %5[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %10 = llvm.call @stpncpy(%arg0, %9, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    %11 = llvm.call @stpncpy(%arg0, %5, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @fold_stpncpy_a4(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("1234") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @a4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.constant(9 : i64) : i64
    %9 = llvm.call @stpncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, !llvm.ptr) -> ()
    %10 = llvm.call @stpncpy(%arg0, %1, %3) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    %11 = llvm.call @stpncpy(%arg0, %1, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    %12 = llvm.call @stpncpy(%arg0, %1, %5) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, !llvm.ptr) -> ()
    %13 = llvm.call @stpncpy(%arg0, %1, %6) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    %14 = llvm.call @stpncpy(%arg0, %1, %7) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %14) : (!llvm.ptr, !llvm.ptr) -> ()
    %15 = llvm.call @stpncpy(%arg0, %1, %8) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %15) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @fold_stpncpy_s(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @stpncpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @stpncpy(%arg0, %arg1, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @call_stpncpy_s(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.call @stpncpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    %2 = llvm.call @stpncpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
}
