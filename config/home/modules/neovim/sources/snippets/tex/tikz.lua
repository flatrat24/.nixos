local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

function line_begin_or_non_letter(line_to_cursor, matched_trigger)
  local line_begin = line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
  local non_letter = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match("[^%a]")
  return line_begin or non_letter
end

function non_letter(line_to_cursor, matched_trigger)
  local non_letter = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match("[^%a]")
  return non_letter
end

local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local date_input = function(args, snip, old_state, fmt)
  local fmt = fmt or "%Y-%m-%d"
  return sn(nil, i(1, os.date(fmt)))
end

local buffer_is_empty = function()
  -- Technically doens't verify that the buffer is empty, just that
  -- there is a single line in the buffer and that the snippet trigger
  -- is the first set of characters in the line
  local last_line = vim.fn.line('$')
  if last_line == 1 and line_begin then
    return true
  else
    return false
  end
end

return {
  s( -- dr -> TikZ Draw )
    {
      trig = "dr",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <> <>;
      ]],
      {
        c(1, {
          fmta(
            [[
              \draw[draw=<>, <>]
            ]],
            {
              i(1),
              i(2),
            }
          ),
          fmta(
            [[
              \fill[fill=<>, <>]
            ]],
            {
              i(1),
              i(2),
            }
          ),
          fmta(
            [[
              \filldraw[fill=<>, draw=<>, <>]
            ]],
            {
              i(1),
              i(2),
              i(3),
            }
          ),
        }),
        i(0),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- nd -> TikZ Node )
    {
      trig = "nd",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \draw[<>] (<>) node[rotate = <>, anchor = <>, <>] {<>};
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
        i(6),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- lg -> Logic Node )
    {
      trig = "lg",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \node[<> port] (<>) at (<>) {<>};
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- arc -> TikZ Arc )
    {
      trig = "arc",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \draw[domain=<>] plot ({<>+cos(\x)} {<>+sin(\x)});
      ]],
      {
        i(1),
        i(2),
        i(3),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- ap -> Add Plot )
    {
      trig = "ap",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \addplot [
          domain=<>:<>,
          samples=<>,
          color=<>,
        ] {<>};
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- for -> For Loop )
    {
      trig = "for",
    },
    fmta(
      [[
    \foreach \<> in {<>} {
      <>
    }
    ]],
      {
        i(1, "x"),
        i(2),
        i(0),
      }
    ),
    {
      -- condition = line_begin_or_non_letter
      condition = line_begin
    }
  ),
  s( -- sinwav -> Sine Wave TikZ )
    {
      trig = "sinwav",
    },
    fmta(
      [[
    % Sine Wave
    \def \amplitude{<>}
    \def \frequency{<>}
    \def \periods{<>}

    \pgfmathsetmacro{\n}{(\periods * 4) - 1}
    \foreach \i in {0,...,\n} {
    \ifthenelse{\isodd \i}{
    \pgfmathsetmacro{\xi}{((\i * pi) / 2) / \frequency}
    \pgfmathsetmacro{\xf}{(((\i + 1) * pi) / 2) / \frequency}
    \pgfmathsetmacro{\yi}{(sin((\frequency * \xi * 180 / (pi))) * \amplitude}
    \pgfmathsetmacro{\yf}{(sin((\frequency * \xf * 180 / (pi))) * \amplitude}
    \draw[<>] (\xi,\yi) cos (\xf,\yf) ;
    }{
    \pgfmathsetmacro{\xi}{((\i * pi) / 2) / \frequency}
    \pgfmathsetmacro{\xf}{(((\i + 1) * pi) / 2) / \frequency}
    \pgfmathsetmacro{\yi}{(sin((\frequency * \xi * 180 / (pi))) * \amplitude}
    \pgfmathsetmacro{\yf}{(sin((\frequency * \xf * 180 / (pi))) * \amplitude}
    \draw[<>] (\xi,\yi) sin (\xf,\yf) ;
    }
    }
    ]],
      {
        i(1, "1"),
        i(2, "1"),
        i(3, "1"),
        i(4),
        rep(4),
      }
    ),
    {}
  ),
  s( -- coswav -> Cosine Wave TikZ )
    {
      trig = "coswav",
    },
    fmta(
      [[
    % Cosine Wave
    \def \amplitude{<>}
    \def \frequency{<>}
    \def \periods{<>}

    \pgfmathsetmacro{\n}{(\periods * 4) - 1}
    \foreach \i in {0,...,\n} {
    \ifthenelse{\isodd \i}{
    \pgfmathsetmacro{\xi}{((\i * pi) / 2) / \frequency}
    \pgfmathsetmacro{\xf}{(((\i + 1) * pi) / 2) / \frequency}
    \pgfmathsetmacro{\yi}{(cos((\frequency * \xi * 180 / (pi))) * \amplitude}
    \pgfmathsetmacro{\yf}{(cos((\frequency * \xf * 180 / (pi))) * \amplitude}
    \draw[<>] (\xi,\yi) sin (\xf,\yf) ;
    }{
    \pgfmathsetmacro{\xi}{((\i * pi) / 2) / \frequency}
    \pgfmathsetmacro{\xf}{(((\i + 1) * pi) / 2) / \frequency}
    \pgfmathsetmacro{\yi}{(cos((\frequency * \xi * 180 / (pi))) * \amplitude}
    \pgfmathsetmacro{\yf}{(cos((\frequency * \xf * 180 / (pi))) * \amplitude}
    \draw[<>] (\xi,\yi) cos (\xf,\yf) ;
    }
    }
    ]],
      {
        i(1, "1"),
        i(2, "1"),
        i(3, "1"),
        i(4),
        rep(4),
      }
    ),
    {}
  ),
  s( -- 2mp -> 2D Moving Particle TikZ )
    {
      trig = "2mp",
    },
    fmta(
      [[
    % 2D Moving Particle
    \def \velocity {<>}
    \def \angle {<>}
    \def \xPosition {<>}
    \def \yPosition {<>}
    \def \maxRadius {<>}
    \def \n {<>}
    \foreach \i in {1,...,\n} {
    \pgfmathsetmacro \v {\velocity / 5}
    \pgfmathsetmacro \colorValue {(100 / \n) * \i}
    \pgfmathsetmacro \r {(\maxRadius * \i) / \n}
    \pgfmathsetmacro \x {\xPosition + (cos(\angle) * (\i * \v))}
    \pgfmathsetmacro \y {\yPosition + (sin(\angle) * (\i * \v))}
    \filldraw[red!\colorValue!white] (\x,\y) circle (\r cm);
    }
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
        i(6),
      }
    ),
    {}
  ),
  s( -- 3mp -> 3D Moving Particle TikZ )
    {
      trig = "3mp",
    },
    fmta(
      [[
    % 3D Moving Particle
    \def \velocity {<>}
    \def \polarAngle {<>}
    \def \azimuthalAngle {<>}
    \def \xPosition {<>}
    \def \yPosition {<>}
    \def \zPosition {<>}
    \def \maxRadius {<>}
    \def \n {<>}
    \foreach \i in {1,...,\n} {
    \pgfmathsetmacro \v {\velocity / 5}
    \pgfmathsetmacro \colorValue {(100 / \n) * \i}
    \pgfmathsetmacro \r {(\maxRadius * \i) / \n}
    \pgfmathsetmacro \x {\xPosition + (sin(\polarAngle) * cos(\azimuthalAngle) * (\i * \v))}
    \pgfmathsetmacro \y {\yPosition + (sin(\polarAngle) * sin(\azimuthalAngle) * (\i * \v))}
    \pgfmathsetmacro \z {\zPosition + (cos(\azimuthalAngle) * (\i * \v))}
    \filldraw[red!\colorValue!white] (\x,\y,\z) circle (\r cm);
    }
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
        i(6),
        i(7),
        i(8),
      }
    ),
    {}
  ),
  s( -- 3rp -> 3D Rectangular Prism TikZ )
    {
      trig = "3rp",
    },
    fmta(
      [[
    % 3D Rectangular Prism
    \def \x {<>}
    \def \y {<>}
    \def \z {<>}
    \def \xLen {<>}
    \def \yLen {<>}
    \def \zLen {<>}
    \def \gridStep {<>}

    \pgfmathsetmacro \xi {\x - \gridStep}
    \pgfmathsetmacro \xf {\xLen + \gridStep}
    \pgfmathsetmacro \zi {\z - \gridStep}
    \pgfmathsetmacro \zf {\zLen + \gridStep}
    \pgfmathsetmacro \negGridStep {\gridStep * -1}
    \foreach \a in {\xi,\x,...,\xf} {
      \foreach \b in {\zi,\z,...,\zf} {
        \draw[gridLine] (\a,\y,\zi) -- (\a,\y,\zf);
        \draw[gridLine] (\xi,\y,\b) -- (\xf,\y,\b);
      }
    }

    \pgfmathsetmacro \X {\x + \xLen}
    \pgfmathsetmacro \Y {\y + \yLen}
    \pgfmathsetmacro \Z {\z + \zLen}
    \draw[cubeBorder] (\x,\y,\z) -- (\x,\Y,\z) -- (\X,\Y,\z) -- (\X,\y,\z) -- cycle;
    \fill[cubeFilling] (\x,\y,\z) -- (\x,\Y,\z) -- (\X,\Y,\z) -- (\X,\y,\z) -- cycle;
    \draw[cubeBorder] (\x,\y,\z) -- (\x,\Y,\z) -- (\x,\Y,\Z) -- (\x,\y,\Z) -- cycle;
    \fill[cubeFilling] (\x,\y,\z) -- (\x,\Y,\z) -- (\x,\Y,\Z) -- (\x,\y,\Z) -- cycle;
    \draw[cubeBorder] (\x,\y,\z) -- (\x,\y,\Z) -- (\X,\y,\Z) -- (\X,\y,\z) -- cycle;
    \fill[cubeFilling] (\x,\y,\z) -- (\x,\y,\Z) -- (\X,\y,\Z) -- (\X,\y,\z) -- cycle;

    <>

    \draw[cubeBorder] (\X,\y,\z) -- (\X,\y,\Z) -- (\X,\Y,\Z) -- (\X,\Y,\z) -- cycle;
    \fill[cubeFilling] (\X,\y,\z) -- (\X,\y,\Z) -- (\X,\Y,\Z) -- (\X,\Y,\z) -- cycle;
    \draw[cubeBorder] (\x,\y,\Z) -- (\x,\Y,\Z) -- (\X,\Y,\Z) -- (\X,\y,\Z) -- cycle;
    \fill[cubeFilling] (\x,\y,\Z) -- (\x,\Y,\Z) -- (\X,\Y,\Z) -- (\X,\y,\Z) -- cycle;
    \draw[cubeBorder] (\x,\Y,\z) -- (\x,\Y,\Z) -- (\X,\Y,\Z) -- (\X,\Y,\z) -- cycle;
    \fill[cubeFilling] (\x,\Y,\z) -- (\x,\Y,\Z) -- (\X,\Y,\Z) -- (\X,\Y,\z) -- cycle;
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
        i(6),
        i(7),
        i(0),
      }
    ),
    {}
  ),
  s( -- r3p -> n Random 3D Particles )
    {
      trig = "r3p",
    },
    fmta(
      [[
    % n Random 3D Particles
    \def \n {<>}
    \def \xMin {<>}
    \def \yMin {<>}
    \def \zMin {<>}
    \def \xMax {<>}
    \def \yMax {<>}
    \def \zMax {<>}
    \def \radius {<>}
    \foreach \x in {1,...,\n} {
      \pgfmathsetmacro \x {(rnd * (\xMax - \xMin)) + \xMin}
      \pgfmathsetmacro \y {(rnd * (\yMax - \yMin)) + \yMin}
      \pgfmathsetmacro \z {(rnd * (\zMax - \zMin)) + \zMin}
      \filldraw[red!100!white] (\x,\y,\z) circle (\radius px);
    }
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
        i(6),
        i(7),
        i(0),
      }
    ),
    {}
  ),
  s( -- mcr -> pgfmathsetmacro )
    {
      trig = "mcr",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <><>
      ]],
      {
        c(1, {
          fmta(
            [[
              \pgfmathsetmacro{\<>}{<>}
            ]],
            {
              i(1),
              i(2),
            }
          ),
          fmta(
            [[
              \pgfmathsetmacro{\<>}{<>}
              \pgfmathprintnumberto{\<>}{\<>Pretty}
            ]],
            {
              i(1),
              i(2),
              rep(1),
              rep(1),
            }
          ),
        }),
        i(0),
      }
    ),
    {
      condition = line_begin
    }
  ),
}
