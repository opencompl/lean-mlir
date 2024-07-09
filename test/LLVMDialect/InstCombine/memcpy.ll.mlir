module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @UnknownConstant() {addr_space = 0 : i32} : i128
  llvm.func @test1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(100 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg0, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(100 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg0, %0) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @test3(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(17179869184 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @memcpy_to_constant(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @UnknownConstant : !llvm.ptr
    %1 = llvm.mlir.constant(16 : i32) : i32
    "llvm.intr.memcpy"(%0, %arg0, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
}
