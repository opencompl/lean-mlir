module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @matching_scalar(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32
    llvm.return %0 : f32
  }
  llvm.func @nonmatching_scalar(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> i32
    llvm.return %0 : i32
  }
  llvm.func @larger_scalar(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> i64 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> i64
    llvm.return %0 : i64
  }
  llvm.func @smaller_scalar(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> i8 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> i8
    llvm.return %0 : i8
  }
  llvm.func @smaller_scalar_less_aligned(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> i8 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i8
    llvm.return %0 : i8
  }
  llvm.func @matching_scalar_small_deref(%arg0: !llvm.ptr {llvm.dereferenceable = 15 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32
    llvm.return %0 : f32
  }
  llvm.func @matching_scalar_smallest_deref(%arg0: !llvm.ptr {llvm.dereferenceable = 1 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32
    llvm.return %0 : f32
  }
  llvm.func @matching_scalar_smallest_deref_or_null(%arg0: !llvm.ptr {llvm.dereferenceable_or_null = 1 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32
    llvm.return %0 : f32
  }
  llvm.func @matching_scalar_smallest_deref_addrspace(%arg0: !llvm.ptr<4> {llvm.dereferenceable = 1 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr<4> -> f32
    llvm.return %0 : f32
  }
  llvm.func @matching_scalar_smallest_deref_or_null_addrspace(%arg0: !llvm.ptr<4> {llvm.dereferenceable_or_null = 1 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr<4> -> f32
    llvm.return %0 : f32
  }
  llvm.func @matching_scalar_volatile(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> f32 {
    %0 = llvm.load volatile %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32
    llvm.return %0 : f32
  }
  llvm.func @nonvector(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}) -> f32 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> f32
    llvm.return %0 : f32
  }
}
