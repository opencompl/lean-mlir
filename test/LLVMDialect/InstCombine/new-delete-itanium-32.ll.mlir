module  {
  llvm.func @_Znwj(i32) -> !llvm.ptr<i8>
  llvm.func @_Znaj(i32) -> !llvm.ptr<i8>
  llvm.func @_ZnwjSt11align_val_t(i32, i32) -> !llvm.ptr<i8>
  llvm.func @_ZnajSt11align_val_t(i32, i32) -> !llvm.ptr<i8>
  llvm.func @_ZnwjSt11align_val_tRKSt9nothrow_t(i32, i32, !llvm.ptr<struct<"nothrow_t", ()>>) -> !llvm.ptr<i8>
  llvm.func @_ZnajSt11align_val_tRKSt9nothrow_t(i32, i32, !llvm.ptr<struct<"nothrow_t", ()>>) -> !llvm.ptr<i8>
  llvm.func @_ZdlPvj(!llvm.ptr<i8>, i32)
  llvm.func @_ZdaPvj(!llvm.ptr<i8>, i32)
  llvm.func @_ZdlPvSt11align_val_t(!llvm.ptr<i8>, i32)
  llvm.func @_ZdaPvSt11align_val_t(!llvm.ptr<i8>, i32)
  llvm.func @_ZdlPvjSt11align_val_t(!llvm.ptr<i8>, i32, i32)
  llvm.func @_ZdaPvjSt11align_val_t(!llvm.ptr<i8>, i32, i32)
  llvm.func @_ZdlPvSt11align_val_tRKSt9nothrow_t(!llvm.ptr<i8>, i32, !llvm.ptr<struct<"nothrow_t", ()>>)
  llvm.func @_ZdaPvSt11align_val_tRKSt9nothrow_t(!llvm.ptr<i8>, i32, !llvm.ptr<struct<"nothrow_t", ()>>)
  llvm.func @llvm.assume(i1)
  llvm.func @elim_new_delete_pairs() {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(32 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.alloca %4 x !llvm.struct<"nothrow_t", ()> : (i32) -> !llvm.ptr<struct<"nothrow_t", ()>>
    %6 = llvm.call @_Znwj(%3) : (i32) -> !llvm.ptr<i8>
    llvm.call @_ZdlPvj(%6, %3) : (!llvm.ptr<i8>, i32) -> ()
    %7 = llvm.call @_Znaj(%3) : (i32) -> !llvm.ptr<i8>
    llvm.call @_ZdaPvj(%7, %3) : (!llvm.ptr<i8>, i32) -> ()
    %8 = llvm.call @_ZnwjSt11align_val_t(%3, %2) : (i32, i32) -> !llvm.ptr<i8>
    llvm.call @_ZdlPvSt11align_val_t(%8, %2) : (!llvm.ptr<i8>, i32) -> ()
    %9 = llvm.call @_ZnajSt11align_val_t(%3, %2) : (i32, i32) -> !llvm.ptr<i8>
    llvm.call @_ZdaPvSt11align_val_t(%9, %2) : (!llvm.ptr<i8>, i32) -> ()
    %10 = llvm.call @_ZnwjSt11align_val_tRKSt9nothrow_t(%3, %2, %5) : (i32, i32, !llvm.ptr<struct<"nothrow_t", ()>>) -> !llvm.ptr<i8>
    llvm.call @_ZdlPvSt11align_val_tRKSt9nothrow_t(%10, %2, %5) : (!llvm.ptr<i8>, i32, !llvm.ptr<struct<"nothrow_t", ()>>) -> ()
    %11 = llvm.call @_ZnajSt11align_val_tRKSt9nothrow_t(%3, %2, %5) : (i32, i32, !llvm.ptr<struct<"nothrow_t", ()>>) -> !llvm.ptr<i8>
    llvm.call @_ZdaPvSt11align_val_tRKSt9nothrow_t(%11, %2, %5) : (!llvm.ptr<i8>, i32, !llvm.ptr<struct<"nothrow_t", ()>>) -> ()
    %12 = llvm.call @_ZnwjSt11align_val_t(%3, %2) : (i32, i32) -> !llvm.ptr<i8>
    llvm.call @_ZdlPvjSt11align_val_t(%12, %3, %2) : (!llvm.ptr<i8>, i32, i32) -> ()
    %13 = llvm.call @_ZnajSt11align_val_t(%3, %2) : (i32, i32) -> !llvm.ptr<i8>
    llvm.call @_ZdaPvjSt11align_val_t(%13, %3, %2) : (!llvm.ptr<i8>, i32, i32) -> ()
    %14 = llvm.call @_ZnajSt11align_val_t(%3, %1) : (i32, i32) -> !llvm.ptr<i8>
    llvm.call @llvm.assume(%0) : (i1) -> ()
    llvm.call @_ZdaPvjSt11align_val_t(%14, %3, %1) : (!llvm.ptr<i8>, i32, i32) -> ()
    llvm.return
  }
}
