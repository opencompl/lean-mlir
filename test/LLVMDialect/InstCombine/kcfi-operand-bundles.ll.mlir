module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @f1() attributes {passthrough = ["kcfi-target"]} {
    llvm.return
  }
  llvm.func @f2() attributes {passthrough = ["kcfi-target"]}
  llvm.func @g(%arg0: !llvm.ptr {llvm.noundef}) attributes {passthrough = ["kcfi-target"]} {
    llvm.call %arg0() : !llvm.ptr, () -> ()
    llvm.call @f1() : () -> ()
    llvm.call @f2() : () -> ()
    llvm.return
  }
}