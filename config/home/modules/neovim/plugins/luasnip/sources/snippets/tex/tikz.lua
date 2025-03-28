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
        \<>[<>] <>;
      ]],
      {
        c(1, {
          t("draw"),
          t("fill"),
          t("filldraw"),
        }),
        c(2, {
          t(""),
          t("wire"),
          t("body"),
          t("force"),
          t("dimension"),
          t("support"),
          t("line"),
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
