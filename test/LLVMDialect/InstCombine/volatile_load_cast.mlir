module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @float_load(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.bitcast %0 : i32 to f32
    llvm.return %1 : f32
  }
  llvm.func @i32_load(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @double_load(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.load volatile %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %1 = llvm.bitcast %0 : i64 to f64
    llvm.return %1 : f64
  }
  llvm.func @i64_load(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.load volatile %arg0 {alignment = 8 : i64} : !llvm.ptr -> f64
    %1 = llvm.bitcast %0 : f64 to i64
    llvm.return %1 : i64
  }
  llvm.func @ptr_load(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load volatile %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
}
