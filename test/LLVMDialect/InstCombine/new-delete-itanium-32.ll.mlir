"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_Znwj", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_Znaj", type = !llvm.func<ptr<i8> (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_ZnwjSt11align_val_t", type = !llvm.func<ptr<i8> (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_ZnajSt11align_val_t", type = !llvm.func<ptr<i8> (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_ZnwjSt11align_val_tRKSt9nothrow_t", type = !llvm.func<ptr<i8> (i32, i32, ptr<struct<"nothrow_t", ()>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_ZnajSt11align_val_tRKSt9nothrow_t", type = !llvm.func<ptr<i8> (i32, i32, ptr<struct<"nothrow_t", ()>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_ZdlPvj", type = !llvm.func<void (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_ZdaPvj", type = !llvm.func<void (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_ZdlPvSt11align_val_t", type = !llvm.func<void (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_ZdaPvSt11align_val_t", type = !llvm.func<void (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_ZdlPvjSt11align_val_t", type = !llvm.func<void (ptr<i8>, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_ZdaPvjSt11align_val_t", type = !llvm.func<void (ptr<i8>, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_ZdlPvSt11align_val_tRKSt9nothrow_t", type = !llvm.func<void (ptr<i8>, i32, ptr<struct<"nothrow_t", ()>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_ZdaPvSt11align_val_tRKSt9nothrow_t", type = !llvm.func<void (ptr<i8>, i32, ptr<struct<"nothrow_t", ()>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.assume", type = !llvm.func<void (i1)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 32 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.alloca"(%4) : (i32) -> !llvm.ptr<struct<"nothrow_t", ()>>
    %6 = "llvm.call"(%3) {callee = @_Znwj, fastmathFlags = #llvm.fastmath<>} : (i32) -> !llvm.ptr<i8>
    "llvm.call"(%6, %3) {callee = @_ZdlPvj, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> ()
    %7 = "llvm.call"(%3) {callee = @_Znaj, fastmathFlags = #llvm.fastmath<>} : (i32) -> !llvm.ptr<i8>
    "llvm.call"(%7, %3) {callee = @_ZdaPvj, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> ()
    %8 = "llvm.call"(%3, %2) {callee = @_ZnwjSt11align_val_t, fastmathFlags = #llvm.fastmath<>} : (i32, i32) -> !llvm.ptr<i8>
    "llvm.call"(%8, %2) {callee = @_ZdlPvSt11align_val_t, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> ()
    %9 = "llvm.call"(%3, %2) {callee = @_ZnajSt11align_val_t, fastmathFlags = #llvm.fastmath<>} : (i32, i32) -> !llvm.ptr<i8>
    "llvm.call"(%9, %2) {callee = @_ZdaPvSt11align_val_t, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32) -> ()
    %10 = "llvm.call"(%3, %2, %5) {callee = @_ZnwjSt11align_val_tRKSt9nothrow_t, fastmathFlags = #llvm.fastmath<>} : (i32, i32, !llvm.ptr<struct<"nothrow_t", ()>>) -> !llvm.ptr<i8>
    "llvm.call"(%10, %2, %5) {callee = @_ZdlPvSt11align_val_tRKSt9nothrow_t, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, !llvm.ptr<struct<"nothrow_t", ()>>) -> ()
    %11 = "llvm.call"(%3, %2, %5) {callee = @_ZnajSt11align_val_tRKSt9nothrow_t, fastmathFlags = #llvm.fastmath<>} : (i32, i32, !llvm.ptr<struct<"nothrow_t", ()>>) -> !llvm.ptr<i8>
    "llvm.call"(%11, %2, %5) {callee = @_ZdaPvSt11align_val_tRKSt9nothrow_t, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, !llvm.ptr<struct<"nothrow_t", ()>>) -> ()
    %12 = "llvm.call"(%3, %2) {callee = @_ZnwjSt11align_val_t, fastmathFlags = #llvm.fastmath<>} : (i32, i32) -> !llvm.ptr<i8>
    "llvm.call"(%12, %3, %2) {callee = @_ZdlPvjSt11align_val_t, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i32) -> ()
    %13 = "llvm.call"(%3, %2) {callee = @_ZnajSt11align_val_t, fastmathFlags = #llvm.fastmath<>} : (i32, i32) -> !llvm.ptr<i8>
    "llvm.call"(%13, %3, %2) {callee = @_ZdaPvjSt11align_val_t, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i32) -> ()
    %14 = "llvm.call"(%3, %1) {callee = @_ZnajSt11align_val_t, fastmathFlags = #llvm.fastmath<>} : (i32, i32) -> !llvm.ptr<i8>
    "llvm.call"(%0) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.call"(%14, %3, %1) {callee = @_ZdaPvjSt11align_val_t, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "elim_new_delete_pairs", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
