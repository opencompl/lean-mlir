"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<void (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @f} : () -> !llvm.ptr<func<void (i16)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<void (i16)>>) -> !llvm.ptr<func<i32 (i32)>>
    %2 = "llvm.call"(%1, %arg0) : (!llvm.ptr<func<i32 (i32)>>, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "g", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
