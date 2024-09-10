module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "big">>} {
  llvm.func @test1(%arg0: !llvm.ptr) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i1
    llvm.return %0 : i1
  }
  llvm.func @test2(%arg0: i128) -> !llvm.ptr attributes {passthrough = ["nounwind"]} {
    %0 = llvm.inttoptr %arg0 : i128 to !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @f0(%arg0: i32) -> i64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    llvm.return %1 : i64
  }
  llvm.func @test4(%arg0: !llvm.vec<4 x ptr>) -> vector<4xi32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.ptrtoint %arg0 : !llvm.vec<4 x ptr> to vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }
  llvm.func @testvscale4(%arg0: !llvm.vec<? x 4 x  ptr>) -> !llvm.vec<? x 4 x  i32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.ptrtoint %arg0 : !llvm.vec<? x 4 x  ptr> to !llvm.vec<? x 4 x  i32>
    llvm.return %0 : !llvm.vec<? x 4 x  i32>
  }
  llvm.func @test5(%arg0: !llvm.vec<4 x ptr>) -> vector<4xi128> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.ptrtoint %arg0 : !llvm.vec<4 x ptr> to vector<4xi128>
    llvm.return %0 : vector<4xi128>
  }
  llvm.func @test6(%arg0: vector<4xi32>) -> !llvm.vec<4 x ptr> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.inttoptr %arg0 : vector<4xi32> to !llvm.vec<4 x ptr>
    llvm.return %0 : !llvm.vec<4 x ptr>
  }
  llvm.func @test7(%arg0: vector<4xi128>) -> !llvm.vec<4 x ptr> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.inttoptr %arg0 : vector<4xi128> to !llvm.vec<4 x ptr>
    llvm.return %0 : !llvm.vec<4 x ptr>
  }
}
