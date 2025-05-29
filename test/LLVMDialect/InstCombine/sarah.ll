define i64 @test(i64 %x) {
entry:
  %k1 = add i64 %x, %x
  %k2 = xor i64 %k1, %k1
  ret i64 %k2
}

 define i64 @main(i64 %x)  {
  %2 = call i64 @test(i64 %x)
  ret i64 %2
}