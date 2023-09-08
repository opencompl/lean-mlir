"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "main2", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "ctime2", type = !llvm.func<ptr<i7> (ptr<i999>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i999>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @main2} : () -> !llvm.ptr<func<i32 ()>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<i32 ()>>) -> !llvm.ptr<func<ptr<i7> ()>>
    %2 = "llvm.call"(%1) : (!llvm.ptr<func<ptr<i7> ()>>) -> !llvm.ptr<i7>
    "llvm.return"(%2) : (!llvm.ptr<i7>) -> ()
  }) {linkage = 10 : i64, sym_name = "ctime", type = !llvm.func<ptr<i7> (ptr<i999>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @ctime2} : () -> !llvm.ptr<func<ptr<i7> (ptr<i999>)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<ptr<i7> (ptr<i999>)>>) -> !llvm.ptr<func<i32 (ptr<i99>)>>
    %2 = "llvm.mlir.null"() : () -> !llvm.ptr<i99>
    %3 = "llvm.call"(%1, %2) : (!llvm.ptr<func<i32 (ptr<i99>)>>, !llvm.ptr<i99>) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "main", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
