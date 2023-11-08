"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "g", type = i8, value = -1 : i8} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.addressof"() {global_name = @g} : () -> !llvm.ptr<i8>
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i8>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<i8>) -> !llvm.ptr<i4>
    "llvm.call"(%4) {callee = @bar, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i4>) -> ()
    %5 = "llvm.bitcast"(%4) : (!llvm.ptr<i4>) -> !llvm.ptr<i8>
    "llvm.call"(%5, %1, %2, %0) {callee = @llvm.memcpy.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.call"(%5) {callee = @gaz, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memcpy.p0i8.p0i8.i32", type = !llvm.func<void (ptr<i8>, ptr<i8>, i32, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<void (ptr<i4>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "gaz", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
