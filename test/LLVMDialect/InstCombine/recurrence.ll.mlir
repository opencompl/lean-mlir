"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 15 : i64} : () -> i64
    "llvm.br"(%arg0)[^bb1] : (i64) -> ()
  ^bb1(%1: i64):  // 2 preds: ^bb0, ^bb1
    %2 = "llvm.or"(%1, %0) : (i64, i64) -> i64
    "llvm.call"(%2) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.br"(%2)[^bb1] : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_or", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64):  // no predecessors
    "llvm.br"(%arg0)[^bb1] : (i64) -> ()
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = "llvm.or"(%0, %arg1) : (i64, i64) -> i64
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.br"(%1)[^bb1] : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_or2", type = !llvm.func<i64 (i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64):  // no predecessors
    "llvm.br"(%arg0)[^bb1] : (i64) -> ()
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = "llvm.or"(%arg1, %0) : (i64, i64) -> i64
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.br"(%1)[^bb1] : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_or3", type = !llvm.func<i64 (i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: !llvm.ptr<i64>):  // no predecessors
    "llvm.br"(%arg0)[^bb1] : (i64) -> ()
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = "llvm.load"(%arg1) : (!llvm.ptr<i64>) -> i64
    %2 = "llvm.or"(%0, %1) : (i64, i64) -> i64
    "llvm.call"(%2) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.br"(%2)[^bb1] : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_or4", type = !llvm.func<i64 (i64, ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 15 : i64} : () -> i64
    "llvm.br"(%arg0)[^bb1] : (i64) -> ()
  ^bb1(%1: i64):  // 2 preds: ^bb0, ^bb1
    %2 = "llvm.and"(%1, %0) : (i64, i64) -> i64
    "llvm.call"(%2) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.br"(%2)[^bb1] : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_and", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64):  // no predecessors
    "llvm.br"(%arg0)[^bb1] : (i64) -> ()
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = "llvm.and"(%0, %arg1) : (i64, i64) -> i64
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.br"(%1)[^bb1] : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_and2", type = !llvm.func<i64 (i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64):  // no predecessors
    "llvm.br"(%arg0)[^bb1] : (i64) -> ()
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = "llvm.and"(%arg1, %0) : (i64, i64) -> i64
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.br"(%1)[^bb1] : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_and3", type = !llvm.func<i64 (i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: !llvm.ptr<i64>):  // no predecessors
    "llvm.br"(%arg0)[^bb1] : (i64) -> ()
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = "llvm.load"(%arg1) : (!llvm.ptr<i64>) -> i64
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> i64
    "llvm.call"(%2) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i64) -> ()
    "llvm.br"(%2)[^bb1] : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test_and4", type = !llvm.func<i64 (i64, ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
