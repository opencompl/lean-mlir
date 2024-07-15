module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @main2() -> i32
  llvm.func @ctime2(!llvm.ptr) -> !llvm.ptr
  llvm.func @ctime(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @main2 : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.addressof @ctime2 : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.call %0(%1) : !llvm.ptr, (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }
}
