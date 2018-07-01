local nixio = require "nixio"
local ksutil = require "luci.ksutil"

module("luci.controller.apps.regionwifi.index", package.seeall)

function index()
	entry({"apps", "regionwifi"}, call("action_index"))
end

function action_index()
    ksutil.shell_action("regionwifi")
end
