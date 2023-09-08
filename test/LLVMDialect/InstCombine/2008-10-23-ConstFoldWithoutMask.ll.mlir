"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.inttoptr"(%0) : (i32) -> !llvm.ptr<i8>
    %2 = "llvm.ptrtoint"(%1) : (!llvm.ptr<i8>) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "tstid", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
