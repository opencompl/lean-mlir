module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @exp2(f64) -> f64
  llvm.func @exp2f(f32) -> f32
  llvm.func @exp2l(f128) -> f128
  llvm.func @test_simplify1(%arg0: i32) -> f64 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify2(%arg0: i16 {llvm.signext}) -> f64 {
    %0 = llvm.sitofp %arg0 : i16 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify3(%arg0: i8 {llvm.signext}) -> f64 {
    %0 = llvm.sitofp %arg0 : i8 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify4(%arg0: i32) -> f32 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.call @exp2f(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_no_simplify1(%arg0: i32) -> f64 {
    %0 = llvm.uitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify6(%arg0: i16 {llvm.zeroext}) -> f64 {
    %0 = llvm.uitofp %arg0 : i16 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify7(%arg0: i8 {llvm.zeroext}) -> f64 {
    %0 = llvm.uitofp %arg0 : i8 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify8(%arg0: i8 {llvm.zeroext}) -> f32 {
    %0 = llvm.uitofp %arg0 : i8 to f32
    %1 = llvm.call @exp2f(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify9(%arg0: i8 {llvm.zeroext}) -> f64 {
    %0 = llvm.uitofp %arg0 : i8 to f64
    %1 = llvm.intr.exp2(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify10(%arg0: i8 {llvm.zeroext}) -> f32 {
    %0 = llvm.uitofp %arg0 : i8 to f32
    %1 = llvm.intr.exp2(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @sitofp_scalar_intrinsic_with_FMF(%arg0: i8) -> f32 {
    %0 = llvm.sitofp %arg0 : i8 to f32
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @sitofp_vector_intrinsic_with_FMF(%arg0: vector<2xi8>) -> vector<2xf32> {
    %0 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf32>
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<nnan>} : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @test_readonly_exp2_f64_of_sitofp(%arg0: i32) -> f64 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_readonly_exp2f_f32_of_sitofp(%arg0: i32) -> f32 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.call @exp2f(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_readonly_exp2l_fp128_of_sitofp(%arg0: i32) -> f128 {
    %0 = llvm.sitofp %arg0 : i32 to f128
    %1 = llvm.call @exp2l(%0) : (f128) -> f128
    llvm.return %1 : f128
  }
  llvm.func @test_readonly_exp2f_f32_of_sitofp_flags(%arg0: i32) -> f32 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.call @exp2f(%0) {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f32) -> f32
    llvm.return %1 : f32
  }
}
