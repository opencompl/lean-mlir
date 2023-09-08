"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 50 : i64} : () -> i64
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<i8, 4>
    %2 = "llvm.getelementptr"(%1, %0) : (!llvm.ptr<i8, 4>, i64) -> !llvm.ptr<i8, 4>
    "llvm.return"(%2) : (!llvm.ptr<i8, 4>) -> ()
  }) {linkage = 10 : i64, sym_name = "f_0", type = !llvm.func<ptr<i8, 4> ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 50 : i64} : () -> i64
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<i8, 3>
    %2 = "llvm.getelementptr"(%1, %0) : (!llvm.ptr<i8, 3>, i64) -> !llvm.ptr<i8, 3>
    "llvm.return"(%2) : (!llvm.ptr<i8, 3>) -> ()
  }) {linkage = 10 : i64, sym_name = "f_1", type = !llvm.func<ptr<i8, 3> ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8, 4>>, %arg1: !llvm.ptr<ptr<i8, 4>>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i8, 4>>) -> !llvm.ptr<i8, 4>
    "llvm.store"(%0, %arg1) : (!llvm.ptr<i8, 4>, !llvm.ptr<ptr<i8, 4>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "f_2", type = !llvm.func<void (ptr<ptr<i8, 4>>, ptr<ptr<i8, 4>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8, 3>>, %arg1: !llvm.ptr<ptr<i8, 3>>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i8, 3>>) -> !llvm.ptr<i8, 3>
    "llvm.store"(%0, %arg1) : (!llvm.ptr<i8, 3>, !llvm.ptr<ptr<i8, 3>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "f_3", type = !llvm.func<void (ptr<ptr<i8, 3>>, ptr<ptr<i8, 3>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8, 4>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i64} : () -> i64
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i8, 4>>) -> !llvm.ptr<i8, 4>
    %2 = "llvm.call"() {callee = @alloc, fastmathFlags = #llvm.fastmath<>} : () -> !llvm.ptr<i8, 4>
    %3 = "llvm.addrspacecast"(%2) : (!llvm.ptr<i8, 4>) -> !llvm.ptr<i8>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<i8>) -> !llvm.ptr<ptr<i8, 4>>
    %5 = "llvm.getelementptr"(%4, %0) : (!llvm.ptr<ptr<i8, 4>>, i64) -> !llvm.ptr<ptr<i8, 4>>
    "llvm.store"(%1, %5) : (!llvm.ptr<i8, 4>, !llvm.ptr<ptr<i8, 4>>) -> ()
    %6 = "llvm.bitcast"(%5) : (!llvm.ptr<ptr<i8, 4>>) -> !llvm.ptr<i64>
    %7 = "llvm.load"(%6) : (!llvm.ptr<i64>) -> i64
    "llvm.return"(%7) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "g", type = !llvm.func<i64 (ptr<ptr<i8, 4>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ptr<i8>, 4>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i64} : () -> i64
    %1 = "llvm.load"(%arg0) : (!llvm.ptr<ptr<i8>, 4>) -> !llvm.ptr<i8>
    %2 = "llvm.call"() {callee = @alloc, fastmathFlags = #llvm.fastmath<>} : () -> !llvm.ptr<i8, 4>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<i8, 4>) -> !llvm.ptr<ptr<i8>, 4>
    %4 = "llvm.getelementptr"(%3, %0) : (!llvm.ptr<ptr<i8>, 4>, i64) -> !llvm.ptr<ptr<i8>, 4>
    "llvm.store"(%1, %4) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>, 4>) -> ()
    %5 = "llvm.bitcast"(%4) : (!llvm.ptr<ptr<i8>, 4>) -> !llvm.ptr<i64, 4>
    %6 = "llvm.load"(%5) : (!llvm.ptr<i64, 4>) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "g2", type = !llvm.func<i64 (ptr<ptr<i8>, 4>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "alloc", type = !llvm.func<ptr<i8, 4> ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8, 4>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @f_5} : () -> !llvm.ptr<func<i64 (i64)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<i64 (i64)>>) -> !llvm.ptr<func<i64 (ptr<i8, 4>)>>
    %2 = "llvm.call"(%1, %arg0) : (!llvm.ptr<func<i64 (ptr<i8, 4>)>>, !llvm.ptr<i8, 4>) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "f_4", type = !llvm.func<i64 (ptr<i8, 4>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "f_5", type = !llvm.func<i64 (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
