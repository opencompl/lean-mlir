module  {
  llvm.mlir.global private constant @".str"("12\00")
  llvm.mlir.global private constant @".str.1"("0\00")
  llvm.mlir.global private constant @".str.2"("4294967296\00")
  llvm.mlir.global private constant @".str.3"("10000000000000000000000\00")
  llvm.mlir.global private constant @".str.4"("9923372036854775807\00")
  llvm.mlir.global private constant @".str.5"("4994967295\00")
  llvm.mlir.global private constant @".str.6"("499496729\00")
  llvm.mlir.global private constant @".str.7"("4994967295\00")
  llvm.func @strtol(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
  llvm.func @atoi(!llvm.ptr<i8>) -> i32
  llvm.func @atol(!llvm.ptr<i8>) -> i64
  llvm.func @atoll(!llvm.ptr<i8>) -> i64
  llvm.func @strtoll(!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
  llvm.func @strtol_dec() -> i64 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @".str" : !llvm.ptr<array<3 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @strtol(%4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    llvm.return %5 : i64
  }
  llvm.func @strtol_base_zero() -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr<array<3 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strtol(%3, %0, %1) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    llvm.return %4 : i64
  }
  llvm.func @strtol_hex() -> i64 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @".str" : !llvm.ptr<array<3 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @strtol(%4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    llvm.return %5 : i64
  }
  llvm.func @strtol_endptr_not_null(%arg0: !llvm.ptr<ptr<i8>>) -> i64 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr<array<3 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strtol(%3, %arg0, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    llvm.return %4 : i64
  }
  llvm.func @strtol_endptr_maybe_null(%arg0: !llvm.ptr<ptr<i8>>) -> i64 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @".str.1" : !llvm.ptr<array<2 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strtol(%3, %arg0, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    llvm.return %4 : i64
  }
  llvm.func @atoi_test() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr<array<3 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = llvm.call @atoi(%2) : (!llvm.ptr<i8>) -> i32
    llvm.return %3 : i32
  }
  llvm.func @strtol_not_const_str(%arg0: !llvm.ptr<i8>) -> i64 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %2 = llvm.call @strtol(%arg0, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    llvm.return %2 : i64
  }
  llvm.func @atoi_not_const_str(%arg0: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.call @atoi(%arg0) : (!llvm.ptr<i8>) -> i32
    llvm.return %0 : i32
  }
  llvm.func @strtol_not_const_base(%arg0: i32) -> i64 {
    %0 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr<array<3 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = llvm.call @strtol(%3, %0, %arg0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    llvm.return %4 : i64
  }
  llvm.func @strtol_long_int() -> i64 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @".str.2" : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @strtol(%4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    llvm.return %5 : i64
  }
  llvm.func @strtol_big_overflow() -> i64 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.addressof @".str.3" : !llvm.ptr<array<24 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<24 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = llvm.call @strtol(%4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    llvm.return %5 : i64
  }
  llvm.func @atol_test() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @".str.6" : !llvm.ptr<array<10 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<10 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = llvm.call @atol(%2) : (!llvm.ptr<i8>) -> i64
    llvm.return %3 : i64
  }
  llvm.func @atoll_test() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @".str.5" : !llvm.ptr<array<11 x i8>>
    %2 = llvm.getelementptr %1[%0, %0] : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = llvm.call @atoll(%2) : (!llvm.ptr<i8>) -> i64
    llvm.return %3 : i64
  }
  llvm.func @strtoll_test() -> i64 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<ptr<i8>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @".str.7" : !llvm.ptr<array<11 x i8>>
    %4 = llvm.getelementptr %3[%2, %2] : (!llvm.ptr<array<11 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @strtoll(%4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    llvm.return %5 : i64
  }
}
