module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @X(0 : i8) {addr_space = 0 : i32} : i8
  llvm.mlir.global external @Y(12 : i8) {addr_space = 0 : i32} : i8
  llvm.func @zero_byte_test() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @X : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.mlir.addressof @Y : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(123 : i8) : i8
    "llvm.intr.memmove"(%1, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    "llvm.intr.memcpy"(%1, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    "llvm.intr.memset"(%1, %5, %4) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return
  }
}
