module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @user(!llvm.ptr)
  llvm.func @malloc(i64) -> !llvm.ptr attributes {passthrough = [["allockind", "9"], ["allocsize", "4294967295"], ["alloc-family", "malloc"]]}
  llvm.func @free(!llvm.ptr) attributes {passthrough = [["allockind", "4"], ["alloc-family", "malloc"]]}
  llvm.func @malloc_then_free_not_needed() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @free(%2) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @malloc_then_free_needed() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @user(%1) : (!llvm.ptr) -> ()
    llvm.call @free(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
}
