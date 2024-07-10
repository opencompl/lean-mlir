#tbaa_root = #llvm.tbaa_root<id = "Simple C/C++ TBAA">
#tbaa_type_desc = #llvm.tbaa_type_desc<id = "omnipotent char", members = {<#tbaa_root, 0>}>
#tbaa_type_desc1 = #llvm.tbaa_type_desc<id = "int", members = {<#tbaa_type_desc, 0>}>
#tbaa_type_desc2 = #llvm.tbaa_type_desc<id = "float", members = {<#tbaa_type_desc, 0>}>
#tbaa_tag = #llvm.tbaa_tag<base_type = #tbaa_type_desc1, access_type = #tbaa_type_desc1, offset = 0>
#tbaa_tag1 = #llvm.tbaa_tag<base_type = #tbaa_type_desc2, access_type = #tbaa_type_desc2, offset = 0>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @Unknown() {addr_space = 0 : i32} : i32
  llvm.func @store_of_undef(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @store_of_poison(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.poison : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @store_into_undef(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @store_into_null(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(124 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.add %1, %0  : i32
    llvm.store %2, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @store_at_gep_off_null_inbounds(%arg0: i64) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.getelementptr inbounds %0[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @store_at_gep_off_null_not_inbounds(%arg0: i64) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.getelementptr %0[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @store_at_gep_off_no_null_opt(%arg0: i64) attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.getelementptr inbounds %0[%arg0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test3(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(47 : i32) : i32
    %2 = llvm.mlir.constant(-987654321 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %1, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
  llvm.func @test4(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(47 : i32) : i32
    %2 = llvm.mlir.constant(-987654321 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
  llvm.func @test5(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(47 : i32) : i32
    %1 = llvm.mlir.constant(-987654321 : i32) : i32
    llvm.store %0, %arg1 {alignment = 1 : i64} : i32, !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %1, %arg1 {alignment = 1 : i64} : i32, !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }
  llvm.func @test6(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(1 : i32) : i32
    llvm.store %0, %arg2 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : i32, !llvm.ptr
    llvm.br ^bb1(%1 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
    %5 = llvm.load %arg2 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32
    %6 = llvm.icmp "slt" %5, %arg0 : i32
    llvm.cond_br %6, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %7 = llvm.sext %5 : i32 to i64
    %8 = llvm.getelementptr inbounds %arg1[%7] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %2, %8 {alignment = 4 : i64, tbaa = [#tbaa_tag1]} : f32, !llvm.ptr
    %9 = llvm.load %arg2 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32
    %10 = llvm.add %9, %3 overflow<nsw>  : i32
    llvm.store %10, %arg2 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : i32, !llvm.ptr
    llvm.br ^bb1(%10 : i32)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
  llvm.func @dse1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @dse2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @dse3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @dse4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @dse5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %0, %arg0 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @write_back1(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @write_back2(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @write_back3(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @write_back4(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @write_back5(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %0, %arg0 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @write_back6(%arg0: !llvm.ptr) {
    %0 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @write_back7(%arg0: !llvm.ptr) {
    %0 = llvm.load volatile %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %0, %arg0 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @store_to_constant() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @Unknown : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @store_to_readonly_noalias(%arg0: !llvm.ptr {llvm.noalias, llvm.readonly}) {
    %0 = llvm.mlir.constant(3 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
