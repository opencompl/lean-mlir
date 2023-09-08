"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 1 : i64, sym_name = "\01L_OBJC_METH_VAR_NAME_112", type = !llvm.array<15 x i8>, value = "whiteComponent\00"} : () -> ()
  "llvm.mlir.global"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @"\01L_OBJC_METH_VAR_NAME_112"} : () -> !llvm.ptr<array<15 x i8>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<array<15 x i8>>) -> !llvm.ptr<struct<"struct.objc_selector", opaque>>
    "llvm.return"(%1) : (!llvm.ptr<struct<"struct.objc_selector", opaque>>) -> ()
  }) {linkage = 1 : i64, sym_name = "\01L_OBJC_SELECTOR_REFERENCES_81", type = !llvm.ptr<struct<"struct.objc_selector", opaque>>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @objc_msgSend_fpret} : () -> !llvm.ptr<func<void (ptr<struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>>, ...)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<void (ptr<struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>>, ...)>>) -> !llvm.ptr<func<f32 (ptr<struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>>, ptr<struct<"struct.objc_selector", opaque>>)>>
    %2 = "llvm.mlir.addressof"() {global_name = @"\01L_OBJC_SELECTOR_REFERENCES_81"} : () -> !llvm.ptr<ptr<struct<"struct.objc_selector", opaque>>>
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.alloca"(%4) : (i32) -> !llvm.ptr<ptr<struct<"struct.NSArray", (struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>)>>>
    %6 = "llvm.alloca"(%4) : (i32) -> !llvm.ptr<ptr<struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>>>
    %7 = "llvm.load"(%5) : (!llvm.ptr<ptr<struct<"struct.NSArray", (struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>)>>>) -> !llvm.ptr<struct<"struct.NSArray", (struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>)>>
    %8 = "llvm.getelementptr"(%7, %3, %3) : (!llvm.ptr<struct<"struct.NSArray", (struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>)>>, i32, i32) -> !llvm.ptr<struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>>
    "llvm.store"(%8, %6) : (!llvm.ptr<struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>>, !llvm.ptr<ptr<struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>>>) -> ()
    %9 = "llvm.load"(%2) : (!llvm.ptr<ptr<struct<"struct.objc_selector", opaque>>>) -> !llvm.ptr<struct<"struct.objc_selector", opaque>>
    %10 = "llvm.load"(%6) : (!llvm.ptr<ptr<struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>>>) -> !llvm.ptr<struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>>
    %11 = "llvm.call"(%1, %10, %9) : (!llvm.ptr<func<f32 (ptr<struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>>, ptr<struct<"struct.objc_selector", opaque>>)>>, !llvm.ptr<struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>>, !llvm.ptr<struct<"struct.objc_selector", opaque>>) -> f32
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bork", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "objc_msgSend_fpret", type = !llvm.func<void (ptr<struct<"struct.NSObject", (ptr<struct<"struct.objc_class", opaque>>)>>, ...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
