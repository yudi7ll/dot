local utils = require("utils")

local keymaps = require("keymaps")
local ui = require("ui")

local other_opts = {
	use_ime = true,
	-- macos_forward_to_ime_modifier_mask = 'SHIFT',
	check_for_updates_interval_seconds = 30 * 24 * 60 * 60,
}
return utils.merge({ other_opts, keymaps, ui })
