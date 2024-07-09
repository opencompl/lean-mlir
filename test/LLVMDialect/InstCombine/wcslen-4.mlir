module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.mlir.global external constant @hello(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi32>) {addr_space = 0 : i32} : !llvm.array<6 x i32>
  llvm.func @wcslen(!llvm.ptr) -> i64
  llvm.func @test_no_simplify1() -> i64 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }
}
