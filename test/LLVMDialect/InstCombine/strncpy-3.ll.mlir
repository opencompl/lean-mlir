"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "str", type = !llvm.array<2 x i8>, value = "a\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "str2", type = !llvm.array<3 x i8>, value = "abc"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "str3", type = !llvm.array<4 x i8>, value = "abcd"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strncpy", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @str} : () -> !llvm.ptr<array<2 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<2 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3, %0) {callee = @strncpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fill_with_zeros", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @str2} : () -> !llvm.ptr<array<3 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<3 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3, %0) {callee = @strncpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fill_with_zeros2", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @str3} : () -> !llvm.ptr<array<4 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3, %0) {callee = @strncpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fill_with_zeros3", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 128 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @str3} : () -> !llvm.ptr<array<4 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3, %0) {callee = @strncpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fill_with_zeros4", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 129 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @str3} : () -> !llvm.ptr<array<4 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3, %0) {callee = @strncpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "no_simplify", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
