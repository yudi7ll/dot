local wezterm = require("wezterm")

local is_mac = wezterm.target_triple:find("darwin") ~= nil

local font_config = wezterm.font({
	family = "JetBrains Mono",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})

local platform_config = {}
if is_mac then
	platform_config = {
		font = font_config,
		font_size = 13,
		dpi = 144.0,
		macos_window_background_blur = 40,
	}
else
	platform_config = {
		font = font_config,
		font_size = 9.5,
	}
end

local format_title = function(title, is_active, max_width)
	local title_len = #title
	local pad_len = math.floor((max_width - title_len) / 2)

	local formatted_title = {
		Text = string.rep(" ", pad_len) .. title .. string.rep(" ", pad_len),
	}
	if is_active then
		return {
			{ Background = { Color = "#333333" } },
			{ Foreground = { Color = "#f2f2f2" } },
			formatted_title,
		}
	else
		return {
			{ Background = { Color = "#17191e" } },
			{ Foreground = { Color = "#444444" } },
			formatted_title,
		}
	end
end

local user_var_tab_title_key = "tab_title"
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	return format_title(tostring((tab.tab_index + 1)), tab.is_active, max_width)
end)

-- wezterm.on("update-right-status", function(window)
-- 	local date = wezterm.strftime("%Y-%m-%d %H:%M:%S")
-- 	window:set_right_status({ Foreground = { Color = "#cad3f5" } }, wezterm.format({ { Text = " " .. date .. " " } }))
-- end)

wezterm.on("user-var-changed", function(window, pane, name, value)
	wezterm.log_info("user-var-changed", name, value)
	if name == user_var_tab_title_key then
		pane:tab():set_title(value)
	end
end)

local config = {
	color_scheme = "3024 (dark) (terminal.sexy)",
	front_end = "WebGpu",
	tab_max_width = 6,
	colors = {
		tab_bar = {
			-- The color of the inactive tab bar edge/divider
			background = "#121419",
			new_tab = { bg_color = "#121419", fg_color = "#dcd7ba" },
		},
		foreground = "#dcd7ba",
		background = "#121419",

		cursor_bg = "#c8c093",
		-- cursor_fg = '#c8c093',
		cursor_border = "#c8c093",

		selection_fg = "#c8c093",
		selection_bg = "#2d4f67",

		scrollbar_thumb = "#16161d",
		split = "#444444",
	},
	window_background_image = os.getenv("HOME") .. "/.config/wezterm/bg/background.png",
	window_background_opacity = 0.95,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	initial_rows = 34,
	initial_cols = 134,
	enable_wayland = false,
}

-- Merge platform-specific settings
for k, v in pairs(platform_config) do
	config[k] = v
end

return config
