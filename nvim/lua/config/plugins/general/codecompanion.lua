local default_model = "deepseek/deepseek-r1:free"
local available_models = {
    "google/gemini-2.5-pro-exp-03-25",
    "google/gemini-2.5-pro-preview-03-25",
    "google/gemini-2.0-flash-exp:free",
    "google/gemini-2.0-flash-001",
    "deepseek/deepseek-r1:free",
    "deepseek/deepseek-chat-v3-0324:free",
}
local current_model = default_model

local function select_model()
    vim.ui.select(available_models, {
        prompt = "Select Openrouter Model:",
    }, function(choice)
            if choice then
                current_model = choice
                vim.notify("Selected Openrouter model: " .. current_model)
            end
        end)
end
local adpater_openrouter = function()
    return require("codecompanion.adapters").extend("openai_compatible", {
        env = {
            url = "https://openrouter.ai/api",
            api_key = "OPENROUTER_API_KEY",
            chat_url = "/v1/chat/completions",
        },
        schema = {
            model = {
                default = current_model,
            },
        },
    })
end

local opts = {
    adapters = {
        http = {
            copilot = function()
                return require("codecompanion.adapters").extend("copilot", {
                    schema = {
                        model = {
                            default = "chatgpt-4.5",
                        },
                    },
                })
            end,
            gemini = function()
                return require("codecompanion.adapters").extend("gemini", {
                    schema = {
                        model = {
                            -- default = "gemini-2.5-pro-exp-03-25",
                            default = "gemini-2.5-flash-preview-04-17",
                        },
                    },
                })
            end,
            openrouter = adpater_openrouter,
        }
    },
    strategies = {
        chat = {
            adapter = "gemini",
            roles = {
                user = "razorr",
            },
            keymaps = {
                send = {
                    modes = {
                        i = { "<C-CR>", "<C-s>" },
                    },
                },
                completion = {
                    modes = {
                        i = "<C-x>",
                    },
                },
                close = {
                    modes = {
                        i = "<C-q>",
                        n = "<C-q>"
                    },
                    index = 4,
                }
            },
            slash_commands = {
                ["buffer"] = {
                    keymaps = {
                        modes = {
                            i = "<C-b>",
                        },
                    },
                },
                ["help"] = {
                    opts = {
                        max_lines = 1000,
                    },
                },
            },
            tools = {
                opts = {
                    auto_submit_success = false,
                    auto_submit_errors = false,
                },
            },
        },
        inline = { adapter = "gemini" },
    },
    display = {
        action_palette = {
            provider = "default",
        },
        chat = {
            show_references = true,
            show_header_separator = true,
            -- show_settings = true,
            token_count = function(tokens, adapter)
                return " Tokens: " .. tokens .. " | Model: " .. adapter.formatted_name
            end,
        },
        -- diff = {
        --     provider = "mini_diff",
        -- },
    },
    extensions = {
        history = {
            enabled = true,
            opts = {
                keymap = "gh",
                save_chat_keymap = "sc",
                auto_save = true,
                expiration_days = 0,
                picker = "default",
                auto_generate_title = true,
                continue_last_chat = false,
                delete_on_clearing_chat = false,
                dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
                enable_logging = false,
            }
        },
        -- history = {
        --     enabled = true,
        --     opts = {
        --         keymap = "gh",
        --         auto_generate_title = true,
        --         continue_last_chat = false,
        --         delete_on_clearing_chat = false,
        --         picker = "snacks",
        --         enable_logging = false,
        --         dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        --     },
        -- },
        -- mcphub = {
        --     callback = "mcphub.extensions.codecompanion",
        --     opts = {
        --         make_vars = true,
        --         make_slash_commands = true,
        --         show_result_in_chat = true,
        --     },
        -- },
        -- vectorcode = {
        --     opts = {
        --         add_tool = true,
        --     },
        -- },
    },
    opts = {
        log_level = "DEBUG",
    },
}

require("codecompanion").setup(opts)

vim.keymap.set({ "n", "v" }, "<Leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
-- vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cco", select_model, { desc = "Select Openrouter Model" })
vim.keymap.set("n", "<leader>ccm", select_model, { desc = "Select Openrouter Model" })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
