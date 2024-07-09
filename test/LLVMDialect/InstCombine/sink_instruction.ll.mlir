module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.sdiv %arg1, %arg2  : i32
    %1 = llvm.add %arg2, %arg1  : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @test2(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(1000000 : i32) : i32
    llvm.br ^bb1(%arg0, %0 : i32, i32)
  ^bb1(%3: i32, %4: i32):  // 2 preds: ^bb0, ^bb3
    %5 = llvm.add %3, %1 overflow<nsw>  : i32
    %6 = llvm.sdiv %5, %3  : i32
    %7 = llvm.icmp "eq" %3, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb3(%3 : i32)
  ^bb2:  // pred: ^bb1
    %8 = llvm.call @bar() : () -> i32
    llvm.br ^bb3(%6 : i32)
  ^bb3(%9: i32):  // 2 preds: ^bb1, ^bb2
    %10 = llvm.add %4, %1 overflow<nsw>  : i32
    %11 = llvm.icmp "eq" %10, %2 : i32
    llvm.cond_br %11, ^bb4, ^bb1(%9, %10 : i32, i32)
  ^bb4:  // pred: ^bb3
    llvm.return %9 : i32
  }
  llvm.func @bar() -> i32
  llvm.func @test3(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg1 : i32 to i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.switch %arg1 : i32, ^bb2(%0 : i32) [
      5: ^bb1,
      2: ^bb1
    ]
  ^bb1:  // 2 preds: ^bb0, ^bb0
    %4 = llvm.add %3, %arg1 overflow<nsw>  : i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }
  llvm.func @foo(i32, i32) -> i32
  llvm.func @test4(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.sdiv %arg0, %arg1  : i32
    %1 = llvm.add %arg1, %arg0  : i32
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.call @foo(%1, %1) : (i32, i32) -> i32
    llvm.return %2 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }
  llvm.func @test5(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.sext %arg1 : i32 to i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.cond_br %arg2, ^bb1, ^bb2(%2 : i32)
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg1, %arg1 overflow<nsw>  : i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @test6(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.sext %arg1 : i32 to i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %3 = llvm.add %arg1, %arg1 overflow<nsw>  : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.switch %arg1 : i32, ^bb2 [
      5: ^bb3(%2 : i32),
      2: ^bb3(%2 : i32)
    ]
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%3 : i32)
  ^bb3(%4: i32):  // 3 preds: ^bb1, ^bb1, ^bb2
    llvm.return %4 : i32
  }
  llvm.func @checkd(f64)
  llvm.func @log(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind", "willreturn"]}
  llvm.func @test7(%arg0: i1, %arg1: f64) {
    %0 = llvm.call @log(%arg1) : (f64) -> f64
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @checkd(%0) : (f64) -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @abort()
  llvm.func @dummy(i64)
  llvm.func @test8(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.select %3, %1, %0 : i1, i64
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @dummy(%4) : (i64) -> ()
    llvm.return %4 : i64
  ^bb2:  // pred: ^bb0
    llvm.call @abort() : () -> ()
    llvm.unreachable
  }
}
