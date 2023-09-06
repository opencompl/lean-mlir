module  {
  llvm.func @foo(!llvm.ptr<i8>)
  llvm.func @bar(!llvm.ptr<i8, 1>)
  llvm.func @nonnullAfterBitCast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.bitcast %1 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @foo(%2) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @nonnullAfterSExt(%arg0: i8) {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.inttoptr %3 : i64 to !llvm.ptr<i8>
    llvm.call @foo(%4) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @nonnullAfterZExt(%arg0: i8) {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.inttoptr %3 : i64 to !llvm.ptr<i8>
    llvm.call @foo(%4) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @llvm.assume(i1)
  llvm.func @nonnullAfterInt2Ptr(%arg0: i32, %arg1: i64) {
    %0 = llvm.mlir.constant(100 : i64) : i64
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.sdiv %1, %arg0  : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr<i8>
    llvm.call @foo(%3) : (!llvm.ptr<i8>) -> ()
    %4 = llvm.sdiv %0, %arg1  : i64
    %5 = llvm.inttoptr %4 : i64 to !llvm.ptr<i8>
    llvm.call @foo(%5) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @nonnullAfterPtr2Int() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<i32> to i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr<i8>
    llvm.call @foo(%3) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @maybenullAfterInt2Ptr(%arg0: i128) {
    %0 = llvm.mlir.constant(0 : i128) : i128
    %1 = llvm.icmp "ne" %arg0, %0 : i128
    llvm.call @llvm.assume(%1) : (i1) -> ()
    %2 = llvm.inttoptr %arg0 : i128 to !llvm.ptr<i8>
    llvm.call @foo(%2) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @maybenullAfterPtr2Int() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 : (i32) -> !llvm.ptr<i32>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<i32> to i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr<i8>
    llvm.call @foo(%3) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @maybenullAfterAddrspacecast(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<i8> to !llvm.ptr<i8, 1>
    llvm.call @bar(%0) : (!llvm.ptr<i8, 1>) -> ()
    llvm.call @foo(%arg0) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
}
