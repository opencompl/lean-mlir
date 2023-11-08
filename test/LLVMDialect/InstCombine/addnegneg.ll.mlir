"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.sub"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.sub"(%0, %arg2) : (i32, i32) -> i32
    %3 = "llvm.add"(%2, %1) : (i32, i32) -> i32
    %4 = "llvm.add"(%3, %arg3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "l", type = !llvm.func<i32 (i32, i32, i32, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
