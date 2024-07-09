module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @as0() {addr_space = 0 : i32} : i32
  llvm.mlir.global external @as1() {addr_space = 1 : i32} : i32
  llvm.func @addrspace0(!llvm.ptr)
  llvm.func @addrspace1(!llvm.ptr<1>)
  llvm.func @test() {
    %0 = llvm.mlir.addressof @as0 : !llvm.ptr
    %1 = llvm.mlir.addressof @as1 : !llvm.ptr<1>
    llvm.call @addrspace0(%0) : (!llvm.ptr) -> ()
    llvm.call @addrspace1(%1) : (!llvm.ptr<1>) -> ()
    llvm.return
  }
}
