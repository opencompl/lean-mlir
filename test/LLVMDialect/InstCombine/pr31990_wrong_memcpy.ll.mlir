module  {
  llvm.mlir.global external constant @g(-1 : i8) : i8
  llvm.func @foo() {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.addressof @g : !llvm.ptr<i8>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x i8 : (i32) -> !llvm.ptr<i8>
    %4 = llvm.bitcast %3 : !llvm.ptr<i8> to !llvm.ptr<i4>
    llvm.call @bar(%4) : (!llvm.ptr<i4>) -> ()
    %5 = llvm.bitcast %4 : !llvm.ptr<i4> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p0i8.i32(%5, %1, %2, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.call @gaz(%5) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @llvm.memcpy.p0i8.p0i8.i32(!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1)
  llvm.func @bar(!llvm.ptr<i4>)
  llvm.func @gaz(!llvm.ptr<i8>)
}
