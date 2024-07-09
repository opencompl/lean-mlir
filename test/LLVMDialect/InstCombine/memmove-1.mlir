module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @memmove(!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
  llvm.func @test_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memmove(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test_simplify2(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memmove(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memmove(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test_no_incompatible_attr(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memmove(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
}
