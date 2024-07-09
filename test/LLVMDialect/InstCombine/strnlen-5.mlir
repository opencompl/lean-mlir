module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @ax() {addr_space = 0 : i32} : !llvm.array<0 x i8>
  llvm.mlir.global external @a5() {addr_space = 0 : i32} : !llvm.array<5 x i8>
  llvm.mlir.global external constant @s5("12345\00") {addr_space = 0 : i32}
  llvm.func @strnlen(!llvm.ptr, i64) -> i64
  llvm.func @fold_strnlen_ax_0_eqz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @fold_strnlen_ax_0_gtz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %3 = llvm.icmp "ugt" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @fold_strnlen_ax_1_eqz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %4 = llvm.icmp "eq" %3, %2 : i64
    llvm.return %4 : i1
  }
  llvm.func @fold_strnlen_ax_1_lt1() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @fold_strnlen_ax_1_neqz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %4 = llvm.icmp "ne" %3, %2 : i64
    llvm.return %4 : i1
  }
  llvm.func @fold_strnlen_ax_1_gtz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %4 = llvm.icmp "ugt" %3, %2 : i64
    llvm.return %4 : i1
  }
  llvm.func @fold_strnlen_ax_9_eqz() -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(9 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    %4 = llvm.icmp "eq" %3, %2 : i64
    llvm.return %4 : i1
  }
  llvm.func @call_strnlen_ax_n_eqz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @strnlen(%0, %arg0) : (!llvm.ptr, i64) -> i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @fold_strnlen_ax_nz_eqz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @ax : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.or %arg0, %0  : i64
    %4 = llvm.call @strnlen(%1, %3) : (!llvm.ptr, i64) -> i64
    %5 = llvm.icmp "eq" %4, %2 : i64
    llvm.return %5 : i1
  }
  llvm.func @fold_strnlen_ax_nz_gtz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @ax : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.or %arg0, %0  : i64
    %4 = llvm.call @strnlen(%1, %3) : (!llvm.ptr, i64) -> i64
    %5 = llvm.icmp "ugt" %4, %2 : i64
    llvm.return %5 : i1
  }
  llvm.func @fold_strnlen_a5_pi_nz_eqz(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.or %arg1, %0  : i64
    %4 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr, i64) -> i64
    %6 = llvm.icmp "eq" %5, %2 : i64
    llvm.return %6 : i1
  }
  llvm.func @fold_strnlen_s5_pi_nz_eqz(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %2 = llvm.mlir.addressof @s5 : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.or %arg1, %0  : i64
    %5 = llvm.getelementptr inbounds %2[%3, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    %7 = llvm.icmp "eq" %6, %3 : i64
    llvm.return %7 : i1
  }
  llvm.func @call_strnlen_s5_pi_n_eqz(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %4 = llvm.call @strnlen(%3, %arg1) : (!llvm.ptr, i64) -> i64
    %5 = llvm.icmp "eq" %4, %2 : i64
    llvm.return %5 : i1
  }
}
