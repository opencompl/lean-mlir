module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @_swift_slowAlloc() {addr_space = 0 : i32} : !llvm.ptr
  llvm.func @rt_swift_slowAlloc(i64, i64) -> !llvm.ptr
  llvm.func @_TwTkV(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @rt_swift_slowAlloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.store %2, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    "llvm.intr.memcpy"(%2, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %2 : !llvm.ptr
  }
}
