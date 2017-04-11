--
-- IPShield
--
-- 2017 xiejiangzhi
--

local M ={}
M.__index = M

local Helper = require 'resty.web_shield.helper'

-- config table:
--  whitelist: {'127.0.0.1', '10.10.1.1/16'},
--  blacklist: {'123.123.123.1/24'}
--
function M.new(config)
  return setmetatable({
    whitelist = config.whitelist,
    blacklist = config.blacklist
  }, M)
end

function M:filter(ip, uid, method, path)
  for index, value in ipairs(self.blacklist) do
    if value == ip then return Helper.BLOCK end
  end

  for index, value in ipairs(self.whitelist) do
    if value == ip then return Helper.BREAK end
  end

  return Helper.PASS
end

return M

