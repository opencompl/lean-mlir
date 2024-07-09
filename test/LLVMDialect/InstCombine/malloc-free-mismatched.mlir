module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @_Z6answeri(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(80 : i64) : i64
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.call @free(%2) : (!llvm.ptr) -> ()
    llvm.return %1 : i32
  }
  llvm.func @test_alloca() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.call @free(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @_Znam(i64) -> (!llvm.ptr {llvm.nonnull}) attributes {passthrough = ["nobuiltin", ["allockind", "9"], ["allocsize", "4294967295"], ["alloc-family", "_Znam"]]}
  llvm.func @free(!llvm.ptr) attributes {passthrough = [["allockind", "4"], ["alloc-family", "malloc"]]}
}
