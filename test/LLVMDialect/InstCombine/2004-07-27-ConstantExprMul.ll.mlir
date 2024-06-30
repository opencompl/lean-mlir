"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 4 : i64, sym_name = "p", type = i32, value = 0 : i32} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @p} : () -> !llvm.ptr<i32>
    %1 = "llvm.ptrtoint"(%0) : (!llvm.ptr<i32>) -> i32
    %2 = "llvm.mul"(%arg0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
