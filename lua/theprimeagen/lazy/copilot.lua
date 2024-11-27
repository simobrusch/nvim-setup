return {
    {
        "github/copilot.vim",
        config = function()
            -- Set proxy for Copilot
            vim.g.copilot_proxy = "http://aproxy.corproot.net:8080" -- Replace with your proxy URL

            -- Disable strict SSL verification (optional)
            vim.g.copilot_proxy_strict_ssl = false -- Set to `true` for strict SSL, `false` to disable verification
        end,
    },
}