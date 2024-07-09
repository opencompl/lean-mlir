module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @alloc_elides_test(%arg0: i32) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(8 : i64) : i64
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.call @__rust_alloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.store %2, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.call @__rust_realloc(%5, %0, %1, %3) : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr
    llvm.store %4, %6 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.call @__rust_dealloc(%6, %0, %1) : (!llvm.ptr, i64, i64) -> ()
    llvm.return
  }
  llvm.func @__rust_alloc(i64, i64 {llvm.allocalign}) -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind", ["allockind", "41"], ["allocsize", "4294967295"], ["alloc-family", "__rust_alloc"]]}
  llvm.func @__rust_realloc(!llvm.ptr {llvm.allocptr}, i64, i64 {llvm.allocalign}, i64) -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind", ["allockind", "41"], ["allocsize", "17179869183"], ["alloc-family", "__rust_alloc"]]}
  llvm.func @__rust_dealloc(!llvm.ptr {llvm.allocptr}, i64, i64) attributes {passthrough = ["nounwind", ["allockind", "4"], ["alloc-family", "__rust_alloc"]]}
}
