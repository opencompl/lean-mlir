module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<200>, dense<[128, 128, 128, 64]> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.global_memory_space", 200 : ui64>, #dlti.dl_entry<"dlti.program_memory_space", 200 : ui64>, #dlti.dl_entry<"dlti.alloca_memory_space", 200 : ui64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global private unnamed_addr constant @str("exactly 16 chars\00") {addr_space = 200 : i32, alignment = 1 : i64, dso_local}
  llvm.func @strcpy(!llvm.ptr<200>, !llvm.ptr<200>) -> !llvm.ptr<200>
  llvm.func @stpcpy(!llvm.ptr<200>, !llvm.ptr<200>) -> !llvm.ptr<200>
  llvm.func @strncpy(!llvm.ptr<200>, !llvm.ptr<200>, i64) -> !llvm.ptr<200>
  llvm.func @stpncpy(!llvm.ptr<200>, !llvm.ptr<200>, i64) -> !llvm.ptr<200>
  llvm.func @test_strcpy_to_memcpy(%arg0: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("exactly 16 chars\00") : !llvm.array<17 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr<200>
    %2 = llvm.call @strcpy(%arg0, %1) : (!llvm.ptr<200>, !llvm.ptr<200>) -> !llvm.ptr<200>
    llvm.return
  }
  llvm.func @test_stpcpy_to_memcpy(%arg0: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("exactly 16 chars\00") : !llvm.array<17 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr<200>
    %2 = llvm.call @stpcpy(%arg0, %1) : (!llvm.ptr<200>, !llvm.ptr<200>) -> !llvm.ptr<200>
    llvm.return
  }
  llvm.func @test_stpcpy_to_strcpy(%arg0: !llvm.ptr<200>, %arg1: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.call @stpcpy(%arg0, %arg1) : (!llvm.ptr<200>, !llvm.ptr<200>) -> !llvm.ptr<200>
    llvm.return
  }
  llvm.func @test_strncpy_to_memcpy(%arg0: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("exactly 16 chars\00") : !llvm.array<17 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr<200>
    %2 = llvm.mlir.constant(17 : i64) : i64
    %3 = llvm.call @strncpy(%arg0, %1, %2) : (!llvm.ptr<200>, !llvm.ptr<200>, i64) -> !llvm.ptr<200>
    llvm.return
  }
  llvm.func @test_stpncpy_to_memcpy(%arg0: !llvm.ptr<200>) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("exactly 16 chars\00") : !llvm.array<17 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr<200>
    %2 = llvm.mlir.constant(17 : i64) : i64
    %3 = llvm.call @stpncpy(%arg0, %1, %2) : (!llvm.ptr<200>, !llvm.ptr<200>, i64) -> !llvm.ptr<200>
    llvm.return
  }
}
