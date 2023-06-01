# nvim_conf
my current nvim configuration. Very much a WIP


## how to use
launch nvim and wait for lazy to install the necesarry packages. 

To enable a language server you need to run `:Mason` and install all the necesarry packages (find them like `\rust` and press i on all the relevant packages).
Then install TreeSitter for the language with `:TSInstall <language>`. 
`:LspStart` should start the language server for errors and completions.

## ToDos: 
- [ ] make lsp auto start
- [ ] keybind auto-completion
