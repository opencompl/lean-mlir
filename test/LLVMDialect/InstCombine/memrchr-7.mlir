module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a5("12345") {addr_space = 0 : i32}
  llvm.func @memrchr(!llvm.ptr, i32, i64) -> !llvm.ptr
  llvm.func @call_memrchr_ap5_c_1_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.getelementptr %1[%4, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %8 = llvm.call @memrchr(%6, %arg0, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %9 = llvm.icmp "eq" %8, %7 : !llvm.ptr
    llvm.return %9 : i1
  }
  llvm.func @call_memrchr_ap5_c_5_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.getelementptr %1[%4, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %8 = llvm.call @memrchr(%6, %arg0, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %9 = llvm.icmp "eq" %8, %7 : !llvm.ptr
    llvm.return %9 : i1
  }
  llvm.func @fold_memrchr_ap5_c_n_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @memrchr(%4, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %6 = llvm.icmp "eq" %5, %1 : !llvm.ptr
    llvm.return %6 : i1
  }
  llvm.func @fold_memrchr_ap5_c_n_eqz(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @memrchr(%5, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %7 = llvm.icmp "eq" %6, %4 : !llvm.ptr
    llvm.return %7 : i1
  }
  llvm.func @fold_memrchr_a_nul_n_eqz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @memrchr(%5, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %7 = llvm.icmp "eq" %6, %4 : !llvm.ptr
    llvm.return %7 : i1
  }
}
