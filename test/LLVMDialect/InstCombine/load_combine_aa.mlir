module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_load_combine_aa(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
