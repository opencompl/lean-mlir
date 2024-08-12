module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @realloc(!llvm.ptr {llvm.allocptr}, i64) -> !llvm.ptr attributes {passthrough = [["allockind", "2"], ["allocsize", "8589934591"]]}
  llvm.func @malloc(i64) -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = [["allockind", "9"]]}
  llvm.func @realloc_null_ptr() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(100 : i64) : i64
    %2 = llvm.call @realloc(%0, %1) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @realloc_unknown_ptr(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i64) : i64
    %1 = llvm.call @realloc(%arg0, %0) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
}
