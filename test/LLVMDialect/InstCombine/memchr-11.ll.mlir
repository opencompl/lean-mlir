module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a5("12345") {addr_space = 0 : i32}
  llvm.func @memchr(!llvm.ptr, i32, i64) -> !llvm.ptr
  llvm.func @fold_memchr_a_c_5_eq_a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %4 = llvm.icmp "eq" %3, %1 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @fold_memchr_a_c_n_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.call @memchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @call_memchr_api_c_n_eq_a(%arg0: i64, %arg1: i32, %arg2: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %4 = llvm.call @memchr(%3, %arg1, %arg2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "eq" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @fold_memchr_s_c_15_eq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %arg0 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @fold_memchr_s_c_17_neq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(17 : i64) : i64
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %2 = llvm.icmp "ne" %1, %arg0 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @fold_memchr_s_c_nz_eq_s(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.or %arg2, %0  : i64
    %2 = llvm.call @memchr(%arg0, %arg1, %1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %arg0 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @call_memchr_s_c_n_eq_s(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) -> i1 {
    %0 = llvm.call @memchr(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %1 = llvm.icmp "eq" %0, %arg0 : !llvm.ptr
    llvm.return %1 : i1
  }
}
