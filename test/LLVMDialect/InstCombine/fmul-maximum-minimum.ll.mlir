module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg0, %arg1)  : (f32, f32) -> f32
    %2 = llvm.fmul %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @test_comm1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg0, %arg1)  : (f32, f32) -> f32
    %2 = llvm.fmul %1, %0  : f32
    llvm.return %2 : f32
  }
  llvm.func @test_comm2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg1, %arg0)  : (f32, f32) -> f32
    %2 = llvm.fmul %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @test_comm3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg1, %arg0)  : (f32, f32) -> f32
    %2 = llvm.fmul %1, %0  : f32
    llvm.return %2 : f32
  }
  llvm.func @test_vect(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %1 = llvm.intr.maximum(%arg1, %arg0)  : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %2 = llvm.fmul %0, %1  : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @test_flags(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg0, %arg1)  : (f32, f32) -> f32
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @test_flags2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg0, %arg1)  : (f32, f32) -> f32
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<ninf, nsz, arcp, contract, afn, reassoc>} : f32
    llvm.return %2 : f32
  }
}
