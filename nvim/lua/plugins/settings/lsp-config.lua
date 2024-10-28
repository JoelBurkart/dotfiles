return {
	basedpyright = {
		settings = {
			basedpyright = {
				-- Using Ruff's import organizer
				disableOrganizeImports = true,
			},
			python = {
				analysis = {
					-- Ignore all files for analysis to exclusively use Ruff for linting
					ignore = { "*" },
				},
			},
		},
	},

	ruff_ls = {
		init_options = {
			settings = {
			}
		}
	}
}
