(lang dune 2.7)
(name emblem)

(generate_opam_files true)

(source (github unrealakama/emblem))
(license MIT)
(authors "Adam Ringwood")
(maintainers "adam@nexadmin.com")

(package
 (name emblem)
 (synopsis "A library for well typed, distributed, roughly ordered 128 bit ids")
 (description "Allows for well typed, distributed, roughly ordered 128 bit ids")
 (depends
  (dune (> 2.7))
  (zarith (> 1.9))
  (rresult (> 0.6))
  (fmt (> 0.8.7))))
