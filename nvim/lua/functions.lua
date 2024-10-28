local M = {}

function M.format_null(opt)
    local null_ls_sources = {}
    local mason_sources = {}

	local mr = require("mason-registry")

	local function package_exists(package_name)
        local package = mr.get_package(package_name)
        return package ~= nil
    end
    -- Iterate over the opt table to collect formatted null_ls sources
    for name, methods in pairs(opt) do

			if type(methods) == "table" then
				for _, method in ipairs(methods) do
					-- Safely access null-ls builtins, ensuring it exists
					local builtin = require("null-ls").builtins[method[1]]
					if builtin and builtin[name] then
						table.insert(null_ls_sources, builtin[name])
						table.insert(mason_sources, name) -- Add name for MasonInstall
					else
						vim.notify("Error: Invalid builtin or method for " .. name)
					end
				end
			else
            local builtin = require("null-ls").builtins[methods]
            if builtin and builtin[name] then
                table.insert(null_ls_sources, builtin[name])
                table.insert(mason_sources, name) -- Add name for MasonInstall
            else
                vim.notify("Error: Invalid builtin or method for " .. name)
            end
        end
    end

    -- Install all sources using Mason after collecting them
	for _, mason_name in ipairs(mason_sources) do
		if package_exists(mason_name) then
			local package = mr.get_package(mason_name)
			if not package:is_installed() then
				vim.cmd(":MasonInstall " .. mason_name)
			end
		end
    end

    return null_ls_sources
end

function M.list_lsps(opt)
	local lsp_list = {}

	for _, config_name in pairs(opt) do
		table.insert(lsp_list, config_name)
	end
	return lsp_list
end


return M
