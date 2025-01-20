return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			-- stylua: ignore start
			{ ",a", function() require("harpoon"):list():add() end, desc = "Add to harpoon" },
			{ "<c-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end },
			{ ",1", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
			{ ",2", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
			{ ",3", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
			{ ",4", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },
			-- stylua: ignore end
		},
	},
}