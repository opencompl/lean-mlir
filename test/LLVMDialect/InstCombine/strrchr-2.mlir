module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @hello("hello world\\n\00") {addr_space = 0 : i32}
  llvm.mlir.global external @chr(0 : i8) {addr_space = 0 : i32} : i8
  llvm.func @strrchr(!llvm.ptr, i32) -> i8
  llvm.func @test_nosimplify1() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.addressof @chr : !llvm.ptr
    %5 = llvm.call @strrchr(%1, %2) : (!llvm.ptr, i32) -> i8
    llvm.store %5, %4 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
}
