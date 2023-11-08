"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "str", type = !llvm.array<11 x i8>, value = "toulbroc'h\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "malloc", type = !llvm.func<ptr<i8> (i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.objectsize.i64.p0i8", type = !llvm.func<i64 (ptr<i8>, i1, i1, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strdup", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "__strdup", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strndup", type = !llvm.func<ptr<i8> (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "__strndup", type = !llvm.func<ptr<i8> (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @str} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4) {callee = @strdup, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%5, %1, %0, %1) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "check_strdup", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %3 = "llvm.mlir.addressof"() {global_name = @str} : () -> !llvm.ptr<array<11 x i8>>
    %4 = "llvm.getelementptr"(%3, %2, %2) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4) {callee = @__strdup, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%5, %1, %0, %1) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "check_dunder_strdup", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %4 = "llvm.mlir.addressof"() {global_name = @str} : () -> !llvm.ptr<array<11 x i8>>
    %5 = "llvm.getelementptr"(%4, %3, %3) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%5, %2) {callee = @strndup, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %7 = "llvm.call"(%6, %1, %0, %1) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.return"(%7) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "check_strndup", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %4 = "llvm.mlir.addressof"() {global_name = @str} : () -> !llvm.ptr<array<11 x i8>>
    %5 = "llvm.getelementptr"(%4, %3, %3) : (!llvm.ptr<array<11 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %6 = "llvm.call"(%5, %2) {callee = @__strndup, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %7 = "llvm.call"(%6, %1, %0, %1) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.return"(%7) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "check_dunder_strndup", type = !llvm.func<i64 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
