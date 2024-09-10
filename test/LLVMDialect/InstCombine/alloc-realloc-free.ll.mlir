module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func local_unnamed_addr @test() attributes {passthrough = ["mustprogress", "nounwind", "willreturn", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(6 : i64) : i64
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.call @realloc(%2, %1) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.call @free(%3) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func local_unnamed_addr @malloc(i64 {llvm.noundef}) -> (!llvm.ptr {llvm.noalias, llvm.noundef}) attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = readwrite>, passthrough = ["mustprogress", "nofree", "nounwind", "willreturn", ["allockind", "9"], ["alloc-family", "malloc"]]}
  llvm.func local_unnamed_addr @realloc(!llvm.ptr {llvm.allocptr, llvm.nocapture}, i64 {llvm.noundef}) -> (!llvm.ptr {llvm.noalias, llvm.noundef}) attributes {memory = #llvm.memory_effects<other = none, argMem = readwrite, inaccessibleMem = readwrite>, passthrough = ["mustprogress", "nounwind", "willreturn", ["allockind", "2"], ["alloc-family", "malloc"]]}
  llvm.func local_unnamed_addr @free(!llvm.ptr {llvm.allocptr, llvm.nocapture, llvm.noundef}) attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nofree", "nosync", "nounwind", "speculatable", "willreturn", ["allockind", "4"], ["alloc-family", "malloc"]]}
}
