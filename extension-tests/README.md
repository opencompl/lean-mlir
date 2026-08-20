We inspect closely the lowering of `llvm.sext`, `llvm.zext`, and `llvm.trunc` instructions with 
`llc -march=riscv64 -mcpu=generic-rv64 -mattr=+m,+b -filetype=asm -O0`, for every combination of extension from `i1` to `i64`. 
