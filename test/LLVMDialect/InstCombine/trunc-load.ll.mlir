module  {
  llvm.func @truncload_no_deref(%arg0: !llvm.ptr<i64>) -> i32 {
    %0 = llvm.load %arg0 : !llvm.ptr<i64>
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }
  llvm.func @truncload_small_deref(%arg0: !llvm.ptr<i64>) -> i32 {
    %0 = llvm.load %arg0 : !llvm.ptr<i64>
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }
  llvm.func @truncload_deref(%arg0: !llvm.ptr<i64>) -> i32 {
    %0 = llvm.load %arg0 : !llvm.ptr<i64>
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }
  llvm.func @truncload_align(%arg0: !llvm.ptr<i32>) -> i16 {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }
  llvm.func @use(i64)
  llvm.func @truncload_extra_use(%arg0: !llvm.ptr<i64>) -> i32 {
    %0 = llvm.load %arg0 : !llvm.ptr<i64>
    llvm.call @use(%0) : (i64) -> ()
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }
  llvm.func @truncload_type(%arg0: !llvm.ptr<i64>) -> i8 {
    %0 = llvm.load %arg0 : !llvm.ptr<i64>
    %1 = llvm.trunc %0 : i64 to i8
    llvm.return %1 : i8
  }
  llvm.func @truncload_volatile(%arg0: !llvm.ptr<i64>) -> i32 {
    %0 = llvm.load %arg0 : !llvm.ptr<i64>
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }
  llvm.func @truncload_address_space(%arg0: !llvm.ptr<i64, 1>) -> i32 {
    %0 = llvm.load %arg0 : !llvm.ptr<i64, 1>
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }
}
