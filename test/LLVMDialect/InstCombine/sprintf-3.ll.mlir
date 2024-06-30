"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "percent_s", type = !llvm.array<3 x i8>, value = "%s\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sprintf", type = !llvm.func<i32 (ptr<ptr<i8>>, ptr<i32>, ...)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @percent_s} : () -> !llvm.ptr<array<3 x i8>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<array<3 x i8>>) -> !llvm.ptr<i32>
    %2 = "llvm.call"(%arg0, %1, %arg1) {callee = @sprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<ptr<i8>>, !llvm.ptr<i32>, !llvm.ptr<i32>) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "PR51200", type = !llvm.func<i32 (ptr<ptr<i8>>, ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
