module  {
  llvm.func @blah(%arg0: !llvm.ptr<i16>) {
    %0 = llvm.mlir.addressof @objc_msgSend_stret : !llvm.ptr<func<ptr<i8> (ptr<i8>, ptr<i8>, ...)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<ptr<i8> (ptr<i8>, ptr<i8>, ...)>> to !llvm.ptr<func<void (ptr<i16>)>>
    llvm.call %1(%arg0) : (!llvm.ptr<i16>) -> ()
    llvm.return
  }
  llvm.func @objc_msgSend_stret(!llvm.ptr<i8>, !llvm.ptr<i8>, ...) -> !llvm.ptr<i8>
}
