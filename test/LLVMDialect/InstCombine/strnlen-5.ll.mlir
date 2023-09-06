module  {
  llvm.mlir.global external @ax() : !llvm.array<0 x i8>
  llvm.mlir.global external @a5() : !llvm.array<5 x i8>
  llvm.mlir.global external constant @s5("12345\00")
  llvm.func @strnlen(!llvm.ptr<i8>, i64) -> i64
  llvm.func @fold_strnlen_ax_0_eqz() -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @strnlen(%2, %0) : (!llvm.ptr<i8>, i64) -> i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }
  llvm.func @fold_strnlen_ax_0_gtz() -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @strnlen(%2, %0) : (!llvm.ptr<i8>, i64) -> i64
    %4 = llvm.icmp "ugt" %3, %0 : i64
    llvm.return %4 : i1
  }
  llvm.func @fold_strnlen_ax_1_eqz() -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    llvm.return %5 : i1
  }
  llvm.func @fold_strnlen_ax_1_lt1() -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    %5 = llvm.icmp "ult" %4, %0 : i64
    llvm.return %5 : i1
  }
  llvm.func @fold_strnlen_ax_1_neqz() -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    %5 = llvm.icmp "ne" %4, %1 : i64
    llvm.return %5 : i1
  }
  llvm.func @fold_strnlen_ax_1_gtz() -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    %5 = llvm.icmp "ugt" %4, %1 : i64
    llvm.return %5 : i1
  }
  llvm.func @fold_strnlen_ax_9_eqz() -> i1 {
    %0 = llvm.mlir.constant(9 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = llvm.call @strnlen(%3, %0) : (!llvm.ptr<i8>, i64) -> i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    llvm.return %5 : i1
  }
  llvm.func @call_strnlen_ax_n_eqz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @strnlen(%2, %arg0) : (!llvm.ptr<i8>, i64) -> i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }
  llvm.func @fold_strnlen_ax_nz_eqz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.or %arg0, %2  : i64
    %4 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr<i8>, i64) -> i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @fold_strnlen_ax_nz_gtz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @ax : !llvm.ptr<array<0 x i8>>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.or %arg0, %2  : i64
    %4 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<0 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr<i8>, i64) -> i64
    %6 = llvm.icmp "ugt" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @fold_strnlen_a5_pi_nz_eqz(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr<array<5 x i8>>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.or %arg1, %2  : i64
    %4 = llvm.getelementptr %1[%0, %arg0] : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr<i8>, i64) -> i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @fold_strnlen_s5_pi_nz_eqz(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr<array<6 x i8>>
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.or %arg1, %2  : i64
    %4 = llvm.getelementptr %1[%0, %arg0] : (!llvm.ptr<array<6 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @strnlen(%4, %3) : (!llvm.ptr<i8>, i64) -> i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @call_strnlen_s5_pi_n_eqz(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr<array<6 x i8>>
    %2 = llvm.getelementptr %1[%0, %arg0] : (!llvm.ptr<array<6 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %3 = llvm.call @strnlen(%2, %arg1) : (!llvm.ptr<i8>, i64) -> i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }
}
