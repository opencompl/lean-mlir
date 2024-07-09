module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global internal unnamed_addr @base(dense<0> : tensor<16xi32>) {addr_space = 3 : i32, alignment = 16 : i64, dso_local} : !llvm.array<16 x i32>
  llvm.func @foo(!llvm.ptr)
  llvm.func @test() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : tensor<16xi32>) : !llvm.array<16 x i32>
    %3 = llvm.mlir.addressof @base : !llvm.ptr<3>
    %4 = llvm.addrspacecast %3 : !llvm.ptr<3> to !llvm.ptr
    %5 = llvm.getelementptr %4[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.call @foo(%5) : (!llvm.ptr) -> ()
    llvm.return
  }
}
