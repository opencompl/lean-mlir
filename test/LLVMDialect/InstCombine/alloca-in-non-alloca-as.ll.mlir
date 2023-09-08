"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (ptr<i8>, ptr<ptr<i32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> !llvm.ptr<i32>
    %1 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %2 = "llvm.alloca"(%1) : (i64) -> !llvm.ptr<i8>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<i8>) -> !llvm.ptr<ptr<i32>>
    "llvm.store"(%0, %3) : (!llvm.ptr<i32>, !llvm.ptr<ptr<i32>>) -> ()
    "llvm.call"(%2, %3) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i32>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 4 : i64, sym_name = "__omp_offloading_802_ea0109_main_l8", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<array<30 x struct<"struct.widget", (array<8 x i8>)>>>
    %3 = "llvm.getelementptr"(%2, %0, %0) : (!llvm.ptr<array<30 x struct<"struct.widget", (array<8 x i8>)>>>, i64, i64) -> !llvm.ptr<struct<"struct.widget", (array<8 x i8>)>>
    "llvm.call"(%3) {callee = @zot, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"struct.widget", (array<8 x i8>)>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "spam", type = !llvm.func<void (ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "zot", type = !llvm.func<void (ptr<struct<"struct.widget", (array<8 x i8>)>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
