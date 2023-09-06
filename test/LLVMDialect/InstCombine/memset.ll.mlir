module  {
  llvm.mlir.global external constant @Unknown() : i128
  llvm.func @test(%arg0: !llvm.ptr<array<1024 x i8>>) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(1 : i8) : i8
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.getelementptr %arg0[%6, %6] : (!llvm.ptr<array<1024 x i8>>, i32, i32) -> !llvm.ptr<i8>
    llvm.call @llvm.memset.p0i8.i32(%7, %5, %6, %4) : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    llvm.call @llvm.memset.p0i8.i32(%7, %5, %3, %4) : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    llvm.call @llvm.memset.p0i8.i32(%7, %5, %2, %4) : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    llvm.call @llvm.memset.p0i8.i32(%7, %5, %1, %4) : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    llvm.call @llvm.memset.p0i8.i32(%7, %5, %0, %4) : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    llvm.return %6 : i32
  }
  llvm.func @memset_to_constant() {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.addressof @Unknown : !llvm.ptr<i128>
    %4 = llvm.bitcast %3 : !llvm.ptr<i128> to !llvm.ptr<i8>
    llvm.call @llvm.memset.p0i8.i32(%4, %2, %1, %0) : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    llvm.return
  }
  llvm.func @memset_undef(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.undef : i8
    llvm.call @llvm.memset.p0i8.i32(%arg0, %2, %1, %0) : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    llvm.return
  }
  llvm.func @memset_undef_volatile(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.undef : i8
    llvm.call @llvm.memset.p0i8.i32(%arg0, %2, %1, %0) : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    llvm.return
  }
  llvm.func @memset_poison(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.undef : i8
    llvm.call @llvm.memset.p0i8.i32(%arg0, %2, %1, %0) : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    llvm.return
  }
  llvm.func @memset_poison_volatile(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.undef : i8
    llvm.call @llvm.memset.p0i8.i32(%arg0, %2, %1, %0) : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    llvm.return
  }
  llvm.func @llvm.memset.p0i8.i32(!llvm.ptr<i8>, i8, i32, i1)
}
