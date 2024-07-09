module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @s4("1234\00567\00") {addr_space = 0 : i32}
  llvm.func @strncpy(!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
  llvm.func @sink(!llvm.ptr, !llvm.ptr)
  llvm.func @fold_strncpy_overlap(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg0, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @call_strncpy_overlap(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg0, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    %4 = llvm.call @strncpy(%arg0, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @fold_strncpy_s0(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("1234\00567\00") : !llvm.array<9 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(9 : i64) : i64
    %8 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<9 x i8>
    %9 = llvm.call @strncpy(%arg0, %8, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, !llvm.ptr) -> ()
    %10 = llvm.call @strncpy(%arg0, %8, %5) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    %11 = llvm.call @strncpy(%arg0, %8, %6) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    %12 = llvm.call @strncpy(%arg0, %8, %7) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, !llvm.ptr) -> ()
    %13 = llvm.call @strncpy(%arg0, %8, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @fold_strncpy_s(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg1, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @call_strncpy_s(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(9 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg1, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    %4 = llvm.call @strncpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
}
