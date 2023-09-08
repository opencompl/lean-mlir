"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "Unknown", type = i128} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<array<1024 x i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = false} : () -> i1
    %5 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %6 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %7 = "llvm.getelementptr"(%arg0, %6, %6) : (!llvm.ptr<array<1024 x i8>>, i32, i32) -> !llvm.ptr<i8>
    "llvm.call"(%7, %5, %6, %4) {callee = @llvm.memset.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    "llvm.call"(%7, %5, %3, %4) {callee = @llvm.memset.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    "llvm.call"(%7, %5, %2, %4) {callee = @llvm.memset.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    "llvm.call"(%7, %5, %1, %4) {callee = @llvm.memset.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    "llvm.call"(%7, %5, %0, %4) {callee = @llvm.memset.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 (ptr<array<1024 x i8>>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %3 = "llvm.mlir.addressof"() {global_name = @Unknown} : () -> !llvm.ptr<i128>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<i128>) -> !llvm.ptr<i8>
    "llvm.call"(%4, %2, %1, %0) {callee = @llvm.memset.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "memset_to_constant", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.undef"() : () -> i8
    "llvm.call"(%arg0, %2, %1, %0) {callee = @llvm.memset.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "memset_undef", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.undef"() : () -> i8
    "llvm.call"(%arg0, %2, %1, %0) {callee = @llvm.memset.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "memset_undef_volatile", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.undef"() : () -> i8
    "llvm.call"(%arg0, %2, %1, %0) {callee = @llvm.memset.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "memset_poison", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.mlir.undef"() : () -> i8
    "llvm.call"(%arg0, %2, %1, %0) {callee = @llvm.memset.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "memset_poison_volatile", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memset.p0i8.i32", type = !llvm.func<void (ptr<i8>, i8, i32, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
