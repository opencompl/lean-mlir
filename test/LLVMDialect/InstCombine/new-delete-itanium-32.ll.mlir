module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @_Znwj(i32) -> !llvm.ptr
  llvm.func @_Znaj(i32) -> !llvm.ptr
  llvm.func @_ZnwjSt11align_val_t(i32, i32) -> !llvm.ptr
  llvm.func @_ZnajSt11align_val_t(i32, i32) -> !llvm.ptr
  llvm.func @_ZnwjSt11align_val_tRKSt9nothrow_t(i32, i32, !llvm.ptr) -> !llvm.ptr
  llvm.func @_ZnajSt11align_val_tRKSt9nothrow_t(i32, i32, !llvm.ptr) -> !llvm.ptr
  llvm.func @_ZdlPvj(!llvm.ptr, i32)
  llvm.func @_ZdaPvj(!llvm.ptr, i32)
  llvm.func @_ZdlPvSt11align_val_t(!llvm.ptr, i32)
  llvm.func @_ZdaPvSt11align_val_t(!llvm.ptr, i32)
  llvm.func @_ZdlPvjSt11align_val_t(!llvm.ptr, i32, i32)
  llvm.func @_ZdaPvjSt11align_val_t(!llvm.ptr, i32, i32)
  llvm.func @_ZdlPvSt11align_val_tRKSt9nothrow_t(!llvm.ptr, i32, !llvm.ptr)
  llvm.func @_ZdaPvSt11align_val_tRKSt9nothrow_t(!llvm.ptr, i32, !llvm.ptr)
  llvm.func @elim_new_delete_pairs() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(16 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.alloca %0 x !llvm.struct<"nothrow_t", ()> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.call @_Znwj(%1) : (i32) -> !llvm.ptr
    llvm.call @_ZdlPvj(%6, %1) : (!llvm.ptr, i32) -> ()
    %7 = llvm.call @_Znaj(%1) : (i32) -> !llvm.ptr
    llvm.call @_ZdaPvj(%7, %1) : (!llvm.ptr, i32) -> ()
    %8 = llvm.call @_ZnwjSt11align_val_t(%1, %2) : (i32, i32) -> !llvm.ptr
    llvm.call @_ZdlPvSt11align_val_t(%8, %2) : (!llvm.ptr, i32) -> ()
    %9 = llvm.call @_ZnajSt11align_val_t(%1, %2) : (i32, i32) -> !llvm.ptr
    llvm.call @_ZdaPvSt11align_val_t(%9, %2) : (!llvm.ptr, i32) -> ()
    %10 = llvm.call @_ZnwjSt11align_val_tRKSt9nothrow_t(%1, %2, %5) : (i32, i32, !llvm.ptr) -> !llvm.ptr
    llvm.call @_ZdlPvSt11align_val_tRKSt9nothrow_t(%10, %2, %5) : (!llvm.ptr, i32, !llvm.ptr) -> ()
    %11 = llvm.call @_ZnajSt11align_val_tRKSt9nothrow_t(%1, %2, %5) : (i32, i32, !llvm.ptr) -> !llvm.ptr
    llvm.call @_ZdaPvSt11align_val_tRKSt9nothrow_t(%11, %2, %5) : (!llvm.ptr, i32, !llvm.ptr) -> ()
    %12 = llvm.call @_ZnwjSt11align_val_t(%1, %2) : (i32, i32) -> !llvm.ptr
    llvm.call @_ZdlPvjSt11align_val_t(%12, %1, %2) : (!llvm.ptr, i32, i32) -> ()
    %13 = llvm.call @_ZnajSt11align_val_t(%1, %2) : (i32, i32) -> !llvm.ptr
    llvm.call @_ZdaPvjSt11align_val_t(%13, %1, %2) : (!llvm.ptr, i32, i32) -> ()
    %14 = llvm.call @_ZnajSt11align_val_t(%1, %3) : (i32, i32) -> !llvm.ptr
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.call @_ZdaPvjSt11align_val_t(%14, %1, %3) : (!llvm.ptr, i32, i32) -> ()
    llvm.return
  }
}
