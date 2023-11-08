"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "_swift_slowAlloc", type = !llvm.ptr<func<ptr<i8> (i64, i64)>>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memcpy.p0i8.p0i8.i64", type = !llvm.func<void (ptr<i8>, ptr<i8>, i64, i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "rt_swift_slowAlloc", type = !llvm.func<ptr<i8> (i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<array<24 x i8>>, %arg1: !llvm.ptr<struct<"swift.opaque", opaque>>, %arg2: !llvm.ptr<struct<"swift.type", (i64)>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 40 : i64} : () -> i64
    %3 = "llvm.bitcast"(%arg1) : (!llvm.ptr<struct<"swift.opaque", opaque>>) -> !llvm.ptr<struct<"V", packed (struct<packed (struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>)>, struct<"Si", packed (i64)>, struct<"SQ", packed (array<8 x i8>)>, struct<"SQ", packed (array<8 x i8>)>, struct<"Si", packed (i64)>, struct<"swift.opaque", opaque>)>>
    %4 = "llvm.call"(%2, %1) {callee = @rt_swift_slowAlloc, fastmathFlags = #llvm.fastmath<>} : (i64, i64) -> !llvm.ptr<i8>
    %5 = "llvm.bitcast"(%arg0) : (!llvm.ptr<array<24 x i8>>) -> !llvm.ptr<ptr<i8>>
    "llvm.store"(%4, %5) : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> ()
    %6 = "llvm.bitcast"(%4) : (!llvm.ptr<i8>) -> !llvm.ptr<struct<"V", packed (struct<packed (struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>)>, struct<"Si", packed (i64)>, struct<"SQ", packed (array<8 x i8>)>, struct<"SQ", packed (array<8 x i8>)>, struct<"Si", packed (i64)>, struct<"swift.opaque", opaque>)>>
    %7 = "llvm.bitcast"(%6) : (!llvm.ptr<struct<"V", packed (struct<packed (struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>)>, struct<"Si", packed (i64)>, struct<"SQ", packed (array<8 x i8>)>, struct<"SQ", packed (array<8 x i8>)>, struct<"Si", packed (i64)>, struct<"swift.opaque", opaque>)>>) -> !llvm.ptr<i8>
    %8 = "llvm.bitcast"(%3) : (!llvm.ptr<struct<"V", packed (struct<packed (struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>)>, struct<"Si", packed (i64)>, struct<"SQ", packed (array<8 x i8>)>, struct<"SQ", packed (array<8 x i8>)>, struct<"Si", packed (i64)>, struct<"swift.opaque", opaque>)>>) -> !llvm.ptr<i8>
    "llvm.call"(%7, %8, %2, %0) {callee = @llvm.memcpy.p0i8.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    %9 = "llvm.bitcast"(%6) : (!llvm.ptr<struct<"V", packed (struct<packed (struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>, struct<"Vs4Int8", packed (i8)>)>, struct<"Si", packed (i64)>, struct<"SQ", packed (array<8 x i8>)>, struct<"SQ", packed (array<8 x i8>)>, struct<"Si", packed (i64)>, struct<"swift.opaque", opaque>)>>) -> !llvm.ptr<struct<"swift.opaque", opaque>>
    "llvm.return"(%9) : (!llvm.ptr<struct<"swift.opaque", opaque>>) -> ()
  }) {linkage = 10 : i64, sym_name = "_TwTkV", type = !llvm.func<ptr<struct<"swift.opaque", opaque>> (ptr<array<24 x i8>>, ptr<struct<"swift.opaque", opaque>>, ptr<struct<"swift.type", (i64)>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
