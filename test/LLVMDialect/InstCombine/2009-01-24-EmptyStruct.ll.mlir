module  {
  llvm.func @handle_event(%arg0: !llvm.ptr<struct<"struct.inode", (i32, struct<"struct.mutex", (struct<"struct.atomic_t", (i32)>, struct<"struct.rwlock_t", (struct<"struct.lock_class_key", ()>)>, struct<"struct.list_head", (ptr<struct<"struct.list_head">>, ptr<struct<"struct.list_head">>)>)>)>>) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%1, %0, %0] : (!llvm.ptr<struct<"struct.inode", (i32, struct<"struct.mutex", (struct<"struct.atomic_t", (i32)>, struct<"struct.rwlock_t", (struct<"struct.lock_class_key", ()>)>, struct<"struct.list_head", (ptr<struct<"struct.list_head">>, ptr<struct<"struct.list_head">>)>)>)>>, i64, i32, i32) -> !llvm.ptr<struct<"struct.rwlock_t", (struct<"struct.lock_class_key", ()>)>>
    %3 = llvm.bitcast %2 : !llvm.ptr<struct<"struct.rwlock_t", (struct<"struct.lock_class_key", ()>)>> to !llvm.ptr<i32>
    llvm.store %0, %3 : !llvm.ptr<i32>
    llvm.return
  }
}
