module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @throwAnExceptionOrWhatever()
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2 overflow<nsw>  : i64
    %5 = llvm.add %4, %0  : i64
    %6 = llvm.icmp "ugt" %5, %1 : i64
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %7 = llvm.trunc %4 : i64 to i32
    llvm.return %7 : i32
  }
  llvm.func @test2(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2 overflow<nsw>  : i64
    %5 = llvm.add %4, %0  : i64
    llvm.store %5, %arg2 {alignment = 4 : i64} : i64, !llvm.ptr
    %6 = llvm.icmp "ugt" %5, %1 : i64
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %7 = llvm.trunc %4 : i64 to i32
    llvm.return %7 : i32
  }
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i64 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.add %3, %2 overflow<nsw>  : i64
    %5 = llvm.add %4, %0  : i64
    %6 = llvm.icmp "ugt" %5, %1 : i64
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i64
  }
  llvm.func @test4(%arg0: i8 {llvm.signext}, %arg1: i8 {llvm.signext}) -> (i8 {llvm.zeroext}) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.sext %arg0 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.add %3, %2 overflow<nsw>  : i32
    %5 = llvm.add %4, %0 overflow<nsw>  : i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    %7 = llvm.trunc %4 : i32 to i8
    llvm.return %7 : i8
  }
  llvm.func @test8(%arg0: i64, %arg1: i64) -> i32 attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(2147483648 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.add %arg0, %arg1  : i64
    %3 = llvm.add %2, %0  : i64
    %4 = llvm.icmp "ugt" %3, %1 : i64
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @throwAnExceptionOrWhatever() : () -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %5 = llvm.trunc %2 : i64 to i32
    llvm.return %5 : i32
  }
}
