"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.undef"() : () -> !llvm.ptr<ptr<i8>>
    "llvm.br"(%0)[^bb1] : (!llvm.ptr<ptr<i8>>) -> ()
  ^bb1(%1: !llvm.ptr<ptr<i8>>):  // 2 preds: ^bb0, ^bb1
    %2 = "llvm.load"(%1) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<i8>) -> !llvm.ptr<ptr<i8>>
    %4 = "llvm.load"(%3) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    %5 = "llvm.bitcast"(%4) : (!llvm.ptr<i8>) -> !llvm.ptr<ptr<i8>>
    "llvm.br"(%5)[^bb1] : (!llvm.ptr<ptr<i8>>) -> ()
  ^bb2:  // no predecessors
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "mem", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
