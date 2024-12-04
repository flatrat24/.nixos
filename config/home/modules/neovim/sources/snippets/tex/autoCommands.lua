local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  -- Greek Letters
  s({ trig = ";ga",  snippetType = "autosnippet"  }, { t("\\alpha")      }),
  s({ trig = ";gb",  snippetType = "autosnippet"  }, { t("\\beta")       }),
  s({ trig = ";gc",  snippetType = "autosnippet"  }, { t("\\chi")        }),
  s({ trig = ";gd",  snippetType = "autosnippet"  }, { t("\\delta")      }),
  s({ trig = ";gD",  snippetType = "autosnippet"  }, { t("\\Delta")      }),
  s({ trig = ";ge",  snippetType = "autosnippet"  }, { t("\\epsilon")    }),
  s({ trig = ";gf",  snippetType = "autosnippet"  }, { t("\\phi")        }),
  s({ trig = ";gF",  snippetType = "autosnippet"  }, { t("\\Phi")        }),
  s({ trig = ";gg",  snippetType = "autosnippet"  }, { t("\\gamma")      }),
  s({ trig = ";gG",  snippetType = "autosnippet"  }, { t("\\Gamma")      }),
  s({ trig = ";gh",  snippetType = "autosnippet"  }, { t("\\eta")        }),
  s({ trig = ";gi",  snippetType = "autosnippet"  }, { t("\\pi")         }),
  s({ trig = ";gI",  snippetType = "autosnippet"  }, { t("\\Pi")         }),
  s({ trig = ";gk",  snippetType = "autosnippet"  }, { t("\\kappa")      }),
  s({ trig = ";gl",  snippetType = "autosnippet"  }, { t("\\lambda")     }),
  s({ trig = ";gL",  snippetType = "autosnippet"  }, { t("\\Lambda")     }),
  s({ trig = ";gm",  snippetType = "autosnippet"  }, { t("\\mu")         }),
  s({ trig = ";gn",  snippetType = "autosnippet"  }, { t("\\nu")         }),
  s({ trig = ";go",  snippetType = "autosnippet"  }, { t("\\theta")      }),
  s({ trig = ";gO",  snippetType = "autosnippet"  }, { t("\\Theta")      }),
  s({ trig = ";gp",  snippetType = "autosnippet"  }, { t("\\pi")         }),
  s({ trig = ";gP",  snippetType = "autosnippet"  }, { t("\\Pi")         }),
  s({ trig = ";gr",  snippetType = "autosnippet"  }, { t("\\rho")        }),
  s({ trig = ";gs",  snippetType = "autosnippet"  }, { t("\\sigma")      }),
  s({ trig = ";gS",  snippetType = "autosnippet"  }, { t("\\Sigma")      }),
  s({ trig = ";gt",  snippetType = "autosnippet"  }, { t("\\tau")        }),
  s({ trig = ";gve", snippetType = "autosnippet"  }, { t("\\varepsilon") }),
  s({ trig = ";gvf", snippetType = "autosnippet"  }, { t("\\varphi")     }),
  s({ trig = ";gvo", snippetType = "autosnippet"  }, { t("\\vartheta")   }),
  s({ trig = ";gw",  snippetType = "autosnippet"  }, { t("\\omega")      }),
  s({ trig = ";gW",  snippetType = "autosnippet"  }, { t("\\Omega")      }),
  s({ trig = ";gx",  snippetType = "autosnippet"  }, { t("\\xi")         }),
  s({ trig = ";gX",  snippetType = "autosnippet"  }, { t("\\Xi")         }),
  s({ trig = ";gy",  snippetType = "autosnippet"  }, { t("\\psi")        }),
  s({ trig = ";gY",  snippetType = "autosnippet"  }, { t("\\Psi")        }),
  s({ trig = ";gz",  snippetType = "autosnippet"  }, { t("\\zeta")       }),


  -- General Math
  s({ trig = ";m*",  snippetType = "autosnippet"  }, { t("\\cdot")       }),
  s({ trig = ";m8",  snippetType = "autosnippet"  }, { t("\\times")      }),

  -- Set Theory
  s({ trig = ";so",  snippetType = "autosnippet"  }, { t("\\varnothing")              }),
  s({ trig = ";si",  snippetType = "autosnippet"  }, { t("\\in")                      }),
  s({ trig = ";sI",  snippetType = "autosnippet"  }, { t("\\notin")                   }),
  s({ trig = ";ss",  snippetType = "autosnippet"  }, { t("\\subset")                  }),
  s({ trig = ";sS",  snippetType = "autosnippet"  }, { t("\\subseteq")                }),
  s({ trig = ";sp",  snippetType = "autosnippet"  }, { t("\\superset")                }),
  s({ trig = ";sP",  snippetType = "autosnippet"  }, { t("\\superseteq")              }),
  s({ trig = ";su",  snippetType = "autosnippet"  }, { t("\\cup")                     }),
  s({ trig = ";sU",  snippetType = "autosnippet"  }, { t("\\cap")                     }),
  s({ trig = ";sd",  snippetType = "autosnippet"  }, { t("\\textbackslash")           }),
  s({ trig = ";s!",  snippetType = "autosnippet"  }, { t("^{\\textbf{\\complement}}") }),
  s({ trig = ";sn",  snippetType = "autosnippet"  }, { t("\\mathbb{N}")               }),
  s({ trig = ";sz",  snippetType = "autosnippet"  }, { t("\\mathbb{Z}")               }),
  s({ trig = ";sq",  snippetType = "autosnippet"  }, { t("\\mathbb{Q}")               }),
  s({ trig = ";sr",  snippetType = "autosnippet"  }, { t("\\mathbb{R}")               }),
  s({ trig = ";sc",  snippetType = "autosnippet"  }, { t("\\mathbb{C}")               }),

  -- Logic
  s({ trig = ";ln",  snippetType = "autosnippet"  }, { t("\\lnot")     }),
  s({ trig = ";la",  snippetType = "autosnippet"  }, { t("\\land")     }),
  s({ trig = ";lo",  snippetType = "autosnippet"  }, { t("\\lor")      }),
  s({ trig = ";lx",  snippetType = "autosnippet"  }, { t("\\oplus")    }),
  s({ trig = ";lf",  snippetType = "autosnippet"  }, { t("\\forall")   }),
  s({ trig = ";le",  snippetType = "autosnippet"  }, { t("\\exists")   }),
  s({ trig = ";lE",  snippetType = "autosnippet"  }, { t("\\exists !") }),
  s({ trig = ";lb",  snippetType = "autosnippet"  }, { t("\\bot")      }),
  s({ trig = ";lt",  snippetType = "autosnippet"  }, { t("\\top")      }),

  -- Other
  s({ trig = ";~",   snippetType = "autosnippet"  }, { t("\\sim")        }),
  s({ trig = ";$",   snippetType = "autosnippet"  }, { t("\\textdollar") }),
}
