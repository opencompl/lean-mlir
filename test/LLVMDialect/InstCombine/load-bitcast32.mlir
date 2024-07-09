module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test3(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test4(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    llvm.return %1 : i64
  }
  llvm.func @test5(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    llvm.return %1 : i32
  }
  llvm.func @test6(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    llvm.return %1 : i64
  }
}
