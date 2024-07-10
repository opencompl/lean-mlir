#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "bool", sizeInBits = 8, encoding = DW_ATE_boolean>
#di_basic_type1 = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "char", sizeInBits = 8, encoding = DW_ATE_signed_char>
#di_file = #llvm.di_file<"test.cpp" in "/home/user">
#di_null_type = #llvm.di_null_type
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C_plus_plus, file = #di_file, producer = "clang version 3.8.0 (trunk 248826) (llvm/trunk 248827)", isOptimized = true, emissionKind = Full>
#di_composite_type = #llvm.di_composite_type<tag = DW_TAG_array_type, baseType = #di_basic_type1, sizeInBits = 8, alignInBits = 8, elements = #llvm.di_subrange<count = 1 : i64>>
#di_subroutine_type = #llvm.di_subroutine_type<types = #di_null_type, #di_basic_type>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "bar", linkageName = "bar", file = #di_file, line = 2, scopeLine = 2, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#di_lexical_block = #llvm.di_lexical_block<scope = #di_subprogram, file = #di_file, line = 3, column = 3>
#di_lexical_block1 = #llvm.di_lexical_block<scope = #di_lexical_block, file = #di_file, line = 3, column = 3>
#di_lexical_block2 = #llvm.di_lexical_block<scope = #di_lexical_block1, file = #di_file, line = 3, column = 30>
#di_local_variable = #llvm.di_local_variable<scope = #di_lexical_block2, name = "text", file = #di_file, line = 4, type = #di_composite_type>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(!llvm.ptr {llvm.nocapture}, !llvm.ptr {llvm.nocapture})
  llvm.func @bar(%arg0: i1) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<1 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.intr.dbg.declare #di_local_variable = %1 : !llvm.ptr
    %2 = llvm.alloca %0 x !llvm.array<1 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.start 1, %2 : !llvm.ptr
    llvm.intr.lifetime.end 1, %2 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.start 1, %2 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.intr.lifetime.end 1, %2 : !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.start 1, %2 : !llvm.ptr
    llvm.call @foo(%2, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.intr.lifetime.end 1, %2 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.return
  }
}
