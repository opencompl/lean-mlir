"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"struct.inode", (i32, struct<"struct.mutex", (struct<"struct.atomic_t", (i32)>, struct<"struct.rwlock_t", (struct<"struct.lock_class_key", ()>)>, struct<"struct.list_head", (ptr<struct<"struct.list_head">>, ptr<struct<"struct.list_head">>)>)>)>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -1 : i64} : () -> i64
    %2 = "llvm.getelementptr"(%arg0, %1, %0, %0) : (!llvm.ptr<struct<"struct.inode", (i32, struct<"struct.mutex", (struct<"struct.atomic_t", (i32)>, struct<"struct.rwlock_t", (struct<"struct.lock_class_key", ()>)>, struct<"struct.list_head", (ptr<struct<"struct.list_head">>, ptr<struct<"struct.list_head">>)>)>)>>, i64, i32, i32) -> !llvm.ptr<struct<"struct.rwlock_t", (struct<"struct.lock_class_key", ()>)>>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<struct<"struct.rwlock_t", (struct<"struct.lock_class_key", ()>)>>) -> !llvm.ptr<i32>
    "llvm.store"(%0, %3) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "handle_event", type = !llvm.func<void (ptr<struct<"struct.inode", (i32, struct<"struct.mutex", (struct<"struct.atomic_t", (i32)>, struct<"struct.rwlock_t", (struct<"struct.lock_class_key", ()>)>, struct<"struct.list_head", (ptr<struct<"struct.list_head">>, ptr<struct<"struct.list_head">>)>)>)>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
