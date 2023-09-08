"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "\01??2@YAPEAX_K@Z", type = !llvm.func<ptr<i8> (i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "\01??3@YAXPEAX@Z", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %1 = "llvm.call"(%0) {callee = @"\01??2@YAPEAX_K@Z", fastmathFlags = #llvm.fastmath<>} : (i64) -> !llvm.ptr<i8>
    "llvm.call"(%1) {callee = @"\01??3@YAXPEAX@Z", fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test9", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
