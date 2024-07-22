module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global weak @p(0 : i32) {addr_space = 0 : i32} : i32
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @p : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.mul %arg0, %2  : i32
    llvm.return %3 : i32
  }
}
