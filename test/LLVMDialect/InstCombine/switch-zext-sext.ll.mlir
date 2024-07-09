module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_switch_with_zext(%arg0: i16, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.zext %arg0 : i16 to i32
    llvm.switch %0 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %arg1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
  llvm.func @test_switch_with_sext(%arg0: i16, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.sext %arg0 : i16 to i32
    llvm.switch %0 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %arg1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
  llvm.func @test_switch_with_zext_unreachable_case(%arg0: i16, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.zext %arg0 : i16 to i32
    llvm.switch %0 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1,
      65537: ^bb1
    ]
  ^bb1:  // 4 preds: ^bb0, ^bb0, ^bb0, ^bb0
    llvm.return %arg1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
  llvm.func @test_switch_with_sext_unreachable_case(%arg0: i16, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.sext %arg0 : i16 to i32
    llvm.switch %0 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1,
      4294901759: ^bb1
    ]
  ^bb1:  // 4 preds: ^bb0, ^bb0, ^bb0, ^bb0
    llvm.return %arg1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }
}
