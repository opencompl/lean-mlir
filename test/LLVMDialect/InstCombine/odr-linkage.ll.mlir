module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global available_externally constant @g1(1 : i32) {addr_space = 0 : i32} : i32
  llvm.mlir.global linkonce_odr constant @g2(2 : i32) {addr_space = 0 : i32} : i32
  llvm.mlir.global weak_odr constant @g3(3 : i32) {addr_space = 0 : i32} : i32
  llvm.mlir.global internal constant @g4(4 : i32) {addr_space = 0 : i32, dso_local} : i32
  llvm.func @test() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @g1 : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.mlir.addressof @g3 : !llvm.ptr
    %6 = llvm.mlir.constant(4 : i32) : i32
    %7 = llvm.mlir.addressof @g4 : !llvm.ptr
    %8 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %9 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %12 = llvm.add %8, %9  : i32
    %13 = llvm.add %12, %10  : i32
    %14 = llvm.add %13, %11  : i32
    llvm.return %14 : i32
  }
}
