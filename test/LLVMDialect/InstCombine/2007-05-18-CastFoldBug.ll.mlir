"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i16>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @objc_msgSend_stret} : () -> !llvm.ptr<func<ptr<i8> (ptr<i8>, ptr<i8>, ...)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<ptr<i8> (ptr<i8>, ptr<i8>, ...)>>) -> !llvm.ptr<func<void (ptr<i16>)>>
    "llvm.call"(%1, %arg0) : (!llvm.ptr<func<void (ptr<i16>)>>, !llvm.ptr<i16>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "blah", type = !llvm.func<void (ptr<i16>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "objc_msgSend_stret", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, ...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
