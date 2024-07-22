module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @truncload_no_deref(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }
  llvm.func @truncload_small_deref(%arg0: !llvm.ptr {llvm.dereferenceable = 7 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }
  llvm.func @truncload_deref(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }
  llvm.func @truncload_align(%arg0: !llvm.ptr {llvm.dereferenceable = 14 : i64}) -> i16 {
    %0 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> i32
    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }
  llvm.func @use(i64)
  llvm.func @truncload_extra_use(%arg0: !llvm.ptr {llvm.dereferenceable = 100 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i64
    llvm.call @use(%0) : (i64) -> ()
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }
  llvm.func @truncload_type(%arg0: !llvm.ptr {llvm.dereferenceable = 9 : i64}) -> i8 {
    %0 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i64
    %1 = llvm.trunc %0 : i64 to i8
    llvm.return %1 : i8
  }
  llvm.func @truncload_volatile(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }
  llvm.func @truncload_address_space(%arg0: !llvm.ptr<1> {llvm.dereferenceable = 8 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr<1> -> i64
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }
}
