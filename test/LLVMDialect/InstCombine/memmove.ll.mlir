module  {
  llvm.mlir.global internal constant @S("panic: restorelist inconsistency\00")
  llvm.mlir.global external constant @h("h\00")
  llvm.mlir.global external constant @hel("hel\00")
  llvm.mlir.global external constant @hello_u("hello_u\00")
  llvm.mlir.global external constant @UnknownConstant() : i128
  llvm.func @test1(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.call @llvm.memmove.p0i8.p0i8.i32(%arg0, %arg1, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
  llvm.func @test2(%arg0: !llvm.ptr<i8>, %arg1: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @S : !llvm.ptr<array<33 x i8>>
    %3 = llvm.getelementptr %2[%1, %1] : (!llvm.ptr<array<33 x i8>>, i32, i32) -> !llvm.ptr<i8>
    llvm.call @llvm.memmove.p0i8.p0i8.i32(%arg0, %3, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
  llvm.func @test3(%arg0: !llvm.ptr<array<1024 x i8>>) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.addressof @hello_u : !llvm.ptr<array<8 x i8>>
    %5 = llvm.mlir.addressof @hel : !llvm.ptr<array<4 x i8>>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.addressof @h : !llvm.ptr<array<2 x i8>>
    %8 = llvm.getelementptr %7[%6, %6] : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %9 = llvm.getelementptr %5[%6, %6] : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %10 = llvm.getelementptr %4[%6, %6] : (!llvm.ptr<array<8 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %11 = llvm.getelementptr %arg0[%6, %6] : (!llvm.ptr<array<1024 x i8>>, i32, i32) -> !llvm.ptr<i8>
    llvm.call @llvm.memmove.p0i8.p0i8.i32(%11, %8, %3, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.call @llvm.memmove.p0i8.p0i8.i32(%11, %9, %1, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.call @llvm.memmove.p0i8.p0i8.i32(%11, %10, %0, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return %6 : i32
  }
  llvm.func @test4(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(100 : i32) : i32
    llvm.call @llvm.memmove.p0i8.p0i8.i32(%arg0, %arg0, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
  llvm.func @memmove_to_constant(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.addressof @UnknownConstant : !llvm.ptr<i128>
    %3 = llvm.bitcast %2 : !llvm.ptr<i128> to !llvm.ptr<i8>
    llvm.call @llvm.memmove.p0i8.p0i8.i32(%3, %arg0, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
  llvm.func @llvm.memmove.p0i8.p0i8.i32(!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1)
}
