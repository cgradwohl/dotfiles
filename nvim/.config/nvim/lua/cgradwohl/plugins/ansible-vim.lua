return {
	{
		"pearofducks/ansible-vim",
		ft = { "yaml.ansible" },
		lazy = true,
		event = { "BufReadPost *.yml.j2", "BufReadPost *.yaml.j2" },
	},
}
