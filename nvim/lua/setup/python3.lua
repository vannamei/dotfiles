local python3_dir = os.getenv("HOME") .. "/.python_env/nvim"
vim.g.python3_host_prog = python3_dir .. "/bin/python"
vim.env.PATH = python3_dir .. "/bin:" .. os.getenv("PATH")
