import { isbnValid } from "custom_modules/isbn/validate"
import { isbnNormalize, isbn10CheckDigit, isbn13CheckDigit } from "custom_modules/isbn/main"
import { isbnRanges } from "custom_modules/isbn/isbn_ranges"

export const isbnConvert = (isbn) => {
  function toIsbn10(normalized) {
    if (/^979/.test(normalized)) return null

    let isbn10 = normalized.replace(/^978/, "").slice(0, -1), hypenated
    isbn10 += isbn10CheckDigit(isbn10.split("")).toString()
    hypenated = hypenate(isbn10, 10)

    return hypenated
  }

  function toIsbn13(normalized) {
    let isbn13 = `978${normalized}`.slice(0, -1), hypenated
    isbn13 += isbn13CheckDigit(isbn13.split("")).toString()
    hypenated = hypenate(isbn13, 13)

    return hypenated
  }

  function hypenate(isbn, base) {
    const ranges = isbnRanges()
    const tisbn = (base == 10) ? `978${isbn}` : isbn
    let group = null, prefix = null, hypenated = "", parts = [], f_prefix

    Object.keys(ranges).every((g) => {
      if ((new RegExp(`^${g}`)).test(tisbn)) {
        const prefixes = ranges[g]
        const pre_loc = g.length
        group = g

        prefixes.every((p, ix) => {
          const p_length = p[0].toString().length
          const number = tisbn.slice(pre_loc, pre_loc + p_length)

          if ((number >= parseInt(p[0])) && (number <= parseInt(p[1]))) {
            prefix = p
            prefix[2] = p_length
            prefix[3] = number
          }

          // exit every
          if (prefix) return false
          else return true
        })
      }

      // exit every
      if (group && prefix) return false
      else return true
    })

    if (!(group && prefix)) return isbn

    f_prefix = prefix[3].padStart(prefix[2], "0");
    parts = [
      group.slice(0, 3),
      group.slice(3),
      f_prefix,
      tisbn.slice(group.length + f_prefix.length, -1),
      tisbn.slice(-1)
    ]
    hypenated = parts.join("-")

    if (base == 10) hypenated = hypenated.replace(/^978-/, "")

    return hypenated
  }

  if (!isbnValid(isbn)) return;

  const normalized = isbnNormalize(isbn)

  switch (normalized.length) {
    case 10:
      return toIsbn13(normalized)
    case 13:
      return toIsbn10(normalized)
    default:
      return null
  }
}
