
define i23 @main(i42 %0) {
  %2 = trunc nuw nsw i42 %0 to i23
  ret i23 %2
}
