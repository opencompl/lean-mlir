"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hello", type = !llvm.array<6 x i8>, value = "hello\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hello_no_nul", type = !llvm.array<5 x i8>, value = "hello"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "__strlen_chk", type = !llvm.func<i32 (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.call"(%arg0, %0) {callee = @__strlen_chk, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "unknown_str_known_object_size", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<6 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @__strlen_chk, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "known_str_known_object_size", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @hello} : () -> !llvm.ptr<array<6 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<6 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @__strlen_chk, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "known_str_too_small_object_size", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @hello_no_nul} : () -> !llvm.ptr<array<5 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<5 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%3, %0) {callee = @__strlen_chk, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "known_str_no_nul", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.call"(%arg0, %0) {callee = @__strlen_chk, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "unknown_str_unknown_object_size", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
