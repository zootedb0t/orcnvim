vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "mason.nvim" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("mason.nvim")
			end
			vim.cmd("MasonUpdate")
		end
	end,
})

vim.pack.add({ "https://github.com/mason-org/mason.nvim" })

require("mason").setup({
	ui = {
		border = "single",
		width = 0.7,
		height = 0.7,
	},
})
