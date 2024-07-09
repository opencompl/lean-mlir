module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo1(%arg0: !llvm.ptr {llvm.align = 32 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %0 : i32
  }
  llvm.func @foo2(%arg0: !llvm.ptr {llvm.align = 32 : i64}) -> i32 {
    %0 = llvm.call @func1(%arg0) : (!llvm.ptr) -> !llvm.ptr
    %1 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }
  llvm.func @func1(!llvm.ptr {llvm.returned}) -> !llvm.ptr attributes {passthrough = ["nounwind"]}
}
