export const isbnNormalize = (isbn) => {
  return isbn.replace(/^(?:ISBN(?:-1[03])?:? )?|([^0-9X])/g, "") || ""
}

export const isbn10CheckDigit = (digits) => {
  if (digits.length != 9) return null

  let sum = 0
  let check_digit, i

  // Compute check digit for ISBN-10
  digits.reverse();
  for (i = 0; i < digits.length; i++) {
    sum += (i + 2) * parseInt(digits[i], 10);
  }
  check_digit = 11 - (sum % 11);
  if (check_digit == 10) {
    check_digit = "X";
  } else if (check_digit == 11) {
    check_digit = "0";
  }

  return check_digit;
}

export const isbn13CheckDigit = (digits) => {
  if (digits.length != 12) return null

  let sum = 0
  let check_digit, i

  for (i = 0; i < digits.length; i++) {
    sum += (((i % 2) * 2) + 1) * parseInt(digits[i], 10);
  }
  check_digit = 10 - (sum % 10);
  if (check_digit == 10) check_digit = "0";

  return check_digit;
}
