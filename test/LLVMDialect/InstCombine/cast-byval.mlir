module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", (i64)>}) -> i64 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64
    llvm.return %0 : i64
  }
  llvm.func @bar(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @foo : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (i64) -> i64
    llvm.return %1 : i64
  }
  llvm.func @qux(%arg0: !llvm.ptr {llvm.byval = !llvm.struct<"Foo", (i64)>}) -> i64 {
    %0 = llvm.mlir.addressof @bar : !llvm.ptr
    %1 = llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> i64
    llvm.return %1 : i64
  }
}
