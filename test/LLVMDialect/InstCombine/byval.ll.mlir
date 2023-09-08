"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "add_byval_callee", type = !llvm.func<void (ptr<f64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "add_byval_callee_2", type = !llvm.func<void (ptr<f64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @add_byval_callee} : () -> !llvm.ptr<func<void (ptr<f64>)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<void (ptr<f64>)>>) -> !llvm.ptr<func<void (ptr<i64>)>>
    "llvm.call"(%1, %arg0) : (!llvm.ptr<func<void (ptr<i64>)>>, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "add_byval", type = !llvm.func<void (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @add_byval_callee_2} : () -> !llvm.ptr<func<void (ptr<f64>)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<void (ptr<f64>)>>) -> !llvm.ptr<func<void (ptr<i64>)>>
    "llvm.call"(%1, %arg0) : (!llvm.ptr<func<void (ptr<i64>)>>, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "add_byval_2", type = !llvm.func<void (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> i8
    %1 = "llvm.bitcast"(%arg0) : (!llvm.ptr<i8>) -> !llvm.ptr<struct<"t2", (i8)>>
    "llvm.call"(%0, %1) {callee = @vararg_callee, fastmathFlags = #llvm.fastmath<>} : (i8, !llvm.ptr<struct<"t2", (i8)>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "vararg_byval", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "vararg_callee", type = !llvm.func<void (i8, ...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
