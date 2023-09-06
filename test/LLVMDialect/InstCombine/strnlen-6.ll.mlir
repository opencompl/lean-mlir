module  {
  llvm.mlir.global external @ecp() : !llvm.ptr<i8>
  llvm.func @strnlen(!llvm.ptr<i8>, i64) -> i64
  llvm.func @deref_strnlen_ecp_3() -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.addressof @ecp : !llvm.ptr<ptr<i8>>
    %2 = llvm.load %1 : !llvm.ptr<ptr<i8>>
    %3 = llvm.call @strnlen(%2, %0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @deref_strnlen_ecp_nz(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @ecp : !llvm.ptr<ptr<i8>>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.or %arg0, %1  : i64
    %3 = llvm.load %0 : !llvm.ptr<ptr<i8>>
    %4 = llvm.call @strnlen(%3, %2) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @noderef_strnlen_ecp_n(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @ecp : !llvm.ptr<ptr<i8>>
    %1 = llvm.load %0 : !llvm.ptr<ptr<i8>>
    %2 = llvm.call @strnlen(%1, %arg0) : (!llvm.ptr<i8>, i64) -> i64
    llvm.return %2 : i64
  }
}
