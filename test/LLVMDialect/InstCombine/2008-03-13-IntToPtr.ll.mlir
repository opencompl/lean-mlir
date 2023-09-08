"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<i8>
    %2 = "llvm.ptrtoint"(%1) : (!llvm.ptr<i8>) -> i32
    %3 = "llvm.add"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.inttoptr"(%3) : (i32) -> !llvm.ptr<i8>
    "llvm.return"(%4) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "bork", type = !llvm.func<ptr<i8> (ptr<ptr<i8>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
