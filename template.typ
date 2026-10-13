#import "@preview/numbly:0.1.0": numbly
#import "@preview/pointless-size:0.1.2": zh

// 三线表
#let table_stroke(stroke) = (x, y) => (
  top: if y < 2 { stroke } else { 0pt },
  bottom: stroke,
)

#let abstract = abstract => {
  par(first-line-indent: 0em)[
    #text(font: "Noto Sans SC")[*摘要：*]
    #text(size: zh(4.5))[
      #abstract
    ]]
}

#let keywords = (..keywords) => {
  par(first-line-indent: 0em)[
    #text(font: "Noto Sans SC")[*关键词：*]
    #text(size: zh(4.5))[
      #keywords.pos().join("，")
    ]]
}

#let main_page = (body, front-matter: []) => {
  // 设置页面样式
  set page(
    paper: "a4",
    margin: (
      top: 2.8cm,
      bottom: 2.5cm,
      left: 2.5cm,
      right: 2.5cm,
    ),
  )

  // 设置字体
  set text(
    lang: "zh",
    font: (
      (name: "Noto Serif SC", covers: "latin-in-cjk"),
      "Noto Serif SC",
    ),
    zh(4.5),
  )
  show math.equation: set text(font: (
    "New Computer Modern Math",
    "Noto Serif SC",
  ))
  show raw: set text(font: "Noto Sans Mono")

  // 前言
  front-matter

  set par(justify: true, leading: 0.95em, spacing: 0.95em, first-line-indent: (amount: 2em, all: true))

  // 设置 heading 的样式
  set heading(numbering: numbly(
    "{1:一、}",
    "{1:1}.{2:1}",
  ))
  show heading.where(level: 1): it => {
    // 重置计数器
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)

    set align(center)
    set text(weight: "regular", font: "Noto Sans SC", size: zh(2.5))
    set block(spacing: 1.14em, below: 1.14em)
    // pagebreak(weak: true)
    block(it)
  }
  show heading.where(level: 2): it => {
    set text(weight: "regular", font: "Noto Sans SC", size: zh(4))
    set block(above: 1.14em, below: 1.14em)
    block(it)
  }
  show heading.where(level: 3): it => {
    set text(weight: "regular", font: "Noto Sans SC", size: zh(4.5))
    set block(above: 1.14em, below: 1.14em)
    block(it)
  }

  // 设置编号
  set figure(numbering: num => numbering("1-1", counter(heading).get().first(), num))
  show figure.where(kind: table): set figure(numbering: num => numbering("1.1", counter(heading).get().first(), num))
  set math.equation(numbering: nums => numbering("(1-1)", counter(heading).get().first(), nums))

  // 设置 table 的样式
  show figure.where(kind: table): set figure.caption(position: top)
  set table(
    stroke: table_stroke(1pt),
    align: horizon,
  )
  show figure.caption: set text(weight: "bold")

  // 设置公式
  set math.vec(delim: "[")
  set math.mat(delim: "[")

  set enum(numbering: "(1)")

  show footnote.entry: set text(size: zh(5.5))

  body
}
