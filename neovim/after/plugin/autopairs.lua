local npairs_status_ok, npairs = pcall(require, "nvim-autopairs")
if not npairs_status_ok then
	return
end

npairs.setup({
	check_ts = true,
	ts_config = {
		lua = { "string" }, -- it will not add a pair on that treesitter node
		javascript = { "template_string" },
		java = false, -- don't check treesitter on java
	},
	disable_filetype = { "TelescopePrompt" },
	-- fast_wrap = {
	--   map = '<M-e>',
	--   chars = { '{', '[', '(', '"', "'" },
	--   pattern = [=[[%'%"%)%>%]%)%}%,]]=],
	--   end_key = '$',
	--   keys = 'qwertyuiopzxcvbnmasdfghjkl',
	--   check_comma = true,
	--   highlight = 'Search',
	--   highlight_grey='Comment'
	-- },
})
