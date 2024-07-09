module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: f64, %arg1: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fadd %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }
  llvm.func @test2(%arg0: f64, %arg1: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fsub %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }
  llvm.func @test3(%arg0: f64, %arg1: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fmul %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }
  llvm.func @test4(%arg0: f64, %arg1: f16) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f16 to f80
    %2 = llvm.fmul %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }
  llvm.func @test5(%arg0: f64, %arg1: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fdiv %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }
}
