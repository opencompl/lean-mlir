"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strchr", type = !llvm.func<ptr<i8> (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<ptr<i8>>
    "llvm.store"(%arg0, %2) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %3 = "llvm.load"(%2) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @strchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "pr43081", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
