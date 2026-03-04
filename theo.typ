#let __theo-counter__ = counter("theo-counter")
#let __theo-type__ = state("theo-type")

#let theo-init(body) = {
  // カウンタリセット
  show heading.where(level: 1): it => {
    __theo-counter__.step(level: 1)
    it
  }
  // block内のスタイル
  show block: set enum(indent: 2em)
  show block: set list(indent: 2em)
  show block: set terms(indent: 3em)

  body
}

#let theo-box(label, col) = {
  (name: none, ref: none, body) => block(
    stroke: (left: 2pt + col),
    inset: (left: 2em + 1em + 2pt, rest: .5em),
    outset: (left: -2em),
    width: 100%,
  )[
    #context {
      __theo-type__.update(label)
      __theo-counter__.step(level: 2)
    }
    #par(first-line-indent: (amount: -.5em, all: true))[
      #set text(font: "Arial", weight: "bold", col)
      #context {
        __theo-type__.get()
        __theo-counter__.display()
      }
      #if name != none [#h(1em)#name]
    ]
    #ref
    #body
  ]
}

#let definition = theo-box("定義", orange)
#let theorem = theo-box("定理", green)
#let proposition = theo-box("命題", teal)
#let lemma = theo-box("補題", purple)
#let corollary = theo-box("系", blue)
#let axiom = theo-box("公理", maroon)

#let proof(body) = block(
  stroke: (left: 2pt + gray),
  inset: (left: 2em + 1em + 2pt, rest: .5em),
  outset: (left: -2em),
  width: 100%,
)[
  #text(style: "italic")[Proof.]
  #h(1em)
  #body
  #h(1fr)
  $qed$
]

#let theo-ref(reference-label) = context [
  #__theo-type__.at(reference-label)
  #__theo-counter__.at(reference-label).map(str).join(".")
]
