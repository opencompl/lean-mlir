module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global private unnamed_addr constant @".str"("abc\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.func arm_aapcscc @_abs(%arg0: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.call arm_aapcscc @abs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func arm_aapcscc @abs(i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func arm_aapcscc @_labs(%arg0: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.call arm_aapcscc @labs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func arm_aapcscc @labs(i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func arm_aapcscc @_strlen1() -> i32 {
    %0 = llvm.mlir.constant("abc\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call arm_aapcscc @strlen(%1) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }
  llvm.func arm_aapcscc @strlen(!llvm.ptr) -> i32
  llvm.func arm_aapcscc @_strlen2(%arg0: !llvm.ptr) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call arm_aapcscc @strlen(%arg0) : (!llvm.ptr) -> i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
}
