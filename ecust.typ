#import "@preview/touying:0.6.3": *

#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let header(self) = {
    place(
      center + top,
      dy: .5em,
      rect(
        width: 100%,
        height: 1.8em,
        fill: self.colors.primary,
        align(
          left + horizon,
          h(1.5em) + text(fill: white, utils.call-or-display(self, self.store.header)),
        ),
      ),
    )
    place(left + top, line(
      start: (40%, 0%),
      end: (37%, 100%),
      stroke: .5em + white,
    ))
    place(right + top, dy: .8em, dx: -1em, image("assets/ecust.png", fit: "contain", height: 50%))
  }
  let footer(self) = {
    place(left, dx: 2em, text("勤奋求实 励志明徳", fill: gray, font: "KaiTi", size: 20pt))
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..bodies,
  )
})

#let title-slide(config: (:), extra: none, ..args) = touying-slide-wrapper(
  self => {
    self = utils.merge-dicts(
      self,
      config-common(freeze-slide-counter: true),
      config-page(
        background: image("assets/background.png", width: 100%, height: 96%),
        margin: (top: 0em, bottom: 0em),
      ),
      config,
    )
    let info = self.info + args.named()
    let body = {
      set align(center)
      stack(
        spacing: 3em,
        v(1em),
        image("assets/ecust.png"),
        if info.title != none {
          text(
            size: 40pt,
            weight: "bold",
            fill: self.colors.neutral-lightest,
            info.title,
          )
        },
        if info.author != none {
          text(
            fill: self.colors.neutral-lightest,
            size: 28pt,
            weight: "regular",
            info.author,
          )
        },
        if info.date != none {
          text(
            fill: self.colors.neutral-lightest,
            size: 20pt,
            weight: "regular",
            utils.display-info-date(self),
          )
        },
        if extra != none {
          text(
            fill: self.colors.neutral-lightest,
            size: 20pt,
            weight: "regular",
            extra,
          )
        },
      )
    }
    touying-slide(self: self, body)
  },
)

#let outline-slide(config: (:), leading: 50pt) = touying-slide-wrapper(self => {
  set text(size: 30pt, fill: self.colors.primary)
  set par(leading: leading)
  let body = {
    place(line(start: (45%, 0%), end: (45%, 100%), stroke: 2pt + self.colors.primary))
    grid(
      columns: (1fr, 1fr),
      rows: 1fr,
      align(
        center + horizon,
        {
          set par(leading: 20pt)
          context {
            if text.lang == "zh" {
              text(
                size: 80pt,
                weight: "bold",
                font: "KaiTi",
                [#text(size: 36pt)[CONTENTS]\ 目录],
              )
            } else {
              text(
                size: 48pt,
                weight: "bold",
                [CONTENTS],
              )
            }
          }
        },
      ),
      align(
        left + horizon,
        {
          set par(leading: leading)
          set text(weight: "bold")
          components.custom-progressive-outline(
            level: none,
            depth: 1,
            numbered: (true,),
            vspace: (.4em,),
          )
        },
      ),
    )
  }
  let header(self) = {
    place(
      left + top,
      dy: .5em,
      rect(
        width: 100%,
        height: 1.8em,
        fill: self.colors.primary,
        [],
      ),
    )
    place(left + top, line(
      start: (30%, 0%),
      end: (27%, 100%),
      stroke: .5em + white,
    ))
    place(left + top, dy: .8em, dx: 1em, image("assets/ecust.png", fit: "contain", height: 50%))
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      background: grid(
        columns: (1fr, 1fr),
        rows: 1fr,
        [], image("assets/ecust1.png", width: 80%),
      ),
      header: header,
    ),
  )
  touying-slide(self: self, config: config, body)
})

#let new-section-slide(config: (:), level: 1, body) = touying-slide-wrapper(
  self => {
    let slide-body = {
      stack(
        dir: ttb,
        spacing: 12%,
        align(
          center,
          text(
            fill: self.colors.primary,
            size: 166pt,
            utils.display-current-heading-number(level: level),
          ),
        ),
        place(center, line(length: 50%, stroke: 1.5pt + self.colors.primary)),
        align(
          center,
          text(
            fill: self.colors.primary,
            size: 60pt,
            weight: "bold",
            utils.display-current-heading(level: level, numbered: false),
          ),
        ),
      )
      body
    }
    let header(self) = {
      place(
        left + top,
        polygon(
          fill: self.colors.primary,
          (0cm, 0cm),
          (7cm, 0cm),
          (4cm, 5cm),
          (0cm, 5cm),
        ),
      )
    }
    let footer(self) = {
      place(
        right + bottom,
        polygon(
          fill: self.colors.primary,
          (3cm, 0cm),
          (7cm, 0cm),
          (7cm, 5cm),
          (0cm, 5cm),
        ),
      )
    }
    self = utils.merge-dicts(
      self,
      config-page(
        background: image("assets/ecust1.png"),
        header: header,
        footer: footer,
      ),
    )
    touying-slide(self: self, config: config, slide-body)
  },
)

#let end-slide(config: (:), body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      margin: 2em,
      background: image("assets/background.png", width: 100%, height: 100%),
    ),
  )
  set text(fill: self.colors.neutral-lightest, size: 2em, weight: "bold")
  touying-slide(self: self, config: config, align(horizon + center, body))
})

#let theme(
  aspect-ratio: "16-9",
  header: self => utils.display-current-heading(depth: self.slide-level),
  footer: context utils.slide-counter.display(),
  ..args,
  body,
) = {
  set text(size: 20pt)
  set heading(numbering: "1.1")
  show heading.where(level: 1): set heading(numbering: "01")

  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      margin: (x: 2em, top: 3.5em, bottom: 2em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        show heading: set text(fill: self.colors.primary-light)

        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: rgb("#003F88"),
      primary-light: rgb("#2159A5"),
      primary-lightest: rgb("#F2F4F8"),
      neutral-lightest: rgb("#FFFFFF"),
    ),
    // save the variables for later use
    config-store(
      align: align,
      header: header,
      footer: footer,
    ),
    ..args,
  )

  body
}
