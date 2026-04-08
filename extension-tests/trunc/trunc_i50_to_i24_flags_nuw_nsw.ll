
define i24 @main(i50 %0) {
  %2 = trunc nuw nsw i50 %0 to i24
  ret i24 %2
}
