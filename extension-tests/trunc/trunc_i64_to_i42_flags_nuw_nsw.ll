
define i42 @main(i64 %0) {
  %2 = trunc nuw nsw i64 %0 to i42
  ret i42 %2
}
