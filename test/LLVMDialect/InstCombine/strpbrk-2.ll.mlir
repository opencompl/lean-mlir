module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @hello("hello world\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @w("w\00") {addr_space = 0 : i32}
  llvm.func @strpbrk(!llvm.ptr, !llvm.ptr) -> i8
  llvm.func @test_no_simplify1() -> i8 {
    %0 = llvm.mlir.constant("hello world\00") : !llvm.array<12 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant("w\00") : !llvm.array<2 x i8>
    %3 = llvm.mlir.addressof @w : !llvm.ptr
    %4 = llvm.call @strpbrk(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i8
    llvm.return %4 : i8
  }
}
