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

local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  s(
    {
      trig = "pf",
    },
    fmta(
      [[
        printf("<>);
      ]],
      { 
        c(1, {
          sn(nil, {
            i(1),
            t("\", "),
            i(2),
          }),
          sn(nil, {
            i(1),
            t("\""),
          }),
        })
      }
    )
  ),
  s(
    {
      trig = "fn",
    },
    fmta(
      [[
        <> <>(<>) {
          <>
        }
      ]],
      { i(1, "return"), i(2, "name"), i(3, "arguments"), i(0) }
    )
  ),
}
