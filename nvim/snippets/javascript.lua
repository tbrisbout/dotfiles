-- Globals injected here:
--
-- snip_env = {
-- s = require("luasnip.nodes.snippet").S,
-- sn = require("luasnip.nodes.snippet").SN,
-- t = require("luasnip.nodes.textNode").T,
-- f = require("luasnip.nodes.functionNode").F,
-- i = require("luasnip.nodes.insertNode").I,
-- c = require("luasnip.nodes.choiceNode").C,
-- d = require("luasnip.nodes.dynamicNode").D,
-- r = require("luasnip.nodes.restoreNode").R,
-- l = require("luasnip.extras").lambda,
-- rep = require("luasnip.extras").rep,
-- p = require("luasnip.extras").partial,
-- m = require("luasnip.extras").match,
-- n = require("luasnip.extras").nonempty,
-- dl = require("luasnip.extras").dynamic_lambda,
-- fmt = require("luasnip.extras.fmt").fmt,
-- fmta = require("luasnip.extras.fmt").fmta,
-- conds = require("luasnip.extras.expand_conditions"),
-- types = require("luasnip.util.types"),
-- events = require("luasnip.util.events"),
-- parse = require("luasnip.util.parser").parse_snippet,
-- ai = require("luasnip.nodes.absolute_indexer"),
-- }


local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- snippets ideas
-- 
-- log: cycle through
--
-- console.log( ... )
-- console.log({ ... })
-- console.log("1", { 2 })
-- (console.log("1", {2}), 3)
--
-- probe:
-- console.log(<file name> - <line> - <function name>)

return {
  s("log", {
    t('console.log({ '),
    i(1),
    t(' });'),
  })
}
