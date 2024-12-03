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
  s( -- mm -> Inline Math )
    {
      trig = "mm",
    },
    fmta(
      [[
        <>$<>$<>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
        i(0),
      }
    ),
    {}
  ),
  s( -- ff -> Fraction )
    {
      trig = "ff",
    },
    fmta(
      [[
        <>\frac{<>}{<>}<>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
        i(2),
        i(0),
      }
    ),
    {}
  ),
  s( -- fF -> Fraction (Denominator) )
    {
      trig = "fF",
    },
    fmta(
      [[
        <>\frac{<>}{<>}<>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(2),
        d(1, get_visual),
        i(0),
      }
    ),
    {}
  ),
  s( -- sq -> Square Root )
    {
      trig = "sq",
    },
    fmta(
      [[
        <>\sqrt{<>}<>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
        i(0),
      }
    ),
    {}
  ),
  s( -- ii -> Integral )
    {
      trig = "ii",
    },
    fmta(
      [[
        <>\<>_{<>}^{<>} <> \,<>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        c(1, {
          t("int"),
          t("oint"),
        }),
        i(2),
        i(3),
        d(4, get_visual),
        i(5),
      }
    ),
    {}
  ),
  s( -- ss -> Sigma Sum )
    {
      trig = "ss",
    },
    fmta(
      [[
        <>\<>_{<>}^{<>} <>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        c(1, {
          t("sum"),
          t("prod"),
        }),
        i(2),
        i(3),
        d(4, get_visual),
      }
    ),
    {}
  ),
  s( -- ll -> Limit )
    {
      trig = "ll",
    },
    fmta(
      [[
        <>\lim_{<> \to <>} <>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        i(2),
        d(3, get_visual),
      }
    ),
    {}
  ),
  s( -- o^ -> Hat )
    {
      trig = "o^",
    },
    fmta(
      [[
        \hat{<>}<>
      ]],
      {
        d(1, get_visual),
        i(0),
      }
    ),
    {}
  ),
  s( -- o- -> Overline )
    {
      trig = "o-",
    },
    fmta(
      [[
        \overline{<>}<>
      ]],
      {
        d(1, get_visual),
        i(0),
      }
    ),
    {}
  ),
  s( -- o-r -> Over Right Arrow )
    {
      trig = "o-r",
    },
    fmta(
      [[
        \overrightarrow{<>}<>
      ]],
      {
        d(1, get_visual),
        i(0),
      }
    ),
    {}
  ),
  s( -- o-l -> Over Left Arrow )
    {
      trig = "o-l",
    },
    fmta(
      [[
        \overleftarrow{<>}<>
      ]],
      {
        d(1, get_visual),
        i(0),
      }
    ),
    {}
  ),
  s( -- ^ -> Superscript )
    {
      trig = "^",
    },
    fmta(
      [[
        ^{<>}
      ]],
      {
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- _ -> Subscript )
    {
      trig = "_",
    },
    fmta(
      [[
        _{<>}
      ]],
      {
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- inf -> Infinity )
    {
      trig = "inf",
    },
    fmta(
      [[
        \infty
      ]],
      {}
    ),
    {}
  ),
}
