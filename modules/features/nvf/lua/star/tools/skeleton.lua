local M = {}

local function pascal_case_from_snake(name)
    local parts = vim.split(name, "[_-]", { trimempty = true })
    for i, p in ipairs(parts) do
        parts[i] = p:sub(1, 1):upper() .. p:sub(2)
    end
    return table.concat(parts, "")
end

function M.insert()
    local ext = vim.fn.expand("%:e")
    local name = vim.fn.expand("%:t")
    local stem = vim.fn.expand("%:t:r")
    local lines = {}

    if ext ~= "rs" then
        vim.notify("Skel: only Rust (.rs) files are supported", vim.log.levels.WARN)
        return
    end

    if name == "main.rs" then
        lines = {
            "fn main() {",
            '    println!("Hello, world!");',
            "}",
        }
    elseif name == "lib.rs" then
        lines = {
            "//! " .. pascal_case_from_snake(vim.fn.fnamemodify(vim.loop.cwd(), ":t")) .. " library.",
            "",
            "pub fn version() -> &'static str {",
            '    env!("CARGO_PKG_VERSION")',
            "}",
        }
    else
        local struct_name = pascal_case_from_snake(stem)
        lines = {
            "#[derive(Debug, Default)]",
            "pub struct " .. struct_name .. " {",
            "    // TODO: add fields",
            "}",
            "",
            "impl " .. struct_name .. " {",
            "    pub fn new() -> Self {",
            "        Self::default()",
            "    }",
            "}",
            "",
            "#[cfg(test)]",
            "mod tests {",
            "    use super::*;",
            "",
            "    #[test]",
            "    fn test_initialization() {",
            "        // let _ = " .. struct_name .. "::new();",
            "    }",
            "}",
        }
    end

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

return M

