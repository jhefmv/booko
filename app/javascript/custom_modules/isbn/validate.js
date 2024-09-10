import { isbnNormalize, isbn10CheckDigit, isbn13CheckDigit } from "custom_modules/isbn/main"

export const isbnValid = (isbn) => {
  const regex = /^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$/

  if (regex.test(isbn)) {
    const digits = isbnNormalize(isbn).split("")
    const last_digit = digits.pop()
    let check_digit

    if (digits.length == 9) {
      check_digit = isbn10CheckDigit(digits)
    } else {
      check_digit = isbn13CheckDigit(digits)
    }

    return check_digit == last_digit
  } else {
    return false
  }
}
