
define i20 @main(i42 %0) {
  %2 = trunc nuw nsw i42 %0 to i20
  ret i20 %2
}
